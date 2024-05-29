<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ include file="/common/scripts.jsp" %>
	<link rel="stylesheet" href="<%=ctx%>/assest/template/css/trumbowyg.min.css">
    <script src="<%=ctx%>/assest/template/js/vendor/trumbowyg.min.js"></script>
    <script src="<%=ctx%>/assest/template/js/vendor/trumbowyg/ko.js"></script>
    <script type="text/javascript">
	    $(document).ready(function(){
	    	
	    	//게시글 등록에 실패해서 다시 이 뷰로 올 경우, 
	    	//사용자 입력 내용을 그대로 전달받아 뿌려줌 	
	    	$('#trumbowyg-demo').trumbowyg('html', '${boardSaveDto.content}');

	    })    
    
	    $('#trumbowyg-demo').trumbowyg({
	        lang: 'kr'
	    });
	    
	   
// 	    1. trumbowyg는 내부적으로 div id와 같은 name으로 textarea를 만든다.
	    
// 	    컨트롤러에서 받아보면 마치 editor의 id로 parameter전송이 가능한 것처럼 보이지만,
// 	    내부적으로는 id와 같은 이름의 name의 textarea를 만들기 때문에 그렇게 보일 뿐이다.
// 	    div의 id는 form전송시 파라미터로 취급되지 않는다. 내가 실험 해봄
	    
// 	    2. 나는 Controller에서 dto로 한번에 받기를 원한다. (hashMap에서 꺼내기 귀찮고 유효성 검사도 한번에 처리하고 싶음.)
// 	    처음에는 trumbowyg에디터에 해당하는 div의 id 자체를 "content"로 바꾸고 싶었으나(dto의 명세와 일치시킬 목적) 
// 	    테스트 결과 왠지 모르겠는데 꼭 id가 "trumbowyg-demo"여야만 브라우저에서 에디터가 정상적으로 렌더링 되었음.
	    
// 	    그래서 form전송 전에 이 에디터에 의해 내부적으로 생성되는 textarea의 이름을 content로 바꿔주는 방법을 택함.
	    function formCheck(elem) {
	    	let txtArea = elem.querySelector('textarea[name=trumbowyg-demo]')
	    	console.log(txtArea)
	    	txtArea.setAttribute("name","content")
	    	
	    	if(txtArea.getAttribute("name")=="content"){
	    		console.log(txtArea)
	    		return true;
	    	} 
	    	return false;
	    }
	</script>
    <!--================================
            START DASHBOARD AREA
    =================================-->
    <section class="support_threads_area section--padding2">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="question-form cardify p-4">
                        <form action="<c:url value='/forum/notice/writePage.do'/>" method="post" onsubmit="return formCheck(this)">
                            <div class="form-group">
                                <label>제목</label>
                                <input type="text" placeholder="Enter title here" required name="title">
                                <spring:hasBindErrors name="boardSaveDto">
                                    <c:if test="${errors.hasFieldErrors('title') }">
                                    	<strong style="color:red">${errors.getFieldError('title').defaultMessage }</strong>
                                    </c:if>
                                    </spring:hasBindErrors>
                                <input type="hidden" name="boardTypeSeq" value="1"/> <!-- 공지사항은 boardTypeSeq가 1이다. 흠 근데 이거 하드코딩일까? -->
                            </div>
                            <div class="form-group">
                                <label>Description</label>
                            <spring:hasBindErrors name="boardSaveDto">
	                            <c:if test="${errors.hasFieldErrors('content') }">
	                            	<strong style="color:red">${errors.getFieldError('content').defaultMessage }</strong>
	                            </c:if>
                            </spring:hasBindErrors>
                                <div id="trumbowyg-demo"></div>
                            </div>

                            <div class="form-group">
                                <div class="attachments">
                                    <label>Attachments</label>
                                    <label>
                                        <span class="lnr lnr-paperclip"></span> Add File
                                        <span>or Drop Files Here</span>
                                        <input type="file" style="display:none;">
                                    </label>
                                </div>
                            </div>
                            <div class="form-group">
                                <button type="submit" class="btn btn--md btn-primary">Submit Request</button>
                            	<a href="<c:url value='/forum/notice/listPage.do'/>" class="btn btn--md btn-light">Cancel</a>
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
    <!--================================
            END DASHBOARD AREA
    =================================-->
