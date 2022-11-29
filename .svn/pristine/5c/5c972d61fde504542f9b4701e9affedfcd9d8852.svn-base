<%@page contentType="text/html;charset=UTF-8" %><%@ page import="java.net.*"%><%@ page import="java.util.*"%><%@ page import="java.text.*"%><%@ page import="java.security.*"%><%@ page import="com.capinfo.crypt.*"%><%@ page import="tea.entity.member.*"%>
<%@ page import="tea.ui.*"%><%@ page import="java.math.*"%><%@ page import="tea.entity.csvclub.alipay.*"%><%@ page import="tea.entity.csvclub.encrypt.*" %><%@ page import="tea.entity.admin.mov.*" %><%@ page import="tea.entity.admin.*" %>
<%@ page import="tea.entity.citybcst.*" %><%@ page import="tea.entity.site.*" %>
<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");

TeaSession teasession = new TeaSession(request);
Community community=Community.find(teasession._strCommunity);
StringBuffer param=new StringBuffer();

String menu_id=(request.getParameter("id"));
if(menu_id!=null&&menu_id.length()>0)
{
  param.append("&id=").append(menu_id);
}



String num="0";
if(teasession.getParameter("num")!=null)
{
  num=teasession.getParameter("num");
}

int ids=0;
if(teasession.getParameter("ids")!=null && teasession.getParameter("ids").length()>0)
{
  ids=Integer.parseInt(teasession.getParameter("ids"));
}
CityBcst bcstobj = CityBcst.find(ids);

%>
<html>
<head>

<script> if(parent.lantk) { document.getElementsByTagName("LINK")[0].href="/res/csvclub/cssjs/community_02.css"; } </script>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type="" ></SCRIPT>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/jsp/csvclub/js.js" type=""></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache"/>
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache"/>
<META HTTP-EQUIV="Expires" CONTENT="0"/>
<title>城市服务管理广播社区信息员招聘</title>

<link href="style.css" rel="stylesheet" type="text/css" />
<link href="../about/style.css" rel="stylesheet" type="text/css" />
<style type="text/css">
<!--
.lzj_01{font-size: 16px;font-weight: bold;line-height:150%;border:1px solid #4AB3FF;margin:10px 0;clear:both;}
#bodynone{width:100%;margin:0;text-align:center;font-size:12px;}
#bodynone img{border:0;}
-->
</style>
</head>

<body id=bodynone>
<div style="width:780px;margin:0 auto;">
<div id="jspbefore" style="display:none">
  <script>if(top.location==self.location)jspbefore.style.display='';</script><%=community.getJspBefore(teasession._nLanguage)%>
</div>

<TABLE width="80%" border="0" align="center" CELLPADDING="10" CELLSPACING="0" class="lzj_01">
  <tr>
  <td><img src="/res/radio/0904/0904991302.jpg"></td>
  <td>感谢您的报名，我们会在阶段报名完成后，统一审核报名人员提供的信息，并在七月或八月份主动与您联系，请您耐心等待。</td>
  </tr>
</table>

<div id="jspafter" style="display:none">
  <script>if(top.location==self.location)jspafter.style.display='';</script>
  <%=community.getJspAfter(teasession._nLanguage)%>
</div>
</div>
</body>
</html>

