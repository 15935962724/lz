<%@page contentType="text/html;charset=UTF-8" %><%@ page import="java.util.*" %><%@ page import="tea.html.*" %><%@ page import="java.math.*" %><%@page import="tea.ui.node.general.*" %><%@ page import="tea.entity.member.*" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.*" %><%@ page import="tea.entity.site.*" %><%@page import="tea.entity.*" %><%@page import="tea.entity.node.*" %><%@ page import="tea.ui.*" %><% request.setCharacterEncoding("UTF-8");

Http h=new Http(request,response);
TeaSession teasession=new TeaSession(request);

int i = Integer.parseInt(request.getParameter("listing"));
Listing obj = Listing.find(i);


Node node = Node.find(h.node);

AccessMember am=AccessMember.find(h.node,teasession._rv);

if(!node.isCreator(teasession._rv)&&am.getPurview()<2)
{
  response.sendRedirect("/servlet/StartLogin?node=" + h.node);
  return;
}

Resource r=new Resource("/tea/ui/node/listing/Picks");
r.add("/tea/ui/node/listing/ListingShow");

int status=obj.getStatus();

%><!DOCTYPE html>
<html>
<head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script>
function f_pickmanual(v)
{
  window.open('EditPickManual.jsp?node=<%=h.node%>&listing=<%=i%>&pickmanual='+v, '_self');
}
function f_pickmanual2(obj,v)
{
  if(confirm('你真想删除这个吗?'))
  {
    window.open('/servlet/EditPickManual?node=<%=h.node%>&listing=<%=i%>&pickmanual='+v+'&act=delete', '_self');
    obj.disabled=true;
  }
}

//////////////////////////////////////
function f_pickfrom(v)
{
  window.open('EditPickFrom.jsp?node=<%=h.node%>&listing=<%=i%>&pickfrom='+v, '_self');
}
function f_pickfrom2(obj,v)
{
  if(confirm('你真想删除这个吗?'))
  {
    mt.post('/servlet/EditPickFrom?node=<%=h.node%>&listing=<%=i%>&pickfrom='+v+'&act=delete');
    obj.disabled=true;
  }
}

//////////////////////////////////////
function f_picknode(v)
{
  window.open('EditPickNode.jsp?node=<%=h.node%>&listing=<%=i%>&picknode='+v, '_self');
}
function f_picknode2(obj,v,v2)
{
  if(confirm('你真想删除这个吗?'))
  {
    window.open('/servlet/EditPickNode?node=<%=h.node%>&listing=<%=i%>&picknode='+v+'&type='+v2+'&act=delete', '_self');
    obj.disabled=true;
  }
}

//////////////////////////////////////
function f_picknews(v)
{
  window.open('EditPickNews.jsp?node=<%=h.node%>&listing=<%=i%>&picknews='+v, '_self');
}
function f_picknews2(obj,v)
{
  if(confirm('你真想删除这个吗?'))
  {
    window.open('/servlet/EditPickNews?node=<%=h.node%>&listing=<%=i%>&picknews='+v+'&act=delete', '_self');
    obj.disabled=true;
  }
}
</script>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "Pick")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div>
<%--
<TABLE CELLSPACING=0 class="section">
<tr id="TableCaption">
  <td hu="hu"><%=r.getString(teasession._nLanguage, "Style")%></td>
</tr>
<tr>
<td class="listing">
<table cellspacing="0" cellpadding="0" class="listings">
  <tr ID=TableHeader>
    <td><%=r.getString(teasession._nLanguage, "Style")%></td>
    <td><%=r.getString(teasession._nLanguage, "Type")%></td>
    <td><%=r.getString(teasession._nLanguage, "Node")%></td>
<td></td>
  </tr>
  <%
  for(java.util.Enumeration enumeration = tea.entity.node.ListingShow.findByListing(i); enumeration.hasMoreElements(); )
{
  int id = ((Integer)enumeration.nextElement()).intValue();
     tea.entity.node.ListingShow ls_obj = tea.entity.node.ListingShow.find(id);

      %> <tr>
    <td><%=r.getString(teasession._nLanguage,tea.entity.node.ListingShow.STYLE_TYPE[ls_obj.getStyle()])%></td>
    <td><%   int type = ls_obj.getType();
     int typealias = ls_obj.getTypeAlias();
     if(type == 255)
		out.print(r.getString(teasession._nLanguage, "AllTypes"));
    else
     if(typealias == 0)
     {	out.print(r.getString(teasession._nLanguage, Node.NODE_TYPE[type]));
     }  else
     {
         TypeAlias typealias1 = TypeAlias.find(typealias);
        out.print( typealias1.getName(teasession._nLanguage));
     }%></td>
    <td><%=tea.entity.node.Node.find(ls_obj.getRoot()).getAnchor(teasession._nLanguage)%></td>
<td>
<input type="button" value="<%=r.getString(teasession._nLanguage, "CBEdit")%>" ID=CBEdit CLASS=CB onClick="window.open('EditListingShow.jsp?node=<%=h.node%>&Listing=<%=i%>&id=<%=id%>', '_self');">
<input type="button" value="<%=r.getString(teasession._nLanguage, "CBDelete")%>" ID=CBDelete CLASS=CB onClick="if(confirm('<%=r.getString(teasession._nLanguage, "ConfirmDelete")%>')){window.open('/servlet/EditListingShow?node=<%=h.node%>&Listing=<%=i%>&id=<%=id%>&delete=ON', '_self');}">

</td>
  </tr>
  <%

}
  %>
