<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.db.DbAdapter"  %><%@page import="tea.resource.Resource" %><%@page import="tea.entity.admin.*" %><%@page import="tea.entity.member.*" %><%@page import="tea.entity.site.*" %><%@page import="tea.entity.node.*" %><%@page import="tea.ui.TeaSession" %><%@page import="java.util.*"%><%
request.setCharacterEncoding("UTF-8");


TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}


Resource r=new Resource("/tea/resource/Other");

String member=teasession._rv._strV;
Profile p=Profile.find(member);
String msnid=p.getMsnID();

boolean ok=(msnid!=null&&msnid.length()>0);

%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type=""></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="">
function f_act(act,member)
{
  if(act=="del")
  {
    if(!confirm('确定删除您的「即时洽谈设定」吗？'))return false;
  }
  form1.act.value=act;
  form1.action=form1.action+"?member="+encodeURIComponent(member);
  form1.submit();
}
</script>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "设置 Windows Live Messenger 即时消息控件")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" action="/servlet/EditMsn" method="post">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="act" value="edit"/>
<input type="hidden" name="nexturl"/>
<script type="">
form1.nexturl.value=location;
</script>

<table cellpadding="0" cellspacing="0" border="0" id="tablecenter">
  <tr id="tableonetr">
    <td width="1">&nbsp;</td>
    <td>状态</td>
    <td>操作</td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage,"即时洽谈")%></td>
    <td><%=ok?"<img src='http://messenger.services.live.com/users/"+msnid+"/presenceimage/' />已设定":"未设定"%></td>
    <td>
    <%
    if(ok)
    {
      out.print("<input type='button' value='编辑' onclick=f_act('edit','"+member+"');> ");
      out.print("<input type='button' value='删除' onclick=f_act('del','"+member+"');> ");
      out.print("<input type='button' value='测试' onclick=window.open('http://settings.messenger.live.com/Conversation/IMMe.aspx?invitee="+msnid+"&mkt=zh-cn','','width=500px,height=400px')>");
    }
    %>
    </td>
  </tr>
</table>
<%
if(!ok)
{
  %>
  <input type="submit" value="现在设定"/>
  <%
}
%>
</form>

<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</html>
