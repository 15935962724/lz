<%@page contentType="text/html;charset=UTF-8"%>
<%@page import="tea.htmlx.*"%>
<%@page import="tea.ui.TeaSession"%>
<%@page import="tea.resource.*"%>
<%@page import="tea.entity.site.*"%>
<%@page import="tea.entity.member.*"%>
<%@page import="java.net.*"%>
<%
  request.setCharacterEncoding("UTF-8");
  String act = request.getParameter("act");
  if (act != null) {
    String value = request.getParameter("value");
    if (act.equals("vertify")) {
      out.print(value.equals(session.getAttribute("sms.vertify")));
    }
    return;
  }
%>
<jsp:useBean id="sms" scope="page" class="tea.entity.node.Sms"/>
<%
  TeaSession teasession = new TeaSession(request);
  if (teasession._rv == null) {
    response.sendRedirect("/servlet/StartLogin?node"+teasession._nNode);
    return;
  }
  Resource r = new Resource("/tea/ui/util/SignUp1").add("/tea/htmlx/HtmlX");
  Community community = Community.find(teasession._strCommunity);
  String nexturl = request.getParameter("nexturl");
  String member = request.getParameter("member");
  Profile obj = null;

    obj = Profile.find(member);


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
      if(
      submitEmail(form.email,'无效-邮箱')
      &&submitText(form.mobile,'无效-移动电话')
      &&submitInteger(form.mobile,'无效-移动电话')
      &&submitLength(11,12,form.mobile,'无效-移动电话')
      &&submitText(form.vertify,'无效-验证码')
      &&submitText(form.firstname,'无效-姓名')
      &&submitText(form.card,'无效-证件号码')
      )
      {
        //if(form.cardtype.value=="0"){alert("请选择证件!");return false;}
        if(document.getElementById('cardtype').value=='0')
        {
          var len = document.getElementById('card').value.length;
          if(len==15||len==18)
          {}
          else
          {
            alert('无效-身份证');
            return false;
          }
        }
      }
      else
      {
        return false;
      }
    }


    function f_ajax(obj1)
    {
      var act=obj1.name;
      var sv=document.getElementById('span_'+act);
      if(obj1.value=="")
      {
        sv.innerHTML="<img src=/tea/image/public/check_error.gif>不能为空";
        return;
      }
      sv.innerHTML="<img src=/tea/image/public/load.gif>";
      sendx(location.href+"&act="+act+"&value="+obj1.value,function(v)
      {
        if(v.indexOf('true')!=-1)
        {
          sv.innerHTML="<img src=/tea/image/public/check_right.gif>";
        }else
        {
            sv.innerHTML="<img src=/tea/image/public/check_error.gif>输入错误!请重新输入";
        }
      }
      )
    }

    function submitSelect2(select, alerttext) {

	if(select.selectedIndex==0)
        {
          alert(alerttext);
          select.focus();
          return false;
        }else
        {
          return true;
        }

}



    </script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body id="bodynone" class="register">
<div id="jspbefore" style="display:none"><%=community.getJspBefore(teasession._nLanguage)%></div>
<div id="tablebgnone" class="register">
  <h1><%=r.getString(teasession._nLanguage, "用户资料查看修改")%>  </h1>
  <div id="head6">
    <img height="6" src="about:blank" alt="">
  </div>
  <FORM name="form1" METHOD="POST" ACTION="/servlet/hyedituser" onSubmit="return (check(this));">
  <input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
  <input type="hidden" name="Node" value="<%=teasession._nNode%>"/>
  <input type="hidden" name="Language" value="<%=teasession._nLanguage%>"/>
  <input type="hidden" name="nexturl" value="<%=nexturl%>"/>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter" align="left">
    <tr>
      <th>        *
        <%=r.getString(teasession._nLanguage, "会员ID：")%>      </th>
      <td colspan="4"><%=obj.getMember()%>        <input type="hidden" value="<%=obj.getMember()%>" name="member"/>
      </td>
    </tr>
    <tr id="type_0">
      <th> *
        <%=r.getString(teasession._nLanguage, "邮箱：")%>      </th>
      <td colspan="3">
        <input type="TEXT" class="edit_input" name="email" size="30" maxlength="40" value="<%=obj.getEmail()%>">
      </td>
    </tr>
    <tr id=type_1>
      <th>*<%=r.getString(teasession._nLanguage, "移动电话：")%>      </th>
      <td  colspan="3">
        <input type="TEXT" class="edit_input" name="mobile" size="30" maxlength="20" value="<%=obj.getMobile()%>">
      </td>

    <tr>
     <!-- <th>        *
<%=r.getString(teasession._nLanguage, "验证码：")%>      </th>
      <td>
        <input type="TEXT" class="edit_input" name="vertify" onChange="f_ajax(this)" size="30" maxlength="20">
        <span id="span_vertify"></span>
      </td>
      <th><%=r.getString(teasession._nLanguage, "验证码：")%>      </th>
      <td>
        <img src="/jsp/registration/validate.jsp" alt="Validate">
      </td>
    </tr>
    <tr>-->
      <th>        *
<%=r.getString(teasession._nLanguage, "姓名：")%>      </th>
    <%    %>
      <td>
        <input type="TEXT" class="edit_input" name="firstname" value="<%=obj.getFirstName(teasession._nLanguage)%>" size="30" maxlength="20">
      </td>
      <th>        *
<%=r.getString(teasession._nLanguage, "性别：")%>   </th>
      <td>
        <input id="gender_0" type="radio" name="sex" value="1" checked/>
        <label for="gender_0"><%=r.getString(teasession._nLanguage, "男")%>        </label>
        <input id="gender_1" type="radio" name="sex" value="0" <%if(!obj.isSex())out.println("checked");%>/>
        <label for="gender_1"><%=r.getString(teasession._nLanguage, "女")%>        </label>
      </td>
    </tr>
    <tr>
      <th nowrap>证件类型</th>
      <td>
        <select name="cardtype">

        <%
          for (int i = 0; i < Common.CARDT_TYPE.length; i++) {
            out.print("<option value=" + i);
            if (i == obj.getCardType()) {
              out.print(" selected ");
            }
            out.print(">" + Common.CARDT_TYPE[i]);
          }
        %>
        </select>
      </td>
      <th>证件号码:</th>
      <td colspan="2">
        <input name="card" type="text" value="<%=obj.getCard()%>" size="30">
      </td>
    </tr>
    <tr>
      <td align="center">
        <input type="submit" class="edit_button" id="edit_submit" value="<%=r.getString(teasession._nLanguage, " 修 改 ")%>">
      </td>
      <td>
        <input type="button" value="修改密码" onClick="javascript:window.open('/jsp/registration/ChangePassword.jsp','anyname','width=500,height=200')"/>
      </td>
    </tr>
  </table>
  </FORM>
  <div id="jspafter" style="display:none"><%=community.getJspAfter(teasession._nLanguage)%>  </div>
</body>
</html>
