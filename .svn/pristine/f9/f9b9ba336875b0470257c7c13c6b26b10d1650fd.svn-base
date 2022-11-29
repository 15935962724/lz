<%@page contentType="text/html;charset=UTF-8" %><%@ page import="java.util.*" %><%@ page import="tea.entity.admin.*" %><%@ page import="tea.entity.site.*" %><%@ page import="java.math.*" %><%@ page import="tea.entity.member.*" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.*" %><%@ page import="tea.entity.node.*" %><%@ page import="tea.ui.TeaSession" %><% request.setCharacterEncoding("UTF-8");

response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

Resource r=new Resource("/tea/resource/SMS");

//SMSProfile sp_obj=SMSProfile.find(teasession._rv._strV,teasession._strCommunity);
//if(sp_obj.getPassword()==null||sp_obj.getPassword().length()<1)
//{
//  response.sendRedirect("/jsp/info/Alert.jsp?info="+java.net.URLEncoder.encode("您的手机还没有进行验证,请先验证(在\"更改手机\"中点\"下一步\").","UTF-8")+"&nexturl="+java.net.URLEncoder.encode("/jsp/sms/EditSMSProfile.jsp?node="+teasession._nNode+"&community="+teasession._strCommunity,"UTF-8"));
//  return;
//}
//
//SMSMoney sm_obj=SMSMoney.find(teasession._rv._strV,teasession._strCommunity);
//if(sm_obj == null || sm_obj.getBalance().compareTo(SMSMoney.SMS_PRICE)==-1)
//{
//  response.sendRedirect("/jsp/info/Alert.jsp?info="+java.net.URLEncoder.encode("余额不足,请联系管理员.","UTF-8"));
//  return;
//}

AdminUsrRole aur=AdminUsrRole.find(teasession._strCommunity,teasession._rv._strV);
if(AdminUnit.find(aur.getUnit()).getPath().indexOf("/"+227+"/")!=-1)
{
  response.sendRedirect("/jsp/info/Alert.jsp?info="+java.net.URLEncoder.encode("工程局成员,无权发送短信.","UTF-8"));
  return;
}

String to = request.getParameter("to");
String tmember="/";
if(to!=null)
{
  tmember=tmember+to+"/";
  Profile p=Profile.find(to);
  to=p.getName(teasession._nLanguage)+"; ";
}

%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script type="">
function f_open()
{
  window.open('/jsp/user/list/SelMembers2.jsp?community=<%=teasession._strCommunity%>&member=form1.tmember&unit=form1.tunit&name=form1.name&notnull=mobile','','width=450px,height=350px,top=300px,left=400px');
}
function f_clear()
{
  form1.tmember.value="/";
  form1.tunit.value="/";
  form1.name.value="";
}
function f_sel(obj)
{
  var v=obj.value;
  if(v=="")return;
  var range = document.selection.createRange();
  var range_all = document.body.createTextRange();
  range_all.moveToElementText(obj);
  var start=0;
  while(range_all.compareEndPoints("StartToStart", range) < 0&&start<v.length-2)
  {
    range_all.moveStart('character', 1);
    start++;
  }
  range_all.moveStart('character', -start)
  //
  start=v.lastIndexOf(' ',start)+1;
  range_all.moveStart('character', start);
  var end=v.indexOf(';',start);
  range_all.moveEnd('character', end-v.length);
  range_all.select();
  obj.selectionStart=start;
  obj.selectionEnd=end;
}
function f_del(event,obj)
{
  var kc=event.keyCode;
  if(kc==8||kc==46)
  {
    var v=obj.value;
    obj.value=v.substring(0,obj.selectionStart)+v.substring(obj.selectionEnd+2);
    //v=v.substring(obj.selectionStart,obj.selectionEnd);
  }
}
</script>
</head>

<body onload="form1.content.focus();">
<form name="form1" action="/servlet/EditSMSMessage" method="POST" onsubmit="return submitText(this.name,'无效内部人员')&&submitText(this.content,'无效内容')">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="tmember" value="<%=tmember%>">
<input type="hidden" name="tunit" value="/">

<h1><%=r.getString(teasession._nLanguage,"SendSMS")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<%--
  <tr>
    <td>帐户余额:</td>
    <td><%=sm_obj.getBalance()%></td>
  </tr>
--%>
  <tr>
    <td nowrap><%=r.getString(teasession._nLanguage,"接收人员")%></TD>
    <td>
      <textarea name="name" readonly="readonly" cols="50" rows="2" onkeyup="f_del(event,this)" onclick="f_sel(this)"><%if(to!=null)out.print(to);%></textarea>
      <input type="button" value="添加" onClick="f_open();" />
      <input type="button" value="清空" onClick="f_clear();" />
    </td>
  </tr>
  <tr>
    <td nowrap><%=r.getString(teasession._nLanguage,"短信正文")%></TD>
    <td><%=SMSMessage.contentToHtml(teasession,"content")%></td>
  </tr>
  <%--
  <tr>
    <td><%=r.getString(teasession._nLanguage,"Options")%></td>
    <td>
      <!--1172546539508=保存到"短信发送记录"-->
      <input  id="CHECKBOX" type="CHECKBOX" checked="checked" name="save"/><%=r.getString(teasession._nLanguage,"1172546539508")%>
    </td>
  </tr>
  --%>
  <tr>
    <td>&nbsp;</td>
    <td><input type="submit" name="Submit" value="<%=r.getString(teasession._nLanguage,"CBSend")%>">
      <input type="reset" name="Submit" value="<%=r.getString(teasession._nLanguage,"Reset")%>"></td>
  </tr>
</table>
</form>

<br>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"></div>
</body>
</html>
