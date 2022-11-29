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
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<title>收藏夹重命名</title>
 <script src="/tea/tea.js" type="text/javascript"></script>
<script type="">
function check(form)
{
  return up()&&submitText(form.rename,'无效-名称')&&confirm("点击确定将使收藏夹名称 '"+document.frm.Lightboxes.value+"' 变更为 '"+document.frm.rename.value+"'");
}

function up()
{
  if(document.frm.Lightboxes.value='我的收藏夹1'||document.frm.Lightboxes.value='我的收藏夹2'||document.frm.Lightboxes.value='我的收藏夹3')
  {
    alert('默认收藏夹名称不能更改！');
    return false;
  }
  return true;
}
</script>
<style>
#table001{background:#F6F6F6;border-bottom:5px solid #eee;padding:6px;}
#submit,.Button{width:70px;height:22px;font-size:12px;line-height:15px;border:1px solid #7F9DB9;background:#fff;padding-bottom:5px;*padding:0;}
#Lightboxes,.lightbox{border:1px solid #7F9DB9;background:#fff;height:22px;font-size:12px;line-height:150%;}
.lzj_001{border:1px solid #7F9DB9;background:#fff;height:22px;font-size:12px;line-height:22px;*line-height:16px;}
.bg8 td{background:#eee;border-bottom:1px solid #ccc;}
.padleft,.padright{border-bottom:1px solid #ccc;padding:6px;}

</style>
</head>
<body style="margin:0;">
<%if(request.getParameter("back")!=null){%>
<div id="jspbefore">
  <%=community.getJspBefore(teasession._nLanguage)%>
</div>

<%}%>
<div id="wai">
<div id="li_biao"><a href="http://bp.redcome.com" target="_top">首页</a>&nbsp;><%if(request.getParameter("back")==null){%>&nbsp;管理中心&nbsp;><%}%>&nbsp;收藏夹重命名</div>
<h1>收藏夹重命名</h1>
<form name="frm" method="POST" action="/servlet/EditBPperson" onSubmit="return check(this);">
                <input type="hidden" name="act" value="rename"/>
                <input type="hidden" name="back" value="<%=request.getParameter("back")%>"/>
                <input type="hidden" name="email" value="<%=bp.getEmail()%>"/>
<table width="95%" border="0" cellspacing="0" cellpadding="5" id="table001">
<%if(isExt!=null){ %>
<tr>
  <td colspan="2" align="center">已有名称为 "<%=isExt%>" 的收藏夹,请重新命名</td>
</tr>
<%}%>
	<tr class="bg8">


		<td width="90%" class="padleft">请选择一个现有的收藏夹重新命名:</td>
		<td width="10%" class="padright">

<select id="Lightboxes" class="lightbox" name="Lightboxes" style="width: 150;">
               <%
                Enumeration e = BLightbox.findLightBox(bp.getEmail());
                while(e.hasMoreElements()){
                  String element = e.nextElement().toString();
                  out.print("<option value=\""+element+"\">"+element+"</option>");
                }
                %>

          </select>

		</td>
	</tr>
	<tr>
		<td class="padleft">请输入这个新的收藏夹名称 (最大 50 个字符):</td>
		<td class="padright">
			<input type="hidden" name="submitType" id="submitType" value="Rename">
			<input type="text" name="rename" value="" maxlength="50" style="width: 150;" class="lzj_001">
		</td>
	</tr>
	<tr><td align="right" colspan="3"><input type="submit" name="SubmitLB" value="重命名" width="140" class="button">
		</td></tr>
</table>
</form>
</div>
<%if(request.getParameter("back")!=null){%>
<div id="jspafter">
  <%=community.getJspAfter(teasession._nLanguage)%>
</div>
<%}%>
</body>

<!-- Stock photography -->
</html>
