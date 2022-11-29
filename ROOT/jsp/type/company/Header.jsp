<%@page contentType="text/html;charset=UTF-8"  %>
<%@include file="/jsp/Header.jsp"%>

<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
.unnamed1 {
	background-image: url(file:///C|/Documents%20and%20Settings/Administrator/My%20Documents/My%20Pictures/latinlogo.jpg);
	background-repeat: no-repeat;
	background-position: 1px 1px;
	text-decoration: none;
	border: 1px solid #CCCCCC;
}
-->
</style></head>

<body>

    <table border="0" width="100%" height="71" cellspacing="0" cellpadding="0">
      <tr>
        <td  id=logozone width="382" rowspan="2">&nbsp;
        </td>
                <td align="right" valign="bottom" style="padding-right:30px" valigh=bottom>
				<a href="ManageCompanyindex.jsp?node=15419" target="_parent">管理首页｜</a><a href="/servlet/Folder?node=14741" target="_blank">前台首页</a><a href="/servlet/Logout"  target="_parent">｜退出登陆</a>　　当前用户：<%=teasession._rv%></td>
      </tr>
    </table>
</body>
</html>


