<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="tea.htmlx.*"%>
<%@ page import="tea.ui.TeaSession"%>
<%@ page import="tea.resource.*" %>
<%@ page import="tea.entity.site.*" %>
<%@ page import="tea.entity.bpicture.*" %>
<%
TeaSession teasession =new TeaSession(request);
Community community=Community.find(teasession._strCommunity);
Resource r = new Resource("/tea/ui/util/SignUp1").add("/tea/htmlx/HtmlX");
String member = request.getParameter("member");
String password = request.getParameter("password");
%>
<HTML>
  <HEAD>
    <title>B-picture会员-注册</title>

<script src="/tea/tea.js" type="text/javascript"></script>
<script type="">
function check(form)
{
  return submitText(form.name,'无效-姓名')
  &&submitText(form.mobile,'无效-手机')
  &&submitInteger(form.mobile,'无效-手机')
  &&submitLength(11,12,form.mobile,'无效-手机')
  &&submitInteger(form.phone,'无效-联系电话')
  &&submitText(form.comname,'无效-公司名称')
  &&submitjob(form.comstyle,'请选择公司类型')
  &&submitjob(form.state,'请选择所属地区')
  &&submitInteger(form.zip,'无效-邮编')
  &&submitterms(form.terms,'无效-协议');
}
function submitInteger(text, alerttext)
{if(text.value.length>0){
	if (isNaN(parseInt(text.value)))
	{
		alert(alerttext);
		text.focus();
		return false;
	}
	text.value=parseInt(text.value);
	return true;
      }
        return true;
}
function submitjob(text,alerttext)
{
  if(text.value.length==0||text.value=='00')
  {
    alert(alerttext);
    text.focus();
    return false;
  }
  return true;
}

function submitterms(text,alerttext)
{
  if(!text.checked){
    alert(alerttext);
    text.focus();
    return false;
  }
  return true;
}
function submitEmail(text, alerttext)
{
	var   strReg="";
	var   r;
	var str = text.value;
        if(str.length>0){
          strReg=/^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/i;
          r=str.search(strReg);
          if(r==-1)
          {
            alert(alerttext);
            text.focus();
            return false;
          }

          return true;
        }
        return true;
}


