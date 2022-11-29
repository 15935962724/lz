<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.htmlx.*"%>
<%@ page import="tea.ui.TeaSession"%>
<%@ page import="tea.resource.*" %>
<%@ page import="tea.entity.site.*" %>
<%@ page import="tea.entity.member.Profile" %>
<jsp:useBean id="sms" scope="page" class="tea.entity.node.Sms" />
<%
TeaSession teasession = new TeaSession(request);
Resource r = new Resource("/tea/ui/util/SignUp1").add("/tea/htmlx/HtmlX");
String vertify=sms.password();
Community community=Community.find(teasession._strCommunity);
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script language="javascript" src="/tea/CssJs/AreaCityData_zh_CN.js"></script>
<script language="javascript" src="/tea/CssJs/AreaCityData<%=Common.CHATSET[teasession._nLanguage]%>.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="http://www.gmodules.com/ig/ifr?url=http://www.google.com/ig/modules/translatemypage.xml&up_source_language=zh-CN&w=160&h=60&title=&border=&output=js">
</script><!--添加 google 翻译工具栏-->
</head>
<body id="bodynone" >
<div id="jspbefore" style="display:none">
<%=community.getJspBefore(teasession._nLanguage)%>
</div>
<div id="tablebgnone" class="register">
<h1><%=r.getString(teasession._nLanguage, "注册信息")%></h1>
<div id="head6"><img height="6" src="about:blank" alt=""></div>
  <FORM name="form1" METHOD="POST" ACTION="/servlet/hylogin">
  <input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
  <input type="hidden" name="Node" value="<%=teasession._nNode%>"/>
  <input type="hidden" name="Language" value="<%=teasession._nLanguage%>"/>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter" align="left">
    <tr>
      <th>*<%=r.getString(teasession._nLanguage, "用户名：")%></th>
      <td colspan="2"><input type="TEXT" class="edit_input"  name="member" size="30" maxlength="40"></td>
    </tr>
  <tr>
      <th>*<%=r.getString(teasession._nLanguage, "密码：")%></th>
      <td colspan="2">
        <input type="password" class="edit_input"  name="password"  size="30" maxlength="16">
      </td>

    </tr>
    <tr>
      <th>*<%=r.getString(teasession._nLanguage, "确认密码：")%></th>
      <td colspan="2"><input type="password" class="edit_input"  name="password_1"  size="30" maxlength="16"></td>
    </tr>
    <tr>
    <td align="center" colspan="2">
      <input type="submit" class="edit_button" id="edit_submit"   value="<%=r.getString(teasession._nLanguage, " 登 陆 ")%>">
       <input type="button" class="edit_button" id="edit_submit"  value="<%=r.getString(teasession._nLanguage, " 注册 ")%>" onclick="self.location='register.jsp'">
       </td>
    </tr>
    <%
    String member = (String)session.getAttribute("member");
   if(member!= null && !member.equals("webmaster"))
   {
   %>
   <tr>
   <td colspan="3">
   <%=member%> :<br />您好，欢迎您来到主页 ... ...
   </td>
   </tr>
   <tr>
   <td>
     <input type="button" name="membercenter" value="会员中心" onclick="self.location='membercenter.jsp?member=<%=member%>'"/>
   </td>
   <td>
     <input type="button" name="createhostel" value="管理员或代理商创建酒店" onclick="self.location='createhostel.jsp?member=<%=member%>'"/>
   </td>
   <td>
     <input type="button" name="applyadmin" value="申请为酒店管理者" onclick="self.location='applyadmin.jsp?member=<%=member%>'"/>
   </td>
   </tr>
   <%}
   else if(member !=null && member.equals("webmaster"))
   {
   %>
    <td><input type="button" name="auditsHostel" value="处理申请菜单" onclick="self.location='auditsHostel.jsp?member=<%=member%>'"/></td>
  <%} %>
  </table>
  </FORM>
<div id="head6"><img height="6" src="about:blank" alt=""></div>
</div>
<div id="jspafter" style="display:none">
<%=community.getJspAfter(teasession._nLanguage)%>
</div>
</body>
</html>
