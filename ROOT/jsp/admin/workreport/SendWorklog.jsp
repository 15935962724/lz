<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.ui.admin.*" %><%@ page import="tea.db.DbAdapter" %><%@ page import="tea.entity.*" %><%@ page import="tea.entity.member.*" %><%@ page  import="tea.resource.Resource"  %><%@ page  import="tea.entity.admin.*" %><%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String community=teasession._strCommunity;


Resource r=new Resource("/tea/resource/Workreport");

Profile profile=Profile.find(teasession._rv._strV);
String subject=profile.getLastName(teasession._nLanguage)+profile.getFirstName(teasession._nLanguage)+" 于 "+Entity.sdf.format(new java.util.Date())+"的工作日志";


String tmps[]=request.getParameterValues("worklog");
if(tmps==null)
{
  response.sendRedirect("/jsp/info/Alert.jsp?info="+java.net.URLEncoder.encode("至少选中一个...","UTF-8"));
  return;
}
int worklogs[]=new int[tmps.length];
for(int i=0;i<tmps.length;i++)
{
  worklogs[i]=Integer.parseInt(tmps[i]);
} 

String tomember="";
StringBuffer inbox=new StringBuffer();
AdminUsrRole aur=AdminUsrRole.find(teasession._strCommunity,teasession._rv._strV);

java.util.Enumeration e=AdminUsrRole.find(teasession._strCommunity," AND member!="+DbAdapter.cite(teasession._rv._strV)+" AND classes LIKE "+DbAdapter.cite("%/"+aur.getUnit()+"/%"),0,Integer.MAX_VALUE);
while(e.hasMoreElements())
{
  tomember=(String) e.nextElement();
  inbox.append(tomember).append(";");
}


String url="http://"+request.getServerName()+":"+request.getServerPort()+"/jsp/admin/workreport/Worklogs_4.jsp;jsessionid="+session.getId()+"?member="+java.net.URLEncoder.encode(teasession._rv._strV,"UTF-8")+"&tomember="+java.net.URLEncoder.encode(tomember,"UTF-8")+"&"+request.getQueryString();

String html=EditWorkreport.content(community,1,tomember,new String[]{teasession._rv._strV},worklogs,null);

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<script type="">
function fsubmit()
{
  if(form1.inbox_up.value==''&&form1.inbox_colleague.value==''&&form1.inbox_member.value==''&&form1.inbox_email.value=='')
  {
    alert("收件箱-上级,同事,会员,通讯录 至少填写一项.");
    form1.inbox_up.focus();
    return false;
  }
  return submitText(form1.subject,'<%=r.getString(teasession._nLanguage,"Subject")%>');
}

function LoadWindow(obj,type,field)
{
  loc_x=document.body.scrollLeft+event.clientX-event.offsetX-100;
  loc_y=document.body.scrollTop+event.clientY-event.offsetY+210;
  if(window.Event)
  {
    window.open("/jsp/sms/psmanagement/FrameGU.jsp?index="+obj+"&type="+type+"&field="+field,self,"edge:raised;scroll:0;status:0;help:0;resizable:1;dialogWidth:400px;dialogHeight:320px;dialogTop:"+loc_y+"px;dialogLeft:"+loc_x+"px");
  }else
  {
    window.showModalDialog("/jsp/sms/psmanagement/FrameGU.jsp?index="+obj+"&type="+type+"&field="+field,self,"edge:raised;scroll:0;status:0;help:0;resizable:1;dialogWidth:400px;dialogHeight:320px;dialogTop:"+loc_y+"px;dialogLeft:"+loc_x+"px");
  }
}
</script>
</head>
<body onLoad="form1.inbox_up.focus();">
<!--发送邮件-->
<h1><%=r.getString(teasession._nLanguage,"1168829505147")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br>

   <form name="form1" METHOD="get" action="/servlet/EditWorkreport" onSubmit="return fsubmit();">
     <input type=hidden name="community" value="<%=community%>"/>
     <input type=hidden name="nexturl" value="<%=request.getParameter("nexturl")%>"/>
     <input type=hidden name="action" value="sendworklog"/>
     <%

     if(worklogs!=null)
     {
       for(int i=0;i<worklogs.length;i++)
       {
         out.print("<input type=hidden name=worklog value="+worklogs[i]+" >");
       }

     }
     %>


   <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr><td><%=r.getString(teasession._nLanguage,"1168840467531")%><!--=收件箱(上级)--></td><td><input name="inbox_up" size="60" value="<%=inbox.toString()%>"><input type="button" value="..." onclick="LoadWindow('form1.inbox_up',1,'member');"/></td></tr>
     <tr><td><%=r.getString(teasession._nLanguage,"1173456221421")%><!--=收件箱(同事)--></td><td><input name="inbox_colleague" size="60" value=""><input type="button" value="..." onclick="LoadWindow('form1.inbox_colleague',1,'member');"/></td></tr>
     <tr><td><%=r.getString(teasession._nLanguage,"1173456221422")%><!--=收件箱(会员)--></td><td><input name="inbox_member" size="60" value=""></td></tr>
     <tr><td><%=r.getString(teasession._nLanguage,"1173456221423")%><!--=收件箱(通讯录)--></td><td><input name="inbox_email" size="60" value=""><input type="button" value="..." onclick="LoadWindow('form1.inbox_email',0,'email');"/></td></tr>
     <tr><td><%=r.getString(teasession._nLanguage,"Subject")%></td>
       <td><input name="subject" size="60" value="<%=subject%>"></td></tr>
     <tr>
       <td><%=r.getString(teasession._nLanguage,"Text")%></td>
       <td>
         <iframe width="600" height="400" src="about:blank" id="ifr"></iframe>
         <script type="">
         ifr.document.open();
         ifr.document.write("<%=html.replaceAll("\\r\\n","\\\\r\\\\n").replaceAll("\"","\\\\\"")%>");
         ifr.document.close();
         </script>
       </td>
     </tr>
   </table>
   <input type="submit" value="<%=r.getString(teasession._nLanguage,"Submit")%>"  onclick="">
   <input type="button" value="<%=r.getString(teasession._nLanguage,"CBBack")%>" onClick="history.back();" >
</form>

<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
