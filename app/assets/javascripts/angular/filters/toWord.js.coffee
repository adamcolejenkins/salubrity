# This filter allows retrieves the fieldtypes that
# is searched for.
@salubrity.filter 'toWord', ->

  (value) ->
    th = [
      ""
      "thousandth"
      "millionth"
      "billionth"
      "trillionth"
    ]
    dg = [
      "zero"
      "first"
      "second"
      "third"
      "fourth"
      "fifth"
      "sixth"
      "seventh"
      "eighth"
      "ninth"
    ]
    tn = [
      "tenth"
      "eleventh"
      "twelfth"
      "thirteenth"
      "fourteenth"
      "fifteenth"
      "sixteenth"
      "seventeenth"
      "eighteenth"
      "nineteenth"
    ]
    tw = [
      "twentieth"
      "thirtieth"
      "fortieth"
      "fiftieth"
      "sixtieth"
      "seventieth"
      "eightieth"
      "ninetieth"
    ]
    toWords = (s) ->
      s = s.toString()
      s = s.replace(/[\, ]/g, "")
      console.log s
      console.log parseFloat(s)
      return "not a number"  unless s is parseFloat(s).toString()
      x = s.indexOf(".")
      x = s.length  if x is -1
      return "too big"  if x > 15
      n = s.split("")
      str = ""
      sk = 0
      i = 0

      while i < x
        if (x - i) % 3 is 2
          if n[i] is "1"
            str += tn[Number(n[i + 1])] + " "
            i++
            sk = 1
          else unless n[i] is 0
            str += tw[n[i] - 2] + " "
            sk = 1
        else unless n[i] is 0
          str += dg[n[i]] + " "
          str += "hundred "  if (x - i) % 3 is 0
          sk = 1
        if (x - i) % 3 is 1
          str += th[(x - i - 1) / 3] + " "  if sk
          sk = 0
        i++
      unless x is s.length
        y = s.length
        str += "point "
        i = x + 1

        while i < y
          str += dg[n[i]] + " "
          i++
      str.replace /\s+/g, " "

    toWords(value)
