<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<%
String ctx = request.getContextPath();
%>

<!-- swiper -->
<link rel="stylesheet" href="https://unpkg.com/swiper@6.8.4/swiper-bundle.min.css" />
<link rel="stylesheet" href="<%=ctx%>/assest/template/css/swiper.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons" />

	<!--================================
	    START FEATURE AREA
	=================================-->
    <section class="features section--padding modal-open" >
    
    <div class="promotion">
      <div class="swiper-container">
      <!-- swiper wrapper -->
        <div class="swiper-wrapper">
        
          <div class="swiper-slide">
          	<div class="feature">
              <img src="<c:url value='/assest/template/images/lemon.png'/>" width="50px" height="50px"/>
              <div class="feature__title">
                  <h3 style="font-weight: 600;">About This Portfolio</h3>
              </div>
              <div class="feature__desc" style="text-align:left;">
                  <p><span style="font-weight: 600; padding-top: 30px;"> 💡 목표 </span> 
                  : 웹 페이지의 기본 기능을 전체적으로 스스로 구현해보고 AWS를 활용해 직접 배포하기</p>
                  <p><span style="font-weight: 600;"> 💡 기능 요약 </span><p>
                  <div style="padding-left: 30px;">
					  <p>1. 회원가입 및 로그인, 비밀번호 찾기</p>
					  <p>2. 게시판 CRUD, 댓글, 좋아요/싫어요</p> 
					  <p>3. 파일 첨부 및 다운로드</p>
					  <p>4. WebSocket을 활용한 댓글 알림</p>
					  <p>5. STOMP를 활용한 채팅방 구현</p>
                  </div>
              </div>
              <a href="https://pacific-soil-139.notion.site/1d2d062cb6ed41d0a3e0efc66cab4cbf?pvs=4" target="_blank" class="swiper-btn">자세히 보기</a>
          	</div>
          </div>
          
          <div class="swiper-slide">
          	<div class="feature">
              <img src="<c:url value='/assest/template/images/lemon.png'/>" width="50px" height="50px"/>
              <div class="feature__title">
                  <h3 style="font-weight: 600;">ABOUT ME</h3>
              </div>
              <div class="feature__desc" style="text-align:left;">
                  <h5 style="font-weight: 600;text-align:center;"> 💻 집중력과 꼼꼼함을 갖춘 신입 BackEnd개발자 박문주입니다. </h5>
<!--                   <p><span style="font-weight: 600;"> 💡 SKILL </span><p> -->
                  <div style="padding-top: 30px;">
                  <p>  안녕하세요! 저는 몰입과 꼼꼼함, 빠른 이해력을 바탕으로 문제 해결력을 발휘하는 열정적인 신입 개발자 박문주입니다.
				  <br>&nbsp;&nbsp;새로운 지식을 탐구하는 것을 좋아해 생명과학 대학원에 진학했으나, 스스로 직접 무언가를 만드는 일에 희열을 느끼는 성향임을 깨닫고 
				  제과 학교에 진학 후 파티셰로서 일을 하던 중 우연히 프로그래밍의 매력에 빠지게 되어 개발자의 길을 선택하게 되었습니다. 
 				  <br>&nbsp;&nbsp; 크라우드 펀딩을 주제로 한 팀 프로젝트와, 회원가입 및 로그인/게시판/채팅 등의 기능을 구현한 개인 프로젝트를 진행한 경험이 있습니다.
				  <br>&nbsp;&nbsp; 주변으로 받은 도움을 잊지 않고 연차가 쌓일수록 의미있는 지식과 경험을 주변에 나눌 수 있는 개발자가 되고 싶습니다. </p>
