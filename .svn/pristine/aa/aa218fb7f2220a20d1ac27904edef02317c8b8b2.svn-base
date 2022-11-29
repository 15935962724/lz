<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.htmlx.*"%>
<%@page import="tea.ui.TeaSession"%>
<%@page import="tea.resource.*" %>
<%@page import="tea.entity.site.*" %>
<%@page import="tea.entity.member.Profile" %>
<jsp:useBean id="sms" scope="page" class="tea.entity.node.Sms" /><%
TeaSession teasession = new TeaSession(request);
Resource r = new Resource("/tea/ui/util/SignUp1").add("/tea/htmlx/HtmlX");

String vertify=sms.password();

Community community=Community.find(teasession._strCommunity);
String nexturt = request.getRequestURI()+"?"+request.getContextPath();

%>
<HTML>
  <HEAD>

    <script src="/tea/tea.js" type="text/javascript"></script>
    <SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/card.js" type="text/javascript"></SCRIPT>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <script>
      window.name='dialog';
//      function submitCheck(form1)
//      {
//        return(
//        submitLength(4,20,form1.MemberId,'<%=r.getString(teasession._nLanguage, "InvalidMemberId")%>')
//        &&submitMemberid(form1.MemberId,'<%=r.getString(teasession._nLanguage, "InvalidMemberId")%>')
//
//        &&submitLength(6,20,form1.EnterPassword,'<%=r.getString(teasession._nLanguage, "InvalidPassword")%>')
//        &&submitIdentifier(form1.EnterPassword,'<%=r.getString(teasession._nLanguage, "InvalidPassword")%>')
//        &&submitEqual(form1.EnterPassword,form1.ConfirmPassword,'<%=r.getString(teasession._nLanguage, "InvalidConfirmPassword")%>')
//
//        );
//      }
      function f_meberid_check(obj)
      {
        var sc=document.getElementById('memberid_check');
        var len=obj.value.length+escape(obj.value).split("%u").length-1;
        if(len<4||len>20)
        {
          sc.innerHTML='<img src=/tea/image/public/check_error.gif> 无效用户名-长度不正确';
        }else
        if(isMemberid(obj.value))
        {
          sc.innerHTML='<img src=/tea/image/public/load.gif>检查中...';
          sendx('/servlet/Ajax?act=checkmember&member='+obj.value,function(bool)
          {
            sc.innerHTML=bool=='true'?'<img src=/tea/image/public/check_error.gif> 该用户已经存在了':'<img src=/tea/image/public/check_right.gif >';
          });
        }else
        {
          sc.innerHTML='<img src=/tea/image/public/check_error.gif> 无效用户名-特殊字符';
        }
      }

      function f_ep_check(obj)
      {
        ep_check.innerHTML=(obj.value.length<6)?'<img src=/tea/image/public/check_error.gif> 无效密码':'<img src=/tea/image/public/check_right.gif >';
      }
      function f_cp_check(obj)
      {


        cp_check.innerHTML=(form1.EnterPassword.value!=form1.ConfirmPassword.value||form1.ConfirmPassword.value.length<6)?'<img src=/tea/image/public/check_error.gif> 密码不相同':'<img src=/tea/image/public/check_right.gif >';
      }

      //登陆和注册方法
      function f_edit(obj)
      {
        var len=form1.MemberId.value.length;
        if(len<4||len>20)
        {
          alert("无效用户名-长度不正确");
          form1.MemberId.select();
          return false;
        }

        if(form1.EnterPassword.value.length<6 ||form1.EnterPassword.value.length>20)
        {
          alert("密码应该在6到20位，重新填写！");
          form1.EnterPassword.select();
          return false;
        }
        if(form1.EnterPassword.value!=form1.ConfirmPassword.value)
        {
          alert("密码和重复密码填写不同，重新填写！");
          form1.ConfirmPassword.select();
          return false;
        }
       if(!isEmail(form1.Email.value))
       {
         alert("邮箱地址不正确！");
         form1.Email.select();
         return false;
       }

        form1.act.value='edit';
        form1.action="/jsp/user/RapidEditUser.jsp";
        form1.submit();
        obj.value="正在验证....";
        obj.disabled=true;
      }
      function f_log(obj)
      {
        if(form1.member.value=='')
        {
          alert("用户名不能为空！");
          form1.member.select();
          return false;
        }
        form1.act.value='log';
        form1.action="/jsp/user/RapidEditUser.jsp";
        form1.submit();
          obj.value="正在验证....";
        obj.disabled=true;
      }
      </script>
