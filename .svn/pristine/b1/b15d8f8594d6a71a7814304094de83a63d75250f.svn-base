<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.entity.node.Event"%>
<%@page import="tea.entity.node.Node"%>
<%@page import="tea.entity.admin.AdminRole"%>
<%@page import="tea.entity.admin.AdminUnit"%>
<%@page import="tea.entity.admin.AdminUsrRole"%>
<%@page import="java.net.URLEncoder"%>
<%@ page import="tea.resource.Resource" %><%@ page import="tea.db.DbAdapter" %><%@ page import="tea.ui.TeaSession" %>
<%@page import="tea.entity.*"%><%@page import="tea.entity.volunteer.*" %><%@page import="tea.entity.member.*" %><%@page import="tea.resource.*" %><%@page import="java.io.*" %>
<%@page import="java.util.*"%>
<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);


tea.entity.site.Community community=tea.entity.site.Community.find(teasession._strCommunity);
String nexturl = teasession.getParameter("nexturl"); 
%>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="<%=community.getJspBeforePath(teasession._nLanguage)%>" type="text/javascript"></SCRIPT>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/tea/Calendar.js" type="text/javascript"></script>
<script src="/tea/city.js" type="text/javascript"></script>

<script>

var c=5;
var t;
    function goUrl()
 {
    document.getElementById("timeid").innerHTML=c+"秒后将自动进入登录页面...";
 t=setTimeout("goUrl()",1000);
 c-=1;
 if(c==0)
 {
   location.href="/html/folder/41-1.htm";
 }
 }

 window.onload=goUrl;
</script>
<link href="/res/westrac/cssjs/12L1.css" rel="stylesheet" type="text/css"/>
<form name="form1" method="post" action="?"  >
<input type="hidden" name="node" value="<%=teasession._nNode%>">

<div class="RegiSuccess">

<div class="RegSelect">
<!-- 
<input type="radio" name="type" value="0" onClick="window.open('/html/folder/32-1.htm','_self');">&nbsp;普通会员&nbsp;&nbsp;&nbsp;&nbsp;
<input type="radio" name="type" value="1" checked="checked">&nbsp;履友</div>
 -->
 <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    
     <tr>
      <td class="td01"><span>恭喜您！</span>已经成功完成注册，感谢您加入高尔夫俱乐部，快来登录吧！</td>
    </tr>
    
    <tr>
     <td class="td02">注：注册成功后即可使用注册账号登录，未通过审核的只享有普通会员权限，通过审核后才享有高尔夫俱乐部高级会员权限，账号审核中...审核通过后我们将第一时间短信通知您!</td>
    </tr>
  </table>
  <div id="timeid"></div>
  <div class="NotNormal">如果页面无法正常跳转，请点击<a href="/html/folder/41-1.htm">登录</a></div>
  
</div>
 </form>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="<%=community.getJspAfterPath(teasession._nLanguage)%>" type="text/javascript"></SCRIPT>
