Chartkick.options = {
  colors: ["#dfe2e7"],
  library: {
    axisTitlesPosition: "none",
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
      textPosition: "none"
    },
    hAxis: {
      gridlines: {
          color: 'transparent'
      },
      textPosition: "none"
    },
    pieHole: 0.37,
    legend: "none"
  }
}

Chartkick.options[:html] = "<div id=\"%{id}\" style=\"height: %{height};\"><img src=\"/assets/loader.light.svg\" class=\"loader\"></div>"