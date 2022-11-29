<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>
<%
r.add("/tea/ui/member/profile/EditAddress");r.add("/tea/ui/util/SignUp1");
if(!teasession._rv.isReal())
            {
                 response.sendError(403);
                return;
            }
            tea.entity.member.Profile profile;
            String memeber;
            if(teasession.getParameter("Member")!=null)
            memeber=teasession.getParameter("Member");
            else
            memeber=teasession._rv._strR;
            profile = tea.entity.member.Profile.find(memeber);
%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "CBEditAll")%></h1>
  <div id="head6"><img height="6" src="about:blank"></div>
<input type='hidden' name="rmember" VALUE="webmaster">
<input type='hidden' name=vmember VALUE="webmaster">

  <FORM name=foEdit METHOD=POST action="/servlet/EditAddress" onSubmit="return(submitText(this.FirstName,'<%=r.getString(teasession._nLanguage, "InvalidLastName")%>')&&submitEmail(this.Email,'<%=r.getString(teasession._nLanguage, "InvalidEmailAddress")%>'));">
    <%
String nexturl=request.getParameter("nexturl");
if(nexturl!=null&&!nexturl.equals("null"))
out.println("<input type=hidden name=nexturl value="+nexturl+" />");
%>
<input type="hidden" name="community" value="<%=node.getCommunity()%>"/>
    <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
      <tr>
        <TD><%=getNull(r.getString(teasession._nLanguage, "MemberId"))%>:</TD>
        <td><%=memeber%></td>
        <TD><%=getNull(r.getString(teasession._nLanguage, "EmailAddress"))%>:</TD>
        <td><input type="TEXT" class="edit_input"  name=Email VALUE="<%=profile.getEmail()%>" SIZE=40 MAXLENGTH=40></td>
      </tr>
      <tr>
        <TD><%=r.getString(teasession._nLanguage, "FirstName")%>:</TD>
        <td><input type="TEXT" class="edit_input"  name=FirstName VALUE="<%=profile.getFirstName(teasession._nLanguage)%>" SIZE=20 MAXLENGTH=20></td>
        <TD><%=r.getString(teasession._nLanguage, "LastName")%>:</TD>
        <td><input type="TEXT" class="edit_input"  name=LastName value="<%=profile.getLastName(teasession._nLanguage)%>" size=20 maxlength=20></td>
      </tr>
      <tr>
        <TD><%=r.getString(teasession._nLanguage, "Organization")%>:</TD>
        <td COLSPAN=3><input type="TEXT" class="edit_input"  name=Organization VALUE="<%=getNull(profile.getOrganization(teasession._nLanguage))%>" SIZE=40 MAXLENGTH=40></td>
      </tr>
      <tr>
        <TD><%=r.getString(teasession._nLanguage, "Address")%>:</TD>
        <td COLSPAN=3><TEXTAREA name="Address" class="edit_input" ROWS="2" COLS="60"><%=getNull(profile.getAddress(teasession._nLanguage))%></TEXTAREA></td>
      </tr>
      <tr>
        <TD><%=r.getString(teasession._nLanguage, "Handset")%>:</TD>
        <td COLSPAN=3><input type="TEXT" class="edit_input"  name=Mobile VALUE="<%=getNull(profile.getMobile())%>" SIZE=40 MAXLENGTH=40></td>
      </tr>
      <tr>
        <TD><%=r.getString(teasession._nLanguage, "City")%>:</TD>
        <td><input type="TEXT" class="edit_input"  name=City VALUE="<%=getNull(profile.getCity(teasession._nLanguage))%>" SIZE=20 MAXLENGTH=20></td>
        <TD><%=r.getString(teasession._nLanguage, "State")%>:</TD>
        <td><input type="TEXT" class="edit_input"  name=State VALUE="<%=getNull(profile.getState(teasession._nLanguage))%>" SIZE=20 MAXLENGTH=20></td>
      </tr>
      <tr>
        <TD><%=r.getString(teasession._nLanguage, "Zip")%>:</TD>
        <td><input type="TEXT" class="edit_input"  name=Zip VALUE="<%=getNull(profile.getZip(teasession._nLanguage))%>" SIZE=20 MAXLENGTH=20></td>
        <TD><%=r.getString(teasession._nLanguage, "Country")%>:</TD>
        <td><input type="TEXT" class="edit_input"  name=Country VALUE="<%=getNull(profile.getCountry(teasession._nLanguage))%>" SIZE=20 MAXLENGTH=20></td>
      </tr>
      <tr>
        <TD><%=r.getString(teasession._nLanguage, "Telephone")%>:</TD>
        <td><input type="TEXT" class="edit_input"  name=Telephone VALUE="<%=getNull(profile.getTelephone(teasession._nLanguage))%>" SIZE=20 MAXLENGTH=20></td>
        <TD><%=r.getString(teasession._nLanguage, "Fax") %>:</TD>
        <td><input type="TEXT" class="edit_input"  name=Fax VALUE="<%=getNull(profile.getFax(teasession._nLanguage))%>" SIZE=20 MAXLENGTH=20></td>
      </tr>
      <tr>
        <!--TD><%=r.getString(teasession._nLanguage, "Age") %>:</TD>
        <td COLSPAN=3>
<SELECT name=Age>
<OPTION SELECTED VALUE="0">N/A</OPTION>
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
<OPTION VALUE="14">60-</OPTION></SELECT></td-->
        <TD><%=r.getString(teasession._nLanguage, "Birth")%>:</TD>
        <td><%
java.util.Date birth=        profile.getBirth();

		  java.util.Calendar c= java.util.Calendar.getInstance();
	c.set(java.util.Calendar.YEAR,c.get(java.util.Calendar.YEAR)-30);

	out.print(new tea.htmlx.TimeSelection("Birth", birth).toString());%></td>
      </tr>
      <tr>
        <TD><%=r.getString(teasession._nLanguage, "WebPage")%>:</TD>
        <td COLSPAN=3><input type="TEXT" class="edit_input"  name=WebPage VALUE="" SIZE=60 MAXLENGTH=255></td>
      </tr>
    </table>
    <input type="hidden" name=AddressTPublic value=1 <%=getCheck((profile.getType() & 1) != 0)%>>
    <!--<%=r.getString(teasession._nLanguage, "AddressTPublic")%>-->
    <input type="submit" class="edit_button" id="edit_submit"  value="<%=r.getString(teasession._nLanguage, "Submit")%>" >
  </FORM>
  <SCRIPT>document.foEdit.Email.focus();</SCRIPT>
<div id="head6"><img height="6" src="about:blank"></div>
  <div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
<%----%>
</body>
</html>

