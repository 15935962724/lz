<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.Resource"  %><%@page import="java.io.*" %><%@ page  import="tea.entity.bbs.*" %><%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

Resource r=new Resource();





%><html>
<head>
<title>论坛等级选择</title>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script>
function f_re(img){window.returnValue=img;window.close();}
</script>
</head>
<body>


<div id="head6"><img height="6" src="about:blank"></div>
<br>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter" style="cursor:hand">
<%
for(int i=1;i<13;i++)
{
  String n="/tea/image/bbslevel/"+i+".gif";
  %>
  <tr onMouseOver="bgColor='#BCD1E9'" onMouseOut="bgColor=''" onclick="f_re('<%=n%>')">
    <td><img alt="" src="<%=n%>"/></td>
 </tr>
<%
}
%>
</table>

<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
