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
String policy=obj.get("msnpolicy");
int width=obj.getInt("msnwidth");
int height=obj.getInt("msnheight");
String before=obj.get("msnbefore");
String after=obj.get("msnafter");

%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type=""></SCRIPT>
<script src="/tea/mt.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "设置 Windows Live Messenger 即时消息控件")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" action="/servlet/EditCommunityOption" method="post" target="_ajax" onsubmit="return submitText(this.msnpolicy,'<%=r.getString(teasession._nLanguage, "隐私策略")%>')&&submitInteger(this.msnwidth,'<%=r.getString(teasession._nLanguage, "大小")%>')&&submitInteger(this.msnheight,'<%=r.getString(teasession._nLanguage, "大小")%>');">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="name" value="/msnpolicy/msnwidth/msnheight/msnbefore/msnafter/">

<table cellpadding="0" cellspacing="0" border="0" id="tablecenter">
  <tr>
    <td><%=r.getString(teasession._nLanguage,"隐私策略")%></td>
    <td><input name="msnpolicy" value="<%if(policy!=null)out.print(policy);%>"></td>
    <td>请填节点号</td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage,"大小")%></td>
    <td><input name="msnwidth" value="<%=width%>" size="5">x<input name="msnheight" value="<%=height%>" size="5">PX</td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage,"之前")%></td>
    <td><textarea name="msnbefore" cols="50" rows="4"><%if(before!=null)out.print(before);%></textarea></td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage,"之后")%></td>
    <td><textarea name="msnafter" cols="50" rows="4"><%if(after!=null)out.print(after);%></textarea></td>
  </tr>
</table>


<input type="submit" class="edit_input" value="<%=r.getString(teasession._nLanguage,"Submit")%>">
</form>

<table cellpadding="0" cellspacing="0" border="0" id="tablecenter">
<tr>
  <td>
    <textarea name="textarea" cols="50" rows="5">&lt;script src="/jsp/im/Msns.jsp?style=0">&lt;/script></textarea>
  </td>
</tr>
<tr>
  <td>
    <textarea name="textarea" cols="50" rows="5">&lt;script src="/jsp/im/Msns.jsp?style=1">&lt;/script></textarea>
  </td>
</tr>
<tr>
  <td>
    <textarea name="textarea" cols="50" rows="5">&lt;script src="/jsp/im/Msns.jsp?style=2">&lt;/script></textarea>
  </td>
</tr>
</table>

<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</html>
