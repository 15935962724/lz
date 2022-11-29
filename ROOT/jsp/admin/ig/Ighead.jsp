<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.ui.*" %><%@page import="tea.entity.member.*" %><%

TeaSession teasession=new TeaSession(request);
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
  return;
}
tea.resource.Resource r=new tea.resource.Resource();
r.add("/tea/resource/fun");

Profile p=Profile.find(teasession._rv._strV);


%><!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<TITLE>个性化主页 EDN-ERP</TITLE>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>
<BODY >
<DIV ID=Body>
<DIV ID=Header>
<style>
#erptop{width:100%;padding:4px}
#erptop a{padding:0px 3px}
</style>
  <div align=right nowrap id="erptop">
<img src="<%=p.getPhotopath(teasession._nLanguage)%>" >
<b><%=p.getEmail()%></b>
| <a href="/servlet/Folder?node=59303&Language=1" target="_top">常规主页</a>
| <a href="/servlet/Logout?node=59303&Language=1" target="_top">登出</a></div>
  <style>
.q{padding:0px 8px}
input{font-size:12px}
#shch a{padding-left:5px;font-size:14px}
.STYLE2 {
	font-size: 14px;
	font-weight: bold;padding:10px 10px 10px 100px;}
	.STYLE2 a{
	font-size: 14px;
	font-weight: bold;padding:10px 10px 10px 10px;}
</style>
  <div style="text-align:left">
    <form action="/search" name=f>
      <table border=0 cellspacing=0 cellpadding=0 >
        <tr>
          <td style="padding-right:20px"><img src="/res/EDN-ERP/u/0703/070345670.gif"></td>
          <td><table border=0 cellspacing=0 cellpadding=0 >
              <tr>
                <td nowrap style="padding:15px 0px"><font size=-1><b>企业</b><a class=q href="####" >产品</a><a class=q href="####" >社区</a><a class=q href="#" >资讯</a><a class=q href="####" >地图</a> <a class=q href="####" >论坛</a><b><a href="#" class=q>更多&raquo;</a></b></font></td>
              </tr>
            </table>
            <table cellpadding=0 cellspacing=0>
              <tr valign=top>
                <td width=25%></td>
                <td align=center nowrap><input name=hl type=hidden value=zh-CN>
                  <input maxlength=2048 name=q size=55 title="搜索" value="">
                <br></td>
                <td nowrap width=25% id="shch"><input name=btnG type=submit value="搜　索" style="height:22px"></td>
              </tr>
              <tr>
                <td align=center colspan=3  style="padding-top:4px"><font size=-1>
                  <input id=all type=radio name=lr value="" checked>
                  <label for=all>标题 </label>
                  <input id=radio type=radio name=lr value="" >
                  <label for=all>全文</label></font></td>
              </tr>
          </table></td>
        </tr>
      </table>
    </form>
</DIV>





