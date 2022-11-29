<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ page import="tea.ui.TeaSession" %>

<%
request.setCharacterEncoding("UTF-8");

TeaSession teasession = new TeaSession(request);
tea.entity.site.Community community = tea.entity.site.Community.find(teasession._strCommunity);
String item_number = request.getParameter("item_number");
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" language="javascript" src="/tea/tea.js"></script>
<title>Done</title>
</head>
<body  id="bodynone2">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="<%=community.getJspBeforePath(teasession._nLanguage)%>" type="text/javascript"></SCRIPT>


          <form  name="form1" action="?" method="get" enctype="multipart/form-data">
          <input   type="hidden"  name="act"  value="OceanSuccess">
          <table id="tableSuccess">
            <tr><td rowspan="2" class="td01"></td>
            </tr>
<tr>
  <td class="td03">
      <div class="Payno1">
      Hello：<br>
Please remember your order number:<%=item_number %><!--，相关信息已经发送到您的邮箱zhangsan@sina.com，请注意查收。--></div>
<div class="Payno2"></td>
        </tr>
          </table>
        <div class="CloseButton">
<input type="button" value="Close" onClick="window.close();" />
</div>
          </form>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="<%=community.getJspAfterPath(teasession._nLanguage)%>" type="text/javascript"></SCRIPT>
</body>
</html>