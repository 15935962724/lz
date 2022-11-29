<%@ page contentType="text/html; charset=UTF-8" %>

<html>
<head>
<title>
Loading...
</title>
</head>
<body bgcolor="#ffffff">
<h1>

</h1>
<form name="form1" action="http://222.35.63.147/golden_test/GoldenFormLogout.asp" method="POST">
<input type="hidden" name="LoginId" value="<%=request.getSession(true).getAttribute("LoginId")%>"/>
</form>
<script language=javascript type="text/javascript">
document.form1.submit()
</script>

</body>
</html>
