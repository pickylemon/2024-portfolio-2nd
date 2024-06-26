<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
String ctx = request.getContextPath();
%>
<link rel="stylesheet" href="<%=ctx%>/assest/template/css/trumbowyg.min.css">
<script src="<%=ctx%>/assest/js/page.js"></script>
<script src="<%=ctx%>/assest/template/js/vendor/jquery/jquery-1.12.3.js"></script>
<script src="<%=ctx%>/assest/template/js/vendor/trumbowyg.min.js"></script>
<script src="<%=ctx%>/assest/template/js/vendor/trumbowyg/ko.js"></script>
<!-- <script src="https://kit.fontawesome.com/a26f9e7c74.js" crossorigin="anonymous"></script> -->


<style>
    .reply_content {
    	width: 100%;
    }
    .name_vote {
    	width: 100%;
    }
    .pull-left{
    	width: 100%;
    }
    .inner {
    	display: flex;
    	justify-content: space-between; 
    	align-items: center;
    	width: 100%;
    }
    .dateVoteStat, .regDtmVote {
    	margin-top: 5px;
    	display: flex;
    	justify-content: space-between; 
    	align-items: center;
    	width: 100%;
    }
    
    .voteStat .total {
	    border: 0px;
	    color: #fff;
	    background: #6fa9e9;
	    font-weight: 400;
	    font-size: 14px;
	    line-height: 24px;
	    display: inline-block;
	    padding: 0 10px;
	    border-radius: 4px;
    
    }
    
    .delModBtnGrp button {
    	border: 0px;
   	    color: #fff;
	    background: #6fa9e9;
	    font-weight: 400;
	    font-size: 14px;
	    line-height: 24px;
	    display: inline-block;
	    padding: 0 10px;
 	    -webkit-border-radius: 100px; 
	    border-radius: 100px; 
    }
    div.contentBtn.hiddenComment {
    	display : none;
    }
    
    .comment-form-area.edit .comment-reply-form button.edit, 
    .comment-form-area.edit .comment-reply-form button.cancel {
    	color: #fff;
	    background: #6fa9e9;
    }
    .contentBtn .commentContent .mention {
    	border: 0px;
   	    color: #343a40;
	    background: #EEF2F8;
	    font-weight: 400;
	    font-size: 14px;
	    line-height: 24px;
	    display: inline-block;
	    padding: 0 8px;
    }
    
    
    .cardify.forum--issue, forum--replays cardify {
    	background: #fffbec;
    
    }
</style>    
    
    

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
                                    <a href="#" id="cThumbUpAnchor" data-thumb=true class="${boardDto.isLike eq 'Y'? 'active':'' }" onclick="javascript:thumbClick(${boardDto.boardSeq }, ${boardDto.boardTypeSeq }, this);">
                                        <span class="lnr lnr-thumbs-up"></span>
                                    </a>
                                    <a href="#" id="cThumbDownAnchor" data-thumb=false class="${boardDto.isLike eq 'N'? 'active':'' }" onclick="javascript:thumbClick(${boardDto.boardSeq }, ${boardDto.boardTypeSeq }, this);">
                                        <span class="lnr lnr-thumbs-down"></span>
                                    </a>
                                </div>
                                <!-- end .vote -->
                            </div>
                            <!-- end .title_vote -->
             				<div class="regDtmVote">
	                            <div class="suppot_query_tag">
	                                <img class="poster_avatar" src="<%=ctx%>/assest/template/images/support_avat1.png" alt="Support Avatar"> ${boardDto.regMemberId }
	                                <span>${boardDto.regDtm }</span>
	                            </div>
	                            <div class="voteStat">
	                                <div class="total">like : <span class="voteSum true">${boardDto.likeTotal}</span> </div> 
	                                <div class="total">unlike: <span class="voteSum false">${boardDto.unlikeTotal}</span></div>
	                        	</div>
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
                            <br><br>
                            <!-- 수정하기, 삭제하기 버튼은 본인일때만 보여야 하는 버튼 -->
                            <c:if test='${sessionScope.memberSeq eq boardDto.regMemberSeq }'>
                            	<button class="btn btn--sm btn--round" id="modBtn" onclick="location.href='<c:url value='/forum/notice/${boardDto.boardTypeSeq }/${boardDto.boardSeq }/modifyPage.do'/>';">글 수정하기</button>
                            	<button class="btn btn--sm btn--round" id="delBtn" onclick="javascript:deletePage()">글 삭제하기</button>
