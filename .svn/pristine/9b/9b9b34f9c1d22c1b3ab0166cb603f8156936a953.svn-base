<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>
<%
//tea.ui.TeaSession teasession=new tea.ui.TeaSession(request);
int replay=Integer.parseInt(request.getParameter("replay"));
tea.entity.node.BBSReply reply_obj = tea.entity.node.BBSReply.find(replay);



%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js">
</SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body> 
<h1><%=r.getString(teasession._nLanguage, "CBSetVisible")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<FORM name=foSet METHOD=POST action="/servlet/EditBBSReply"> 
  <%
String nexturl=request.getParameter("nexturl");
  if(nexturl!=null)
  out.println("<input type='hidden' name=nexturl VALUE="+nexturl+">");
%> 
  <legend><%=r.getString(teasession._nLanguage, "CBSetVisible")%></legend> 
  <input type='hidden' name=Node VALUE="<%=teasession._nNode%>"> 
  <input type='hidden' name=replay VALUE="<%=replay%>"> 
  <input  id="CHECKBOX" type="CHECKBOX" name=hidden value=null <%=getCheck(reply_obj.isHidden())%>> 
  <%=r.getString(teasession._nLanguage, "NodeOHidden")%> 
  <input type="submit" class="edit_button" name="visible" id="edit_submit"  value="<%=r.getString(teasession._nLanguage, "Submit")%>"> 
</FORM> 
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</html>

