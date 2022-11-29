<%@page contentType="text/html;charset=UTF-8" %><%@ page import="java.net.*"%><%@ page import="java.util.*"%><%@ page import="java.text.*"%><%@ page import="java.security.*"%><%@ page import="com.capinfo.crypt.*"%><%@ page import="tea.entity.member.*"%>
<%@ page import="tea.ui.*"%><%@ page import="java.math.*"%><%@ page import="tea.entity.csvclub.alipay.*"%><%@ page import="tea.entity.csvclub.encrypt.*" %><%@ page import="tea.entity.admin.mov.*" %><%@ page import="tea.entity.admin.*" %>
<%@ page import="tea.entity.ocean.*" %><%@ page import="tea.db.DbAdapter" %>
<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");

TeaSession teasession = new TeaSession(request);
String community=teasession._strCommunity;
StringBuffer param=new StringBuffer();
StringBuffer sql=new StringBuffer();
String menu_id=(request.getParameter("id"));
if(menu_id!=null&&menu_id.length()>0)
{

  param.append("&id=").append(menu_id);
}

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
  fieldname="form1.member";
}

int pos = 0, pageSize = 10, count = 0;
if (request.getParameter("pos") != null) {
  pos = Integer.parseInt(request.getParameter("pos"));
}
count =AdminUsrRole.count(teasession._strCommunity,sql.toString());
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
<title>选择经办人</title>
<script type="">
window.name="me";
function add_mode(mode_name)
{
  window.returnValue = mode_name;
  window.close();
}
</script>
</head>
<body>
<h1>选择经办人</h1>
<form action="/jsp/leagueshop/leagueShopbumen.jsp" method="GET" target="me">
<table border="0" CELLPADDING="0" CELLSPACING="0" id="tablecenter">
  <tr><td  nowrap="nowrap">姓名：</td><td><input  name="name" value="" size="8"/></td><td><input type="submit" value="查询" /></td></tr>
</table>
</form>
<table border="0" CELLPADDING="0" CELLSPACING="0" id="tablecenter">
  <tr id="tableonetr"><td nowrap="nowrap">姓名</td></tr>
    <%
    Enumeration e = AdminUsrRole.findByCommunity(teasession._strCommunity," and  member in (select member from Profile)");
    for(int j=0;e.hasMoreElements();j++)
    {
      String members=String.valueOf(e.nextElement());
      AdminUsrRole obja=AdminUsrRole.find(teasession._strCommunity ,members);

      String nameshow="";
      if(Profile.isExisted(members))
      {
        Profile pro = Profile.find(members);
        nameshow=pro.getName(teasession._nLanguage);
      }
       out.print("<tr><td nowrap>　<a href=# onclick=\"add_mode('"+members+"');\">"+ nameshow+"</a></td></tr>");
    }
    %>
</table>

</body>
</html>

