<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <title>AG Grid Demo</title>
	<!-- ag-grid  -->
	<!-- <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/ag-grid-community/styles/ag-grid.css"> -->
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/ag-grid-community/styles/ag-theme-alpine.css">

    <!-- toastr.js  -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css">
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
	
	<!-- Notyf -->
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/notyf@3/notyf.min.css">
	<script src="https://cdn.jsdelivr.net/npm/notyf@3/notyf.min.js"></script>
	
  
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
	
	<!-- 토스트 메세지 샘플 -->  
	<button onclick="toastr.success('성공메세지');">toastr - success</button>
	<button onclick="toastr.info('인포메세지');">toastr - info</button>
	<button onclick="toastr.warning('워닝메세지');">toastr - warning</button>
	<button onclick="toastr.error('에러메세지');">toastr - error</button>
	<button onclick="showSuccess()">notyf - success</button>
	<button onclick="showError()">notyf - error</button>
  
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/ag-grid-community/dist/ag-grid-community.min.js"></script>
  
  <script>
 	 /* 그리드 컬럼 설정 */
    const columnDefs = [
      { field: "id", headerName: "ID", sortable: true, resizable: true , cellStyle: {
          backgroundColor: "#fff8dc"  // light yellow (cornsilk)
      }},
      { field: "name", headerName: "이름", sortable: true, resizable: true },
      { field: "age", headerName: "나이", sortable: true, sort:"desc", hide:false, width:100,  resizable: true },
      { field: "email", headerName: "이메일", sortable: true, resizable: true }
    ];

    /* 그리드 가변 조절을 위한 선언 */
    let gridApi = null;
    let gridColumnApi = null;
    
   const gridOptions = {
  columnDefs: columnDefs,
  rowData: [],/* 하단 ajax로 데이터 받아옴 */
  defaultColDef: {
    /* flex: 1, */
    minWidth: 120,
    sortable: true, /* order 가능 */
    resizable: true /* resizing 가능 */
  },
  pagination: true, /* 페이징 설정 부분 */
  paginationPageSize: 10, 
  paginationPageSizeSelector: [10,20,30],
  animateRows: true,
  rowHeight: 30,
  headerHeight: 50,
  /* getRowId: params => params.data.id, */
  onGridReady: function(params){ /* 그리드 렌더링 후 데이터 삽입 */
	  gridApi = params.api;
	  createColumnToggles(columnDefs);
	  
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


   /* 그리드 csv로 내보내기 함수 */
  function onExport() {
	  if (gridApi) {
	    gridApi.exportDataAsCsv();
	  } else {
	    alert("그리드가 아직 초기화되지 않았습니다.");
	  }
}
	/* simple 컬럼 보이기, 숨기기 */
  function onBtHide() {
	     gridApi.setColumnsVisible(['age'], false);
	 }
  function onBtShow() {
	     gridApi.setColumnsVisible(['age'], true);
	 }
  
  /* 컬럼 표시 여부 토글 함수 */
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
  /* 그리드 상태 저장 함수 (추후 개인 그리드 설정정보 저장값으로 이용) */
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
	     정렬: c.sort || "정렬 안됨"
	   }));

	   console.table(result);
	  
	 }   
   
document.addEventListener('DOMContentLoaded', function () {
	/* 그리드 구현 */
  const eGridDiv = document.querySelector('#myGrid');
  agGrid.createGrid(eGridDiv, gridOptions);
  
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
