
//webSocket관련 코드



let socket = null; //socket을 전역으로 쓰기 위해!

//예제에서는 footer에 두었다. 어느 페이지에 있더라도 alarm을 받을 수 있도록
//header에 해당하는 menu에 이 자스코드를 두면 실행이 안되는 것 같다..

// window.onload = function(){
	
	connect();

// }	


function connect(){
	//1. 웹소켓 연결(pf-servlet.xml에 설정한 path)
// 	let ws = new WebSocket("ws://localhost:8080/pf/websocket.do");
	let ws = new WebSocket("/pf/websocket.do");
// 	let ws = new WebSocket("/ws/websocket.do");
	//socket을 전역으로 사용할 수 있도록
	socket = ws 
	
	
	//2. open 이벤트리스너 등록
	ws.addEventListener("open", (event) => {
		console.log(event)
		console.log("socket connected")
	})
	//3. message 이벤트리스너 등록 (message를 통해 데이터를 수신할 때 발생하는 이벤트)
	ws.addEventListener("message", (event) => {
// 		alert(event.data)
		let msgAlert = document.querySelector('#msgAlert');
		msgAlert.innerHTML = event.data
		msgAlert.style.display = 'block'
		
		setTimeout(function(){
			msgAlert.style.display = 'none'
			},5000); //애니메이션 효과를 주고 싶었는데, 적용이 잘 안됨
		console.log("Message from server : ", event.data)
	})

	//4. close 이벤트리스너 등록
	ws.addEventListener("close", (event) => {
		console.log(event.code)
		console.log(event)
		console.log("socket closed")
	})
	//5. error 이벤트리스너 등록 
	ws.addEventListener("error", (event) => {
		console.log("WebSocket Error : ", event)
	})
	//2~5는 모두 웹소켓 연결이 이루어진 이후에 의미 있으므로 connect() 내부에서 정의
}
