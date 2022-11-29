<%@page import="tea.entity.MT"%>
<%@page contentType="text/html;charset=UTF-8"%>
<%@page import="tea.entity.Http"%>
<%@page import="tea.htmlx.*"%>
<%@page import="tea.resource.*"%>
<%@page import="tea.entity.site.*"%>
<%@page import="tea.entity.member.Profile"%>
<%
  request.setCharacterEncoding("UTF-8");
  Http h = new Http(request);
  
  String act = h.get("act");

  if (act != null) {
    String value = h.get("value");
    
    if (act.equals("verify")) {
      out.print(MT.dec(h.getCook("verify",null)).equalsIgnoreCase(value));
    }
    else if (act.equals("member")) {
      out.print(!Profile.isExisted(value));//&&!Profile.isLExisted(value,teasession._nLanguage));
    }
    return;
  }
%>

<SCRIPT LANGUAGE="JAVASCRIPT" SRC="/tea/tea.js" type="text/javascript"></SCRIPT>
<SCRIPT LANGUAGE="JAVASCRIPT" SRC="/tea/mt.js" type="text/javascript"></SCRIPT>
<div class="numLog">
  <div class="logintit"><b>用户注册</b></div>
      <div class="denglu">
        <form action="/Members.do" target="_ajax" onsubmit="return mt.checkFlag()&&mt.check(this)" name="form1">
          <input type="hidden" name="act" value="register">
          <input type="hidden" name="checkFlag">
          <input type="hidden" name="nexturl" value="/">
          <table>
         	 <tr>
                  <td class="sp1">会员模型：</td>
                  <td>
                  	<input name="type" type="radio" value="2" checked="checked">普通会员
                  </td>
              </tr>
              <tr>
                  <td class="sp1">用户名：</td>
                  <td>
                  	<input type="text" name="member" min="3" alt="用户名" onblur="f_ajax(this)" value="" class="texts">
                  	<span id="span_member"></span>
                  </td>
              </tr>
			  <tr>
			      <td class="sp1">密码：</td>
			      <td><input type="password" name="password" alt="密码" min="6" value="" class="texts"></td>
			  </tr>
			  <tr>
			      <td class="sp1">确认密码：</td>
			      <td><input type="password" name="password2" alt="确认密码" value="" class="texts"></td>
			  </tr>
			  <tr>
                  <td class="sp1">邮箱：</td>
                  <td><input type="text" name="email" alt="邮箱" value="" class="texts"></td>
              </tr>
              <tr>
                  <td class="sp1">昵称：</td>
                  <td><input type="text" name="firstname" min="3" alt="昵称" value="" class="texts"></td>
              </tr>
			  <tr>
			      <td class="sp1">验证码：</td>
			      <td>
			      	<input style="text-transform: uppercase; width:93px;" alt="验证码" onfocus="mt.verifys()" onchange="f_ajax(this)" onblur="f_ajax(this)" maxlength="4" name="verify" autocomplete="off" class="input" style='width:100px'>
			      	<a href="javascript:mt.verifys()"><img id="img_verifys" src="/Imgs.do?act=verify&amp;t=0.8841180045674784" alt="" style="visibility: visible;"></a>
			      	<span id="span_verify"></span>
				  </td>
			  </tr>
			  <tr>
			      <td></td>
			      <td style="color:#999;">
			      	<input name="tiaokuan" alt="服务条款" type="checkbox" style="position:relative;top:2px;margin-right:4px;"  />
			      	<label for="agree">我已阅读并同意</label>《<a id="tk" href="/html/folder/14103029-1.htm" style="color:#999;">服务条款</a>》
			      </td>
			  </tr>
			  <tr>
			  	<td colspan="2"><input type="submit" value="注册"></td>
			  </tr>
		</table>
	</form>
	<script type="text/javascript">
		function f_ajax(obj)
		{
		  var act=obj.name;
		  var sv=document.getElementById('span_'+act);
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
		      }else if(obj.name=="verify"){
		      	  sv.innerHTML="<img src=/tea/image/public/check_right.gif>";
		      }
		      form1.checkFlag.value="";
		    }else
		    {
		      if(obj.name=="member")
		      {
		          sv.innerHTML="<img src=/tea/image/public/check_error.gif>用户名已存在";
		      }else if(obj.name=="verify")
		      {
		          sv.innerHTML="<img src=/tea/image/public/check_error.gif>抱歉，验证码错误！";
		      }
		      obj.focus();
		      form1.checkFlag.value=obj.name;
		    }
		  }
		  )
		}
		mt.checkFlag=function(){
			var flag = form1.checkFlag.value;
			if(flag!="")
				mt.show("输入不正确,请重新输入!");
			return flag=="";
		};
	</script>
	</div>
</div>



