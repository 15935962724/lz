<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.entity.*"%><%@ page import="tea.db.DbAdapter" %><%@ page import="tea.resource.*" %><%@ page import="tea.entity.site.License" %><%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}
License license = License.getInstance();
if(!teasession._rv._strR.equals(teasession._rv._strV) && !teasession._rv._strR.equals(license.getWebMaster()))
{
  response.sendError(403);
  return;
}


Resource r=new Resource("/tea/ui/site/EditLicense");


tea.entity.node.AccessMember am = null;
if (teasession._rv != null)
{

  am = tea.entity.node.AccessMember.find(teasession._nNode, teasession._rv._strV);

}

Http h=new Http(request,response);


tea.entity.node.Node node = tea.entity.node.Node.find(teasession._nNode);
String nr = tea.ui.node.general.NodeServlet.getButton(node,h,am,request);

%>
<html>
<head>
<link href="/tea/tea.css" rel="stylesheet" type="text/css"/>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<%=nr%>
<h1><%=r.getString(teasession._nLanguage, "EditLicense")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<FORM name=foEdit METHOD=POST action="/servlet/EditLicense" target="_ajax" onSubmit="return mt.check(this);">
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr>
  <td><%=r.getString(teasession._nLanguage, "License")%>:</td>
  <td><input type="TEXT" class="edit_input" name="license" VALUE="<%=license.getLicense()%>" alt="<%=r.getString(teasession._nLanguage, "License")%>"></td>
</tr>

<!--
<tr><td><%=r.getString(teasession._nLanguage, "WebSite")%>:</td>
<td><input type="TEXT" class="edit_input"  name="website" VALUE="<%=license.getWebSite()%>" SIZE=40 MAXLENGTH=40></td></tr>
-->
<tr>
  <td><%=r.getString(teasession._nLanguage, "WebMaster")%>(<%=r.getString(teasession._nLanguage, "MemberId")%>):</td>
  <td><input type="TEXT" class="edit_input" readonly name=WebMaster VALUE="<%=license.getWebMaster()%>" SIZE=40 MAXLENGTH=40></td>
</tr>
<tr>
  <td><%=r.getString(teasession._nLanguage, "Sitemap")%>:</td>
  <td><input type="TEXT" class="edit_input"  name=website VALUE="<%=license.getWebSite()%>" SIZE=40 MAXLENGTH=40></td>
</tr>
<!--
<tr><td><%=r.getString(teasession._nLanguage, "WebSupport")%>(<%=r.getString(teasession._nLanguage, "EmailAddress")%>):</td>
<td>
<input type="TEXT" class="edit_input"  name=WebSupport VALUE="<%=license.getWebSupport()%>" SIZE=40 MAXLENGTH=40></td></tr><tr><td><%=r.getString(teasession._nLanguage, "SmtpServer")%>:</td>
<td>
<input type="TEXT" class="edit_input"  name=SmtpServer VALUE="<%=license.getSmtpServer()%>" SIZE=40 MAXLENGTH=40></td></tr -->

<tr>
<%-- if(license.getSmtpServer().equalsIgnoreCase("localhost")){%>

	<input type="TEXT" class="edit_input"  name=SmtpServer VALUE="<%=InetAddress.getLocalHost().getHostAddress()%>" SIZE=40 MAXLENGTH=40></td>
<% }else{%>
	<input type="TEXT" class="edit_input"  name=SmtpServer VALUE="<%=license.getSmtpServer()%>" SIZE=40 MAXLENGTH=40></td>
}%}
--%>

<tr><td colspan=2><hr size="1" noshade></td></tr>
<tr><td><%=r.getString(teasession._nLanguage, "LocalHost")%>:</td><td><%=java.net.InetAddress.getLocalHost().getHostAddress()%></td></tr>
<tr><td><%=r.getString(teasession._nLanguage, "SerialNumber")%>:</td><td><%=license.getSerialNumber()%></td></tr>
<tr><td><%=r.getString(teasession._nLanguage, "RegistrationDate")%>:</td><td><%=Entity.sdf.format(license.getRegistrationDate())%></td></tr>
<tr><td><%=r.getString(teasession._nLanguage, "ExpirationDate")%>:</td><td><%=Entity.sdf.format(license.getExpirationDate())%></td></tr>
<tr><td><%=r.getString(teasession._nLanguage, "NumberOfCommunity")%>:</td><td><%=Integer.valueOf(license.getNumberOfCommunity())%></td></tr>
<tr>
  <td><%=r.getString(teasession._nLanguage,"Languages")%>:</td>
  <td>
  <%
  int lang=license.getWebLanguages();
  for(int i=0;i<Common.LANGUAGE.length;i++)
  {
    out.print("<input type='checkbox' name='language' value='"+i+"' id='language"+i+"' alt='"+r.getString(teasession._nLanguage,"Languages")+"'");
    if((lang&1<<i)!=0)out.print(" checked ");
    out.print("><label for='language"+i+"'>"+r.getString(teasession._nLanguage,Common.LANGUAGE[i])+"</label>　");
  }
  %>
  </td>
</tr>
<tr>
  <td>定时器是否开启:</td>
  <td>
    <input type="CHECKBOX" name="Listenertype" value="1" <%if(license.getListenertype()!=null && license.getListenertype().indexOf("/1/")!=-1)out.print(" checked "); %> >生日短信发送进程&nbsp;
    <input type="CHECKBOX" name="Listenertype" value="2" <%if(license.getListenertype()!=null && license.getListenertype().indexOf("/2/")!=-1)out.print(" checked "); %> >活动到期扫描进程&nbsp;
    <input type="CHECKBOX" name="Listenertype" value="3" <%if(license.getListenertype()!=null && license.getListenertype().indexOf("/3/")!=-1)out.print(" checked "); %> >电子报应用封面定时抓取进程
  </td>
</tr>


<tr>
  <td></td>
  <td><input type="submit" class="edit_button" id="edit_submit"  value="<%=r.getString(teasession._nLanguage, "Submit")%>"></td>
</tr>
</table>
</FORM>


<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</html>
