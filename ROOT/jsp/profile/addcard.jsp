<%@ page contentType="text/html; charset=UTF-8" %>
<%tea.ui.TeaSession teasession = new tea.ui.TeaSession(request); %>
<html>
<head>
<script   language="Javascript" type="text/javascript">
  function check() {
    var name = document.form1.cardname.value;
    if(name == ""){
      alert('请输入新建名片夹名称！');
      return false;
    }
    document.form1.action="/servlet/AddCardHouse";
    document.form1.submit();
opener.location.reload();
  window.close();
  }
  </script>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script language="javascript" src="/tea/CssJs/AreaCityData_zh_CN.js" type=""></script>
<title>
新建名片夹
</title>
</head>
<body bgcolor="#ffffff">
<h1 align="center">
新建名片夹
</h1>
<form action="/servlet/AddCardHouse" name="form1" method="POST">
<table align="center" border="0" id="tablecenter">
<tr>
<td align="center">
新建名片夹名称：
</td>
<td align="center"><input type="text" name="cardname"/></td>
</tr>
<tr>
<td align="center" colspan="2">
<input type="button" value="创建" onclick="check();"/>
</td>
</tr>
</table>
</form>
</body>
</html>
