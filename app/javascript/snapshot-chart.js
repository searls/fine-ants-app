import amcharts from 'amcharts3'
import 'amcharts3/amcharts/serial'
import 'amcharts3/amcharts/plugins/dataloader/dataloader'
import 'amcharts3/amcharts/themes/light'

document.addEventListener('turbo:load', () => {
  if (!document.getElementById('snapshot-chart')) return

  const chart = AmCharts.makeChart("snapshot-chart", {
    "pathToImages": "/assets/amcharts/images/",
    "type": "serial",
    "theme": "light",
    "marginRight": 40,
    "marginLeft": 40,
    "autoMarginOffset": 20,
    "mouseWheelZoomEnabled":true,
    "dataDateFormat": "YYYY-MM-DD",
    "valueAxes": [{
      "id": "v1",
      "unit": "$",
      "unitPosition": "left",
      "axisAlpha": 0,
    }],
    "graphs": [{
      "id": "g1",
      "bullet": "round",
      "bulletBorderAlpha": 1,
      "bulletColor": "#FFFFFF",
      "bulletSize": 5,
      "hideBulletsCount": 50,
      "lineThickness": 2,
      "useLineColorForBulletBorder": true,
      "valueField": "value",
      "balloonText": "$[[value]]"
    }, {
      "id": "g2",
      "bullet": "round",
      "bulletBorderAlpha": 1,
      "bulletColor": "#FFFFFF",
      "bulletSize": 5,
      "hideBulletsCount": 50,
      "lineThickness": 2,
      "useLineColorForBulletBorder": true,
      "valueField": "wage",
      "balloonText": "$[[wage]]"
    }],
    "chartScrollbar": {
      "graph": "g1",
      "oppositeAxis": false,
      "offset": 30,
      "scrollbarHeight": 80,
      "backgroundAlpha": 0,
      "selectedBackgroundAlpha": 0.1,
      "selectedBackgroundColor": "#888888",
      "graphFillAlpha": 0,
      "graphLineAlpha": 0.5,
      "selectedGraphFillAlpha": 0,
      "selectedGraphLineAlpha": 1,
      "autoGridCount":true,
      "color":"#AAAAAA"
    },
    "chartCursor": {
      "pan": true,
      "valueLineEnabled": true,
      "valueLineBalloonEnabled": true,
      "cursorAlpha":1,
      "cursorColor":"#258cbb",
      "limitToGraph":"g1",
      "valueLineAlpha":0.2,
      "valueZoomable":true
    },
    "valueScrollbar":{
      "offset": 20,
      "scrollbarHeight":10
    },
    "categoryField": "date",
    "categoryAxis": {
      "parseDates": true,
      "dashLength": 1,
      "minorGridEnabled": true
    },
    "dataLoader": {
      "url": "/dashboard/snapshot-chart-data"
    }
  })
})
