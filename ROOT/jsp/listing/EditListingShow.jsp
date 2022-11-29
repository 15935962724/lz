<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>
<%
r.add("/tea/ui/node/listing/ListingShow");

int id=0;
if(request.getParameter("id")!=null)
id=Integer.parseInt(request.getParameter("id"));
int style=0,type=0,root=teasession._nNode,typealias=0,listing=Integer.parseInt(request.getParameter("Listing"));
if(id!=0)
{
  tea.entity.node.ListingShow ls_obj=tea.entity.node.ListingShow.find(id);
  style=ls_obj.getStyle();
  type=ls_obj.getType();
  root=ls_obj.getRoot();
  typealias=ls_obj.getTypeAlias();
  listing=ls_obj.getListing();
}

%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>
<body> 
<h1><%=r.getString(teasession._nLanguage, "EditListingShow")%></h1>
<div id="head6"><img height="6" src="about:blank"></div> 
<div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div> 
<FORM name=foEdit METHOD=POST action="/servlet/EditListingShow" onSubmit="return(submitInteger(this.root,'InvalidNode'))"> 
  <input type='hidden' name=Node VALUE="<%=teasession._nNode%>"> 
  <input type='hidden' name=Listing VALUE="<%=listing%>"> 
  <input type='hidden' name=id VALUE="<%=id%>"> 
  <table border="0" cellspacing="0" cellpadding="0" id="tablecenter"> 
    <tr> 
      <TD><%=r.getString(teasession._nLanguage, "Style")%>:</TD> 
      <td> <input  id="radio" type="radio" name="style" <%=getCheck(0==style)%> value="0" id="0"> 
        <label for="0"><%=r.getString(teasession._nLanguage, tea.entity.node.ListingShow.STYLE_TYPE[0])%></label> 
        <input  id="radio" type="radio" name="style" <%=getCheck(1==style)%> value="1" id="1"> 
        <label for="1"><%=r.getString(teasession._nLanguage,  tea.entity.node.ListingShow.STYLE_TYPE[1])%></label> 
        <input  id="radio" type="radio" name="style" <%=getCheck(2==style)%>  value="2" id="2"> 
        <label for="2"><%=r.getString(teasession._nLanguage, tea.entity.node.ListingShow.STYLE_TYPE[2])%></label> </td> 
    </tr> 
    <tr> 
      <TD><%=r.getString(teasession._nLanguage, "Type")%>:</TD> 
      <td><%=new tea.htmlx.TypeSelection(teasession._nLanguage, type, typealias)%> </td> 
    </tr> 
    <tr> 
      <TD><%=r.getString(teasession._nLanguage, "Node")%>:</TD> 
      <td><input type="TEXT" class="edit_input"  name=root VALUE="<%=root%>"></td> 
    </tr> 
  </table> 
  <input type="submit" class="edit_button" id="edit_submit"  value="提交"> 
</form> 
<div id="head6"><img height="6" src="about:blank"></div> 
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div> 
</body>
</html>

