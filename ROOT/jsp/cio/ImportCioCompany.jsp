<%@page contentType="text/html;charset=UTF-8" %><%@page import="java.util.*" %><%@page import="tea.entity.member.*" %>
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

String q=request.getParameter("q");

StringBuilder sql=new StringBuilder();
sql.append(" AND invite=1");
if(q!=null)
{
  sql.append(" AND name LIKE ").append(DbAdapter.cite("%"+q+"%"));
}

Resource r=new Resource();

int j=CioCompany.count(teasession._strCommunity,sql.toString());

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
    case "go":
    form1.action="?";
    form1.method="get";
    break;
  }
  form1.act.value=act;
  form1.submit();
}
</script>
</head>
<body>

<h1>已邀请的企业<%=j%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br/>
<form name="form1" action="/servlet/EditCioCompany"  >
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<script type="">document.write("<input type='hidden' name='nexturl' value='"+location+"' />");</script>
<input type="hidden" name="id" value="<%=menuid%>"/>
<input type="hidden" name="act" value="import"/>

<div id="mihu">企业集团名称　<input type="text" name="q" value="<%if(q!=null)out.print(q);%>">　<a href="javascript:f_action('go');">模糊查找</a></div>

<table border='0' cellpadding='0' cellspacing='0' id='tablecenterleft'><tr id='tableonetr'><td id='xuhao'>序号</td><td id='gongsi'>企业（集团）名称</td><td id='qiyexuhao'>分类</td><td id='qiyexuhao'>参会企业序号</td><td id='denglumm'>系统登陆密码</td></tr>
<%
Enumeration e=CioCompany.find(teasession._strCommunity,sql.toString(),0,Integer.MAX_VALUE);
for(int i=1;e.hasMoreElements();i++)
{
  CioCompany cc=(CioCompany)e.nextElement();
  int ccid=cc.getCioCompany();
  String name=cc.getName();
  String member=cc.getMember();
  String password=Profile.find(member).getPassword();
  if(q!=null&&q.length()>0)
  {
    name=name.replaceAll(q,"<font color='red'>"+q+"</font>");
  }
  out.print("<tr onmouseover=bgColor='#BCD1E9' onmouseout=bgColor=''>");
  out.print("<td id='xuhao'>"+i);
  out.print("<td id='gongsi'>"+name);
  out.print("<td id='qiyexuhao'>"+(cc.isCentral()?"央企":"地方"));
  out.print("<td id='qiyexuhao'>"+member);
  out.print("<td id='denglumm'>"+password);
  if(i%80==0)
  {
    out.print("</table><table border='0' cellpadding='0' cellspacing='0' id='tablecenterleft'><tr id='tableonetr'><td id='xuhao'>序号</td><td id='gongsi'>企业（集团）名称</td><td id='qiyexuhao'>分类</td><td id='qiyexuhao'>参会企业序号</td><td id='denglumm'>系统登陆密码</td></tr>");
  }
}
%>
</table>
<div id="tablebottom_button02">
<input type="submit" class="button_01" value="导出Excel" />

<input type="button" class="button_02"  value="增减被邀请企业" onClick="window.open('/jsp/cio/InviteCioCompany.jsp?community=<%=teasession._strCommunity%>','_self');"/>
</div>
</form>
<div  id="tablebottom_02">
说明：<br/>
查询并导出企业参会序号及密码用于发放邀请函。</div>
<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
