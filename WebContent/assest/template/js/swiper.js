new Swiper('.promotion .swiper-container', {
  //direction: 'horizontal' 디폴트값이라 생략
  slidesPerView: 3, //한번에 보여줄 슬라이드 개수
  spaceBetween: 10, //슬라이드 사이 여백(px)
  centeredSlides: true, //
  loop: true,
  autoplay: {//객체 데이터로 할당
    delay: 2000
  }, 
  pagination : {
    el: '.promotion .swiper-pagination', //페이지 번호 요소 선택자
    clickable: true //사용자가 클릭해서 제어할 수 이는 여부.
  },
  navigation: {
    prevEl: '.promotion .swiper-prev',
    nextEl: '.promotion .swiper-next'
  }
});
