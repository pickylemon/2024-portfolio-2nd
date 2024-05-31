<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
String ctx = request.getContextPath();
%>
    <section class="section--padding2">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <div class="">
                        <div class="modules__content">
                            <div class="withdraw_module withdraw_history">
                                <div class="withdraw_table_header">
                                    <h3>공지사항</h3>
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
                                        		<a href="<c:url value='/forum/notice/readPage.do?boardSeq=${item.boardSeq }&boardTypeSeq=${item.boardTypeSeq }'/>">
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
													<a class="prev page-numbers" href="<c:url value='/forum/notice/listPage.do?page=${ph.startPage-1 }&size=${ph.pageSize }'/>">
					                                    <span class="lnr lnr-arrow-left"></span>
					                                </a>
												</c:if>
												<c:forEach var="i" begin="${ph.startPage }" end="${ph.endPage }">
													<a class="page-numbers" href="<c:url value='/forum/notice/listPage.do?page=${i }&size=${ph.pageSize }'/>">${i }</a>
												</c:forEach>
				                                <c:if test="${ph.endPage ne ph.totalPage }">
													<a class="next page-numbers" href="<c:url value='/forum/notice/listPage.do?page=${ph.endPage+1 }&size=${ph.pageSize }'/>">
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
        </div>
        <!-- end .container -->
    </section>
    <script>
//     let code = '${code}'
//     let msg = '${msg}'
//     window.onload = function(){
//        	if(msg!=''){
//        		alert(msg)
//        		console.log(code)
//        	}
//     }
    
    let msg = '${msgObject.msg}'
    let code = '${msgObject.code}'

    window.onload = function(){
	   	if(msg!=''){
	   		console.log(code)
	   		alert(msg)
	   	}
    }
        
    </script>
   
