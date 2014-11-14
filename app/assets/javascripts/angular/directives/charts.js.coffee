@salubrity
  
  .directive 'chart', ($timeout) ->
    return (
      restrict: "E"
      template: '<canvas></canvas>'
      replace: true
      scope: 
        chartObject: "=data"

      link: ($scope, elem, attrs) ->

        console.log "=========================="
        # console.log $scope, elem, attrs

        $timeout (->

          console.log attrs

          options = 
            canvas:
              # String - Type of chart to display
              type:   attrs.type    || "Line"
              # Number - width of chart
              width:  attrs.width   || elem.parent().innerWidth()
              # Number - height of chart
              height: attrs.height  || elem.parent().innerHeight()

            chart:

              pie:
                # Boolean - Whether we should show a stroke on each segment
                segmentShowStroke : true
                # String - The colour of each segment stroke
                segmentStrokeColor : "#fff"
                # Number - The width of each segment stroke
                segmentStrokeWidth : 2
                # Number - The percentage of the chart that we cut out of the middle
                percentageInnerCutout : 35 #  This is 0 for Pie charts
                # Number - Amount of animatio steps
                animationSteps : 100
                # Boolean - Whether we animate the rotation of the Doughnut
                animateRotate : true
                # Boolean - Whether we animate scaling the Doughnut from the centre
                animateScale : true
                labelFontFamily : "Arial"
                labelFontStyle : "normal"
                labelFontSize : 24
                labelFontColor : "#666"

              bar:
                # Boolean - Whether the scale should start at zero, or an order of magnitude down from the lowest value
                scaleBeginAtZero : true
                # Boolean - Whether grid lines are shown across the chart
                scaleShowGridLines : false
                # String - Colour of the grid lines
                scaleGridLineColor : "rgba(0,0,0,.05)"
                # Number - Width of the grid lines
                scaleGridLineWidth : 1
                # Boolean - If there is a stroke on each bar
                barShowStroke : false
                # Number - Pixel width of the bar stroke
                barStrokeWidth : 2
                # Number - Spacing between each of the X value sets
                barValueSpacing : 2
                # Number - Spacing between data sets within X values
                barDatasetSpacing : 1
                # String - A legend template
                legendTemplate : "<ul class=\"<%=name.toLowerCase()%>-legend\"><% for (var i=0; i<datasets.length; i++){%><li><span style=\"background-color:<%=datasets[i].lineColor%>\"></span><%if(datasets[i].label){%><%=datasets[i].label%><%}%></li><%}%></ul>"

          
          chartOptions = angular.extend(
            # Boolean - Whether to animate the chart
            animation: true
            # Number - Number of animation steps
            animationSteps: 60
            # String - Animation easing effect
            animationEasing: "easeOutQuart"
            # Boolean - If we should show the scale at all
            showScale: false
            # Boolean - If we want to override with a hard coded scale
            scaleOverride: false
            # ** Required if scaleOverride is true **
            # Number - The number of steps in a hard coded scale
            scaleSteps: null            # Number - The value jump in the hard coded scale
            scaleStepWidth: null            # Number - The scale starting value
            scaleStartValue: null
            # String - Colour of the scale line
            scaleLineColor: "rgba(0,0,0,.1)"
            # Number - Pixel width of the scale line
            scaleLineWidth: 1
            # Boolean - Whether to show labels on the scale
            scaleShowLabels: false
            # Interpolated JS string - can access value
            scaleLabel: "<%=value%>"
            # Boolean - Whether the scale should stick to integers, not floats even if drawing space is there
            scaleIntegersOnly: true
            # Boolean - Whether the scale should start at zero, or an order of magnitude down from the lowest value
            scaleBeginAtZero: true
            # String - Scale label font declaration for the scale label
            scaleFontFamily: "'Helvetica Neue', 'Helvetica', 'Arial', sans-serif"
            # Number - Scale label font size in pixels
            scaleFontSize: 12
            # String - Scale label font weight style
            scaleFontStyle: "normal"
            # String - Scale label font colour
            scaleFontColor: "#666"
            # Boolean - whether or not the chart should be responsive and resize when the browser does.
            responsive: true
            # Boolean - whether to maintain the starting aspect ratio or not when responsive, if set to false, will take up entire container
            maintainAspectRatio: true
            # Boolean - Determines whether to draw tooltips on the canvas or not
            showTooltips: true
            # Array - Array of string names to attach tooltip events
            tooltipEvents: ["mousemove", "touchstart", "touchmove"]
            # String - Tooltip background colour
            tooltipFillColor: "rgba(59,66,80, 0.8)"
            # String - Tooltip label font declaration for the scale label
            tooltipFontFamily: "'Helvetica Neue', 'Helvetica', 'Arial', sans-serif"
            # Number - Tooltip label font size in pixels
            tooltipFontSize: 12
            # String - Tooltip font weight style
            tooltipFontStyle: "normal"
            # String - Tooltip label font colour
            tooltipFontColor: "#fff"
            # String - Tooltip title font declaration for the scale label
            tooltipTitleFontFamily: "'Helvetica Neue', 'Helvetica', 'Arial', sans-serif"
            # Number - Tooltip title font size in pixels
            tooltipTitleFontSize: 12
            # String - Tooltip title font weight style
            tooltipTitleFontStyle: "bold"
            # String - Tooltip title font colour
            tooltipTitleFontColor: "#fff"
            # Number - pixel width of padding around tooltip text
            tooltipYPadding: 6
            # Number - pixel width of padding around tooltip text
            tooltipXPadding: 6
            # Number - Size of the caret on the tooltip
            tooltipCaretSize: 8
            # Number - Pixel radius of the tooltip border
            tooltipCornerRadius: 2
            # Number - Pixel offset from point x to tooltip edge
            tooltipXOffset: 10
            # String - Template string for single tooltips
            tooltipTemplate: "<%if (label){%><%=label%>: <%}%><%= value %> responses"
            # String - Template string for single tooltips
            multiTooltipTemplate: "<%= value %> responses"

          , options.chart[options.canvas.type.toLowerCase()], $scope.chartObject.options)
          
          # We want to add labels to the chart instead of tooltips
          # so we need to extend the chart
          # Chart.types.Doughnut.extend(
          #   name: "PieAlt"
          #   draw: ->
          #     Chart.types.Doughnut.prototype.draw.apply(this, arguments)
          #     console.log this

          # )

          # Get our canvas element
          canvas = elem.get(0)
          # Get our context
          context = canvas.getContext('2d')
          # Set the canvas height
          canvas.width = options.canvas.width
          # Set the canvas width
          canvas.height = options.canvas.height
          # Instantiate our chart
          chart = new Chart(context)

          # Update when chart data changes
          $scope.$watch (-> $scope.chartObject), (value) ->

            # Return if we have no data
            return unless value?

            # Set our chart type
            chartType = options.canvas.type

            # Build the chart
            chart[chartType]($scope.chartObject, chartOptions)
            

        ), 1000
    )