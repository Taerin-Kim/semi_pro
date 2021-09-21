<%@page import="java.math.BigInteger"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.security.SecureRandom"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>

<%
	String clientId = "zOyYdXgy2oaLzPhWWPFb";//애플리케이션 클라이언트 아이디값";
    String redirectURI = URLEncoder.encode("http://localhost:8787/snsLogin/naver.do", "UTF-8");
    SecureRandom random = new SecureRandom();
    String state = new BigInteger(130, random).toString();
    String apiURL = "https://nid.naver.com/oauth2.0/authorize?response_type=code";
    apiURL += "&client_id=" + clientId;
    apiURL += "&redirect_uri=" + redirectURI;
    apiURL += "&state=" + state;
    session.setAttribute("state", state);
%>
					<!-- 네이버아이디로 로그인 버튼 노출 영역 -->
					<div>
						<a href="<%=apiURL%>"><img src="resources/img/naver.png" width="280px" height="40px"></a>
					</div>
							
					<!-- 카카오아이디로 로그인 버튼 노출 영역 -->
					<div>
						<a href="https://kauth.kakao.com/oauth/authorize?client_id=6147ede2fee67c7e4d0316a0ef4cb677&redirect_uri=http://localhost:8787/semi_project_Day_Two/kakao.do&response_type=code"><img src="resources/img/kakao.png" width="280px" height="40px"></a>
					</div>
</body>
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>

<!-- kakao로그인 실행 함수 -->
<script>
	//javascript SDK 초기화
	//javascript key:804de9dc4d252e4123548ce16301b21c
	Kakao.init("804de9dc4d252e4123548ce16301b21c");
	console.log(Kakao.isInitialized());
	
	function kakaologin(){
		Kakao.Auth.login({
			//사용동의한 항목들(추가항목 동의받기)
			scope: 'profile, account_email, gender',
			//로그인 성공
			success: function(authObj){
				Kakao.API.request({
					//로그인한 사용자의 정보 가져오기
					url:'/v2/user/me',
					success: function(res){
						const kakao_account = res.kakao_account;
						console.log(kakao_account);
					}
				});
			},
			fail: function(error){
				console.log(error);
			}
		});
	}
</script>
</html>