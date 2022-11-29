<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.resource.Resource" %>
<%@page import="tea.entity.admin.erp.*" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.ui.TeaSession" %>
<%@page import="tea.entity.admin.erp.icard.*" %>
<%
request.setCharacterEncoding("UTF-8");
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");


TeaSession teasession = new TeaSession(request);
if (teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
  return;
}

String nexturl = request.getParameter("nexturl");


int icprice=Integer.parseInt(request.getParameter("icprice"));


if("POST".equals(request.getMethod()))
{
  int startprice=Integer.parseInt(request.getParameter("startprice"));
  int endprice=Integer.parseInt(request.getParameter("endprice"));
  if(icprice<1)
  {
    ICPrice.create(teasession._strCommunity,startprice,endprice);
  }else
  {
    ICPrice ct=ICPrice.find(icprice);
    ct.set(startprice,endprice);
  }
  response.sendRedirect(nexturl);
  return;
}


int startprice=0,endprice=0;
if(icprice>0)
{
  ICPrice ct=ICPrice.find(icprice);
  startprice=ct.getStartPrice();
  endprice=ct.getEndPrice();
}
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" language="javascript" src="/tea/tea.js"></script>
<title>添加/编辑价位</title>
<script type="">
function f_submit()
{
  if(parseInt(form1.startprice.value)>=parseInt(form1.endprice.value))
  {
    alert('起始价格 不能大于 终止价格!');
    form1.endprice.focus();
    return false;
  }
}
</script>
</head>
<body id="bodynone" onload="form1.startprice.focus();">
<h1>添加/编辑价位</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" action="?" method="post" onsubmit="return submitInteger(this.startprice,'无效-起始价格')&&submitInteger(this.endprice,'无效-终止价格')&&f_submit();">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="icprice" value="<%=icprice%>"/>
<input type="hidden" name="nexturl" value="<%=nexturl%>"/>
<input type="hidden" name="act" value="edit"/>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
	<tr>
      <td>起始价格:</td>
      <td><input name="startprice" type="text" value="<%=startprice%>" mask="int"></td>
    </tr>
	<tr>
      <td>终止价格:</td>
      <td><input name="endprice" type="text" value="<%=endprice%>" mask="int"></td>
    </tr>
    <tr>
      <td>&nbsp;</td>
      <td><input type="submit" value="保存">
      <input type="button" value="返回" onclick='history.back();'></td>
    </tr>
</table>
</form>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
