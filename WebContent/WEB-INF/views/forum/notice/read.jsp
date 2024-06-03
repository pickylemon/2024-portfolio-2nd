<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
String ctx = request.getContextPath();
%>
	<link rel="stylesheet" href="<%=ctx%>/assest/template/css/trumbowyg.min.css">
    <script src="<%=ctx%>/assest/template/js/vendor/trumbowyg.min.js"></script>
    <script src="<%=ctx%>/assest/template/js/vendor/trumbowyg/ko.js"></script>

    <!--================================
            START DASHBOARD AREA
    =================================-->
    <section class="support_threads_area section--padding2">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="forum_detail_area ">
                        <div class="cardify forum--issue">
                            <div class="title_vote clearfix">
                                <h3>${boardDto.title }</h3>

                                <div class="vote">
                                    <a href="#">
                                        <span class="lnr lnr-thumbs-up"></span>
                                    </a>
                                    <a href="#">
                                        <span class="lnr lnr-thumbs-down"></span>
                                    </a>
                                </div>
                                <!-- end .vote -->
                            </div>
                            <!-- end .title_vote -->
                            <div class="suppot_query_tag">
                                <img class="poster_avatar" src="<%=ctx%>/assest/template/images/support_avat1.png" alt="Support Avatar"> ${boardDto.regMemberId }
                                <span>${boardDto.regDtm }</span>
                            </div>
                            <p style="    margin-bottom: 0; margin-top: 19px;">
                            	${boardDto.content }</p>
                             <br/><br/><br/>
                            <c:if test="${attFileList.size() != 0}">
	                            <c:forEach items="${attFileList }" var="attFile">
	                            	<a href="<%=ctx%>/forum/notice/download.do?attachSeq=${attFile.attachSeq}">다운로드 : ${attFile.orgFileNm } (${attFile.fileSize } bytes) [다운로드 횟수 : ${attFile.downloadCnt } ]</a>
	                            	<br>
	                            </c:forEach>
	                            <br>
	                            <br>
                            </c:if>
                            
                            <!-- 첨부된 파일이 2개 이상일때만 전체 압축해서 다운로드 받을 수 있음 -->
                            <c:if test="${attFileList.size() > 1}">
                            	<a href="<%=ctx%>/forum/notice/${boardDto.boardTypeSeq }/${boardDto.boardSeq }/download.do">파일 전체 다운로드</a>
                            	<br>
                            </c:if>
                            
                            <!-- 수정하기, 삭제하기 버튼은 본인일때만 보여야 하는 버튼 -->
                            <c:if test='${sessionScope.memberSeq eq boardDto.regMemberSeq }'>
                            	<a href="<c:url value='/forum/notice/${boardDto.boardTypeSeq }/${boardDto.boardSeq }/modifyPage.do'/>" id="modBtn" >글 수정하기</a><br>
                            	<a href="#" id="delBtn" onclick="javascript:deletePage()">글 삭제하기</a><br>
                            </c:if>
                        </div>
                        <!-- end .forum_issue -->


                        <div class="forum--replays cardify">
                            <div class="area_title">
                                <h4>${comments.size()} Replies</h4>
                            </div>
                            <!-- end .area_title -->

                            <div class="forum_single_reply">
                                <div class="reply_content">
                                    <div class="name_vote">
                                        <div class="pull-left">
                                            <h4>AazzTech
                                                <span>staff</span>
                                            </h4>
                                            <p>Answered 3 days ago</p>
                                        </div>
                                        <!-- end .pull-left -->

                                        <div class="vote">
                                            <a href="#" class="active">
                                                <span class="lnr lnr-thumbs-up"></span>
                                            </a>
                                            <a href="#" class="">
                                                <span class="lnr lnr-thumbs-down"></span>
                                            </a>
                                        </div>
                                    </div>
                                    <!-- end .vote -->
                                    <p>Nunc placerat mi id nisi interdum mollis. Praesent pharetra, justo ut sceleris que the
                                        mattis, leo quam aliquet congue placerat mi id nisi interdum mollis. </p>
                                </div>
                                <!-- end .reply_content -->
                            </div>
                            <!-- end .forum_single_reply -->

                            <div class="comment-form-area">
                                <h4>Leave a comment</h4>
                                <!-- comment reply -->
                                <div class="media comment-form support__comment">
                                    <div class="media-left">
                                        <a href="#">
                                            <img class="media-object" src="<%=ctx%>/assest/template/images/m7.png" alt="Commentator Avatar">
                                        </a>
                                    </div>
                                    <div class="media-body">
                                        <form action="#" class="comment-reply-form">
                                            <div id="trumbowyg-demo"></div>
                                            <button class="btn btn--sm btn--round">Post Comment</button>
                                        </form>
                                    </div>
                                </div>
                                <!-- comment reply -->
                            </div>
                        </div>
                        <!-- end .forum_replays -->
                    </div>
                    <!-- end .forum_detail_area -->
                </div>
                <!-- end .col-md-12 -->            
            </div>
            <!-- end .row -->
        </div>
        <!-- end .container -->
    </section>
     <script type="text/javascript">
	    $('#trumbowyg-demo').trumbowyg({
	        lang: 'kr'
	    });
	    
	    

	    function deletePage(){
	    	if(!confirm("게시글을 정말로 삭제하시겠습니까?")) {
	    		return;
	    	}
	    	
	    	let url = '<%=ctx%>/forum/notice/'+${boardDto.boardTypeSeq}
	    	url += '/'+ ${boardDto.boardSeq} +'/deletePage.do'
	    	
	    	$.ajax({    
	    		type : 'delete',           
	    		// 타입 (get, post, put 등등)    
	    		url : url,
	    		// 요청할 서버url
	    		async : true,
	    		// 비동기화 여부 (default : true)
	    		headers : {
	    			// Http header
// 	    			"Content-Type" : "application/json",
// 	    			"accept" : "application/json"
	    		},
	    		dataType : 'text',
	    		success : function(result) {
	    			// 결과 성공 콜백함수 
	    			//alert('성공')
	    			//console.log(result);
	    			console.log(result)
	    			alert(result)
    				location.href='<%=ctx%>/forum/notice/listPage.do'

	    		},
	    		error : function(result) {
	    			// 결과 에러 콜백함수
	    			console.log(result)
	    			console.log(result.responseText)
	    			alert(result.responseText)
// 	    			console.log(error)
	    		}
	    	});
	    }
	</script>
    <!--================================
            END DASHBOARD AREA
    =================================-->
	