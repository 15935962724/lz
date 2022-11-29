<%/**************************供货商地址*****表***************************/%>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr id="TableCaption"><td COLSPAN=10><%=r.getString(teasession._nLanguage, "VendorAddress")%></td></tr>
<%          if(flag2)
            {
                Profile profile = Profile.find(rv._strR);
                String s32 = profile.getEmail();
                String s33 = profile.getFirstName(teasession._nLanguage);
                String s34 = profile.getLastName(teasession._nLanguage);
                String s35 = RequestHelper.makeName(teasession._nLanguage, s33, s34);
                String s36 = profile.getOrganization(teasession._nLanguage);
                String s37 = profile.getAddress(teasession._nLanguage);
                String s38 = profile.getCity(teasession._nLanguage);
                String s39 = profile.getState(teasession._nLanguage);
                String s40 = profile.getZip(teasession._nLanguage);
                String s41 = profile.getCountry(teasession._nLanguage);
                String s43 = profile.getTelephone(teasession._nLanguage);
                String s44 = profile.getFax(teasession._nLanguage); %>

<tr><TD><%=r.getString(teasession._nLanguage, "Vendor")%>:</TD>
    <td COLSPAN=3><%=ts.hrefGlance(rv)%></td></tr>
<tr><TD><%=r.getString(teasession._nLanguage, "EmailAddress")%>:</TD>
    <td COLSPAN=3><A href="/servlet/NewMessage?Receiver=<%=s32%>" TARGET="_blank"><%=s32%></A> </td></tr>
<tr><TD><%=r.getString(teasession._nLanguage, "Name")%>:</TD>
    <td COLSPAN=3><A href="/servlet/NewMessage?Receiver=<%=s35%>" TARGET="_blank"><%=s35%></A> </td></tr>
<tr><TD><%=r.getString(teasession._nLanguage, "Organization") %>:</TD>
    <td COLSPAN=3><%=s36%></td></tr>
<tr><TD><%=r.getString(teasession._nLanguage, "Address")%>:</TD>
    <td COLSPAN=3></td><%=s37%></tr>
<tr><TD><%=r.getString(teasession._nLanguage, "City")%>:</TD>
    <td><%=s38%></td>
    <TD><%=r.getString(teasession._nLanguage, "State")%>:</TD>
    <td><%=s39%></td></tr>
<tr><TD><%=r.getString(teasession._nLanguage, "Zip")%>:</TD>
    <td><%=s40%></td>
    <TD><%=r.getString(teasession._nLanguage, "Country")%>:</TD>
    <td><%=s41%></td></tr>
<tr><TD><%=r.getString(teasession._nLanguage, "Telephone")%>:</TD>
<td><%=s43%></td>
<TD><%=r.getString(teasession._nLanguage, "Fax")%>:</TD>
<td><%=s44%></td></tr><% }%></table>

