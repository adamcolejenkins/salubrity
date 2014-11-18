Chartkick.options = {
  colors: ["#dfe2e7"],
  library: {
    axisTitlesPosition: "none",
    backgroundColor: "transparent",
    chartArea: {
      # left: 0,
      top: 10,
      height: "90%",
      width: "90%"
    },
    vAxis: {
      gridlines: {
          color: 'transparent'
      },
      textPosition: "none",
      baselineColor: "#e5e6ea"
    },
    hAxis: {
      gridlines: {
          color: 'transparent'
      },
      textPosition: "none",
      baselineColor: "#e5e6ea"
    },
    pieHole: 0.37,
    legend: "none"
  }
}

Chartkick.options[:html] = "<div id=\"%{id}\" style=\"height: %{height};\"><img src=\"/assets/loader.light.svg\" class=\"loader\"></div>"