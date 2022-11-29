<%@ page contentType="text/html; charset=UTF-8" %>
<%
request.setCharacterEncoding("utf-8");
String cid = request.getParameter("cid");
tea.ui.TeaSession teasession = new tea.ui.TeaSession(request);
tea.db.DbAdapter db = new tea.db.DbAdapter();
db.executeQuery("select cardtypename from cartewarehouse where cardtypeid=" + cid);
%>
<html>
<head>
<script   language="Javascript" type="text/javascript">
  function check() {
     var name = document.form1.cardname.value;
    if(name == ""){
      alert('请输入新的名片夹名称！');
      return false;
    }
    document.form1.action="/servlet/UpCardName";
    document.form1.submit();
opener.location.reload();
  window.close();
  }
  </script>
    <link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script language="javascript" src="/tea/CssJs/AreaCityData_zh_CN.js" type=""></script>
<title>
重命名
</title>
</head>
<body bgcolor="#ffffff">
<h1 align="center">
名片夹重命名
</h1>
<form name="form1" action="/servlet/UpCardName" method="post">
<table align="center" border="2" id="tablecenter">
  <tr>
    <td align="center">
    此名片夹新名称：
    </td>
    <%while(db.next()){ %>
    <td align="center"><input type="text" name="cardname" value="<%=db.getString(1)%>"/>
      <input type="hidden" name="cid" value="<%=cid%>"/>
    </td><%
    }
    %>
    </tr>
    <tr>
      <td align="center" colspan="2">
        <input type="button" value="更改名称" onclick="check();"/>
      </td>
    </tr>
</table>
</form>
</body>
</html>