<%--                             	<button class="btn btn--sm btn--round" id="listBtn" onclick="location.href='<c:url value='/forum/notice/listPage.do?page=${ph.page }&size=${ph.size }&keyword=${ph.sc.keyword}&value=${ph.sc.value}'/>';">목록으로</button> --%>
<%--                             	<a href="<c:url value='/forum/notice/${boardDto.boardTypeSeq }/${boardDto.boardSeq }/modifyPage.do'/>" id="modBtn" >글 수정하기</a><br> --%>
<!--                             	<a href="#" id="delBtn" onclick="javascript:deletePage()">글 삭제하기</a><br> -->
                            </c:if>
                            	<button class="btn btn--sm btn--round" id="listBtn" onclick="location.href='<c:url value='/forum/notice/listPage.do${ph.makeQueryString() }'/>';">목록으로</button>
                        </div>
                        <!-- end .forum_issue -->


                        <div class="forum--replays cardify">
                            <div class="area_title">
                                <h4>${commentCnt} Replies</h4>
                            </div>
                            <c:forEach var="comment" items="${comments }">
                            	<div class="forum_single_reply" data-commentSeq="${comment.commentSeq }">
                            	<!-- commentDto의 lvl을 활용해 패딩값을 조절해서 댓글 계층구조를 시각적으로 드러내기 -->
<%-- 	                                <div class="reply_content" style="padding-left: ${18 + 30*comment.lvl}px"> --%>
	                                <div class="reply_content" style="padding-left: ${comment.lvl eq 0? 18 : 50}px">
	                                    <div class="name_vote">
	                                        <div class="pull-left">
	                                        	<div class="inner">
		                                        	<h4>${comment.deleteDtm eq null ? comment.regMemberNm : '' }
<!-- 		                                                <span>staff</span> -->
		                                            </h4>
		                                            <c:if test="${comment.deleteDtm eq null }">
		                                            <div class="reply vote">
			                                            <a href="#" class="reply ${comment.isLike eq 'Y'? 'active': ''}" data-thumb=true onclick="javascript:replyThumbClick(${comment.commentSeq}, this)">
			                                                <span class="lnr lnr-thumbs-up"></span>
			                                            </a>
			                                            <a href="#" class="reply ${comment.isLike eq 'N'? 'active': ''}" data-thumb=false onclick="javascript:replyThumbClick(${comment.commentSeq}, this)">
			                                                <span class="lnr lnr-thumbs-down"></span>
			                                            </a>
		                                        	</div>
		                                            </c:if>
	                                        	</div>
	                                        	<div class="dateVoteStat">
	                                        		<p>${comment.deleteDtm eq null ? comment.regDtm : '' }</p>
	                                        		<c:if test="${comment.deleteDtm eq null }">
	                                        		<div class="voteStat">
			                                            <div class="total">like : <span class="voteSum true"> ${comment.likeTotal} </span></div> 
			                                            <div class="total">unlike: <span class="voteSum false"> ${comment.unlikeTotal} </span></div>
		                                            </div>
	                                        		</c:if>
	                                        	</div>
	                                            
	                                        </div>
	                                        <!-- end .pull-left -->
	
	                                    </div>
	                                    <!-- end .vote -->  
	                                    <!-- 대댓글의 경우(lvl이 0이 아님) 대댓글 마크 표현 -->
	                                    <div class="contentBtn">
	                                    	<p> 
