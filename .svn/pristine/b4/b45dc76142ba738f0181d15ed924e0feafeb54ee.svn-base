<%@page contentType="text/html;charset=UTF-8"%>
<%
tea.ui.TeaSession teasession=new tea.ui.TeaSession(request);
tea.entity.node.Node node=tea.entity.node.Node.find(teasession._nNode);
%>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>

<body  >

<h1>消息</h1>
<div id="head6"><img height="6" alt=""></div>
<h2></h2>
<br/>
<table border="0" cellPadding="0" cellSpacing="0" id="tablecenter">
        
		<tr >
		<td width="100" height="100" rowspan="2">成功</td>
          <td>保存成功</td>
        </tr>
		        <tr ><td><A href="javascript:history.back();">返回</A></td>
        </tr>
      </table>


<br/>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</html>



