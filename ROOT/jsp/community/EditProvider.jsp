<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>

<%
r.add("/tea/ui/member/community/Communities");

String s =  request.getParameter("community");
if(!teasession._rv.isWebMaster() && !teasession._rv.isOrganizer(s))
{
  response.sendError(403);
  return;
}
String s1 =  request.getParameter("Member");
boolean flag = s1 == null;
int k = 0;
int i1 = 0;
if(!flag)
{
  tea.entity.site.Provider provider = tea.entity.site.Provider.find(s, s1);
  k = provider.getProviders0();
  i1 = provider.getProviders1();
}

%>



<html>
<head>
<link href="/res/<%=s%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js">
</SCRIPT>
<script>
function selectAll(bool)
{
<%for(int i=0;i<Node.NODE_TYPE.length ;i++){%>
foEdit.<%=Node.NODE_TYPE[i]%>.checked=bool;
<%}%>
}
</script>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "Providers")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<FORM name=foEdit METHOD=POST action="/servlet/EditProvider" onSubmit="return(submitText(this.Members,'<%=r.getString(teasession._nLanguage, "InvalidMemberIds")%>'));">
<input type='hidden' name=community VALUE="<%=s%>">

  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr><td>
<%=r.getString(teasession._nLanguage, "MemberId")%>:
<%
if(!flag)
{%><%=s1%>
	<input type='hidden' name="Members" value=<%=s1%>>
<%
}else
{%><input type="TEXT" class="edit_input"  name=Members ><%
}%>
<tr><tr><td>
<%for(int i=0;i<Node.NODE_TYPE.length ;i++){%>
<span>
	<input  id="CHECKBOX" type="CHECKBOX" name=<%=Node.NODE_TYPE[i]%> value=null <%=getCheck(((i >= 32 ? i1 : k) & 1 << 0 % 32) != 0)%> ><%=r.getString(teasession._nLanguage, Node.NODE_TYPE[i])%>
</span>
<%}%>
</td></tr>
</table>

    <INPUT TYPE=button class="edit_button" onclick="javascript:selectAll(false)" NAME="NotSelectAll" VALUE="<%=r.getString(teasession._nLanguage, "NotSelectAll")%>">
  <INPUT TYPE=button class="edit_button"  onclick="javascript:selectAll(true)" NAME="SelectAll" VALUE="<%=r.getString(teasession._nLanguage, "SelectAll")%>">

<input type="submit" class="edit_button" id="edit_submit"  value="<%=r.getString(teasession._nLanguage, "Submit")%>">
 <%
if(flag)
{%><SCRIPT>document.foEdit.Members.focus();</SCRIPT>
<%}%>
</form>

  <div id="head6"><img height="6" src="about:blank"></div>
  <div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</html>


