# Hyphenate text
@salubrity.filter 'hyphenate', ->
  (text) ->
    String(text).toLowerCase().replace(/^\s+|\s+$/g, '').replace(RegExp(' ', 'g'), '-').replace(/[-]+/g, '-').replace /[^\w-]+/g, ''


# Convert snake_case_text to sentence format
@salubrity.filter 'stripSnake', ->
  (text) ->
    String(text).replace /_/g, ' '


# IDK
@salubrity.filter 'interpolate', [
  'version'
  (version) ->
    (text) ->
      String(text).replace /\%VERSION\%/mg, version
]