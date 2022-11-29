<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter" %>
<%@ page  import="tea.resource.*"  %>
<%@ page  import="tea.entity.admin.*" %>
<%@ page  import="tea.htmlx.*" %>
<%@ page  import="tea.entity.admin.sales.*" %>
<%@ page import="tea.ui.TeaSession" %>
<%
request.setCharacterEncoding("UTF-8");
TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}
tea.resource.Resource r = new Resource() ;
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<body bgcolor="#ffffff">

<form method="post" action="ItemList.jsp">
<%
int flowitem=0;
int workproject = 0;
String ItemName = r.getString(teasession._nLanguage,"项目管理") ;

if(request.getParameter("workproject")!=null)
{
 workproject = Integer.parseInt(request.getParameter("workproject")) ;
}

if(request.getParameter("flowitem")!=null)
{
  flowitem = Integer.parseInt(request.getParameter("flowitem"));
  Flowitem obj=Flowitem.find(flowitem);
  ItemName = obj.getName(teasession._nLanguage);
}

%>
<script type="">
function changId(a)
{
  var ci=document.getElementById('currentnana');
  if(ci)
  {
    ci.id='nana';
  }
  a.id='currentnana';
}
</script>
<h1><%=ItemName%></h1><div id="biank">
<a id="nana" onClick="changId(this)" onfocus=this.blur()  href="/jsp/admin/workreport/WorkFormList.jsp?flowitem=<%=flowitem%>&workproject=<%=flowitem%>" target="VWproject2"><%=r.getString(teasession._nLanguage,"工作汇总")%></a>
<a id="nana" onClick="changId(this)" onfocus=this.blur()  href="/jsp/admin/workreport/ViewWorkproject2.jsp?workproject=<%=workproject%>&flowitem=<%=flowitem %>" target="VWproject2"><%=r.getString(teasession._nLanguage,"基本信息")%></a>
<!--a id="nana" onClick="changId(this)" onfocus=this.blur()  href="/jsp/admin/workreport/Worklogs_5.jsp?workproject=<%=flowitem%>" target="VWproject2"><%=r.getString(teasession._nLanguage,"工作日志")%></a-->
<a id="nana" onClick="changId(this)" onfocus=this.blur()  href="/jsp/admin/workreport/Worklogs_6.jsp?workproject=<%=flowitem%>" target="VWproject2"><%=r.getString(teasession._nLanguage,"总结汇报")%></a>
<a id="nana" onClick="changId(this)" onfocus=this.blur()  href="/jsp/admin/workreport/Worklogs_7.jsp?workproject=<%=flowitem%>" target="VWproject2"><%=r.getString(teasession._nLanguage,"问题反馈")%></a>
<a id="nana" onClick="changId(this)" onfocus=this.blur()  href="/jsp/admin/workreport/Worklogs_8.jsp?workproject=<%=workproject%>" target="VWproject2"><%=r.getString(teasession._nLanguage,"沟通记录")%></a>
<a id="nana" onClick="changId(this)" onfocus=this.blur()  href="/jsp/admin/workreport/Worklogs_9.jsp?workproject=<%=flowitem%>" target="VWproject2"><%=r.getString(teasession._nLanguage,"相关资料")%></a>
<!--a id="nana" onClick="changId(this)" onfocus=this.blur()  href="/jsp/admin/workreport/Worklogs_12.jsp?flowitem=<%=flowitem%>" target="VWproject2"><%=r.getString(teasession._nLanguage,"任务汇总")%></a-->
</div>
</form>
</body>
</html>



