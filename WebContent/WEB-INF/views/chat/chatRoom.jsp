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

    <title>CHATROOM</title>

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
    <script src="https://kit.fontawesome.com/99823c8069.js" crossorigin="anonymous"></script>
    <!-- endinject -->

    <!-- Favicon -->
    <link rel="icon" type="image/png" sizes="16x16" href="<%=ctx%>/assest/template/images/lemon.png">    
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
		background-color: #ffe78d;
/*         height: 100%; */
        height: 80%;
        display: flex;
        flex-direction: row;
        align-items: center;
        justify-content: space-around;
	}
	section {
		background-color: white;
        height: 500%;
        background: #fffbec;
	}
	aside {
	    padding: 40px 30px;
		display: flex;
		flex-direction: column;
		background-color: #FFF2C0;
		width: 100%;
	}
	
	aside p {
		font-size: 20px;
	    line-height: 26px;
	    margin: 15px;
	    color: #333;
	    font-weight: 600;
	    padding-bottom: 12px;
/* 	    padding: 15px 27px; */
	}
	
	
	aside ul li, .chatMsgs li  {
		font-size: 16px;
		line-height: 20px;
		margin : 15px;
	}
	
	.chatMsgs li.center {
		color: #9FACE1;
		font-weight: bold;
	
	}
	
	footer {
		display: flex;
/* 		width: 100%; */
		flex-direction: row;
		padding: 0 10px;
		justify-content: space-around;
		align-items: center;
		background-color: #FFE8D8;
		height: 70%;
	}
	
	.chatRoomTitle {
	    color: #9FACE1;
	    font-weight: 500;
	    font-size: 23px;
	    font-weight: 600;
/* 		text-align: center; */
	}
	
/* 	.chat-field, .chat-btn { */
/* 		display: inline-block; */
/* 	} */
	
 	.chat-field { 
 		flex: 0 0 70%; 
	
 	} 
	
 	.chat-btn { 
 		flex: 0 0 10%; 
 		background: #9FACE1
 	} 
 	
 	.fa-crown {
 		padding-right: 10px;
 	}

 	
	</style>
</head>
<body>
	<div class="contentContainer">
		<div class="contentBox">
			<div class="innerBox">
				<header>
				<div class="chatRoomTitle">
					"${chatRoomDto.roomNm }"에 오신 것을 환영합니다.
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
			<ul class="chatMemberList">						
				<li> <i class="fas fa-solid fa-crown" style="color:#ffc900;"></i><span>${chatRoomDto.managerId }</span></li>
				<c:forEach var="member" items="${memberList}">
					<li><span> ${ member }</span> </li>
				</c:forEach>
			</ul>
			</aside>
		</div>
		<footer class="chat-form">
            <input type="text" class="text_field chat-field" id="chatMsg" name="value" style="width:70%;">
            <button type="submit" class="search-btn btn--sm chat-btn" style="width:120px;" onclick="sendMsg()">전송</button>
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
    	
    	console.log("scokStomp")
    	console.log(sockStomp)

    }
    


    function connectStomp(){
    	
       	let sock = new SockJS("/pf/stomp")
       	let stompClient = Stomp.over(sock)
       	

    	sockStomp = stompClient
    	
    	let headers = {
       		memberSeq : memberSeq
       	}
    	stompClient.connect(headers, function(frame){
    		console.log('Connected : ' + frame)
    		
    		let newMember = {
    			chatroomSeq: chatroomSeq,
    			memberSeq: memberSeq,
    			messageType: "ENTER"
    		}
    		
	   		stompClient.send("/chat/groupchat/"+chatroomSeq, headers, JSON.stringify(newMember))
	   		
	   		stompClient.subscribe("/topic/message/"+chatroomSeq, function(response) {

	   			console.log("event sent from server", response)
	   			
	   			let chatForm = JSON.parse(response.body)
	   			

	   			if(chatForm.messageType == 'ENTER') {
		   			//새 멤버가 들어오면 목록에 추가하고
	   				addMemberList(chatForm.memberId)	   				
	   			} else if(chatForm.messageType == 'LEAVE') {
		   			//나간 멤버가 있다면 리스트에서 제외하기
		   			removeMemberList(chatForm.memberId)
	   			}
   			
	   			//받은 메시지를 렌더링
	   			renderMessage(chatForm)
	   			console.log(chatForm)
	   			console.log("message="+ chatForm.message)
	   		})
    	})
    	
    	//sockStomp.ws.close = leaveChatRoom
    	window.addEventListener('beforeunload', leaveChatRoom);
    }
    
    function sendMsg(){
    	let msgInput = document.querySelector("#chatMsg");
    	let chatForm = {
    			chatroomSeq: chatroomSeq,
    			memberSeq: memberSeq,
    			messageType: "CHAT",
    			message: msgInput.value
    	}   	
    	sockStomp.send("/chat/groupchat/"+chatroomSeq, {}, JSON.stringify(chatForm))
//     	sockStomp.send("/chat/groupchat", {}, JSON.stringify(chatForm))
    	
    	//메시지를 보낸 후 다시 초기화하기
    	msgInput.value=''
    	
    }
    
    

    function renderMessage(chatForm){
    	
    	let message = chatForm.message
    	console.log("message=" + message)
    	
    	if(chatForm.messageType == "ENTER" || chatForm.messageType == "LEAVE") {
    		//채팅방 중앙에 메시지를 뿌린다.
    		alignMsg(message, "center")
    		return
    	}
    	
    	//'나'인지 타인인지 구분해서 화면에 렌더링하기.
    	if(chatForm.memberSeq == memberSeq) {
    		//내가 보낸 메시지면 오른쪽에 렌더링
    		alignMsg(message, "right")
    	} else {
    		//타인이 보낸 메시지면 왼쪽에 렌더링
    		message = chatForm.memberId + " : " + message
    		console.log("타인의 메시지 : " + message)
    		alignMsg(message, "left")
    	}
    }
    
    function alignMsg(message, direction){
    	const elem = document.createElement("li")
    	elem.innerHTML = message
    	if(direction == "center") {
    		elem.classList.add("center");
    	}
    	
    	elem.style.textAlign = ""+direction
    	chatMsgs.appendChild(elem)
    }
    
    //새로 채팅방에 들어온 멤버를 추가하기
    function addMemberList(memberId) {
    	let chatMembers = document.querySelectorAll('ul.chatMemberList > li > span')
    	let memberArr = []
    	chatMembers.forEach(el => memberArr.push(el.innerText))
    	
    	if(!memberArr.includes(memberId)) {
            let chatMemberList = document.querySelector('ul.chatMemberList')
        	let newMemberLi = document.createElement("li");
            let newMemberSpan = document.createElement("span");
            newMemberSpan.innerText = memberId
        	newMemberLi.appendChild(newMemberSpan)
        	chatMemberList.appendChild(newMemberLi)
    	}
    }
    
    function removeMemberList(memberId) {
    	let chatMembers = document.querySelectorAll('ul.chatMemberList > li')
    	for(member of chatMembers) {
    		if(member.querySelector('span').innerText == memberId) {
    			member.remove()
    		}
    	}
    	
    }
    
    function leaveChatRoom(event) {

    	console.log("leave event")
    	console.log(event)
    	let chatForm = {
    			chatroomSeq: chatroomSeq,
    			memberSeq: memberSeq,
    			messageType: "LEAVE",
    	}   
    	
    	sockStomp.send("/chat/groupchat/"+chatroomSeq, {}, JSON.stringify(chatForm))
    	sockStomp.ws.close()
    	
    }
    	
    
    
    

    </script>
</html>

