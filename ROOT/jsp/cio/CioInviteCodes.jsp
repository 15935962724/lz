<%@page contentType="text/html;charset=UTF-8" %><%@page import="java.util.*" %>
<%@ page import="tea.db.DbAdapter"%><%@page import="tea.resource.Resource" %>
<%@ page import="tea.entity.cio.*" %><%@ page import="tea.ui.TeaSession" %>
<%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String menuid=request.getParameter("id");

String nexturl=request.getParameter("nexturl");

StringBuilder sql=new StringBuilder();
StringBuilder par=new StringBuilder();
par.append("?community=").append(teasession._strCommunity);
par.append("&id=").append(menuid);

String s=request.getParameter("s");
if(s!=null&&s.length()>0)
{
  sql.append(" AND member IS ").append("1".equals(s)?" NOT NULL":" NULL");
  par.append("&s=").append(s);
}
par.append("&pos=");

int pos=0;
String tmp=request.getParameter("pos");
if(tmp!=null)
{
  pos=Integer.parseInt(tmp);
}

Resource r=new Resource();

int j=CioInviteCode.count(teasession._strCommunity,sql.toString());

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="">
function f_action(act,ccid)
{
  switch(act)
  {
    case "delete":
    if(!confirm("确认删除?"))
    {
      return false;
    }
    break;
  }
  form2.code.value=ccid;
  form2.act.value=act;
  form2.submit();
}
</script>
</head>
<body>


<h1>邀请码管理 <%=j%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br/>
<form name="form1" action="?" >
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="id" value="<%=menuid%>"/>
<div style="text-align:left;">
<table border='0' cellpadding='0' cellspacing='0'  style="margin-left:30px;margin-bottom:10px;">
<tr>
  <td>状态:<select name="s">
    <option value="">------------</option>
    <option value="0" <%if("0".equals(s))out.print(" selected=''");%>>未使用</option>
    <option value="1" <%if("1".equals(s))out.print(" selected=''");%>>已使用</option>
</select>　<input type="submit" value="GO"/></td>
</tr>
</table>
</div>
</form>

<form name="form2" action="/servlet/EditCioInviteCode" method="post" >
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<script type="">document.write("<input type='hidden' name='nexturl' value='"+location+"' />");</script>
<input type="hidden" name="code"/>
<input type="hidden" name="act" value="create"/>

<table border='0' cellpadding='0' cellspacing='0' id='tablecenterleft'>
  <tr id='tableonetr'>
    <td id='xuhao'>序号</td>
    <td id="yaoqm">邀请码</td>
    <td id="zhuangt">状态</td>
    <td id="shiyz">使用者</td>
    <td id="ip">IP</td>
    <td id="bianji">&nbsp;</td>
  </tr>
<%
Enumeration e=CioInviteCode.find(teasession._strCommunity,sql.toString(),pos,20);
for(int i=pos;e.hasMoreElements();i++)
{
  CioInviteCode cic=(CioInviteCode)e.nextElement();
  String code=cic.getCode();
  String member=cic.getMember();
  String ip=cic.getIp();
  out.print("<tr onmouseover=bgColor='#BCD1E9' onmouseout=bgColor=''>");
  out.print("<td id='xuhao'>"+(i+1));
  out.print("<td id='yaoqm'>"+code);
  out.print("<td id='zhuangt'>"+(member==null?"未使用":"已使用"));
  out.print("<td id='shiyz'>");
  if(member!=null)out.print(member);
  out.print("<td id='ip'>");
  if(ip!=null)out.print(ip);
  out.print("<td id='bianji'>");
  if(member==null)
  {
    out.print("<a href=javascript:f_action('delete','"+code+"')>删除</a>");
  }
}
out.print("<tr><td colspan='6' align='right'>"+new tea.htmlx.FPNL(teasession._nLanguage,par.toString(),pos,j,20)+"</td></tr>");
%>
</table>
<div id="tablebottom_button02">
<input type="button" value="添加邀请码" onClick="f_action('create');"/>
<input type="button" value="导出邀请码" onClick="f_action('import');"/>
</form>
</div>
<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
