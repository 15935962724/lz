<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.resource.Resource" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.member.*" %>
<%@page import="tea.ui.TeaSession" %>
<%@page import="java.io.*" %>
<%@page import="java.util.*" %>
<% request.setCharacterEncoding("UTF-8");


TeaSession teasession=new TeaSession(request);

if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

DbAdapter db = new DbAdapter();
try
{
 out.print("<marquee behavior=scroll direction=up scrollAmount=2 scrollDelay=1><TABLE id=\"tablecenter\">");
db.executeQuery("select distinct(member) from OnlineList where  member is not null and community="+db.cite(teasession._strCommunity));
    while(db.next())
    {
      String mem = db.getString(1);
      OnlineList oobj = OnlineList.find(mem);
      Profile pobj = Profile.find(mem);
     out.print("<tr><td colspan=2 align=left nowrap=nowrap>");
      if((pobj.getLastName(teasession._nLanguage)+pobj.getFirstName(teasession._nLanguage))!=null && (pobj.getLastName(teasession._nLanguage)+pobj.getFirstName(teasession._nLanguage)).length()>0)
      {
        out.print(pobj.getLastName(teasession._nLanguage)+pobj.getFirstName(teasession._nLanguage));
      }else
      {
        out.print(mem);
      }
   out.print("</td></tr>");
    }
       out.print("</TABLE></marquee>");
}finally
{
  db.close();
}
%>
