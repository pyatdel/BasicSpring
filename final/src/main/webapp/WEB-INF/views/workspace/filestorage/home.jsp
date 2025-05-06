<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.util.Date" %>
<%@page import="java.text.SimpleDateFormat" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!-- 라이브러리 include  -->
   <jsp:include page="../../include/library.jsp"></jsp:include>
   <!-- 라이브러리 include  -->
    
 <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">


<style>
html {
  scroll-behavior: smooth;
}
ul li {
margin:0 ; 
padding:0 ;


}
.content{
    width: 96%;
    margin-left: auto !important;
    margin-top: 0 !important;
    padding:  0 !important;

}
.content-area{
padding: 6px !important;
}
.filecontainer{
display: flex;
margin-top:4%;

}
.file{
width: 76%;
margin:0 auto ;
}
.fileside{
width: 18%;
height:100vh;
border-right: 1px solid #c5c5c5;
}
.fileside > ul {

list-style: none;
margin-top:2%;
    padding-left: 0 !important;
    vertical-align:middle;
    cursor: pointer;
}
h3{
margin:30px !important;
margin-left:50px !important; 
font-weight: normal !important;
cursor: pointer;

}
.fileside > ul > li {
padding:40px;
height: 60px;
  display: flex;
  align-items: center;  /* 세로 중앙 정렬 */
  align-content: center;
  justify-content: flex-start;  /* 수평 중앙 정렬 (필요시 조정) */
  font-weight:600;
  font-size: 17px;
  color:#555454;
}

.fileside > ul > li:hover{
background-color: #f1f1f1;
color: #3069CE !important;

}
.fa-3x {
font-size: 2em !important;
padding-right:10px;
}
.table{
margin-top:1%;
text-align: center;
}
tr:hover{
background-color: #f1f1f1;

}
 tr{
height:70px;
border:white !important;
  width: 100%;
    vertical-align: middle; /* 세로 중앙 정렬 */

}
thead{
border:white !important;

}
.telft{
text-align: left;
font-weight:bold;
cursor: pointer;
width: 700px;
}
select{
outline: none !important;
border:none !important;
background-color:#f1f1f1; 
padding:10px;
border-radius:10px;
margin-left: 30px !important;
width: 150px;
}
.fa-solid{
padding:10px;
color:#3069CE;
font-size: 1.5em;
}
.fa-file-pdf{

color:#db5353;
}
.fa-file-zipper{
color:orange;
}
.icon{
color:#3069CE !important;
font-size: 1.5em;
margin-right: 18px;
}
.iconc{
margin-right: 28px;

}
.iconh{
margin-right: 26px;

}
.fa-download{
    color: #858585 !important;
    font-size: 19px;

}
.fa-file-excel{
color:#278986;

}
.fileHeader{
display: flex;
justify-content: space-between;
    margin-top: 2.8%;
    margin-bottom: 1.8%;
}
.searchInput{
    outline: none !important;
    border: 1px solid #c1c1c1 !important;
    padding: 8px;
    border-radius: 5px;
     caret-color: #66afe9;
     width: 240px;
     

}
 .searchInput:focus {
            border-color: #66afe9; /* 포커스 시 테두리 색상 변경 */
            box-shadow: 0 0 5px rgba(102, 175, 233, .6); /* 포커스 시 그림자 효과 */
        }
.fileBt ,.fileBt2{
width:9%;
   height: 40px !important;
   border-radius: 10px !important;
       background-color:#434343!important;
    border: none!important;
    color:white !important;
    outline: none !important; 

}
 button:active {
    box-shadow: inherit !important; /* 클릭 시 그림자 효과 */
    outline: none !important;
    border: none !important;
}   
button:focus {
    outline: none !important;  /* 포커스 시 외곽선 없애기 */
    box-shadow: none !important; /* 포커스 시 그림자 없애기 */
}
.searchText{
	width: 200px;
	height:40px;
	border: 1px solid gray;
	caret-color: #66afe9;
}
.col-md-7{
        width: 100%  !important;  
        display: flex  !important;  
        justify-content: center  !important;  
        
}
    .searchText {
            width: 300px; /* 너비 설정 */
            padding: 10px; /* 안쪽 여백 */
            border: 1px solid #ccc; /* 테두리 설정 */
            border-radius: 4px; /* 테두리 둥글게 */
            font-size: 16px; /* 폰트 크기 */
            outline: none; /* 클릭 시 테두리 강조 없애기 */
            box-sizing: border-box; /* 패딩이 포함된 전체 너비 계산 */
            min-height: 10px; /* 최소 높이 설정 */
            word-wrap: break-word; /* 단어가 길면 줄 바꿈 */
            caret-color: #66afe9; /* 커서 색상 설정 */
            cursor: text; /* 마우스 커서를 텍스트 커서로 설정 */
        }

        .searchText:focus {
            border-color: #66afe9; /* 포커스 시 테두리 색상 변경 */
            box-shadow: 0 0 5px rgba(102, 175, 233, .6); /* 포커스 시 그림자 효과 */
        }
        .fa-magnifying-glass {
    position: absolute;
    right: 10%;
    cursor: pointer;
    color: #bfbfbf;
    font-size: 25px;
    margin: 0 !important;
        
        }
        .searchBar{
        position: relative;
        text-align: center;
            margin:  12% 0 7% 0;
        }
        a{
        color: inherit !important; }
        .file.active {
        
        display: block;
        
        }
        .file.active {
        
        display: block;
        
        }
        .file{
        display: none;
        height: 100vh;
        }
        .nav.active {
    color: #3069CE;
}
input[type="file" i] {
    appearance: none;
    cursor: default;
    align-items: baseline;
    color: inherit;
    text-overflow: ellipsis;
    text-align: start !important;
    padding: initial;
    border: initial;
    white-space: pre;
}
.fileBox{
display: flex;


}
 #fileInput {
            display: none;
        }
        .pagebox{
        width: 100%;
        display: block;
        
        }
        #divPagingArea{
        width: 100% !important;
        display: block !!important; 
        
        }
        .fa-file-image{
        	color:#dd4f4f;
        }
        .fa-file-lines{
        color: #278986;
        }
        
    #down{
		cursor: pointer;    
    
    }
    #down:active > i{
    color:#3069CE !important;
    
    
    }
    .fileBox{
    }
    .hoverMenu{
    	display: none;
    	position: absolute;
    	left: 24%;
    	top:23%;
    	background-color: white;
    	width: 200px;
    	border-radius: 10px;
    	box-shadow: 10px 10px 10px gray;
    	
    }
    .hoverTag{
    	display: block;
    	padding: 20px;
    	color:black !important;
    	font-weight: normal;
    
    }
    .hoverTag:hover{
    	background: #dae0eb !important;
    	border-radius: 10px;
    
    }
    .fileBox:hover .hoverMenu{
    display: block;
	
}
.deptFolder{
    width: 120px;
    height: 120px;
    border-radius: 5px;
    cursor: pointer;


}
.deptFolder:active{
    border: 1px solid #3069CE;
    background-color: #66aee958;

}
.btn-primary{
background-color:  #3069CE !important;
color:white !important;
border:none !important

}
.fa-folder-plus ,.fa-folder-open{
    color:#f5e45f !important;
    font-size: 4rem;
    text-align: center;
    display: flex;
    align-items: center;
    justify-content: center;


}
.deptName{
text-align: center;

}
.deptContainer {
    margin-top:5% ;
    margin-left: 5%;
    display: grid;
    grid-template-columns: repeat(7, 1fr); /* 한 행에 5개의 항목 */
    grid-gap: 10px;
    width: 100%;
    height: 200px; /* 화면에 보이는 높이 */
}
.errorPage{
font-size: 2rem;
    display: flex
;
    text-align: center;
    justify-content: center;
    align-items: center;
    height: 40vh;
    font-weight: normal !important;
    color: #474747;

}
.errorBox{
display: block ;
}
.fileStorage{
color:#3069CE !important;
font-weight: bold;

}
.workSubMenu{

display: block !important;
height: auto !important;

}
.workMenu {
color:#3069CE !important;
font-weight: bold;
}
.bluBt{
background-color: #434343!important;
color:white !important;
outline: none !important;
border:none !important;
width: 90px !important;
height:38px !important;
border-radius: 5px !important;

}
// 목록 버튼
.greenBt{
background-color: #278986;
color:white;
outline: none;
border:none;
width: 90px;
height:36px; 
border-radius: 5px;

}
.blueline{
background-color: white !important;
color: #434343!important;
font-weight:bold;
border: 1px solid #434343!important;

}