<%-- 	                                    		<div>[self : ${comment.commentSeq}] [parent : ${comment.parentCommentSeq}]</div> --%>
	                                    		<div class="commentContent">
	                                    		<c:if test="${comment.mentionMemberNm ne null && comment.deleteDtm eq null}">
	                                    			<span class="mention">@${comment.mentionMemberNm}</span>
	                                    			
	                                    		</c:if> 
	                                    		<c:choose>
	                                    			<c:when test="${comment.deleteDtm eq null }">
	                                    			<span class="commentContent">${comment.content }</span>
	                                    			</c:when>
	                                    			<c:otherwise>
	                                    			<span>삭제된 댓글입니다.</span>
	                                    			</c:otherwise>
	                                    		</c:choose>
	                                    		</div>
	                                    	</p>
	                                    	<div class="delModBtnGrp">
	                                    	 <!-- 댓글 수정 삭제 버튼은 작성자에게만 보인다. -->
	                                    	<c:if test="${sessionScope.memberSeq eq comment.regMemberSeq && comment.deleteDtm eq null}">
	                                    		<button type="button" class="modBtn" onclick="javascript:openModifyWindow(this)">댓글 수정</button>
	                                    		<button type="button" class="delBtn" onclick="javascript:deleteComment(${boardDto.boardTypeSeq}, ${boardDto.boardSeq }, this)">댓글 삭제</button>
                                    		</c:if>
                                    		<c:if test="${comment.deleteDtm eq null }">
                                    		   	<button type="button" class="replyBtn" 
                                    			data-commentSeq="${comment.commentSeq}" data-commentLvl="${comment.lvl}"
                                    			data-parentCommentSeq="${comment.parentCommentSeq}" 
                                    			data-mentionMemberSeq="${comment.regMemberSeq }"
                                    			onclick="javascript:openReplyWindow(this)">답글</button>
                                    		</c:if>

	                                    	</div>
	                                    </div>
	                                </div>
	                                <!-- end .reply_content -->
                            	</div>
                            <!-- end .forum_single_reply -->
                            </c:forEach>

							<!-- 댓글 및 대댓글 등록 창 -->
                            <div class="comment-form-area reply">
                                <h4>Leave a comment</h4>
                                <!-- comment reply -->
                                <div class="media comment-form support__comment">
                                    <div class="media-left">
                                        <a href="#">
										<img class="media-object" src="<%=ctx%>/assest/template/images/lemon.png" alt="Commentator Avatar" width="70px" height="70px">                                        
										</a>
                                    </div>
	                                   <div class="media-body">
	                                       <form class="comment-reply-form">
<!-- 	                                           <div id="trumbowyg-demo"></div> -->
	                                           <div id="content"></div>
	                                           <!-- 댓글 및 대댓글 등록 버튼 -->
	                                           <button type="button" onclick="javascript:addComment(${boardDto.boardTypeSeq}, ${boardDto.boardSeq}, this)" class="btn btn--sm btn--round submit">Post Comment</button>
	                                           <button type="button" onclick="location.href='<%=ctx %>/forum/notice/readPage.do?boardSeq=${boardDto.boardSeq }&boardTypeSeq=${boardDto.boardTypeSeq }'"  class="btn btn--sm btn--round">Cancel</button>
	                                       </form>
	                                   </div>
                                </div>
                                <!-- comment reply -->
                            </div>
                            
                            <!-- 댓글 수정 창 -->
                            <div class="comment-form-area edit" style="display:none">
                                <h4>Edit your comment</h4>
                                <!-- comment reply -->
                                <div class="media comment-form support__comment">
                                    <div class="media-left">
                                        <a href="#">
                                            <img class="media-object" src="<%=ctx%>/assest/template/images/lemon.png"  alt="Commentator Avatar" width="70px" height="70px">
                                        </a>
                                    </div>
                                    <div class="media-body">
                                    	<div class="comment-reply-form">
                                        	<div id="comment-edit"></div>
                                        	<button type="button" onclick="javascript:modifyComment(${boardDto.boardTypeSeq}, ${boardDto.boardSeq }, this)" class="btn btn--sm btn--round edit">Edit Comment</button>
                                            <button type="button" 
                                           		onclick="location.href='<%=ctx %>/forum/notice/readPage.do?boardSeq=${boardDto.boardSeq }&boardTypeSeq=${boardDto.boardTypeSeq }'" 
                                           		class="btn btn--sm btn--round cancel">Cancel</button>
                                        </div>
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

