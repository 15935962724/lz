<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>

<%
//            if(!node.isCreator(teasession._rv))
//            {
//                response.sendError(403);
//                return;
//            }

tea.ui.TeaSession teasession = new tea.ui.TeaSession(request);
String community = teasession._strCommunity;
r.add("/tea/ui/node/type/classified/EditClassified").add("/tea/resource/Job");
Company classified;
String name;
String text;
int sequence;

if(request.getParameter("NewNode")!=null)
{
  classified = Company.find(0);
  name="";
  text="";
  sequence= Node.getMaxSequence(teasession._nNode) + 10;
} else
{
  classified=Company.find(teasession._nNode);
  name=node.getSubject(teasession._nLanguage);
  sequence=node.getSequence();
  text=HtmlElement.htmlToText(node.getText(teasession._nLanguage));
}

String nexturl=request.getParameter("nexturl");

%>

<html>
<head>
<link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>
<body onload="form1.Name.focus();">
<h1><%=r.getString(teasession._nLanguage, "1167441430421")%></h1>
  <div id="head6"><img height="6" src="about:blank"></div>

    <FORM name=form1 METHOD=POST action="/servlet/EditCompany"  onsubmit="return submitText(this.Name, '<%=r.getString(teasession._nLanguage, "InvalidSubject")%>')">
      <input type='hidden' name=Node VALUE="<%=teasession._nNode%>">
      <%
      if(nexturl!=null)
      out.print("<input type='hidden' name=nexturl value="+nexturl+">");

      if(request.getParameter("NewNode")!=null)
      {
        out.println("<INPUT TYPE=hidden NAME=NewNode VALUE=ON>");
      }
      %>
      <INPUT TYPE="hidden" NAME="TypeAlias" VALUE="<%=request.getParameter("TypeAlias")%>">

        <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
          <tr><TD>* <%=r.getString(teasession._nLanguage, "Name")%>:</TD>
            <td><input type="TEXT" class="edit_input"  name="Name" size="40" MAXLENGTH="255" VALUE="<%=(name)%>"></td>
</tr>
              <tr><TD><%=r.getString(teasession._nLanguage, "Superior")%>:</TD>
                <td colspan="2">
                  <select name="superior">
                    <option value=0 >----------------</option>
                    <%
                    java.util.Enumeration enumer=Node.findByType(21,community);
                    int nodecode;
                    while(enumer.hasMoreElements())
                    {
                      nodecode=((Integer)enumer.nextElement()).intValue();
                      if( nodecode!=teasession._nNode)
                      {
                        out.print("<option ");
                        if(nodecode==classified.getSuperior(teasession._nLanguage))
                        out.print("SELECTED ");
                        out.print("value="+nodecode+">"+Node.find(nodecode).getSubject(teasession._nLanguage));
                      }
                    }
                    %>
                    </select></td>
            </tr>
              <tr><TD><%=r.getString(teasession._nLanguage, "Intro")%>:</TD>
              <td><textarea name="Text" rows="8" cols="70" class="edit_input"><%=text%></textarea></td>
            </tr>

            <tr><TD><%=r.getString(teasession._nLanguage, "Contact")%>:</TD>
              <td><input type="TEXT" class="edit_input"  name=Contact VALUE="<%=getNull(classified.getContact(teasession._nLanguage))%>"></td>
            </tr>
            <tr><TD><%=r.getString(teasession._nLanguage, "EmailAddress")%>:</TD>
              <td><input type="TEXT" class="edit_input"  name=Email VALUE="<%=getNull(classified.getEmail(teasession._nLanguage))%>"></td>
            </tr>
            <%--
            <tr><TD><%=r.getString(teasession._nLanguage, "Organization")%>:</TD>
              <td><input type="TEXT" class="edit_input"  name=Organization VALUE="<%=getNull(classified.getOrganization(teasession._nLanguage))%>" SIZE=40 MAXLENGTH=40></td>
            </tr>
            --%><input type="hidden" value="" name="Organization"/>


            <tr><TD><%=r.getString(teasession._nLanguage, "Address")%>:</TD>
              <td><TEXTAREA name=Address  class="edit_input" ROWS=2 COLS=60><%=HtmlElement.htmlToText(getNull(classified.getAddress(teasession._nLanguage)))%></TEXTAREA></td>
            </tr>
            <%--
            <tr><TD><%=r.getString(teasession._nLanguage, "City")%>:</TD>
              <td><input type="TEXT" class="edit_input"  name=City VALUE="<%=getNull(classified.getCity(teasession._nLanguage))%>" SIZE=20 MAXLENGTH=20></td>
            </tr><tr><TD><%=r.getString(teasession._nLanguage, "State")%>:</TD>
              <td><input type="TEXT" class="edit_input"  name=State VALUE="<%=getNull(classified.getState(teasession._nLanguage))%>" SIZE=20 MAXLENGTH=20></td>
            </tr>
            --%><input type="hidden" value="0" name="City"/>
            <input type="hidden" value="" name="State"/>



            <tr><TD><%=r.getString(teasession._nLanguage, "Zip")%>:</TD>
              <td><input type="TEXT" class="edit_input"  name=Zip VALUE="<%=getNull(classified.getZip(teasession._nLanguage))%>" SIZE=20 MAXLENGTH=20></td>
            </tr>
            <%--
            <tr><TD><%=r.getString(teasession._nLanguage, "Country")%>:</TD>
              <td><input type="TEXT" class="edit_input"  name=Country VALUE="<%=getNull(classified.getCountry(teasession._nLanguage))%>" SIZE=20 MAXLENGTH=20></td>
            </tr>
            --%><input type="hidden" value="" name="Country"/>

            <tr><TD><%=r.getString(teasession._nLanguage, "Telephone")%>:</TD>
              <td><input type="TEXT" class="edit_input"  name=Telephone VALUE="<%=getNull(classified.getTelephone(teasession._nLanguage))%>" SIZE=20 MAXLENGTH=20></td>
            </tr>
            <%--
            <tr><TD><%=r.getString(teasession._nLanguage, "Fax")%>:</TD>
              <td><input type="TEXT" class="edit_input"  name=Fax VALUE="<%=getNull(classified.getFax(teasession._nLanguage))%>" SIZE=20 MAXLENGTH=20></td>
            </tr>
            --%><input type=hidden name="Fax" value="">
            <tr><TD><%=r.getString(teasession._nLanguage, "WebPage")%>:</TD>
              <td><input type="TEXT" class="edit_input"  name=WebPage VALUE="<%=getNull(classified.getWebPage(teasession._nLanguage))%>" SIZE=60 MAXLENGTH=255></td>
            </tr>
            <%--
            <tr><TD><%=r.getString(teasession._nLanguage, "WebLanguage")%>:</TD>
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
            </tr>--%><input type=hidden name="WebLanguage" value="1">
                <tr><TD><%=r.getString(teasession._nLanguage, "Sequence")%>:</TD>
              <td><input type="TEXT" class="edit_input"  name=sequence  VALUE="<%=sequence%>" ></td>
            </tr>

        </table>
          <P ALIGN=CENTER>
            <input type=SUBMIT name="GoFinish" ID="edit_GoFinish" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "CBSubmit")%>">
            <input type="button" value="<%=r.getString(teasession._nLanguage, "CBBack")%>" onclick="window.open('<%=nexturl%>','_self');">
          </P>
        </form>

        <div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
