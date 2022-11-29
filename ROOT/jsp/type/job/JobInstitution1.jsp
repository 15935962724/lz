<%@page contentType="text/html; charset=UTF-8"%>
<%@page import="tea.ui.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.entity.node.Hotel_application"%>
<%@page import="tea.entity.site.*"%>
<%@page import="tea.entity.member.*"%>
<%@page import="tea.db.*"%>
<%@page import="tea.entity.admin.*"%>
<%
request.setCharacterEncoding("UTF-8");
TeaSession teasession = new TeaSession(request);



%>

 <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<%
DbAdapter db = new DbAdapter();
boolean fa = false;
try
{

  db.executeQuery("SELECT distinct(j.orgid) FROM Node n INNER JOIN Job j ON n.node=j.node WHERE  n.type=50 AND n.hidden = 0 AND n.community="+db.cite(teasession._strCommunity));

  while(db.next()){
    Node n = Node.find(db.getInt(1));
    out.print("<tr><td>");
    out.print("<A HREF=\"/servlet/Company?node="+db.getInt(1)+"&language=1\" TARGET=\"_self\">");
    out.print(n.getSubject(teasession._nLanguage));
    out.print("</A>");
    out.print("</td></tr>");
    fa = true;
  }
} finally
{
  db.close();
}
if(!fa)
{
  out.print("<tr><td colspan=10 align=center>暂无记录</td></tr>");
}
%>

</table>


