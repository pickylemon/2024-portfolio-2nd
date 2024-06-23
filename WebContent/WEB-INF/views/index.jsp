<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

	<!--================================
	    START FEATURE AREA
	=================================-->
    <section class="features section--padding modal-open" >
        <!-- start container -->
        <div class="container">
            <!-- start row -->
            <div class="row">
                <!-- start search-area -->
                <div class="col-lg-4 col-md-6">
                    <div class="feature">
                        <div class="feature__img">
                            <img src="<c:url value='/assest/template/images/feature1.png'/>" alt="feature" />
                        </div>
                        <div class="feature__title">
                            <h3>Best UX Research</h3>
                        </div>
                        <div class="feature__desc">
                            <p>Nunc placerat mi id nisi interdum mollis. Praesent pharetra, justo ut scelerisque the mattis,
                                leo quam aliquet diam congue is laoreet elit metus.</p>
                        </div>
                    </div>
                    <!-- end /.feature -->
                </div>
                <!-- end /.col-lg-4 col-md-6 -->

                <!-- start search-area -->
                <div class="col-lg-4 col-md-6">
                    <div class="feature">
                        <div class="feature__img">
                            <img src="<c:url value='/assest/template/images/feature2.png'/>" alt="feature" />
                        </div>
                        <div class="feature__title">
                            <h3>Fully Responsive</h3>
                        </div>
                        <div class="feature__desc">
                            <p>Nunc placerat mi id nisi interdum mollis. Praesent pharetra, justo ut scelerisque the mattis,
                                leo quam aliquet diam congue is laoreet elit metus.</p>
                        </div>
                    </div>
                    <!-- end /.feature -->
                </div>
                <!-- end /.col-lg-4 col-md-6 -->

                <!-- start search-area -->
                <div class="col-lg-4 col-md-6">
                    <div class="feature">
                        <div class="feature__img">                        
                            <img src="<c:url value='/assest/template/images/feature3.png'/>" alt="feature" />
                        </div>
                        <div class="feature__title">
                            <h3>Buy & Sell Easily</h3>
                        </div>
                        <div class="feature__desc">
                            <p>Nunc placerat mi id nisi interdum mollis. Praesent pharetra, justo ut scelerisque the mattis,
                                leo quam aliquet diam congue is laoreet elit metus.</p>
                        </div>
                    </div>
                    <!-- end /.feature -->
                </div>
                <!-- end /.col-lg-4 col-md-6 -->
            </div>
            <!-- end /.row -->
        </div>
        <!-- end /.container -->
        
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
