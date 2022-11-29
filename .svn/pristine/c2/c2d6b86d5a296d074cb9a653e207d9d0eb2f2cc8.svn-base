<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.entity.*"%>
<%@page import="java.util.*" %>
<%@page import="java.net.*" %>
<%@page import="java.io.*" %>
<%@page import="tea.resource.Resource" %>
<%@page import="tea.ui.*" %>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.entity.site.*" %>
<%@page import="tea.entity.util.*" %>
<%@page import="tea.ui.node.general.*" %>
<% request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);

AccessMember am=AccessMember.find(teasession._nNode, teasession._rv);
if(teasession._rv!=null&&!teasession._rv.isWebMaster() && !teasession._rv.isOrganizer(teasession._strCommunity))
{
  response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
  return;
}

Resource r=new Resource("/tea/resource/DNS");

Http h=new Http(request,response);


String act=request.getParameter("act");

%><html>
<head>
<link href="/tea/tea.css" rel="stylesheet" type="text/css"/>
<link href="/tea/community.css" rel="stylesheet" type="text/css">
<script LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<script type="">
var old;
function f_showtb(id)
{
  if(old)old.style.display="none";
  var tb=document.getElementById("tb"+id);
  if(tb)
  {
    tb.style.display="";
    old=tb;
  }
}
</script>
</head>
<body onLoad="try{ form1.exid.focus(); }catch(e){ f_showtb(0); form1.subject.focus(); }">
<%=NodeServlet.getButton(Node.find(teasession._nNode),h,am,request)%>
<h1><%=r.getString(teasession._nLanguage, "Template")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<%
if(act==null)
{
  int example=Integer.parseInt(request.getParameter("example"));
  Example e=Example.find(example);
  String pic=e.getPicture();
%>
<form name="form1" action="/servlet/EditExample" method="post" enctype="multipart/form-data" onSubmit="return(submitText(this.subject,'<%=r.getString(teasession._nLanguage, "InvalidSubject")%>'));">
<input type="hidden" name="act" value="edit"/>
<input type="hidden" name="example" value="<%=example%>"/>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td><%=r.getString(teasession._nLanguage, "Subject")%>:</td>
    <td colspan="2"><input type="text" name="subject" value="<%=e.getSubject()%>" size="50"/></td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "缩略图")%>:</td>
    <td colspan="2"><input type="file" name="picture" size="40">
    <%
    if(pic!=null)
    {
      int len=(int)new File(application.getRealPath(pic)).length();
      if(len>0)
      {
        out.print("<a href=\"javascript:showImg('"+pic+"')\">"+len+r.getString(teasession._nLanguage, "Bytes")+"</a>");
        out.print("<input name='clear' type='checkbox' onclick=\"form1.picture.disabled=checked;form1.picture.style.backgroundColor=checked?'#ccc':''\">"+r.getString(teasession._nLanguage, "Clear"));
      }
    }
    %>
    </td>
  </tr>
</table>

<input type="submit" value="<%=r.getString(teasession._nLanguage, "Submit")%>">
<input type="button" value="<%=r.getString(teasession._nLanguage, "CBBack")%>" onclick="history.back()"/>
</form>



<%
}else if(act.equals("step1"))
{
%>
<form name="form1" action="?" onSubmit="return(submitInteger(this.exid,'<%=r.getString(teasession._nLanguage, "InvalidListingNumber")%>'));">
<input type="hidden" name="act" value="step2"/>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td><%=r.getString(teasession._nLanguage, "ID号")%>:</td>
    <td><input type="text" name="exid" mask="int" /></td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "类型")%>:</td>
    <td>
      <input name="extype" type="radio" value="C">CSS
      <input name="extype" type="radio" value="S" checked="checked"><%=r.getString(teasession._nLanguage,"Section")%>
      <input name="extype" type="radio" value="L"><%=r.getString(teasession._nLanguage,"Listing")%>
    </td>
  </tr>

</table>

<input type="submit" value="<%=r.getString(teasession._nLanguage, "Submit")%>" onclick="">
<input type="button" value="<%=r.getString(teasession._nLanguage, "CBBack")%>" onclick="history.back()"/>
</form>

<%
}else if(act.equals("step2"))
{
  String exid=request.getParameter("exid");
  String extype=request.getParameter("extype");

%>
<form name="form1" action="/servlet/EditExample" method="post" enctype="multipart/form-data" onSubmit="return(this.type[0].checked&&submitText(this.subject,'<%=r.getString(teasession._nLanguage, "InvalidSubject")%>'))||(this.type[1].checked&&submitInteger(this.example,'<%=r.getString(teasession._nLanguage, "InvalidSubject")%>'));">
<input type="hidden" name="act" value="edit"/>
<input type="hidden" name="extype" value="<%=extype%>"/>
<input type="hidden" name="exid" value="<%=exid%>"/>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td><%=r.getString(teasession._nLanguage, "选择类型")%>:</td>
    <td><input type="radio" name="type" value="0" onclick="f_showtb(value)" checked="checked"/>添加新的模板</td>
    <td><input type="radio" name="type" value="1" onclick="f_showtb(value)" />插入到已存在的模板中</td>
  </tr>
<tbody id="tb0" style="display:none">
  <tr>
    <td><%=r.getString(teasession._nLanguage, "Subject")%>:</td>
    <td colspan="2"><input type="text" name="subject" value="" size="50"/></td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "缩略图")%>:</td>
    <td colspan="2"><input type="file" name="picture" size="40"></td>
  </tr>
</tbody>
<tbody id="tb1" style="display:none">
  <tr>
    <td><%=r.getString(teasession._nLanguage, "模板号")%>:</td>
    <td colspan="2">
      <input type="text" name="example" value="" mask="int"/>
      <select onchange="form1.example.value=value;">
        <option value="">-----------------</option>
        <%
        ArrayList ee= Example.find("",0,Integer.MAX_VALUE);
        for(int i=0;i<ee.size();i++)
        {
          Example e=(Example)ee.get(i);
          int id=e.getExample();
          String subject=e.getSubject();
          out.print("<option value='"+id+"'>"+subject);
        }
        %>
        </select>
    </td>
  </tr>
</tbody>

</table>

<input type="submit" value="<%=r.getString(teasession._nLanguage, "Submit")%>" onclick="">
<input type="button" value="<%=r.getString(teasession._nLanguage, "CBBack")%>" onclick="history.back()"/>
</form>
<%
}
%>

<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</html>
