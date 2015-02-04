# This filter allows retrieves the fieldContexts that
# is searched for.
@salubrity.filter 'fieldContextSearch', ['CONFIG', (CONFIG) ->

  (attribute, value) ->
    contexts = CONFIG.fieldContexts
    obj   = []
    i     = 0
    # loop through contexts
    while i < contexts.length
      obj.push contexts[i] if contexts[i][attribute] is value
      i++

    return obj[0] if obj.length is 1
    obj

]