<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">

<head>
  <meta charset="utf-8" />

  <title>Chart</title>
  	<script src="${pageContext.request.contextPath}/static/plugins/amcharts4/core.js"></script>
	<script src="${pageContext.request.contextPath}/static/plugins/amcharts4/charts.js"></script>
	
	 <style>
	  .grid-container {
    display: grid;
    grid-template-columns: 1fr 1fr;
    grid-template-rows: auto auto;
    gap: 20px;
    padding: 20px;
    height: 100vh;
    box-sizing: border-box;
  }

  .chart-box {
    height: 280px;
    padding: 10px;
    border: 1px solid #ccc;
    border-radius: 8px;
    box-shadow: 0 1px 5px rgba(0, 0, 0, 0.1);
    background-color: #fff;
    box-sizing: border-box;
  }
    #chartdiv {
      width: 100%;
      height: 500px;
    }
    #chartdiv2 {
      width: 100%;
      height: 500px;
    }
  </style>
  
</head>

<body>
	AmChart example
	  <div class="grid-container">
		<div id="chartdiv" class="chart-box"></div>
	    <div id="chartdiv2" class="chart-box"></div>
	    <div id="chartdiv3" class="chart-box"></div>
	    <div id="chartdiv4" class="chart-box"></div>
    </div>	
</body>

 <script>
    // 차트 생성
    var chart = am4core.create("chartdiv", am4charts.XYChart);

    // 데이터 세팅
    chart.data = [
      { category: "A", value: 25 },
      { category: "B", value: 50 },
      { category: "C", value: 75 },
      { category: "D", value: 60 },
      { category: "E", value: 90 }
    ];

    // X축 (카테고리)
    var categoryAxis = chart.xAxes.push(new am4charts.CategoryAxis());
    categoryAxis.dataFields.category = "category";
    categoryAxis.renderer.grid.template.location = 0;

    // Y축 (값)
    var valueAxis = chart.yAxes.push(new am4charts.ValueAxis());

    // 시리즈 (막대)
    var series = chart.series.push(new am4charts.ColumnSeries());
    series.dataFields.categoryX = "category";
    series.dataFields.valueY = "value";
    series.columns.template.tooltipText = "{categoryX}: [bold]{valueY}[/]";

    // 막대 스타일 (선택 사항)
    var columnTemplate = series.columns.template;
    columnTemplate.fillOpacity = 0.6;
    columnTemplate.strokeWidth = 1;
    columnTemplate.strokeOpacity = 0.8;
  </script>
  
   <script>
    // 차트 객체 생성
    var chart2 = am4core.create("chartdiv2", am4charts.PieChart);

    // 도넛 스타일을 위해 내부 반지름 설정
    chart2.innerRadius = am4core.percent(50);

    // 데이터
    chart2.data = [
      { channel: "인터넷 뉴스", value: 45 },
      { channel: "모바일 앱", value: 30 },
      { channel: "TV 뉴스", value: 15 },
      { channel: "종이 신문", value: 5 },
      { channel: "기타", value: 5 }
    ];

    // 시리즈 추가
    var pieSeries = chart2.series.push(new am4charts.PieSeries());
    pieSeries.dataFields.value = "value";
    pieSeries.dataFields.category = "channel";

    // 라벨 안보이게 하고 외부에만 보이게
    pieSeries.labels.template.disabled = true;
    pieSeries.ticks.template.disabled = true;

    // 툴팁 내용 설정
    pieSeries.slices.template.tooltipText = "{category}: {value}건 ({value.percent.formatNumber('#.0')}%)";

    // 색상 커스터마이징
    pieSeries.colors.list = [
      am4core.color("#0088cc"),
      am4core.color("#00cc99"),
      am4core.color("#ffaa00"),
      am4core.color("#cc4444"),
      am4core.color("#999999")
    ];

    // 도넛 중앙 텍스트 삽입
    let label = chart2.seriesContainer.createChild(am4core.Label);
    label.text = "총 뉴스 소비";
    label.horizontalCenter = "middle";
    label.verticalCenter = "middle";
    label.fontSize = 16;
    label.fontWeight = "600";

    // 범례 추가
    chart2.legend = new am4charts.Legend();
    chart2.legend.position = "right";
    chart2.legend.valign = "middle";
    chart2.legend.labels.template.truncate = false;
    chart2.legend.labels.template.wrap = true;
    
    function createLineChart(divId) {
        var chart = am4core.create(divId, am4charts.XYChart);

        chart.data = [
          { month: "1월", value: 50 },
          { month: "2월", value: 65 },
          { month: "3월", value: 80 },
          { month: "4월", value: 70 },
          { month: "5월", value: 90 },
          { month: "6월", value: 100 }
        ];

        var categoryAxis = chart.xAxes.push(new am4charts.CategoryAxis());
        categoryAxis.dataFields.category = "month";

        var valueAxis = chart.yAxes.push(new am4charts.ValueAxis());

        var series = chart.series.push(new am4charts.LineSeries());
        series.dataFields.valueY = "value";
        series.dataFields.categoryX = "month";
        series.tooltipText = "{categoryX}: [b]{valueY}[/]";
        series.strokeWidth = 2;

        // 동그란 점 마커 추가
        series.bullets.push(new am4charts.CircleBullet());

        chart.cursor = new am4charts.XYCursor();
      }

      // 방사형 차트 (chartdiv4)
      function createRadarChart(divId) {
        var chart = am4core.create(divId, am4charts.RadarChart);

        chart.data = [
          { category: "기획", value: 80 },
          { category: "디자인", value: 65 },
          { category: "개발", value: 90 },
          { category: "QA", value: 70 },
          { category: "운영", value: 60 }
        ];

        var categoryAxis = chart.xAxes.push(new am4charts.CategoryAxis());
        categoryAxis.dataFields.category = "category";

        var valueAxis = chart.yAxes.push(new am4charts.ValueAxis());
        valueAxis.renderer.axisFills.template.fill = am4core.color("#f3f3f3");
        valueAxis.renderer.axisFills.template.fillOpacity = 0.05;

        var series = chart.series.push(new am4charts.RadarSeries());
        series.dataFields.valueY = "value";
        series.dataFields.categoryX = "category";
        series.name = "역량 점수";
        series.strokeWidth = 2;
        series.fillOpacity = 0.3;
        series.tooltipText = "{categoryX}: [bold]{valueY}[/]점";

        chart.cursor = new am4charts.RadarCursor();
      }

      // 새 차트들
      createLineChart("chartdiv3");
      createRadarChart("chartdiv4");
    
  </script>
  
  
</html> 
