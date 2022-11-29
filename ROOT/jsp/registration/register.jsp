<%@page contentType="text/html;charset=UTF-8"%>
<%@page import="tea.htmlx.*"%>
<%@page import="tea.ui.TeaSession"%>
<%@page import="tea.resource.*"%>
<%@page import="tea.entity.site.*"%>
<%@page import="tea.entity.member.Profile"%>
<%
  request.setCharacterEncoding("UTF-8");
  TeaSession teasession = new TeaSession(request);
  String act = request.getParameter("act");

  if (act != null) {
    String value = request.getParameter("value");
    if (act.equals("vertify")) {
      out.print(value.equals(session.getAttribute("sms.vertify")));
    }
    else if (act.equals("member")) {
      out.print(!Profile.isExisted(value));//&&!Profile.isLExisted(value,teasession._nLanguage));
    }
    else if (act.equals("firstname")) {
      out.println(!Profile.isExisted(value));
    }
    return;
  }
    Community community = Community.find(teasession._strCommunity);
%>

<script type="text/javascript">
var bv=false;
function check(form)
{
  if(submitText(form.member,'无效-用户名')
  &&submitID(form.checkID,'用户名已存在，请更改！')
  &&submitText(form.password,'无效-密码')
  &&submitText(form.password_1,'无效-确认密码')
  &&submitEqual(form.password,form.password_1,'两次密码输入不一致')
  &&submitText(form.Email,'无效-邮箱')
  &&submitEmail(form.Email,'无效-邮箱')
  &&submitText(form.mobile,'无效-移动电话')
  &&submitInteger(form.mobile,'无效-移动电话')
  &&submitLength(11,12,form.mobile,'无效-移动电话')
  &&submitText(form.firstname,'无效-姓名')
  &&submitCheckbox(form.acceptterm,'请阅读协议')
 )
  {
    if(document.getElementById('cardtype').value==0)
    {
        var len = document.getElementById('card').value.length;
        if(len==15||len==18){
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
  var checkid=document.getElementById('checkID');
  if(obj.value==""||obj.value==null)
  {
    sv.innerHTML="<img src=/tea/image/public/check_error.gif>不能为空";
    return;
  }
  sv.innerHTML="<img src=/tea/image/public/load.gif>";
  sendx("?act="+act+"&value="+obj.value,function(v)
  {
    if(v.indexOf('true')!=-1)
    {
      if(obj.name=="member"){
      sv.innerHTML="<img src=/tea/image/public/check_right.gif>用户名可用";
      checkid.value="false";
      }
      else
      {
        sv.innerHTML="<img src=/tea/image/public/check_right.gif>";
        if(obj.name=="vertify")
        bv=true;
      }
    }else
    {
      if(obj.name=="member")
      {
        sv.innerHTML="<img src=/tea/image/public/check_error.gif>用户名已存在";
         checkid.value="true";
      }
      else if(obj.name=="firstname")
      {
      //sv.innerHTML="<img src=/tea/image/public/check_error.gif>姓名已存在";
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

<SCRIPT LANGUAGE="JAVASCRIPT" SRC="/tea/tea.js" type="text/javascript"></SCRIPT>
<div id="tablebgnone" class="register">
  <h1>普通会员注册信息</h1>
  <div id="head6">
    <img height="6" src="about:blank" alt="">
  </div>
  <FORM name="form1" METHOD="POST" onsubmit="return(check(this));" ACTION="/servlet/Registration">
  <input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
  <input type="hidden" name="Node" value="2"/>
  <input type="hidden" name="Language" value="<%=teasession._nLanguage%>"/>
  <input type="hidden" name="checkID" value="<%=!Profile.isExisted1(request.getParameter("value"))%>"/>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter" align="left">
    <tr>
      <td  id="type_1">*用户ID：</td>
      <td  id="type_3">
        <input type="TEXT" class="edit_input" name="member" onblur="f_ajax(this)" size=30 maxlength=40>
      </td>
      <td width="17%"> <span id="span_member"></span></td><td>【用户名ID由英文字母数字和下划线组成】</td>
    </tr>

    <tr>
      <td id="type_1">*密码：</td>
      <td colspan="3"  id="type_3">
        <input type="password" class="edit_input" name="password" value="" size="30" maxlength="16">
      </td>
    </tr>
    <tr>
      <td id="type_1">*确认密码：</td>
      <td colspan="3"  id="type_3">
        <input type="password" class="edit_input" name="password_1" value="" size="30" maxlength="16">
      </td>
    </tr>
    <tr id="type_0">
      <td id="type_1">*邮箱：</td>
      <td colspan="3"  id="type_3">
        <input type="TEXT" class="edit_input" name="Email" size="30" maxlength="40">
      </td>
    </tr>
    <tr id=type_0>
      <td id="type_1">*手机号：</td>
      <td colspan="3"  id="type_3">
        <input type="TEXT" class="edit_input" name="mobile" size="30" maxlength="20">
      </td>
    </tr>
    <!--<tr>
      <td id="type_1">*验证码：</td>
      <td  id="type_3">
        <input type="TEXT" class="edit_input" name="vertify" id="yzm"  size="30" maxlength="20" onchange="f_ajax(this)" onblur="f_ajax(this)" /></td>  <td id="type_2"><img src="/jsp/registration/validate.jsp" alt="Validate"></td>
      <td> <span id="span_vertify"></span>
      </td>
    </tr>-->
    <tr>
      <td id="type_1">*姓名：</td>
      <td  id="type_3">
        <input type="TEXT" class="edit_input" name="firstname" value="" size="30" maxlength="20">
      </td>
      <td id="type_2" align="center">*性别：</td>
      <td>
        <input id="gender_0" type="radio" name="sex" value="1" checked="checked"/>
        <label for="gender_0">男</label>
        <input id="gender_1" type="radio" name="sex" value="0"/>
        <label for="gender_1">女</label>
      </td>
    </tr>
    <tr>
      <td nowrap id="type_1">证件类型：</td>
      <td  id="type_3">
        <!--MTPs 台胞证 HVPs 回乡证 Military officer军官证 Passport护照  Identity Cards居民身份证-->
        <select name="cardtype" id="cardtype">
          <option value="0" selected="selected">居民身份证</option>
          <option value="1">护照</option>
          <option value="2">军官证</option>
          <option value="3">回乡证</option>
          <option value="4">台胞证</option>
        </select>　*
      </td>
      <td id="type_2" nowrap="nowrap">证件号码：</td>
      <td colspan="2"  id="type_4">
        <input name="card" type="text" size="30" id="card">
      </td>
    </tr>

         <tr>
      <td colspan="4" align="center" id="denglu_tk">
       <input  name="acceptterm" type="checkbox" value="1" checked="true">
	我已经阅读并接受 <a href="/jsp/registration/SignUp.jsp" target="_blank" class="blue_xhx"><font color="red"><b>普通会员注册用户协议</b></font></a>
      </td>

    </tr>
    <tr>
      <td align="center" colspan="4" id="denglu_tk">
        <input type="image" src="/res/jiudian/u/0802/080250264.jpg" class="edit_button" id="submit" value=" 注册 ">&nbsp;&nbsp;&nbsp;&nbsp;
        <a href="#" onClick="javascript:history.back()"><img src="/res/jiudian/u/0803/080314081.jpg"></a>
      </td>

    </tr>
  </table>
  </FORM>
  <div id="head6">
    <img height="6" src="about:blank" alt="">
  </div>
</div>


