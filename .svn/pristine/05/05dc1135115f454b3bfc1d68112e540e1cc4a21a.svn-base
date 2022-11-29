<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter" %><%@page import="tea.entity.*" %>
<%@page import="tea.resource.Resource"  %>
<%@page import="tea.entity.admin.office.*" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.ui.TeaSession" %><%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

Resource r=new Resource();

boolean esp=request.getParameter("esp")!=null;
int seal=0;
String tmp=request.getParameter("seal");
if(tmp!=null)
{
  seal=Integer.parseInt(tmp);
}

boolean debug="127.0.0.1".equals(request.getRemoteAddr());

AdminUsrRole aur=AdminUsrRole.find(teasession._strCommunity,teasession._rv._strV);
String cachet=aur.getCachet();


//http://127.0.0.1/jsp/admin/office/CachetList.jsp?esp=on

%>
<html>
<head>
<title>选择印章</title>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT src="/tea/tea.js" type="text/javascript"></SCRIPT>
<script LANGUAGE=JAVASCRIPT src="/tea/applet/office/ocx.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script>
function f_s(dv)
{
  var ds=document.all('ds');
  if(!ds)return;
  if(!ds.length)ds=new Array(ds);
  for(var i=0;i<ds.length;i++)
  {
    ds[i].style.display='none';
  }
  if(dv)form1.sel.value=dv;
  var i=form1.sel.selectedIndex;
  if(i==-1)i=form1.sel.selectedIndex=0;
  ds[i].style.display='';
}
function f_c(src)
{
  opener.f_SelSign(src);
  window.close();
}
window.focus();
</script>
</head>
<body oncontextmenu="return <%=debug%>;" onload="window.focus();f_s(window.opener?opener.ssign:null)">

<h1>电子章</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br>
<script>
//document.write("<object id='s1' classid=clsid:36B09CEA-F6CC-4971-B7B5-52CAE0810666 codebase=/tea/applet/office/ntkosigntool.cab#version=3,0,5,0>");
//document.write("<div style=color:red>不能装载印章管理控件。请在检查浏览器的选项中检查浏览器的安全设置。</div>");
//document.write("</object>");
//$('s1').OpenFromURL("/res/Home/office/newsign.esp?123456","123456");
</script>
<form name="form1">
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr><td valign="top">
<%
int j=0;
String cs[]=cachet.split("/");
if(cs.length>1)
{
  StringBuilder js=new StringBuilder();
  out.print("<select name='sel' size='12' style='width:300px' onDblClick='f_c(sel.value)' onchange='f_s()'>");
  for(int i=1;i<cs.length;i++)
  {
    int igd=Integer.parseInt(cs[i]);
    Cachet obj=Cachet.find(igd);
    if(!obj.isExists()||obj.isEsp()!=esp)continue;
    String n=obj.getName();
    String v=obj.getPicture()+"?"+obj.getPassword();
    out.print("<option value=\""+v+"\" ");
    if(seal==igd)out.print(" selected='true'");
    out.print(">"+n+" - "+obj.getType());
    //
    js.append("<div id='ds' style='display:none'><script>sign.show(\""+v+"\");</script></div>");
  }
  out.print("</select></td><td>"+js.toString());
//  out.print("<script>");
//  out.print("var sel=document.all('sel');var op=sel.options;");
//  out.print("if(ss)sel.value=ss;");
//  out.print("if(sel.selectedIndex==-1)op[0].selected=true;");
//  out.print("var ocx=sign.show(sel.value);");
//  out.print("</script>");
}else
{
  out.print("对不起,您没有使用印章的权限");
  out.print("<style>.is{ display:none; }</style>");
}
%>
</td></tr>
</table>
<input type="button" value=" 确 定 " onclick="sel.ondblclick();" class="is"/>
<input type="button" value=" 关 闭 " onclick="f_c(null);"/>
</form>

<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</HTML>
