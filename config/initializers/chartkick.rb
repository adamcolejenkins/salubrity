Chartkick.options = {
  colors: ["#677486", "#28B598", "#F54D4B", "#19b698", "#FED16C", "#47b8e5", "#d4a74c"],
  library: {
    axisTitlesPosition: "out",
    backgroundColor: "transparent",
    lineWidth: 2,
    fontName: "Open Sans",
    animation: {
      duration: 1000,
      easing: "inAndOut"
    },
    chartArea: {
      # left: 10,
      top: 10,
      height: "90%",
      width: "90%"
    },
    vAxis: {
      gridlines: {
          color: "#EFEFEF"
      },
      textPosition: "out",
      baselineColor: "transparent",
      textStyle: {
        color: "#909baa",
        fontSize: 10
      },
      titleTextStyle: {
        color: "#677487",
        fontSize: 10,
        italic: false
      }
    },
    hAxis: {
      # gridlines: {
      #     color: "#e5e6ea"
      # },
      textPosition: "out",
      baselineColor: "transparent",
      textStyle: {
        color: "#909baa",
        fontSize: 10
      }
    },
    pieHole: 0.37,
    legend: {
      position: "bottom",
      alignment: "start",
      top: 10,
      textStyle: {
        color: "#909baa",
        fontSize: 12
      }
    },
    tooltip: {
      showColorCode: true,
      textStyle: {
        color: "#677487",
        fontSize: 12
      }
    }
  }
}

Chartkick.options[:html] = "<div id=\"%{id}\" style=\"height: %{height};\"><img src=\"/assets/loader.light.svg\" class=\"loader\"></div>"