</table>
  </td>
  </tr>
</table>
<input type="button" value="<%=r.getString(teasession._nLanguage, "CBNew")%>" ID="CBNew" CLASS="CB" onClick="window.open('/jsp/listing/EditListingShow.jsp?node=<%=h.node%>&Listing=<%=i%>', '_self');">
--%>
<%
if(obj.getPick() == 0)
{
%>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr ID=tableonetr>
    <td><%=r.getString(teasession._nLanguage, "Community")%></td>
    <td><%=r.getString(teasession._nLanguage, "Type")%></td>
    <td></td>
  </tr>
  <%
  Iterator it=PickManual.find(" AND listing="+i,0,Integer.MAX_VALUE).iterator();
  while(it.hasNext())
  {
    PickManual t = (PickManual)it.next();
    out.println("<tr onmouseover=bgColor='#BCD1E9' onmouseout=bgColor='' >");
    out.println("<td>"+MT.f(t.community,r.getString(teasession._nLanguage, "AllCommunities")));
    if(t.type == 255)
    out.println("<td>"+r.getString(teasession._nLanguage, "AllTypes"));
    else if(t.type<1024)
    {
      out.println("<td>"+r.getString(teasession._nLanguage, Node.NODE_TYPE[t.type]));
    }else if(t.type<65535)
    {
      out.println("<td>"+Dynamic.find(t.type).getName(teasession._nLanguage));
    }else
    {
      TypeAlias ta = TypeAlias.find(t.type);
      out.println("<td>" + ta.getName(teasession._nLanguage));
    }
    out.println("<td><input type='button' value="+r.getString(teasession._nLanguage, "CBEdit")+" ID=CBEdit CLASS=CB onClick=f_pickmanual("+t.pickmanual+");>");
    out.println("<input type='button' value="+r.getString(teasession._nLanguage, "CBDelete")+" ID=CBDelete CLASS=CB onClick=f_pickmanual2(this,"+t.pickmanual+");>");
  }
  out.println("</td></tr></table><input type='button' value="+r.getString(teasession._nLanguage, "CBNew")+" ID=CBNew CLASS=CB onClick=f_pickmanual(0);>");
}

