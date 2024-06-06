<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ include file="/common/scripts.jsp" %>
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
                    <div class="question-form cardify p-4">
                        <form action="<c:url value='/forum/notice/${boardDto.boardTypeSeq }/${boardDto.boardSeq }/modifyPage.do'/>"
                         							  method="post" enctype="multipart/form-data">
                            <div class="form-group">
                                <label>제목</label> 
                                <input type="text" placeholder="Enter title here" required name="title" value="${boardDto.title }">
                                <!-- model에 담겨오는 이름이 아니라, 클래스 이름을 적어야 에러 메시지가 찍힌다 -->
                                <spring:hasBindErrors name="boardModifyDto">
                                    <c:if test="${errors.hasFieldErrors('title') }">
                                    	<strong style="color:red">${errors.getFieldError('title').defaultMessage }</strong>
                                    </c:if>
                                </spring:hasBindErrors>
                            </div>
                            <div class="form-group">
                                <label>Description</label>
                                <spring:hasBindErrors name="boardModifyDto">
                                    <c:if test="${errors.hasFieldErrors('content') }">
                                    	<strong style="color:red">${errors.getFieldError('content').defaultMessage }</strong>
                                    </c:if>
                                </spring:hasBindErrors>
<!--                                 <div id="trumbowyg-demo"></div> -->
                                <div id="content"></div>
                            </div>
                            <div class="form-group">
                                <div class="attachments">
 								<b style="font-size:20px;">Attachments</b>
                                <c:set var="listSize" value='${attFileList.size() }'/>
                                <c:forEach items="${attFileList }" var="attFile">
                                	<div> 
                                		<span>첨부 파일 : ${attFile.orgFileNm } (${attFile.fileSize })</span>
										<button type="button" onclick="javascript:deleteFile(${attFile.attachSeq})">삭제</button>
                                	</div>
                                </c:forEach>
                                
                                <!--  첨부파일은 총 3개까지 추가 가능 -->
                                <c:forEach begin='${listSize +1}' end="3" step="1" var="i">
                                    <label>
                                        <span class="lnr lnr-paperclip"></span> Add File
                                        <span>or Drop Files Here</span>
                                        <span class="fileName"></span>
                                        <input type="file" name="attFiles" style="display:none;font-size:15px;" 
                                        				onchange="showFileName(this)">
                                        <span style="color:red;">${uploadMsg}</span>
                                    </label>
                                </c:forEach>            
                                </div>
                            </div>
                            <div class="form-group">
                                <button type="submit" class="btn btn--md btn-primary">수정하기</button>
                            	<a href="<c:url value='/forum/notice/listPage.do'/>" class="btn btn--md btn-light">취소</a>
                            </div>
                        </form>
                    </div><!-- ends: .question-form -->
                </div>
                <!-- end .col-md-12 -->
            </div>
            <!-- end .row -->
        </div>
        <!-- end .container -->
    </section>
    

    
    <script>
    let msg = '${msgObject.msg}'
    let code = '${msgObject.code}'

    window.onload = function(){
	   	if(msg!=''){
	   		console.log(code)
	   		alert(msg)
	   	}
    }
        
    $(document).ready(function(){
    	//게시물 정보 뿌려주기
//     	$('#trumbowyg-demo').trumbowyg('html', '${boardDto.content}');
    	$('#content').trumbowyg('html', '${boardDto.content}');

    })
    
     //개별 파일 삭제 ajax 요청
	    function deleteFile(attachSeq){
    	if(!confirm("첨부파일을 삭제하시겠습니까?"))
    		return;
    	
	    	$.ajax({    
	    		type : 'delete',             
	    		url : '<%=ctx%>/forum/notice/'+attachSeq+'/deleteFile.do',
	    		async : true,
	    		headers : {
// 	    			"Content-Type" : "application/json",
// 	    			"accept" : "application/json"
	    		},
	    		dataType : 'text',
	    		success : function(result) {
	    			// 결과 성공 콜백함수 
	    			console.log(result)
	    			alert(result)
  					location.href='<%=ctx%>/forum/notice/${boardDto.boardTypeSeq }/${boardDto.boardSeq }/modifyPage.do'
    			},
	    		error : function(result) {
	    			// 결과 에러 콜백함수
	    			console.log(result)
	    			console.log(result.responseText)
	    			alert(result.responseText)
	    		}
	    	});
	    	
	    }
    
    	    
    //input태그를 disply:none으로 해둔 상태라 추가된 파일명(onchange이벤트)을 보여주기 위한 함수
    function showFileName(elem) {
    	console.dir(elem)
    	console.log(elem.value)
    	const fileName = elem.files[0].name
    	elem.closest('label').querySelector('span.fileName').innerText = fileName
    }
    
    //form submit전에 textarea의 name을 변경해준다.(controller에서 한번에 dto로 받고싶어서)
//     function formCheck(elem) {
//     	let txtArea = elem.querySelector('textarea[name=trumbowyg-demo]')
//     	console.log(txtArea)
//     	txtArea.setAttribute("name","content")
    	
//     	if(txtArea.getAttribute("name")=="content"){
//     		console.log(txtArea)
//     		return true;
//     	} 
//     	return false;
//     }
	</script>

    <!--================================
            END DASHBOARD AREA
    =================================-->
