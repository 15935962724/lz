<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="tea.htmlx.*"%>
<%@ page import="tea.ui.TeaSession"%>
<%@ page import="tea.resource.*" %>
<%@ page import="tea.entity.site.*" %>
<%@ page import="tea.entity.bpicture.*" %>
<%
TeaSession teasession =new TeaSession(request);
Community community=Community.find(teasession._strCommunity);
Resource r = new Resource("/tea/ui/util/SignUp1").add("/tea/htmlx/HtmlX");

%>
<HTML>
  <HEAD>
    <title>B-picture会员-信息提示</title>

<script src="/tea/tea.js" type="text/javascript"></script>
<script type="">
</script>
<style>

.t{margin:12px 0;height:20px;line-height:20px;width:100%;font-size:14px;font-weight:bold;background:url(/res/bigpic/u/0812/081243709.gif) no-repeat 25 2;padding-left:45px;}
#tablecenter002{background:#F6F6F6;border-top:10px solid #eeeeee;font-size:12px;line-height:150%;}
#lzj_an_big{width:80px;height:23px;background:url(/res/bigpic/u/0812/an.jpg) no-repeat;border:0;margin:0 10px;}
#txtfirstName,#txtPwd1,#txtPwd2,#selJobTitle,#selCompanyType,#txtzip,#txtMobilePhone{width:200px;height:22px;border:1px solid #809EBA;background:#fff;line-height:22px;font-size:12px;}
#txtEmail,#txtJobTitleOther,#txtCompanyTypeOther,#txtCompany,#txtCompanyWebsite,#txtaddr1,#txtstate,#txtzip,#txtContactPhone{width:300px;height:22px;border:1px solid #809EBA;background:#fff;line-height:22px;font-size:12px;}

#li_biao{height:35px;*height:25px;line-height:35px;padding-left:15px;font-size:12px;background-color:#D6E6FF;border-top:1px solid #67A7E4;}
#dv1{width:70%;float:right;text-align:right;color:#0000CC;font-size:12px;height:40px;}
.lzj_a{margin:0 10px;color:#0000CC; text-decoration:none;}
#my-B-picture{color:#000;font-weight:bold;text-decoration:none;margin:0 10px;}
#sear{text-align:left;padding-left:70px;}
#qt{width:210px;height:23px;border:1px solid #809EBA;background:#fff;}
#lzj_bg{font-size:12px;}
#lzj_bg a{color:#0000cc;}
#lzj_an{width:45px;height:23px;background:url(/res/bigpic/u/0811/08111256.jpg) no-repeat;border:0;margin:0 10px;}
.kuan{border:0;}
.lzj_logo{width:60px;float:left;background:url(/res/bigpic/u/0812/081243711.jpg) no-repeat 10px 2px;}
.lzj_logo a{display:block;width:160px;height:40px;}
</style>
</HEAD>
<body style="margin:0;padding:0;">
<div style="background: #f6f6f6; padding-bottom: 10px; padding-top: 8px;height:40px;">
<div class="lzj_logo"><a href="/servlet/Folder?node=2198115&language=1"></a></div>
<div id="dv1"><a id="my-B-picture" title="B-picture管理平台" href="/jsp/bpicture/index.jsp">我的B-picture</a>|
<%if(teasession._rv==null){%>
<a class="lzj_a" href="/servlet/Folder?node=2198284&language=1">登录</a>| <a class="lzj_a" title="免费注册" href="/servlet/Node?node=2201051&language=1">注册</a>|
<%}else{%>
<a class="lzj_a" id="cancels" href="/servlet/Logout?community=bigpic&node=2198115" target=_top >&nbsp;退出</a>|
<%}%>
  <a class="lzj_a" title="编辑和管理您的收藏夹" href="/jsp/bpicture/buyer/ViewLightbox.jsp?back=1">收藏夹</a>| <a class="lzj_a" href="/jsp/bpicture/buyer/ShoppingCart.jsp?back=1">购物车</a>| <a class="lzj_a" title="订单和下载" href="/jsp/bpicture/buyer/OrderAndDown.jsp?back=1">订单</a>| <a class="lzj_a" href="/servlet/Node?node=2198272&amp;language=1">联系我们</a>| <a class="lzj_a" href="/servlet/Folder?node=2198279&amp;language=1">帮助</a></div>
</div>
 <div style="text-align:left;" id="li_biao">　><a href="http://bp.redcome.com">首页</a>>信息提示</div>

<table cellSpacing="0" cellPadding="2" width="700" align="center" border="0" id="tablecenter002">
<tr>
<td align="center"><b>信息提示</b></td>
</tr>
<tr>
<td>&nbsp;</td>
</tr>
<tr>
<td align="center"><%=teasession.getParameter("info")%></td>
</tr>
<tr>
<td>&nbsp;</td>
</tr>
<%if(teasession.getParameter("but").equals("0")){%>
<tr>
  <td align="center"><input id="lzj_an_big" type="button" size=60 value="去首页" onclick="window.open('http://bp.redcome.com','_self');"/><input id="lzj_an_big" type="button" size=60 value="关闭此页" onclick="window.close();"/></td>
</tr>
<%}else{%>
<tr>
  <td align="center"><input id="lzj_an_big" type="button" size=60 value="我的B-Picture" onclick="window.open('http://bp.redcome.com/jsp/bpicture','_self');"/><input id="lzj_an_big" size=60 type="button" value="关闭此页" onclick="window.close();"/></td>
</tr>
<%} %>
</table>
<div id="jspafter">
      <%=community.getJspAfter(teasession._nLanguage)%>
    </div>
</body>

</HTML>

