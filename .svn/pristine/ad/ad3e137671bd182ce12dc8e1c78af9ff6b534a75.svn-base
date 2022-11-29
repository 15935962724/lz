<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.db.*" %><%@page import="java.util.*" %><%@page import="tea.entity.node.*" %><%@page import="tea.entity.member.*" %>
<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

tea.ui.TeaSession teasession = new tea.ui.TeaSession(request);
if (teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode + "&nexturl=" + request.getRequestURI() + "?" + request.getQueryString());
  return;
}

tea.resource.Resource r=new tea.resource.Resource("/tea/resource/Callboard");

int callboard=0;
String tmp=request.getParameter("callboard");
if(tmp!=null)
{
  callboard=Integer.parseInt(tmp);
}
String subject=null,content=null;
if(callboard!=0)
{
  Callboard c=Callboard.find(callboard);
  subject=c.getSubject(teasession._nLanguage);
  content=tea.html.HtmlElement.htmlToText(c.getContent(teasession._nLanguage));
}

boolean isBg=request.getParameter("bg")!=null;

StringBuffer sql=new StringBuffer();
if(!isBg)
{
  sql.append(" AND member=").append(DbAdapter.cite(teasession._rv._strV));
}
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type=""></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body onload="form1.subject.focus();">

  <h1><%=r.getString(teasession._nLanguage, "Callboard")%></h1>
  <div id="head6"><img height="6" alt=""></div>
    <br>
   <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr id="tableonetr">
       <td><%=r.getString(teasession._nLanguage, "Subject")%></td>
       <td><%//=r.getString(teasession._nLanguage, "Text")%>提交时间</td>
       <td></td>
     </tr>
   <%
   Enumeration enumer=Callboard.find(sql.toString(),0,Integer.MAX_VALUE);
   while(enumer.hasMoreElements())
   {
     int id=((Integer)enumer.nextElement()).intValue();
     Callboard c=Callboard.find(id);
     out.print("<tr onMouseOver=bgColor='#BCD1E9' onMouseOut=bgColor=''>");
     out.print("<td>"+c.getSubject(teasession._nLanguage));
     out.print("<td>"+c.getTimeToString());
     out.print("<td><input type='button' onclick=window.open('?callboard="+id+"&'+location.search.substring(1).replace('callboard=',''),'_self'); value="+r.getString(teasession._nLanguage,"CBEdit")+">");
     out.print("<input type='button' onclick=if(confirm('"+r.getString(teasession._nLanguage, "ConfirmDelete")+"'))window.open('/servlet/EditCallboard?community="+teasession._strCommunity+"&nexturl='+encodeURIComponent(location.href)+'&callboard="+id+"&delete=ON','_self'); value="+r.getString(teasession._nLanguage,"CBDelete")+">");
   }
   %>
   </table>

<h1><%=r.getString(teasession._nLanguage, "Add")%>/<%=r.getString(teasession._nLanguage, "Edit")%></h1>
<div id="head6"><img height="6" alt=""></div>
<br>
<form name="form1" METHOD=POST action="/servlet/EditCallboard" onSubmit="return(submitText(this.subject,'<%=r.getString(teasession._nLanguage, "InvlaidSubject")%>')&&submitText(this.content,'<%=r.getString(teasession._nLanguage, "InvalidText")%>'));">
  <input type="hidden" name="community" value="<%=teasession._strCommunity%>" >
  <input type="hidden" name="callboard" value="<%=callboard%>" >
  <input type="hidden" name="node" value="<%=teasession._nNode%>" >
  <input type="hidden" name="nexturl" value="<%=(request.getRequestURI()+"?"+request.getQueryString()).replaceAll("callboard=","")%>" >

  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Subject")%>:</td>
      <td><input type="text" class="edit_input"  name=subject value="<%if(subject!=null)out.print(subject);%>" size=40 maxlength=40></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Text")%>:</td>
      <td><textarea name="content" cols="50" rows="7"><%if(content!=null)out.print(content.replaceAll("<","&lt;"));%></textarea></td>
    </tr>
    <tr>
      <td>&nbsp;</td>
      <td><input name="submit" class="edit_button"  type="submit"  value="<%=r.getString(teasession._nLanguage, "Submit")%>"></td>
    </tr>
  </table>
</form>

<br>
<div id="head6"><img height="6" alt=""></div>
<%--<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>--%>
</body>
</html>
