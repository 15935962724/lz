<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.entity.im.*" %><%@page import="tea.entity.node.*" %><%@page import="java.util.*" %><%@page import="tea.ui.*" %><%@page import="tea.db.*" %>
<%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);

String community=teasession._strCommunity;

String name=request.getParameter("name");
String tmember=request.getParameter("tmember");
if(tmember==null)
{
  tmember=Node.find(teasession._nNode).getCreator()._strV;
}


%><html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<LINK href="/res/<%=community%>/cssjs/community.css" REL="stylesheet" TYPE="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type=""></SCRIPT>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/jsp/im/im.js" type=""></SCRIPT>
</head>

<body onLoad="im_load()">

<div id="history" style="width:270px;height:100px;overflow-y:auto;border:1px solid #4A6FB5;font-size:12px;line-height:120%;margin:0px auto 0px auto;text-align:left;"></div>
<form name="form1" method="post" action="/servlet/EditImMessage" onSubmit="return im_refresh(true);">
<input type="hidden" name="community" value="<%=community%>">
<input type="hidden" name="tmember" value="<%=tmember%>">
<input name="content" type="text" id="wenben_text" style="width:270px;border:1px solid #4A6FB5;margin:3px auto;">
<input style="background:url(/res/lib/u/0805/080547959.jpg);width:62px;height:19px;border:0px;" type="submit" name="send" value="" accesskey="S">
</form>

</body>
</html>
