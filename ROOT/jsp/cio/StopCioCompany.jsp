<%@page contentType="text/html;charset=UTF-8" %><%@page import="java.util.*" %>
<%@ page import="tea.db.DbAdapter"%><%@page import="tea.resource.Resource" %>
<%@ page import="tea.entity.cio.*" %><%@ page import="tea.ui.TeaSession" %>
<%@page import="tea.entity.site.*" %>
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
sql.append(" AND central=1");
if(q!=null)
{
  sql.append(" AND name LIKE ").append(DbAdapter.cite("%"+q+"%"));
}

Resource r=new Resource();


CommunityOption co = new CommunityOption(teasession._strCommunity);
Date stoptime=co.getDate("ciostoptime");
Date starttime=co.getDate("ciostarttime");


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

<h1>截止日期设置</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br/>
<form name="form1" action="/servlet/EditCioCompany" method="post" >
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<script type="">document.write("<input type='hidden' name='nexturl' value='"+location+"' />");</script>
<input type="hidden" name="id" value="<%=menuid%>"/>
<input type="hidden" name="act" value="stop"/>

<div id="mihu">报名截止日期 <input type="text" name="stoptime" onClick="showCalendar(this)" value="<%if(stoptime!=null)out.print(CommunityOption.sdf.format(stoptime));%>"></div>
<div id="mihu">会议开始日期 <input type="text" name="starttime" onClick="showCalendar(this)" value="<%if(starttime!=null)out.print(CommunityOption.sdf.format(starttime));%>"></div>


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
  if(cc.isSpecial())
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
<input type="submit" class="button_02"  value="设置选中企业不受截止日期限制" />
</div>
<div  id="tablebottom_02">
说明：<br/>
截止日期是指参会报名截止日期<br/>
日期后不可以在填报,<br/>
设置不受截止日期限制的企业可以继续填报.
</div>
</form>

<%@include file="/jsp/include/Calendar2.jsp" %>
<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
