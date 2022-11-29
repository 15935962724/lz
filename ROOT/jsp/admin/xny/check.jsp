<%@page contentType="text/html;charset=UTF-8" %><%@page import="java.io.*"%><%@page import="java.util.*"%><%@page import="net.mietian.common.*"%><%@page import="tea.ui.*"%><%@page import="tea.db.*"%><%@page import="tea.entity.site.*"%><%@page import="tea.entity.member.*"%><%
request.setCharacterEncoding("UTF-8");
String sn=request.getServerName();
String ip=request.getRemoteAddr();
String ua=request.getHeader("User-Agent");

%>
<form action="?">
  <select name="type" id="type">
    <option value="cec">cec</option>
    <option value="xny">xny</option>
  </select>
  <input type="submit" value="&#25552;&#20132;" />
</form>

<%
String type=request.getParameter("type");
if(type==null)return;
%>
<table>
<tr><th>表单</th><th>字段</th><th>名称</th></tr>
<%
Enumeration e=DynamicType.find("",0,Integer.MAX_VALUE);
while(e.hasMoreElements())
{
  int dtid=((Integer)e.nextElement()).intValue();
  DynamicType dt=DynamicType.find(dtid);
  int did=dt.getDynamic();
  File f=new File(application.getRealPath("/jsp/admin/"+type+"/Flowbusiness_"+did+".jsp"));
  if(f.exists())
  {
    System.out.println(dtid);
    String h=tea.entity.Filex.read(f.getPath(),"utf-8");
    if(h.indexOf("/"+dtid+"/")==-1&&h.indexOf("td"+dtid+"\"")==-1)
    {
      out.println("<tr><td>"+did+"<td>"+dtid+"<td>"+dt.getName(1));
    }
  }
}
%>
</table>
