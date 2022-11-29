<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="tea.htmlx.*"%>
<%@ page import="tea.ui.TeaSession"%>
<%@ page import="tea.resource.*" %>
<%@ page import="tea.entity.bpicture.*" %>
<%@ page import="java.util.*" %>
<%@ page import="tea.entity.site.*" %>
<%
response.setHeader("progma","no-cache");
response.setHeader("Cache-Control","no-cache");
response.setDateHeader("Expires",0);

TeaSession teasession =new TeaSession(request);
Community community = Community.find(teasession._strCommunity);
Resource r = new Resource("/tea/ui/util/SignUp1").add("/tea/htmlx/HtmlX");

if(teasession._rv==null)
{
  response.sendRedirect("/jsp/user/StartLogin.jsp?nexturl="+request.getRequestURI());
}
String email = request.getParameter("email");
if(email == null)
{
  email = teasession._rv._strR;
}
int bpid = Bperson.findId(email);
Bperson bp = Bperson.find(bpid);
String isExt = request.getParameter("isext");
%>
<html>
<!-- Stock photography -->
<head>

<title>创建新收藏夹</title>
<script src="/tea/tea.js" type="text/javascript"></script>
<script type="">
function check(form)
{
  return submitText(form.lbname,'无效-名称')&&confirm("点击确定将创建名称为 '"+document.frm1.lbname.value+"' 的收藏夹");
}
</script>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">


<style>
#table001{background:#F6F6F6;border-bottom:5px solid #eee;padding:6px;}
#submit,.Button{width:70px;height:22px;font-size:12px;line-height:15px;border:1px solid #7F9DB9;background:#fff;padding-bottom:5px;*padding-bottom:0;}
.lightbox{border:1px solid #7F9DB9;background:#fff;height:22px;font-size:12px;line-height:22px;*line-height:16px;}
.bg8 td{background:#eee;border-bottom:1px solid #ccc;}
.padright{padding:6;}
</style>
</head>




<body style="margin:0;">
<%if(request.getParameter("back")!=null){%>
<div id="jspbefore">
  <%=community.getJspBefore(teasession._nLanguage)%>
</div>

<%}%>
<div id="wai">
<div id="li_biao"><a href="http://bp.redcome.com" target="_top">首页</a>&nbsp;><%if(request.getParameter("back")==null){%>&nbsp;管理中心&nbsp;><%}%>&nbsp;创建收藏夹</div>
<h1>创建收藏夹</h1>
<form name="frm1" method="POST" action="/servlet/EditBPperson" onSubmit="return check(this);">
<input type="hidden" name="back" value="<%=request.getParameter("back")%>"/>
<table width="95%" border="0" align="center" cellpadding="5" cellspacing="0" id="table001">
  <%if(isExt!=null){ %>
  <tr>
    <td colspan="2" align="center">已有名称为 "<%=isExt%>" 的收藏夹</td>
  </tr>
  <%}%>
  <tr class="bg8">

    <td width="52%" class="padleft">请输入新收藏夹的名称 (最大50个字符):</td>
    <td width="42%" align="right" class="padright"><input type="text" name="lbname" maxlength="50" style="width: 150;" class="lightbox"></td>
  </tr>
  <tr><td align="right" colspan="4"><input class="button" type="submit" name="SubmitLB" value="创建">
    <input type="hidden" name="act" value="create">
    <input type="hidden" name="email" value="<%=bp.getEmail()%>">
    </td>
  </tr>
</table>
</form></div>
<%if(request.getParameter("back")!=null){%>
<div id="jspafter">
  <%=community.getJspAfter(teasession._nLanguage)%>
</div>
<%}%>
</body>

<!-- Stock photography -->
</html>
