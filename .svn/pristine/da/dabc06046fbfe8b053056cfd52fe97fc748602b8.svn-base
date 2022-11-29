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
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js?fff" type="text/javascript"></SCRIPT>

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
  if(form1.type.value=="0")
  {
    if(form1.regmail&&form1.regmail[1].checked)
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
  if(form1.type.value=="1")
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
  <FORM name=form1 METHOD=POST ACTION="EditUser.jsp" onSubmit="return submitCheck(this);">
  <input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
  <input type="hidden" name="node" value="<%=teasession._nNode%>"/>
  <input type="hidden" name="Language" value="<%=teasession._nLanguage%>"/>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <th nowrap>*
        <select name="type" onChange="f(this);">
            <option value=0 ><%=r.getString(teasession._nLanguage, "EmailAddress")%>
            <option value=1 ><%=r.getString(teasession._nLanguage, "mobile1")%>
              </select>
          <!-- %=r.getString(teasession._nLanguage, "MemberId")%-->
        :</th>
      <td ><input type="TEXT" class="edit_input"  name=MemberId value="" size=30 maxlength=40><span id="domain"></span></td>
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
      <th>* <%=r.getString(teasession._nLanguage, "EnterPassword")%>:</th>
      <td><input type="password" class="edit_input"  name=EnterPassword value="" size=30 maxlength=16></td>
	   <td></td>
	   <td></td>
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
      <td><input type="TEXT" class="edit_input"  name=PhoneNumber value="" size=30 maxlength=20></td>
      <td>　</td>
      <td>　</td>
    </tr>
    <tr>
      <th>* <%=r.getString(teasession._nLanguage, "Validate")%>:</th>
      <td><input type="TEXT" class="edit_input"  name=vertify value="" size=30 maxlength=20>
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
    <tr>
      <th><%=r.getString(teasession._nLanguage, "IdentityCard")%>:</th>
      <td><input name="card" type="text" value="" size="30"></td>
      <th nowrap><%=r.getString(teasession._nLanguage, "Birth")%>:</th>
      <td><%
		  java.util.Calendar c= java.util.Calendar.getInstance();
	c.set(java.util.Calendar.YEAR,c.get(java.util.Calendar.YEAR)-30);
	out.print(new tea.htmlx.TimeSelection("Birth", c.getTime()).toString());%></td>
    </tr>
    <tr>
      <th>* <%=r.getString(teasession._nLanguage, "State")%><%=r.getString(teasession._nLanguage, "City")%>:</th>
      <td><!--input type="TEXT" class="edit_input"  name=State VALUE="" SIZE=20 MAXLENGTH=20-->
          <select id="State" name="State">
            <option value="">--------------</option>
            <%
                for(int i=0;i<Common.PROVINCE.length;i++)
                {
                  out.print("<option value="+Common.PROVINCE[i]+" >"+r.getString(teasession._nLanguage,"Province."+Common.PROVINCE[i]));
                }
                %>
          </select>
          <input  name="City" class="edit_input" size="12"></td>
      <th><%=r.getString(teasession._nLanguage, "Address")%>:</th>
      <td><textarea name=Address class="edit_input"  rows=2 cols=27></textarea></td>
    </tr>
    <tr>
      <th><%=r.getString(teasession._nLanguage, "Organization")%>:</th>
      <td ><input type="TEXT" class="edit_input"  name=Organization value="" size=30 maxlength=40></td>
      <th><%=r.getString(teasession._nLanguage, "Zip")%>:</th>
      <td><input type="TEXT" class="edit_input"  name=Zip value="" size=30 maxlength=20></td>
    </tr>
    <tr>
      <th><%=r.getString(teasession._nLanguage, "Telephone")%>:</th>
      <td><input type="TEXT" class="edit_input"  name=Telephone1 value="" size=5 maxlength=5>
        -
        <input type="TEXT" class="edit_input"  name=Telephone2 value="" size=15 maxlength=13></td>
      <th><%=r.getString(teasession._nLanguage, "Fax")%>:</th>
      <td><input type="TEXT" class="edit_input"  name=Fax value="" size=30 maxlength=20></td>
    </tr>
    <tr>
      <!--TD><%=r.getString(teasession._nLanguage, "Age")%>:</TD>
        <td> <SELECT name=Age>
            <OPTION VALUE="0">N/A</OPTION>
            <OPTION VALUE="1">0-6</OPTION>
            <OPTION VALUE="2">7-12</OPTION>
            <OPTION VALUE="3">13-15</OPTION>
            <OPTION VALUE="4">16-18</OPTION>
            <OPTION VALUE="5">19-22</OPTION>
            <OPTION VALUE="6">23-25</OPTION>
            <OPTION VALUE="7">26-28</OPTION>
            <OPTION VALUE="8">29-35</OPTION>
            <OPTION VALUE="9">36-40</OPTION>
            <OPTION VALUE="10">41-45</OPTION>
            <OPTION VALUE="11">46-50</OPTION>
            <OPTION VALUE="12">51-55</OPTION>
            <OPTION VALUE="13">56-60</OPTION>
            <OPTION VALUE="14">60-</OPTION>
          </SELECT> </td-->
      <th><%=r.getString(teasession._nLanguage, "Country")%>:</th>
      <td><%=new CountrySelection("Country",teasession._nLanguage)%></td>
      <th><%=r.getString(teasession._nLanguage, "WebPage")%>:</th>
      <td><input type="TEXT" class="edit_input"  name=WebPage value="" size="30" maxlength="255"></td>
    </tr>
    <tr id="visage">
      <th><%=r.getString(teasession._nLanguage, "Party")%>:</th>
      <td><%
        tea.html.DropDown select=new tea.html.DropDown("polity",0);
        for(int index=0;index<Profile.POLITY_TYPE.length;index++)
        {
          select.addOption(index,r.getString(teasession._nLanguage,Profile.POLITY_TYPE[index]));
        }
        out.print(select.toString());
        %></td>
    </tr>
  </table>
  <input  id="CHECKBOX" type="CHECKBOX" name=AddressTPublic value=null>
    <%=r.getString(teasession._nLanguage, "AddressTPublic")%>
    <input type="submit" class="edit_button" id="edit_submit"   value="<%=r.getString(teasession._nLanguage, "Submit")%>">
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







<%----****************\u00B2\u00BB\u00D2\u00AA\u00B2á\u00B3\u00FD\u00D2\u00D4\u00CF\u00C2\u00B4ú\u00C2\u00EB(\u00D2\u00D4\u00C7°\u00CA\u00B9\u00D3\u00C3SMS×\u00A2\u00B2á\u00B5\u00C4\u00B7\u00BD\u00CA\u00BD)******************************************



<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.htmlx.Languages"%>
<%@ page import="tea.ui.TeaSession"%>
<%@ page import = "tea.resource.Resource" %>
<jsp:useBean id="sms" scope="page" class="tea.entity.node.Sms" />
<%TeaSession teasession = new TeaSession(request);
Resource r = new Resource("/tea/ui/util/SignUp1");
String vertify=sms.password();
HttpSession session = request.getSession(true);
session.setAttribute("sms.vertify" ,vertify);
 String s2 = request.getParameter("Node");
	%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>
<DIV ID="edit_BodyDiv"> <%=r.getString(teasession._nLanguage, "InfSignUp")%>
  <FORM name=form1 METHOD=POST ACTION="EditUser.jsp?node=<%=s2%>" onSubmit="return(submitIdentifier(this.MemberId,'<%=r.getString(teasession._nLanguage, "InvalidMemberId")%>')&&submitIdentifier(this.Password,'<%=r.getString(teasession._nLanguage, "InvalidPassword")%>')&&submitEqual(this.Confirm,this.Password,'InvalidConfirm')&&submitText(this.FirstName,'<%=r.getString(teasession._nLanguage, "InvalidFirstName")%>')&&submitText(this.LastName, '<%=r.getString(teasession._nLanguage, "InvalidLastName")%>')&&submitEmail(this.Email,'<%=r.getString(teasession._nLanguage, "InvalidEmailAddress")%>'));">
    <input type='hidden' name=NextUrl VALUE="EditUser.jsp">
    <table class="section" cellspacing="0">
      <tr>
        <TD>*<%=r.getString(teasession._nLanguage, "MemberId")%>:</TD>
        <td><input type="TEXT" class="edit_input"  name=MemberId VALUE="" SIZE=20 MAXLENGTH=20></td>
        <TD>*<%=r.getString(teasession._nLanguage, "EmailAddress")%>:</TD>
        <td><input type="TEXT" class="edit_input"  name=Email VALUE="" SIZE=40 MAXLENGTH=40></td>
      </tr>
      <tr>
        <TD>*<%=r.getString(teasession._nLanguage, "mobile1")%>:</TD>
        <td><input type="TEXT" class="edit_input"  name=PhoneNumber VALUE="" SIZE=20 MAXLENGTH=20></td>
      </tr>
      <tr>
        <TD>*<%=r.getString(teasession._nLanguage, "Validate")%>:</TD>
        <td><input type="TEXT" class="edit_input"  name=vertify VALUE="" SIZE=20 MAXLENGTH=20></td>
        <TD>*<%=r.getString(teasession._nLanguage, "VerificationCode")%>:</TD>
        <td> <%=vertify%></td>
      </tr>
      <tr>
        <TD>*<%=r.getString(teasession._nLanguage, "FirstName")%>:</TD>
        <td><input type="TEXT" class="edit_input"  name=FirstName VALUE="" SIZE=20 MAXLENGTH=20></td>
        <TD>*<%=r.getString(teasession._nLanguage, "LastName")%>:</TD>
        <td><input type="TEXT" class="edit_input"  name=LastName VALUE="" SIZE=20 MAXLENGTH=20></td>
      </tr>
      <tr>
        <TD><%=r.getString(teasession._nLanguage, "Organization")%>:</TD>
        <td COLSPAN=3><input type="TEXT" class="edit_input"  name=Organization VALUE="" SIZE=40 MAXLENGTH=40></td>
      </tr>
      <tr>
        <TD><%=r.getString(teasession._nLanguage, "Address")%>:</TD>
        <td COLSPAN=3><TEXTAREA name=Address ROWS=2 COLS=60></TEXTAREA></td>
      </tr>
      <tr>
        <TD><%=r.getString(teasession._nLanguage, "City")%>:</TD>
        <td><input type="TEXT" class="edit_input"  name=City VALUE="" SIZE=20 MAXLENGTH=20></td>
        <TD><%=r.getString(teasession._nLanguage, "State")%>:</TD>
        <td><input type="TEXT" class="edit_input"  name=State VALUE="" SIZE=20 MAXLENGTH=20></td>
      </tr>
      <tr>
        <TD><%=r.getString(teasession._nLanguage, "Zip")%>:</TD>
        <td><input type="TEXT" class="edit_input"  name=Zip VALUE="" SIZE=20 MAXLENGTH=20></td>
        <TD><%=r.getString(teasession._nLanguage, "Country")%>:</TD>
        <td><input type="TEXT" class="edit_input"  name=Country VALUE="" SIZE=20 MAXLENGTH=20></td>
      </tr>
      <tr>
        <TD><%=r.getString(teasession._nLanguage, "Telephone")%>:</TD>
        <td><input type="TEXT" class="edit_input"  name=Telephone VALUE="" SIZE=20 MAXLENGTH=20></td>
        <TD><%=r.getString(teasession._nLanguage, "Fax")%>:</TD>
        <td><input type="TEXT" class="edit_input"  name=Fax VALUE="" SIZE=20 MAXLENGTH=20></td>
      </tr>
      <tr>
        <TD><%=r.getString(teasession._nLanguage, "Age")%>:</TD>
        <td> <SELECT name=Age>
            <OPTION VALUE="0">N/A</OPTION>
            <OPTION VALUE="1">0-6</OPTION>
            <OPTION VALUE="2">7-12</OPTION>
            <OPTION VALUE="3">13-15</OPTION>
            <OPTION VALUE="4">16-18</OPTION>
            <OPTION VALUE="5">19-22</OPTION>
            <OPTION VALUE="6">23-25</OPTION>
            <OPTION VALUE="7">26-28</OPTION>
            <OPTION VALUE="8">29-35</OPTION>
            <OPTION VALUE="9">36-40</OPTION>
            <OPTION VALUE="10">41-45</OPTION>
            <OPTION VALUE="11">46-50</OPTION>
            <OPTION VALUE="12">51-55</OPTION>
            <OPTION VALUE="13">56-60</OPTION>
            <OPTION VALUE="14">60-</OPTION>
          </SELECT> </td>
        <TD><%=r.getString(teasession._nLanguage, "WebPage")%>:</TD>
        <td><input type="TEXT" class="edit_input"  name=WebPage VALUE="" size="40" MAXLENGTH="255"></td>
      </tr>
    </table>
    <input  id="CHECKBOX" type="CHECKBOX" name=AddressTPublic value=null>
    <%=r.getString(teasession._nLanguage, "AddressTPublic")%>
    <input type="submit" class="edit_button" id="edit_submit"  value="<%=r.getString(teasession._nLanguage, "Submit")%>">
  </FORM>
  <SCRIPT>document.form1.MemberId.focus();</SCRIPT>
  <div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</DIV><FONT ID=FooterDiv>
</html>

--%>


