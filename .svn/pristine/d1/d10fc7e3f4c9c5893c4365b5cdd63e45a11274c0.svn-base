<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.htmlx.*"%>
<%@ page import="tea.ui.TeaSession"%>
<%@ page import="tea.resource.*" %>
<%@ page import="tea.entity.site.*" %>
<%@ page import="tea.entity.member.Profile" %>
<jsp:useBean id="sms" scope="page" class="tea.entity.node.Sms" />
<%
TeaSession teasession = new TeaSession(request);
Resource r = new Resource("/tea/ui/util/SignUp1").add("/tea/htmlx/HtmlX");
String vertify=sms.password();
Community community=Community.find(teasession._strCommunity);
%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>

<script language="javascript" src="/tea/CssJs/AreaCityData_zh_CN.js"></script>
<script language="javascript" src="/tea/CssJs/AreaCityData<%=Common.CHATSET[teasession._nLanguage]%>.js"></script>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body id="bodynone" >
<div id="jspbefore" style="display:none">
<%=community.getJspBefore(teasession._nLanguage)%>
</div>
<div id="tablebgnone" class="register">
<h1><%=r.getString(teasession._nLanguage, "LogSignUp")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
  <FORM name=form1 METHOD=POST ACTION="EditUser.jsp" onSubmit="return submitCheck(this);">
  <input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
  <input type="hidden" name="Node" value="<%=teasession._nNode%>"/>
  <input type="hidden" name="Language" value="<%=teasession._nLanguage%>"/>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <th nowrap>*用户名:</th>
      <td ><input type="TEXT" class="edit_input"  name=MemberId value="" size=30 maxlength=40><span id="domain"></span></td>
      <td colspan="2"> </td>
      </tr>

    <tr>
      <th>* <%=r.getString(teasession._nLanguage, "密码设置")%>:</th>
      <td><input type="password" class="edit_input"  name=EnterPassword value="" size=30 maxlength=16></td>
    </tr>
    <tr>
      <th>* <%=r.getString(teasession._nLanguage, "密码确认")%>:</th>
      <td><input type="password" class="edit_input"  name=ConfirmPassword value="" size=30 maxlength=16></td>

    </tr>

  </table>

    <input type="submit"  class="edit_button" id="edit_submit"   value="<%=r.getString(teasession._nLanguage, "下一步")%>">
     <input type="submit" name="submit2" class="edit_button" id="edit_submit"   value="<%=r.getString(teasession._nLanguage, "保存并添加公司")%>">
  </FORM>
<SCRIPT>document.form1.MemberId.focus();</SCRIPT>

<div id="head6"><img height="6" src="about:blank" alt=""></div></div>

<div id="jspafter" style="display:none">
<%=community.getJspAfter(teasession._nLanguage)%>
</div>
<script>
if(top.location==self.location)
{
  jspbefore.style.display='';
  jspafter.style.display='';
}

f_regmail();
</script>


<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</html>




