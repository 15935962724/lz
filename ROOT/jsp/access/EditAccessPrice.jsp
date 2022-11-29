<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>
<%
r.add("/tea/ui/node/access/EditAccessPrice");
if(!node.isCreator(teasession._rv))
{
  response.sendError(403);
  return;
}
String s =  request.getParameter("Currency");
boolean flag = s == null;
int j = 1;
BigDecimal bigdecimal1 = new BigDecimal(0.0D);
if(!flag)
{
  j = Integer.parseInt(s);
  bigdecimal1 = AccessPrice.find(teasession._nNode, j).getPrice();
}

%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js">
</SCRIPT>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "CBAccessPrices")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<input type='hidden' name="rmember" VALUE="webmaster">
<input type='hidden' name=vmember VALUE="webmaster">
<div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div>

  <FORM name=foEdit METHOD=POST action="/servlet/EditAccessPrice" onSubmit="return(submitFloat(this.Price,'<%=r.getString(teasession._nLanguage, "InvalidPrice")%>')&&(this.submit.disabled=true) );">
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <input type='hidden' name=Node VALUE="<%=teasession._nNode%>">
    <%
 if(flag)
 out.print("<input type='hidden' name=New VALUE=ON >");
%>

<%=new tea.htmlx.CurrencySelection(teasession._nLanguage, j, !flag)%>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Price")%>:</td>
      <td><input type="TEXT" class="edit_input"  name="Price" VALUE="<%=bigdecimal1%>" SIZE=4></td>
    </tr>
    <tr>
      <td></td>
      <td><input type="submit" name="submit" class="edit_button" id="edit_submit"  value="<%=r.getString(teasession._nLanguage, "Submit")%>">
        <SCRIPT>document.foEdit.Price.focus();</SCRIPT></td>
    </tr>
</table>
  </FORM>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</html>



