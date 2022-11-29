<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="java.math.*" %>
<%@ page import="tea.entity.member.*" %>
<%@ page import="tea.db.DbAdapter" %>
<%@ page import="tea.resource.*" %>
<%@ page import="tea.entity.node.*" %>
<%@ page import="tea.entity.admin.*" %>
<%@ page import="tea.ui.*" %>
<%@ page import="tea.entity.site.*" %>
<%
request.setCharacterEncoding("UTF-8");
TeaSession teasession=new TeaSession(request);


String nexturl = teasession.getParameter("nexturl");
String currency = teasession.getParameter("currency");
String buys[] = teasession.getParameterValues("buys");
session.setAttribute("buys",buys);
tea.entity.site.Community community = tea.entity.site.Community.find(teasession._strCommunity);


if(request.getParameter("changequantity") != null)//修改数量
{
  int i=0;
  do
  {
    String s1 =  request.getParameter("buy" + i);
    if(s1 != null)
    {
      int quantity = Integer.parseInt(request.getParameter("quantity" + i));
      ShoppingCarts scobj =ShoppingCarts.find(Integer.parseInt(s1));
//      Buy buy = Buy.find(Integer.parseInt(s1));
//      buy.set(quantity);
      scobj.set(quantity);
      i++;
    } else
    {
      response.sendRedirect(nexturl);
      return;
    }
  } while(true);
}else if(request.getParameter("clearsc") != null)//清空购物车
{
  int i = 0;
  do
  {
    String s1 =  request.getParameter("buy" + i);
    if(s1 != null)
    {
//      Buy buy = Buy.find(Integer.parseInt(s1));
//      buy.delete();
ShoppingCarts scobj =ShoppingCarts.find(Integer.parseInt(s1));
scobj.delete();
      i++;
    } else
    {
      response.sendRedirect(nexturl);
      return;
    }
  } while(true);
}else if(request.getParameter("delete")!=null)//删除
{
  int scid = Integer.parseInt(teasession.getParameter("scid"));
  ShoppingCarts scobj = ShoppingCarts.find(scid);
  scobj.delete();
  response.sendRedirect(nexturl);
  return;
}








%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/card.js" type="text/javascript"></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
    <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
      <META HTTP-EQUIV="Expires" CONTENT="0">
     <SCRIPT LANGUAGE=JAVASCRIPT SRC="<%=community.getJspBeforePath(teasession._nLanguage)%>" type="text/javascript"></SCRIPT>


      <script type="">
       function f_log(obj)
       {
          if(formlog1.member.value=='')
          {
            alert('请填写用户名！');
            formlog1.member.select();
            return false;
          }
           if(formlog1.epassword.value=='')
          {
            alert('请填写密码！');
            formlog1.epassword.select();
            return false;
          }
          formlog1.act.value='log';
          formlog1.action="/jsp/offer/EditLogin.jsp";
          formlog1.submit();
          obj.value="正在验证....";
          obj.disabled=true;
       }

       //登陆和注册方法
      function f_edit(obj)
      {
        var len=formlog1.MemberId.value.length;
        if(len<4||len>20)
        {
          alert("无效用户名-长度不正确");
          formlog1.MemberId.select();
          return false;
        }

        if(formlog1.EnterPassword.value.length<6 ||formlog1.EnterPassword.value.length>20)
        {
          alert("密码应该在6到20位，重新填写！");
          formlog1.EnterPassword.select();
          return false;
        }
        if(formlog1.EnterPassword.value!=formlog1.ConfirmPassword.value)
        {
          alert("密码和重复密码填写不同，重新填写！");
          formlog1.ConfirmPassword.select();
          return false;
        }
       if(!isEmail(formlog1.Email.value))
       {
         alert("邮箱地址不正确！");
         formlog1.Email.select();
         return false;
       }

        formlog1.act.value='edit';
        formlog1.action="/jsp/offer/EditLogin.jsp";
        formlog1.submit();
        obj.value="正在验证....";
        obj.disabled=true;
      }

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


        cp_check.innerHTML=(formlog1.EnterPassword.value!=formlog1.ConfirmPassword.value||formlog1.ConfirmPassword.value.length<6)?'<img src=/tea/image/public/check_error.gif> 密码不相同':'<img src=/tea/image/public/check_right.gif >';
      }

      </script>
  <body id="lzj_nei">
