<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
 
 
<style>
body {
 	background-color: #fffbec; 
}

 .aboutMe { 
 	padding: 50px 0; 
} 


.timeline .happening .happening--detail:before {
	position: absolute;
    content: '';
    left: 0;
    top: 0;
    width: 4px;
    height: 100%;
    background: #ebecf1;
    z-index: -1;
    -webkit-transform: translateX(-50%);
    -ms-transform: translateX(-50%);
    transform: translateX(-50%);
}

p.skill {
    font-size: 15px;
    line-height: 30px;
    color: #555555;
    font-weight: 600;
    margin: 16px 0;

}

.cert, .projectList {
	display: flex;
	flex-direction: row;
	justify-content: space-around;

}
.testimonial {
	width: 535px;


}


.pjTitle {
	display: flex;
	flex-direction: row;
 	align-items: center; 

}

.pjDetail {
    font-size: 16px;
    line-height: 26px;
    color: #555555;
    font-weight: 400;
}

.pjDetail li {
	margin-bottom: 10px;

}
.introTxt {

}

.fa-lemon {
	color: #ffd84d;

}



.testimonial {
	position: relative;

}

.btn-pj {
	text-align: right;
	position: absolute;
	bottom: 20px;
	right: 20px;
}

.exception {
	height: 510px;

}


</style>
    <!--================================
    START TIMELINE AREA