</script>
<style>
#dv1{width:100%;text-align:right;font-size:12px;height:55px;background:url(/res/bigpic/u/0812/081255616.jpg) no-repeat 10 5;color:#0000CC;}
.lzj_a{margin:0 10px;color:#0000CC; text-decoration:none;margin-top:8px;}
#tablecenter001{border-top:1px solid #67A7E4;background:#D6E6FF;font-size:12px;color:#000;height:28px;line-height:28px;padding-left:15px;}
#tablecenter001 a{color:#0000ff;}
.t{margin:12px 0;height:20px;line-height:20px;width:100%;font-size:14px;font-weight:bold;background:url(/res/bigpic/u/0812/081243709.gif) no-repeat 25 2;padding-left:45px;}
#tablecenter002{background:#F6F6F6;border-top:10px solid #eeeeee;font-size:12px;line-height:150%;}
#lzj_an{width:45px;height:23px;background:url(/res/bigpic/u/0812/081243710.jpg) no-repeat;border:0;margin:0 10px;}
#txtfirstName,#txtPwd1,#txtPwd2,#selJobTitle,#selCompanyType,#txtzip,#txtMobilePhone{width:200px;height:22px;border:1px solid #809EBA;background:#fff;line-height:22px;font-size:12px;}
#txtEmail,#txtJobTitleOther,#txtCompanyTypeOther,#txtCompany,#txtCompanyWebsite,#txtaddr1,#txtstate,#txtzip,#txtContactPhone{width:300px;height:22px;border:1px solid #809EBA;background:#fff;line-height:22px;font-size:12px;}
.top{border-top:1px solid #cccccc;margin-top:19px;}
.top td{font-size:12px;line-height:150%;}
.top td a{color:#0000CC;}
</style>
</HEAD>
<body style="margin:0;padding:0;">
 <div id="jspbefore">
    <%=community.getJspBefore(teasession._nLanguage)%>
  </div>
 <div style="text-align:left;" id="li_biao">　><a href="http://bp.redcome.com">首页</a>>注册</div>
<div class="t">注册</div>

  <form name="reg" action="/servlet/EditBPperson" method="post" onSubmit="return(check(this));">
<input type="hidden" name="regstyle" value="0"/>
<input type="hidden" name="member" value="<%=member%>"/>
<input type="hidden" name="password" value="<%=password%>"/>
<input type="hidden" name="act" value="reg"/>
  <table cellSpacing="0" cellPadding="2" width="700" align="center" border="0" id="tablecenter002">

  </table>
  <table cellSpacing="0" cellPadding="2" width="700" align="center" border="0" id="tablecenter002" style="border:0;border-bottom:10px solid #eeeeee;">

  <tr>
      <td width="8" rowSpan="30"><IMG height="1" src="Images/s.gif" width="4"></td>
        <td height="40" colSpan="2"><strong>基本信息</strong></td>
        <td align="right"><span style="color:#0265CB;"><strong>*</strong></span>
          表示必须填写</td>
          <td width="8" rowSpan="11"><IMG height="1" src="Images/s.gif" width="4"></td>
    </tr>
    <tr>
      <td align="right">姓名</td>
      <td class="red" align="center"><span style="color:#0265CB;"><b>*</b></span></td>
      <td><input name="name" type="text" maxlength="50" id="txtfirstName" tabindex="15" size="35" /></td>
    </tr>
    <!--<tr>
      <td align="right">Email</td>
      <td class="red" align="center"><span style="color:#0265CB;"><b>*</b></span></td>
      <td><input name="email" type="text" maxlength="50" id="txtEmail" tabindex="16" size="35" /></td>
    </tr>-->
    <tr>
      <td  align="right">性别</td>
     <td class="red" align="center"><span style="color:#0265CB;"><b>*</b></span></td>
      <td><select name="sex" id="DrpTitle" tabindex="17">
        <option selected="selected" value="1">男</option>
        <option value="0">女</option>
</select></td>
    </tr>
    <tr>
      <td align="right"><span id="lblMobile">手机</span></td><!--Mobile / Cell-->
      <td class="red" align="center"><span style="color:#0265CB;"><b>*</b></span></td>
      <td><input name="mobile" type="text" maxlength="50" id="txtMobilePhone" tabindex="18" size="35" /></td>
    </tr>

    <tr>
      <td align="right"><span id="lblTelephone">联系电话</span></td><!--Telephone-->
      <td>&nbsp;</td>
      <td><input name="phone" type="text" maxlength="50" id="txtContactPhone" tabindex="19" size="35"/></td>
    </tr>
   <tr>
      <td align="right">MSN</td>
      <td class="red" align="center"></td>
      <td><input name="MSN" type="text" maxlength="50" id="txtEmail" tabindex="20" size="35" /></td>
    </tr>

    <tr>
      <td align="right">所属地区</td>
      <td class="red" align="center"><span style="color:#0265CB;"><b>*</b></span></td>
      <td> <select id="state" name="state" tabindex="21">
            <%
                for(int i=0;i<Common.CSVCITYS.length;i++)
                {
                  out.print("<option value="+Common.CSVCITYS[i][0]+" >"+Common.CSVCITYS[i][1]);
                }
                %>
          </select></td>
    </tr>
    <tr>
      <td align="right" height="28">城市</td>
      <td class="red" align="center" height="28"></td>
      <td height="28"><input name="city" type="text" maxlength="35" id="txtstate" tabindex="22" size="35"/></td>
    </tr>
    <tr>
      <td align="right">地址</td>
      <td class="red" align="center"></td>
      <td><input name="addr" type="text" maxlength="35" id="txtaddr1" tabindex="23" size="35" /></td>
    </tr>

    <tr>
      <td align="right">邮编</td>
      <td class="red" align="center"></td>
      <td><input name="zip" type="text" maxlength="25" id="txtzip" tabindex="24" size="35"/></td>
    </tr>
<tr>
      <td align="right">从事摄影年限</td>
      <td class="red" align="center"></td>
      <td> <select id="state" name="photoyear" tabindex="25">
            <%
                for(int i=0;i<Common.PHOTOYEAR.length;i++)
                {
                  out.print("<option value="+Common.PHOTOYEAR[i][0]+" >"+Common.PHOTOYEAR[i][1]);
                }
                %>
          </select></td>
    </tr>
    <tr>
      <td align="right">主要摄影题材</td>
      <td class="red" align="center"></td>
      <td> <table style="font-size:12px;line-height:150%;">
      <tr>

            <%
                for(int i=0;i<Common.PHMETERIA.length;i++)
                {

                  out.print("<td><input type=checkbox name=meteria value="+Common.PHMETERIA[i][0]+" >"+Common.PHMETERIA[i][1]+"</td>");
                  if(i==4)
                  {
                  out.print("</tr><tr>");
                  }
                }
                %>
                </tr>
                </table>
          </td>
    </tr>
     <tr>
      <td align="right">作品主要载体</td>
      <td class="red" align="center"></td>
      <td> <table style="font-size:12px;line-height:150%;">
      <tr>

            <%
                for(int i=0;i<Common.PHVECTOR.length;i++)
                {
                  out.print("<td><input type=checkbox name=vector value="+Common.PHVECTOR[i][0]+" >"+Common.PHVECTOR[i][1]+"</td>");
               if(i==2)
                  {
                  out.print("</tr><tr>");
                  }
                }
                %>
                </tr>
                </table>
          </td>
    </tr>
    <tr>
      <td colSpan="3">&nbsp;</td>
    </tr>
 <tr vAlign="top">
      <td>&nbsp;</td><td colspan="3">　&nbsp;&nbsp;<input type="checkbox" name="mailto" value="1"/>是否接受来自B-p的电子信</td>
    </tr>
    <tr>
      <td>&nbsp;</td>
      <td class="red" align="center"><span style="color:#0265CB;"><b>*</b></span></td>
      <td>&nbsp;<span style="width:16px;"><input id="chkTerms" type="checkbox" name="terms" value="1" tabindex="26" /><label for="terms"> </label></span>我接受并同意B-p网站 <A href="javascript:window.showModalDialog('/servlet/Node?node=2198280','_top','dialogWidth:450px;dialogHeight:600px;dialogLeft:750px;dialogTop:240px;');">
          用户服务条款</A></td>
    </tr>

			<tr vAlign="top">
			  <td height="40" colspan="3" align="center" valign="middle"> <input type="submit" value="注册" id="lzj_an"/></td>

  </table>
  </form>
<div id="jspafter">
      <%=community.getJspAfter(teasession._nLanguage)%>
    </div>
</body>

</HTML>

