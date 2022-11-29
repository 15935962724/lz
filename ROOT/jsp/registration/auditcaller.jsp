
<%@page contentType="text/html;charset=UTF-8"%>
<%@page import="tea.htmlx.*"%>
<%@page import="tea.ui.TeaSession"%>
<%@page import="tea.resource.*"%>
<%@page import="tea.entity.site.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.entity.member.Profile"%>
<jsp:useBean id="sms" scope="page" class="tea.entity.node.Sms"/>
<%
  request.setCharacterEncoding("UTF-8");
  TeaSession teasession = new TeaSession(request);
  String member = teasession.getParameter("member");
  Caller obj = Caller.find(member);
  Profile profile = Profile.find(obj.getMember());
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script language="javascript" src="/tea/CssJs/AreaCityData_zh_CN.js" type=""></script>
<script type="text/javascript">
function check(form)
{
  if(submitText(form.oldpassword,'无效-旧密码')
&&submitText(form.password,'无效-新密码')
&&submitText(form.cpassword,'无效-确认密码')
&&submitEqual(form.password,form.cpassword,'两次密码输入不一致')){
if(document.getElementById("opassword").value!=document.getElementById("oldpass").value)
{
  alert("您输入的密码错误，请重新输入");
  form.oldpassword.focus;
  return false;
}
if(document.getElementById('mob').value!=null)
{
  if(submitText(form.mobile,'无效-手机号')
  &&submitInteger(form.mobile,'无效-手机号')
  &&submitLength(11,12,form.mobile,'无效-手机号')
  ){}
  else{return false;}
}
}else{return false;}
}

</script>
  <%--
    <script language="javascript" src="/tea/CssJs/AreaCityScipt.js"></script>
    <script language="javascript" src="/tea/CssJs/SummaryDataCN.js"></script>
    <script language="javascript" src="/tea/CssJs/SummaryScript.js"></script>
  --%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body id="bodynone">
<div id="tablebgnone" class="register">
  <h1>更改话务员信息</h1>
  <div id="head6">
    <img height="6" src="about:blank" alt="">
  </div>
  <FORM name="form1" METHOD="POST" ACTION="/servlet/auditcaller" onSubmit="return check(this);">
  <input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
  <input type="hidden" name="Node" value="<%=teasession._nNode%>"/>
  <input type="hidden" name="Language" value="<%=teasession._nLanguage%>"/>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <th nowrap>*登录ID：</th>
      <td colspan="3">
        <font color="#DF451C">
          <strong><%=member%>          </strong>
        </font>
        <input type="hidden" class="edit_input" name="member" value="<%=member%>">
      </td>
    </tr>
    <tr>
      <th>*输入旧密码：</th>
      <td colspan="3">
        <input type="password" class="edit_input" name="oldpassword" id="oldpass" value="" size=30 maxlength=16/>
        <input type="hidden" name="opassword" id="opassword" value="<%=profile.getPassword()%>"/>
      </td>
    </tr>
    <tr>
      <th>*输入新密码：</th>
      <td>
        <input type="password" class="edit_input" name="password" value="" size=30 maxlength=16>
      </td>
      <td>　</td>
      <td>　</td>
    </tr>
    <tr>
      <th>*确认密码：</th>
      <td>
        <input type="password" class="edit_input" name="cpassword" value="" size=30 maxlength=16>
      </td>
      <td>　</td>
      <td>　</td>
    </tr>
    <tr id=type_1>
      <th>手机号码：</th>
      <td>
        <input type="TEXT" class="edit_input" name="mobile" value="<%=profile.getMobile()%>" size=30 maxlength=20 id="mob">
      </td>
      <td>　</td>
      <td>　</td>
    </tr>
    <tr id=type_1>
      <th>坐席号：</th>
      <td colspan="3">
        <input type="TEXT" class="edit_input" name="site" value="<%=obj.getSite()%>" size=30 maxlength=20>
      </td>
    </tr>
    <tr>
      <th>*姓名：</th>
      <td>
        <input type="TEXT" class="edit_input" name="firstname" value="<%=profile.getFirstName(teasession._nLanguage)%>" size=30 maxlength=20>
      </td>
      <th>*性别：</th>
      <td>
        <input id="gender_0" type="radio" name="sex" value="1" checked="checked"/>
        <label for="gender_0">男</label>
        <input id="gender_1" type="radio" name="sex" value="0"/>
        <label for="gender_1">女</label>
      </td>
    </tr>
    <tr>
      <th nowrap>*证件类型：</th>
      <td>
        <select name="cardtype">
        <%
          for (int j = 0; j < Common.CARDT_TYPE.length; j++) {
            out.println("<option value=" + j);
            if (profile.getCardType() == j) {
              out.println("selected");
            }
            out.println(">" + Common.CARDT_TYPE[j] + "</option>");
          }
        %>

      </td>
      <th>*证件号码:</th>
      <td colspan="2">
        <input name="card" type="text" value="<%=profile.getCard()%>" size="30">
      </td>
    </tr>
    <tr>
      <td colspan="4" align="center">
        <input type="submit" name="submit" value=" 修 改 "/>
      </td>
    </tr>
  </table>
  </FORM>
  <div id="head6">
    <img height="6" src="about:blank">
  </div>
</div>
</body>
</html>
