module ChartHelper

  COLORS = %w( #55A9DC #886DB3 #6CC080 #E6645C #6FC3F6 #A287CD #86DA9A #FF7E76 #88DCFF #BBA0E6 #9FF3B3 #FF978F)

  def donut_chart_options(options={})
    {
      height: options[:height] || nil,
      colors: options[:colors] || nil,
      chart: {
            type: 'bar'
        },
      library: {
        title: {
          text: options[:title] || '',
          verticalAlign: 'top',
          useHTML: false,
          style: {
            width: '100%',
            textAlign: 'left',
            fontSize: "14px",
            color: '#737373'
          },
          align: 'left',
          y: 15
          # x: 110
        },
        plotOptions: {
          pie: {
            showInLegend: false,
            center: ['50%', '60%'],
            size: '60%',
            innerSize: '30%'
          }
        },
        legend: {
          align: 'right',
          verticalAlign: 'middle',
          layout: 'vertical',
          # x: -75
        }
      }
    }
  end

  def bar_chart_options(options={})
    {
      height: options[:height] || nil,
      colors: options[:colors] || nil,
      chart: {
        type: 'bar'
      },
      library: {
        title: {
          text: options[:title] || '',
          # verticalAlign: 'top',
          # useHTML: false,
          style: {
            width: '100%',
            textAlign: 'left',
            color: '#737373'
          },
          align: 'left'
        },
        plotOptions: {
          bar: {
            dataLabels: {
              enabled: true,
              align: 'left',
              format: "<b>{x} {y}</b>",
              x: 0,
              y: 0
            },
            pointPadding: -0.2
          }
        },
        tooltip: {
          enabled: false
        },
        xAxis: {
          labels: {
            enabled: false
          },
          tickWidth: 0
        },
        yAxis: {
          labels: {
            enabled: false
          },
          gridLineWidth: 0,
          lineWidth: 0
        }
      }
    }
  end

  def guage_chart_options(options={})
    {
      height: options[:height] || nil,
      # colors: options[:colors] || nil,
      library: {
        chart: {
          type: 'solidgauge'
        },
        pane: {
          center: ['50%', '85%'],
          size: '140%',
          startAngle: -90,
          endAngle: 90,
          background: {
            backgroundColor: '#EEE',
            innerRadius: '60%',
            outerRadius: '100%',
            shape: 'arc'
          }
        },
        tooltip: {
          enabled: false
        },
        title: {
          text: options[:title] || '',
          verticalAlign: 'top',
          useHTML: false,
          style: {
            width: '90%',
            # height: '170px',
            textAlign: 'left',
            fontSize: "14px",
            color: '#737373'
          },
          align: 'left',
          y: 15
          # x: 110
        },
        plotOptions: {
          pie: {
            dataLabels: {
              enabled: false
            },
            # showInLegend: false,
            # center: ['50%', '85%'],
            # size: '100%',
            # startAngle: -90,
            # endAngle: 90,
            # background: {
            #   backgroundColor: '#EEE',
            #   innerRadius: '60%',
            #   outerRadius: '100%',
            #   shape: 'arc'
            # }
          }
        },
        yAxis: {
          min: options[:min] || 0,
          max: options[:max] || 10,
          stops: [
              [0.1, '#DF5353'],
              [0.5, '#DDDF0D'],
              [0.9, '#55BF3B']
          ],
          lineWidth: 0,
          minorTickInterval: nil,
          tickPixelInterval: 400,
          tickWidth: 0,
          title: {
            y: -70
          },
          labels: {
            y: 16
          }
        }
      }
    }
  end

  def column_chart_options(options={})
    {
      height: options[:height] || nil,
      # colors: options[:colors],
      library: {
        title: {
          text: options[:title] || '',
          useHTML: true,
          style: {
            color: '#737373',
            fontWeight: 'normal'
          }
        },
        yAxis: {
          labels: {
            enabled: true
          },
          title: {
            # text: 'Responses'
          }
          # min: 1
        },
        legend: {
          layout: 'vertical',
          backgroundColor: 'rgba(255, 255, 255, 0.7)',
          align: 'right',
          verticalAlign: 'top',
          y: 44,
          x: 0,
          borderWidth: 1,
          borderRadius: 2,
          borderColor: '#e7ebee',

          floating: true,
          draggable: true,
          zIndex: 20
        },

      }
    }

  end
end
