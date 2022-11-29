<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter"%>
<%@ page import="tea.resource.Resource"%>
<%@ page import="tea.entity.admin.*" %>
<%@ page import="tea.ui.TeaSession" %>
<%@ page import="java.util.*" %>
<%@ page import="tea.db.*" %>
<%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

int showcount=Integer.parseInt(request.getParameter("showcount"));

String community=teasession._strCommunity;
// String sql = " and type=1 and (naught =2 or naught2=2)";

String member=teasession._rv.toString();
AdminUsrRole adobj = AdminUsrRole.find(teasession._strCommunity,member);

 StringBuffer sql=new StringBuffer(" and type=1 ");
 sql.append(" and (( tmember='/' and tunit='/'  ) or");
 sql.append("(");
//String aa[] = adobj.getRole().split("/");//当然用户的角色
//for(int i=1;i<aa.length;i++)
//{
//	sql.append("   partid like '%/"+aa[i]+"%' or ");
//}
sql.append(" tmember LIKE '%/"+member+"/%'");
sql.append(" OR tunit LIKE '%/"+adobj.getUnit()+"/%'))");
/*
java.util.Calendar c=Calendar.getInstance();
int day=c.get(c.DAY_OF_YEAR);
c.set(c.DAY_OF_YEAR,day-20);
Date ctime = c.getTime();
sql.append(" and issuetime >= ").append(DbAdapter.cite(Bulletin.sdf.format(ctime)));
*/
int count = Bulletin.count(teasession._strCommunity,sql.toString());
sql.append(" ORDER BY issuetime desc  ");

//System.out.println(sql.toString());


java.util.Enumeration enumer = Bulletin.find(teasession._strCommunity,sql.toString(),0,5);
if(!enumer.hasMoreElements())
{
  out.print("暂无公告");
}else
while(enumer.hasMoreElements())
{
  int id = ((Integer)enumer.nextElement()).intValue();
  Bulletin obj = Bulletin.find(id);
  String caption=obj.getCaption();

  if(caption.length()>24)
  {
    caption=caption.substring(0,23)+"...";
  }
%><div><a href="/jsp/admin/flow/BulletinContent.jsp?community=<%=community %>&bulletin=<%=id %>" title="<%=obj.getCaption()%>" target="_blank"><%
if(obj.getNotread()==0)
{
  out.print("<b>");
  out.print(caption);
  out.print("</b>");
}else
{
  out.print(caption);
}
%></a>
<%=obj.getIssuetimeToString().substring(0,10)%></div>
<%
}
if(count>showcount)
{
  %>
<!--  <tr><td><a href="/jsp/admin/flow/SeeBulletin.jsp" target="_blank">更多</a></td></tr>--><%
}
%>

