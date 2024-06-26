<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script src="https://kit.fontawesome.com/99823c8069.js" crossorigin="anonymous"></script>

<%
String ctx = request.getContextPath();
%>

<style>

.boardList {
	background: #fffbec;

}

</style>

    <section class="section--padding2 boardList">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <div class="">
                        <div class="modules__content">
                            <div class="withdraw_module withdraw_history boardList">
                                <div class="withdraw_table_header">
                                    <h3>공지사항</h3>
                                    <br>
                                    <h6>총 ${listSize }개의 글이 있습니다.</h6>
                                </div>
                                <div class="table-responsive">
                                    <table class="table withdraw__table">
                                        <thead>
                                            <tr>
                                            	<th>No</th>
                                                <th>제목</th>
                                                <th>Date</th>
                                                <th>조회수</th>
                                                <th>작성자</th>
                                            </tr>
                                        </thead>

                                        <tbody>
                                        <c:forEach var="item" items="${list}">
                                        	<tr>
                                        		<td>${item.boardSeq }</td>
                                        		<td>
<%--                                         		<a href="<c:url value='/forum/notice/readPage.do?boardSeq=${item.boardSeq }&boardTypeSeq=${item.boardTypeSeq }&page=${ph.page }&size=${ph.size }&keyword=${ph.sc.keyword}&value=${ph.sc.value }'/>"> --%>
                                        		<a href="<c:url value='/forum/notice/readPage.do${ph.makeQueryString() }&boardSeq=${item.boardSeq }&boardTypeSeq=${item.boardTypeSeq }'/>">
                                        		${item.title } [${item.boardCommentCnt }]
                                        		<c:if test="${item.attFileCnt > 0}">
                                        			<i class="fas fa-solid fa-paperclip"></i>
                                        		</c:if>
                                        		</a></td>
                                        		<td>${item.regDtm }</td>
                                        		<td>${item.hit }</td>
                                        		<td>${item.regMemberId }</td>
                                        	</tr>
                                        </c:forEach>
                                        </tbody>
                                    </table>
                                    <div style="display: inline-block; margin: 0 5px; float: right; padding-right:10px;">
		                                <a href="<c:url value='/forum/notice/writePage.do'/>">
		                                	<button class="btn btn--round btn--bordered btn-sm btn-secondary">작성</button>
		                                </a>
		                            </div>
                                    <div class="pagination-area" style="padding-top: 45px;">
				                        <nav class="navigation pagination" role="navigation">
				                            <div class="nav-links">
				                              <c:if test="${ph.startPage ne 1 }">
													<a class="prev page-numbers boardList" href="<c:url value='/forum/notice/listPage.do?page=${ph.startPage-1 }&size=${ph.size }&keyword=${ph.sc.keyword }&value=${ph.sc.value }'/>">
					                                    <span class="lnr lnr-arrow-left"></span>
					                                </a>
												</c:if>
												<c:forEach var="i" begin="${ph.startPage }" end="${ph.endPage }">
													<a class="page-numbers pages boardList" href="<c:url value='/forum/notice/listPage.do?page=${i }&size=${ph.size }&keyword=${ph.sc.keyword }&value=${ph.sc.value }'/>">${i }</a>
												</c:forEach>
				                                <c:if test="${ph.endPage ne ph.totalPage }">
													<a class="next page-numbers boardList" href="<c:url value='/forum/notice/listPage.do?page=${ph.endPage+1 }&size=${ph.size }&keyword=${ph.sc.keyword }&value=${ph.sc.value }'/>">
					                                    <span class="lnr lnr-arrow-right"></span>
					                                </a>
												</c:if>
				                            </div>
				                        </nav>
				                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- end .col-md-6 -->
            </div>
            <!-- end .row -->
            
           <!-- start .search_box -->
           <div class="search_box boardList">
               <form action="<c:url value='/forum/notice/listPage.do'/>" method="get">
                   <input type="text" class="text_field" name="value" placeholder="검색 키워드를 입력해주세요." required value="${ph.sc.value }" >
                   <div class="search__select select-wrap">
                       <select name="keyword" class="select--field" id="blah">
                           <option value="writer">작성자</option>
                           <option value="content">내용</option>
                           <option value="title">제목</option>
                           <option value="all">전체</option>
                       </select>
                       <span class="lnr lnr-chevron-down"></span>
                   </div>
                   <button type="submit" class="search-btn btn--lg">검색</button>
               </form>
           </div>
           <!-- end ./search_box -->
            
        </div>
        <!-- end .container -->
    </section>
    <script>    
    let msg = '${msgObject.msg}'
    let code = '${msgObject.code}'
    let currPage = '${pageContext.request.getParameter("page")}'
    let keyword = '${sc.keyword}'
    
    
    if(msg!=''){
   		console.log(code)
   		alert(msg)
    }
    
   	//해당 페이지 색깔 표시하기
   	let pageNavi = document.querySelectorAll('a.pages')
   	pageNavi.forEach(function(elem) {
   		if(elem.innerText == currPage) {
   			elem.style.background = '#0674ec'
   			elem.style.color = '#fff'
   		}
   	})
   	
   	//검색창에 검색 키워드 유지하기
   	let options = document.querySelectorAll('option')
   	options.forEach(function(elem) {
   		if(elem.value == keyword) {
   			elem.selected = true
   		}
   	})
   


    window.onload = function(){
   	
    }
    
    

    </script>
   