=================================-->
    <section class="team_area section--padding aboutMe">
        <div class="container">
            <!-- start row -->
            <div class="row">
                <!-- start col-md-12 -->
                <div class="col-md-12">
                    <div class="section-title">
                        <h1>
                            <span class="highlighted">안녕하세요,</span>
                        </h1>
                        <h2>집중력과 꼼꼼함을 갖춘 신입 BackEnd개발자 박문주입니다.</h2>
                    </div>
                    <div class="introTxt">
                    <p>&emsp;안녕하세요! 저는 몰입과 꼼꼼함, 빠른 이해력을 바탕으로 문제 해결력을 발휘하는 열정적인 신입 개발자 박문주입니다. <br>
                    &emsp;새로운 지식을 탐구하는 것을 좋아해 생명과학 대학원에 진학했으나, 스스로 직접 무언가를 만드는 일에 희열을 느끼는 성향임을 깨닫고 제과 학교에 진학 후 파티셰로서 일을 하던 중 
                    우연히 프로그래밍의 매력에 빠지게 되어 개발자의 길을 선택하게 되었습니다. 
                    <p>&emsp;지난 해 10월, 정석코딩 백엔드 부트캠프 과정을 통해 개발 공부를 본격적으로 시작했습니다. 
             		Java와 Spring을 깊이 있게 학습했으며, 데이터 모델링과 SQL학습을 통해 백엔드 개발자로서 갖추어야 할 데이터 처리 능력을 길렀습니다.
             		또한 HTML, CSS, JavaScript 등을 학습하며 웹 개발 전반에 대한 이해를 높였습니다.</p>
                    <p>&emsp;부트캠프 당시 크라우드 펀딩을 주제로한 팀 프로젝트를 진행하였고, 데이터 모델링부터 HTML, CSS를 통한 템플릿을 제작, 백엔드 로직까지 
                    웹개발의 모든 파트를 직접 구현한 경험이 있습니다.
                    또한 지난 3월 부트캠프 수료 후 스프링, JPA 스터디에 참여해 스프링의 기본 원리를 다시 복습하고, ORM 기술을 체계적으로 학습했습니다.
                    아울러 개인 프로젝트로 해당 사이트를 만들어 로그인, 회원가입, 게시판, 파일 업/다운로드, 채팅 등의 기능을 구현하였고, AWS EC2, RDS와 Nginx를 웹서버로 활용해 배포함으로써 웹 개발에 대해 더 깊은 이해할 수 있었습니다.</p>
                    
                    <p>&emsp;개발 공부를 시작할 때 많은 분들의 도움을 받았기에, 그 감사함을 잊지 않고 연차가 쌓일수록 의미있는 지식과 경험을 주변에 도움이 되는 개발자가 되고 싶습니다. 
                    업무에 대해 같이 고민하고 협력할 수 있는 동료, 믿을 수 있고 함께 일 하고 싶은 구성원이 되고 싶고, 동료들과 더불어 성장하는 개발자가 되고 싶습니다.</p>
                    </div>

                </div>
                <!-- end /.col-md-12 -->
            </div>
            <!-- end /.row -->

           
        </div>
        <!-- end /.container -->
    </section>
    <hr>
    <section class="timeline_area section--padding aboutMe">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <div class="section-title">
                        <h1>EDUCATION 
                            <span class="highlighted"> & CAREER</span>
                        </h1>
                    </div>
                </div>
                <!-- end /.col-md-12 -->
            </div>
            <!-- end /.row -->

            <div class="row">
                <div class="col-md-12">
                    <ul class="timeline">
                        <li class="happening">
                            <div class="happening--period">
                                <p>2015.08</p>
                            </div>
                            <div class="happening--detail">
                                <h4 class="title">성균관대학교 자연과학대학 졸업</h4>
                                <p>생명과학과, 프랑스어문학과(복수 전공) 졸업
                                <br>
                                학점 : 4.3 / 4.5</p>
                            </div>
                        </li>

                        <li class="happening">
                            <div class="happening--period">
                                <p>2016.10 ~ 2018.10</p>
                            </div>
                            <div class="happening--detail">
                                <h4 class="title">프릳츠 커피 컴퍼니</h4>
                                <p>바리스타 정직원</p>
                            </div>
                        </li>

                        <li class="happening">
                            <div class="happening--period">
                                <p>2019.07 ~ 2012.03</p>
                            </div>
                            <div class="happening--detail">
                                <h4 class="title">삐아프</h4>
                                <p>쇼콜라티에 정직원</p>
                            </div>
                        </li>

                        <li class="happening">
                            <div class="happening--period">
                                <p>2021.09 ~ 2022.04</p>
                            </div>
                            <div class="happening--detail">
                                <h4 class="title">르 꼬르동 블루 서울</h4>
                                <p>제과 디플로마 과정 수료</p>
                            </div>
                        </li>
                        
                        <li class="happening">
                            <div class="happening--period">
                                <p>2022.07 ~ 2023.11</p>
                            </div>
                            <div class="happening--detail">
                                <h4 class="title">마얘</h4>
                                <p>파티셰 정직원</p>
                            </div>
                        </li>
                        
                        <li class="happening">
                            <div class="happening--period">
                                <p>2023.12 ~ 2023.08</p>
                            </div>
                            <div class="happening--detail">
                                <h4 class="title">1인 케이크 가게 운영(자영업)</h4>
                            </div>
                        </li>

                        <li class="happening">
                            <div class="happening--period">
                                <p>2023.10 ~ 2024.03</p>
                            </div>
                            <div class="happening--detail">
                                <h4 class="title">정석코딩 부트캠프 백엔드 과정 수료</h4>
                                <p>Java, Spring, MySQL, Oracle, 
                                <br> HTML, CSS, JavaScript, 데이터 모델링 등 학습 및 팀 프로젝트 </p>
                            </div>
                        </li>
                        <li class="happening">
                            <div class="happening--period">
                                <p>2024.03 ~ </p>
                            </div>
                            <div class="happening--detail">
                                <h4 class="title">Spring, JPA 스터디 및 개인 프로젝트 진행</h4>
                                <p> AWS EC2, RDS
                                <br> Nginx를 웹서버로 활용해 개인 프로젝트 배포 </p>
                            </div>
                        </li>

                    </ul>
                    <!-- end /.timeline -->
                </div>
                <!-- end /.col-md-12 -->
            </div>
            <!-- end /.row -->
        </div>
        <!-- end /.container -->
    </section>
    <!--================================
    END TIMELINE AREA
=================================-->


    <!--================================
    START COUNTER UP AREA2
