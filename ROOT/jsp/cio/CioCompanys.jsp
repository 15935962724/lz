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

int central=-1;
String tmp=request.getParameter("central");
if(tmp!=null)
{
  central=Integer.parseInt(tmp);
}

String menuid=request.getParameter("id");

String nexturl=request.getParameter("nexturl");

String q=request.getParameter("q");

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
    case "delete":
    if(!confirm("确认删除?"))
    {
      return false;
    }
    break;
    case "edit":
    window.open("/jsp/cio/SetCioCompanyName.jsp?community=<%=teasession._strCommunity%>&ciocompany="+ccid,"","width=300,height=150");
    return;
  }
  form2.ciocompany.value=ccid;
  form2.act.value=act;
  form2.submit();
}
</script>
</head>
<body>

<h1>参会企业库管理 <%=j%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br/>
<form name="form1" action="?">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="id" value="<%=menuid%>"/>
<div id="mihu">企业集团名称　<input type="text" name="q" value="<%if(q!=null)out.print(q);%>">　<a href="###" onclick="form1.submit();">模糊查找</a></div>
</form>

<form name="form2" action="/servlet/EditCioCompany" method="post" >
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<script type="">document.write("<input type='hidden' name='nexturl' value='"+location+"' />");</script>
<input type="hidden" name="ciocompany"/>
<input type="hidden" name="central" value="<%=central%>"/>
<input type="hidden" name="act"/>

<table border='0' cellpadding='0' cellspacing='0' id='tablecenterleft'><tr id='tableonetr'><td id='xuhao'>序号</td><td id="gongsi">企业（集团）名称</td><td id="bianji">&nbsp;</td></tr>
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
  out.print("<td id='xuhao'>"+i);
  out.print("<td id='gongsi'>"+name);
  out.print("<td id='bianji'><a href=javascript:f_action('edit',"+ccid+")>编辑</a> <a href=javascript:f_action('delete',"+ccid+")>删除</a>");
  if(i%80==0)
  {
    out.print("</table><table border='0' cellpadding='0' cellspacing='0' id='tablecenterright'><tr id='tableonetr'><td id='xuhao'>序号</td><td id='gongsi'>企业（集团）名称</td><td id='bianji'>&nbsp;</td></tr>");
  }
}
%>
</table>
<h1 id="teshuh1">添加参会企业库管理</h1>
<div id="bottom_div">
输入完整的企业集团名称--一次可创建多个,每行一个企业.
<table border="0" cellpadding="0" cellspacing="0" id="tablecenterbottom">
  <tr>
    <td nowrap><textarea name="name" cols="50" rows="8"></textarea></td>
  </tr>
<tr>
<td class="td_02"><input type="button" value="添加" onClick="return submitText(form1.name,'无效-企业集团名称')&&f_action('create');"/></td>
</table>
</div>
</form>

<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
