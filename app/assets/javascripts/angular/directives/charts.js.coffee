@salubrity
  
  .directive 'pieChart', ($timeout) ->
      return (
        restrict: "C",
        link: ($scope, elem, attrs) ->

          chart = null

          # Retrieve the data
          data = $scope[attrs.ngModel]

          console.log data

          if data is undefined
            data = [
              label: "No results"
              data: 100
            ]

          # Set the pie chart options
          options =
            series:
              pie:
                show: true
                innerRadius: 0.27
                shadow:
                  top: 5
                  left: 15
                  alpha: 0.3

                stroke:
                  width: 0

                label:
                  show: true
                  formatter: (label, series) ->
                    "<div style=\"font-size:12px;text-align:center;padding:2px;color:#333;\">" + label + "</div>"

                highlight:
                  opacity: 0.08

            grid:
              hoverable: true
              clickable: true

            colors: [
              "#5793f3"
              "#dd4d79"
              "#bd3b47"
              "#dd4444"
              "#fd9c35"
              "#fec42c"
              "#d4df5a"
              "#5578c2"
            ]
            legend:
              show: true

          # If the data changes somehow, update it in the chart
          $scope.$watch attrs.ngModel, (v) ->
            console.log v
            unless chart
              chart = $.plot(elem, v, options)
              elem.show()
            else
              chart.setData v
              chart.setupGrid()
              chart.draw()
      )