<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
    <!--================================
	    START FOOTER AREA
	=================================-->
	<style>
	.footer-align {
		width: 100%;
		display: flex;
		flex-direction: column;
		align-items: center;
		justify-content: space-between;
		text-align:center;
	}
	
	
/* 	.footer-layout-left{ */
/* 		flex: 0 0 35%; */
/* 		max-with: 35%; */
/* 	} */
/* 	.footer-layout-right{ */
/* 		flex: 0 0 65%; */
/* 		max-with: 65%; */
/* 	}	 */
	
	</style>
    <footer class="footer-area">
        <div class="footer-big section--padding">
            <!-- start .container -->
            <div class="container">
                <div class="row footer-align">
                    <ul class="info-contact">
                    <h3 class="footer-widget-title text--white" style="font-weight:bold;">CONTACT ME</h3>
                        <p>
                            <span class="info">
                            <i class="fa-solid fa-envelope info-icon"></i> 
                              novecento104@gmail.com</span>
                        </p>
                    </ul>
                        
					<div class="social social--color--filled">
                        <ul>
                            <li>
                                <a href="<c:url value='/contactMe.do'/>">
                                    <img src="<c:url value='/assest/template/images/lemon.png'/>" width="40px" height="40px"/>
                                </a>
                            </li>
                            <li>
                                <a href="https://github.com/pickylemon/2024-portfolio-2nd">
                                    <img src="<c:url value='/assest/template/images/github.png'/>" width="40px" height="40px"/>
                                </a>
                            </li>
                            <li>
                                <a href="https://velog.io/@melodie104/series/Exception-%EB%AA%A8%EC%9D%8C">
                                   <img src="<c:url value='/assest/template/images/velog.png'/>" width="40px" height="40px"/>
                                </a>
                            </li>
                        </ul>
                    </div> 
<!--                     <div class="footer-layout-left"> -->
<!--                         <div class="info-footer"> -->

<!--                             <p class="info--text"> -->
                            
<!--                             </p> -->

<!--                         </div> -->
<!--                         end /.info-footer -->
<!--                     </div> -->
                    <!-- end /.col-md-3 -->


<!--                     <div class="footer-layout-right"> -->
<!--                         <div class="newsletter"> -->
<!--                             <h4 class="footer-widget-title text--white">Newsletter</h4> -->
<!--                             <p>Subscribe to get the latest news, update and offer information. Don't worry, we won't send spam!</p> -->
<!--                             <div class="newsletter__form"> -->
<%--                                 <form action="#"> --%>
<!--                                     <div class="field-wrapper"> -->
<!--                                         <input class="relative-field rounded" type="text" placeholder="Enter email"> -->
<!--                                         <button class="btn btn--round" type="submit">Submit</button> -->
<!--                                     </div> -->
<%--                                 </form> --%>
<!--                             </div> -->
<!--                         </div> -->
<!--                         end /.newsletter -->
<!--                     </div> -->
                    <!-- end /.col-md-4 -->
                </div>
                <!-- end /.row -->
            </div>
            <!-- end /.container -->
        </div>
        <!-- end /.footer-big -->

        <div class="mini-footer">
            <div class="container">
                <div class="row">
                    <div class="col-md-12">
                        <div class="copyright-text">
                            <div class="info__logo">
                                <img src="<c:url value='/assest/template/images/myLogo.png'/> " alt="footer logo" width="200" height="auto"/>
                            </div>
                        </div>

                        <div class="go_top">
                            <span class="lnr lnr-chevron-up"></span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </footer>
    
    <!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.3.0/sockjs.min.js"></script> -->
 
<script>
//webSocket관련 코드


let socket = null; //socket을 전역으로 쓰기 위해!

//예제에서는 footer에 두었다. 어느 페이지에 있더라도 alarm을 받을 수 있도록
//header에 해당하는 menu에 이 자스코드를 두면 실행이 안되는 것 같다..

window.onload = function(){
	connect()
}	


function connect(){
	//1. 웹소켓 연결(pf-servlet.xml에 설정한 path)
// 	let ws = new WebSocket("ws://localhost:8080/pf/websocket.do");
	let ws = new WebSocket("/pf/websocket.do");
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
		console.log(event)
		console.log("socket closed")
	})
	//5. error 이벤트리스너 등록 
	ws.addEventListener("error", (event) => {
		console.log("WebSocket Error : ", event)
	})
	//2~5는 모두 웹소켓 연결이 이루어진 이후에 의미 있으므로 connect() 내부에서 정의
}
</script>

    <!--================================
    END FOOTER AREA
	=================================-->
