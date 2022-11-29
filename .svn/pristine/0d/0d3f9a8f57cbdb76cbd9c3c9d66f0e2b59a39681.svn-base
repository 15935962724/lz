<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@page import="java.util.*"%><%@ page  import="tea.resource.Resource"  %><%@ page  import="tea.entity.node.*" %><%@ page  import="tea.entity.util.*" %><%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);

String q=request.getParameter("t255_q");


/*
Enumeration e=request.getHeaderNames();
while(e.hasMoreElements())
{
	String name=(String)e.nextElement();
	String value=request.getHeader(name);
	System.out.println(name+":"+value);
}*/

String lan=request.getHeader("Accept-Language");
if(lan.startsWith("zh-cn"))
	lan="zh_CN";
else
if(lan.startsWith("zh-tw"))
	lan="zh_TW";
else
{
	int i=lan.indexOf(";");
	if(i!=-1)
	{
		lan=lan.substring(0,i);
	}
}

String ip=request.getRemoteAddr();
String addr=NodeAccessWhere.findByIp(ip).substring(0,3);

Enumeration e=Card.find(" AND card<100 AND address LIKE "+DbAdapter.cite(addr+"%"),0,1);
if(e.hasMoreElements())
{
  addr=String.valueOf(((Card)e.nextElement()).getCard());
}else
{
  addr="00";
  System.out.println("Adword没有找到对应的地区:"+ip+":"+addr);
}
e=Adword.find(q,addr,lan);

out.print("<table>");
while(e.hasMoreElements())
{
  int id=((Integer)e.nextElement()).intValue();
  Adword obj=Adword.find(id);
  obj.setHits();
  out.print("<tr><td>");
  String pic=obj.getAdpic();
  if(pic!=null&&pic.length()>0)
  out.print("<a target=_blank href=/servlet/EditAdwordClick?adword="+id+"&ai="+System.currentTimeMillis()+session.getId()+" ><img src="+pic+"></a><br>");
  out.print("<a target=_blank href=/servlet/EditAdwordClick?adword="+id+"&ai="+System.currentTimeMillis()+session.getId()+" >"+obj.getAdtitle()+"</a><br>");
  out.print("<span id=adexplain1>"+obj.getAdexplain1()+"</span><br>");
  out.print("<span id=adexplain2>"+obj.getAdexplain2()+"</span><br>");
  out.print("<span id=adshow>"+obj.getAdshow()+"</span><br>");
  out.print("</td></tr>");
  out.print("<tr><td>&nbsp;</td></tr>");
}
out.print("</table>");

%>

