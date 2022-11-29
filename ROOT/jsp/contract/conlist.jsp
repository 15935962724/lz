<%@page contentType="text/html;charset=UTF-8" %>
<%@page  import="tea.entity.contract.*" %>
<%@include file="/jsp/Header.jsp"%>
<%
  java.text.DecimalFormat df =new java.text.DecimalFormat("#.00");
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
//out.print(teasession._strCommunity);
int id =0;
if(teasession.getParameter("id")!=null && teasession.getParameter("id").length()>0)
   id = Integer.parseInt(teasession.getParameter("id"));

StringBuffer param = new StringBuffer("?community=" + teasession._strCommunity);
StringBuffer sql=new StringBuffer();
sql.append(" order by time desc");
String member=null;
if(teasession.getParameter("mem")!=null&&!teasession.equals("")){
  member=teasession.getParameter("mem");
}else{
 member=teasession._rv.toString();
}
int pos=0;
String tmp=request.getParameter("pos");
if(tmp!=null)
{
  pos=Integer.parseInt(tmp);
}
int count=Contract.count(teasession._strCommunity,member,sql.toString());
Vector enu = (Vector)Contract.findList(teasession._strCommunity,member,sql.toString(),pos,10);

param.append("&id=").append(id);
param.append("&pos=");

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
</head>
<body >
<form action="?" method="POST" name="form1">
<h1>用户项目列表</h1>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">

<tr>
<td>合同名称</td><td>签定时间</td><td>金额</td><td>预付款金额</td><td>项目类型</td>
<%if(member.equals(teasession._rv.toString())){ %>
<td>操作</td>
<%} %>

</tr>
<%
 for(int i=0;i<enu.size();i++)
    {

    Contract cobj =(Contract) enu.get(i);



    %>
    <tr>

    <td><%=cobj.getCname()%></td>
    <td><%=cobj.getTime().substring(0,10)%></td>
    <td><%=df.format(cobj.getMoney())%></td>
    <td><%=df.format(cobj.getPrepay()) %></td>
    <td><%= tea.entity.contract.Iteminfo.find(cobj.getType()).getItemtype()%></td>
    <%if(member.equals(teasession._rv.toString())){ %>
    <td><a href="/jsp/contract/contract.jsp?conid=<%=cobj.getConid()%>">修改</a>/<a href="/servlet/ContractServlet?del=<%=cobj.getConid()%>">删除</a></td>
    <%} %>
    </tr>
<%} %>

<%
if(member.equals(teasession._rv.toString())){
%>
<tr>
<td colspan="6"><a href="/jsp/contract/contract.jsp" target="_self">提交项目</a></td>
</tr><%} %>

<tr><td align="center" colspan="4"><%=new tea.htmlx.FPNL(teasession._nLanguage,param.toString(),pos,count,10)%></td></tr>

</table>
</form>
</body>
</html>
