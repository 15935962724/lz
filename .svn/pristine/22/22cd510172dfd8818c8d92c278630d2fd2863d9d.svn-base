<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.resource.*"%><%@ page import="tea.entity.*"%><%@ page import="tea.entity.node.*"%><%

request.setCharacterEncoding("UTF-8");

Http h=new Http(request,response);

tea.ui.TeaSession teasession = new tea.ui.TeaSession(request);

Node node=Node.find(h.node);
Link t=Link.find(h.node,h.language);

tea.resource.Resource r = new tea.resource.Resource();

r.add("/tea/resource/Link");

String nexturl=h.get("nexturl");



%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1><%=r.getString(h.language, "CBNewLink")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<div id="pathdiv"><%=node.getAncestor(h.language)%> </div>
<form action="/Links.do" method="post" target="_ajax" onSubmit="return mt.check(this)">
<input type="hidden" name="act" value="edit"/>
<%
boolean LinkType=false;
String subject=null,url=null,logo=null,name=null,email=null,password=null,text=null;
int classes=0, sequence=0;
boolean _bNew=request.getParameter("NewNode")!=null;
if(_bNew)
{
  out.print("<input type='hidden' name=NewNode value=ON>");
  logo=url="http://www.";
}else
{
  sequence=node.getSequence();
  subject=node.getSubject(h.language);
  url=node.getClickUrl(h.language);
  logo=node.getPicture(h.language);
  text=node.getText(h.language);
}
if(nexturl!=null)out.print("<input type='hidden' name='nexturl' value='"+nexturl+"'>");
%>
  <input type='hidden' name="node" value="<%=h.node%>">
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td align="right"><%=r.getString(h.language,"LinkType")%>：</td>
      <td>
        <input id="radio" type="radio" name="type" value="true" checked ><%=r.getString(h.language,"LogoLink")%>　
        <input id="radio" type="radio" name="type" value="false" <%if(!t.type)out.print(" checked ");%>><%=r.getString(h.language,"CharLink")%> </td>
    </tr>
    <tr>
      <td align="right" valign="middle"><%=r.getString(h.language,"al.Subject")%>：</td>
      <td><input name="subject" value="<%=MT.f(subject)%>" alt="<%=r.getString(h.language,"al.Subject")%>" size="30" maxlength="200">
        <font color="#FF0000"> *</font></td>
    </tr>
    <tr>
      <td align="right"><%=r.getString(h.language,"URL")%>：</td>
      <td><input name="url" size="30"  maxlength="500" value="<%=url%>" alt="<%=r.getString(h.language,"URL")%>">
        <font color="#FF0000">*</font></td>
    </tr>
    <tr>
      <td align="right">Logo：</td>
      <td><input name="logo" size="30"  maxlength="500" value="<%=logo%>" title="">100 X 32 </td>
    </tr>
    <tr>
      <td align="right">E-Mail：</td>
      <td><input name="email" type="text" value="<%=MT.f(t.email)%>" size="30"  maxlength="80"></td>
    </tr>
    <tr>
      <td align="right"><%=r.getString(h.language,"Username")%>：</td>
      <td><input name="name" type="text" value="<%=MT.f(t.name)%>" size="30"  maxlength="50"></td>
    </tr>
    <tr>
      <td align="right"><%=r.getString(h.language,"Type")%>：</td>
      <td valign="middle">
        <%
        tea.html.DropDown dd=new tea.html.DropDown("classes",t.classes);
        for(int index=0;index<Link.CLASSES_TYPE.length;index++)
        {
          dd.addOption(index,Link.CLASSES_TYPE[index]);
        }
        out.println(dd.toString());
        %></td>
    </tr>
     <tr>
      <td align="right"><%=r.getString(h.language,"顺序")%>：</td>
      <td><input name="sequence" value="<%=sequence%>" ></td>
    </tr>
    <tr>
      <td align="right"><%=r.getString(h.language,"Text")%>：</td>
      <td valign="middle"><textarea name="text" cols="40" rows="5" id="SiteIntro" title=""><%=MT.f(text)%></textarea></td>
    </tr>
<%--
    <tr><td><%=r.getString(h.language,"Note")%></td></tr>
    <tr><td colspan="2"><hr size="1"/></tr>
    <tr>
      <td align="right"><%=r.getString(h.language,"Password")%>：</td>
      <td><input name="password" type="password" id="SitePassword3" value="<%//if(password!=null)out.print(password);%>" size="20" maxlength="20">
        <font color="#FF0000">*</font></td>
    </tr>
    <%
    if(_bNew)
    {
     out.print("<tr><td align=right>"+r.getString(h.language,"ConfirmPassword")+"：</td>");
     out.print("<td><input name=SitePwdConfirm type=password size=20 maxlength=20 ><font color=#FF0000>*</font></td></tr>");
    }
    %>
<%
        if(!_bNew)out.print("<input type='Submit' value="+r.getString(h.language,"Delete")+" name='delete'  onClick=\"return confirm('"+r.getString(h.language,"ConfirmDelete")+"');\">");
        %>
--%>
</table>
<center>
<input type="Submit" value="<%=r.getString(h.language,"Submit")%>" name="cmdOk">
<input type="reset" value="<%=r.getString(h.language,"Reset")%>" name="cmdReset">
<input type="button" value="<%=r.getString(h.language,"Back")%>" onclick="history.back()">
</center>
</form>

<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
