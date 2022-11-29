<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter"%>
<%@page import="tea.resource.Resource"%>
<%@page import="java.util.*"%>
<%@page import="java.net.*"%>
<%@page import="java.io.*"%>
<%@page import="tea.entity.member.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.entity.eon.*"%>
<%@page import="tea.ui.TeaSession"%><%
request.setCharacterEncoding("UTF-8");
response.setHeader("Cache-Control", "no-cache");

TeaSession teasession=new TeaSession(request);

EonNode en = EonNode.find(teasession._nNode);
if(teasession._rv==null&&en.isReg())
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}
String tel="";
if(teasession._rv!=null)
{
  Profile p=Profile.find(teasession._rv._strV);
  tel=p.getTelephone(teasession._nLanguage);
}

Resource r=new Resource();

Node n=Node.find(teasession._nNode);

String member=n.getCreator()._strV; //request.getParameter("member");//客服

int pn=0;//Integer.parseInt(request.getParameter("processnum"));

Profile p=Profile.find(member);


%><html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="/tea/tea.js" type="text/javascript"></script>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
</head>
<body id=edntelwindow1>

<div id="head6"><img height="6" src="about:blank"></div>
<br>

<form name="form1" action="/servlet/EonRecords" onSubmit="return submitText(form1.tel,'无效-号码');">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>">
<input type="hidden" name="node" value="<%=teasession._nNode%>">
<input type="hidden" name="processnum" value="<%=pn%>">
<input type="hidden" name="nexturl" value="/jsp/type/company/windows/EonCall2.jsp?">
<input type="hidden" name="member" value="<%=member%>">
<input type="hidden" name="act" value="outbound">


<div style="width:318px;text-align:right;"><input name="tel" style="border:1px solid #A4A4A4;" type="text" value="<%=tel%>"><input type="submit" value="　" id="edntelqueding"></div>
<div id="tel_tu"><img src="/res/lib/u/0805/080533238.jpg"></div>

</form>

</body>
</html>
