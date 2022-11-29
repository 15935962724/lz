<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="java.util.*" %>
<%@page import="java.net.*" %>
<%@page import="tea.resource.Resource" %>
<%@page import="tea.ui.*" %><%@page import="tea.entity.*" %>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.entity.site.*" %>
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


String title=r.getString(teasession._nLanguage, "DomainNameBangding");
%><html>
<head>
<title><%=title%></title>
<link href="/tea/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<script type="">
function fedit(obj,value)
{
  for(var index=0;index<obj.length;index++)
  {
    if(obj.options[index].value==value)
    {
      obj.options[index].selected=true;
      break;
    }
  }
}
function submitURL(obj,alerttext)
{
  if (obj.value.length == 0)
  {
    alert(alerttext);
    obj.focus();
    return false;
  }
  return true;
}
</script>
</head>
<body onLoad="form1.domainname.focus();">

<h1><%=title%></h1>

<div id="head6"><img height="6" src="about:blank"></div>

  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr ID=tableonetr>
      <td width="1">&nbsp;</td>
      <td><%=r.getString(teasession._nLanguage, "Community")%></td>
      <td><%=r.getString(teasession._nLanguage, "DomainName")%></td>
      <td><%=r.getString(teasession._nLanguage, "Node")%></td>
      <td>&nbsp;</td>
    </tr>
   <%
   Enumeration enumer= DNS.find(" AND url IS NULL AND status="+teasession._nStatus,0,200);
   for(int i=1;enumer.hasMoreElements();)
   {
     String name=(String)enumer.nextElement();
     DNS d = DNS.find(name);
     String community=d.getCommunity();
     if(community!=null&&Community.find(community).getNode()>0)
     {

         name=name.replaceAll("%", "*");
     %>
     <tr onMouseOver=bgColor='#BCD1E9' onMouseOut=bgColor='' style="<%if(!d.isOK())out.print("color:red");%>">
     <td width="1"><%=i++%></td>
     <td><%=d.getCommunity()%></td>
     <td><%=name%></td>
     <td><%=d.getNode()%></td>
     <td><input type="button" value="<%=r.getString(teasession._nLanguage, "CBEdit")%>" onClick="fedit(form1.community,'<%=d.getCommunity()%>');form1.node.value='<%=d.getNode()%>';form1.gkey.value='<%=MT.f(d.gkey)%>';form1.domainname.value='<%=name%>';form1.domainname.style.color='#999999';form1.node.focus();"/>
     <%
     if(!"*".equals(name))
     {
       out.print("<input type='button' name='delete' value="+r.getString(teasession._nLanguage, "CBDelete")+" onclick=\"if(confirm('"+r.getString(teasession._nLanguage, "ConfirmDelete")+"')){window.open('/servlet/EditDNS?domainname="+name+"&delete=ON', '_self'); this.disabled=true; }\" />");
       out.print("<input type='button' value="+r.getString(teasession._nLanguage, "City")+" onclick=\"window.open('/jsp/site/DNSCitys.jsp?domainname="+name+"', '_self');\" />");
     }
     %></td>
    </tr>
     <%
     }
   }
   %>
   <br/>
   </table>
   <br>

   <FORM name=form1 METHOD=POST action="/servlet/EditDNS" onSubmit="return(submitInteger(this.node,'<%=r.getString(teasession._nLanguage, "InvlaidNode")%>')&&submitText(this.domainname,'<%=r.getString(teasession._nLanguage, "InvalidName")%>'));">
     <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
       <tr>
         <td><%=r.getString(teasession._nLanguage, "Community")%>:</td>
         <td>
           <select name="community">
           <%
           enumer= Organizer.findOrganizing(teasession._rv);
           while(enumer.hasMoreElements())
           {
             String name=(String)enumer.nextElement();
             out.print("<option value="+name);
             if(name.equals(teasession._strCommunity))
             out.print(" selected");
             out.print(">"+name);
           }
           %>
           </select>
         </td>
       </tr>
       <tr>
         <td><%=r.getString(teasession._nLanguage, "DomainName")%>:</td>
         <td><input type="TEXT"  name=domainname onkeypress="if(event.keyCode==32)event.returnValue=false;" onKeyDown="onfocus();" onfocus="if(this.style.color=='#999999')form1.node.focus();"  value="" size=40 maxlength=128>
         </td>
       </tr>
       <tr>
         <td><%=r.getString(teasession._nLanguage, "Node")%>:</td>
         <td><input type="TEXT" name="node" mask="int" value="0"></td>
       </tr>
       <tr>
         <td>Google Key:</td>
         <td><input type="TEXT" name="gkey" value=""></td>
       </tr>
       <tr>
         <td>&nbsp;</td>
         <td><input name="submit"  type="submit" value="<%=r.getString(teasession._nLanguage, "Submit")%>"></td>
       </tr>
     </table>
   </FORM>