=================================-->
	<hr>
    <section class="counter-up-area counter-up--area2 aboutMe">
        <!-- start .container -->
        <div class="container">
            <div class="row">

            <!-- start .col-md-12 -->
            <div class="col-md-12">
                    <div class="section-title">
                        <h1>
                            <span class="highlighted">CERTIFICATES</span>
                        </h1>
                    </div>
                <div class="counter-up cert">
                    <div class="counter mcolor1">
                        <span class="lnr lnr-smile"></span>
                        <span class="count">정보처리기사(필기)</span>
                        <span>24.05.09 응시 (94/100)</span>
                    </div>
                    <div class="counter mcolor3">
                        <span class="lnr lnr-smile"></span>
                        <span class="count">SQLD</span>
                        <br>
                        <span>24.05.25 응시 (88/100)</span>
                    </div>                    
                </div>
            </div>
            <!-- end /.col-md-12 -->
           </div>
        </div>
        <!-- end /.container -->
    </section>
    <!--================================
    END COUNTER UP AREA2
=================================-->

    <!--================================
    START MARTPLACE TEAM AREA
=================================-->
	<hr>
    <section class="team_area section--padding aboutMe">
        <div class="container">
            <!-- start row -->
            <div class="row">
                <!-- start col-md-12 -->
                <div class="col-md-12">
                    <div class="section-title">
                        <h1>
                            <span class="highlighted">Projects</span>
                        </h1>
                    </div>
                </div>
                <!-- end /.col-md-12 -->
            </div>
            <!-- end /.row -->

            <div class="projectList">
                 <div class="testimonial pj">
                     <div class="testimonial__about pjTitle">
                         <div class="avatar v_middle">
                             <img src="<c:url value='/assest/template/images/fundly-logo.png'/>" alt="fundly"/>
                         </div>
                         <div class="name-designation v_middle">
                             <h4 class="name">Fundly</h4>
                             <span class="desig">크라우드 펀딩 플랫폼 팀프로젝트</span>
                         </div>
                     </div>
                     <hr>
                     <div class="testimonial__text">
	                         <ul class="pjDetail">
		                         <li><i class="fa-solid fa-lemon"></i>&ensp;프로젝트 등록 파트 뷰 구현(HTML, CSS, JS, Tiles)</li>
		                         <li><i class="fa-solid fa-lemon"></i>&ensp;datepicker와 공휴일api를 이용해 제 7영업일 구하는 로직 구현</li>
		                         <li><i class="fa-solid fa-lemon"></i>&ensp;프로젝트에 포함되는 상품(아이템 및 선물) CRUD 및 Tx, Validation 처리</li>
		                         <li><i class="fa-solid fa-lemon"></i>&ensp;위즈윅 에디터를 활용한 상품 이미지 업로드 및 상품 설명 CRUD 및 Tx, Validation 처리</li>
	                         </ul>
                     </div>
                     <div class="btn-pj">
					 	<a href="https://pacific-soil-139.notion.site/Fundly-52bc32bc991b46a789760a5b952df59f" target="_blank" class="btn btn--icon btn-sm btn--round btn-info"> MORE </a>                     
                     </div>
                 </div>
                 
                 <div class="testimonial pj">
                     <div class="testimonial__about">
                         <div class="avatar v_middle">
                             <img src="<c:url value='/assest/template/images/myLogo.png'/>" alt="portfolio">
                         </div>
                         <div class="name-designation v_middle">
                             <h4 class="name">개인 프로젝트</h4>
                             <span class="desig">회원가입, 로그인, 게시판, 채팅 등</span>
                         </div>
                     </div>
                     <hr>
                     <div class="testimonial__text">
	                         <ul class="pjDetail">
		                         <li><i class="fa-solid fa-lemon"></i>&ensp;회원가입, 로그인 및 유저 정보 암호화(BCrypt), 로그인 필터 구현</li>
		                         <li><i class="fa-solid fa-lemon"></i>&ensp;게시판 CRUD, 좋아요/싫어요, 댓글, 검색 기능 구현</li>
		                         <li><i class="fa-solid fa-lemon"></i>&ensp;파일 업로드 및 다운로드, zip 파일 다운로드 구현</li>
		                         <li><i class="fa-solid fa-lemon"></i>&ensp;WebSocket과 STOMP를 활용한 댓글 알림 및 채팅 기능 구현</li>
	                         </ul>
                     </div>
                     <div class="btn-pj">
					 	<a href="https://pacific-soil-139.notion.site/1d2d062cb6ed41d0a3e0efc66cab4cbf?pvs=4" target="_blank" class="btn btn--icon btn-sm btn--round btn-info"> MORE </a>                     
                     </div>
                     </div>
                 </div>

            </div>
            <!-- end /.row -->
        </div>
        <!-- end /.container -->
    </section>
    <!--================================
    END MARTPLACE TEAM AREA