<div id="lzj_nei1">
<form name="formlog1" method="POST" action="?" target="ifdialog">
<input type="hidden" name="act" />
<input type="hidden" name="nexturl" value="<%=nexturl%>"/>
<input type="hidden" name="currency" value="<%=currency%>"/>

        <table border="0" cellpadding="0" cellspacing="0" id="lzjtablecenter">
          <tr id="lzjtable">
            <td colspan="2">用户登陆</td>
          </tr>
          <tr id="lzjtable1">
            <td colspan="2">已经注册用户请从这里登陆</td>
          </tr>
          <tr>
            <td width="85" align="right">用户名： </td>
            <td width="292"><input type="text" name="member" value="" id="lzj_name"/></td>
          </tr>
          <tr>
            <td width="85" align="right">密码：</td>
            <td width="292"><input type="password" name="epassword" value="" id="lzj_password"/></td>
          </tr>
          <tr>
            <td width="85">&nbsp;</td>
            <td width="292"><A href="/servlet/RetrievePassword?node=3952&Language=1">忘记密码怎么办？</A></td>
          </tr>
          <tr>
            <td width="85">&nbsp;</td>
            <td width="292" height="70"><input type="button" name="logname" value="登陆" onClick="f_log(this);" id="lzj_button"/></td>
          </tr>
		  <tr id="lzj_kun">
		    <td colspan="2">&nbsp;</td>
		  </tr>
    </table>

        <table border="0" cellpadding="0" cellspacing="0" id="lzjtablecenter1">
          <tr id="lzjtable">
            <td colspan="3">新用户注册</td>
          </tr>
          <tr id="lzjtable1">
            <td colspan="3">新用户在这里注册</td>
          </tr>
          <tr>
            <td width="115" align="right">用户名： </td>
              <td width="160"><input name="MemberId" type="text" onKeyPress="if(event.keyCode==32)event.returnValue=false;" onChange="f_meberid_check(this);" id="yonghuming"></td>
              <td colspan="2" width="275"> <span id="memberid_check"></span>  4-20字符，可以使用字母、中文字符</td>
          </tr>
          <tr>
            <td width="115" align="right">密码：</td>
            <td width="160"><input name="EnterPassword" type="Password" id="EnterPassword" onBlur="f_ep_check(this);"></td>
            <td colspan="2" width="275"> <span id="ep_check"></span> 不能少于6个字符</td>
          </tr>
          <tr>
            <td width="115" align="right">确认密码：</td>
              <td width="160"><input name="ConfirmPassword" type="Password" id="ConfirmPassword" onBlur="f_cp_check(this);"></td>
              <td colspan="2" width="275"> <span id="cp_check"></span> 请再输入一次密码</td>
          </tr>

        <tr>
          <td width="115" align="right">邮箱地址：</td>
          <td width="160"><input name="Email" type="text" id="yonghuming" ></td>
          <td colspan="2" width="275">   <span id="email_check"></span>  当您忘记密码时，可通过邮箱取回密码</td>
        </tr>
           <tr>

          <td width="115" align="right">验证码：</td>
          <td width="160"><INPUT id="yonghuming" name=vertify ></td>
          <td width="275" nowrap><img src="/jsp/user/validate.jsp"></td>
        </tr>

          <tr>
            <td width="115" height="70">&nbsp;</td>
            <td colspan="2"><INPUT name="editname" id="buttom1" type="submit" value="快速注册" onClick="f_edit(this);"></td>
          </tr>
    </table>



  </form>

<div id="lzj_wu"></div>
        <iframe name="ifdialog" style="display:none"></iframe>
		</div>
</body>


</html>

<SCRIPT LANGUAGE=JAVASCRIPT SRC="<%=community.getJspAfterPath(teasession._nLanguage)%>" type="text/javascript"></SCRIPT>

