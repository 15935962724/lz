<%@page contentType="text/html;charset=UTF-8" %><%@ page import="java.net.*"%><%@ page import="java.util.*"%><%@ page import="java.text.*"%><%@ page import="java.security.*"%><%@ page import="com.capinfo.crypt.*"%><%@ page import="tea.entity.member.*"%>
<%@ page import="tea.ui.*"%><%@ page import="java.math.*"%><%@ page import="tea.entity.csvclub.alipay.*"%><%@ page import="tea.entity.csvclub.encrypt.*" %><%@ page import="tea.entity.admin.mov.*" %><%@ page import="tea.entity.admin.*" %>
<%@ page import="tea.entity.ocean.*" %>
<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");

TeaSession teasession = new TeaSession(request);
StringBuffer param=new StringBuffer();
String menu_id=(request.getParameter("id"));
if(menu_id!=null&&menu_id.length()>0)
{
  param.append("&id=").append(menu_id);
}

String  num = "";
String str="暂无信息";
if(teasession.getParameter("num")!=null && teasession.getParameter("num").length()>0)
{
  num = teasession.getParameter("num");
  int ii = Integer.parseInt(teasession.getParameter("num"));
  int i=3; switch(ii)
  {
    case 1: out.println("<h1>分店销售情况监测</h1>");break;
    case 2: out.println("<h1>分店销售情况统计</h1>");break;
    case 3: out.println("<h1>分店库存统计</h1>");break;
    case 4: out.println("<h1>分店进货量统计</h1>");break;
    case 5: out.println("<h1>分店订货单管理</h1>");break;
    case 6: out.println("<h1>分店会员信息</h1>");break;
    case 7: out.println("<h1>分店库存预警</h1>");break;
    default:out.println("default");break;
  }
}

//分店销售情况监测	（1）刘
//分店数量统计
//分店销售情况统计	（2）刘
//分店库存统计	（3）金舒
//分店进货量统计	（4）金舒
//分店订货单管理	（5）金舒s
//该分店会员信息	（6）刘
//分店库存预警	（7）刘



%>
<html>
<head>
  <link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
  <script>if(parent.lantk) {document.getElementsByTagName("LINK")[0].href="/res/csvclub/cssjs/community_02.css"; }</script>
  <SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type="" ></SCRIPT>
  <SCRIPT LANGUAGE=JAVASCRIPT SRC="/jsp/csvclub/js.js" type=""></SCRIPT>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <META HTTP-EQUIV="Pragma" CONTENT="no-cache"/>
  <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache"/>
  <META HTTP-EQUIV="Expires" CONTENT="0"/>
<title>无</title>
</head>
<body>

<TABLE border="0" CELLPADDING="0" CELLSPACING="0" id="tablecenter">
<tr>
</tr>
</table>
</body>
</html>