=================================-->

    <!--================================
    START PARTNER AREA
=================================-->
	<hr>
    <section class="partner-area section--padding partner--area2 bgimage aboutMe">
        <!-- start container -->
        <div class="container">
            <!-- start row -->
            <div class="row">
                <!-- start col-md-12 -->
                <div class="col-md-12">
                    <div class="section-title">
                        <h1>
                            <span class="highlighted">SKILLS</span>
                        </h1>
                    </div>
                </div>
                <!-- end /.col-md-12 -->
            </div>
            <!-- end /.row -->

            <div class="row">
                <div class="col-md-12">
                    <div class="partners">
	                    <div class="partners-inner">
	                        <div class="partner">
								<img src="<c:url value='/assest/template/images/svg/badges/Java-Dark.svg'/>" width="50px" height="50px" alt="Java">
	                        	<p class="skill">Java</p>
	                        </div>
	                        <div class="partner">
								<img src="<c:url value='/assest/template/images/svg/badges/Spring-Light.svg'/>" width="50px" height="50px" alt="Spring">
	                        	<p class="skill">Spring</p>
	                        </div>
	                        <div class="partner">
								<img src="<c:url value='/assest/template/images/svg/badges/springboot-color.svg'/>" width="50px" height="50px" alt="springboot">
	                        	<p class="skill">SpringBoot</p>
	                        </div>
	                        <div class="partner">
								<img src="<c:url value='/assest/template/images/svg/badges/MySQL-Light.svg'/>" width="50px" height="50px" alt="MySQL">
	                        	<p class="skill">MySQL</p>
	                        </div>
	                        <div class="partner">
								<img src="<c:url value='/assest/template/images/svg/badges/oracle-color.svg'/>" width="50px" height="50px" alt="oracle">
	                        	<p class="skill">Oracle</p>
	                        </div>
	                        <div class="partner">
	                            <img src="<c:url value='/assest/template/images/svg/badges/apachemaven-color.svg'/>" width="50px" height="50px" alt="ApacheMaven">
	                        	<p class="skill">Apache Maven</p>
	                        </div>
	                        <div class="partner">
								<img src="<c:url value='/assest/template/images/svg/badges/apachetomcat-color.svg'/>" width="50px" height="50px" alt="ApacheTomcat">
	                        	<p class="skill">Apache Tomcat</p>
	                        </div>
	                    </div>

	                    <div class="partners-inner">
	                        <div class="partner">
								<img src="<c:url value='/assest/template/images/svg/badges/JavaScript.svg'/>" width="50px" height="50px" alt="JavaScript">
	                        	<p class="skill">JavaScript</p>
	                        </div>
	                        <div class="partner">
								<img src="<c:url value='/assest/template/images/svg/badges/JQuery.svg'/>" width="50px" height="50px" alt="JQuery">
	                        	<p class="skill">JQuery</p>
	                        </div>
	                        <div class="partner">
								<img src="<c:url value='/assest/template/images/svg/badges/AWS-Dark.svg'/>" width="50px" height="50px" alt="AWS">
	                        	<p class="skill">AWS</p>
	                        </div>
	                        <div class="partner">
								<img src="<c:url value='/assest/template/images/svg/badges/Git.svg'/>" width="50px" height="50px" alt="Git">
	                        	<p class="skill">Git</p>
	                        </div>
	                        <div class="partner">
								<img src="<c:url value='/assest/template/images/svg/badges/Github-Dark.svg'/>" width="50px" height="50px" alt="GitHubDark">
	                        	<p class="skill">Github</p>
	                        </div>
	                        <div class="partner">
								<img src="<c:url value='/assest/template/images/svg/badges/html5-color.svg'/>" width="50px" height="50px" alt="HTML">
	                        	<p class="skill">HTML5</p>
	                        </div>
	                        <div class="partner">
								<img src="<c:url value='/assest/template/images/svg/badges/CSS.svg'/>" width="50px" height="50px" alt="CSS">
	                        	<p class="skill">CSS</p>
	                        </div>

	                    </div>

                    </div>
                </div>
            </div>
            <!-- end /.row -->
        </div>
        <!-- end /.container -->
    </section>
    <!--================================
    END PARTNER AREA
