<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%
String ctx = request.getContextPath();
%>
  <!--================================
            START DASHBOARD AREA
    =================================-->
    <section class="pass_recover_area section--padding2">
        <div class="container">
            <div class="row">
                <div class="col-lg-6 offset-lg-3">
                    <form action="<c:url value='/auth/checkIdAndEmail.do'/>" method="post">
                        <div class="cardify recover_pass">
                            <div class="login--header">
                                <p>비밀번호를 찾고자 하는 아이디와 가입시 등록한 이메일을 입력해주세요.</p>
                            </div>
                            <!-- end .login_header -->

                            <div class="login--form">
                                <div class="form-group">
                                    <label for="id">Enter your ID</label>
                                    <input id="id" type="text" class="text_field" placeholder="Enter your id" name="memberId" value="${memberId}">
                                </div>
                                <div class="form-group">
                                    <label for="email">Enter your Email</label>
                                    <input id="email" type="text" class="text_field" placeholder="Enter your email" name="email" value="${email }">
                                </div>


                                <button class="btn btn--md btn--round register_btn" type="submit">Next Step</button>
                            </div>
                            <!-- end .login--form -->
                        </div>
                        <!-- end .cardify -->
                    </form>
                </div>
                <!-- end .col-md-6 -->
            </div>
            <!-- end .row -->
        </div>
        <!-- end .container -->
    </section>
    <!--================================
            END DASHBOARD AREA
    =================================-->
</html>