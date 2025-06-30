<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <title>AG Grid Demo</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/ag-grid-community/styles/ag-grid.css">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/ag-grid-community/styles/ag-theme-alpine.css">
  <style>
    html, body {
      height: 100%;
      margin: 0;
      font-family: 'Arial';
    }
    /* AG Grid 기본 컨테이너 */
.ag-theme-alpine {
  height: 600px;
  width: 100%;
  border: 1px solid #ccc; /* 외곽선 추가 */
  font-family: 'Segoe UI', sans-serif;
  font-size: 14px;
}

/* 셀 테두리 강조 */
.ag-cell, .ag-header-cell {
  border-right: 1px solid #ddd !important;
  border-bottom: 1px solid #ddd !important;
}

/* 마지막 셀 오른쪽 테두리 없애기 방지 */
.ag-row .ag-cell:last-child,
.ag-header-row .ag-header-cell:last-child {
  border-right: 1px solid #ddd !important;
}

/* 헤더 스타일 */
.ag-header-cell-label {
  font-weight: bold;
  color: #333;
}

/* 마우스 hover 시 강조 */
.ag-row-hover .ag-cell {
  background-color: #f4f8ff !important;
}

/* 선택된 행 강조 */
.ag-row-selected {
  background-color: #d0e6ff !important;
}

/* 버튼 스타일 */
.custom-button {
  margin: 10px;
  padding: 8px 16px;
  background-color: #3a78c9;
  color: white;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  font-weight: bold;
}

.custom-button:hover {
  background-color: #2c5fa4;
}

  </style>
</head>
<body>
<button onclick="onBtHide()">Hide Cols</button>
<button onclick="onBtShow()">Show Cols</button>
<button class="custom-button" onclick="showGridState()">현재 상태 보기</button>

	<div id="columnToggles" style="margin: 10px 0;"></div>
  <button class="custom-button" onclick="onExport()">CSV 다운로드</button>
  <div id="myGrid" class="ag-theme-alpine"></div>
  
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <!-- <script src="https://cdn.jsdelivr.net/npm/ag-grid-community/dist/ag-grid-community.min.noStyle.js"></script> -->
  <script src="https://cdn.jsdelivr.net/npm/ag-grid-community/dist/ag-grid-community.min.js"></script>
  
  <script>
    const columnDefs = [
      { field: "id", headerName: "ID", sortable: true, resizable: true , cellStyle: {
          backgroundColor: "#fff8dc"  // light yellow (cornsilk)
      }},
      { field: "name", headerName: "이름", sortable: true, resizable: true },
      { field: "age", headerName: "나이", sortable: true, resizable: true },
      { field: "email", headerName: "이메일", sortable: true, resizable: true }
    ];

    // 전역 gridOptions
    let gridApi = null;
    let gridColumnApi = null;
    
   const gridOptions = {
  columnDefs: columnDefs,
  rowData: [],
  defaultColDef: {
    flex: 1,
    minWidth: 120,
    sortable: true,
    resizable: true
  },
  pagination: true,
  paginationPageSize: 10,
  animateRows: true,
  rowHeight: 30,
  headerHeight: 50,
  getRowId: params => params.data.id,
  onGridReady: function(params){
	  gridApi = params.api;
	  createColumnToggles(columnDefs);

	  console.log("gridApi : "+ gridApi);
	  console.log("gridColumnApi : "+ gridColumnApi);
	  
	    $.ajax({
	        url: "/grid/users",
	        method: "POST",
	        contentType: "application/json",
	        data: JSON.stringify({
	         /*  keyword: "사용자1",
	          minAge: 25 */
	        }),
	        success: function (data) {
	        	 gridApi.updateGridOptions({ rowData: data });
	        },
	        error: function (xhr, status, error) {
	          console.error("데이터 요청 실패:", status, error);
	        }
	      });
  }
  

};

