@salubrity #app
  
  .directive 'vectorMap', ($timeout) ->
    return (
      restrict: "A"
      link: (scope, elem, attrs) ->
        $timeout ->
          latitude = 38.937630
          longitude = -92.327083

          elem.vectorMap
            map: 'us_merc_en'
            backgroundColor: '#383A41'
            regionStyle:
              initial:
                fill: '#707482'
              hover:
                "fill-opacity": 0.8
            markerStyle:
              initial:
                r: 8
              hover:
                r: 12
                stroke: 'rgba(29,210,175,0.3)'
                "stroke-width": 6
            markers: [
              latLng: [latitude, longitude]
              name: attrs.name
              style:
                fill: '#1DD2AF'
                stroke:'rgba(29,210,175,0.3)'
                "stroke-width": 3
            ]

    )