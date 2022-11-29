<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%><%@page import="tea.entity.member.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%><%@page import="tea.entity.lms.*"%><%@page import="tea.entity.admin.*"%><%

Http h=new Http(request,response);
//if(h.member<1)
//{
//  response.sendRedirect("/servlet/StartLogin?community="+h.community);
//  return;
//}


%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/jsp/lms/lms.js" type="text/javascript"></script>
</head>
<body>
<h1></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form3" action="/LmsExports.do?name=学员报考.xlsx" method="post" target="_ajax">
<input type="hidden" name="act" value="sql"/>
<input type="hidden" name="key1" value="<%=MT.enc("SELECT '中','中国','中国人','中国人民','中国人民万','中国人民万岁','中国人民万岁万','中国人民万岁万岁','中国人民万岁万岁万','中国人民万岁万岁万万','中国人民万岁万岁万万岁' FROM Node WHERE node=14050002")%>"/>
<input type="hidden" name="key" value="<%=MT.enc("SELECT null,'A','AB','ABC','ABCD','ABCDE','ABCDEF','ABCDEFG' FROM Node WHERE node=14050002")%>"/>
<input type="submit" value="导出"/>
</form>

</body>
</html>
