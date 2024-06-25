<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<style>
.contactMe {
	margin-bottom: 30px;
}

</style>
    <!--================================
        START AFFILIATE AREA
    =================================-->
    <section class="contact-area section--padding">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <div class="row">
                        <!-- start col-md-12 -->
                        <div class="col-md-12">
                            <div class="section-title">
                                <h1>CONTACT
                                    <span class="highlighted">ME</span>
                                </h1>
<!--                                 <p>이력서와 자기소개서를 보내드립니다.</p> -->
                            </div>
                        </div>
                        <!-- end /.col-md-12 -->
                    </div>
                    <!-- end /.row -->

                    <div class="row">
                        <div class="col-lg-4 col-md-6">
                            <div class="contact_tile">
                                <span class="tiles__icon lnr lnr-map-marker"></span>
                                <h4 class="tiles__title">Office Address</h4>
                                <div class="tiles__content">
                                    <p>202 New Hampshire Avenue , Northwest #100, New York-2573</p>
                                </div>
                            </div>
                        </div>
                        <!-- end /.col-lg-4 col-md-6 -->

                        <div class="col-lg-4 col-md-6">
                            <div class="contact_tile">
                                <span class="tiles__icon lnr lnr-phone"></span>
                                <h4 class="tiles__title">Phone Number</h4>
                                <div class="tiles__content">
                                    <p>1-800-643-4500</p>
                                    <p>1-800-643-4500</p>
                                </div>
                            </div>
                            <!-- end /.contact_tile -->
                        </div>
                        <!-- end /.col-lg-4 col-md-6 -->

                        <div class="col-lg-4 col-md-6">
                            <div class="contact_tile">
                                <span class="tiles__icon lnr lnr-inbox"></span>
                                <h4 class="tiles__title">Phone Number</h4>
                                <div class="tiles__content">
                                    <p>support@aazztech.com</p>
                                    <p>support@aazztech.com</p>
                                </div>
                            </div>
                            <!-- end /.contact_tile -->
                        </div>
                        <!-- end /.col-lg-4 col-md-6 -->

                        <div class="col-md-12">
                            <div class="contact_form cardify">
                                <div class="contact_form__title">
                                    <h3>연락처와 성함을 남겨주시면 이력서와 자기소개서를 보내드립니다.</h3>
                                </div>

                                <div class="row contactMe">
                                    <div class="col-md-8 offset-md-2">
                                        <div class="contact_form--wrapper">
                                            <form action="#">
<!--                                                 <div class="row"> -->
<!--                                                     <div class="col-md-6"> -->
<!--                                                         <div class="form-group"> -->
<!--                                                             <input type="text" placeholder="Name"> -->
<!--                                                         </div> -->
<!--                                                     </div> -->

<!--                                                     <div class="col-md-6"> -->
<!--                                                         <div class="form-group"> -->
<!--                                                             <input type="text" placeholder="Email"> -->
<!--                                                         </div> -->
<!--                                                     </div> -->
<!--                                                 </div> -->

                                                <div class="row">
                                                    <div class="col-md-6">
                                                        <div class="form-group">
                                                            <input type="text" placeholder="연락받으실 분의 성함을 입력해주세요.">
                                                        </div>
                                                    </div>

                                                    <div class="col-md-6">
                                                        <div class="form-group">
                                                            <input type="text" placeholder="연락받으실 이메일을 입력해주세요.">
                                                        </div>
                                                    </div>
                                                </div>

                                                <textarea cols="30" rows="10" placeholder="메시지를 남겨주세요."></textarea>

                                                <div class="sub_btn">
                                                    <button type="button" class="btn btn--round btn--default">SEND</button>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                    <!-- end /.col-md-8 -->
                                </div>
                                <!-- end /.row -->
                            </div>
                            <!-- end /.contact_form -->
                        </div>
                        <!-- end /.col-md-12 -->
                    </div>
                    <!-- end /.row -->
                </div>
                <!-- end /.col-md-12 -->
            </div>
            <!-- end /.row -->
        </div>
        <!-- end /.container -->
    </section>