document.addEventListener('DOMContentLoaded', function () {
  const eGridDiv = document.querySelector('#myGrid');
  agGrid.createGrid(eGridDiv, gridOptions);
  
});


    // CSV 내보내기
   function onExport() {
  if (gridApi) {
    gridApi.exportDataAsCsv();
  } else {
    alert("그리드가 아직 초기화되지 않았습니다.");
  }
}

   function onBtHide() {
	     gridApi.setColumnsVisible(['age'], false);
	 }
   function onBtShow() {
	     gridApi.setColumnsVisible(['age'], true);
	 }
   
   function createColumnToggles(columnDefs) {
	    const container = document.getElementById("columnToggles");
	    container.innerHTML = '';

	    columnDefs.forEach(col => {
	      const wrapper = document.createElement("label");
	      wrapper.style.marginRight = "12px";

	      const checkbox = document.createElement("input");
	      checkbox.type = "checkbox";
	      checkbox.checked = true;
	      checkbox.dataset.colId = col.field;

	      checkbox.addEventListener("change", function () {
	        const colId = this.dataset.colId;
	        const visible = this.checked;
	        if (gridApi) {
	          gridApi.setColumnsVisible([colId], visible);
	        }
	      });

	      wrapper.appendChild(checkbox);

	      const label = document.createTextNode(col.headerName);
	      wrapper.appendChild(label);

	      container.appendChild(wrapper);
	    });
	  }
   
   function showGridState() {
	   if (!gridApi) {
	     alert("그리드가 아직 초기화되지 않았습니다.");
	     return;
	   }

	   const columnState = gridApi.getColumnState(); // 컬럼 정보

	   const result = columnState.map(c => ({
	     컬럼ID: c.colId,
	     숨김여부: c.hide ? "숨김" : "표시",
	     너비: c.width + "px",
	     순서: c.order !== undefined ? c.order : "-",
	     정렬: c.sort || "정렬 안됨"
	   }));

	   console.table(result);

	   // 간단한 Alert 메시지 출력
	  
	 }
  </script>
</body>
</html>





<%-- <%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <title>E7E Ag-Grid 시작 예제</title>
    <!-- 하는 김에 괘니 tailwindcss도 적용해 보깅 -->
    <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
    <style type="text/tailwindcss">
      .e7e {
        @apply text-center text-3xl my-1 pb-4 rounded bg-blue-500 px-4 py-2 font-bold text-white hover:bg-blue-600;
      }
    </style>
    <!-- tailwindcss 적용 끝, production mode에선 사용하지 말것-->
    <!-- ag-grid 적용 -->
    <script src="https://cdn.jsdelivr.net/npm/ag-grid-community/dist/ag-grid-community.min.js"></script>
    <link rel="stylesheet" href="index.css" />
  </head>
 
  <body>
    <h1 class="e7e">테이블</h1>
    <!-- 테마는 quartz, balham, material,alpine 있음 -->
    <div id="e7eGrid" class="ag-theme-quartz-dark w-full h-100"></div>
    <script type="module">
      // 샘플 ROW 데이타 정의, DB Select의 1줄 Row들의 모임 list가 될거시당
      const rowData = [
        {
          name: "경미닝",
          birth: "2000-03-03",
          nationality: "한국",
          special: "기획",
        },
        {
          name: "선주닝",
          birth: "1999-09-09",
          nationality: "한국",
          special: "비동기",
        },
        {
          name: "카리나",
          birth: "2000-04-11",
          nationality: "한국",
          special: "리액트",
        },
        {
          name: "지젤",
          birth: "2000-10-30",
          nationality: "일본",
          special: "JSP",
        },
        {
          name: "윈터",
          birth: "2001-01-01",
          nationality: "한국",
          special: "바닐라JS",
        },
        {
          name: "닝닝",
          birth: "2002-10-23",
          nationality: "중국",
          special: "마이바티스",
        },
      ];
 
      // 통합 설정 객체, 아주 많은 속성들이 제공됨(일단 몇개만)
      const gridOptions = {
        theme: "legacy",
        rowData: rowData,
        columnDefs: [
          // 컬럼 정의
          { field: "name", headerName: "이름" },
          { field: "birth", headerName: "생일" },
          { field: "nationality", headerName: "국적" },
          { field: "special", headerName: "담당" },
        ],
        autoSizeStrategy: {
          // 자동사이즈정책
          type: "fitGridWidth", // 그리드넓이기준으로
          defaultMinWidth: 150, // 컬럼 최소사이즈
        },
        rowHeight: 45, // row 높이지정
      };
 
      const gridDiv = document.querySelector("#e7eGrid");
      const gridApi = agGrid.createGrid(gridDiv, gridOptions);
    </script>
  </body>
</html> --%>


<%-- 
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">

