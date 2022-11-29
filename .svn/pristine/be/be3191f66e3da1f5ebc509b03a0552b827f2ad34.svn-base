<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="java.util.*" %>
<%@page import="java.net.*" %>
<%@page import="tea.resource.Resource" %>
<%@page import="tea.ui.*" %>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.entity.site.*" %>
<%@page import="tea.entity.util.*" %>
<% request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+request.getRequestURI()+"?"+request.getQueryString());
  return;
}

if(!teasession._rv.isWebMaster() && !teasession._rv.isOrganizer(teasession._strCommunity))
{
  response.sendError(403);
  return;
}

Resource r=new Resource("/tea/resource/DNS");

String domainname=request.getParameter("domainname");
int dnscity=0;
String tmp=request.getParameter("dnscity");
if(tmp!=null)
{
  dnscity=Integer.parseInt(tmp);
}
int city=0;
String url="";
if(dnscity>0)
{
  DNSCity dc=DNSCity.find(dnscity);
  domainname=dc.getDomainname();
  city=dc.getCity();
  url=dc.getUrl();
}

String ip=request.getRemoteAddr();
out.print("<!--"+NodeAccessWhere.findByIp(ip)+"-->");

%><html>
<head>
<link href="/tea/community.css" rel="stylesheet" type="text/css">
<script LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type="text/javascript"></script>
<script LANGUAGE=JAVASCRIPT SRC="/tea/card.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<body onLoad="form1.url.focus();">

<h1><%=r.getString(teasession._nLanguage, "DomainName")+domainname%></h1>

 <div id="head6"><img height="6" src="about:blank"></div>


   <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr ID=tableonetr>
       <td width="1">&nbsp;</td>
       <td>城市</td>
       <td>网址</td>
       <td></td>
     </tr>
   <%
   Enumeration e= DNSCity.findByDomainname(domainname);
   for(int i=1;e.hasMoreElements();i++)
   {
     DNSCity dc=(DNSCity)e.nextElement();
     int id=dc.getDNSCity();
     String u=dc.getUrl();
     out.print("<tr onMouseOver=\"bgColor='#BCD1E9'\" onMouseOut=\"bgColor=''\">");
     out.print("<td>"+i);
     out.print("<td>"+Card.find(dc.getCity()).toString());
     out.print("<td><a href="+u+">"+u+"</a>");
     out.print("<td><input type='button' value='"+r.getString(teasession._nLanguage, "CBEdit")+"' onclick=\"window.open('?dnscity="+id+"', '_self');\" />");
     out.print("<input type='button' value='"+r.getString(teasession._nLanguage, "CBDelete")+"' onclick=\"if(confirm('"+r.getString(teasession._nLanguage, "ConfirmDelete")+"')){ form1.act.value='deletednscity'; form1.dnscity.value='"+id+"'; form1.submit(); }\" />");
   }
   %>
   </table>
   <br>


<form name="form1" action="/servlet/EditDNS" onSubmit="return(submitInteger(this.city0,'<%=r.getString(teasession._nLanguage, "InvlaidNode")%>')&&submitText(this.url,'<%=r.getString(teasession._nLanguage, "InvalidName")%>'));">
<input type="hidden" name="act" value="editdnscity"/>
<input type="hidden" name="dnscity" value="<%=dnscity%>"/>
<input type="hidden" name="domainname" value="<%=domainname%>"/>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td><%=r.getString(teasession._nLanguage, "City")%>:</td>
    <td><script type="">selectcard("city0","city1",null,"<%=city%>");</script></td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "URL")%>:</td>
    <td><input type="text"  name="url"  value="<%=url%>" size="40" maxlength="128">
    </td>
  </tr>
</table>
<input type="submit" value="<%=r.getString(teasession._nLanguage, "Submit")%>" onclick="">
<input type="button" value="<%=r.getString(teasession._nLanguage, "CBBack")%>" onclick="window.open('/jsp/site/EditDNS.jsp?community=Home','_self');"/>
</form>



<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</html>
