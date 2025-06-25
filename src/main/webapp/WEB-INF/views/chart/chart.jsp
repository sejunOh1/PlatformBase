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
    #chartdiv {
      width: 100%;
      height: 500px;
    }
  </style>
  
</head>

<body>
	AmChart example
	<div id="chartdiv"></div>
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
</html> 
