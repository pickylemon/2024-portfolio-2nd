# [ 프로젝트 개요 ]

### 목표
- 웹 사이트의 기본이 되는 핵심 기능들을 직접 구현하고, AWS를 통해 배포하는 경험 쌓기

### 구현한 기능
1. 회원가입 및 로그인, 비밀번호 찾기
  - Bcrypt를 활용한 유저 정보 암호화
  - JavaMailSender를 활용한 인증메일 보내기

2. 게시판 
  - 게시판 CRUD
  - 댓글 CRUD
  - 제목, 작성, 제목, 전체 옵션으로 검색 가능
  - 게시글 및 댓글 좋아요/싫어요 및 카운팅

3. 파일 첨부 및 다운로드
  - 게시글 작성시 한 게시글당 최대 3개 파일 첨부 가능
  - 파일 개별 다운로드 및 전체 zip 다운로드, 다운로드 수 카운팅

4. WebSocket을 활용한 댓글 알림
  - 내가 작성한 게시글에 타인이 댓글을 달면, 상단에 5초간 알림 띄우기

5. STOMP를 활용한 채팅방 구현
  - STOMP의 핵심 개념 (구독과 발행)을 이해하고, 
   채팅방에 입장/ 대화/ 퇴장 메시지를 렌더링하기

### 개발기간
  - 24.04.11 ~ 현재 리팩토링 및 기능 추가 진행 중

----------------

# [ 프로젝트 설명 ]

### 기술스택
- Backend  
: `SpringFramework 5.3` `Maven` `MyBatis` `JUnit5`
- Frontend  
: `HTML` `CSS` `JavaScript` `JQuery` `JSP` `Tiles`
- Database  
: `MySQL 8.0`
- Deploy  
: `Apache Tomcat` `AWS(EC2, RDS)`  `Nginx`  `MobaXterm`  `FileZilla`
- Else  
: `Git` `Sourctree` `GitHub`  `Notion`

### 아키텍처

----------------

# [ 구현 기능 상세 ]

**[Github issue 모음](https://github.com/pickylemon/2024-portfolio-2nd/issues?q=is%3Aissue+is%3Aclosed)**  

## 1. 회원가입 및 로그인
### - 회원가입
**[관련 Github issue로 이동](https://github.com/pickylemon/2024-portfolio-2nd/issues/3)**  
**[관련 코드로 이동](https://github.com/pickylemon/2024-portfolio-2nd/blob/develop/src/main/java/com/portfolio/www/auth/controller/JoinController.java)**

### - 로그인
**[관련 Github issue로 이동](https://github.com/pickylemon/2024-portfolio-2nd/issues/5)**  
**[관련 코드로 이동](https://github.com/pickylemon/2024-portfolio-2nd/blob/develop/src/main/java/com/portfolio/www/auth/controller/LoginController.java)**

### - 비밀번호 찾기
**[관련 Github issue로 이동](https://github.com/pickylemon/2024-portfolio-2nd/issues/7)**  
**[관련 코드로 이동](https://github.com/pickylemon/2024-portfolio-2nd/blob/develop/src/main/java/com/portfolio/www/auth/service/AuthCommonService.java)**

## 2. 게시판 CRUD, 검색, 댓글CRUD, 좋아요/싫어요

### - 게시판 CRUD, 페이징, 검색
**[관련 Github issue로 이동](https://github.com/pickylemon/2024-portfolio-2nd/issues/10)**  
**[관련 코드로 이동](https://github.com/pickylemon/2024-portfolio-2nd/blob/develop/src/main/java/com/portfolio/www/forum/notice/controller/NoticeController.java)**

### -좋아요/싫어요
**[관련 Github issue로 이동](https://github.com/pickylemon/2024-portfolio-2nd/issues/21)**  
**[관련 코드로 이동](https://github.com/pickylemon/2024-portfolio-2nd/blob/develop/src/main/java/com/portfolio/www/forum/notice/service/BoardService.java)**

### - 댓글
**[관련 Github issue로 이동](https://github.com/pickylemon/2024-portfolio-2nd/issues/19)**  
**[관련 코드로 이동](https://github.com/pickylemon/2024-portfolio-2nd/blob/develop/src/main/java/com/portfolio/www/forum/notice/controller/RestCommentController.java)**

## 3. 파일 업로드 / 다운로드

### - 파일 업로드
**[관련 Github issue로 이동](https://github.com/pickylemon/2024-portfolio-2nd/issues/17)**  
**[관련 코드로 이동](https://github.com/pickylemon/2024-portfolio-2nd/blob/develop/src/main/java/com/portfolio/www/forum/notice/util/FileUtil.java)**

### - 개별 파일 다운로드 / 전체 파일 zip 다운로드
**[관련 Github issue로 이동](https://github.com/pickylemon/2024-portfolio-2nd/issues/17)**  
**[관련 코드로 이동](https://github.com/pickylemon/2024-portfolio-2nd/blob/develop/src/main/java/com/portfolio/www/forum/notice/util/FileDownloadView.java)**



## 4. 댓글 알림과 채팅 구현 (WebSocket과 STOMP 활용)

### - 순수 WebSocket을 통한 댓글 알림 구현
**[관련 Github issue로 이동](https://github.com/pickylemon/2024-portfolio-2nd/issues/30)**  
**[관련 코드로 이동](https://github.com/pickylemon/2024-portfolio-2nd/blob/develop/src/main/java/com/portfolio/www/alarm/WebSocketHandler.java)**

### - STOMP를 통한 채팅방 구현
**[관련 Github issue로 이동](https://github.com/pickylemon/2024-portfolio-2nd/issues/38)**  
**[관련 코드로 이동](https://github.com/pickylemon/2024-portfolio-2nd/blob/develop/src/main/java/com/portfolio/www/chat/controller/ChatController.java)**

----------------

# [문제 해결 사례]

### 1. zip 파일로 전체 파일 다운로드
- 유저가 다운받은 zip파일 압축을 해제하면 original 파일명으로 파일을 얻을 수 있다.

### 2. 민감한 설정파일 암호화하기
- DB나 Mail Config 파일은 개인정보가 포함되어 있기 때문에 Jasypt를 통해 암호화
- AWS를 통해 배포를 할 때도 환경변수 설정을 추가해줌

### 3. 로그인 필터 구현
- 게시판, 채팅 등 공통적으로 로그인 검증 코드가 필요한 페이지들은
로그인 필터로 한번에 묶어 처리

### 4. EC2 환경에서 WebSocket Connection 에러 해결하기
- 로컬에서는 잘 연결되던 WebSocket이 배포 후 연결 안됨
Proxy관련 설정을 추가해준 사례