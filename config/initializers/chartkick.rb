Chartkick.options = {
  colors: ['#55A9DC', '#886DB3', '#6CC080', '#E6645C', '#6FC3F6', '#A287CD', '#86DA9A', '#FF7E76', '#88DCFF', '#BBA0E6', '#9FF3B3', '#FF978F' ],
  library: {
    backgroundColor: "transparent",
    chart: {
      style: {
        fontFamily: "Open Sans",
        fontWeight: "normal"
      }
    },
    xAxis: {
      lineColor: "#f2f2f2",
      gridLineColor: "#f2f2f2"
    },
    yAxis: {
      gridLineColor: "#f2f2f2"
    },
    credit: false,
    animation: {
      duration: 1000,
      easing: "inAndOut"
    },
    plotOptions: {
      line: {
        marker: {
          enabled: true,
          lineWidth: 8,
          radius: 5,
          fillColor: nil,
          lineColor: 'rgba(0, 0, 0, 0.15)',
          symbol: 'circle',
          states: {
            hover: {
              lineWidth: 0,
              radius: 10
            }
          }
        }
      },
      bar: {
        # pointWidth: 10
      },
      column: {
        # pointWidth: 10
      },
      pie: {
        dataLabels: {
          enabled: true,
          style: {
            color: '#737373'
          },
          format: "{point.name} <b>{point.percentage:.1f}%</b>"
        },
        allowPointSelect: true,
        cursor: 'pointer',
        showInLegend: false,
        size: '75%',
        innerSize: '75%'
      }
    },
    tooltip: {
      headerFormat: '<b>{point.key}<b/><br />'
    },
    legend: {
      useHTML: true,
      title: {
        style: {
          fontWeight: 300
        }
      }
    }
  }
}

Chartkick.options[:html] = "<div id=\"%{id}\" style=\"height: %{height};\"><img src=\"/assets/loader.light.svg\" class=\"loader\"></div>"