<style type="text/css">
#bodynone{width:100%;padding-left:10px;}
#bodynone #tablebgnone .zhucebt{display:block;height:40px;line-height:40px;padding-left:20px;font-size: 14px;font-weight: bold;color:#FF6600;background:url(/res/Home/u/0811/081119151.jpg) no-repeat 0% 50%;}
#ConfirmPassword,#yonghuming,#EnterPassword,#epassword,#member{width:100px;height:18px;line-height:18px;font-size:12px;border:1px solid #BBC0BA;background:#ffffff;}
#bodynone #tablebgnone #dl{color:#006600;background:url(/res/Home/u/0811/081119150.jpg) no-repeat 0% 50%;}
#jihuo{width:80px;height:22px;text-align:center;background:url(/res/Home/u/0811/081119149.jpg) no-repeat;border:0;}
#lzj td{color:#666666;}
</style>
      </HEAD>
      <body id="bodynone" >
      <div id="tablebgnone" class="register">
        <div id="head6"><img height="6" src="about:blank"></div>
          <FORM name=form1 METHOD=POST action="?" target="ifdialog">
            <input type="hidden" name="act" />
            <input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
            <input type="hidden" name="Node" value="<%=teasession._nNode%>"/>
            <input type="hidden" name="commodity" value="<%=request.getParameter("commodity")%>"/>
            <input type="hidden" name="currency" value="<%=request.getParameter("currency")%>"/>
            <input type="hidden" name="strid" value="<%=request.getParameter("strid")%>"/>
             <input type="hidden" name="acts" value="<%=request.getParameter("acts")%>"/>



            <div id="toptu"></div>

 <div id="denglu">
              <span class="zhucebt" id="dl">我是会员，快速登录</span>
        <div id="shurukuang">
          <table width="100%" border="0" align="center" cellpadding="3" cellspacing="0" style="font-size:12px;" id="lzj">
        <tr>
          <td width="16%" nowrap>用户名：</td>
          <td width="28%"><input name="member" type="text" value="" id="member"></td>
          <td width="56%">&nbsp;</td>
        </tr>
        <tr>
          <td>密　码：</td>
          <td><input name="epassword" type="Password" value="" id="epassword"></td>
          <td><input  id="jihuo"name="logname"  type="button" value="登录" onClick="f_log(this);" /></td>
        </tr>
      </table>
       </div>
</div>


      <DIV id=denglu><SPAN class="zhucebt">　不是会员，快速注册</SPAN>
              <div id="shurukuang">
      <table width="100%" border="0" align="center" cellpadding="3" cellspacing="0" style="font-size:12px;" id="lzj">
        <tr>
          <td> <span class="ju">*</span>用户名：</td>
          <td><input name="MemberId" type="text" onKeyPress="if(event.keyCode==32)event.returnValue=false;" onChange="f_meberid_check(this);" id="yonghuming"></td>
          <td colspan="2"> <span id="memberid_check"></span> </span> 4-20字符，可以使用字母、中文字符</td>
        </tr>
        <tr>
          <td> <span class="ju">*</span>密　码：</td>
          <td><input name="EnterPassword" type="Password" id="EnterPassword" onBlur="f_ep_check(this);"></td>
          <td colspan="2"> <span id="ep_check"></span> 不能少于6个字符</td>
        </tr>
        <tr>
          <td nowrap> <span class="ju">*</span>重复密码：</td>
          <td><input name="ConfirmPassword" type="Password" id="ConfirmPassword" onBlur="f_cp_check(this);"></td>
          <td colspan="2"> <span id="cp_check"></span> 请再输入一次密码</td>
        </tr>
        <tr>
          <td><span class="ju">*</span>邮箱地址：</td>
          <td> <input name="Email" type="text" id="yonghuming" ></td>
          <td colspan="2">   <span id="email_check"></span>  当您忘记密码时，可通过邮箱取回密码</td>
        </tr>
        <tr>
          <td><span class="ju">*</span> 验证码：</td>
          <td><INPUT id="yonghuming" name=vertify ></td>
          <td nowrap><img src="validate.jsp"></td>
          <td>   </td>
        </tr>
        <tr>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td height="33" colspan="2"><INPUT name="editname" id="jihuo" type=submit value=快速注册 onClick="f_edit(this);"></td>
        </tr>
      </table>

      </div>

</DIV>
<iframe name="ifdialog" style="display:none"></iframe>
          </FORM>

          </div>

      </body>
</HTML>
