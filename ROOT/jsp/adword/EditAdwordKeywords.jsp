<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.Resource"  %><%@ page  import="tea.entity.node.*" %><%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

int adword = Integer.parseInt(teasession.getParameter("adword"));

Adword obj = Adword.find(adword);

String key=obj.getKeyworlds();
if(key==null||key.length()<1)
{
  key="&lt;在此处输入关键字&gt;";
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
<body onload="form1.keywords.focus();">

为广告命名 > 目标客户 > 制作广告 > <b>选择关键字</b> > 定价 > 审核与保存
<div id="head6"><img height="6" src="about:blank"></div>
<br>


<form name="form1" action="/servlet/EditAdword" method="post" onsubmit="return submitText(this.keywords,'无效-关键字');">
<input type=hidden name=community value=<%=teasession._strCommunity%> >
<input type=hidden name=adword value=<%=adword%> >
<input type=hidden name=act value=editadwordkeywords >
<input type=hidden name=nexturl value="/jsp/adword/EditAdwordPricing.jsp">

<h2>选择关键字</h2>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr>
  <td>输入特定字词或词组，数量随您决定，每行一个:</td>
</tr>
<tr>
  <td><textarea rows="12" name="keywords" cols="24" ><%=key%></textarea></td>
  <td>例如:<br><br>火星漫游<br>火星旅游<br>火星豪华游</td>
</tr>
</table>

<input type="submit" value="<%=r.getString(teasession._nLanguage,"返回")%>" onclick="form1.nexturl.value='/jsp/adword/EditAdwordShow.jsp'" >
<input type="submit" value="<%=r.getString(teasession._nLanguage,"继续")%>" >

</form>

<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
