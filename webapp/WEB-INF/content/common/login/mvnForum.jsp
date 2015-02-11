<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<script type="text/javascript" language="javascript">
	

function showForum(){
	window.location.href="http://localhost:8080/bbs/mvnforum/loginprocess?MemberName=<%=session.getAttribute("userID")%>&FromLoginPage=true&MemberMatkhau=www";
	
}
</script>
</head>
<body class="body_sub" onload="showForum()">	
		<form >								
			</form>			
</div>			
</body>
</html>
   