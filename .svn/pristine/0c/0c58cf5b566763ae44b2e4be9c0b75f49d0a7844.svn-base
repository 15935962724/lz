<%@page contentType="text/html;charset=UTF-8" %>
<%@page  import="tea.entity.contract.*" %>
<%@include file="/jsp/Header.jsp"%>
<%@page import="java.util.*" %>
<%

request.setCharacterEncoding("UTF-8");
TeaSession teasession=new TeaSession(request);

int id =0;
if(teasession.getParameter("id")!=null && teasession.getParameter("id").length()>0)
   id = Integer.parseInt(teasession.getParameter("id"));
   StringBuffer param = new StringBuffer("?community=" + teasession._strCommunity);
   int pos=0;
   String tmp=request.getParameter("pos");
if(tmp!=null)
{
  pos=Integer.parseInt(tmp);
}
int count=Iteminfo.count(teasession._strCommunity);

param.append("&id=").append(id);
param.append("&pos=");
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">

</head>
<body>
<form action="?" method="POST" name="form1">
<h1>
项目类型列表
</h1>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr>
<td>编号</td><td>类型</td><td>操作</td>
<%

//Enumeration item= Iteminfo.find(teasession._strCommunity,pos,10);
Vector item=(Vector)Iteminfo.find1(teasession._strCommunity,pos,10);
 for(int i=0;i<item.size();i++)
    {
    Iteminfo iobj=(Iteminfo)item.get(i);
    %>
    <tr>
    <td><%=iobj.getItemid() %></td>
    <td><%=iobj.getItemtype()%></td>
    <td><a href="/jsp/contract/iteminfo.jsp?itemid=<%=iobj.getItemid()%>">修改</a>/<a href="/servlet/editItemInfo?del=<%=iobj.getItemid()%>">删除</a></td>

    <%} %>
    <tr>
    <td colspan="4"><a href="/jsp/contract/iteminfo.jsp" target="_self">增加项目类型</a></td>
    </tr>
    <tr><td align="center" colspan="4"><%=new tea.htmlx.FPNL(teasession._nLanguage,param.toString(),pos,count,10)%></td></tr>
  </table>
</body>
</html>
