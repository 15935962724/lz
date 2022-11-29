<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>

<%
            if(!node.isCreator(teasession._rv))
            {
                response.sendError(403);
                return;
            }
            r.add("/tea/ui/node/type/classified/EditClassified");
            Classified classified = Classified.find(teasession._nNode);
%>

<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "Classified")%><%=r.getString(teasession._nLanguage, "Edit")%></h1>
  <div id="head6"><img height="6" src="about:blank"></div>

 <div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div>
		<FORM name=foEdit METHOD=POST action="/servlet/EditClassified">
          <input type='hidden' name=Node VALUE="<%=teasession._nNode%>">
          <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
              <tr><td><%=r.getString(teasession._nLanguage, "Name")%>:</td>
              <td><input type="TEXT" class="edit_input"  name="Name" size="40" MAXLENGTH="255" VALUE="<%=(node.getSubject(teasession._nLanguage))%>"></td>
            </tr>
              <tr><td><%=r.getString(teasession._nLanguage, "Intro")%>:</td>
              <td><textarea name="Text" rows="8" cols="70" class="edit_input"><%=HtmlElement.htmlToText(node.getText(teasession._nLanguage))%></textarea></td>
            </tr>

            <tr><td><%=r.getString(teasession._nLanguage, "Contact")%>:</td>
              <td><input type="TEXT" class="edit_input"  name=Contact VALUE="<%=getNull(classified.getContact(teasession._nLanguage))%>"></td>
            </tr><tr><td><%=r.getString(teasession._nLanguage, "EmailAddress")%>:</td>
              <td><input type="TEXT" class="edit_input"  name=Email VALUE="<%=getNull(classified.getEmail(teasession._nLanguage))%>"></td>
            </tr><tr><td><%=r.getString(teasession._nLanguage, "Organization")%>:</td>
              <td><input type="TEXT" class="edit_input"  name=Organization VALUE="<%=getNull(classified.getOrganization(teasession._nLanguage))%>" SIZE=40 MAXLENGTH=40></td>
            </tr><tr><td><%=r.getString(teasession._nLanguage, "Address")%>:</td>
              <td><TEXTAREA name=Address  class="edit_input" ROWS=2 COLS=60><%=HtmlElement.htmlToText(getNull(classified.getAddress(teasession._nLanguage)))%></TEXTAREA></td>
            </tr><tr><td><%=r.getString(teasession._nLanguage, "City")%>:</td>
              <td><input type="TEXT" class="edit_input"  name=City VALUE="<%=getNull(classified.getCity(teasession._nLanguage))%>" SIZE=20 MAXLENGTH=20></td>
            </tr><tr><td><%=r.getString(teasession._nLanguage, "State")%>:</td>
              <td><input type="TEXT" class="edit_input"  name=State VALUE="<%=getNull(classified.getState(teasession._nLanguage))%>" SIZE=20 MAXLENGTH=20></td>
            </tr><tr><td><%=r.getString(teasession._nLanguage, "Zip")%>:</td>
              <td><input type="TEXT" class="edit_input"  name=Zip VALUE="<%=getNull(classified.getZip(teasession._nLanguage))%>" SIZE=20 MAXLENGTH=20></td>
            </tr><tr><td><%=r.getString(teasession._nLanguage, "Country")%>:</td>
              <td><input type="TEXT" class="edit_input"  name=Country VALUE="<%=getNull(classified.getCountry(teasession._nLanguage))%>" SIZE=20 MAXLENGTH=20></td>
            </tr><tr><td><%=r.getString(teasession._nLanguage, "Telephone")%>:</td>
              <td><input type="TEXT" class="edit_input"  name=Telephone VALUE="<%=getNull(classified.getTelephone(teasession._nLanguage))%>" SIZE=20 MAXLENGTH=20></td>
            </tr><tr><td><%=r.getString(teasession._nLanguage, "Fax")%>:</td>
              <td><input type="TEXT" class="edit_input"  name=Fax VALUE="<%=getNull(classified.getFax(teasession._nLanguage))%>" SIZE=20 MAXLENGTH=20></td>
            </tr><tr><td><%=r.getString(teasession._nLanguage, "WebPage")%>:</td>
              <td><input type="TEXT" class="edit_input"  name=WebPage VALUE="<%=getNull(classified.getWebPage(teasession._nLanguage))%>" SIZE=60 MAXLENGTH=255></td>
            </tr><tr><td><%=r.getString(teasession._nLanguage, "WebLanguage")%>:</td>
              <td><SELECT name=WebLanguage>
                  <OPTION SELECTED VALUE="0"><%=r.getString(teasession._nLanguage, Common.LANGUAGE[0])%></OPTION>
                  <OPTION VALUE="1"><%=r.getString(teasession._nLanguage, Common.LANGUAGE[1])%></OPTION>
                  <OPTION VALUE="2"><%=r.getString(teasession._nLanguage, Common.LANGUAGE[2])%></OPTION>
                  <OPTION VALUE="3"><%=r.getString(teasession._nLanguage, Common.LANGUAGE[3])%></OPTION>
                  <OPTION VALUE="4"><%=r.getString(teasession._nLanguage, Common.LANGUAGE[4])%></OPTION>
                  <OPTION VALUE="5"><%=r.getString(teasession._nLanguage, Common.LANGUAGE[5])%></OPTION>
                  <OPTION VALUE="6"><%=r.getString(teasession._nLanguage, Common.LANGUAGE[6])%></OPTION>
                  <OPTION VALUE="7"><%=r.getString(teasession._nLanguage, Common.LANGUAGE[7])%></OPTION>
                  <OPTION VALUE="8"><%=r.getString(teasession._nLanguage, Common.LANGUAGE[8])%></OPTION>
                  <OPTION VALUE="9"><%=r.getString(teasession._nLanguage, Common.LANGUAGE[9])%></OPTION>
                </SELECT></td>
            </tr></table>
          <P ALIGN=CENTER>
            <input type="submit" name="GoBack" id="edit_GoBack" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "GoBack")%>">
            <input type=SUBMIT name="GoFinish" ID="edit_GoFinish" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "Finish")%>">
          </P>
        </form>
<div id="head6"><img height="6" src="about:blank"></div>
  <div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
<%----%>
</body>
</html>