//게시글 삭제, 좋아요/싫어요 함수

   	//게시글 삭제 메서드
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
	    
    //게시글에 대한 좋아요/싫어요 투표
    function thumbClick(boardSeq, boardTypeSeq, elem) {
//     	alert('clicked!');
    	
//     	let voteDiv = elem.closest('div.vote');
    	let voteDiv = elem.closest('div.cardify');
    	console.log(boardSeq);
    	console.log(boardTypeSeq);
    	
    	console.log(voteDiv)
    	
    	let url = '<%=ctx%>/forum/notice/'
    	url += boardTypeSeq + '/'
    	url += boardSeq +'/'
    	url += 'vote.do'
    	url += '?thumb=' + elem.getAttribute("data-thumb")
    		
    			
    	$.ajax({    
    		type : 'get',           
    		// 타입 (get, post, put 등등)    
    		url : url,
    		// 요청할 서버url
    		async : true,
    		// 비동기화 여부 (default : true)
    		headers : {
    			// Http header
//     			"Content-Type" : "application/json",
    			"accept" : "application/json"
    		},
    		dataType : 'json',
    		success : function(result) {
    			// 결과 성공 콜백함수 
    			console.dir(result)
    			
    			if(result.code == 0) { //이전 투표 결과가 없는 경우.
    				voteDiv.querySelector("a[data-thumb="+result.thumb+"]").classList.add('active')

    				//카운트 반영
    				let voteSum = voteDiv.querySelector("span.voteSum."+result.thumb)
    				voteSum.innerText = parseInt(voteSum.innerText) + 1
    				
    			} else if (result.code == 1) { //이전 투표결과를 취소
    				voteDiv.querySelector("a[data-thumb="+result.thumb+"]").classList.remove('active')

    				//카운트 반영
    				let voteSum = voteDiv.querySelector("span.voteSum."+result.thumb)
    				voteSum.innerText = parseInt(voteSum.innerText) - 1
    			} else { //이전 투표결과를 반대로 
    				voteDiv.querySelector("a[data-thumb="+!result.thumb+"]").classList.remove('active')
    				voteDiv.querySelector("a[data-thumb="+result.thumb+"]").classList.add('active')

    				//카운트 반영
    				let voteSum1 = voteDiv.querySelector("span.voteSum."+result.thumb)
    				let voteSum2 = voteDiv.querySelector("span.voteSum."+!result.thumb)
    				voteSum1.innerText = parseInt(voteSum1.innerText) + 1
    				voteSum2.innerText = parseInt(voteSum2.innerText) - 1

    			}

    		},
    		error : function(request, status, error) {
    			// 결과 에러 콜백함수
    			alert('투표 결과 반영에 실패했습니다.');
    			console.log(error)
    		}
    	});
    }	    
    
    
    
