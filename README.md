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
<img width="223" alt="architecture" src="https://github.com/pickylemon/2024-portfolio-2nd/assets/156510800/a10867e3-cdb2-41d7-b2b9-a7ec2ebc78b9">

----------------

# [ 구현 기능 상세 ]

**[노션으로 이동](https://pacific-soil-139.notion.site/1d2d062cb6ed41d0a3e0efc66cab4cbf?pvs=4)**

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
#### [상황]
- 게시글에 첨부된 파일이 2개 이상일 경우, zip 파일로 한번에 다운 받는 옵션이 있다.
- 기존 zip파일을 만드는 메서드에서는 File타입의 List를 인자로 받고 있는데,
File객체로부터는 서버에 물리적으로 저장된 파일명만 얻을 수 있다.
- 서버에 저장되는 파일들은, 각각 구분될 수 있도록 UUID를 변형한 파일명으로 저장된다.
- 즉,  해당 코드로는 
유저가 zip파일을 다운로드 받아서 압축을 해제시, 업로드시의 원본 파일명을 얻을 수 없다.
```java
//before
@Component
public class FileUtil {
.. (중략)

	//기존 코드는 File타입의 객체를 자료구조에 담아 받고 있는데,
	//File객체에서는 getName()으로 물리적으로 저장된(UUID의 변형) 이름만 구할 수 있다.
	/
	public File makeCompressedFile(List<File> zipList) {
	...(중략)
	
		for(CustomFile file : zipList) {
				fis = new FileInputStream(file);
				ZipEntry zipEntry = new ZipEntry(file.getName()); 
				//압축해제시 업로드시의 원본 파일명이 아닌, UUID 형태의 이름의 파일명이 나타남.
				
				zos.putNextEntry(zipEntry);
				
				 byte[] bytes = new byte[1024];
              int length;
              while((length = fis.read(bytes)) != -1) {
                  zos.write(bytes, 0, length);
              }

              fis.close();
              zos.closeEntry();
			}
	}
}
```

#### [해결]
- File 클래스를 상속받는 CustomFile 클래스를 정의하고 orgFileNm을 필드에 추가했다.
```java
/**
 * 파일 다운로드시, 
 * abstractPath를 기준으로 한 fileName이 아닌
 * 업로드 시의 원본 이름을 그대로 쓰고 싶어서 만든 클래스
 */
@Getter
public class CustomFile extends File {
	
	private File file;
	private String orgFileNm;
	
	public CustomFile(String abstractPath, String orgFileNm) {
		super(abstractPath);
		this.orgFileNm = orgFileNm;
	}
}
```

#### [결과]
- FileUtil클래스의 zip파일을 만드는 메서드에서 File타입이 아닌 CutomFile 타입의 List를 인자로 받음으로써, zip파일 생성시 원본 파일명을 살릴 수 있게 되었다.
```java
//after
@Component
public class FileUtil {
.. (중략)

	//CustomFile타입의 List를 받음으로써, 업로드시의 원본 파일명을 알 수 있게 되었다.
	public File makeCompressedFile(List<CustomFile> zipList) {
	...(중략)
	
		for(CustomFile file : zipList) {
				fis = new FileInputStream(file);
				ZipEntry zipEntry = new ZipEntry(file.getOrgFileNm()); 
				//압축해제시 업로드시의 원본 파일명을 얻을 수 있게 됨.
				
				zos.putNextEntry(zipEntry);
				
				 byte[] bytes = new byte[1024];
              int length;
              while((length = fis.read(bytes)) != -1) {
                  zos.write(bytes, 0, length);
              }

              fis.close();
              zos.closeEntry();
		}
	}
}
```
-------------------------

### 2. 민감한 설정파일 암호화하기
#### [상황]
- DB나 JavaMailSender 관련 설정들은 개인정보가 코드에 그대로 노출되게 된다.
- .gitignore로 해당 파일들을 깃으로 관리하지 않을 수 있지만, 
 war파일 배포시 해당 파일들의 정보가 필요한 경우도 있으므로 (Jenkins를 통한 배포 등)
 단순히 설정 파일을 올리지 않는 것이 해결책이 될 수가 없었다.
```java
// before : 개인정보가 그대로 코드에 노출되어 있는 상황

// database 관련 설정
	<bean id="dataSource" class="org.springframework.jdbc.datasource.DriverManagerDataSource">
		<property name="driverClassName" value="com.mysql.cj.jdbc.Driver" />
		<property name="url" value="jdbc:mysql://localhost:73306/board?serverTimezone=Asia/Seoul" />
		<property name="username" value="admin"/>
		<property name="password" value="admin"/>
	</bean>


// JavaMailSender 관련 설정
	<bean id="mailSender" class="org.springframework.mail.javamail.JavaMailSenderImpl">
		<property name="host" value="smtp.naver.com" />
		<property name="port" value="587" />
		<property name="username" value="메일주소" />
		<property name="password" value="비밀번호" />
		<property name="javaMailProperties">
			<props>
				<prop key="mail.smtp.starttls.enable">true</prop>
			</props>
		</property>
	</bean>
```

#### [해결]
- Jasypt 라이브러리를 이용하여 설정 정보를 암호화했다.   
   **>>>> 💡 [Jasypt 라이브러리 정리(블로그 정리)](http://velog.io/@melodie104/Jasypt를-이용한-설정-정보-암호화)**

- 로컬에서 환경변수에 설정을 해주었으므로, 원격으로 배포시에도 똑같이 환경변수를 추가해주었다.  
  **>>>>💡 [원격 톰캣의 Jasypt 환경변수 설정(블로그 정리)](http://velog.io/@melodie104/배포-2.-수동-배포)**

- Jasypt 라이브러리를 통해 설정정보를 암호화하고 로컬 환경과 배포 환경(개발)에서
설정파일을 분리함으로써 보다 유용하게 관리할 수 있었다.
- 민감한 정보들을 암호화함으로써 파일이 노출되어도 안전을 보장받을 수 있다.
- 암호화 key를 환경변수로 직접 등록하는 방식을 택함으로써, key를 노출시키지 않을 수 있다.
```java
<!-- db-config.properties -->

db.url=ENC(rlBEtizIYH0bJ1iclJfaIyimpCfLYhKeYGRg6cLPS7DcZ0OJIrjzJMQk7/e/ZHlJYbb135Z)
db.username=ENC(Lmt45==DQWERhhQZDIoNan2KY=)
db.password=ENC(c3Fk0/Yh5dqN83fsD91xoQWERZ/0qpSI7)
```
------------------------------

### 3. 로그인 필터 구현
#### [상황]
- 게시판이나 채팅창 등 로그인 회원만 이용 가능한 서비스의 경우,  
비 로그인 사용자가 해당 페이지에 접근할 경우, 로그인 상태를 판별해서 로그인 페이지로 먼저 유도하는 로직이 필요하다.
- 이처럼 공통 로직이 여러 군데에서 중복되는 현상이 있었는데 이는 유지 보수 관점에서도 좋지 않고 객체지향적인 코드가 아니어서 개선이 필요했다.
```java
//before
@Controller
@RequestMapping("/forum/notice")
@RequiredArgsConstructor
public class NoticeController {

	public String listPage(HttpServletRequest request, ...) {
			HttpSession session = request.getSession(false);
			if(session == null || session.getAttribute("memberSeq") {
					return "redirect:/auth/loginPage.do";
			}
	(중략)
	}
}
```

#### [해결]
- 공통 로직을 LoginFilter로 따로 분리해서 객체지향적으로 구현했다.
- 또한  해당 Filter를 적용할 경로를 LoginFilter에서 내부적으로 enum으로 관리함으로써
코드의 응집도를 높이고자 했다.
- 또한 로그인 후에는 원래 접근하고자 했던 페이지로 다시 redirect를 시킴으로써 사용자 편의를 고려할 수 있었다. 
(ex. 비 로그인 상태에서 게시판 접근 → 로그인 페이지로 이동 → 로그인 성공 후 다시 게시판으로 redirect)

```java
public class LoginFilter implements Filter {
//필터
	private List<String> urlMappings = LoginUrlMapping.getUrlList();

	@Override
	public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain)
			throws IOException, ServletException {
		HttpServletRequest request = (HttpServletRequest)req;
		HttpServletResponse response = (HttpServletResponse)resp;
		String contextPath = request.getContextPath();
		String requestURL = request.getRequestURL().toString();
		String requestURI = request.getRequestURI().replaceAll(contextPath, "");
		HttpSession session = request.getSession(false);
		
		//로그인이 필요한 페이지인지 검사
		if(urlMappings.stream().anyMatch(url -> requestURI.startsWith(url))) {
			log.info("로그인 필터 시작");
			//로그인이 필요한 페이지일때 로그인 상태인지 검사
			if(session == null || ObjectUtils.isEmpty(session.getAttribute("memberSeq"))) {
				response.sendRedirect(contextPath+"/auth/loginPage.do?url="+requestURL);
				return;  //return이 매우 중요. return 안 해주면 chain.doFilter까지 실행됨.
			}
		}
		chain.doFilter(request, response);
	}
	
	
	//LoginFilter가 적용할 경로들은 내부적으로 enum으로 따로 관리
	@Getter
	private enum LoginUrlMapping {
		BOARD("/forum"),
		SALES("/sales"),
		QA("/qa"),
		SUPPORT("/support"),
		CHAT("/chat");
		
		private final String url;
		
		LoginUrlMapping(String url) {
			this.url = url;
		}
		
		private static List<String> getUrlList() {
			return Stream.of(LoginUrlMapping.values())
					.map(LoginUrlMapping::getUrl)
					.collect(Collectors.toList());
		}
	}
}
```
----------------------------

### 4. EC2 환경에서 WebSocket Connection 에러 해결하기
#### [상황]
- 로컬 환경에서는 잘 생성되던 WebSocket Connection이
war파일을 원격 서버에 올리자 연결되지 않는 현상이 발생했다.
- MobaXterm을 통해 톰캣 로그를 확인해보니
`Handshake failed due to invalid Upgrade header: null` 와 같은 문제를 확인할 수 있었다.
<img width="595" alt="ec2_websocket 에러" src="https://github.com/pickylemon/2024-portfolio-2nd/assets/156510800/1c406217-72ee-48d1-ac98-98052bc5a16e">

#### [해결]
- 웹소켓 연결은 HTTP handshake시 websocket으로 Upgrade 요청을 보냄으로써 이루어진다. 하지만 내가 설정한 원격 환경에서는 헤더에 upgrade에 대한 유효한 정보가 없기 때문에 websocket 연결이 실패하는 것이었다.
- 현재, AWS EC2를 원격 서버로 이용하고 Nginx를 통해 reverse proxy를 구성해 WebServer로 연결될 수 있게 원격 환경을 세팅해둔 상황이었다.
- Nginx 공식 사이트를 참고하였더니 (https://nginx.org/en/docs/http/websocket.html)
문제의 원인을 확인할 수 있었다.
<img width="722" alt="nginxWebServer해결2" src="https://github.com/pickylemon/2024-portfolio-2nd/assets/156510800/d4f30ba8-16b4-4aac-b8a0-33dd6449e237">  

- 즉, upgrade 헤더는 proxy server로 전달되지 않으니 프록시 설정에 직접 upgrade 관련된 헤더를 명시해줌으로써 해결이 가능했다.
- 아래와 같이 프록시를 설정한 pf.conf 파일에 직접 upgrade 관련 헤더를 명시해주었더니
원격 환경에서도 로컬에서와 같이 WebSocket연결이 성공적으로 이루어짐을 확인할 수 있었다.  
<img width="487" alt="pf conf" src="https://github.com/pickylemon/2024-portfolio-2nd/assets/156510800/5077d42e-59e1-499e-91da-f10de383b6ac">  

**>>>> 💡 [EC2 환경에서 WebSocket Connection Error 해결(블로그 정리)](http://velog.io/@melodie104/EC2-환경에서-WebSocket-Connection-Error-해결)**
