<%@page contentType="text/html;charset=utf-8" %>
<%@include file="/jsp/Header.jsp"%>
<%
String community=request.getParameter("community");
if(community==null)
{
  community=node.getCommunity();
}
if(request.getMethod().equals("POST"))
{
  String number = request.getParameter("number");
  String message =request.getParameter("message");
  boolean save = request.getParameter("save") != null;
  String result = tea.entity.member.SMSMessage.send("webmaster", teasession._nLanguage, number, message, save, community, 0, null);
//  super.outText(teasession, response, result);
  response.sendRedirect("/jsp/info/Succeed.jsp?info="+java.net.URLEncoder.encode(result,"UTF-8")+"&node="+teasession._nNode+"&community="+community);
  return;
}

r.add("/tea/resource/SMS");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script type="">
function LoadWindow(obj)
{
  URL="/jsp/sms/psmanagement/FrameGU.jsp?index="+obj;
  loc_x=document.body.scrollLeft+event.clientX-event.offsetX-100;
  loc_y=document.body.scrollTop+event.clientY-event.offsetY+210;
  window.showModalDialog(URL,self,"edge:raised;scroll:0;status:0;help:0;resizable:1;dialogWidth:320px;dialogHeight:265px;dialogTop:"+loc_y+"px;dialogLeft:"+loc_x+"px");
}
function fkey(obj,obj2)
{
  obj2.value=obj.value.length;
}
function submitMobile(obj,text)
{
  if(isNaN(parseInt(obj.value))||obj.value.indexOf("13")!=0||obj.value.length<11)
  {
    alert(text);
    obj.focus();
    return false;
  }
  return true;
}
</script>
</head>

<body onload="form1.number.focus();">
<form name="form1" action="<%=request.getRequestURI()%>" method="POST" onsubmit="return submitMobile(this.number,'无效手机号')&&submitText(this.message,'无效内容')">
<input type="hidden" name="node" value="<%=teasession._nNode%>"/>
<input type="hidden" name="community" value="<%=community%>"/>
   <h1><%=r.getString(teasession._nLanguage,"SendSMS")%></h1>
   <div id="head6"><img height="6" src="about:blank"></div>
   <br>
     <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td nowrap><%=r.getString(teasession._nLanguage,"Number")%></TD>
    <td><input type="text" value="13" name="number"><input type="button" value="..." onclick="LoadWindow('form1.number');"/></td>
  </tr>
  <tr>
    <td nowrap><%=r.getString(teasession._nLanguage,"Text")%></TD>
    <td><textarea name="message" cols="50"  onKeyUp="fkey(this,form1.count);" onchange="fkey(this,form1.count);" onmouseup="fkey(this,form1.count);" onpaste="fkey(this,form1.count);" onkeypress="fkey(this,form1.count);" rows="5"></textarea><br/>
<%=r.getString(teasession._nLanguage,"WordCount")%><input type=text name="count" style="border: 0px;" readonly="readonly" size="3" value="0">
	</td>
  </tr>
  <tr><TD><%=r.getString(teasession._nLanguage,"Options")%></TD><td><input  id="CHECKBOX" type="CHECKBOX" checked="checked" name="save"/><%=r.getString(teasession._nLanguage,"Save")%>
  <tr>
    <td>&nbsp;</td>
    <td><input type="submit" name="Submit" value="<%=r.getString(teasession._nLanguage,"CBSend")%>">
    <input type="reset" name="Submit" value="<%=r.getString(teasession._nLanguage,"Reset")%>"></td>
  </tr>
</table>
</form>
   <br>
   <div id="head6"><img height="6" src="about:blank"></div>
   <br/>
   <div id="language"></div>
</body>
</html>


