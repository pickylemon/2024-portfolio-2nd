<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
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
                    <form action="<c:url value='/auth/resetPasswd.do'/>" method="post" onsubmit="return pwdEquals(this)">
                        <div class="cardify recover_pass">
                            <div class="login--header">
                                <p>새로운 비밀번호를 지정해주세요</p>
                            </div>
                            <!-- end .login_header -->

                            <div class="login--form">
                                <div class="form-group">
                                    <label for="passwd">Enter your New Password</label>
                                    <input id="passwd" type="text" class="text_field" placeholder="Reset your password" name="passwd" value="${dto.passwd }">
                                    <spring:hasBindErrors name="passwdResetDto">
	                                    <c:if test="${errors.hasFieldErrors('passwd') }">
	                                    	<strong style="color:red">${errors.getFieldError('passwd').defaultMessage }</strong>
	                                    </c:if>
                                    </spring:hasBindErrors>
                                    <input type="hidden" name="memberSeq" value="${dto.memberSeq }"/>
                                    <input type="hidden" name="resetPasswdAuthSeq" value="${dto.resetPasswdAuthSeq }"/>
                                </div>
                                <div class="form-group">
                                    <label for="passwd2">Check your New Password Again</label>
                                    <input id="passwd2" type="text" class="text_field" placeholder="Check your password again" name="passwd2">
                                </div>
                                

                                <button class="btn btn--md btn--round register_btn" type="submit">Reset your password</button>
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
<script>
<!-- 비밀번호 확인 실패하면 submit 안되게 -->
function pwdEquals(elem) { 
	console.log(elem)
	let pwd1 = elem.querySelector("input[name=passwd]")
	let pwd2 = elem.querySelector("input[name=passwd2]")    	
	    	
	console.log(pwd1.value)
	if(pwd1.value !== pwd2.value) {
		if(document.querySelector('#pwdDiff') == null) {
    		const notice = createNotice()
    		pwd1.closest('div').append(notice)
		}

		return false;
	}
	
	return true;
	
	function createNotice(){
		let notice = document.createElement("p")
    	notice.style.color = 'red'
    	notice.id = 'pwdDiff'
    	let msg = document.createTextNode("비밀번호가 일치하지 않습니다.");
		
		notice.appendChild(msg);
		
		return notice
	}
}

    let msg = '${msgObject.msg}'
    let code = '${msgObject.code}'

    window.onload = function(){
    	if(msg!=''){
    		console.log(code)
    		alert(msg)
    	}
    }
</script>