<%@page contentType="text/html;charset=UTF-8"  %>
<%@include file="/jsp/include/Header.jsp"%>

<%






  String name;


int aerodrome=0;
if(request.getParameter("aerodrome")!=null)
 aerodrome=Integer.parseInt(request.getParameter("aerodrome"));

  if(aerodrome!=0)
  {
    tea.entity.site.Aerodrome flight=tea.entity.site.Aerodrome.find(aerodrome);
    name=flight.getName(teasession._nLanguage);
  }else
  {
    name="";
  }

%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"></head>
<body>
<h1><%=r.getString(teasession._nLanguage, "EditAerodrme")%></h1>
  <div id="head6"><img height="6" src="about:blank"></div>

  <div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%>  </div>

<form name=f1 action="/servlet/EditAerodrome?node=<%=teasession._nNode%>" method="post"    onsubmit="return(submitText(this.name, '<%=r.getString(teasession._nLanguage, "InvalidParamter")%>'))">
<input type="hidden" name="community" value="<%=node.getCommunity()%>"/>
<input type="hidden" name="aerodrome" value="<%=aerodrome%>"/>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">

    <tr>
      <td nowrap><%=r.getString(teasession._nLanguage, "Name")%>:</td>
      <td><input type="text" name="name" value="<%=name%>"></td>
    </tr>

</table>
  <INPUT TYPE=SUBMIT name="GoFinish" ID="edit_GoFinish" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "Submit")%>">
</form>
<script>document.f1.name.focus()</script>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%>  </div>

</body>
</html>

