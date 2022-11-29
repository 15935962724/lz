<%@page contentType="text/html;charset=UTF-8" %><%@page import="java.util.*" %><%@page import="java.net.*" %><%@page import="tea.resource.Resource" %><%@page import="tea.ui.*" %><%@page import="tea.entity.*" %><%@page import="tea.entity.node.*" %><%@page import="tea.entity.site.*" %><% request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
AccessMember am =AccessMember.find(teasession._nNode, teasession._rv);

boolean bool=false;
RV rv = teasession._rv;
if (rv == null)
{
	rv = new RV("<" + request.getRemoteAddr() + ">");
}else
{
	bool=teasession._rv.isWebMaster()||teasession._rv.isOrganizer(teasession._strCommunity);
}
if(am.getPurview()<3&&!bool)
{
	response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
	return;
}

Node node=Node.find(teasession._nNode);

Resource r=new Resource("/tea/ui/member/community/Providers");
r.add("/tea/ui/node/access/AccessMembers");


%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT SRC="/tea/tea.js" type="text/javascript"></SCRIPT>
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

<h1><%=r.getString(teasession._nLanguage, "CBAccessMembers")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div>

<FORM name="form1" METHOD=post action="/servlet/EditAccessMember">
<input type='hidden' name="node" VALUE="<%=teasession._nNode%>">
<input type='hidden' name="act" VALUE="">
<input type='hidden' name="accessmember" VALUE="0">

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr id="tableonetr">
  <td width=1>&nbsp;</td>
  <td noWrap><%=r.getString(teasession._nLanguage, "会员")%></td>
  <td noWrap><%=r.getString(teasession._nLanguage, "应用于")%></td>
  <td noWrap><%=r.getString(teasession._nLanguage, "权限")%></td>
  <td noWrap><%=r.getString(teasession._nLanguage, "继承于")%></td>
  <td noWrap>&nbsp;</td>
</tr>
<%
Enumeration e = AccessMember.findByNode(teasession._nNode);
for(int i=0;e.hasMoreElements();)
{
  int id = ((Integer)e.nextElement()).intValue();
  AccessMember obj=AccessMember.find(id);
  //如果是组织者||创建者
  String creator=obj.getCreator();
  if(bool||creator.equals(rv._strV))
  {
    %>
    <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
      <td width="1"><%=++i%></td>
      <td><%=AccessMember.OBJECT_TYPE[obj.getObjectType()]%></td>
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
<tr>
	<td colspan="10">注意:如果是要设置其他类别的 手动列举权限，要在编辑后出现的链接 里面添加参数“type2”,例如：/jsp/access/EditAccessMember.jsp?node=71&accessmember=1&type2=94</td>
</tr>
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
