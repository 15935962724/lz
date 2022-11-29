<%@page contentType="text/html;charset=UTF-8"  %>
<%@include file="/jsp/Header.jsp"%>

<html>
<head>
<title>无标题文档</title>
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

-->
</style></head>

<body bgcolor="#FFFBF0">



<div align="center"><br>
  <span style="font-size:14px;color:#990000;"> <%=teasession._rv%></span>
</div>
<table border="0" cellpadding="0" cellspacing="0" >

  <tr>
    <td scope="row"><a href="/jsp/type/report/ManageCompanyReportView.jsp?NewNode=ON&Type=39&TypeAlias=0&node=16827"><br>

    </a>
      <div > <a href="/servlet/Logout?nexturl=http://127.0.0.1:82" target="_parent">退出登陆</a></div>
<div  onclick="document.all.child1.style.display=(document.all.child1.style.display =='none')?'':'none';" >
  <a href="/jsp/type/company/ManageCompanyView.jsp?NewNode=ON&Type=39&TypeAlias=0&node=16909" target="mainFrame">发布公司简介</a></div>

 <div ><a href="/jsp/user/ChangePassword.jsp?nexturl=/servlet/Folder?node=14741" target="mainFrame">用户密码修改</a></div>
 <div ><a href="/jsp/type/goods/ManageCompanyGoodsView.jsp?NewNode=ON&Type=34&TypeAlias=0&node=16830" target="mainFrame">创建公司产品</a></div>
 <div ><a href="/jsp/type/report/ManageCompanyReportView.jsp?NewNode=ON&Type=39&TypeAlias=0&node=16033" target="mainFrame">销售信息发布</a></div>
 <div ><a href="/jsp/type/report/ManageCompanyReportView.jsp?NewNode=ON&Type=39&TypeAlias=0&node=16827" target="mainFrame">购买信息发布</a></div>
 <div ><a href="/jsp/type/report/ManageCompanyReportView.jsp?NewNode=ON&Type=39&TypeAlias=0&node=16828" target="mainFrame">代理信息发布</a></div>
 <div ><a href="/jsp/type/report/ManageCompanyReportView.jsp?NewNode=ON&Type=39&TypeAlias=0&node=16829" target="mainFrame">合作信息发布</a></div>
 <div ><a href="/jsp/type/report/ManageCompanyReportView.jsp?NewNode=ON&Type=39&TypeAlias=0&node=16762" target="mainFrame">创建公司新闻</a></div>
 <div id="main1"><a href="/jsp/talkback/CreateAllTalkbackList.jsp?pos=3 " target="mainFrame">查看客户留言</a></div>
	</td>
  </tr>
</table>

</body>
</html>

