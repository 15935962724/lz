<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter"  %>
<%@page import="tea.resource.Resource" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.site.*" %>
<%@page import="tea.ui.TeaSession" %>
<%@page import="java.util.*"%><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

Resource r=new Resource("/tea/resource/Other");

CommunityOption obj=CommunityOption.find(teasession._strCommunity);
String mb=obj.get("msgboptions");
if(mb==null)mb="/";

String OP[]={"","验正码"};

%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type=""></SCRIPT>
<script src="/tea/mt.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script>
function f_submit()
{
  var v="/";
  var o1=form1.options;
  for(var i=0;i<o1.length;i++)
  {
    if(o1[i].checked)
    {
      v=v+o1[i].value+"/";
    }
  }
  form1.msgboptions.value=v;
}
</script>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "留言板设置")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" action="/servlet/EditCommunityOption" method="post" target="_ajax" onsubmit="return f_submit();">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="name" value="/msgboptions/">
<input type="hidden" name="msgboptions" value="<%=mb%>">
<input type="hidden" name="options">

<table cellpadding="0" cellspacing="0" border="0" id="tablecenter">
  <tr>
    <td><%=r.getString(teasession._nLanguage,"Options")%></td>
    <td>
    <%
    for(int i=1;i<OP.length;i++)
    {
      out.print("<input name='options' type='checkbox' value='"+i+"'");
      if(mb.indexOf("/"+i+"/")!=-1)
      {
        out.print(" checked='true'");
      }
      out.print(">"+OP[i]);
    }
    %>
    </td>
  </tr>
</table>

<input type="submit" class="edit_input" value="<%=r.getString(teasession._nLanguage,"Submit")%>">
</form>

<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</html>