<!-- 					  <p>Backend : SpringFramework, SpringBoot, Java, JSP</p> -->
<!-- 					  <p>Frontend : HTML, CSS, Javascript, JQuery</p>  -->
<!-- 					  <p>Database : MySQL, Oracle</p> -->
<!-- 					  <p>Else : Git, Github, AWS, Nginx, MobaXterm</p> -->
                  </div>
              </div>
              <a href="<c:url value='/aboutMe.do'/>" class="swiper-btn">자세히 보기</a>
          	</div>
          </div>
          
          <div class="swiper-slide">
          	<div class="feature">
              <img src="<c:url value='/assest/template/images/lemon.png'/>" width="50px" height="50px"/>
              <div class="feature__title">
                  <h3 style="font-weight: 600;">TroubleShooting 1</h3>
              </div>
              <div class="feature__desc" style="text-align:left;">
                  <h5 style="font-weight: 600;text-align:center;"> zip파일로 전체 파일 다운로드 구현시 원본 파일 이름을 유지하기 </h5>
                  <p style="padding-top: 30px;"><span style="font-weight: 600;"> 🚨 문제 상황 </span></p>
                  <div style="padding-left: 30px;">
					  <p>- 게시글에 첨부된 파일이 2개 이상일 경우, zip 파일로 한번에 다운 받는 옵션이 있다.
					  <br>- 기존 zip파일을 만드는 메서드에서는 File타입의 List를 인자로 받고 있기 때문에,
					  <br> 유저가 zip파일을 다운로드 받아서 압축을 해제시, 업로드시의 원본 파일명을 얻을 수 없다.</p>
                  </div>
                  <p><span style="font-weight: 600;"> 💡 해결 </span><p>
                  <div style="padding-left: 30px;">
					  <p>- File 클래스를 상속받는 CustomFile 클래스를 정의하고 orgFileNm을 필드에 추가했다.
					  <br>- zip파일을 만드는 메서드에서 CustomFile 타입의 List를 인자로 받아
					  <br>- 유저가 zip파일 압축 해제시, 원본 파일명으로 파일을 얻을 수 있게 개선했다.</p>
                  </div>

              </div>
              <a href="https://pacific-soil-139.notion.site/1d2d062cb6ed41d0a3e0efc66cab4cbf?pvs=97#2d2a43726add44529b10c3a0f1189c6f" target="_blank" class="swiper-btn">자세히 보기</a>
          	</div>
          </div>
          
          <div class="swiper-slide">
          	<div class="feature">
              <img src="<c:url value='/assest/template/images/lemon.png'/>" width="50px" height="50px"/>
              <div class="feature__title">
                  <h3 style="font-weight: 600;">TroubleShooting 2</h3>
              </div>
              <div class="feature__desc" style="text-align:left;">
                  <h5 style="font-weight: 600;text-align:center;"> 민감한 설정파일 암호화하기 </h5>
                  <p style="padding-top: 30px;"><span style="font-weight: 600;"> 🚨 문제 상황 </span></p>
                  <div style="padding-left: 30px;">
					  <p>- DB나 JavaMailSender 관련 설정들은 개인정보가 코드에 그대로 노출되게 된다.
					  <br>- .gitignore로 해당 파일들을 깃으로 관리하지 않을 수 있지만, war파일 배포시 해당 파일들의 정보가 필요한 경우도 있으므로 단순히 설정 파일을 올리지 않는 것이 해결책이 될 수가 없었다.</p>
                  </div>
  
                  <p><span style="font-weight: 600;"> 💡 해결 </span><p>
                  <div style="padding-left: 30px;">
					  <p>- Jasypt 라이브러리를 이용하여 설정 정보를 암호화했다.
					  <br>- 민감한 정보들을 암호화함으로써 파일이 노출되어도 안전을 보장받을 수 있다.
					  <br>- 암호화 key를 환경변수로 직접 등록하는 방식을 택함으로써, key를 노출시키지 않을 수 있다.</p>
                  </div>

              </div>
              <a href="https://velog.io/@melodie104/Jasypt를-이용한-설정-정보-암호화" target="_blank" class="swiper-btn">자세히 보기</a>
          	</div>
          </div>
          
          <div class="swiper-slide">
          	<div class="feature">
              <img src="<c:url value='/assest/template/images/lemon.png'/>" width="50px" height="50px"/>
              <div class="feature__title">
                  <h3 style="font-weight: 600;">TroubleShooting 3</h3>
              </div>
              <div class="feature__desc" style="text-align:left;">
                  <h5 style="font-weight: 600;text-align:center;"> EC2환경에서 WebSocket Connection Error 해결하기 </h5>
                  <p style="padding-top: 30px;"><span style="font-weight: 600;"> 🚨 문제 상황 </span></p>
                  <div style="padding-left: 30px;">
					  <p>- 로컬 환경에서는 잘 생성되던 WebSocket Connection이 war파일을 원격 서버에 올리자 연결되지 않는 현상이 발생했다.
                  </div>
                  <p><span style="font-weight: 600;"> 💡 해결 </span><p>
                  <div style="padding-left: 30px;">
					  <p>- upgrade 헤더는 proxy server로 전달되지 않으니 프록시 설정에 직접 upgrade 관련된 헤더를 명시해줌으로써 해결이 가능했다.
					  <br>- 프록시를 설정한 pf.conf 파일에 직접 upgrade 관련 헤더를 명시해주었더니 원격 환경에서도 로컬에서와 같이 WebSocket연결이 성공적으로 이루어짐을 확인할 수 있었다.</p>
                  </div>

              </div>
              <a href="https://velog.io/@melodie104/EC2-환경에서-WebSocket-Connection-Error-해결" target="_blank" class="swiper-btn">자세히 보기</a>
          	</div>        
          </div>
        
        </div>
        <!-- swiper wrapper end -->
        
      </div>
      
      <div class="swiper-pagination"></div>
      <div class="swiper-prev">
        <div class="material-icons" >arrow_back</div>
      </div>
      <div class="swiper-next">
        <div class="material-icons">arrow_forward</div>
      </div>
      
    </div>

        
   <!-- Modals -->
    <div class="modal fade remail" id="myModal1">
        <div class="modal-dialog modal-lg modal-dialog-centered" role="document">
            <div class="modal-content">
                <!-- end /.modal-header -->
                <div class="modal-body">
					<div class="cardify recover_pass">
                            <div class="login--header">
                                <p>메일 재발송을 위해 가입시 입력한 아이디와 이메일을 입력해주세요.</p>
                            </div>
                            <!-- end .login_header -->
                            <form action="<c:url value='/auth/remail.do'/>" method="post">
	                            <div class="login--form">
	                                <div class="form-group">
	                                    <label for="id">Enter your ID</label>
	                                    <input id="id" type="text" class="text_field" placeholder="Enter your id" name="memberId" value="${memberId}">
	                                </div>
	                                <div class="form-group">
	                                    <label for="ema	il">Enter your Email</label>
	                                    <input id="email" type="text" class="text_field" placeholder="Enter your email" name="email" value="${email }">
	                                </div>
	                                <button class="btn btn--md btn--round register_btn" type="submit">인증 메일 재전송</button>
	                            </div>
                            </form>
                            <!-- end .login--form -->
                        </div>
                        <!-- end .cardify -->
                </div>
                <!-- end /.modal-body -->
            </div>
        </div>
    </div>
    </section>
    
    <script>
    let msg = '${msgObject.msg}'
    let code = '${msgObject.code}'
    
    console.log("code="+code)
    console.log("msg="+msg)
    
    
   	if(code == 101) {
    		//인증메일 시간 초과인 경우 다른 메시들과 다르게 처리
    		remail(msg)
   	} else if (msg!=''){
   		console.log(code)
   		alert(msg)
   	}
    	

    
    //window.onload 왜 작동 안하지?
    		
//     window.onload = function(){
//     	console.log("window.onload")
//     	if(code == 101) {
//     		//인증메일 시간 초과인 경우 다른 메시들과 다르게 처리
//     		remail(msg)
//     	} else if (msg!=''){
//     		console.log(code)
//     		alert(msg)
//     	}
//     } 
    
    function remail(msg){
   		let remailMsg = msg + '\n인증메일을 다시 받으시겠습니까?'
    	if(!confirm(remailMsg)){
    		return;
    	}
	   	document.querySelector('div.remail').style.display = 'block'
	   	document.querySelector('div.remail').classList.add('show')
    	
    }
    </script>
    <!--================================
	    END FEATURE AREA
	=================================-->
