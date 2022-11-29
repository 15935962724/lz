<%@page contentType="text/html;charset=UTF-8" %><%@ page import="java.util.*" %><%@ page import="java.math.*" %><%@ page import="tea.entity.member.*" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.*" %><%@ page import="tea.entity.node.*" %><%@ page import="tea.ui.TeaSession" %><% request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String community=teasession._strCommunity;


Resource r=new Resource("/tea/resource/SMS");

String member=teasession._rv.toString();

String content=SMSMessage.findReverseByMember(member,community);

int count=content.split("<tr><td>").length-1;

%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">

  <script type="">
  function fselectall(bool)
  {
    foEdit.smsmessage.checked=bool;
    for (var index=0;index<foEdit.smsmessage.length;index++)
    {
      foEdit.smsmessage[index].checked=bool;
    }
  }

  function fcheck()
  {
    if(foEdit.smsmessage=='[object]'||foEdit.smsmessage=='[object NodeList]')
    {
      if(foEdit.smsmessage.checked)
      return true;
      for (var index=0;index<foEdit.smsmessage.length;index++)
      {
        if(foEdit.smsmessage[index].checked)
        return true;
      }
    }
    alert('无效选择');
    return false;
  }
  </script>
</head>
<body>

   <h1><%=r.getString(teasession._nLanguage, "RecieveList")+" ("+count+")"%></h1>
<br>
<div id="head6"><img height="6" src="about:blank"></div>
<br/>
   <FORM name=foEdit METHOD=POST action="/servlet/EditSMSMessage?node=<%=teasession._nNode%>" onSubmit="">
   <input type="hidden" name="Node" value="<%=teasession._nNode%>"/>
      <input type="hidden" name="type" value="true"/>
     <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
       <tr ID=tableonetr>
         <TD><%=r.getString(teasession._nLanguage, "Number")%></TD>
         <TD><%=r.getString(teasession._nLanguage, "Text")%></TD>
         <TD><%=r.getString(teasession._nLanguage, "Time")%></TD>
       </tr>
       <%=content %>

  </table>

<br>
<div id="head6"><img height="6" src="about:blank"></div>

<%--<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>--%>

</body>
</html>

