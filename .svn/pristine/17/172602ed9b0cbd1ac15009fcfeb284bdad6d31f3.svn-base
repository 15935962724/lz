<%@page contentType="text/html;charset=UTF-8" %>
<%@ include file="/jsp/Header.jsp" %>
<%
String community=node.getCommunity();
%>
<html>
<head>
<link href="/tea/CssJs/css.css" rel="stylesheet" type="text/css">
<link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<DIV ID="edit_BodyDiv">

<%
tea.ui.TeaSession teasession=new tea.ui.TeaSession(request);
tea.db.DbAdapter dbadapter=new tea.db.DbAdapter();String nexturl=java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString());
try
{
  dbadapter.executeQuery("SELECT node FROM Node WHERE community="+dbadapter.cite(community)+" AND type=21 AND finished=1 AND rcreator="+dbadapter.cite(teasession._rv._strR)+" AND vcreator="+dbadapter.cite(teasession._rv._strV));
  int nodecode;

  if(dbadapter.next())
  {
    nodecode=dbadapter.getInt(1);
    %>
    <%=  tea.entity.node.Node.find(nodecode).getSubject(teasession._nLanguage)%>

    <input type="button" name="" id="edit_submit" class="edit_button" value="编辑" onclick="window.open('ManageEditCompany.jsp?node=<%=nodecode%>&nexturl=<%=nexturl%>','_self')" >
      <input type="button" name="" id="edit_submit" class="edit_button" onClick="if(confirm('确认删除')){window.open('/servlet/DeleteNode?node=<%=nodecode%>&nexturl=<%=nexturl%>', '_self');}" value="删除">
        <%
        }else
        response.sendRedirect("ManageEditCompany.jsp?"+request.getQueryString()+"&nexturl="+nexturl);
      }catch(Exception e)
      {
        e.printStackTrace();
      }finally{
        dbadapter.close();
      }
%>
</DIV>
</body>
</html>

