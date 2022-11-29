<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="tea.htmlx.*"%>
<%@page import="tea.ui.TeaSession"%>
<%@page import="tea.resource.*"%>
<%@page import="tea.entity.site.*"%>
<%@page import="tea.db.*" %>
<%@page import="tea.entity.member.Profile"%>

<%
   request.setCharacterEncoding("UTF-8");

TeaSession teasession = new TeaSession(request);
Resource r = new Resource("/tea/ui/util/SignUp1").add("/tea/htmlx/HtmlX");

StringBuffer param=new StringBuffer("?community=").append(teasession._strCommunity);
StringBuffer sql=new StringBuffer();


String members = teasession.getParameter("members");
if(members!=null && members.length()>0)
{
  sql.append(" and member like ").append(" ").append(DbAdapter.cite("%"+members+"%"));
  param.append("&members=").append(members);
}
String names = teasession.getParameter("names");
if(names!=null && names.length()>0)
{
  sql.append(" and member in (select member from ProfileLayer where firstname like  ").append(" ").append(DbAdapter.cite("%"+names+"%")).append(")");
  param.append("&names=").append(java.net.URLEncoder.encode(names,"UTF-8"));
}
int count=Profile.countByCommunity(teasession._strCommunity,sql.toString());
int pos=0;
int pageSize=20;
if(teasession.getParameter("Pos")!=null)
{
  pos=Integer.parseInt(teasession.getParameter("Pos"));
}

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body id="bodynone">
<script type="">
function f_quzhi(m)
{
   window.opener.f_unit(m);
   window.close();
}
</script>
  <h1><%=r.getString(teasession._nLanguage, "会员查询")%>  </h1>
  <h2>查询</h2>
    <form action="?" name="form1" METHOD="POST">
    <table border="0" cellpadding="0" cellspacing="0" id="tablecenter" align="left">
    <tr>
      <td>会员ID:<input type="text" name="members" value="<%if(members!=null)out.print(members);%>"/> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      会员名称:<input type="text" name="names" value="<%if(names!=null)out.print(names);%>">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      <input type="submit" value="查询"/>
</td>
    </tr>
</table>
<h2>列表</h2>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter" align="left">
    <tr>
      <td nowrap="nowrap">会员ID</td>
      <td nowrap="nowrap">会员名称</td>
    </tr>
    <%
       java.util.Enumeration e = Profile.findByCommunity(teasession._strCommunity,sql.toString(),pos,pageSize);
        if(!e.hasMoreElements())
       {
         out.print("<tr><td align=center colspan=4>暂无记录</td></tr>");
       }
       while(e.hasMoreElements())
       {
           String m = ((String)e.nextElement());
           Profile p = Profile.find(m);
         %>
         <tr onclick="f_quzhi('<%=m%>');">
           <td ><%=m %></td>
           <td><%=p.getLastName(teasession._nLanguage)+p.getFirstName(teasession._nLanguage)%></td>
         </tr><%
       }if(count>pageSize){
       %>
       <tr>
         <td>&nbsp;</td>
         <td align="center"><%=new tea.htmlx.FPNL(teasession._nLanguage, request.getRequestURI()+param.toString() + "&Pos=", pos, count,pageSize)%></td>
       </tr><%} %>
  </table>
  </form>

</body>
</html>
