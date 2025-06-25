<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">

<head>
  <meta charset="utf-8" />
	  <script type="text/javascript" src="${pageContext.request.contextPath}/static/js/tui/tui-pagination.js"></script>
	  <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/tui/tui-pagination.css" />
	  <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/tui/tui-grid.css" />
	  <script src="${pageContext.request.contextPath}/static/js/tui/tui-grid.js"></script>

  <title>Toast UI Grid</title>
  
  <style>  /* 스타일 커스텀 적용 */
    .name-column {
      background-color: #e6f7ff;
      color: #1207e6;           
      font-weight: bold;
    }
  </style>
  
</head>

<body>
	<a href="https://nhn.github.io/tui.grid/latest/tutorial-example01-basic" target="_blank">Toast UI Grid</a> 
	</br>
	테이블 헤더 고정 / 필드별 정렬 기능 / 클라이언트 페이징 / 자동 rownum / 테이블 x,y축 스크롤 활성화 / 스타일 커스텀 적용
	</br>
	<div id="grid"></div>


<script>

document.addEventListener('DOMContentLoaded', function () {

	/* 더미데이터 생성 */
	 const gridData = Array.from({ length: 50 }).map((_, i) => ({
	      id: (10001 + i).toString(),
	      name: 'User ' + (i + 1),
	      age: (20 + (i % 10)).toString(),
	      country: 'South Korea',
	      city: 'City ' + ((i % 5) + 1),
	      job: 'Engineer',
	      hobby: 'Running'
	    }));

	/* grid 생성 및 세부 설정 */
const grid = new tui.Grid({
    el: document.getElementById('grid'),
    data: gridData,
    bodyHeight: 600, /* 테이블 크기 고정시 자동 헤더고정 */
    scrollX: true, /* 테이블의 X축과 Y축 스크롤 활성화 */
    scrollY: true,
    rowHeaders: ['rowNum'], /* 테이블 좌측에 rownum 생성 */
    header: {  /* 계층형태 필드 표현 */ 
        height: 80,
        complexColumns: [
          {
            header: '인적사항',
            name: 'mergeColumn1',
            childNames: ['id', 'name','age']
          },
          {
            header: '위치정보',
            name: 'mergeColumn2',
            childNames: ['country', 'city']
          },
          {
              header: '기타',
              name: 'mergeColumn3',
              childNames: ['job', 'hobby']
            }
        ]
      },
    columns: [ /* 컬럼 정의 */
      {
        header: 'Id',
        name: 'id',
        sortingType: 'desc', /* 정렬 순서 설정 */ 
        sortable: true /* 정렬기능 활성화 */
      },
      {
          header: 'Name',
          name: 'name',
          sortingType: 'desc',
          sortable: true,
          className: 'name-column' /* 컬럼 스타일 커스터마이징 */
        },
        {
            header: 'Age',
            name: 'age',
            sortingType: 'desc',
            sortable: true
          }, 
      {
        header: 'Country',
        name: 'country',
        sortingType: 'desc',
        sortable: true
      },
      {
        header: 'City',
        name: 'city',
        sortingType: 'desc',
        sortable: true
      },
      {
          header: 'Job',
          name: 'job',
          sortingType: 'desc',
          sortable: true
        },
        {
            header: 'Hobby',
            name: 'hobby',
            sortingType: 'desc',
            sortable: true
          }
    ],
    pageOptions: { /* 페이지네이션 활성화  */
        useClient: true, /* 클라이언트단 페이지네이션 명시, 서버 페이지네이션은 데이터소스 사용 */
        perPage: 20
      }
   
  });
});

</script>

</body>
</html> 
