<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>
<%
String community=request.getParameter("community");
if(community==null)
{
  community=node.getCommunity();
}

tea.entity.site.Frame obj=tea.entity.site.Frame.find(community);
if(request.getMethod().equals("POST"))
{
  if(request.getParameter("delete")!=null)
  {
    obj.delete();
  }else
  {
    String beforeheader=request.getParameter("beforeheader");
    String afterheader =request.getParameter("afterheader");
    String beforebody1 =request.getParameter("beforebody1");
    String afterbody1  =request.getParameter("afterbody1");
    String beforebody2 =request.getParameter("beforebody2");
    String afterbody2  =request.getParameter("afterbody2");
    String beforebody3 =request.getParameter("beforebody3");
    String afterbody3  =request.getParameter("afterbody3");
    String beforefooter=request.getParameter("beforefooter");
    String afterfooter =request.getParameter("afterfooter");
    obj.set(beforeheader,afterheader ,beforebody1 ,afterbody1  ,beforebody2 ,afterbody2  ,beforebody3 ,afterbody3  ,beforefooter,afterfooter );
  }
  response.sendRedirect("/jsp/info/Succeed.jsp?nexturl="+java.net.URLEncoder.encode(request.getRequestURI(),"UTF-8"));
  return;
}
r.add("/tea/ui/member/community/EditCommunity");
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>

<body>
     <h1><%=r.getString(teasession._nLanguage, "CBEditCommunity")%></h1>
   <div id="head6"><img height="6" src="about:blank"></div>
<form name="form1" method="post" action="<%=request.getRequestURI()%>?node=<%=teasession._nNode%>">
<input type="hidden" name="community" value="<%=community%>"/>
 <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td><%=r.getString(teasession._nLanguage, "BeforeHeader")%></td>
    <td><textarea name="beforeheader" cols="60" rows="3" id="beforeheader"><%=HtmlElement.htmlToText(obj.getBeforeheader())%></textarea></td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "AfterHeader")%></td>
    <td><textarea name="afterheader" cols="60" rows="3"  id="afterheader"><%=HtmlElement.htmlToText(obj.getAfterheader())%></textarea></td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "BeforeBody1")%></td>
    <td><textarea name="beforebody1" cols="60" rows="3"  id="beforebody1" ><%=HtmlElement.htmlToText(obj.getBeforebody1())%></textarea></td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "AfterBody1")%></td>
    <td><textarea name="afterbody1" cols="60" rows="3" id="afterbody1" ><%=HtmlElement.htmlToText(obj.getAfterbody1())%></textarea></td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "BeforeBody3")%></td>
    <td><textarea name="beforebody3" cols="60" rows="3" id="beforebody3" ><%=HtmlElement.htmlToText(obj.getBeforebody3())%></textarea></td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "AfterBody3")%></td>
    <td><textarea name="afterbody3" cols="60" rows="3" id="afterbody3" ><%=HtmlElement.htmlToText(obj.getAfterbody3())%></textarea></td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "BeforeBody2")%></td>
    <td><textarea name="beforebody2" cols="60" rows="3" id="beforebody2" ><%=HtmlElement.htmlToText(obj.getBeforebody2())%></textarea></td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "AfterBody2")%></td>
    <td><textarea name="afterbody2" cols="60" rows="3" id="afterbody2" ><%=HtmlElement.htmlToText(obj.getAfterbody2())%></textarea></td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "BeforeFooter")%></td>
    <td><textarea name="beforefooter" cols="60" rows="3" id="beforefooter" ><%=HtmlElement.htmlToText(obj.getBeforefooter())%></textarea></td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "AfterFooter")%></td>
    <td><textarea name="afterfooter" cols="60" rows="3" id="afterfooter" ><%=HtmlElement.htmlToText(obj.getAfterfooter())%></textarea></td>
  </tr>
</table>
<input type="submit" value="<%=r.getString(teasession._nLanguage, "Submit")%>"/>
<input type="submit" name="delete" value="恢复默认设置">
   </form>

<div id="head6"><img height="6" src="about:blank"></div>
<%--<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>--%>
</body>
</html>


