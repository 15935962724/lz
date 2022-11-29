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
<h1>查询订单</h1>
<div id="head6"><img height="6" src="about:blank"></div>
  <FORM name=form1 METHOD=POST >
  <input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
  <input type="hidden" name="Node" value="<%=teasession._nNode%>"/>
  <input type="hidden" name="Language" value="<%=teasession._nLanguage%>"/>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
       <tr>
      <th nowrap colspan="4">
      查询订单
         </th>

      </tr>
<tr><td>会员id:
  <input type="text" name="from" value="" readonly size="9">
</td>
<!--td>酒店名称:
  <select>
    <option>酒店一</option>
      <option>酒店2</option>
      <option>全部</option>

</select>
</td-->
<td>订单时间： 从:
  <input type="text" name="from" value="" readonly size="9">
  <input onclick="showCalendar('form1.from')" type="button" value="...">
</td>
<td>到:<input readonly name="to"  value="" type="text" size="9"><input onclick="showCalendar('form1.to')" type="button" value="..."></td>

  <td>订单状态:
    <select>
    <option>全部</option>
      <option>已受理</option>
      <option>未受理</option>
       <option>已入住</option>
      <option>未达</option>
</select></td>
  <td><input type="submit" value="GO"></td></tr>


    <tr>
      <th nowrap>订单号</th>
       <td>酒店</td>
      <td>订单时间</td>
      <td>订单状态</td>
       <td>操作</td>
      </tr>

 <tr>
      <th nowrap><a href="订单号">订单号11</a></th>
       <td><a href="酒店节点">酒店1</a></td>
      <td>订单时间1</td>
       <td>未受理</td>
       <td><a href="酒店节点">通知</a></td>
      </tr>

      <tr>
      <th nowrap>订单号2</th>
       <td><a href="酒店节点">酒店1</a></td>
      <td>订单时间2</td>
       <td>已受理</td>
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







</html>
