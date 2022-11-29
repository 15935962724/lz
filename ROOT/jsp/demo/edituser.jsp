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
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type="text/javascript" ></SCRIPT>
<script language="javascript" src="/tea/CssJs/AreaCityData_zh_CN.js" type="text/javascript"></script>
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
<h1><%=r.getString(teasession._nLanguage, "LogSignUp")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
  <FORM name="form1" METHOD="POST" ACTION="EditUser.jsp" onSubmit="return submitCheck(this);">
  <input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
  <input type="hidden" name="Node" value="<%=teasession._nNode%>"/>
  <input type="hidden" name="Language" value="<%=teasession._nLanguage%>"/>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <th nowrap>*<%=r.getString(teasession._nLanguage, "MemberId")%>:&nbsp;&nbsp;&nbsp;&nbsp;</th>
      <td ><input type="TEXT" class="edit_input"  name="MemberId" value="从数据库中取id，设为只读" size=30 maxlength=40><span id="domain"></span></td>
      <td colspan="2"><%=r.getString(teasession._nLanguage, "InfSignUp")%> </td>
      </tr>
<%
if(community.isRegMail())
{
   String smtp=community.getSmtp();
   int i=smtp.indexOf(".");
   if(i!=-1)
   {
	   smtp=smtp.substring(i+1);
	   out.print("<tr><td></td><td><input name='regmail' type=radio value='false' onclick='f_regmail(this);' checked >是，使用我的电子邮件地址<br><input name='regmail' type=radio value='true' onclick='f_regmail(this);' >否，注册免费的电子邮件地址</td></tr>");
	   out.print("<input type=hidden name=domain value="+smtp+"><script> function f_regmail(){ if(form1.regmail[1].checked){ domain.innerHTML='@"+smtp+"'; form1.type.value=0;f(form1.type);form1.type.disabled=true; }else{ domain.innerHTML=''; form1.type.disabled=false; } } </script>");
   }
}
%>
   <tr>
      <th>* 原来的密码:</th>
      <td><input type="password" class="edit_input"  name=EnterPassword value="" size=30 maxlength=16></td>
	   <td>　</td>
	   <td>　</td>
    </tr>
<tr>
      <th>* <%=r.getString(teasession._nLanguage, "EnterPassword")%>:</th>
      <td><input type="password" class="edit_input"  name=EnterPassword value="" size=30 maxlength=16></td>
	   <td>　</td>
	   <td>　</td>
    </tr>
    <tr>
      <th>* <%=r.getString(teasession._nLanguage, "ConfirmPassword")%>:</th>
      <td><input type="password" class="edit_input"  name=ConfirmPassword value="" size=30 maxlength=16></td>
      <td>　</td>
      <td>　</td>
    </tr>
    <tr id=type_0 style="display:none">
      <th>* <%=r.getString(teasession._nLanguage, "EmailAddress")%>:</th>
      <td><input type="TEXT" class="edit_input"  name=Email value="" size=30 maxlength=40></td>
      <td>　</td>
      <td>　</td>
    </tr>
    <tr id=type_1>
      <th>&nbsp;&nbsp;&nbsp;<%=r.getString(teasession._nLanguage, "mobile1")%>:</th>
      <td><input type="TEXT" class="edit_input"  name=PhoneNumber value="以下各项取数据库中的信息" size=30 maxlength=20></td>
      <td>　</td>
      <td>　</td>
    </tr>
    <tr>
      <th>* <%=r.getString(teasession._nLanguage, "Validate")%>:</th>
      <td><input type="TEXT" class="edit_input"  name="vertify" value="" size=30 maxlength=20>
      <th><%=r.getString(teasession._nLanguage, "VerificationCode")%>:
      <td><img src="validate.jsp" alt="Validate">
              <%//=vertify%></td>
    </tr>
    <tr>
      <th>* <%=r.getString(teasession._nLanguage, "LastName")%><%=r.getString(teasession._nLanguage, "FirstName")%>:</th>
      <td><input type="TEXT" class="edit_input"  name=FirstName value="" size=30 maxlength=20></td>
      <th><%=r.getString(teasession._nLanguage, "Gender")%>:</th>
      <td><input id="gender_0" type="radio" name="sex" value="1" checked />
          <label for="gender_0"><%=r.getString(teasession._nLanguage, "Man")%></label>
          <input id="gender_1"   type="radio" name="sex" value="0" />
          <label for="gender_1"><%=r.getString(teasession._nLanguage, "Woman")%></label></td>
    </tr>
    <tr><th nowrap>证件类型:<span class="xinghao">*</span>:</th>
      <td >
               <select name="cardtype">
		 <option value="0" selected="selected">居民身份证</option>
		 <option value="1">护照</option>
		 <option value="2">军官证</option>
		 <option value="3">回乡证</option>
		 <option value="4">台胞证</option>
		</select>
             </td>
	    <th>证件号码:</th>
      <td colspan="2"><input name="card" type="text" value="" size="30"></td>
    </tr>
  </table>
 <a href="applications.jsp?Node=19146"> <img src="/res/huangjin/u/0712/071263876.jpg" alt=""></a>
    <!--input type="button" class="edit_button" id="edit_submit"    value="<%=r.getString(teasession._nLanguage, "Submit")%>"-->
  </FORM>
<SCRIPT type="text/javascript">document.form1.MemberId.focus();</SCRIPT>
<div id="head6"><img height="6" src="about:blank" alt=""></div></div>
<div id="jspafter" style="display:none">
<%=community.getJspAfter(teasession._nLanguage)%>
</div>
<script type="text/javascript">
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
