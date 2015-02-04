
@salubrity.filter 'filterByAssoc', ->
  # function to invoke by Angular each time
  # Angular passes in the `items` which is our Array
  ($items, $assoc, $id) ->
    return if $items is undefined
    # Create a new Array
    filtered = []
    # loop through existing Array
    i = 0
    while i < $items.length
      item = $items[i]
      children = item[$assoc]
      # loop through associations
      j = 0
      while j < children.length
        child = children[j]
        # check if the individual Array element contains associated id
        if child.id == $id
          # push it into the Array if it does!
          filtered.push item
        j++
      i++
    # boom, return the Array after iteration's complete
    filtered