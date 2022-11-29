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

%>
<html>
<!-- Stock photography -->
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<title>删除收藏夹</title>
<script type="">
function check()
{
  if(document.del.Lightboxes.value=='我的收藏夹1'||document.del.Lightboxes.value='我的收藏夹2'||document.del.Lightboxes.value='我的收藏夹3'){
    alert('不能删除默认收藏夹！');
    return false;
  }
return confirm("是否删除名称为 '"+document.del.Lightboxes.value+"' 的收藏夹");
}
</script>
<style>

#table001{background:#F6F6F6;border-bottom:5px solid #eee;padding:6px;}
#submit,.Button,.button{width:70px;height:22px;font-size:12px;line-height:25px;*line-height:15px;border:1px solid #7F9DB9;background:#fff;padding-bottom:5px;*padding:0;}
#Lightboxes,.lightbox{border:1px solid #7F9DB9;background:#fff;height:22px;font-size:12px;line-height:150%;}
.bg8 td{background:#eee;border-bottom:1px solid #ccc;}
.padright{padding:6px;}
</style>
</head>

<body style="margin:0;">
<%if(request.getParameter("back")!=null){%>
<div id="jspbefore">
  <%=community.getJspBefore(teasession._nLanguage)%>
</div>

<%}%>
<div id="wai">
<div id="li_biao"><a href="http://bp.redcome.com" target="_top">首页</a>&nbsp;><%if(request.getParameter("back")==null){%>&nbsp;管理中心&nbsp;><%}%>&nbsp;删除收藏夹</div>
<h1>删除收藏夹</h1>
 <form name="del" method="POST" action="/servlet/EditBPperson" onSubmit="return check();">
 <input type="hidden" name="act" value="del">
  <input type="hidden" name="back" value="<%=request.getParameter("back")%>">
                    <input type="hidden" name="email" value="<%=bp.getEmail()%>">
<table width="95%" border="0" cellspacing="0" cellpadding="2" id="table001">
	<tr class="bg8">

		<td width="90%" class="padleft">请选择一个收藏夹进行删除:</td>
		<td width="10%" class="padright">
                  <select id="Lightboxes" class="lightbox" name="Lightboxes"  style="WIDTH: 150;">
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
        <td colspan="3" align="right" class="padright">
                <input type="hidden" id="submitType" name="submitType" value="Delete">
                <input type="submit" name="SubmitLB" value="删除" width="140" class="button" ></td>
            </tr>
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
