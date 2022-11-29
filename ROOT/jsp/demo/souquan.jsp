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
<h1>二级区域</h1>
<div id="head6"><img height="6" src="about:blank"></div>
  <FORM name=form1 METHOD=POST >
  <input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
  <input type="hidden" name="Node" value="<%=teasession._nNode%>"/>
  <input type="hidden" name="Language" value="<%=teasession._nLanguage%>"/>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr><td>市/区名称：
</td>
     <td>
<input type="text" name="from" value="" readonly size="9"><input type="submit" value="添加">
</td>
     </tr>


    <tr>
      <th nowrap colspan="3">
     市/区列表
         </th>
      </tr>
    <tr>
      <th nowrap>名称</th>
       <td>操作</td>
      </tr>
 <tr>
      <th nowrap><a href="用户资料">XXX 区 </a></th>
      <td ></td>
      </tr>
<tr>
      <th nowrap><a href="用户资料">XXX 区 </a></th>
      <td ></td>
      </tr>

  </table>
  </FORM>
<SCRIPT>document.form1.MemberId.focus();</SCRIPT>

<div id="head6"><img height="6" src="about:blank"></div></div>

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
