<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%><%@page import="tea.ui.*"%><%@page import="tea.entity.member.*"%><%@page import="tea.entity.admin.*"%><%@page import="tea.entity.*"%><%@page import="tea.db.*"%><%@page import="tea.entity.node.*"%><%@page import="tea.entity.bbs.*"%><%

TeaSession teasession=new TeaSession(request);


String member=teasession._rv!=null?teasession._rv._strR:null;


StringBuilder sb=new StringBuilder();
DbAdapter db=new DbAdapter();
try
{
  db.executeQuery("SELECT father FROM Node WHERE community="+DbAdapter.cite(teasession._strCommunity)+" AND node IN (SELECT node FROM Category WHERE category=57) GROUP BY father");
  while(db.next())
  {
    sb.append(",").append(db.getInt(1));
  }
}finally
{
  db.close();
}

%>

<form name="form1" action="/jsp/type/bbs/EditBBS.jsp" target="_parent">
<input type="hidden" name="NewNode" value="ON"/>
<table>
<%
boolean auth=false;

Enumeration e=Node.find(" AND node IN(0"+sb.toString()+")",0,100);
while(e.hasMoreElements())
{
  int node=((Integer)e.nextElement()).intValue();
  Node n=Node.find(node);
  out.print("<tr><th>"+n.getSubject(teasession._nLanguage));
  Enumeration e2=Node.find(" AND father="+node+" AND type=1 AND node IN (SELECT node FROM Category WHERE category=57)",0,200);
  while(e2.hasMoreElements())
  {
    int forum=((Integer)e2.nextElement()).intValue();
    Node f=Node.find(forum);
    BBSForum bf=BBSForum.find(forum);

    out.print("<tr><td><input type='radio' name='node' value='"+forum+"'");
    if(bf.isAuth(teasession._strCommunity,member,bf.ltopic,bf.rtopic))
      auth=true;
    else
      out.print(" disabled");
    out.print(">"+f.getSubject(teasession._nLanguage));
  }
}

if(!auth&&member==null)
{
  out.print("<script>parent.location.href='/servlet/StartLogin?node="+teasession._nNode+"';</script>");
}

%>
</table>
<input type="submit" name="multi" value="发表"> <input type="button" value="关闭" onclick="parent.mt.close()"/>
</form>
<script src="/tea/mt.js"></script>
<script>
mt.disabled(form1.node);
</script>
