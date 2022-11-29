<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.Resource"  %><%@ page  import="tea.entity.node.*" %><%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

int adword = Integer.parseInt(teasession.getParameter("adword"));
String name="";
if(adword>0)
{
	Adword obj = Adword.find(adword);
	name=obj.getName();
}

Resource r=new Resource();

%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<body onload="form1.name.focus();">

<b>为广告命名</b> > 目标客户 > 制作广告 > 选择关键字 > 定价 > 审核与保存
<div id="head6"><img height="6" src="about:blank"></div>
<br>
<h2>为广告命名</h2>

<form name="form1" action="/servlet/EditAdword" onsubmit="return submitText(this.name,'为您的新广告组命名');">
<input type=hidden name=community value=<%=teasession._strCommunity%> >
<input type=hidden name=adword value=<%=adword%> >
<input type=hidden name=act value=editadwordname >
<input type=hidden name=nexturl value="/jsp/adword/EditAdwordTarget.jsp">

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr>
  <td>为您的新广告组命名</td>
  <td><input type=text name=name value="<%=name%>"></td>
 </tr>
</table>
 
<input type="submit" value="<%=r.getString(teasession._nLanguage,"返回")%>" onclick="form1.nexturl.value='/jsp/adword/Adwords.jsp'" >
<input type="submit" value="<%=r.getString(teasession._nLanguage,"继续")%>" >

</form>

<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>

