<%@ page contentType="text/html;charset=UTF-8" %>
<style type="text/css">
#dv1{width:100%;text-align:right;font-size:12px;height:40px;background:url(/res/bigpic/u/0812/081247284.jpg) no-repeat 10 2;color:#0000CC;}
.lzj_a{margin:0 10px;color:#0000CC; text-decoration:none;}
#my-B-picture{color:#000;font-weight:bold;text-decoration:none;margin:0 10px;}
#sear{text-align:left;padding-left:70px;}
#qt{width:210px;height:23px;border:1px solid #809EBA;background:#fff;}
#lzj_bg{font-size:12px;}
#lzj_bg TD{padding:5px 0;}
#lzj_bg a{color:#0000cc;}
#lzj_an{width:45px;height:23px;background:url(/res/bigpic/u/0812/081243710.jpg) no-repeat;border:0;margin:0 10px;}
.kuan{border:0;}
</style>
<div style="background:#F6F6F6;padding-bottom:10px;padding-top:8px;"><!--
<div id="dv1">
  <a title="管理帐户并访问您的形象" href="/jsp/admin" id="my-B-picture">我的B-picture</a>|
  <%
  if(teasession._rv==null){
    %>
    <a class="lzj_a" href="/jsp/bpicture/regist/StartLogin.jsp?nexturl=<%=url%>">登录</a>|
    <a class="lzj_a" title="它是免费的" href="/jsp/bpicture/regist/register.jsp">注册</a>|
    <%}else{%>
    <a class="lzj_a" id="cancels" href="/servlet/Logout?community=<%=teasession._strCommunity%>&node=<%=c.getLogin()%>&nexturl=<%=url%>" target=_top >&nbsp;登出</a>|
    <%}%>
    <a class="lzj_a" title="编辑和管理您的灯箱" href="/jsp/admin/right.jsp?id=130526&node=2198115&community=bigpic">收藏图库</a>|
    <a class="lzj_a" href="/jsp/admin/right.jsp?id=130518&node=2198115&community=bigpic">购物车</a>|
    <a class="lzj_a" title="您的订单，发票和下载图像" href="#">订单</a>|
    <a class="lzj_a" href="#">联系我们</a>|
    <a class="lzj_a" href="#">帮助</a>
</div>
-->

<form action="/servlet/Folder?node=2198224&language=1" id="sear" name="search" method="get">
<table width="530" cellpadding="0" cellspacing="0"  id="lzj_bg">
  <tr>
    <td>
      <input type="text" name="keywords" id="qt" title="输入关键字，名称或参考号码。" /></td>
    <td><input name="submit" type="submit" id="lzj_an" value="搜索"/></td>
    <td>
      <label for="rm" title="查找版权管理类图片">
        <input id="rm" class="kuan" type="checkbox" name="rm" value="2"/></label>
        <label for="rm" title="查找版权管理类图片"></label>
        <label for="rf" title="查找免版税图片"></label>
        <label for="rf" title="查找免版税图片"></label>    </td>
    <td><label for="label" title="查找版权管理类图片">版权管理类图片(RM)</label></td>
    <td><input id="rf" class="kuan" type="checkbox" name="rf" value="1"/></td>
    <td>免版税图片(RF)</td>
  </tr>
  <tr>
    <td colspan="2"><a href="#">在结果中搜索</a>　<a href="/servlet/Node?node=2198222&language=1" title="更多的选择，布尔检索和过滤器的方向" id="advanced">高级搜索</a></td>
  </tr>
</table>
</form>
</div>
