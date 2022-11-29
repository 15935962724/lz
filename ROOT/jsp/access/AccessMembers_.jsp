<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.entity.*"%><%@page import="java.util.*" %><%@page import="java.net.*" %><%@page import="tea.resource.Resource" %><%@page import="tea.ui.*" %><%@page import="tea.entity.node.*" %><%@page import="tea.entity.site.*" %><% request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+request.getRequestURI()+"?"+request.getQueryString());
  return;
}
Http h=new Http(request,response);


boolean bool=teasession._rv.isWebMaster()||teasession._rv.isOrganizer(teasession._strCommunity);

Node node=Node.find(teasession._nNode);
tea.entity.node.AccessMember am = null;
if (teasession._rv != null)
{

  am = tea.entity.node.AccessMember.find(teasession._nNode, teasession._rv._strV);

}


String nr = tea.ui.node.general.NodeServlet.getButton(node,h, am,request);


if(!bool&&!node.isCreator(teasession._rv)&&AccessMember.find(teasession._nNode,teasession._rv._strV).getPurview()!=3)
{
  response.sendError(403);
  return;
}

Resource r=new Resource("/tea/ui/member/community/Providers");
r.add("/tea/ui/node/access/AccessMembers");

String title=r.getString(teasession._nLanguage, "CBAccessMembers");
%>
<html>
<head>
<title><%=title%></title>
<link href="/tea/tea.css" rel="stylesheet" type="text/css"/>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT SRC="/tea/tea.js" type="text/javascript"></SCRIPT>
<script src="/tea/mt.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<script type="">
function f_submit(act,v)
{
  var bool=true;
  if(act=="delete")
  {
    bool=confirm('<%=r.getString(teasession._nLanguage,"ConfirmDelete")%>');
  }else if(act=="extend")
  {
    if(!form1.extend.checked)
    {
      bool= confirm('<%=r.getString(teasession._nLanguage,"faq1mgb6")%>');
      if(!bool)
      {
        form1.extend.checked=true;
      }
    }
  }else if(act=="reset")
  {
    bool= confirm('<%=r.getString(teasession._nLanguage,"ConfirmApplyToThisTree")%>');
  }
  if(bool)
  {
    form1.accessmember.value=v;
    form1.act.value=act;
    form1.submit();
  }
}
</script>
</head>
<body>
<%=nr%>
<h1><%=title%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div>

<FORM name="form1" METHOD=post action="/servlet/EditAccessMember">
<input type='hidden' name="node" VALUE="<%=teasession._nNode%>">
<input type='hidden' name="act" VALUE="">
<input type='hidden' name="accessmember" VALUE="0">

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr id="tableonetr">
  <td width=1>&nbsp;</td>
  <td><%=r.getString(teasession._nLanguage, "会员")%></td>
  <td><%=r.getString(teasession._nLanguage, "应用于")%></td>
  <td><%=r.getString(teasession._nLanguage, "权限")%></td>
  <td><%=r.getString(teasession._nLanguage, "继承于")%></td>
  <td>&nbsp;</td>
</tr>
<%
Enumeration e = AccessMember.findByNode(teasession._nNode);
for(int i=0;e.hasMoreElements();)
{
  int id = ((Integer)e.nextElement()).intValue();
  AccessMember obj=AccessMember.find(id);
  //如果是组织者||创建者
  String creator=obj.getCreator();
  if(bool||creator.equals(teasession._rv._strV))
  {
    String member=obj.getMember();
    %>
    <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
      <td width="1"><%=++i%></td>
      <td><%=member%></td>
      <td><%=AccessMember.APPLY_STYLE[obj.getStyle()]%></td>
      <td><%=AccessMember.PUR_TYPE[obj.getPurview()]%></td>
      <td>&nbsp;
      <%

      if(obj.getNode()!=teasession._nNode)
      {
        out.print(Node.find(obj.getNode()).getAncestor(teasession._nLanguage));
      }
      %>
      </td>
      <td>
        <input type="button" value="<%=r.getString(teasession._nLanguage, "CBEdit")%>"  onClick="window.open('/jsp/access/EditAccessMember.jsp?node=<%=teasession._nNode%>&accessmember=<%=id%>','_self');">
        <input type="button" value="<%=r.getString(teasession._nLanguage, "CBDelete")%>" onClick="f_submit('delete','<%=id%>');">
      </td>
    </tr>
    <%
  }
}
%>
</table>

<input type="button" value="<%=r.getString(teasession._nLanguage, "CBNew")%>" onClick="window.open('/jsp/access/EditAccessMember.jsp?node=<%=teasession._nNode%>', '_self');">

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<%
if(node.getFather()>0)
{
  out.print("<tr><td><input type=checkbox ");
  if(node.isExtend())
  {
    out.print(" checked ");
  }
  out.print(" name=extend id=extend onClick=f_submit('extend'); ><label for=extend>"+r.getString(teasession._nLanguage,"InheritPurview")+"</label></td></tr>");
}
%>
  <tr>
    <td>
      <input type="button" name="reset" id="reset" onClick="f_submit('reset');" value="<%=r.getString(teasession._nLanguage,"ConfirmApplyToThisTree")%>">
    </td>
  </tr>
</table>
</FORM>

<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</html>
