<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%
String ctx = request.getContextPath();
%>

<!-- 로그인 여부에 따라 로그인/로그아웃 버튼이 보인다. -->
<c:set var="loginOutLink" value="${sessionScope.memberSeq == null ? '/auth/loginPage.do' : '/auth/logout.do'}"/>
<c:set var="loginOut" value="${sessionScope.memberSeq == null ? 'Login' : 'Logout'} "/>
    <!-- ================================
	    START MENU AREA
	================================= -->
    <!-- start menu-area -->
    <div class="menu-area">
    <div id="msgAlert" class="alert alert-success" role="alert" style="display:none"></div>
        <!-- start .top-menu-area -->  
        <div class="top-menu-area">
            <!-- start .container -->
            <div class="container">
                <!-- start .row -->
                <div class="row">
                    <!-- start .col-md-3 -->
                    <div class="col-lg-3 col-md-3 col-6 v_middle">
                        <div class="logo">                        
                            <a href="<c:url value='/index.do'/>">                            	
                                <img src="<c:url value='/assest/template/images/myLogo.png'/>" alt="logo image" class="img-fluid" />
                            </a>
                        </div>
                    </div>
                    <!-- end /.col-md-3 -->

                    <!-- start .col-md-5 -->
                    <div class="col-lg-8 offset-lg-1 col-6 col-md-9 v_middle">
                        <!-- start .author-area -->
                        <div class="author-area not_logged_in">
                            <div class="author__notification_area">
                                <ul>
                                    <li class="has_dropdown">
                                        <div class="icon_wrap">
                                        	<img src="<c:url value='/assest/template/images/lemon.png'/>" alt="logo image" class="img-fluid" width="40px" height="40px"/>
<!--                                             <span class="lnr lnr-cart"></span> -->
                                            <span class="notification_count purch">2</span>
                                        </div>

                                    </li>
                                </ul>
                            </div>
                            <div class="pull-right join desktop-size d-md-block d-none">
                            <c:if test='${sessionScope.memberSeq == null }'>
                                <a href="<c:url value='/auth/joinPage.do'/>" class="btn btn--round btn-secondary  btn--xs">Join Now</a>
                            </c:if>
                                <a href="<c:url value='${loginOutLink}'/>" class="btn btn--round btn--xs">${loginOut}</a>
                            </div>
                            <div class="pull-right join mobile-size d-md-none d-flex">
                                <a href="#" class="btn btn--round btn-secondary "><span class="lnr lnr-user"></span></a>
                                <a href="#" class="btn btn--round"><span class="lnr lnr-enter"></span></a>
                            </div>
                        </div>
                        <!-- end .author-area -->
                    </div>
                    <!-- end /.col-md-5 -->
                </div>
                <!-- end /.row -->
            </div>
            <!-- end /.container -->
        </div>
        <!-- end  -->

        <!-- start .mainmenu_area -->
        <div class="mainmenu">
            <!-- start .container -->
            <div class="container">
                <!-- start .row-->
                <div class="row">
                    <!-- start .col-md-12 -->
                    <div class="col-md-12">
                        <nav class="navbar navbar-expand-md navbar-light mainmenu__menu">
                            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false"
                                aria-label="Toggle navigation">
                                <span class="navbar-toggler-icon"></span>
                            </button>
                            <!-- Collect the nav links, forms, and other content for toggling -->
                            <div class="collapse navbar-collapse" id="navbarNav">
                                <ul class="navbar-nav">
                                    <li class="has_dropdown">
                                        <a href="<c:url value='/index.do'/>">HOME</a>
                                    </li>
                                    <li class="has_dropdown">
                                        <a href="<c:url value='/aboutMe.do'/>">ABOUT ME</a>
                                        <div class="dropdowns dropdown--menu">
                                            <ul>
                                                <li>
                                                    <a href="<c:url value='/aboutMe.do'/>">ABOUT ME</a>
                                                </li>
                                                <li>
                                                    <a href="https://www.notion.so/BackEnd-bb12744efdf74a1b849bdc0b8db03238?pvs=4" target="_blank">이력서</a>
                                                </li>
                                                <li>
                                                    <a href="https://www.notion.so/fe17ff272aef4e4b9fa419596c0e2c76?pvs=4" target="_blank">자기소개서</a>
                                                </li>
                                                <li>
                                                    <a href="https://github.com/pickylemon" target="_blank">Github</a>
                                                </li>
                                                <li>
                                                    <a href="https://velog.io/@melodie104/posts" target="_blank">Velog</a>
                                                </li>
                                            </ul>
                                        </div>
                                    </li>
                                    <li class="has_dropdown">
                                        <a href="<c:url value='/contactMe.do'/>">CONTACT ME</a>
                                    </li>   
                                    <li class="has_dropdown">
                                        <a href="<c:url value='/forum/notice/listPage.do'/>">BOARD</a>
                                        <div class="dropdowns dropdown--menu">
                                            <ul>
                                                <li>
                                                    <a href="<c:url value='/forum/notice/listPage.do'/>">공지사항</a>
                                                </li>
<!--                                                 <li> -->
<!--                                                     <a href="javascript:void(0)">레시피</a> -->
<!--                                                 </li> -->
<!--                                                 <li> -->
<!--                                                     <a href="javascript:void(0)">자유게시판</a> -->
<!--                                                 </li> -->
                                            </ul>
                                        </div>
                                    </li>
                                    
                                    <li>
                                        <a href="<c:url value='/chatRoomList.do'/>">CHATROOM</a>
                                    </li>
<!--                                     <li> -->
<%--                                         <a href="<c:url value='/chatRoomList.do'/>">ALBUM</a> --%>
<!--                                     </li> -->
                                </ul>
                            </div>
                            <!-- /.navbar-collapse -->
                        </nav>
                    </div>
                    <!-- end /.col-md-12 -->
                </div>
                <!-- end /.row-->
            </div>
            <!-- start .container -->
        </div>
        <!-- end /.mainmenu-->
    </div>
    <!-- end /.menu-area -->
    <!--================================
	    END MENU AREA
	=================================-->