<head>
  <meta charset="utf-8" />
  <script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.17.1/xlsx.full.min.js"></script>
	  <script type="text/javascript" src="${pageContext.request.contextPath}/static/js/tui/tui-pagination.js"></script>
	  <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/tui/tui-pagination.css" />
	  <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/tui/tui-grid.css" />
	  <script src="${pageContext.request.contextPath}/static/js/tui/tui-grid.js"></script>
	  <script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.17.1/xlsx.full.min.js"></script>
	  
	  <!-- toastr.js 토스트메세지  -->
	  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css">
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
	
	<!-- Notyf 토스트메세지 -->
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/notyf@3/notyf.min.css">
	<script src="https://cdn.jsdelivr.net/npm/notyf@3/notyf.min.js"></script>
	  
	  
	  
  <title>Toast UI Grid</title>
  
  <style>  /* 스타일 커스텀 적용 */
   .dragging-header {
    opacity: 0.5;
    background-color: #d3d3d3;
    
  	.tui-grid-header-area {
	  height: 60px;  /* 기본보다 조금 더 높게 */
	}

  
    .name-column {
      background-color: #e6f7ff;
      color: #1207e6;           
      font-weight: bold;
      width: 200px;
    }
    
    .tui-grid-btn-sorting {
     transform: scale(1.5);        /* 크기 2배 확대 */
	  transform-origin: center;   /* 중앙 기준 확대 */
	  margin-left: 10px;    
    }
    
    .tui-pagination .tui-page-btn {
      background-color: #000000;
      border: 1px solid #ccc;
      color: white;
      padding: 5px 10px;
      margin: 2px;
    }
    
    .tui-pagination .tui-is-selected {
      background-color: #005577;
      color: white;
      font-weight: bold;
    }
  </style>
  
</head>

<body>
	<a href="https://nhn.github.io/tui.grid/latest/tutorial-example01-basic" target="_blank">Toast UI Grid</a> 
	</br>
	테이블 헤더 고정 / 필드별 정렬 기능 / 클라이언트 페이징 / 자동 rownum / 테이블 x,y축 스크롤 활성화 / 스타일 커스텀 적용
	</br>
	 
	 <!-- <button onclick="javascript:hideColumn('name')">이름 컬럼 토글</button>
  	 <button onclick="javascript:showColumn('name')">나이 컬럼 토글</button> -->
	 <button onclick="toastr.success('성공메세지');">toastr - success</button>
	 <button onclick="toastr.info('인포메세지');">toastr - info</button>
	 <button onclick="toastr.warning('워닝메세지');">toastr - warning</button>
	 <button onclick="toastr.error('에러메세지');">toastr - error</button>
	  <button onclick="showSuccess()">notyf - success</button>
	  <button onclick="showError()">notyf - error</button>

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
          width: 300,
          minWidth: 200,
          resizable: true,
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
	
let draggedColumnName = null;
let originalIndex = null;

const headerCells = document.querySelectorAll('.tui-grid-header-area th[data-column-name]');
headerCells.forEach(th => {
  th.setAttribute('draggable', 'true');

  // 드래그 시작
  th.addEventListener('dragstart', e => {
    draggedColumnName = th.dataset.columnName;
    originalIndex = Array.from(headerCells).indexOf(th);
    th.classList.add('dragging-header');
    e.dataTransfer.effectAllowed = 'move';
  });

  // 드래그 끝
  th.addEventListener('dragend', () => {
    draggedColumnName = null;
    originalIndex = null;
    headerCells.forEach(th => th.classList.remove('dragging-header'));
  });

  // 드롭 대상 위에 올렸을 때
  th.addEventListener('dragover', e => {
    e.preventDefault(); // drop 허용
    e.dataTransfer.dropEffect = 'move';
  });

  // 드롭 시 처리
  th.addEventListener('drop', e => {
    e.preventDefault();
    const targetColumnName = th.dataset.columnName;

    if (draggedColumnName && draggedColumnName !== targetColumnName) {
      const columns = grid.getColumns();

      // 현재 컬럼 순서 → 드래그된 컬럼 이동
      const draggedIndex = columns.findIndex(c => c.name === draggedColumnName);
      const targetIndex = columns.findIndex(c => c.name === targetColumnName);

      const newColumns = [...columns];
      const [moved] = newColumns.splice(draggedIndex, 1); // 제거
      newColumns.splice(targetIndex, 0, moved); // 새 위치 삽입

      grid.setColumns(newColumns); // 재설정
    }

    draggedColumnName = null;
    originalIndex = null;
  });
});

});


const notyf = new Notyf({
    duration: 3000, // 메시지 지속 시간 (ms)
    position: {
      x: 'right',
      y: 'bottom',
    }
  });

  // 성공 메시지
  function showSuccess() {
    notyf.success('성공적으로 처리되었습니다!');
  }

  // 에러 메시지
  function showError() {
    notyf.error('오류가 발생했습니다.');
  }
  
  
  
</script>

</body>
</html> 
  --%>