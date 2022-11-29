<%@page contentType="text/html;charset=UTF-8" %>
<%@ include file="/jsp/Header.jsp" %>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"></head>
<body>
<h1><%=r.getString(teasession._nLanguage, "ManageCompanyReportView")%></h1>
  <div id="head6"><img height="6" src="about:blank"></div>

<DIV ID="edit_BodyDiv">
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<%
tea.ui.TeaSession teasession=new tea.ui.TeaSession(request);
tea.db.DbAdapter dbadapter=new tea.db.DbAdapter();
  String nexturl=java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString());
try
{
  dbadapter.executeQuery("SELECT node FROM Node WHERE type=39 AND finished=1 AND rcreator="+dbadapter.cite(teasession._rv._strR)+" AND vcreator="+dbadapter.cite(teasession._rv._strV)+" AND path like '%/"+teasession._nNode+"/%'");
  int nodecode=0;
  while(dbadapter.next())
  {
    nodecode=dbadapter.getInt(1);
    %><tr><td>
    <%=  tea.entity.node.Node.find(nodecode).getSubject(teasession._nLanguage)%></td><td>
    <input type="button" name="" class="edit_button" value="编辑" onclick="window.open('EditReport.jsp?node=<%=nodecode%>&nexturl=<%=nexturl%>','_self')" >
      <input type="button" name="" class="edit_button" onClick="if(confirm('确认删除')){window.open('/servlet/DeleteNode?node=<%=nodecode%>&nexturl=<%=nexturl%>', '_self');}" value="删除"></td></tr>
        <%
        }
        if(nodecode==0)
        response.sendRedirect("EditReport.jsp?"+request.getQueryString()+"&nexturl="+nexturl);
      }catch(Exception e)
      {
        e.printStackTrace();
      }finally{
        dbadapter.close();
      }
%></table>
<br />
  <input type="button" class="edit_button" value="创建" onclick="window.open('EditReport.jsp?<%=request.getQueryString()%>&nexturl=<%=nexturl%>','_self')" >
</DIV>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>

