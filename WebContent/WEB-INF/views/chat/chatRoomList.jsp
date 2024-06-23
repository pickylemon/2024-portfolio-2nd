<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%
String ctx = request.getContextPath();
%>
<style>
.chat--form {
	display: flex;
	flex-direction: column;
	justify-content: space-between;

}

ul.chatList li {
	padding: 0px 20px;

}

/* ul.chatList { */
/* 	display: flex; */
/* 	flex-direction: row; */
/* 	justify-content: space-between; */
/* } */
</style>
   <!--================================
        START BREADCRUMB AREA
    =================================-->
    <section class="breadcrumb-area">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <div class="breadcrumb">
                        <ul>
                            <li>
                                <a href="index.html">Home</a>
                            </li>
                            <li class="active">
                                <a href="#">채팅방</a>
                            </li>
                        </ul>
                    </div>
                    <h1 class="page-title">채팅방에 오신걸 환영합니다.</h1>
                </div>
            </div>
            <!-- end /.row -->
        </div>
        <!-- end /.container -->
    </section>
    <!--================================
        END BREADCRUMB AREA
    =================================-->

    <!--================================
            START DASHBOARD AREA
    =================================-->
    <section class="support_threads_area section--padding2">
        <div class="container">
            <div class="row">
            
                <div class="col-lg-8">
                    <aside class="sidebar support--sidebar">
<!--                         <a href="login.html" class="login_promot"> -->
<!--                             <span class="lnr lnr-lock"></span>Login to Ask a Question</a> -->

                        <div class="sidebar-card card--forum_categories">
                            <div class="card-title">
