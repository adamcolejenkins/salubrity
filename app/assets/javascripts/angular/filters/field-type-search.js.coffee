@salubrity #app

  # This filter allows retrieves the fieldtypes that
  # is searched for.
  .filter 'fieldTypeSearch', ['CONFIG', (CONFIG) ->

    (attribute, value) ->
      types = CONFIG.fieldTypes
      obj   = []
      i     = 0

      while i < types.length
        obj.push types[i] if types[i][attribute] is value
        i++

      return obj[0] if obj.length is 1
      obj

  ]