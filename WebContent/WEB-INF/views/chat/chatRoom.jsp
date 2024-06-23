<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%
String ctx = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">

    <!-- viewport meta -->
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="MartPlace - Complete Online Multipurpose Marketplace HTML Template">
    <meta name="keywords" content="marketplace, easy digital download, digital product, digital, html5">

    <title>포트폴리오</title>

    <!-- inject:css -->
    <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
    <link rel="stylesheet" href="<%=ctx%>/assest/template/css/animate.css">
    <link rel="stylesheet" href="<%=ctx%>/assest/template/css/font-awesome.min.css">
    <link rel="stylesheet" href="<%=ctx%>/assest/template/css/fontello.css">
    <link rel="stylesheet" href="<%=ctx%>/assest/template/css/jquery-ui.css">
    <link rel="stylesheet" href="<%=ctx%>/assest/template/css/lnr-icon.css">
    <link rel="stylesheet" href="<%=ctx%>/assest/template/css/owl.carousel.css">
    <link rel="stylesheet" href="<%=ctx%>/assest/template/css/slick.css">
    <link rel="stylesheet" href="<%=ctx%>/assest/template/css/trumbowyg.min.css">
    <link rel="stylesheet" href="<%=ctx%>/assest/template/css/bootstrap/bootstrap.min.css">
    <link rel="stylesheet" href="<%=ctx%>/assest/template/css/style.css">
    <!-- endinject -->

    <!-- Favicon -->
    <link rel="icon" type="image/png" sizes="16x16" href="<%=ctx%>/assest/template/images/favicon.png">    
	<script type="text/javascript">
		var ctx = '<%= request.getContextPath() %>';
	</script>	
	<script src="<%=ctx%>/assest/js/page.js"></script>
<style>
	html, body {
		width: 100%;
		height: 100%;
	}
	
	.contentContainer {
		width: 100%;
		height: 100%;
		display: flex;
		flex-direction: column;	
	}
	.contentBox {
		width: 100%;
		height: 500%;
		display: flex;
		flex-direction: row;
	}
	.innerBox {
		width: 300%;
		height: 100%;
		display:flex;
		flex-direction: column;
	
	}
	header {
		background-color: orange;
/*         height: 100%; */
        height: 80%;
	}
	section {
		background-color: white;
        height: 500%;
	}
	aside {
		background-color: green;
		width: 100%;
	}
	
	footer {
		display: flex;
		flex-direction: row;
		justify-content: space-around;
		align-items: center;
		background-color: purple;
		height: 70%;
	}
	
	.chat-field, .chat-btn {
		display: inline-block;
	}
	
/* 	.chat-field { */
/* 		width : 70%; */
/* 	} */
	
/* 	.chat-btn { */
/* 		width: 20%; */
/* 	} */
	</style>
</head>
<body>
	<div class="contentContainer">
		<div class="contentBox">
			<div class="innerBox">
				<header>
				<div>
					<p>'${chatRoomDto.roomNm }'에 오신 것을 환영합니다.</p>
				</div>
				</header>
				<section>
					<div class="chatBox">
						<ul class="chatMsgs">
							
						</ul>
					</div>
				</section>
			</div>
			<aside>
			<p>채팅 멤버</p>
			<ul>
				<li>방장 : ${chatRoomDto.managerNm }</li>
				<c:forEach var="member" items="${memberList}">
					<li> ${ member } </li>
				</c:forEach>
			</ul>
			</aside>
		</div>
		<footer class="chat-form">
            <input type="text" class="text_field chat-field" id="chatMsg" name="value" style="width:70%;">
            <button type="submit" class="search-btn btn--lg chat-btn" style="width:20%;" onclick="sendMsg()">전송</button>
		</footer>
	</div>
</body>
<!--     endinject -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.3.0/sockjs.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
<!-- <script src="https://cdn.jsdelivr.net/npm/@stomp/stompjs@7.0.0/bundles/stomp.umd.min.js"></script> -->
    <script>
    let chatroomSeq = ${chatroomSeq}
//     let memberSeq = ${memberSeq}
    let memberSeq = ${sessionScope.memberSeq}
    let chatMsgs = document.querySelector('ul.chatMsgs')
    let sockStomp = null;
    
    window.onload = function(){
    	connectStomp()
    }

    function connectStomp(){
    	
       	let sock = new SockJS("/pf/stomp")
       	let stompClient = Stomp.over(sock)

    	sockStomp = stompClient

    	stompClient.connect({}, function(frame){
    		console.log('Connected : ' + frame)
    		
    		let newMember = {
    			chatroomSeq: chatroomSeq,
    			memberSeq: memberSeq,
    			msgType: "ENTER"
    		}
    		
	   		stompClient.send("/chat/groupchat/"+chatroomSeq, {}, JSON.stringify(newMember))
	   				
	   		stompClient.subscribe("/topic/message/"+chatroomSeq, function(response) {
	   			console.log("event sent from server", response)
	   			
	   			let chatDto = JSON.parse(response.body)
	   			renderMessage(chatDto)
	   			console.log(chatDto)
	   			console.log("msg="+ chatDto.msg)
	   		})
    	})
    }
    
    function sendMsg(){
    	let msgInput = document.querySelector("#chatMsg");
    	let chatDto = {
    			chatroomSeq: chatroomSeq,
    			memberSeq: memberSeq,
    			msgType: "CHAT",
    			message: msgInput.value
    	}   	
    	sockStomp.send("/chat/groupchat/"+chatroomSeq, {}, JSON.stringify(chatDto))
    	
    	//메시지를 보낸 후 다시 초기화하기
    	msgInput.value=''
    	
    }
    
    

    function renderMessage(chatDto){
    	
    	
    	if(chatDto.msgType == "ENTER" || chatDto.msgType == "LEAVE") {
    		//채팅방 중앙에 메시지를 뿌린다.
    		alignMsg(chatDto, "center")
    		return
    	}
    	
    	
    	//'나'인지 타인인지 구분해서 화면에 렌더링하기.
    	if(chatDto.memberSeq == memberSeq) {
    		//내가 보낸 메시지면 오른쪽에 렌더링
    		alignMsg(chatDto, "right")
    	} else {
    		//타인이 보낸 메시지면 왼쪽에 렌더링
    		alignMsg(chatDto, "left")
    	}
    }
    
    function alignMsg(chatDto, direction){
    	const elem = document.createElement("li")
    	elem.innerHTML = chatDto.message
    	elem.style.textAlign = ""+direction
    	chatMsgs.appendChild(elem)
    }
    </script>
</html>

