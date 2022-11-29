<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>

<%
r.add("/tea/resource/Service");
tea.entity.node.Service investor =tea.entity.node.Service.find(0, teasession._nLanguage);
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/jquery.js" type="text/javascript"></script>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<META http-equiv=Content-Type content="text/html; charset=UTF-8">
<SCRIPT language=JavaScript>
<!--
function checkform(theform)
{
return(submitText(theform.Subject,'主题不能为空'))&&
(submitInteger(theform.minimum,'最小值必须是数字'))&&
(submitFloat(theform.point,'积分必须是数字'))&&
(submitFloat(theform.price,'单价必须是数字'));

}
//-->
</SCRIPT>
</head>
<BODY>
<h1><%=r.getString(teasession._nLanguage, Node.NODE_TYPE[65])%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="edit_BodyDiv">
<div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%>  </div>

<FORM name="form1" action="/servlet/EditService"  method=post enctype="multipart/form-data" onSubmit="return checkform(this);">
<%
String parameter=request.getParameter("nexturl");
boolean parambool=(parameter!=null&&!parameter.equals("null"));
if(parambool)
out.print("<input type='hidden' name=nexturl value="+parameter+">");
String subject="",text="";
Date issDate=null;
if(request.getParameter("NewNode")!=null)
{
  out.println("<INPUT TYPE=hidden NAME=NewNode VALUE=ON>");
}else
if(request.getParameter("NewBrother")!=null)
{
  out.println("<INPUT TYPE=hidden NAME=NewBrother VALUE=ON>");
}else
{
  subject=node.getSubject(teasession._nLanguage);
  text=node.getText(teasession._nLanguage);
  investor= tea.entity.node.Service.find(teasession._nNode, teasession._nLanguage);
  issDate=node.getTime();
}
%>
<input type='hidden' name="node" value="<%=teasession._nNode%>">
<INPUT TYPE="hidden" NAME="TypeAlias" VALUE="<%=request.getParameter("TypeAlias")%>">

  <TABLE border="0" cellspacing="0" cellpadding="0" id="tablecenter" style="BORDER-COLLAPSE: collapse">
    <tr>
      <td align=right nowrap ><%=r.getString(teasession._nLanguage, "Subject")%>:</td>
      <td colspan="20"><input type="TEXT" class="edit_input"  name=Subject value="<%=HtmlElement.htmlToText(subject)%>" size=70 maxlength=255><FONT color=#ff0000>(*)</FONT> </td>
    </tr>
    
    <tr>
      <td align=right nowrap><%=r.getString(teasession._nLanguage, "类型")%>:</td>
      <td colSpan=3>
      <select name="type11" onchange="fn1()">
      <option value="1">1</option>
      <option value="2">2</option>
      </select>
      </td>
    </tr>
    <tr id="sss">
      <td align=right nowrap><%=r.getString(teasession._nLanguage, "区域")%>:</td>
      <td colSpan=3><INPUT name=thing  class="edit_input" value="<%=getNull(investor.getThing())%>">
      </td>
    </tr>
    <div id="ddd"></div>
    <tr align=middle>
      <td colSpan=4><INPUT type=submit  ID="edit_GoFinish" class="edit_button" value=提交 name=Submit>
        <INPUT type=reset value=重填  ID="edit_GoFinish" class="edit_button" name=Submit2>
          <input type="submit" name="GoBack" id="edit_GoBack" class="edit_button" value="<%=r.getString(teasession._nLanguage, "Super")%>">
      </td>
    </tr>
</TABLE>
</FORM>

<script>document.form1.Subject.focus();
function fn1(){
	if(form1.type11.value==2){
		$('#ddd').load('/jsp/type/services/EditService.jsp');
	}
}

</script>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</html>
