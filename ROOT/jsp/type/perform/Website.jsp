<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="tea.ui.TeaSession"%>
<%@page import="tea.entity.site.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.resource.*"%>
<%@page import="tea.db.*"%>
<%@page import="tea.entity.member.*"%>
<%@page import="tea.entity.admin.*"%>
<%@page import="java.util.Date"%>

<%
request.setCharacterEncoding("UTF-8");
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession = new TeaSession(request);
if (teasession._rv == null) {
  response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
  return;
}


String nexturl = request.getRequestURI()+"?"+request.getQueryString();


StringBuffer sql = new StringBuffer("");



%>

<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" language="javascript" src="/tea/tea.js"></script>
<script src="/tea/Calendar.js" type="text/javascript"></script>
<title>售票点管理</title>
</head>

<body>

<h1>售票点管理</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<form name="form1" action="?" method="GET">
<input type="hidden" name="ip" value="<%out.print(request.getServerName()+":"+request.getServerPort()); %>">
  <input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
  <input type="hidden" name="id" value="<%=request.getParameter("id")%>" >

  <table border="0" cellpadding="0" cellspacing="0" class="Search">
    <tr>
       <td class="tdp1">票据编号: </td>
       <td class="tdp2"><input type="text" id="pjnumber" name="pjnumber" value="" ></td>
       <td class="tdp3"><input type="button" class="SearchInput" value="" ></td>
		</tr>
  </table>

  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <TR id="tableonetr">
      <TD nowrap>售票点名称</TD>
      <TD nowrap>联系人</TD>
      <TD nowrap>联系电话</TD>
      <TD nowrap>操作</TD>
    </TR>
      <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
        <td colspan="7">在输入查询的票据编号,查询票据.</td>
      </tr>
  </table>
  <br>
<input type="button" value="添加售票点" onclick="window.open('/jsp/type/perform/EditWebsite.jsp','_self');" />

  </form>


  <div id="head6"><img height="6" src="about:blank"></div>
</div>
</body>
</html>
