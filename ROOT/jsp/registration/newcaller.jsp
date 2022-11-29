<%@page contentType="text/html;charset=UTF-8"%>
<%@page import="tea.htmlx.*"%>
<%@page import="tea.db.*"%>
<%@page import="tea.ui.TeaSession"%>
<%@page import="tea.resource.*"%>
<%@page import="tea.entity.site.*"%>
<%@page import="tea.entity.member.Profile"%>
<%@page import="tea.entity.admin.*"%>
<%@page import="tea.entity.node.*"%>
<jsp:useBean id="sms" scope="page" class="tea.entity.node.Sms"/>
<%
request.setCharacterEncoding("UTF-8");
  TeaSession teasession = new TeaSession(request);
  tea.entity.site.Community community=tea.entity.site.Community.find(teasession._strCommunity);
  String role = teasession.getParameter("role");
  String nexturl = teasession.getParameter("nexturl");
  String act=request.getParameter("act");
  if(act!=null)
  {
    String value=request.getParameter("value");
   if(act.equals("member"))
    {
      out.print(!Profile.isExisted(value));
    }
    return;
  }
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<script type="text/javascript">
function check(form)
{
  if(submitText(form.member,'无效-用户名')
  &&submitText(form.password,'无效-密码')
  &&submitText(form.cpassword,'无效-确认密码')
  &&submitEqual(form.password,form.cpassword,'两次密码输入不一致')
  &&submitText(form.mobile,'无效-移动电话')
  &&submitText(form.site,'无效-坐席号')
  &&submitText(form.firstname,'无效-姓名')
  &&submitText(form.card,'无效-证件号码')
 // &&submitSelect(form.cardtype,'无效-证件类型')

  &&submitCheckbox(form.acceptterm,'请阅读协议')
)
  {
        if(document.getElementById('cardtype').value=='0')
        {
          var len = document.getElementById('card').value.length;
          if(len==15||len==18||len==0){
          }
          else
          {
            alert('无效-身份证');
            return false;
          }
        }
  }else
  {
	return false;
  }
}
function f_ajax(obj)
{
  var act=obj.name;
  var sv=document.getElementById('span_'+act);
  if(obj.value=="")
  {
    sv.innerHTML="<img src=/tea/image/public/check_error.gif>不能为空";
    return;
  }
  sv.innerHTML="<img src=/tea/image/public/load.gif>";
  sendx("?act="+act+"&value="+obj.value,function(v)
  {
    if(v.indexOf('true')!=-1)
    {
      sv.innerHTML="<img src=/tea/image/public/check_right.gif>";
    }else
    {
      if(obj.name=="member"||obj.name=="firstname")
      {
        //sv.innerHTML="<img src=/tea/image/public/check_error.gif>已存在";
      }
      else
      {
        //sv.innerHTML="<img src=/tea/image/public/check_error.gif>输入错误!请重新输入";
      }
    }
  }
  )
}
</script>
</head>

<body id="bodynone_02">
<div id="jspbefore" style="display:none">
<script>if(top.location==self.location)jspbefore.style.display='';</script>
<%=community.getJspBefore(teasession._nLanguage)%>
</div>
<div id="tablecenter_glydenglu" >
  <h1 style="margin:0px;">新话务员</h1>
  <FORM name="form1" METHOD="POST" ACTION="/servlet/EditCaller" onSubmit="return check(this);">
  <input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
  <input type="hidden" name="Node" value="<%=teasession._nNode%>"/>
  <input type="hidden" name="nexturl" value="<%=nexturl%>"/>
  <input type="hidden" name="role" value="<%=role%>"/>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <th nowrap>*登录ID：</th>
      <td colspan="3">
        <input type="TEXT" class="edit_input" name="member" size="30" maxlength="40" onChange="f_ajax(this)">
        <span id="span_member"></span>
      </td>
    </tr>
    <tr>
      <th>*输入密码：</th>
      <td colspan="3">
        <input type="password" class="edit_input" name="password" size=30 maxlength=16>
      </td>
    </tr>
    <tr>
      <th>*确认密码：</th>
      <td colspan="3">
        <input type="password" class="edit_input" name="cpassword" size=30 maxlength=16>
      </td>
    </tr>
    <tr id=type_1>
      <th>*手机号码：</th>
      <td colspan="3">
        <input type="TEXT" class="edit_input" name="mobile" size=30 maxlength=20>
      </td>
    </tr>
    <tr id=type_1>
      <th>*坐席号:</th>
      <td colspan="3">
        <input type="TEXT" class="edit_input" name="site" size=30 maxlength=20>
      </td>
    </tr>
    <tr>
      <th>*姓名:</th>
      <td>
        <input type="TEXT" class="edit_input" name="firstname" size=30 maxlength=20>
      </td>
      <th>性别:</th>
      <td>
        <input id="gender_0" type="radio" name="sex" value="1" checked/>
        <label for="gender_0">男</label>
        <input id="gender_1" type="radio" name="sex" value="0"/>
        <label for="gender_1">女</label>
      </td>
    </tr>
    <tr>
      <th>证件类型:</th>
      <td>
        <select name="cardtype">
          <option value="0" selected="selected">居民身份证</option>
          <option value="1">护照</option>
          <option value="2">军官证</option>
          <option value="3">回乡证</option>
          <option value="4">台胞证</option>
        </select>
      </td>
      <th>*证件号码:</th>
      <td colspan="2">
        <input name="card" type="text" size="30">
      </td>
    </tr>
     <tr>
      <td colspan="4" align="center" id="denglu_tk">
       <input  name="acceptterm" type="checkbox" value="1" checked="true">
	我已经阅读并接受 <a href="/jsp/registration/SignUp.jsp" target="_blank" class="blue_xhx" ><font color="red"><b>话务员注册用户协议</b></font></a>
      </td>
    <tr>
      <td colspan="4" align="center">
        <input type="submit" name="submit" value=" 注 册 "/>
        &nbsp;&nbsp;&nbsp;&nbsp;
<%--        <input type=button value="返回" onClick="javascript:history.back()">--%>
      </td>
    </tr>
  </table>
  </FORM></div>
  <div id="jspafter" style="display:none">
<script>if(top.location==self.location)jspafter.style.display='';</script>
<%=community.getJspAfter(teasession._nLanguage)%>
</div>


<script>
if(top.location==self.location)
{
  jspbefore.style.display='';
  jspafter.style.display='';
}
</script>
</body>
</html>
