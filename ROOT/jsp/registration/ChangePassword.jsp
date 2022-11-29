<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.htmlx.*"%>
<%@ page import="tea.ui.TeaSession"%>
<%@ page import="tea.resource.*" %>
<%@ page import="tea.entity.site.*" %>
<%@ page import="tea.entity.member.*" %>
<jsp:useBean id="sms" scope="page" class="tea.entity.node.Sms" />
<%
request.setCharacterEncoding("UTF-8");
TeaSession teasession = new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}
Resource r = new Resource("/tea/ui/util/SignUp1").add("/tea/htmlx/HtmlX");
Community community=Community.find(teasession._strCommunity);
String member = teasession._rv._strV;
System.out.println("ChangePassword member is : "+member) ;
Profile obj=null;
if(member!=null)
{
   obj = Profile.find(member);
 }
else
{
    obj = Profile.find(teasession._rv.toString());
}
%>
<html>
  <head>
    <link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
    <script src="/tea/tea.js" type="text/javascript"></script>
    <script language="javascript" src="/tea/CssJs/AreaCityData_zh_CN.js" type=""></script>
    <script language="javascript" src="/tea/CssJs/AreaCityData<%=Common.CHATSET[teasession._nLanguage]%>.js" type=""></script>
    <script type="text/javascript">
   function check(form)
    {
      if( submitText(form.oldpassword,'无效-旧密码')
      &&submitText(form.newpassword,'无效-新密码')
      &&submitText(form.newpassword_1,'无效-确认新密码')
      &&submitEqual(form.newpassword,form.newpassword_1,'两次密码输入不一致')
      )
      {
        if(document.getElementById('password').value!=document.getElementById('oldpassword').value)
        {
          alert("您的旧密码输入错误，请重新输入!");
          return false;
        }
      }else
      {
        return false;
      }

    }
    </script>

  </head>
  <body id="bodynone"  class="register">
  <div id="jspbefore" style="display:none">
    <%=community.getJspBefore(teasession._nLanguage)%>
  </div>
  <div id="tablebgnone" class="register">
    <h1><%=r.getString(teasession._nLanguage, "修改密码")%></h1>
    <div id="head6"><img height="6" src="about:blank" alt=""></div>
      <FORM name="form1" METHOD="POST" ACTION="/jsp/registration/changep.jsp" onsubmit="return (check(this));">
        <input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
        <input type="hidden" name="Node" value="<%=teasession._nNode%>"/>
        <input type="hidden" name="Language" value="<%=teasession._nLanguage%>"/>
        <table border="0" cellpadding="0" cellspacing="0" id="tablecenter" align="left">
          <tr>
            <input type="hidden" value="<%=obj.getMember()%>" name="member"/>
            </td>
          <tr>
            <th>*<%=r.getString(teasession._nLanguage, "原来的密码：")%></th>
            <td colspan="3"><input type="password" class="edit_input"  name="oldpassword" size="30" maxlength="16" id="oldpassword">
            <input type="hidden" value="<%=obj.getPassword()%>" name="password"  id="password"/>
            <%System.out.println(obj.getPassword());%>
            </td>
          </tr>
          <tr>
            <th>*<%=r.getString(teasession._nLanguage, "输入密码：")%></th>
            <td colspan="3"><input type="password" class="edit_input"  name="newpassword" size="30" maxlength="16"></td>
          </tr>
          <tr>
            <th>*<%=r.getString(teasession._nLanguage, "确认密码：")%></th>
            <td colspan="3">
              <input type="password" class="edit_input"  name="newpassword_1" size="30" maxlength="16"></td>
          </tr>
<tr>
  <td align="center">
    <input type="submit" class="edit_button" id="edit_submit"   value="<%=r.getString(teasession._nLanguage, " 修 改 ")%>">
  </td>
</tr>
 </table>
</FORM>
<div id="jspafter" style="display:none">
<%=community.getJspAfter(teasession._nLanguage)%>
</div>
</body>
</html>
