<%@page contentType="text/html;charset=UTF-8" %><%@ page import="java.util.*" %><%@ page import="java.math.*" %><%@ page import="tea.entity.member.*" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.*" %><%@ page import="tea.entity.node.*" %><%@ page import="tea.ui.TeaSession" %><% request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
  return;
}
if(!teasession._rv.isReal())
{
  response.sendError(403);
  return;
}

Resource r=new Resource("/tea/ui/member/profile/EditAddress").add("/tea/ui/util/SignUp1");

String memeber;
if(teasession.getParameter("Member")!=null)
memeber=teasession.getParameter("Member");
else
memeber=teasession._rv._strR;

Profile profile = Profile.find(memeber);

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">

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
</script>
</head>
<body id=bodynone>
<h1><%=r.getString(teasession._nLanguage, "CBEditAddress")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<FORM name=foEdit METHOD=POST action="/servlet/EditAddress" onSubmit="return(submitText(this.FirstName,'<%=r.getString(teasession._nLanguage, "InvalidFirstName")%>')&&submitEmail(this.Email,'<%=r.getString(teasession._nLanguage, "InvalidEmailAddress")%>')&&submitSelect(this.State,'<%=r.getString(teasession._nLanguage, "InvalidParameter")%>'));">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<%
String nexturl=request.getParameter("nexturl");
if(nexturl!=null&&!nexturl.equals("null"))
out.println("<input type=hidden name=nexturl value="+nexturl+" />");
%>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <TD><%=(r.getString(teasession._nLanguage, "MemberId"))%>:</TD>
    <td><%=memeber%></td>
    <TD nowrap="nowrap"><%=(r.getString(teasession._nLanguage, "EmailAddress"))%>:</TD>
    <td nowrap="nowrap"><input type="TEXT" class="edit_input"  name=Email VALUE="<%=profile.getEmail()%>" SIZE=30 MAXLENGTH=40></td>
  </tr>
  <tr>
    <TD><%=r.getString(teasession._nLanguage, "FirstName")%>:</TD>
    <td><input type="TEXT" class="edit_input"  name=FirstName VALUE="<%=profile.getFirstName(teasession._nLanguage)%>" SIZE=20 MAXLENGTH=20></td>
      <TD><%=r.getString(teasession._nLanguage, "LastName")%>:</TD>
      <td><input type="TEXT" class="edit_input"  name=LastName VALUE="<%=profile.getLastName(teasession._nLanguage)%>" SIZE=20 MAXLENGTH=20></td>
  </tr>
  <tr>
    <TD><%=r.getString(teasession._nLanguage, "Organization")%>:</TD>
    <td COLSPAN=3><input type="TEXT" class="edit_input"  name=Organization VALUE="<%=(profile.getOrganization(teasession._nLanguage))%>" SIZE=40 MAXLENGTH=40></td>
  </tr>
  <tr>
    <TD><%=r.getString(teasession._nLanguage, "Address")%>:</TD>
    <td COLSPAN=3><TEXTAREA name="Address" class="edit_input" ROWS="2" COLS="60"><%=(profile.getAddress(teasession._nLanguage))%></TEXTAREA></td>
  </tr>
  <tr>
    <TD><%=r.getString(teasession._nLanguage, "Handset")%>:</TD>
    <td COLSPAN=3><input type="TEXT" class="edit_input"  name=Mobile readonly VALUE="<%=(profile.getMobile())%>" SIZE=40 MAXLENGTH=40>
<!--      &nbsp;<a href ="/jsp/sms/EditSMSProfile.jsp?node=<%=teasession._nNode%>"><%=r.getString(teasession._nLanguage, "RejiggerHandset")%></a>&nbsp;<a href ="/jsp/user/ChangePassword.jsp"><%=r.getString(teasession._nLanguage, "RejiggerPassword")%></a> --></td>
  </tr>
  <tr>
    <TD><%=r.getString(teasession._nLanguage, "State")%>:</TD>
    <td><!--input type="TEXT" class="edit_input"  name=State VALUE="<%=(profile.getState(teasession._nLanguage))%>" SIZE=20 MAXLENGTH=20-->
      <select id="State" name="State">
        <option value="">--------------</option>
        <%
        for(int i=0;i<Common.PROVINCE.length;i++)
        {
          out.print("<option value="+Common.PROVINCE[i]);
          if(Common.PROVINCE[i].equals(profile.getState(teasession._nLanguage)))
          {
            out.print(" SELECTED ");
          }
          out.print(" >"+r.getString(teasession._nLanguage,"Province."+Common.PROVINCE[i]));
        }
        %>
        </select>
    </td>
    <TD><%=r.getString(teasession._nLanguage, "City")%>:</TD>
    <td><input type="TEXT" class="edit_input"  name=City VALUE="<%=(profile.getCity(teasession._nLanguage))%>" SIZE=20 MAXLENGTH=20></td>
  </tr>
  <tr>
    <TD><%=r.getString(teasession._nLanguage, "Zip")%>:</TD>
    <td><input type="TEXT" class="edit_input"  name=Zip VALUE="<%=(profile.getZip(teasession._nLanguage))%>" SIZE=20 MAXLENGTH=20></td>
      <TD><%=r.getString(teasession._nLanguage, "Country")%>:</TD>
      <td><%=new tea.htmlx.CountrySelection("Country",teasession._nLanguage,profile.getCountry(teasession._nLanguage))%></td>
  </tr>
  <tr>
    <TD><%=r.getString(teasession._nLanguage, "Telephone")%>:</TD>
    <td><input type="TEXT" class="edit_input"  name=Telephone VALUE="<%=(profile.getTelephone(teasession._nLanguage))%>" SIZE=20 MAXLENGTH=20></td>
      <TD><%=r.getString(teasession._nLanguage, "Fax") %>:</TD>
      <td><input type="TEXT" class="edit_input"  name=Fax VALUE="<%=(profile.getFax(teasession._nLanguage))%>" SIZE=20 MAXLENGTH=20></td>
  </tr>
  <tr>
    <TD nowrap="nowrap"><%=r.getString(teasession._nLanguage, "Birth")%>:</TD>
    <td COLSPAN=3><%=new tea.htmlx.TimeSelection("Birth", profile.getBirth())%></td>
    </tr>
      <tr>
        <TD><%=r.getString(teasession._nLanguage, "WebPage")%>:</TD>
        <td COLSPAN=3><input type="TEXT" class="edit_input"  name=WebPage VALUE="<%=profile.getWebPage(teasession._nLanguage)%>" SIZE=60 MAXLENGTH=255></td>
      </tr>
</table>
<input  id="CHECKBOX" type="CHECKBOX" name=AddressTPublic value=null <%if((profile.getType() & 1) != 0)out.print(" CHECKED ");%>><%=r.getString(teasession._nLanguage, "AddressTPublic")%>
<input type="submit" class="edit_button" id="edit_submit"  value="<%=r.getString(teasession._nLanguage, "Submit")%>">
</FORM>

<SCRIPT>document.foEdit.Email.focus();</SCRIPT>
</body>
</html>
