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

String q=request.getParameter("q");

int central=-1;
String tmp=request.getParameter("central");
if(tmp!=null)
{
  central=Integer.parseInt(tmp);
}

StringBuilder sql=new StringBuilder();
if(central!=-1)
{
  sql.append(" AND central=").append(central);
}
if(q!=null)
{
  sql.append(" AND name LIKE ").append(DbAdapter.cite("%"+q+"%"));
}

Resource r=new Resource();

int j=CioCompany.count(teasession._strCommunity,sql.toString());

%>
<!--
参数:
central:
  没有:全部
  1:央企
  0:地方企业
-->
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

<h1>邀请本次参会企业 <%=j%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br/>
<form name="form1" action="/servlet/EditCioCompany" method="post" >
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<script type="">document.write("<input type='hidden' name='nexturl' value='"+location+"' />");</script>
<input type="hidden" name="id" value="<%=menuid%>"/>
<input type="hidden" name="act" value="invite"/>

<div id="mihu">企业集团名称　<input type="text" name="q" value="<%if(q!=null)out.print(q);%>">　<a href="javascript:f_action('go');">模糊查找</a></div>

<table border='0' cellpadding='0' cellspacing='0' id='tablecenterleft'><tr id='tableonetr'><td id='fuxuan'>&nbsp;</td><td>序号</td><td>企业（集团）名称</td></tr>
<%
Enumeration e=CioCompany.find(teasession._strCommunity,sql.toString(),0,Integer.MAX_VALUE);
for(int i=1;e.hasMoreElements();i++)
{
  CioCompany cc=(CioCompany)e.nextElement();
  int ccid=cc.getCioCompany();
  String name=cc.getName();
  if(q!=null&&q.length()>0)
  {
    name=name.replaceAll(q,"<font color='red'>"+q+"</font>");
  }
  out.print("<tr onmouseover=bgColor='#BCD1E9' onmouseout=bgColor=''>");
  out.print("<td id='fuxuan'><input name='ciocompany' type='checkbox' value='"+ccid+"'");
  if(cc.isInvite())
  {
    out.print(" checked='true'");
  }
  out.print(">");
  out.print("<td id='xuhao'>"+i);
  out.print("<td id='gongsi'>"+name);
  if(i%80==0)
  {
    out.print("</table><table border='0' cellpadding='0' cellspacing='0' id='tablecenterright'><tr id='tableonetr'><td id='fuxuan'>&nbsp;</td><td id='xuhao'>序号</td><td id='gongs'>企业（集团）名称</td></tr>");
  }
}
%>
</table>
<div id="tablebottom_button">
<input type="button" class="button_01" value="全选列表中的企业" onClick="selectAll(form1.ciocompany,true);"/>

<input type="submit" class="button_02"  value="邀请选中的企业参会" />

<input type="button" class="button_03"  value="已邀请的企业" onClick="window.open('/jsp/cio/ImportCioCompany.jsp?community=<%=teasession._strCommunity%>','_self');"/>

<input type="button" class="button_04"  value="管理参会企业库" onClick="window.open('/jsp/cio/CioCompanys.jsp?community=<%=teasession._strCommunity%>&central=<%=central%>','_self');"/>
</div>
<div  id="tablebottom_02">
说明：<br/>
邀请企业参会，系统会自动生成企业参会序号及对应的密码<br/>
在已邀请的企业中可以查询并导出企业参会序号及密码用于发放邀请函。
</div>
</form>

<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
