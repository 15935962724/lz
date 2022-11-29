<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.Resource"  %><%@ page  import="tea.entity.admin.*" %><%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String community=teasession._strCommunity;

Resource r=new Resource("/tea/resource/Workreport");


int worktype=0;
if(request.getParameter("worktype")!=null)
{
  worktype=Integer.parseInt(request.getParameter("worktype"));
}
String name=null;
if(worktype>0)
{
  Worktype obj=Worktype.find(worktype);
  name=obj.getName(teasession._nLanguage);
}


%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<body onload="form1.name.focus();">
<!--工作类型管理-->
<h1><%=r.getString(teasession._nLanguage,"1168592903312")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br>

   <form name=form1 METHOD=get action="/servlet/EditWorkreport" onSubmit="return submitText(this.name,'<%=r.getString(teasession._nLanguage,"InvalidSubject")%>')">
     <input type=hidden name="community" value="<%=community%>"/>
     <input type=hidden name="worktype" value="<%=worktype%>"/>
     <input type=hidden name="nexturl" value="<%=request.getParameter("nexturl")%>"/>
     <input type=hidden name="action" value="editworktype"/>


   <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr><td><%=r.getString(teasession._nLanguage,"1168575002906")%><!--名称--></td><td><input name="name" size="40"  value="<%if(name!=null)out.print(name);%>"></td></tr>
   </table>
   <input type="submit" value="<%=r.getString(teasession._nLanguage,"Submit")%>" >
   <input type="button" value="<%=r.getString(teasession._nLanguage,"CBBack")%>" onclick="history.back();" >
</form>

<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>