=================================-->

    <!--================================
    START TESTIMONIAL
=================================-->
	<hr>
    <section class="testimonial-area testimonial--2 section--padding aboutMe">
        <!-- start .container -->
        <div class="container">
            <!-- start row -->
            <div class="row">
                <!-- start col-md-12 -->
                <div class="col-md-12">
                    <div class="section-title">
                        <h1>Exception
                            <span class="highlighted">TroubleShooting</span>
                        </h1>
                        <p>프로젝트를 진행하며 마주친 예외들을 해결하고 블로그에 정리했습니다.</p>
                    </div>
                </div>
                <!-- end /.col-md-12 -->
            </div>
            <!-- end /.row -->

            <!-- start row -->
            <div class="row">
                <!-- start .col-md-12 -->
                <div class="col-md-12">
                    <div class="testimonial-slider">
                        <div class="testimonial exception">
                            <div class="testimonial__about">
                                <div class="name-designation v_middle">
                                    <h4 class="name">DB 무결성 위반 관련 Exception</h4>
                                    <span class="desig">java.sql.SQLIntegrityConstraintViolationException</span>
                                </div>
                            </div>
		                    <div class="testimonial__text">
		                         <ul class="pjDetail">
			                         <li><i class="fa-solid fa-lemon"></i>&ensp; 상황 : 게시판에서 게시물 삭제시, 게시글 정보를 DB에서 먼저 지우는 메서드를 호출하고 첨부파일 정보를 DB에서 지우는 메서드를 호출.</li>
			                         <li><i class="fa-solid fa-lemon"></i>&ensp; 원인 : 첨부파일 테이블은 게시판 테이블의 board_seq와 board_type_seq를 FK로 가지고 있는 상황 & FK 제약조건이 ON DELETE RESTRICT인 상황.</li>
			                         <li><i class="fa-solid fa-lemon"></i>&ensp; 해결 : 즉, FK 제약조건이 RESTRICT로 걸려있기 때문에 자식 테이블인 첨부파일 테이블 부터 delete를 수행하고 부모테이블인 게시판 테이블의 delete 쿼리를 수행해야 FK 무결성을 위반하지 않는다.</li>		                         </ul>
		                     </div>
		                     <div class="btn-pj">
							 	<a href="https://velog.io/@melodie104/ingjava.sql.SQLIntegrityConstraintViolationException" target="_blank" class="btn btn--icon btn-sm btn--round btn-info"> MORE </a>                     
		                     </div>
                        </div>
                        <!-- end /.testimonial -->

                        <div class="testimonial exception">
                            <div class="testimonial__about">
                                <div class="name-designation v_middle">
                                    <h4 class="name">로그인 필터 관련 Exception</h4>
                                </div>
                            </div>
		                    <div class="testimonial__text">
		                         <ul class="pjDetail">
			                         <li><i class="fa-solid fa-lemon"></i>&ensp; 상황 : 로그인 검증이 필요한 페이지들에 각각 중복 로직을 두지 않고 로그인 필터를 만들어서 공통으로 처리하려는 상황. 하지만 로그를 보면 로그인 페이지로 바로 redirect가 되지 않았다.</li>
			                         <li><i class="fa-solid fa-lemon"></i>&ensp; 원인 및 해결 : response.sendRedirect 이후에 꼭!! return문을 넣어주어야 한다. return문이 없으니 아래 로직까지 다 실행되어 버린 것.</li>
		                         </ul>
		                     </div>
	                        <div class="btn-pj">
						 	   <a href="https://velog.io/@melodie104/로그인-필터가-제대로-작동하지-않는-현상" target="_blank" class="btn btn--icon btn-sm btn--round btn-info"> MORE </a>                     
	                        </div>
                        </div>
                        <!-- end /.testimonial -->

                        <div class="testimonial exception">
                            <div class="testimonial__about">
                                <div class="name-designation v_middle">
                                    <h4 class="name">로컬에서 WebSocket이 연결되지 않는 문제</h4>
                                    <span class="desig">WebSocket Error code 1006</span>
                                </div>
                            </div>
		                    <div class="testimonial__text">
		                         <ul class="pjDetail">
			                         <li><i class="fa-solid fa-lemon"></i>&ensp; 상황 : Spring Framework 5.3에서 WebSocket API만으로 댓글 알림을 구현하려는 상황. 브라우저에서 확인시 WebSocket 연결 자체에 실패하는 현상이 반복적으로 발생. 즉, 서버와 연결 자체가 안되는 상황</li>
			                         <li><i class="fa-solid fa-lemon"></i>&ensp; 원인 및 해결 : 현재 web.xml에 등록되어 있는 Dispatcher Servlet은 하나인 상태이고, *.do url에 대해서만 식별하고 있다. WebSocketHandler의 path를 /webSocket.do와 같이 Dispatcher Servlet의 url pattern과 맞춰주니 정상적으로 WebSocket connection이 생성되었다.</li>
		                         </ul>
		                     </div>
	                        <div class="btn-pj">
						 	   <a href="https://velog.io/@melodie104/WebSocket이-열리지-않는-문제" target="_blank" class="btn btn--icon btn-sm btn--round btn-info"> MORE </a>                     
	                        </div>
                        </div>
                        <!-- end /.testimonial -->

                        <div class="testimonial exception">
                            <div class="testimonial__about">
                                <div class="name-designation v_middle">
                                    <h4 class="name">EC2환경에서 WebSocket Connection Exception</h4>
                                    <span class="desig">Quality Ninja</span>
                                </div>
                            </div>
		                    <div class="testimonial__text">
		                         <ul class="pjDetail">
			                         <li><i class="fa-solid fa-lemon"></i>&ensp; 상황 : 로컬에서는 WebSocket Connection이 잘 생성되었는데, ec2로 옮기자 connection 생성이 안되는 현상. Handshake failed due to invalid Upgrade header: null</li>
			                         <li><i class="fa-solid fa-lemon"></i>&ensp; 원인 및 해결 : HTTP handshake시 Client는 Server로 WebSocket upgrade 요청을 보내는데, 이 요청은 프록시 서버에는 전달되지 않기 때문에, 명시적으로 header가 전달되어야 한다는 것. 프록시 설정에 upgrade를 명시적으로 추가해야 한다. sudo nginx -s reload 후 다시 접속하면 웹소켓이 정상적으로 연결된다.</li>
		                         </ul>
		                     </div>
	                        <div class="btn-pj">
						 	   <a href="https://velog.io/@melodie104/EC2-환경에서-WebSocket-Connection-Error-해결" target="_blank" class="btn btn--icon btn-sm btn--round btn-info"> MORE </a>                     
	                        </div>
                        </div>
                        <!-- end /.testimonial -->
                    </div>
                    <!-- end /.testimonial_slider -->

                    <div class="all-testimonial">
                        <a href="https://velog.io/@melodie104/series/Exception-모음" target="_blank" class="btn btn--lg btn--round">Velog로 이동</a>
                    </div>
                </div>
                <!-- end /.col-md-12 -->
            </div>
            <!-- end /.row -->
        </div>
        <!-- end container -->
    </section>	
    <!--================================
    END TESTIMONIAL
=================================-->