<!--                             	<button class="btn btn--round btn-lg">Button Large</button> -->
                                <h3>주제별 채팅방</h3>
                            </div>
                       	<div class="collapsible-content">
                        <div class="modules__content">
                            <div class="panel-group accordion" role="tablist" id="accordion">
                                <div class="panel accordion__single" id="panel-one">
                                    <div class="single_acco_title">
                                        <h4>
                                            <a data-toggle="collapse" href="#collapse1" class="collapsed" aria-expanded="false" data-target="#collapse1" aria-controls="collapse1">
                                                <span>일상 이야기</span>
                                                <i class="lnr lnr-chevron-down indicator"></i>
                                            </a>
                                        </h4>
                                    </div>

                                    <div id="collapse1" class="panel-collapse collapse" aria-labelledby="panel-one" data-parent="#accordion">
                                        <div class="panel-body">
                          					<ul class="card-content chatList" data-category="001">
                          					<c:forEach var="chatRoom" items="${chatRoomMap.get(\"001\")}">
			                                    <li>
			                                        <a href="<c:url value='/${chatRoom.chatroomSeq }/${sessionScope.memberSeq }/chatRoom.do'/>" 
			                                        	onclick="window.open(this.href, '_blank', 'width=800px,height=800px,scrollbars=yes'); return false;" >
			                                            <span class="lnr lnr-chevron-right"></span>${chatRoom.roomNm }
			                                            <span class="item-count">${chatRoom.memberCnt } /10</span>
			                                        </a>
			                                    </li>
                          					</c:forEach>
                                			</ul>
                                        </div>
                                    </div>
                                </div>
                                <!-- end /.accordion__single -->
                                <div class="panel accordion__single" id="panel-two">
                                    <div class="single_acco_title">
                                        <h4>
                                            <a data-toggle="collapse" href="#collapse2" class="collapsed" aria-expanded="false" data-target="#collapse2" aria-controls="collapse2">
                                                <span>재료와 도구 이야기</span>
                                                <i class="lnr lnr-chevron-down indicator"></i>
                                            </a>
                                        </h4>
                                    </div>

                                    <div id="collapse2" class="panel-collapse collapse" aria-labelledby="panel-two" data-parent="#accordion">
                                        <div class="panel-body">
                          					<ul class="card-content chatList" data-category="002">
                          					<c:forEach var="chatRoom" items="${chatRoomMap.get(\"002\")}">
			                                    <li>
			                                        <a href="<c:url value='/${chatRoom.chatroomSeq }/${sessionScope.memberSeq }/chatRoom.do'/>" 
			                                        	onclick="window.open(this.href, '_blank', 'width=800px,height=800px,scrollbars=yes'); return false;" >
			                                            <span class="lnr lnr-chevron-right"></span>${chatRoom.roomNm }
			                                            <span class="item-count">${chatRoom.memberCnt } / 10</span>
			                                        </a>
			                                    </li>
                          					</c:forEach>
                                			</ul>
                                        </div>
                                    </div>
                                </div>
                                <!-- end /.accordion__single -->
                                <div class="panel accordion__single" id="panel-three">
                                    <div class="single_acco_title">
                                        <h4>
                                            <a data-toggle="collapse" href="#collapse3" class="collapsed" aria-expanded="false" data-target="#collapse3" aria-controls="collapse3">
                                                <span>디저트 탐방</span>
                                                <i class="lnr lnr-chevron-down indicator"></i>
                                            </a>
                                        </h4>
                                    </div>

                                    <div id="collapse3" class="panel-collapse collapse" aria-labelledby="panel-three" data-parent="#accordion">
                                        <div class="panel-body">
                          					<ul class="card-content chatList" data-category="003">
                          					<c:forEach var="chatRoom" items="${chatRoomMap.get(\"003\")}">
			                                    <li>
			                                        <a href="<c:url value='/${chatRoom.chatroomSeq }/${sessionScope.memberSeq }/chatRoom.do'/>" 
			                                        	onclick="window.open(this.href, '_blank', 'width=800px,height=800px,scrollbars=yes'); return false;" >
			                                            <span class="lnr lnr-chevron-right"></span>${chatRoom.roomNm }
			                                            <span class="item-count">${chatRoom.memberCnt } /10</span>
			                                        </a>
			                                    </li>
                          					</c:forEach>
                                			</ul>
                                        </div>
                                    </div>
                                </div>
                                <!-- end /.accordion__single -->
                                <div class="panel accordion__single" id="panel-four">
                                    <div class="single_acco_title">
                                        <h4>
                                            <a data-toggle="collapse" href="#collapse4" class="collapsed" aria-expanded="false" data-target="#collapse4" aria-controls="collapse4">
                                                <span>레시피 이야기</span>
                                                <i class="lnr lnr-chevron-down indicator"></i>
                                            </a>
                                        </h4>
                                    </div>

                                    <div id="collapse4" class="panel-collapse collapse" aria-labelledby="panel-four" data-parent="#accordion">
                                        <div class="panel-body">
                          					<ul class="card-content chatList" data-category="004">
                          					<c:forEach var="chatRoom" items="${chatRoomMap.get(\"004\")}">
			                                    <li>
			                                        <a href="<c:url value='/${chatRoom.chatroomSeq }/${sessionScope.memberSeq }/chatRoom.do'/>" 
			                                        	onclick="window.open(this.href, '_blank', 'width=800px,height=800px,scrollbars=yes'); return false;" >
			                                            <span class="lnr lnr-chevron-right"></span>${chatRoom.roomNm }
			                                            <span class="item-count">${chatRoom.memberCnt } /10</span>
			                                        </a>
			                                    </li>
                          					</c:forEach>
                                			</ul>
                                        </div>
                                    </div>
                                </div>
                                <!-- end /.accordion__single -->
                                <div class="panel accordion__single" id="panel-five">
                                    <div class="single_acco_title">
                                        <h4>
                                            <a data-toggle="collapse" href="#collapse5" class="collapsed" aria-expanded="false" data-target="#collapse5" aria-controls="collapse5">
                                                <span>기타</span>
                                                <i class="lnr lnr-chevron-down indicator"></i>
                                            </a>
                                        </h4>
                                    </div>

                                    <div id="collapse5" class="panel-collapse collapse" aria-labelledby="panel-five" data-parent="#accordion">
                                        <div class="panel-body">
                          					<ul class="card-content chatList" data-category="005">
                          					<c:forEach var="chatRoom" items="${chatRoomMap.get(\"005\")}">
			                                    <li>
			                                        <a href="<c:url value='/${chatRoom.chatroomSeq }/${sessionScope.memberSeq }/chatRoom.do'/>" 
			                                        	onclick="window.open(this.href, '_blank', 'width=800px,height=800px,scrollbars=yes'); return false;" >
			                                            <span class="lnr lnr-chevron-right"></span>${chatRoom.roomNm }
			                                            <span class="item-count">${chatRoom.memberCnt } /10</span>
			                                        </a>
			                                    </li>
                          					</c:forEach>
                                			</ul>
                                        </div>
                                    </div>
                                </div>
                                <!-- end /.accordion__single -->
                        
                            </div>
                            <!-- end /.accordion -->
                        </div>
                        <!--  end of module content -->
                        
                         </div>
                            <!-- end /.collapsible_content -->
                        </div>
                    </aside>
                    <!-- end .sidebar -->
                </div>
                <!-- end .col-md-4 -->
            
                <div class="col-lg-4">
                    <div class="forum_detail_area ">
                        <div class="cardify signup_form">
                            <div class="login--header">
                                <h3>채팅방 만들기</h3>
                                <p>카테고리를 선택 후 <br> 새로운 채팅방을 만들 수 있습니다.</p>
                            </div>
                            <!-- end .login_header -->

                            <div class="login--form chat--form">

                                <div class="form-group">
	                                <label>Category</label>
	                                <div class="select-wrap select-wrap2">
	                                    <select name="category" id="category">
	                                        <option value="">채팅 주제를 선택해주세요</option>
	                                        <option value="001">일상 이야기</option>
	                                        <option value="002">재료/도구 이야기</option>
	                                        <option value="003">디저트 탐방</option>
	                                        <option value="004">레시피 이야기</option>
	                                        <option value="005">기타</option>
	                                    </select>
	                                    <span class="icon-arrow-down"></span>
	                                </div><!-- end /.select-wrap -->
                                </div>

                                <div class="form-group">
                                    <label for="con_pass">채팅방 제목</label>
                                    <input id="con_pass" type="text" class="text_field" placeholder="20자 이내로 입력하세요" name="roomNm">
                                </div>
								<button class="btn btn-lg btn--round btn-info" onclick="javascript:makeChatRoom()">채팅방 만들기</button>
                            </div>
                            <!-- end .login--form -->
                        </div>

                    </div>
                    <!-- end .forum_detail_area -->
                </div>
                <!-- end .col-md-8 -->


            </div>
            <!-- end .row -->
        </div>
        <!-- end .container -->
    </section>
    <!--================================
            END DASHBOARD AREA
    =================================-->

