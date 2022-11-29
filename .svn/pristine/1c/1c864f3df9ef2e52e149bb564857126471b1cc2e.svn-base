<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.entity.site.*" %><%@ page  import="tea.resource.Resource"  %><%@page  import="tea.entity.node.*" %><%@page import="java.util.*" %><%@ page import="tea.ui.*" %><%@ page import="tea.html.*" %><%
request.setCharacterEncoding("UTF-8");

response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession=new TeaSession(request);

Node node=Node.find(teasession._nNode);

String community=node.getCommunity();

String subject="";
Date issueDate=null;
String text="";
int options1=node.getOptions1();
int type=node.getType();
if(type==1)
{
  type=Category.find(teasession._nNode).getCategory();
}else
{
  subject=node.getSubject(teasession._nLanguage);
  issueDate=node.getTime();
  text=HtmlElement.htmlToText(node.getText(teasession._nLanguage));
  type=node.getType();
  options1=Node.find(node.getFather()).getOptions1();
}
if((options1& 1) == 0)
{
  if(teasession._rv==null)
  {
    response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
    return;
  }
  if (!node.isCreator(teasession._rv)&&!AccessMember.find(node._nNode, teasession._rv._strV).isProvider(type))
  {
    response.sendError(403);
    return;
  }
}

if(type>65534)
{
  type=TypeAlias.find(type).getType();
}


String nexturl=teasession.getParameter("nexturl");

Resource r=new Resource();

String title=node.getSubject(teasession._nLanguage);

StringBuffer sbcheck=new StringBuffer();

%>
<HTML>
<HEAD>
<title><%=title%></title>
<link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>
<body onload="form1.subject.focus();">
<h1><%=title%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div>

<form name='form1' action="/servlet/EditDynamicValue" method="post" enctype="multipart/form-data" onsubmit="return fcheck();">
<input type="hidden" name="community" value="<%=community%>">
<input type="hidden" name="node" value="<%=teasession._nNode%>">
<%
if(nexturl!=null)
{
  out.print("<input type='hidden' name='nexturl' value='"+nexturl+"' />");
}
%>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td><%=r.getString(teasession._nLanguage,"Subject")%>:</td>
    <td nowrap class=huititable ><input name="subject" class="edit_input"  type="text" value="<%=subject%>" size="25" maxlength="100">
    </td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage,"Text")%>:</td>
    <td nowrap class=huititable ><textarea name="text" style="" rows="8" cols="70" class="edit_input"><%=text%></textarea>
</td>
</tr>
<tr>
  <td><%=r.getString(teasession._nLanguage,"Time")%>:</td>
  <td nowrap class=huititable ><%=new tea.htmlx.TimeSelection("Issue", issueDate)%> </td>
</tr>
</table>
<%
Enumeration enumeration=DynamicType.findByDynamic(type);
while(enumeration.hasMoreElements())
{
  int id=((Integer)enumeration.nextElement()).intValue();
  DynamicType obj=DynamicType.find(id);
  if(obj.isHidden())
  {
    if(obj.isNeed())
    {
      sbcheck.append("&&submitText(form1.dynamictype"+id+", '"+r.getString(teasession._nLanguage, "InvalidParameter")+"-"+obj.getName(teasession._nLanguage)+"')");
      //out.print("*&#12288;");
    }
    //out.print(obj.getName(teasession._nLanguage));
    out.print(obj.getText(teasession,teasession._nNode,0));
  }
}
%>
<INPUT TYPE=SUBMIT NAME="GoBack"  ID="edit_GoSuper" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "Super")%>">
<INPUT TYPE=SUBMIT name="GoFinish" ID="edit_GoFinish" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "GoFinish")%>">
</form>
<script>
function fcheck()
{
  return submitText(form1.subject, '<%=r.getString(teasession._nLanguage, "InvalidSubject")%>')<%=sbcheck.toString()%>;
}
</script>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</html>
