<%@page contentType="text/html;charset=UTF-8" %><%@ page import="java.net.*"%><%@ page import="java.util.*"%><%@ page import="java.text.*"%><%@ page import="java.security.*"%><%@ page import="com.capinfo.crypt.*"%><%@ page import="tea.entity.member.*"%>
<%@ page import="tea.ui.*"%><%@ page import="java.math.*"%><%@ page import="tea.entity.csvclub.alipay.*"%><%@ page import="tea.entity.csvclub.encrypt.*" %><%@ page import="tea.entity.admin.mov.*" %><%@ page import="tea.entity.admin.*" %>
<%@ page import="tea.entity.ocean.*" %><%@ page import="tea.db.DbAdapter" %>
<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String community=teasession._strCommunity;
StringBuffer param=new StringBuffer();
StringBuffer sql=new StringBuffer();
//String idz=(request.getParameter("id"));
//if(idz!=null&&idz.length()>0)
//{
//
//  param.append("&id=").append(idz);
//}

param.append("?id=").append(request.getParameter("id"));
String name="";
if(teasession.getParameter("name")!=null  && teasession.getParameter("name").length()>0)
{
  name = teasession.getParameter("name");
  sql.append(" and name=").append(DbAdapter.cite(name));
  param.append("&name=").append(DbAdapter.cite(name));
}
String fieldname=request.getParameter("fieldname");
if(fieldname==null)
{
  fieldname="form3.bumen";
}

int pos = 0, pageSize = 10, count = 0;
if (request.getParameter("pos") != null) {
  pos = Integer.parseInt(request.getParameter("pos"));
}
count =AdminUnit.countByCommunity(teasession._strCommunity,sql.toString());
%>
<html>
<head>
  <link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
  <script> if(parent.lantk) { document.getElementsByTagName("LINK")[0].href="/res/csvclub/cssjs/community_02.css"; } </script>
  <SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type="" ></SCRIPT>
  <SCRIPT LANGUAGE=JAVASCRIPT SRC="/jsp/csvclub/js.js" type=""></SCRIPT>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <META HTTP-EQUIV="Pragma" CONTENT="no-cache"/>
  <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache"/>
  <META HTTP-EQUIV="Expires" CONTENT="0"/>
<title>选择分店的部门</title>
<script type="">
window.name="tar";
function add_mode(mode_name)
{
  window.returnValue = mode_name;
  window.close();
}

</script>
</head>
<body>
<h1>选择分店的部门</h1>
<form action="?" method="post" target="tar">
<input type="hidden" name="id" value="<%=request.getParameter("id")%>"/>
<TABLE border="0" CELLPADDING="0" CELLSPACING="0" id="tablecenter">
  <tr><td  nowrap="nowrap">部门名称(店名)：</td><td><input  name="name" value="" size="8"/></td><td><input type="submit" value="查询" /></td></tr>
</table>
</form>


<TABLE border="0" CELLPADDING="0" CELLSPACING="0" id="tablecenter">
  <tr id="tableonetr"><td nowrap="nowrap">部门名称或分店名称</td></tr>
    <%
    Enumeration e = AdminUnit.findByCommunity(community,sql.toString(),pos,10);
    for(int j=0;e.hasMoreElements();j++)
    {
      AdminUnit obja=(AdminUnit)e.nextElement();
      int id=obja.getId();
      out.print("<tr><td nowrap>　<a href=# onclick=\"add_mode("+id+");\">"+ obja.getName()+"</a></td></tr>");
    }
    %>
    <%if(count>10){ %>
    <tr><td  id="tdpage" align="center" style="padding-right:5px;"> <%=new tea.htmlx.FPNL(teasession._nLanguage,request.getRequestURI()+"?"+request.getContextPath()+param.toString()+"&pos=",pos,count,10)%> </td></tr>
    <%
   out.print("<script>document.getElementById('go').style.display='none';</script>");
  } %>
</table>
<script>
var as=document.getElementById("tdpage");
if(as)
{
  as=as.getElementsByTagName("A");

  for(var i=0;i<as.length;i++)
  {
    as[i].setAttribute("target","tar");
  }
}

</script>
</body>
</html>

