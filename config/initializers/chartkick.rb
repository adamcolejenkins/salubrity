Chartkick.options = {
  colors: ["#dfe2e7"],
  library: {
    axisTitlesPosition: "none",
    chartArea: {
      left: 0,
      top: 0,
      height: "100%",
      width: "100%"
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
    }
  }
}

Chartkick.options[:html] = "<div id=\"%{id}\" style=\"height: %{height};\"><img src=\"/assets/loader.light.svg\" class=\"loader\"></div>"