//댓글 등록, 수정, 삭제, 좋아요/싫어요 함수    
     	
	    //어차피 서버에서의 댓글 등록 로직은 같으므로 (댓글과 대댓글의 구분이 없다. 그냥 댓글을 DB에 insert하는 것)
	    //프론트에서도 댓글(parentSeq=null, lvl=0)과 대댓글(parentSeq!=null, lvl>0)을 모두 보낼 수 있게
	    //보내는 data(commentDto)의 스펙을 변경함(즉, parentCommentSeq와 lvl을 추가)
	    function addComment(boardTypeSeq, boardSeq, elem){
	    	let commentDto = {
    			boardTypeSeq: boardTypeSeq,
    			boardSeq: boardSeq,
//     			content: $('#trumbowyg-demo').trumbowyg('html'),
    			content: $('#content').trumbowyg('html'),
    			parentCommentSeq : elem.getAttribute("data-parentCommentSeq"),
    			lvl: elem.getAttribute("data-commentLvl") == null ? 0 : elem.getAttribute("data-commentLvl"),
    			mentionMemberSeq: elem.getAttribute("data-mentionMemberSeq")
	    	};
	    	console.log(commentDto);
	    	
	    	$.ajax({    
	    		type : 'post',           
	    		url : '<%=ctx%>/forum/notice/addComment.do',
    		async : true,
    		// 비동기화 여부 (default : true)
    		headers : {
    			// Http header
	    			"Content-Type" : "application/json"
    		},
    		dataType : 'text',
			data: JSON.stringify(commentDto),
    		success : function(result) {
    			// 결과 성공 콜백함수 
    			
    			//타인이 내 게시글에 댓글을 달면, 알림이 온다. (내가 내 게시글에 단 댓글은 알림x)
    			if(${sessionScope.memberSeq ne boardDto.regMemberSeq }){
        			let msg = {
        					commenterSeq : ${sessionScope.memberSeq},
        					writerSeq : ${boardDto.regMemberSeq},
        					boardSeq : ${boardDto.boardSeq},
        					boardTypeSeq : ${boardDto.boardTypeSeq}
        					
        			}
        			console.log(socket)
        			socket.send(JSON.stringify(msg))
    			}
    			

    			console.log(result)
    			alert(result)
   				location.href='<%=ctx%>/forum/notice/readPage.do?boardSeq='+boardSeq+'&boardTypeSeq='+boardTypeSeq

    		},
    		error : function(result) {
    			// 결과 에러 콜백함수
    			console.log(result)
    			console.log(result.responseText)
    			alert(result.responseText)
    			console.log(error)
    		}
    	});
    }
	    
    //댓글 삭제하기
    function deleteComment(boardTypeSeq, boardSeq, elem){
    	if(!confirm('댓글을 정말 삭제하시겠습니까?')){
    		return;
    	}
    	
    	let comment = elem.closest('div.forum_single_reply');
    
    	console.log("commentSeq = " + comment.getAttribute("data-commentSeq"))
    	url = '<%=ctx%>/forum/notice/'
    	url += comment.getAttribute('data-commentSeq')+'/deleteComment.do'
    	
    	$.ajax({    
    		type : 'delete',           
    		url : url,
    		async : true,
    		// 비동기화 여부 (default : true)
    		dataType : 'text',
    		success : function(result) {

    			// 결과 성공 콜백함수 
    			console.log(result)
    			alert(result)
   				location.href='<%=ctx%>/forum/notice/readPage.do?boardSeq='+boardSeq+'&boardTypeSeq='+boardTypeSeq
   				return;
  
    		},
    		
    		//jQuery .ajax는 js fetchAPI와 달리
    		//상태코드가 200이 아니면 error 콜백에서 처리한다.
    		error : function(result) {
    			// 결과 에러 콜백함수
				console.log(result)
    			console.log(result.responseText)
    			alert(result.responseText)
    			console.log(error)
    		}
    	});
    }
    

    // 댓글 수정을 비동기로 요청하는 메서드
    function modifyComment(boardTypeSeq, boardSeq, elem) {
    	let commentDto = {
    			commentSeq: elem.getAttribute("data-commentSeq"),
    			content: $('#comment-edit').trumbowyg('html')
    	};
      	
     		$.ajax({    
    		type : 'patch',           
    		url : '<%=ctx%>/forum/notice/modifyComment.do',
    		async : true,
    		// 비동기화 여부 (default : true)
    		headers : {
    			// Http header
	    			"Content-Type" : "application/json",
    			"accept" : "application/json"
    		},
    		data: JSON.stringify(commentDto),
    		dataType : 'text',
    		success : function(result) {
    			// 결과 성공 콜백함수 
    			console.log(result)
    			alert(result)
   				location.href='<%=ctx%>/forum/notice/readPage.do?boardSeq='+boardSeq+'&boardTypeSeq='+boardTypeSeq
   				return;
    		},
    
    		error : function(result) {
    			// 결과 에러 콜백함수
				console.log(result)
    			console.log(result.responseText)
    			alert(result.responseText)
    			console.log(error)
    		}
    	});
     		
	}
    // 댓글 수정창을 보여주는 메서드
    function openModifyWindow(elem){
    	//1. 현재 댓글 내용을 댓글 수정 창에 뿌리기.
    	let contentBox = elem.closest('div.contentBtn');
    	let commentContent = contentBox.querySelector('span.commentContent').innerText;
    	console.log(commentContent)
    	$('#comment-edit').trumbowyg('html', commentContent)

    	//2.댓글 수정 창을 현재 댓글 위치로 가져오고(&display를 block) 현재 댓글 내용 요소는 삭제.
    	let commentArea = elem.closest('div.forum_single_reply');
    	let editForm = document.querySelector('div.comment-form-area.edit');
    	commentArea.append(editForm);
    	editForm.style.display = "block";
    	
    	//2-2. 이전의 다른 댓글의 수정버튼을 누른 상태라면, 그 댓글의 수정창은 닫혀야 한다.
    	let hiddenElem = document.querySelector('div.contentBtn.hiddenComment');
    	console.log(hiddenElem);
    	if(hiddenElem != null) {
    		hiddenElem.classList.remove("hiddenComment");
    	}
    		contentBox.classList.add("hiddenComment");
    	
    	
    	//3.댓글 수정 창의 수정 버튼에 현재 댓글의 commentSeq를 심어둔다.
    	let editBtn = editForm.querySelector('button.edit');
    	editBtn.setAttribute('data-commentSeq', commentArea.getAttribute('data-commentSeq'))
    }
    
    
    // 대댓글 등록 창을 띄우는 메서드
    function openReplyWindow(elem){
    	//이전에 등록하지 않고 작성한 내용이 있다면 초기화시키기
//     	$('#trumbowyg-demo').trumbowyg('html', '');
    	$('#content').trumbowyg('html', '');
    	
    	//1.댓글 등록 창을 현재 댓글 위치로 가져오기
    	let ReplyArea = elem.closest('div.forum_single_reply');
    	let commentForm = document.querySelector('div.comment-form-area.reply');
    	
    	ReplyArea.append(commentForm);
    	
    	//3.대댓글 등록 창의 등록 버튼에 현재 댓글의 commentSeq를 심어둔다.
    	let submitBtn = commentForm.querySelector('button.submit');
    	//대댓글이므로 lvl+1 해주기
    	submitBtn.setAttribute('data-parentCommentSeq',
    			elem.getAttribute('data-parentCommentSeq') == null? 
    					elem.getAttribute("data-commentSeq") : elem.getAttribute("data-parentCommentSeq"));
    	submitBtn.setAttribute('data-commentLvl', parseInt(elem.getAttribute('data-commentLvl'))+1);
    	submitBtn.setAttribute('data-mentionMemberSeq', elem.getAttribute("data-mentionMemberSeq"));
    }
    
    
  //각각 댓글에 대한 좋아요 싫어요
    function replyThumbClick(commentSeq, elem) {
//     	alert('clicked!');
//     	let replyDiv = elem.closest('div.reply.vote');
    	let replyDiv = elem.closest('div.forum_single_reply');
    	console.log(replyDiv)
    	
    	let url = '<%=ctx%>/forum/notice/'
    	url += commentSeq + '/'
    	url += 'replyVote.do?thumb=' + elem.getAttribute("data-thumb")
    		
    			
    	$.ajax({    
    		type : 'get',           
    		// 타입 (get, post, put 등등)    
    		url : url,
    		// 요청할 서버url
    		async : true,
    		// 비동기화 여부 (default : true)
    		headers : {
    			// Http header
//     			"Content-Type" : "application/json",
    			"accept" : "application/json"
    		},
    		dataType : 'json',
    		success : function(result) {
    			// 결과 성공 콜백함수 
    			console.dir(result);
    			
    			if(result.code == 0) { //이전 투표 결과가 없는 경우 (새로 투표 결과 insert)
    				//thumb active 표현
    				replyDiv.querySelector("a[data-thumb="+result.thumb+"]").classList.add('active')
    				
    				//카운트 반영
    				let voteSum = replyDiv.querySelector("span.voteSum."+result.thumb)
    				voteSum.innerText = parseInt(voteSum.innerText) + 1

    			} else if (result.code == 1) { //이전 투표결과를 취소
    				//thumb active 표현
					replyDiv.querySelector("a[data-thumb="+result.thumb+"]").classList.remove('active')
					
					//카운트 반영
					let voteSum = replyDiv.querySelector("span.voteSum."+result.thumb)
    				voteSum.innerText = parseInt(voteSum.innerText) - 1

    			} else if (result.code == 2){ //이전 투표결과를 반대로 
    				//thumb active 표현
    				replyDiv.querySelector("a[data-thumb="+!result.thumb+"]").classList.remove('active')
    				replyDiv.querySelector("a[data-thumb="+result.thumb+"]").classList.add('active')
    				
    				//카운트 반영
    				let voteSum1 = replyDiv.querySelector("span.voteSum."+result.thumb)
    				let voteSum2 = replyDiv.querySelector("span.voteSum."+!result.thumb)
    				voteSum1.innerText = parseInt(voteSum1.innerText) + 1
    				voteSum2.innerText = parseInt(voteSum2.innerText) - 1

    			}

    		},
    		error : function(request, status, error) {
    			// 결과 에러 콜백함수
    			alert('failed');
    			console.log(error)
    		}
    	});
    }
</script>

    <!--================================
            END DASHBOARD AREA
    =================================-->
	