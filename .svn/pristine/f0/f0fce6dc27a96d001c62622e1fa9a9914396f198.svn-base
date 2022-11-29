<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.resource.Resource" %>
<%@page import="tea.entity.admin.erp.*" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.node.*" %>
<%@page import="java.util.*" %>
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

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" language="javascript" src="/tea/tea.js"></script>
<title>批理发卡</title>
<script>
function f_view()
{
  var view=document.getElementById('view');
  var m=parseInt(form1.median.value);
  var s=parseInt(form1.start.value);
  var e=parseInt(form1.end.value);
  var p=form1.prefix.value;
  var rs="";
  for(var i=s;i<s+5&&i<e;i++)
  {
    if(form1.filter.checked)i=parseInt((""+i).replace('4','5'));
    rs+=p+f_median(i,m)+"\r\n";
  }
  rs+="...\r\n";
  rs+=p+f_median(e,m)+"\r\n";
  view.value=rs;
}
function f_median(str,m)
{
  if(!str.length)str=""+str;
  for(var i=str.length;i<m;i++)
  {
    str="0"+str;
  }
  return str;
}
</script>
</head>
<body id="bodynone" onload="f_view();form1.prefix.focus();">
<h1>批量发卡</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" action="/servlet/EditICard" onSubmit="return submitText(this.prefix,'无效-前缀')&&submitInteger(this.median,'无效-位数')&&submitInteger(this.start,'无效-卡号')&&submitInteger(this.end,'无效-卡号')&&submitText(this.icardtype,'无效-卡类型');">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="nexturl" value="/jsp/erp/icard/ICards.jsp"/>
<input type="hidden" name="act" value="edit"/>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
    <td>卡号前缀:</td>
    <td><input type="text" name="prefix" value="6688" onchange="f_view()"/></td>
    <td rowspan="3"><textarea id="view" readonly="readonly" rows="5"></textarea></td>
    </tr>
    <tr>
    <td>卡号位数:</td>
    <td><input type="text" name="median" value="6" onchange="f_view()" mask="int"/></td>
    </tr>
  <tr>
    <td>卡号:</td>
    <td><input name="start" type="text" value="1" onchange="f_view()" mask="int"><br>
      <input type="text" name="end" value="1000" onchange="f_view()" mask="int"/></td>
    </tr>
    <tr>
      <td>密码</td>
      <td colspan="2"><input name="password" type="text" value="123456"/><input type="checkbox" onclick="form1.password.disabled=checked" id="isran"><label for="isran">随机</label></td>
    </tr>
    <tr>
      <td>存入金额</td>
      <td colspan="2"><input name="money" type="text" mask="float"/></td>
    </tr>
    <tr>
      <td>作废日期:</td>
      <td colspan="2"><%=new tea.htmlx.TimeSelection("invalid", new Date(System.currentTimeMillis()+315360000000L))%></td>
    </tr>
    <tr>
      <td>卡类型</td>
      <td colspan="2"><%=ICardType.toHtml(teasession._strCommunity,0)%></td>
    </tr>
    <tr>
      <td>&nbsp;</td>
      <td colspan="2"><input type="checkbox" name="filter" onclick="f_view()" checked="checked" id="filter"><label for="filter">过滤掉所有含<b style="color:red">4</b>的卡号</label></td>
    </tr>
    <tr>
      <td>&nbsp;</td>
      <td colspan="2"><input type="submit" value="开始发行">
        <input type="button" value="返回" onclick='history.back();'></td>
    </tr>
</table>
</form>

<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
