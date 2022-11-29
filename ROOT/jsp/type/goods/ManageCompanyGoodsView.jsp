<%@page contentType="text/html;charset=UTF-8" %>
<%@ include file="/jsp/Header.jsp" %>
<%tea.ui.TeaSession teasession=new tea.ui.TeaSession(request);
String community=tea.entity.node.Node.find(teasession._nNode).getCommunity();
%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "ManageCompanyGoodsView")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <%
tea.db.DbAdapter dbadapter=new tea.db.DbAdapter(); String nexturl=java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString());
try
{
  dbadapter.executeQuery("SELECT node FROM Node WHERE community="+dbadapter.cite(community)+" AND type=34 AND finished=1 AND rcreator="+dbadapter.cite(teasession._rv._strR)+" AND vcreator="+dbadapter.cite(teasession._rv._strV));
  int nodecode=0;

    while(dbadapter.next())
  {
    nodecode=dbadapter.getInt(1);
    %>
  <tr>
    <td>&nbsp;&nbsp;<%=  tea.entity.node.Node.find(nodecode).getSubject(teasession._nLanguage)%></TD>
    <TD>　 &nbsp;
      <input type="button" name="" class="edit_button" value="编辑" onclick="window.open('EditGoods.jsp?node=<%=nodecode%>&nexturl=<%=nexturl%>','_self')" >
      <input type="button" name="" class="edit_button" onClick="if(confirm('确认删除')){window.open('/servlet/DeleteNode?node=<%=nodecode%>&nexturl=<%=nexturl%>', '_self');}" value="删除"></TD>
  </TR>
  <%
        }
        if(nodecode==0)
        response.sendRedirect("EditGoods.jsp?"+request.getQueryString()+"&nexturl="+nexturl);
      }catch(Exception e)
      {
        e.printStackTrace();
      }finally{
        dbadapter.close();
      }
%>
</table>
<br />
<input type="button" class="edit_button" value="创建" onclick="window.open('EditGoods.jsp?<%=request.getQueryString()%>&nexturl=<%=nexturl%>','_self')" >
</p>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</html>

