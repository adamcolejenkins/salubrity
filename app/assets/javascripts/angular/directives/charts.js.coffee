@salubrity
  
  .directive 'pieChart', ($timeout) ->
      return (
        restrict: "AC",
        # require: "ngModel"
        link: ($scope, elem, attrs) ->

          console.log $scope
          console.log attrs

          $timeout (->
            chart = null

            # Retrieve the data
            data = attrs.data

            # No Data
            drawBlank = ->
              canvas = chart.getCanvas()
              ctx = canvas.getContext("2d")
              x = canvas.width / 2
              y = canvas.height / 2
              ctx.beginPath()
              ctx.arc(x, y, 100, 0, Math.PI*2, false)
              ctx.arc(x, y, 35, 0, Math.PI*2, true)
              ctx.fillStyle = '#f0f3f4'
              ctx.closePath()
              ctx.fill()
              elem.siblings('.response-time').html('<big>No</big><small>Responses</small>')

            # Set the pie chart options
            options =
              series:
                pie:
                  show: true
                  innerRadius: .35
                  radius: 1

                  stroke:
                    width: 2

                  label:
                    show: true
                    radius: 2/3
                    formatter: (label, series) ->
                      "<div class=\"pie-label\">"+label+'<br/>'+Math.round(series.percent)+"%</div>"
                    threshold: 0.1

                  combine:
                    threshold: 0.1

                  highlight:
                    opacity: 0.08

              grid:
                hoverable: true
                clickable: true
                autoHighlight: true 

              tooltip: true
              tooltipOpts:
                id: "chart-tooltip"
                content: "%s | %p.0%" # show percentages, rounding to 2 decimal places
                shifts:
                  x: 20
                  y: 0
                defaultTheme: false
                lines:
                  track: true
                  threshold: 0.1

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
            $scope.$watch data, (data) ->

              unless chart
                chart = $.plot(elem, data.answers, options)
                console.log chart.getData()[0].percent
                drawBlank() if isNaN(chart.getData()[0].percent)
                elem.show()
                elem.siblings('.response-time').show()
              else
                chart.setData(data)
                chart.setupGrid()
                chart.draw()

          ), 1000

      )

  # .directive 'barGraph'