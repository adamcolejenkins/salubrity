@salubrity
  
  .directive 'pieChart', ($timeout) ->
      return (
        restrict: "C",
        require: "ngModel"
        link: ($scope, elem, attrs, ctrl) ->

          $timeout (->
            chart = null

            # Retrieve the data
            data = $scope[attrs.ngModel]
            console.log ctrl

            # Set the pie chart options
            options =
              series:
                pie:
                  show: true
                  innerRadius: 0.3
                  radius: .7

                  stroke:
                    width: 2

                  label:
                    show: true
                    formatter: (label, series) ->
                      "<div style=\"font-size:12px;font-weight:bold;padding:0px;color:#677487;\">" + label + "</div>"

                  combine:
                    threshold: 0.1

                  highlight:
                    opacity: 0.08

              grid:
                hoverable: true
                clickable: true

              colors: [
                "#D8655D"
                "#F1AD78"
                "#B0C382"
                "#5A8B75"
                "#fd9c35"
                "#fec42c"
                "#d4df5a"
                "#5578c2"
              ]
              legend:
                show: false

            # If the data changes somehow, update it in the chart
            $scope.$watch attrs.data, (data) ->
              console.log data
              return if data is undefined

              console.log data

              unless chart
                chart = $.plot(elem, data, options)
                elem.show()
              else
                chart.setData data
                chart.setupGrid()
                chart.draw()

          ), 1000

      )