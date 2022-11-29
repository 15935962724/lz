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
<%--
<script language="javascript" src="/tea/CssJs/AreaCityScipt.js"></script>
<script language="javascript" src="/tea/CssJs/SummaryDataCN.js"></script>
<script language="javascript" src="/tea/CssJs/SummaryScript.js"></script>
--%>
<script>
function submitSelect(obj,alerttext)
{
  if(obj.selectedIndex==0)
  {
    alert(alerttext);
    obj.focus();
    return false;
  }
  return true;
}

function f(obj)
{
  var type_0=document.getElementById('type_0');
  var type_1=document.getElementById('type_1');
  if(obj.value==1)
  {
    type_0.style.display='';
    type_1.style.display='none';

    form1.Email.value=form1.MemberId.value;
  }else
  {
    type_0.style.display='none';
    type_1.style.display='';
    form1.PhoneNumber.value=form1.MemberId.value;
  }
}

function submitCheck(form1)
{
	if(form1.type.value==0)
	{
		if(form1.regmail[1].checked)
		{
			if(!submitIdentifier(form1.MemberId,'<%=r.getString(teasession._nLanguage, "InvalidMemberId")%>'))
			{
				return false;
			}
			form1.Email.value=form1.MemberId.value+"@"+form1.domain.value;
		}else
		{
			if(!submitEmail(form1.MemberId,'<%=r.getString(teasession._nLanguage, "InvalidEmailAddress")%>'))
			{
				return false;
			}
			form1.Email.value=form1.MemberId.value;
		}
	}else
	if(form1.type.value==1)
	{
		if(!submitText(form1.MemberId,'<%=r.getString(teasession._nLanguage, "InvalidMobile")%>'))
		{
			return false;
		}
		form1.PhoneNumber.value=form1.MemberId.value;
	}
	return(submitIdentifier(form1.EnterPassword,'<%=r.getString(teasession._nLanguage, "InvalidPassword")%>')
	&&submitEqual(form1.EnterPassword,form1.ConfirmPassword,'<%=r.getString(teasession._nLanguage, "InvalidConfirm")%>')
	&&submitText(form1.FirstName,'<%=r.getString(teasession._nLanguage, "InvalidFirstName")%>')
	&&submitText(form1.LastName,'<%=r.getString(teasession._nLanguage, "InvalidLastName")%>')
	&&submitEmail(form1.Email,'<%=r.getString(teasession._nLanguage, "InvalidEmailAddress")%>')
	&&submitEqual(form1.EnterPassword,form1.ConfirmPassword,'<%=r.getString(teasession._nLanguage, "InvalidConfirmPassword")%>')
	&&submitText(form1.State,'<%=r.getString(teasession._nLanguage, "InvalidParameter")%>'));
}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body id="bodynone" >