if(obj.getPick() != 0 && obj.getType() != 1)
{%>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr ID=tableonetr>
      <td><%=r.getString(teasession._nLanguage, "FromStyle")%></td>
      <td><%=r.getString(teasession._nLanguage, "FromCommunity")%></td>
      <td><%=r.getString(teasession._nLanguage, "FromNode")%></td>
      <td>&nbsp;</td>
    </tr>
    <%
    Iterator it=PickFrom.findByListing(i).iterator();
    while(it.hasNext())
    {
      PickFrom t=(PickFrom)it.next();
      int l=t.getFromStyle();
      out.println("<tr onmouseover=bgColor='#BCD1E9' onmouseout=bgColor='' ><td>"+r.getString(teasession._nLanguage, PickFrom.FROM_STYLE[l]));

      if(l!=1)
      out.println("</td><td>"+t.getFromCommunity());//out.println(pickfrom.getFromCommunity());
      else
      out.println("</td><td>");
      //out.println(Node.find(pickfrom.getFromNode()).getAnchor(teasession._nLanguage));
      Node.find(t.getFromNode()).getAncestor(teasession._nLanguage);
      out.println("</td><td>"+Node.find(t.getFromNode()).getAnchor(teasession._nLanguage));
      out.println("</td><td><input type='button' value="+r.getString(teasession._nLanguage, "CBEdit")+" ID=CBEdit CLASS=CB onClick='f_pickfrom("+t.pickfrom+");'>");
      out.println("<input type='button' value="+r.getString(teasession._nLanguage, "CBDelete")+" ID=CBDelete CLASS=CB onClick='f_pickfrom2(this,"+t.pickfrom+");'>");
	  out.println("</td></tr>");
    }
%>
  </table>
  <input type="button" value="<%=r.getString(teasession._nLanguage, "CBNew")%>" ID="CBNew" CLASS="CB" onClick="f_pickfrom('0');">


<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr ID=tableonetr>
    <td><%=r.getString(teasession._nLanguage, "Style")%></td>
    <td><%=r.getString(teasession._nLanguage, "Type")%></td>
    <td><%=r.getString(teasession._nLanguage, "CreatorStyle")%></td>
    <td><%=r.getString(teasession._nLanguage, "RCreator")%></td>
    <td><%=r.getString(teasession._nLanguage, "VCreator")%></td>
    <td><%=r.getString(teasession._nLanguage, "StartStyle")%></td>
    <td><%=r.getString(teasession._nLanguage, "StopStyle")%></td>
    <td>&nbsp;</td>
  </tr>
<%
it=PickNode.findByListing(i).iterator();
while(it.hasNext())
{
  PickNode picknode=(PickNode)it.next();
  //int i1=((Integer)enumeration2.nextElement()).intValue();
  //PickNode picknode=PickNode.find(i1);


  out.println("<tr onmouseover=bgColor='#BCD1E9' onmouseout=bgColor='' ><td>");
  out.println(r.getString(teasession._nLanguage,tea.entity.node. PickNode.NODE_STYLE[picknode.nodeStyle]));
  if(picknode.type == 255)
  out.println("<td>"+r.getString(teasession._nLanguage, "AllTypes"));
  else if(picknode.type<1024)
  {
    out.println("<td>"+r.getString(teasession._nLanguage, Node.NODE_TYPE[picknode.type]));
  }else if(picknode.type<65535)
  {
    out.println("<td>"+Dynamic.find(picknode.type).getName(teasession._nLanguage));
  }else
  {
    TypeAlias ta=TypeAlias.find(picknode.type);
    out.println("<td>" + ta.getName(teasession._nLanguage));
  }
  out.println("<td>"+r.getString(teasession._nLanguage, PickNode.CREATOR_STYLE[picknode.creatorStyle]));
  if(picknode.creatorStyle != 0)
  {
    out.println("<td>"+picknode.rcreator);
    out.println("<td>"+picknode.vcreator);
  } else
  {
    out.println("<td colspan='2'>&nbsp;");
  }
  int i3=picknode.startStyle;
  int j3=picknode.startTerm;
  out.println("<td>"+r.getString(teasession._nLanguage, PickNode.TERM_STYLE[i3]) + (i3 != 0 ? " " + (j3 > 0 ? "+" : "") + j3 + " " + r.getString(teasession._nLanguage, "Hours") : ""));
  //out.println(r.getString(teasession._nLanguage, PickNode.TERM_STYLE[i3]) + (i3 != 0 ? " " + (j3 > 0 ? "+" : "") + j3 + " " + r.getString(teasession._nLanguage, "Hours") : ""));
  int k3=picknode.stopStyle;
  int l3=picknode.stopTerm;
  //out.println(r.getString(teasession._nLanguage, PickNode.TERM_STYLE[k3]) + (k3 != 0 ? " " + (l3 > 0 ? "+" : "") + l3 + " " + r.getString(teasession._nLanguage, "Hours") : ""));
  out.println("<td>"+r.getString(teasession._nLanguage, PickNode.TERM_STYLE[k3]) + (k3 != 0 ? " " + (l3 > 0 ? "+" : "") + l3 + " " + r.getString(teasession._nLanguage, "Hours") : ""));
  out.println("<td><input type=button VALUE="+r.getString(teasession._nLanguage, "CBEdit")+" ID=CBNew CLASS=CB onClick=f_picknode("+picknode.picknode+");>");
  out.println("<input type='button' value="+r.getString(teasession._nLanguage, "CBDelete")+" ID=CBNew CLASS=CB onClick=f_picknode2(this,"+picknode.picknode+","+picknode.type+");></td></tr>");
}
%>
</table>
<input type="button" value="<%=r.getString(teasession._nLanguage, "CBNew")%>" ID="CBNew" CLASS="CB" onClick="f_picknode(0);">


<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr ID=tableonetr>
  <td><%=r.getString(teasession._nLanguage, "IssueTerm")%></td>
  <td>&nbsp;</td>
</tr>
<%
it=PickNews.findByListing(i).iterator();
while(it.hasNext())
{
  PickNews pe=(PickNews)it.next();
  out.println("<tr onmouseover=bgColor='#BCD1E9' onmouseout=bgColor='' ><td>"+pe.issueTerm);
  out.println("<td><input type='button' value="+r.getString(teasession._nLanguage, "CBEdit")+" ID=CBEdit CLASS=CB onClick=\"f_picknews("+pe.picknews+");\">");
  out.println("<input type='button' value="+r.getString(teasession._nLanguage, "CBDelete")+" ID=CBDelete CLASS=CB onClick=\"f_picknews2(this,"+pe.picknews+");\">");
  out.println("</td></tr>");
}
%>
</table>
<input type="button" value="<%=r.getString(teasession._nLanguage, "CBNew")%>" ID="CBNew" CLASS="CB" onClick="f_picknews(0);">
<%}%>





<br><br>
  <input type="submit" VALUE="<%=r.getString(teasession._nLanguage, "GoBack")%>" onclick="window.open('EditListing.jsp?node=<%=h.node%>&status=<%=status%>&listing=<%=i%>','_self');">
  <input type=SUBMIT VALUE="<%=r.getString(teasession._nLanguage, "Finish")%>" onclick="window.open('/servlet/Node?node=<%=h.node%>&status=<%=status%>&edit=ON','_self');">

<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</html>
