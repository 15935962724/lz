<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.entity.*"%>
<%@include file="/jsp/Header.jsp"%>
<%
if((!node.isCreator(teasession._rv) || !teasession._rv.isAdManager())&&AccessMember.find(teasession._nNode,teasession._rv._strV).getPurview()<2)
{
    response.sendError(403);
    return;
}

String title=r.getString(teasession._nLanguage, "CBAdings");
tea.entity.node.AccessMember am = null;
if (teasession._rv != null)
{

  am = tea.entity.node.AccessMember.find(teasession._nNode, teasession._rv._strV);

}
Http h=new Http(request,response);


tea.entity.node.Node node = tea.entity.node.Node.find(teasession._nNode);
String nr = tea.ui.node.general.NodeServlet.getButton(node,h, am,request);
%>
<html>
<head>
<title><%=title%></title>
<link href="/tea/tea.css" rel="stylesheet" type="text/css"/>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT SRC="/tea/tea.js" type="text/javascript"></SCRIPT>
<script src="/tea/mt.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script>
function f_edit(v)
{
  window.open('/jsp/ading/EditAding.jsp?node=<%=teasession._nNode%>&status=<%=teasession._nStatus%>&ading='+v, '_self');
}
function f_delete(obj,v)
{
  if(confirm('<%=r.getString(teasession._nLanguage, "ConfirmDelete")%>'))
  {
    window.open('/servlet/DeleteAding?node=<%=teasession._nNode%>&status=<%=teasession._nStatus%>&ading='+v, '_self');
    obj.disabled=true;
  }
}
</script>
</head>
<body>
<%=nr%>
<h1><%=title%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr ID=tableonetr>
    <td><%=r.getString(teasession._nLanguage, "Name")%> </td>
    <td><%=r.getString(teasession._nLanguage, "Position")%></td>
    <!-- <td><%=r.getString(teasession._nLanguage, "Style")%> </td> -->
    <td>图片尺寸</td>
    <td><%=r.getString(teasession._nLanguage, "StartTime")%> </td>
    <td><%=r.getString(teasession._nLanguage, "StopTime")%> </td>
    <td><%=r.getString(teasession._nLanguage, "CPM")%>
    <td>&nbsp;</td>
  </tr>
<%
for(int i = 0; i < Section.SECTION_TYPE.length; i++)
{
  ArrayList e = Ading.find(node,teasession._nStatus, i, false);
  for(int j=0;j<e.size();j++)
  {
    Ading obj=(Ading)e.get(j);
    String name = obj.getName(teasession._nLanguage);
    String imgSize = obj.getImgSize(teasession._nLanguage);
    int k=obj.getStyle();
    int st=obj.getStyleType();
    int l = obj.getNode();
    Date start = obj.getStartTime();
    Date stop = obj.getStopTime();
    java.math.BigDecimal bigdecimal = obj.getCpm();
    out.print("<tr onmouseover=bgColor='#BCD1E9' onmouseout=bgColor=''>");
    out.print("<td>"+name);
    out.print("<td>"+r.getString(teasession._nLanguage, Section.SECTION_TYPE[obj.getPosition()]));
   // out.print("<td>"+r.getString(teasession._nLanguage, Section.APPLY_STYLE[k]));
    out.print("<td>" +imgSize);
    if(k!=0)
    {
      if(st==255)
      {
        out.print(r.getString(teasession._nLanguage, "AllTypes"));
      }else if(st<1024)
      {
        out.print(r.getString(teasession._nLanguage, Node.NODE_TYPE[st]));
      }else if(st<65535)
      {
        out.print(Dynamic.find(st).getName(teasession._nLanguage));
      }else
      {
        out.print(TypeAlias.find(st).getName(teasession._nLanguage));
      }
    }
    out.print("<td>");
    if(start == null)
    {
      out.print(r.getString(teasession._nLanguage, "AdingOForever"));
    } else
    {
      out.println(obj.getStartTimeToString());
    }
    out.print("<td>"+obj.getStopTimeToString());
    out.print("<td>"+r.getString(teasession._nLanguage, Common.CURRENCY[obj.getCurrency()]) + bigdecimal);
    out.print("<td><input type=button value="+r.getString(teasession._nLanguage, "CBEdit")+" onClick=f_edit("+obj.ading+")>");
    if(obj.isLayerExisted(teasession._nLanguage))
    {
      out.print("<input type=button value="+r.getString(teasession._nLanguage, "CBDelete")+" onClick=f_delete(this,"+obj.ading+")>");
    }
    out.print(Node.find(l).getAncestor(teasession._nLanguage));
  }
}
%>
</table>
<input type="button" value="<%=r.getString(teasession._nLanguage, "CBNew")%>" ID="CBNew" CLASS="CB" onClick="f_edit(0);">
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</html>