.page-item.active .page-link {
    z-index: 1;
    color: white !important;
    background-color: #3069CE !important;
    border-color: #3069CE !important;
}
.next > a{
    color: #3069CE !important;

}
.page-item > a{
    color: #3069CE ;
}
</style>
  </head>

<!-- 헤더 include  -->
   <jsp:include page="../../include/header.jsp"></jsp:include>
<!-- 헤더 include  -->
<div class="filecontainer">

<div class="fileside">
	<h3>파일 보관함</h3>
	
	<ul>
			<input type="file" id="fileInput" name="uploadFiles" onchange="uploadFiles()" multiple>
<!--  
<li class="fileBox">
         	
         	 <div class="hoverMenu">
         		<a href="#" class="hoverTag" onclick="fileCont()">공통</a>
         		<a href="#" class="hoverTag" onclick="MyfileBt()">개인</a>
         		<a href="#" class="hoverTag">부서</a>
         	</div> 
		</li>
-->		
		<div class="searchBar">
			 <input type="text" name="keyword" class="updtcon searchInput" placeholder="검색어를 입력해 주세요."
			 value="${param.keyword}">
					  <i class="fa-solid fa-magnifying-glass" onclick="Search()"></i>
			</div>
		<li class="company nav active" data-nav="common"><i class="fa-solid fa-building icon iconc"></i>회사 공통 파일</li>
		<li class="company nav" data-nav="my" data-url="/file/myListAxios"><i class="fa-solid fa-user icon iconh"></i>개인파일</li>
		<li class="company nav" data-nav="department"><i class="fa-solid fa-users icon"></i>부서파일</li>
	</ul>
</div>
<div class="file active" id="common">
	<%-- <div>${fileStorageServiceList }</div>
	<div>${fileStorageVO }</div> --%>
	<div class="fileHeader">
	<div>
		<select name="languages" id="fileMime" onchange="fileMime()">
		<i class="fas fa-file"></i> 
		  <option value="">모든파일 </option>
		  <option value="text">TEXT</option>
		  <option value="png" >PNG</option>
		  <option value="jpg" >JPG</option>
		  <option value="zip">ZIP</option>
	 </select> 
			<button type="button" id="" class=" fileDwBt bluBt" onclick="downloadMultiple(event) ">다운로드</button> 
			<button type="button" id="edit" class="bluBt blueline" onclick="deleteFile(event) ">삭제</button> 
				
	</div> 
		<button type="button" id="fileBt"  class="fileBt" onclick="fileCont()">업로드하기</button>
	</div>
                            <table class="table table-borderless">
                                <thead>
                                    <tr>
                                        <th scope="col"><input type="checkbox"></th>
                                        <th scope="col" class="telft">파일명</th>
                                        <th scope="col">파일소유자</th>
                                        <th scope="col">업로드 날짜</th>
                                        <th scope="col">파일크기</th>
                                        <th scope="col"></th>
                                    </tr>
                                </thead>
                                <tbody id="tbdy">
                          	
                                </tbody>
                            </table>
                <div class="row justify-content-center" id="divPagingArea"></div>
                 </div>
                        
                        <!--  -->
<div class=" file  " id="my">
	<div class="fileHeader">
	<div>
