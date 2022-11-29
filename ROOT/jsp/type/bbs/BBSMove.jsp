<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%><%@page import="tea.ui.*"%><%@page import="tea.entity.member.*"%><%@page import="tea.entity.admin.*"%><%@page import="tea.entity.*"%><%@page import="tea.db.*"%><%@page import="tea.entity.node.*"%><%@page import="tea.entity.bbs.*"%><%


Http h=new Http(request);

int forum=h.getInt("forum");
String nexturl=h.get("nexturl");
String[] nodes=h.get("nodes").split(",");

StringBuilder sb=new StringBuilder();
DbAdapter db=new DbAdapter();
try
{
  db.executeQuery("SELECT father FROM Node WHERE community="+DbAdapter.cite(h.community)+" AND node IN (SELECT node FROM Category WHERE category=57) GROUP BY father");
  while(db.next())
  {
    sb.append(",").append(db.getInt(1));
  }
}finally
{
  db.close();
}

%>
<form name="form1" action="/servlet/EditBBS">
<input type="hidden" name="act" value="move"/>
<input type="hidden" name="nexturl" value="<%=nexturl%>"/>
<%
for(int i=1;i<nodes.length;i++)
{
  out.print("<input type='hidden' name='nodes' value='"+nodes[i]+"' />");
}
%>
<table>
<tr><td>移动至：<td>
<select name="forum">
<%
Enumeration e=Node.find(" AND node IN(0"+sb.toString()+")",0,100);
while(e.hasMoreElements())
{
  int node=((Integer)e.nextElement()).intValue();
  Node n=Node.find(node);
  out.print("<optgroup label=\""+n.getSubject(h.language)+"\">");
  Enumeration e2=Node.find(" AND father="+node+" AND type=1 AND node IN (SELECT node FROM Category WHERE category=57)",0,200);
  while(e2.hasMoreElements())
  {
    int nid=((Integer)e2.nextElement()).intValue();
    Node f=Node.find(nid);

    out.print("<option value='"+nid+"'");
    if(forum==nid)out.print(" selected");
    out.print(">"+f.getSubject(h.language));
  }
  out.print("</optgroup>");
}
%>
</select>
<tr><td><td><input type="submit" value="提交"> <input type="button" value="关闭" onclick="parent.mt.close()"/>
</table>
</form>
