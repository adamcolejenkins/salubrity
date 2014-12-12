Chartkick.options = {
  colors: ["#dfe2e7", "#677486", "#28B598", "#F54D4B", "#19b698", "#FED16C", "#47b8e5", "#d4a74c"],
  library: {
    # axisTitlesPosition: "none",
    backgroundColor: "transparent",
    chartArea: {
      # left: 10,
      top: 10,
      height: "90%",
      width: "90%"
    },
    vAxis: {
      gridlines: {
          color: "#e5e6ea"
      },
      # textPosition: "none",
      baselineColor: "#e5e6ea"
    },
    hAxis: {
      # gridlines: {
      #     color: "#e5e6ea"
      # },
      # textPosition: "none",
      baselineColor: "#e5e6ea"
    },
    pieHole: 0.37,
    legend: {
      position: "bottom",
      alignment: "start",
      textStyle: {
        fontSize: 10
      }
    }
  }
}

Chartkick.options[:html] = "<div id=\"%{id}\" style=\"height: %{height};\"><img src=\"/assets/loader.light.svg\" class=\"loader\"></div>"