<input type="file"  name="uploadFiles" id="myFileInput" class="myFileInput" onchange="myupload()"  multiple="multiple" style="display: none;"/>
		
		<select name="languages" id="lang">
		<i class="fas fa-file"></i> 
		  <option value="javascript">모든파일 </option>
		  <option value="php">문서</option>
		  <option value="java">사진/동영상</option>
	 </select> 
			<button type="button" id="edit" class="fileDwBt bluBt"  onclick="downloadMultiple(event) ">다운로드</button> 
		<button type="button" id="edit" class="bluBt blueline" onclick="deleteFile(event) ">삭제</button> 
	</div>
			<button type="button" id="fileBt2"  class="fileBt2" onclick="MyfileBt()">업로드하기</button>
	</div>
                            <table class="table table-borderless">
                                <thead>
                                    <tr>
                                        <th scope="col"><input type="checkbox"></th>
                                        <th scope="col" class="telft">파일명</th>
                                        <th scope="col">소유자</th>
                                        <th scope="col">날짜</th>
                                        <th scope="col">크기</th>
                                        <th scope="col"></th>
                                    </tr>
                                </thead>
                                <tbody>
                                	<!-- 비동기 개인파일 리스트 넣을 공간이다 ~ -->
                                </tbody>
                            </table>
                              <div class="row justify-content-center" id="divPagingArea2"></div>
                        </div>
  <!-- 부서 파일함   --> 
