<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>

<%
            if(!node.isCreator(teasession._rv))
            {
                response.sendError(403);
                return;
            }
         Page pagec = Page.find(teasession._nNode);
            int i = node.getOptions1();
			%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "PageOLink")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<input type='hidden' name="rmember" VALUE="webmaster">
<input type='hidden' name=vmember VALUE="webmaster">

  <div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div>
  <FORM name=foEdit METHOD=POST action="/servlet/EditPage">
    <input type='hidden' name=Node VALUE="<%=teasession._nNode%>">
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
      <tr>
        <td><%=r.getString(teasession._nLanguage, "Options")%>:</td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name=PageOLink value=null <%=getCheck((i & 1) != 0)%>>
          <%=r.getString(teasession._nLanguage, "PageOLink")%></td>
      </tr>
      <tr>
        <td><%=r.getString(teasession._nLanguage, "RedirectUrl")%>:</td>
        <td><input type="TEXT" class="edit_input"  name=RedirectUrl VALUE="<%=getNull(pagec.getRedirectUrl(teasession._nLanguage))%>"></td>
      </tr>
    </table>
    <input type="submit" name="GoBack" id="edit_GoBack" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "GoBack")%>">
    <input type=SUBMIT name="GoFinish" ID="edit_GoFinish" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "Finish")%>">
  </form>
  <div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>

