<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.htmlx.*"%><%@ page import="tea.ui.TeaSession"%><%@ page import="tea.resource.*" %><%@ page import="tea.entity.site.*" %><%@ page import="tea.entity.member.Profile" %><jsp:useBean id="sms" scope="page" class="tea.entity.node.Sms" />
<%@include file="/jsp/Header.jsp"%>
<%
 request.setCharacterEncoding("UTF-8");

  TeaSession teasession = new TeaSession(request);
  int id =0;

  if(teasession.getParameter("id")!=null && teasession.getParameter("id").length()>0)
      id =   Integer.parseInt(teasession.getParameter("id"));
  String act = request.getParameter("act");
  if (act != null)
  {
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
Resource r = new Resource("/tea/ui/util/SignUp1").add("/tea/htmlx/HtmlX");
//Community community=Community.find(teasession._strCommunity);
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE="JAVASCRIPT" SRC="/tea/tea.js" type="text/javascript"></SCRIPT>
<script language="javascript" src="/tea/CssJs/AreaCityData_zh_CN.js" type="text/javascript"></script>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

</head>
<body id="bodynone" >
<script type="text/javascript">
function check(form)
{
  if(submitText(form.member,'无效-用户名')
  &&submitID(form.checkID,'用户名已存在，请更改！')
  &&submitText(form.password,'无效-密码')
  &&submitText(form.password_1,'无效-确认密码')
  &&submitEqual(form.password,form.password_1,'两次密码输入不一致')
  &&submitText(form.Email,'无效-邮箱')
  &&submitEmail(form.Email,'无效-邮箱')
  &&submitInteger(form.mobile,'无效-移动电话')
  &&submitLength(11,12,form.mobile,'无效-移动电话')
  &&submitText(form.firstname,'无效-姓名')
 )
  {
    if(document.getElementById('cardtype').value==0)
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
  var checkid=document.getElementById('checkID');
  if(obj.value==""||obj.value==null)
  {
    sv.innerHTML="<img src=/tea/image/public/check_error.gif>不能为空";
    return;
  }
  sv.innerHTML="<img src=/tea/image/public/load.gif>";
sendx("?id=<%=id%>&act="+act+"&value="+obj.value,function(v)
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
<div id="jspbefore" style="display:none">
<%//=community.getJspBefore(teasession._nLanguage)%>
</div>
<div id="tablebgnone" class="register">
<h1>注册信息</h1>
<div id="head6"><img height="6" src="about:blank" alt=""></div>
  <FORM name="form1" METHOD="POST" onsubmit="return(check(this));" ACTION="/servlet/CalleRegister">
  <input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
  <input type="hidden" name="Node" value="<%=teasession._nNode%>"/>
  <input type="hidden" name="Language" value="<%=teasession._nLanguage%>"/>
    <input type="hidden" name="checkID" value="<%=!Profile.isExisted1(request.getParameter("value"))%>"/>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter" align="left">
    <tr>
      <th>*用户名：</th>
      <td>
        <input type="TEXT" class="edit_input"  name="member" onblur="f_ajax(this)"  size=30 maxlength=40>
      <span id="span_member"></span>
      </td>
        <td colspan="2"><%=r.getString(teasession._nLanguage, "请注意会员ID和口令区分大小写.并且我们将根据您的Email地址发送给您的注册信息(会员ID、口令等)请确保您的Email地址是正确的。")%> </td>
      </tr>
    <tr>
      <th>*"密码：</th>
      <td colspan="3"><input type="password" class="edit_input"  name="password" value="" size="30" maxlength="16"></td>
    </tr>
    <tr>
      <th>*"确认密码：</th>
      <td colspan="3"><input type="password" class="edit_input"  name="password_1" value="" size="30" maxlength="16"></td>
    </tr>
    <tr id="type_0">
      <th>*<%=r.getString(teasession._nLanguage, "邮箱：")%></th>
      <td colspan="3"><input type="TEXT" class="edit_input"  name="Email" size="30" maxlength="40"></td>
    </tr>
    <tr id=type_1>
      <th>*<%=r.getString(teasession._nLanguage, "移动电话：")%></th>
      <td colspan="3">
        <input type="TEXT" class="edit_input"  name="mobile" size="30" maxlength="20"></td>
    </tr>
   <!-- <tr>
     <th>* <%=r.getString(teasession._nLanguage, "验证码：")%></th>
    <td><input type="TEXT" class="edit_input"  name="vertify" onchange="f_ajax(this)" size="30" maxlength="20">
    <span id="span_vertify"></span>
     <th><%=r.getString(teasession._nLanguage, "验证码：")%>
      <td><img src="/jsp/registration/validate.jsp" alt="Validate">
    </tr>-->
    <tr>
      <th>*<%=r.getString(teasession._nLanguage, "姓名：")%></th>
      <td><input type="TEXT" class="edit_input"  name="firstname" value="" size="30" maxlength="20">
      </td>
      <th>*<%=r.getString(teasession._nLanguage, "性别：")%></th>
      <td><input id="gender_0" type="radio" name="sex" value="0" checked />
          <label for="gender_0"><%=r.getString(teasession._nLanguage, "男")%></label>
          <input id="gender_1"   type="radio" name="sex" value="1" />
          <label for="gender_1"><%=r.getString(teasession._nLanguage, "女")%></label>
      </td>
    </tr>
    <tr><th nowrap>证件类型 </th>
      <td>
      <select name="cardtype" id="cardtype">
	 <option value="0" selected="selected">居民身份证</option>
	 <option value="1">护照</option>
	 <option value="2">军官证</option>
	 <option value="3">回乡证</option>
	 <option value="4">台胞证</option>
	</select>
      </td>
      <th>证件号码:</th>
      <td colspan="2">
        <input name="card" type="text" value="" size="30" id="card"></td>
    </tr>
    <tr>
    <td align="center">
      <input type="submit" class="edit_button" id="submit"   value=" 注 册 "></td>
    </tr>
  </table>
  </FORM>
<div id="head6"><img height="6" src="about:blank" alt=""></div>
</div>
<div id="jspafter" style="display:none">
<%//=community.getJspAfter(teasession._nLanguage)%>
</div>
</body>
</html>