<div class=" file  " id="department">
	<div class="fileHeader">
	<div>
	<input type="file"  name="uploadFiles" id="deptFileInput" class="deptFileInput" onchange="deptupload()"  multiple="multiple" style="display: none;"  />
			
		<select name="languages" id="lang">
		<i class="fas fa-file"></i> 
		  <option value="javascript">모든파일 </option>
		  <option value="php">문서</option>
		  <option value="java">사진/동영상</option>
	 </select> 
			<button type="button" id="edit" class="fileDwBt bluBt "  onclick="downloadMultiple(event) ">다운로드</button> 
		<button type="button" id="edit" class="bluBt blueline" onclick="deleteFile(event) ">삭제</button> 
	</div>
			<button type="button" id="fileBt2"  class="fileBt2" onclick="deptfileBt()">업로드하기</button>
	</div>
	
    <div class="deptContainer">

        <div class="deptFolder tab" data-tab="develop" data-dept-no="2">
            
            <i class="fa-solid fa-folder-open"></i>
            <div class="deptName" id="developDept">개발부</div>
            
        </div>
        <div class="deptFolder tab" data-tab="sales"  data-dept-no="3" >
            
            <i class="fa-solid fa-folder-open"></i>
            <div class="deptName" id="salesDept">영업부</div>
        </div>
        <div class="deptFolder tab" data-tab="human"  data-dept-no="1">
            
            <i class="fa-solid fa-folder-open"></i>
            <div class="deptName">인사부</div>
            
        </div>
        <div class="deptFolder tab" data-tab="execu"  data-dept-no="4">
            
            <i class="fa-solid fa-folder-open"></i>
            <div class="deptName">행정부</div>
            
        </div>
        <div class="deptFolder tab" data-tab="account"  data-dept-no="5">
            
            <i class="fa-solid fa-folder-open"></i>
            <div class="deptName">회계부</div>
            
        </div>
    </div>
        
        <table class="table table-borderless" style="display: none">
                                <thead>
                                 
                                    <tr>
                                        <th scope="col"><input type="checkbox"></th>
                                        <th scope="col" class="telft">파일명</th>
                                        <th scope="col">소유자</th>
                                        <th scope="col">날짜</th>
                                        <th scope="col">크기</th>
                                        <th scope="col"></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <th scope="row"><input type="checkbox"></th>
                                        <td class="telft" ><i class="fa-regular fa-solid fa-file-zipper"></i>집가고싶다.zip</td>
                                        <td>하잭완</td>
                                        <td>2025-01-03 09:22 </td>
                                        <td>500MB</td>
                                        <td><i class="fa-solid fa-download"></i></td>
                                    </tr>
                                </tbody>
                            </table>
                    
                        <c:forEach var="fileDetailVO"
								items="${fileDetailVOList.fileDetailVO}"
								varStatus="stat">
								<!-- 왼쪽 영역 시작 FileDetailVO(fileSn=1 -->
								<tr>
							<th scope="row">12</th>
							<td>계약서</td>
							<td>
							<button type="button" id="prev" class="btn btn-primary m-2">미리보기</button>
							<button type="button" id="down" class="btn btn-primary m-2">다운로드</button>
							</td>
							</tr>
								<div class="modal_bgrd"  style="display: none; ">
								<div class="mgmodal">
									<div class="delmodal">&times;</div>
									<div class="mdimg">
										<img class="img-fluid imgFileSaveLocate"
											style="cursor: pointer;" src="${fileDetailVO.fileSaveLocate}" 
											data-file-original-name="${fileDetailVO.fileOriginalName}"
					                    	 data-file-save-locate="${fileDetailVO.fileSaveLocate}" />
									</div>
								</div>
								</div>
								<!-- 왼쪽 영역 끝 -->
							</c:forEach>
	</div>
<div class=" file" id="develop">
	<%-- <div>${fileStorageServiceList }</div>
	<div>${fileStorageVO }</div> --%>
	<div class="fileHeader">
                          			 
	<div>
		<select name="languages" id="lang">
		<i class="fas fa-file"></i> 
		  <option value="javascript">모든파일 </option>
		  <option value="php">문서</option>
		  <option value="java">사진/동영상</option>
	 </select> 
			<button type="button" id="edit" class="fileDwBt bluBt" onclick="downloadMultiple(event) ">다운로드</button> 
				<button type="button" id="edit" class="bluBt blueline" onclick="deleteFile(event) ">삭제</button> 
	</div> 
			<button type="button" id="fileBt3"  class="btn btn-primary fileBt3" onclick="deptfileBt()">업로드하기</button>
			
	</div>
                            <table class="table table-borderless">
                                <thead>
                                    <tr>
                                        <th scope="col"><input type="checkbox"></th>
                                        <th scope="col" class="telft">파일명</th>
                                        <th scope="col">소유자</th>
                                        <th scope="col">날짜</th>
                                        <th scope="col">크기</th>
                                        <th scope="col"></th>
                                    </tr>
                                </thead>
                                <tbody id="tbdy">
                                </tbody>
                                
                            </table>
                            <div class="errorBox">
                            	<div class="errorPage"><i class="fa-solid fa-triangle-exclamation"></i> 권한이 없습니다. </div>
                            </div>
                <div class="row justify-content-center" id="divPagingArea"></div>
                 </div>
<div class=" file" id="sales">
	<%-- <div>${fileStorageServiceList }</div>
	<div>${fileStorageVO }</div> --%>
	<div class="fileHeader">
	<div>
		<select name="languages" id="lang">
		<i class="fas fa-file"></i> 
		  <option value="javascript">모든파일 </option>
		  <option value="php">문서</option>
		  <option value="java">사진/동영상</option>
	 </select> 
			<button type="button" id="edit" class="bluBt fileDwBt" onclick="downloadMultiple(event) ">다운로드</button> 
				<button type="button" id="edit" class="bluBt blueline" onclick="deleteFile(event) ">삭제</button> 
	</div> 
			<button type="button" id="fileBt3"  class="btn btn-primary fileBt3" onclick="deptfileBt()">업로드하기</button>
			
	</div>
                            <table class="table table-borderless">
                                <thead>
                                    <tr>
                                        <th scope="col"><input type="checkbox"></th>
                                        <th scope="col" class="telft">파일명</th>
                                        <th scope="col">소유자</th>
                                        <th scope="col">날짜</th>
                                        <th scope="col">크기</th>
                                        <th scope="col"></th>
                                    </tr>
                                </thead>
                                <tbody id="tbdy">
                          	
                                </tbody>
                            </table>
                            <div class="errorBox" id="mgHiphap">
                            	<div class="errorPage"><i class="fa-solid fa-triangle-exclamation"></i> 권한이 없습니다. </div>	
                            </div>
                <div class="row justify-content-center" id="divPagingArea"></div>
                 </div>
<div class=" file" id="human">
	<%-- <div>${fileStorageServiceList }</div>
	<div>${fileStorageVO }</div> --%>
	<div class="fileHeader">
	
	<div>
		<select name="languages" id="lang">
		<i class="fas fa-file"></i> 
		  <option value="javascript">모든파일 </option>
		  <option value="php">문서</option>
		  <option value="java">사진/동영상</option>
	 </select> 
			<button type="button" id="edit" class="btn btn-primary fileDwBt" onclick="downloadMultiple(event) ">다운로드</button> 
				<button type="button" id="edit" class="bluBt blueline" onclick="deleteFile(event) ">삭제</button> 
	</div> 
			<button type="button" id="fileBt3"  class="btn btn-primary fileBt3" onclick="deptfileBt()">업로드하기</button>
			
	</div>
                            <table class="table table-borderless">
                                <thead>
                                    <tr>
                                        <th scope="col"><input type="checkbox"></th>
                                        <th scope="col" class="telft">파일명</th>
                                        <th scope="col">소유자</th>
                                        <th scope="col">날짜</th>
                                        <th scope="col">크기</th>
                                        <th scope="col"></th>
                                    </tr>
                                </thead>
                                <tbody id="tbdy">
                          			
                                </tbody>
                            </table>
                            <div class="errorBox" id="mgHiphap">
                            	
                            	<div class="errorPage"><i class="fa-solid fa-triangle-exclamation"></i> 권한이 없습니다. </div>
                            </div>
                <div class="row justify-content-center" id="divPagingArea"></div>
                 </div>
<div class=" file" id="execu">
	<%-- <div>${fileStorageServiceList }</div>
	<div>${fileStorageVO }</div> --%>
	<div class="fileHeader">
	
	<div>
		<select name="languages" id="lang">
		<i class="fas fa-file"></i> 
		  <option value="javascript">모든파일 </option>
		  <option value="">문서</option>
		  <option value="java">사진/동영상</option>
	 </select> 
			<button type="button" id="edit" class="btn btn-primary fileDwBt" onclick="downloadMultiple(event) ">다운로드</button> 
				<button type="button" id="edit" class="bluBt blueline" onclick="deleteFile(event) ">삭제</button> 
	</div> 
			<button type="button" id="fileBt2"  class="fileBt2" onclick="deptfileBt()">업로드하기</button>
			
	</div>
                            <table class="table table-borderless">
                                <thead>
                                    <tr>
                                        <th scope="col"><input type="checkbox"></th>
                                        <th scope="col" class="telft">파일명</th>
                                        <th scope="col">소유자</th>
                                        <th scope="col">날짜</th>
                                        <th scope="col">크기</th>
                                        <th scope="col"></th>
                                    </tr>
                                </thead>
                                <tbody id="tbdy">
                          			
                                </tbody>
                            </table>
                            <div class="errorBox" id="mgHiphap">
                            	
                            	<div class="errorPage"><i class="fa-solid fa-triangle-exclamation"></i> 권한이 없습니다. </div>
                            </div>
                <div class="row justify-content-center" id="divPagingArea"></div>
                 </div>
<div class=" file" id="account">
	<%-- <div>${fileStorageServiceList }</div>
	<div>${fileStorageVO }</div> --%>
	<div class="fileHeader">
	
	<div>
		<select name="languages" id="lang">
		<i class="fas fa-file"></i> 
		  <option value="javascript">모든파일 </option>
		  <option value="php">문서</option>
		  <option value="java">사진/동영상</option>
	 </select> 
			<button type="button" id="edit" class="fileDwBt" onclick="downloadMultiple(event) ">다운로드</button> 
				<button type="button" id="edit" class="bluBt blueline" onclick="deleteFile(event) ">삭제</button> 
	</div> 
			<button type="button" id="fileBt2"  class="fileBt2" onclick="deptfileBt()">업로드하기</button>
			
	</div>
                            <table class="table table-borderless">
                                <thead>
                                    <tr>
                                        <th scope="col"><input type="checkbox"></th>
                                        <th scope="col" class="telft">파일명</th>
                                        <th scope="col">소유자</th>
                                        <th scope="col">날짜</th>
                                        <th scope="col">크기</th>
                                        <th scope="col"></th>
                                    </tr>
                                </thead>
                                <tbody id="tbdy">
                          			
                                </tbody>
                            </table>
                            <div class="errorBox" id="mgHiphap">
                            	
                            	<div class="errorPage"><i class="fa-solid fa-triangle-exclamation"></i> 권한이 없습니다. </div>
                            </div>
                <div class="row justify-content-center" id="divPagingArea"></div>
                 </div>
                  <jsp:include page="../../include/footer.jsp"></jsp:include>
</div>

   <script src="https://cdnjs.cloudflare.com/ajax/libs/axios/1.7.7/axios.min.js"></script>
<script type="text/javascript">

	// 전역 변수 ~
    const fileInput = document.getElementById('fileInput');
    const fileBt = document.getElementById('fileBt');
    const uploadButton = document.getElementById('uploadButton');
    
    //const myFileInput = document.getElementsByClassName('myFileInput');
    const myFileInput = document.getElementById('myFileInput');
    
    function fileMime(){
    	    const fileMime = document.getElementById('fileMime').value;
    	    console.log("fileMime 벨류 가져오기" , fileMime)
    	    
    	    let keyword = fileMime; 
    	   
    	    getList("1", keyword)
    	
    }
    
    
    function Search(){
    	let keyword = document.querySelector("input[name='keyword']").value;
    	
    	console.log("keyword 키워등" + keyword)
    	 getList("1", keyword)
    	
    }
    
    
    console.log("myFileInput",myFileInput)
	document.addEventListener('DOMContentLoaded', function() {
		getList()	// 페이지가 로드되면 자동으로 리스트를 불러옴 (공통 리스트)
	});
		
    
    function myupload(){
    	
		let formData = new FormData()
		let uploadFiles =  document.querySelector("#myFileInput");
    	
		
		// 이미지 파일들을 가져옴 
		let files = uploadFiles.files;
        console.log("files:" ,files)
		
		for(let i = 0; i<files.length ; i++){
			formData.append("uploadFiles", files[i]);
			console.log("files : ", files );
		}
        
        let fileURL2 = "http://localhost:8020/file/myInsert";
        let data = {
        		fileType: "my", // 폴더 구분용 type
                empNo: "empNo" // 로그인된 empNo는 서버에서 처리됨
            };
        formData.append("type", data.fileType);
        formData.append("value", data.empNo);
        axios.post(fileURL2, formData, {
    	    headers: { 
    	        'Content-Type': 'multipart/form-data' // JSON 데이터 전송 시 Content-Type 설정
    	    }
    	})
    	    .then((res) => {
    	         // 입력 필드 초기화
    	                  const activeNav = document.querySelector('.nav.active'); // 현재 활성화된 탭
	            const url = activeNav.getAttribute('data-url');  
	            const navId = activeNav.getAttribute('data-nav'); 
	            const currentPage = 1;  
	            const keyword = '';     // 예시로 검색어를 빈 문자열로 설정

    	         alert("업로드 성공!");
            // 리스트 갱신을 위한 함수 호출
            getTypeList(url, navId, currentPage, keyword);
    	    })
    	    .catch(function (error) {
    	       alert("실패");
    	       });
    }
    
	function MyfileBt(){
		myFileInput.click();
		
	}
	function deptfileBt(){
		deptFileInput.click();
		
	}
	console.log(fileInput,"fileInput")
		
	// 내가 만든 버튼 누르면 연계돼서 fileInput 선택창 뜨게 하는 함수 
    function fileCont() {
        fileInput.click();
    }
	
    // 파일 선택하고 확인누르면 파일 업로드 되는 함수 임당
    function uploadFiles() {
        let fileInput = document.getElementById('fileInput');
        
        console.log("파일 업로드 시작");

        if (fileInput.files.length > 0) {
            let formData = new FormData();  // FormData 객체로 파일을 아작스로 전송
            
            // 파일들을 가져오기
            let files = fileInput.files;
            console.log("선택된 파일들: ", files);
            
            // 파일들을 FormData에 추가
            for (let i = 0; i < files.length; i++) {
                formData.append("uploadFiles", files[i]);
                console.log("추가된 파일: ", files[i]);
            }

            let fileURL = "http://localhost:8020/file/insert";

            // 아작스로 파일 업로드 요청
            axios.post(fileURL, formData, {
                headers: { 
                    'Content-Type': 'multipart/form-data'
                }
            })
            .then((res) => {
                // 업로드 성공 시 처리
                getList();  // 리스트 갱신 함수 호출
                alert("업로드 성공!");
            })
            .catch(function (error) {
                // 업로드 실패 시 처리
                console.error("업로드 실패: ", error);
                alert("업로드 실패");
            });
        } else {
            alert("파일을 선택해 주세요!");
        }
    }
    
    function deptupload(){
    	
		let formData = new FormData()
		let uploadFiles =  document.querySelector("#deptFileInput");
    	
		
		// 이미지 파일들을 가져옴 
		let files = uploadFiles.files;
        console.log("files:" ,files)
		
		for(let i = 0; i<files.length ; i++){
			formData.append("uploadFiles", files[i]);
			console.log("files : ", files );
		}
        
        let fileURL2 = "http://localhost:8020/file/deptInsert";
        let data = {
        		fileType: "dept" // 폴더 구분용 type
                //empNo:"empNo", // 로그인된 empNo는 서버에서 처리됨
                //deptNo:"deptNo" // 로그인된 empNo는 서버에서 처리됨
                
            };
        formData.append("type", data.fileType);
        //formData.append("value", data.empNo);
        //formData.append("deptNo", data.deptNo);
        //console.log(deptNo , type , value ," formData 되니?")
        axios.post(fileURL2, formData, {
    	    headers: { 
    	        'Content-Type': 'multipart/form-data' // JSON 데이터 전송 시 Content-Type 설정
    	    }
    	})
    	    .then((res) => {
    	         // 입력 필드 초기화
         const activeTab = document.querySelector('.tab.active'); // 현재 활성화된 탭
	            const tabId = activeTab.getAttribute('data-tab'); 
	            const currentPage = 1; 
	            const keyword = '';     
	            const deptNo = activeTab.getAttribute('data-dept-no'); 
    	         alert("업로드 성공!");
	            // 리스트 갱신을 위한 함수 호출
	            getdeptList(deptNo, tabId, currentPage, keyword);
    	    })
    	    .catch(function (error) {
    	       alert("실패");
    	       });
    }
    
    
    function getList(currentPage, keyword) {
        let data = {
            "currentPage": currentPage,
            "keyword": keyword
        };

        console.log("data : ", data);
        let url = "http://localhost:8020/file/listAxios";

        // POST 요청에서 body로 데이터를 전달
        axios.post(url, data)  // axios는 자동으로 JSON 형식으로 변환해서 전달
        .then(function(response) {
            //console.log("articlePage : ", response.data);  // 전체 응답 데이터 확인
            //console.log("articlePage.content : ", response.data.content);  // 실제 콘텐츠 출력
            let fileList = response.data.content;

            // content 데이터가 있을 경우 처리
            let str = ""; // 이 변수는 루프 밖에서 정의해야 외부에서 사용 가능
			console.log("fileList",fileList)
            for (let i = 0; i < fileList.length; i++) {
                let fileContent = fileList[i];

                console.log("파일이름 : ", fileContent);
                //console.log("파일그룹 : ", fileContent.fileGroupVO);
                //console.log("파일세부 : ", fileContent.fileGroupVO.fileDetailVOList[0].fileSaveName);
                let fileSaveDate = new Date(fileContent.fileSaveDate);
                let formattedDate = fileSaveDate.toLocaleDateString('ko-KR', { year: 'numeric', month: '2-digit', day: '2-digit' });

                // 아이콘 클래스를 확장자에 따라 설정
                let iconClass = 'fa-file';  // 기본 아이콘
                //<i class="fa-solid fa-file-excel"></i>
                // 확장자에 따른 아이콘 변경
                if (fileContent.fileExt === 'xlsx') {
                    iconClass = 'fa-file-excel';
                } else if (fileContent.fileExt === 'pdf') {
                    iconClass = 'fa-file-pdf';
                } else if (fileContent.fileExt === 'jpg' || fileContent.fileExt === 'jpeg' ||fileContent.fileExt === 'jfif'
                			||fileContent.fileExt === 'PNG'||fileContent.fileExt === 'JPG') {
                    iconClass = 'fa-file-image';
                } else if (fileContent.fileExt === 'png') {
                    iconClass = 'fa-file-image';
                }else if (fileContent.fileExt === 'odt') {
                    iconClass = 'fa-file-lines';
                }else if (fileContent.fileExt === 'csv') {
                    iconClass = 'fa-file-csv';
                }else if (fileContent.fileExt === 'zip') {
                    iconClass = 'fa-file-zipper';
                }else if (fileContent.fileExt === 'txt') {
                    iconClass = 'fa-align-center';
                } 
                //<i class="fa-solid fa-file-lines"></i><i class="fa-solid fa-file-csv"></i>
                // HTML 테이블 행 생성
                str += `
                	<tr>
                    <th scope="row"><input type="checkbox" class="file-checkbox"></th>
                    <td class="telft">
                        <i class="fa-solid \${iconClass}"></i>
                        \${fileContent.fileOrigiNalName}
                    </td>
                    <td>\${fileContent.empName}</td>
                    <td style="display:none;">\${fileContent.fileExt}</td>
                    <td>\${formattedDate}</td>
                    <td>\${fileContent.fileFancysize}</td>
                    <td data-file-original-name="\${fileContent.fileOriginalName}"
                        data-file-save-locate="\${fileContent.fileSaveLocate}"
                        id="down" onclick="download(event)">
                        <i class="fa-solid fa-download"></i>
                    </td>
                </tr>

                `;
            }
         

            // 결과를 HTML 테이블에 추가
            let tbdy = document.querySelector("#tbdy");
            tbdy.innerHTML = str;

            //console.log(str);

            // 페이지 처리 영역 (pagingArea)도 업데이트
            document.getElementById("divPagingArea").innerHTML = response.data.pagingArea;

            //console.log("페이징", response.data.pagingArea);
        })
        .catch(function(error) {
            console.error('Error:', error);  // 에러 로그 출력
        });
    }
    function download(event){
    	//let down = document.querySelector("#down")
    	let down = event.target.closest("td");  // 클릭된 <td> 요소를 찾음
    	let fileSaveLocate = down.dataset.fileSaveLocate;
        //console.log("파일경로",fileSaveLocate)
    	location.href="/download?fileName="+fileSaveLocate;
    	//ㄴlocation.href=fileSaveLocate;
    	
   	return;
    	
    	
    }
    
 // 페이지 링크 클릭 이벤트 처리
    document.addEventListener('click', function() {
        // 클릭된 요소가 .clsPagingArea 클래스를 가진 <a> 태그인 경우
        if (event.target && event.target.classList.contains('clsPagingArea')) {
            // data-current-page와 data-keyword 값 가져오기
            let currentPage = event.target.getAttribute('data-current-page');
            let keyword = event.target.getAttribute('data-keyword');
            
            // 콘솔 로그로 값 확인
            // console.log("currentPage :" + currentPage);
            // console.log("keyword :" + keyword);
            
            // 회원 목록 호출
            getList(currentPage, keyword);
        }
    });

    
    
    function downloadMultiple(event) {
        let filePaths = [];
        
        // 선택된 해당 체크박스들의 경로를 배열에 추가 
        document.querySelectorAll('.file-checkbox:checked').forEach(checkbox => {
            let tr = checkbox.closest("tr"); 
            let td = tr.querySelector('td[data-file-save-locate]');  // data-file-save-locate' 를 찾음
            if (td) {
                let fileSaveLocate = td.dataset.fileSaveLocate;  // 해당 파일 경로
                filePaths.push(fileSaveLocate);  // 배열에 추가
            }
        });
        
        // 파일 선택 안했을시에 alert
        if (filePaths.length === 0) {
            alert("파일을 선택해 주세요.");
            return;
        }
        
        //console.log("선택 파일 :", filePaths);
        
        // 여러 파일 경로를 URL로 전달
        location.href = "/downloadMulti?fileNames=" + encodeURIComponent(filePaths.join(","));
    }


  
  document.addEventListener('DOMContentLoaded', function() {
	    // 탭 클릭 시 동작
	    const navItems = document.querySelectorAll('.nav');
	    navItems.forEach(navItem => {
	        navItem.addEventListener('click', function(e) {
	            e.preventDefault();
	        });
	    });

	    // 탭 클릭 시 활성화 상태 변경 및 콘텐츠 전환
	    const navElements = document.querySelectorAll('.nav');
	    navElements.forEach(navElement => {
	        navElement.addEventListener('click', function() {
	            // 탭 활성화 상태 변경
	            navElements.forEach(item => item.classList.remove('active'));
	            navElement.classList.add('active');

	            // 컨텐츠 전환
	            const navId = navElement.getAttribute('data-nav');  // data-nav 값을 가져옴
	         
	            const files = document.querySelectorAll('.file');
	            files.forEach(file => file.classList.remove('active'));  // 모든 파일을 비활성화
	            const activeFile = document.getElementById(navId);
	           
	            activeFile.classList.add('active');  // 해당 콘텐츠만 활성화
	              
	            const currentPage = 1; 
	            const keyword = '';    
	            const url = navElement.getAttribute('data-url');  // data-url 값
	            getTypeList(url, navId, currentPage, keyword); // 해당 URL로 데이터를 불러오는 함수 호출   
	                
	        });
	    });
  })
  document.addEventListener('DOMContentLoaded', function() {
	    // 탭 클릭 시 동작
	    const tabItems = document.querySelectorAll('.tab');
	    tabItems.forEach(tabItem => {
	        tabItem.addEventListener('click', function(e) {
	            e.preventDefault();
	        });
	    });

	    // 탭 클릭 시 활성화 상태 변경 및 콘텐츠 전환
	    const tabElements = document.querySelectorAll('.tab');
	    tabElements.forEach(tabElement => {
	        tabElement.addEventListener('click', function() {
	            // 탭 활성화 상태 변경
	            tabElements.forEach(item => item.classList.remove('active'));
	            tabElement.classList.add('active');

	            // 컨텐츠 전환
	            const tabId = tabElement.getAttribute('data-tab');  // data-nav 값을 가져옴
	         
	            const files = document.querySelectorAll('.file');
	            files.forEach(file => file.classList.remove('active'));  // 모든 파일을 비활성화
	            const activeFile = document.getElementById(tabId);
	           
	            activeFile.classList.add('active');  // 해당 콘텐츠만 활성화
	            activeFile.classList.add('list');  // 해당 콘텐츠만 활성화
	              
	            const currentPage = 1;  
	            const keyword = '';     
	            const deptNo = tabElement.getAttribute('data-dept-no');  // data-url 값
	            console.log("deptNo",deptNo);
	            getdeptList(deptNo, tabId, currentPage, keyword); // 해당 URL로 데이터를 불러오는 함수 호출   
	                
	        });
	    });
  })
	    function getTypeList(url, navId, currentPage, keyword){
	    	let data = {
	    		     currentPage: currentPage,
	    	         keyword: keyword
	    	}
	    	//console.log("보낼 data 체킁" , data)
	    	console.log("currentPage 체킁" , currentPage)
	    	axios.post(url,data)
	    		.then(function(res){
	    			const activeList = document.getElementById(navId)
	    			const tableBody = activeList.querySelector('table tbody');
					let list = res.data.content;
					let empNO = res.data.empNo;
	    			console.log("데이터 체킁" , list)
	    			console.log("데이터 res.data  체킁" , res.data)
	    			console.log("데이터 res  체킁" ,res)
	    			console.log("데이터 empNO  체킁" ,empNO)
	    			//console.log("res.data 체킁" ,res.data)
	    			 let str = ""; 
	    			 for (let i = 0; i < list.length; i++) {
	    				 let fileList = list[i];
	    				 //console.log("fileList체킁~ " ,fileList)
    	                 let fileSaveDate = new Date(fileList.fileSaveDate);
    	                 let formattedDate = fileSaveDate.toLocaleDateString('ko-KR', { year: 'numeric', month: '2-digit', day: '2-digit' });
					console.log("fileVOList",fileList)
    	              		    // 아이콘 클래스를 확장자에 따라 설정
		                let iconClass = 'fa-file';  // 기본 아이콘
		                //<i class="fa-solid fa-file-excel"></i>
		                // 확장자에 따른 아이콘 변경
		                if (fileList.fileExt === 'xlsx') {
		                    iconClass = 'fa-file-excel';
		                } else if (fileList.fileExt === 'pdf') {
		                    iconClass = 'fa-file-pdf';
		                } else if (fileList.fileExt === 'jpg' || fileList.fileExt === 'jpeg' ||fileList.fileExt === 'jfif'
		                			||fileList.fileExt === 'PNG'||fileList.fileExt === 'JPG') {
		                    iconClass = 'fa-file-image';
		                } else if (fileList.fileExt === 'png') {
		                    iconClass = 'fa-file-image';
		                }else if (fileList.fileExt === 'odt') {
		                    iconClass = 'fa-file-lines';
		                }else if (fileList.fileExt === 'csv') {
		                    iconClass = 'fa-file-csv';
		                }else if (fileList.fileExt === 'zip') {
		                    iconClass = 'fa-file-zipper';
		                }else if (fileList.fileExt === 'txt') {
		                    iconClass = 'fa-align-center';
		                }    
    	              
    	              
    	                 str += `
    	                 	<tr>
    	                     <th scope="row"><input type="checkbox" class="file-checkbox"></th>
    	                     <td class="telft">
    	                     <i class="fa-solid \${iconClass}"></i>
    	                         \${fileList.fileOrigiNalName}
    	                     </td>
    	                     <td> \${fileList.empName}</td>
    	                     <td style="display:none;">\${fileList.fileExt}</td>
    	                     <td>\${formattedDate}</td>
    	                     <td>\${fileList.fileFancysize}</td>
    	                     <td data-file-original-name="\${fileList.fileOrigiNalName}"
    	                         data-file-save-locate="\${fileList.fileSaveLocate}"
    	                         id="down" onclick="download(event)">
    	                         <i class="fa-solid fa-download"></i>
    	                     </td>
    	                     
    	                 </tr>

    	                 `; 
	    			 }
	    			 
	    			 tableBody.innerHTML = str
	    			 
	    			 
	    			 let div = document.getElementById("divPagingArea2");
	    			 
	    			 
	    			 div.innerHTML = res.data.pagingArea;
	    			 
	    			 // 페이징 처리 함수 넘겨주기 
	    			 paging(url, navId, currentPage, keyword);
	    		})
				.catch(function(error){
					console.err("타입별 리스트 불러오기 실패",error);
					
				})    	
	    	
	    }

  function getdeptList(deptNo,tabId, currentPage, keyword){
  	let data = {
  		     currentPage: currentPage,
  	         keyword: keyword
  	}
  	//console.log("보낼 data 체킁" , data)
  	console.log("currentPage 체킁" , currentPage)
  	let url = "/file/deptListAxios"
  	axios.post(url,data)
  		.then(function(res){
  			console.log("res 넘어왔냐 " , res)
  			console.log("res 넘어왔냐 " , res.data.content)
  			const activeList = document.getElementById(tabId)
  			const tableBody = activeList.querySelector('#tbdy');
  			const errorBox = document.querySelector("#mgHiphap")
  			console.log("체로롱2" , tabId)
  			console.log("tableBody",tableBody)
				let list = res.data.content;
				let empNo = list.empNo;
				let fileTab  = document.querySelector(".file.active > .errorBox")
				console.log("뜨나",fileTab)
  			//console.log("res.data 체킁" ,res.data)
  			 let str = "";
  			
  				 let str2 = "";
				console.log( "jsp내 deptNo"+ deptNo)
  			 for (let i = 0; i < list.length; i++) {
  				 
  				 let fileList = list[i];
				let deptNo2 = fileList.deptNo;
				console.log("controller에서 넘어온 deptNo",deptNo2 )
  			
	  			if(deptNo == deptNo2){
  				fileTab.style.display='none'
			
	  				 //alert("같당");
  				 //console.log("fileList체킁~ " ,fileList)
	                  let fileSaveDate = new Date(fileList.fileSaveDate);
	                 let formattedDate = fileSaveDate.toLocaleDateString('ko-KR', { year: 'numeric', month: '2-digit', day: '2-digit' }); 
				console.log("fileVOList왜안떠",fileList.fileExt)
				console.log("list[i]왜안떠",list[i])
	              		    // 아이콘 클래스를 확장자에 따라 설정
	               let iconClass = 'fa-file';  // 기본 아이콘
	                //<i class="fa-solid fa-file-excel"></i>
	                // 확장자에 따른 아이콘 변경
	                if (fileList.fileExt === 'xlsx') {
	                    iconClass = 'fa-file-excel';
	                } else if (fileList.fileExt === 'pdf') {
	                    iconClass = 'fa-file-pdf';
	                } else if (fileList.fileExt === 'jpg' || fileList.fileExt === 'jpeg' ||fileList.fileExt === 'jfif'
	                			||fileList.fileExt === 'PNG'||fileList.fileExt === 'JPG') {
	                    iconClass = 'fa-file-image';
	                } else if (fileList.fileExt === 'png') {
	                    iconClass = 'fa-file-image';
	                }else if (fileList.fileExt === 'odt') {
	                    iconClass = 'fa-file-lines';
	                }else if (fileList.fileExt === 'csv') {
	                    iconClass = 'fa-file-csv';
	                }else if (fileList.fileExt === 'zip') {
	                    iconClass = 'fa-file-zipper';
	                }else if (fileList.fileExt === 'txt') {
	                    iconClass = 'fa-align-center';
	                }    
	                 str += `
	                 	<tr>
	                     <th scope="row"><input type="checkbox" class="file-checkbox"></th>
	                     <td class="telft">
	                     <i class="fa-solid \${iconClass}"></i>
	                         \${fileList.fileOrigiNalName}
	                     </td>
	                     <td>\${fileList.empName}</td>
	                     <td style="display:none;">${fileList.fileExt}</td>
	                     <td>\${formattedDate}</td>
	                     <td>\${fileList.fileFancysize}</td>
	                     <td data-file-original-name="\${fileList.fileOrigiNalName}"
	                         data-file-save-locate="\${fileList.fileSaveLocate}"
	                         id="down" onclick="download(event)">
	                         <i class="fa-solid fa-download"></i>
	                     </td>
	                     
	                 </tr>

	                 `;  
  			 }else{
  				//alert("같지 않당")
  				 //alert("FEfeefe")
  				 break;
  				 
  				 
  			 }
  			}
  			 
  			console.log("체로롱",errorBox);
  			console.log("체로롱",str2);
  			
  			tableBody.innerHTML = str 
  			 
  			/* let div = document.getElementById("divPagingArea2");
  			 
  			 
  			 div.innerHTML = res.data.pagingArea;
  			 
  			 // 페이징 처리 함수 넘겨주기 
  			 paging(url, navId, currentPage, keyword);
  	*/	})
  		 .catch(error => {
	            console.error("데이터 로딩 실패", error);
	        });   	
  	
  }
  		// 첫번쨰 페이징 박스 id를 구분짓기위해...
		let div2 = document.getElementById("divPagingArea2");
	 
  		// 비동기 페이징박스 링크 클릭 이벤트 처리
		function paging(url, navId, currentPage, keyword){
			  
			  
		  div2.addEventListener('click', function() {
		      // 클릭된 요소가 .clsPagingArea 클래스를 가진 <a> 태그인 경우
		      if (event.target && event.target.classList.contains('clsPagingArea')) {
		          // data-current-page와 data-keyword 값 가져오기
		          let currentPage = event.target.getAttribute('data-current-page');
		          let keyword = event.target.getAttribute('data-keyword');
		          
		          // 콘솔 로그로 값 확인
		          // console.log("currentPage :" + currentPage);
		          // console.log("keyword :" + keyword);
				 
		          // 해당 페이지의 리스트 불러오기		          
		         getTypeList(url, navId, currentPage, keyword)
		      }
		  });
	  }

	    // 스크롤 버튼 클릭 시 스크롤 이동
	    const scrollBtns = document.querySelectorAll('.sBtn');
	    scrollBtns.forEach(scrollBtn => {
	        scrollBtn.addEventListener('click', function(e) {
	            e.preventDefault();
	            const target = document.querySelector(scrollBtn.getAttribute('href'));
	            window.scrollTo({
	                top: target.offsetTop,
	                behavior: 'smooth'
	            });
	        });
	    });

</script>
<script src="/dash/js/main.js"></script>
<script type="text/javascript" src="/dash/lib/chart/chart.min.js"></script>
<script type="text/javascript" src="/js/jquery-3.6.0.js"></script>

<!-- 메인 컨텐츠 영역 끝 -->