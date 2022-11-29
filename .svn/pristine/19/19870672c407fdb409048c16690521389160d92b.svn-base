<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.*" %><%@ page import="tea.entity.member.*" %><%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);

Resource r=new Resource("/tea/resource/Job");

if(request.getMethod().equals("POST"))
{
  String organization=request.getParameter("organization");
  String state=request.getParameter("state");
  String address=request.getParameter("address");
  String telephone=request.getParameter("telephone");
  String firstname=request.getParameter("firstname");
  String email=request.getParameter("email");
  String member=request.getParameter("member");
  String password=request.getParameter("password");

  if(Profile.isExisted(member))
  {
    response.sendRedirect("/jsp/info/Alert.jsp?info="+java.net.URLEncoder.encode(member+" 会员已经存在","UTF-8"));
    return;
  }
  Profile p=Profile.create(member,password,teasession._strCommunity,email,request.getServerName());
  p.setOrganization(organization,teasession._nLanguage);
  p.setState(state,teasession._nLanguage);
  p.setAddress(address,teasession._nLanguage);
  p.setTelephone(telephone,teasession._nLanguage);
  p.setFirstName(firstname,teasession._nLanguage);

  ProfileJob.create(member,teasession._strCommunity);

  response.sendRedirect("/jsp/info/Succeed.jsp?info="+java.net.URLEncoder.encode(member+" 注册成功.","UTF-8"));
  return;
}

r.add("/tea/ui/util/SignUp1").add("/tea/htmlx/HtmlX");

%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/jsp/criterion/js.js"></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<body onLoad="form1.member.focus();">

<h1><%=r.getString(teasession._nLanguage,"1167466843562")%><!--企业会员注册--></h1>
<br>
<div id="head6"><img height="6" src="about:blank"></div>
<br/>

  <FORM name=form1 METHOD=post action="<%=request.getRequestURI()%>" onSubmit="return submitText(this.organization,'<%=r.getString(teasession._nLanguage, "InvalidParameter")%>-公司名称')&&submitText(this.state,'<%=r.getString(teasession._nLanguage, "InvalidParameter")%>-所在地')&&submitText(this.address,'<%=r.getString(teasession._nLanguage, "InvalidParameter")%>-地址')&&submitText(this.telephone,'<%=r.getString(teasession._nLanguage, "InvalidParameter")%>-联系电话')&&submitText(this.firstname,'<%=r.getString(teasession._nLanguage, "InvalidParameter")%>-联系人')&&submitEmail(this.email,'<%=r.getString(teasession._nLanguage, "InvalidEmailAddress")%>')&&submitMemberid(this.member,'<%=r.getString(teasession._nLanguage, "InvalidMemberId")%>')&&submitIdentifier(this.password,'<%=r.getString(teasession._nLanguage, "InvalidPassword")%>')&&submitEqual(this.password,this.cpassword,'<%=r.getString(teasession._nLanguage, "InvalidConfirm")%>');">
    <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
      <tr><td><%=r.getString(teasession._nLanguage,"1167466871093")%><!--公司名称-->:</td><td><input name="organization" type="text" size="40"></td></tr>
        <tr><td><%=r.getString(teasession._nLanguage,"1167466896625")%><!--所在地-->: </td><td>
          <select name="state">
            <option value="">--------------</option>
            <%
            for(int i=0;i<Common.PROVINCE.length;i++)
            {
              out.print("<option value="+Common.PROVINCE[i]+" >"+r.getString(teasession._nLanguage,"Province."+Common.PROVINCE[i]));
            }
            %>
            </select>
        </td></tr>
        <tr><td><%=r.getString(teasession._nLanguage,"1167466918531")%><!--地址-->: </td><td><input name="address" type="text" size="60"></td></tr>
          <tr><td><%=r.getString(teasession._nLanguage,"1167466940000")%><!--联系电话-->: </td><td><input name="telephone" type="text"></td></tr>
            <tr><td><%=r.getString(teasession._nLanguage,"Contact")%><!--联系人-->: </td><td><input name="firstname" type="text"></td></tr>
              <tr><td>E-Mail: </td><td><input name="email" type="text"></td></tr>
                <tr><td colspan="2"><hr>
              </td></tr>
              <tr><td><%=r.getString(teasession._nLanguage,"MemberId")%><!--会员名-->:</td><td><input name="member"  ><%=r.getString(teasession._nLanguage,"1167467002937")%><!--长度:3-20位--></td></tr>
                <tr><td><%=r.getString(teasession._nLanguage,"Password")%>:</td><td><input type="password" name=password ><%=r.getString(teasession._nLanguage,"1167467067343")%><!-- 长度:3-20位 格式:字母或数字--></td></tr>
                  <tr><td><%=r.getString(teasession._nLanguage,"ConfirmPassword")%>:</td><td><input type="password" name=cpassword ></td></tr>
    </table>
<input type=submit value="<%=r.getString(teasession._nLanguage,"CBSubmit")%>">
</form>

<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>