<script>
function makeChatRoom(){
	
	let roomNm = document.querySelector('input[name=roomNm]')
	let category = document.querySelector('select[name=category]')
	let chatRoomDto = {}
	chatRoomDto.roomNm = roomNm.value
	chatRoomDto.category = category.value
	
	console.log(chatRoomDto)

	
	$.ajax({    
		type : 'post',           
		// 타입 (get, post, put 등등)    
		url : '<%=ctx%>/chatRoomList.do',
		// 요청할 서버url
		async : true,
		// 비동기화 여부 (default : true)
		headers : {
			// Http header
			"Content-Type" : "application/json",
			"accept" : "application/json"
		},
		data : JSON.stringify(chatRoomDto),
		dataType : 'json',
		success : function(result) {
			console.log("success result")
			console.log(result)
			
			//원래 input을 초기화하기
			roomNm.value = ''
			category.value = ''
			
			
			let url = "<%=ctx%>/"
			url += result.chatroomSeq +"/"
			url += result.memberSeq +"/"
			url += "chatRoom.do"
			
			console.log("url")
			console.log(url)
			
			window.open(url, "_blank", 'width=800px,height=800px,scrollbars=yes')

		},
		error : function(result) {
			// 결과 에러 콜백함수
			console.log(result)
			console.log(result.responseText)
// 			console.log(error)
		}
	});
}



</script>