<div id="jspbefore" style="display:none">
<%=community.getJspBefore(teasession._nLanguage)%>
</div>
<div id="tablebgnone" class="register">
<h1>申请</h1>
<div id="head6"><img height="6" src="about:blank"></div>
  <FORM name=form1 METHOD=POST >
  <input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
  <input type="hidden" name="Node" value="<%=teasession._nNode%>"/>
  <input type="hidden" name="Language" value="<%=teasession._nLanguage%>"/>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <th nowrap>*

         公司名称:&nbsp;&nbsp;&nbsp;&nbsp;</th>
         <input type="hidden" class="edit_input"  name=MemberId value="登录用户id" size=30 maxlength=40>
      <td ><input type="TEXT" class="edit_input"  name=MemberId value="" size=70 maxlength=40><span id="domain"></span></td>
      <td colspan="2"></td>
      </tr>
      <tr>
        <th nowrap>*

       登录ID:&nbsp;&nbsp;&nbsp;&nbsp;</th>
      <td ><input type="TEXT" class="edit_input"  name=MemberId value="" size=70 maxlength=40><span id="domain"></span></td>
      <td colspan="2"></td>
      </tr>
      <tr>
        <th nowrap>*
       密码:&nbsp;&nbsp;&nbsp;&nbsp;</th>
      <td ><input type="TEXT" class="edit_input"  name=MemberId value="" size=20 maxlength=40><span id="domain"></span>
         确认密码
        <input type="TEXT" class="edit_input"  name=MemberId value="" size=20 maxlength=40><span id="domain"></span></td>

      </tr>
       <tr>
      <th nowrap>*

       联系人:&nbsp;&nbsp;&nbsp;&nbsp;</th>
      <td ><input type="TEXT" class="edit_input"  name=MemberId value="" size=70 maxlength=40><span id="domain"></span></td>
      <td colspan="2"></td>
      </tr>
       <tr>
      <th nowrap>*

       联系方式:&nbsp;&nbsp;&nbsp;&nbsp;</th>
      <td >&nbsp;</td>
      <td colspan="2"></td>
      </tr>

      <tr>
      <th nowrap>*
      电话:&nbsp;&nbsp;&nbsp;&nbsp;</th>
      <td ><input type="TEXT" class="edit_input"  name=MemberId value="" size=70 maxlength=40><span id="domain"></span></td>
      <td colspan="2"></td>
      </tr>
       <tr>
      <th nowrap>*
      传真:&nbsp;&nbsp;&nbsp;&nbsp;</th>
      <td ><input type="TEXT" class="edit_input"  name=MemberId value="" size=70 maxlength=40><span id="domain"></span></td>
      <td colspan="2"></td>
      </tr>
       <tr>
      <th nowrap>*
      电邮:&nbsp;&nbsp;&nbsp;&nbsp;</th>
      <td ><input type="TEXT" class="edit_input"  name=MemberId value="" size=70 maxlength=40><span id="domain"></span></td>
      <td colspan="2"></td>
      </tr>
       <tr>
      <th nowrap>*
      手机:&nbsp;&nbsp;&nbsp;&nbsp;</th>
      <td ><input type="TEXT" class="edit_input"  name=MemberId value="" size=70 maxlength=40><span id="domain"></span></td>
      <td colspan="2"></td>
      </tr>
       <tr>
      <th nowrap>
      QQ:&nbsp;&nbsp;&nbsp;&nbsp;</th>
      <td ><input type="TEXT" class="edit_input"  name=MemberId value="" size=70 maxlength=40><span id="domain"></span></td>
      <td colspan="2"></td>
      </tr>
       <tr>
      <th nowrap>
      MSN:&nbsp;&nbsp;&nbsp;&nbsp;</th>
      <td ><input type="TEXT" class="edit_input"  name=MemberId value="" size=70 maxlength=40><span id="domain"></span></td>
      <td colspan="2"></td>
      </tr>
       <tr>
      <th nowrap>*
       证件类型:&nbsp;&nbsp;&nbsp;&nbsp;</th>
      <td ><input type="TEXT" class="edit_input"  name=MemberId value="" size=70 maxlength=40><span id="domain"></span></td>
      <td colspan="2"></td>
      </tr>
      <tr>
      <th nowrap>*
       证件号码:&nbsp;&nbsp;&nbsp;&nbsp;</th>
      <td ><input type="TEXT" class="edit_input"  name=MemberId value="" size=70 maxlength=40><span id="domain"></span></td>
      <td colspan="2"></td>
      </tr>

       <tr>
      <th nowrap>*申请说明:&nbsp;&nbsp;&nbsp;&nbsp;</th>
      <td ><input type="TEXT" class="edit_input"  name=MemberId value="" size=70 maxlength=40><span id="domain"></span></td>
      <td colspan="2"></td>
      </tr>
     <tr>
      <th nowrap>*
    资质证明文件:&nbsp;&nbsp;&nbsp;&nbsp;</th>
      <td ><input type="file" class="edit_input"  name=MemberId value="" size=70 maxlength=40><span id="domain"></span></td>
      <td colspan="2"></td>
      </tr>

 <tr>
      <th nowrap>*
    管理者类型:&nbsp;&nbsp;&nbsp;&nbsp;</th>
      <td >
      <select><option>酒店直营</option><option>代理商</option>
      </select>
      </td>
      <td colspan="2"></td>
      </tr>


  </table>

    <input type="button" class="edit_button" id="edit_submit"   value="<%=r.getString(teasession._nLanguage, "Submit")%>">
  </FORM>
<SCRIPT type="text/javascript">document.form1.MemberId.focus();</SCRIPT>

<div id="head6"><img height="6" src="about:blank" alt=""></div></div>

<div id="jspafter" style="display:none">
<%=community.getJspAfter(teasession._nLanguage) %>
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






