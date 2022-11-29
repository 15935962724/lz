<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.entity.*"%>
<%@page import="tea.ui.*"%><%@page import="tea.entity.node.*"%><%@page import="tea.html.*"%><%@page import="tea.db.*"%><%@page import="tea.entity.site.*"%><%@page import="tea.resource.*"%><%@page import="java.util.*"%><%@page import="java.io.*"%>
<%
Http h=new Http(request,response);
TeaSession teasession=new TeaSession(request);

Resource r=new Resource();

r.add("/tea/ui/node/general/CloneNode");


String title=r.getString(teasession._nLanguage, "CBClone");
AccessMember am = AccessMember.find(teasession._nNode, teasession._rv);



Node node = Node.find(teasession._nNode);
String nr = tea.ui.node.general.NodeServlet.getButton(node,h, am,request);

%><html>
<head>
<title><%=title%></title>
<link href="/tea/tea.css" rel="stylesheet" type="text/css"/>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script>
function f_colneson(id)
{
  form1.clonesons[id].checked=false;
}
</script>
</head>
<body onload="form1.template.focus();">
<%=nr%>
<h1><%=title%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<!-- 复制-->
<h2><%=r.getString(teasession._nLanguage, "CBClone")%></h2>
<form name=form1 METHOD=POST action="/Nodes.do" target="_ajax" onsubmit="return mt.check(this)&&mt.show(null,0)">
<input type='hidden' name="node" value="<%=h.node%>">
<input type='hidden' name="act" value="clone">
<input type='hidden' name="nexturl" value="location.reload()">
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td><%=r.getString(teasession._nLanguage, "Template")%>:</td>
    <td><input name="template" mask="int" alt="节点号"></td>
</tr>
<tr>
  <td><%=r.getString(teasession._nLanguage, "Options")%>:</td>
  <td>
    <input id="checkbox" type="checkbox" name=clonesections><%=r.getString(teasession._nLanguage, "CloneSections")%>
    <input id="checkbox" type="checkbox" name=clonelistings><%=r.getString(teasession._nLanguage, "CloneListings")%>
    <!--   <input  id="checkbox" type="checkbox" name=CloneCssJs><%=r.getString(teasession._nLanguage, "Clone")%>CssJs-->
    <input id="checkbox" type="checkbox" name=clonesons value="3" onclick="f_colneson(1)"><%=r.getString(teasession._nLanguage, "CloneFrame")%>
    <input id="checkbox" type="checkbox" name=clonesons value="2" onclick="f_colneson(0)"><%=r.getString(teasession._nLanguage, "CloneSons")%>
  </td>
</tr>
<tr>
  <td></td>
  <td><input type="submit" value="<%=r.getString(teasession._nLanguage, "Submit")%>" onclick="f_submit1();"></td>
</tr>
</table>
</form>

<!-- 单一复制-->
<h2><%=r.getString(teasession._nLanguage, "OneClone")%></h2>
<form name=form2 METHOD=POST action="/Nodes.do" target="_ajax" onsubmit="return mt.show(null,0)" >
<input type='hidden' name="node" value="<%=h.node%>">
<input type='hidden' name="act" value="clone">

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr>
  <td><%=r.getString(teasession._nLanguage, "Listing")%>:</td>
  <td><input name=listing mask="int"> <input type="submit" value="<%=r.getString(teasession._nLanguage, "Submit")%>" onclick="return(submitInteger(form2.listing, '<%=r.getString(teasession._nLanguage, "InvalidListingNumber")%>'));"></td>
</tr>
<tr>
  <td><%=r.getString(teasession._nLanguage, "Section")%>:</td>
  <td><input name=section mask="int"> <input type="submit" value="<%=r.getString(teasession._nLanguage, "Submit")%>" onclick="return(submitInteger(form2.section, '<%=r.getString(teasession._nLanguage, "InvalidSectionNumber")%>'));"></td>
</tr>
<tr>
  <td>CssJs:</td>
  <td><input name=cssjs mask="int"> <input type="submit" value="<%=r.getString(teasession._nLanguage, "Submit")%>" onclick="return(submitInteger(form2.cssjs, '<%=r.getString(teasession._nLanguage, "InvalidParameter")%>'));"></td>
</tr>
</table>
</form>

<!--异地复制-->
<h2>异地复制</h2>
<FORM name=form14 METHOD=POST action="/servlet/CloneNode" onSubmit="return(submitInteger(this.template, '<%=r.getString(teasession._nLanguage, "InvalidTemplate")%>'));">
<input type='hidden' name=node VALUE="<%=teasession._nNode%>">
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr>
<td>域名主机:</td>
  <td><input type="text" name="dn" value=""/>
端口:<input type="text" name="port" value="80" size="5" mask="int"/></td>
</tr>
<tr><td>
  <%=r.getString(teasession._nLanguage, "Template")%>:
  </td>
  <td>
  <input type="TEXT" name=template mask="int">
  <input  id="checkbox" type="checkbox" name=clonesections><%=r.getString(teasession._nLanguage, "CloneSections")%>
  <input  id="checkbox" type="checkbox" name=clonelistings><%=r.getString(teasession._nLanguage, "CloneListings")%>
  <input  id="checkbox" type="checkbox" name=clonecssjs><%=r.getString(teasession._nLanguage, "CBClone")%>CssJs
  <input  id="checkbox" type="checkbox" name=clonesons><%=r.getString(teasession._nLanguage, "CloneSons")%>
  <input type="submit"  value="<%=r.getString(teasession._nLanguage, "Submit")%>">
  </td>
  </tr>
  </table>
</FORM>


<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</html>
