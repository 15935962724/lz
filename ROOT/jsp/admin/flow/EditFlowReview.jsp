<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.entity.site.*" %><%@page import="java.io.*" %><%@page import="java.util.*" %><%@page import="tea.html.*" %><%@page import="tea.entity.site.*" %><%@page import="tea.entity.admin.*" %><%@page import="java.math.*" %><%@page import="tea.entity.member.*" %><%@page import="tea.db.DbAdapter"%><%@page import="tea.resource.*" %><%@page import="tea.entity.node.*" %><%@page import="tea.ui.*" %><% request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

int dynamictype=Integer.parseInt(teasession.getParameter("dynamictype"));
int flowbusiness=Integer.parseInt(teasession.getParameter("flowbusiness"));
DynamicValue dv = DynamicValue.find(-flowbusiness, teasession._nLanguage, dynamictype);
String value=dv.getValue();

ProfileBBS pb = ProfileBBS.find(teasession._strCommunity, teasession._rv._strV);
String isign=pb.getISign(teasession._nLanguage);

if("POST".equals(request.getMethod()))
{
  String dts=teasession.getParameter("dts");
  dv.set(isign);
  out.println("<script>window.close();</script>");
  return;
}

Resource r=new Resource("/tea/resource/Dynamic");


%><html>
<head>
<title>审核稿件</title>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<script src="/tea/tea.js" type="text/javascript"></script>
<style type="text/css">
<!--
body
{
 margin-left: 0px;
 margin-top: 0px;
 margin-right: 0px;
 margin-bottom: 0px;
 border:0px;
 background-color:menu;
}
-->
</style>
<script>

var opener=opener?opener:dialogArguments;
</script>
</head>
<body>
<form name="form1" action="?" method="post" onSubmit="">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="flowbusiness" value="<%=flowbusiness%>">
<input type="hidden" name="dynamictype" value="<%=dynamictype%>">


<table border='0' cellpadding='0' cellspacing='0' id="TableAnnex" >
<tr><td>
<%
if(value!=null&&value.length()>0)
{
  out.print("您已经签过字,无须重复签字.");
}else
if (isign == null || isign.length() == 0)
{
  out.print("您还没有上传你的签名.");
} else
{
  out.print("确认签字?");
  out.print("<script>window.onload=function(){ form1.ok.disabled=false; }</script>");
}
%>
</td></tr>
</table>

<input name="ok" type='submit' value=' 确 定 ' disabled="disabled"/> <input type='button' onclick='window.close();' value=' 取 消 '/>

</form>
</body>
</html>