<h1>URL转向</h1>
<div id="head6"><img height="6" src="about:blank"></div>
   <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
       <tr ID=tableonetr>
         <td width="1">&nbsp;</td>
         <td>域名</td>
         <td>URL</td>
         <td>类型</td>
         <td>&nbsp;</td>
       </tr>
   <%
   java.util.Enumeration enumer2= DNS.find(" AND url IS NOT NULL",0,200);
   for(int i=1;enumer2.hasMoreElements();i++)
   {
     String name=(String)enumer2.nextElement();
     DNS d = DNS.find(name);
     %>
     <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
       <td width="1"><%=i%></td>
       <td><%=name%></td>
       <td><%=d.getUrl()%></td>
       <td><%=d.getNode()==-1?"不隐藏URL":"隐藏URL"%></td>
       <td>
         <input type="button" value="<%=r.getString(teasession._nLanguage, "CBEdit")%>" onClick="form2.url.value='<%=d.getUrl()%>';if(<%=d.getNode()%>==-1){form2.node[0].checked=true;}else {form2.node[1].checked=true;}form2.domainname.value='<%=name%>';form2.domainname.style.color='#999999';form2.community.focus();"/>
         <input type="button" name="delete" value="<%=r.getString(teasession._nLanguage, "CBDelete")%>" onClick="if(confirm('<%=r.getString(teasession._nLanguage, "ConfirmDelete")%>')){window.open('/servlet/EditDNS?domainname=<%=name%>&delete=ON', '_self'); this.disabled=true;};"/>
       </td>
     </tr>
     <%
   }
   %>
   <br/>
   </table>
   <br>
   <FORM name=form2 METHOD=POST action="/servlet/EditDNS" onSubmit="return(submitURL(this.domainname,'<%=r.getString(teasession._nLanguage, "InvalidName")%>')&&submitURL(this.community,'<%=r.getString(teasession._nLanguage, "InvalidName")%>'));">
     <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
       <tr>
         <td><%=r.getString(teasession._nLanguage, "DomainName")%>:</td>
         <td><input name="domainname" onKeyDown="onfocus();" onFocus="if(this.style.color=='#999999')form2.community.focus();" value="" size=40 maxlength=128>
         </td>
       </tr>
       <tr>
         <td>URL:</td>
         <td><input type="TEXT" name="url" value="http://" size=40 maxlength=128>
         </td>
       </tr>
       <tr>
         <td><%=r.getString(teasession._nLanguage, "Type")%>:</td>
         <td><input  id="radio" type="radio" checked="checked" name=node value="-1">不隐藏URL
         <input  id="radio" type="radio"  name=node value="-2">隐藏URL</td>
       </tr>
       <tr>
         <td>&nbsp;</td>
         <td><input name="submit"  type="submit"  value="<%=r.getString(teasession._nLanguage, "Submit")%>"></td>
       </tr>
     </table>
   </FORM>
<br>

<div id="head6"><img height="6" src="about:blank"></div>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr><td>注:</td></tr>
<tr><td>1. 如果一个社区多个域名,请在"域名"中指定一个域名作为主域名.其它域名请在"URL转向"中指定.</td></tr>
</table>
<%--<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>--%>
</body>
</html>

