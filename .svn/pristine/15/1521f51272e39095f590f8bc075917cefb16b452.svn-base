<%@page contentType="text/html;charset=UTF-8" %><%@ page import="java.util.*" %><%@ page import="tea.html.*" %><%@ page import="java.math.*" %><%@page import="tea.ui.node.general.*" %><%@ page import="tea.entity.member.*" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.*" %><%@ page import="tea.entity.site.*" %><%@ page import="tea.entity.node.*" %><%@ page import="tea.ui.*" %><% request.setCharacterEncoding("UTF-8");
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");


TeaSession teasession=new TeaSession(request);
Node node =Node.find(teasession._nNode);
AccessMember am=AccessMember.find(teasession._nNode,teasession._rv);
if(!node.isCreator(teasession._rv)&&am.getPurview()<1)
{
	response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
  return;
}

Resource r=new Resource("/tea/ui/node/listed/NewListed");

StringBuilder sql=new StringBuilder();
StringBuilder par=new StringBuilder();
par.append("?node=").append(teasession._nNode);
String q=request.getParameter("q");
if(q!=null&&q.length()>0)
{
  sql.append(" AND ( EXISTS(SELECT listing FROM ListingLayer WHERE l.listing=listing AND name LIKE "+DbAdapter.cite("%"+q+"%")+") OR EXISTS(SELECT node FROM NodeLayer WHERE l.node=node AND subject LIKE "+DbAdapter.cite("%"+q+"%")+") )");
  par.append("&q=").append(java.net.URLEncoder.encode(q,"UTF-8"));
}

%><html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type="">
</SCRIPT>
<script type="">
function fselectall(obj,bool)
{
  if(obj=="[object]")
  {
    obj.checked=bool;
    for (var index=0;index<obj.length;index++)
    {
      obj[index].checked=bool;
    }
  }
}

function submitChecks(obj,txt)
{
  if(obj=='[object]')
  {
    if(obj.checked)
    return true;
    for (var index=0;index<obj.length;index++)
    {
      if(obj[index].checked)
      return true;
    }
  }
  alert(txt);
  return false;
}
</script>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "Report")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="pathdiv"> <%=Node.find(teasession._nNode).getAncestor(teasession._nLanguage)%></div>

<form action="?">
<input type="hidden" name="node" value="<%=teasession._nNode%>"/>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr><td><%=r.getString(teasession._nLanguage, "Name")%><input name="q" type="text" value="<%if(q!=null)out.print(q);%>"><input  type="submit" value="GO"></td>
<td>
</table>
</form>

<%
for(int index=0;index<PickManual.CLASSES_TYPE.length;index++)
{
  int pos=0;
  String strpos=request.getParameter("pos"+index);
  if(strpos!=null)
  pos=Integer.parseInt(strpos);
  int count=Listing.countManualListing(node.getCommunity(),node.getType()," AND classes="+index+sql.toString());
  if(count>0||index==0)
  {
    %>
    <form name="fform111net<%=index%>" action="/servlet/EditListed" method="get" onSubmit="return submitChecks(this.Listing,'<%=r.getString(teasession._nLanguage,"InvalidSelect")%>')">
    <input type="hidden" name="node" value="<%=teasession._nNode%>"/>
    <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
      <tr ID=tableonetr>
        <td>&nbsp;</td>
        <td><%=r.getString(teasession._nLanguage, "ListingNode")%></td>
        <td><%=r.getString(teasession._nLanguage, "Name")%></td>
        <td><%=r.getString(teasession._nLanguage, "Style")%></td>
        <td><%=r.getString(teasession._nLanguage, "Quantity")%></td>
        <td>&nbsp;</td>
      </tr>
      <%
      for(Enumeration enumeration = Listing.findManualListing(node.getCommunity(),node.getType()," AND classes="+index+sql.toString(),pos,25); enumeration.hasMoreElements(); )
      {
        int i = ((Integer)enumeration.nextElement()).intValue();
        Listing listing = Listing.find(i);
        String name=listing.getName(teasession._nLanguage);
        if(q!=null&&q.length()>0)
        {
          name=name.replaceAll(q,"<font color=red>"+q+"</font>");
        }
        %>
        <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
          <td><input  id="CHECKBOX" type="CHECKBOX" name="Listing" value="<%=i%>">
          <%
          out.println("<td>"+Node.find(listing.getNode()).getAnchor(teasession._nLanguage));
          out.println("<td>"+name);
          out.println("<td>"+r.getString(teasession._nLanguage, Section.APPLY_STYLE[listing.getStyle()]));
          out.println("<td>"+listing.getQuantity());
          %> </td>
          <td><input type="button" value="<%=r.getString(teasession._nLanguage, "CBContinue")%>" ID="CBContinue" CLASS="CB" onClick="window.open('/servlet/EditListed?Listing=<%=i%>&node=<%=teasession._nNode%>', '_self');">
          <%           }


            %> </td>
            </tr>
            <tr>
              <td colspan="2"><input  id="CHECKBOX" type="CHECKBOX" onClick="fselectall(fform111net<%=index%>.Listing,this.checked);"><%=r.getString(teasession._nLanguage, "SelectAll")%></td>
              <td colspan="3"><%=new tea.htmlx.FPNL(teasession._nLanguage, par.toString()+ "&pos"+index+"=", pos,count )%>
            </tr>
    </table>
    <input type=submit VALUE="<%=r.getString(teasession._nLanguage, "CBContinue")%>" ID="CBContinue" CLASS="CB" >

    </form>
    <%}
    }
%>
<br>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</html>

