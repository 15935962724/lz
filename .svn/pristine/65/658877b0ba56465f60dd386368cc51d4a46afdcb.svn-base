<%@page contentType="text/html;charset=UTF-8" %>

<%@ page  import="tea.resource.Resource"  %>
<%@page  import="tea.entity.copyright.*" %>
<%@ page import="tea.ui.TeaSession" %>
<%@page  import="tea.entity.contract.*" %>
<%@page import="java.util.*" %>
<%@include file="/jsp/Header.jsp"%>
<%

request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);

//out.print(teasession._strCommunity);

 java.text.DecimalFormat df =new java.text.DecimalFormat("#.00");
int id =0;

if(teasession.getParameter("id")!=null && teasession.getParameter("id").length()>0)
  {
    id = Integer.parseInt(teasession.getParameter("id"));
  }

StringBuffer sql=new StringBuffer();

String member=teasession._rv.toString();
StringBuffer param = new StringBuffer("?community=" + teasession._strCommunity);
sql.append("");

int pos=0;
String tmp=request.getParameter("pos");
if(tmp!=null)
{

  pos=Integer.parseInt(tmp);
}
int count=Contract.count(teasession._strCommunity);
//Enumeration enu = Contract.find(teasession._strCommunity,pos,10);
java.util.Vector enu=(Vector)Contract.findList(teasession._strCommunity,pos,10);

param.append("&id=").append(id);
param.append("&pos=");

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
</head>
<body >
<form action="?" name="form1">
<h1>经销商列表</h1>
<table  border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr>
  <td>经销商</td><td>当月销售额</td><td>累计销售额</td><td>所在地区</td>
</tr>
<%
 //while(enu.hasMoreElements())
    //{
    //String mem=(String)enu.nextElement();
    //Contract cobj = Contract.find(mem);
    for(int i=0;i<enu.size();i++){
    Contract cobj=(Contract)enu.get(i);
    %>
    <tr>
    <td ><a href="/jsp/contract/conlist.jsp?mem=<%=cobj.getMember()%>"><%=cobj.name()%></a></td><td><%=df.format(cobj.month())%></td><td><%=df.format(cobj.sum())%></td><td><%=cobj.area()%></td>
    </tr>
    <%
  }
    %>
 <tr><td align="center" colspan="4"><%=new tea.htmlx.FPNL(teasession._nLanguage,param.toString(),pos,count,10)%></td></tr>
</table>
</form>

</body>
</html>
