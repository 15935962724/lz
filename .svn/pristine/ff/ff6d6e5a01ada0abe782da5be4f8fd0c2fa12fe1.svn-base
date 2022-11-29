<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html>
<head>
<script src="/tea/tea.js" type="text/javascript"></script>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
<body>
<h1><%=r.getString(teasession._nLanguage, "CBNewMessage")%></h1>
<div id="head6"><img height="6" src="about:blank" alt=""></div>
<form name="form1" method="post" onsubmit="return( submitText(this.Subject,'���ⲻ��Ϊ��')&&submitText(this.Content,'���ݲ���Ϊ��'))" action="/servlet/NewMessage" id="form1" style="MARGIN: 0px">
<input name="Cc" type="hidden" id="Cc">
<input name="Bcc" type="hidden" id="Bcc">
<input name="Hint"  type="hidden" value="1">
<div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td align="center" width="8%">To</td>
    <td class="purpleFont" width="92%">
      <input name="To"  value="webmaster" type="text">
    </td>
  </tr>
  <tr>
    <td align="center" width="8%">����</td>
    <td class="purpleFont" width="92%">
      <input name="Subject" type="text">
    </td>
  </tr>
  <tr>
    <td width="3%">
      <img src="../images/icon/BlueArrow.gif" width="5" height="9" alt="BlueArrow">
    </td>
    <td class="blueFont">�����ŵ�����:</td>
  </tr>
  <tr>
    <td colspan="2" class="BlueFont" valign="top" align="center">
      <textarea name="Content" rows="10" cols="110" id="TextBox1" class="msninput"></textarea>
      <FONT face="����">      </FONT>
    </td>
  </tr>
  <tr>
    <td colspan="2" class="BlueFont" height="30" align="center">
      <input type="submit" class="PicButton" value="��������">
    </td>
  </tr>
</table>
</form>
<div id="head6"><img height="6" src="about:blank" alt=""></div>
  <div id="language"><%=new Languages(teasession._nLanguage,request)%></div>

