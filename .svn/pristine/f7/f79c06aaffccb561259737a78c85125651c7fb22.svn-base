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

%>
<HTML>
  <HEAD>
    <title>B-picture会员-完善买家资料</title>

<script src="/tea/tea.js" type="text/javascript"></script>
<script type="">
function check(form)
{
 if(document.getElementById('rep1').checked)
 {
   return submitjob(form.state,'请选择所属地区')
  &&submitInteger(form.zip,'无效-邮编');
 }else{
   return submitText(form.comname,'无效-公司名称')
  &&submitjob(form.comstyle,'请选择公司类型')
  &&submitjob(form.state,'请选择所属地区')
  &&submitInteger(form.zip,'无效-邮编');
 }

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


</script>
<style>

.t{margin:12px 0;height:20px;line-height:20px;width:100%;font-size:14px;font-weight:bold;background:url(/res/bigpic/u/0812/081243709.gif) no-repeat 25 2;padding-left:45px;}
#tablecenter002{background:#F6F6F6;border-top:10px solid #eeeeee;font-size:12px;line-height:150%;}
#lzj_an{width:45px;height:23px;background:url(/res/bigpic/u/0812/081243710.jpg) no-repeat;border:0;margin:0 10px;}
#txtfirstName,#txtPwd1,#txtPwd2,#selJobTitle,#selCompanyType,#txtzip,#txtMobilePhone{width:200px;height:22px;border:1px solid #809EBA;background:#fff;line-height:22px;font-size:12px;}
#txtEmail,#txtJobTitleOther,#txtCompanyTypeOther,#txtCompany,#txtCompanyWebsite,#txtaddr1,#txtstate,#txtzip,#txtContactPhone{width:300px;height:22px;border:1px solid #809EBA;background:#fff;line-height:22px;font-size:12px;}

</style>
</HEAD>
<body style="margin:0;padding:0;">

<div class="t">完善买家资料</div>

  <form name="reg" action="/servlet/EditBPperson" method="post" onSubmit="return(check(this));">
<input type="hidden" name="regstyle" value="1"/>
<input type="hidden" name="member" value="<%=member%>"/>
<input type="hidden" name="act" value="regbuy"/>
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
    <!--<tr>
      <td align="right" height="43">工作类型</td>
      <td class="red" align="center" height="43"><span style="color:#0265CB;"><b>*</b></span></td>
      <td height="43"><select name="jobstyle" id="selJobTitle" tabindex="61">
        <option value="">请选择 ...</option>
        <%
                for(int i=0;i<Common.JOBSTYLE.length;i++)
                {
                  out.print("<option value="+Common.JOBSTYLE[i][0]+" >"+Common.JOBSTYLE[i][1]);
                }
                %>
</select></td>
    </tr>
    <tr>
      <td align="right">(其他)</td>
      <td>&nbsp;</td>
      <td><input name="jobother" type="text" maxlength="80" id="txtJobTitleOther" tabindex="62" size="35" /></td>
    </tr>-->
<tr>
<td valign="top" align="right">您所代表的是</td>
<td></td>
<td><input id="rep1" type="radio" name="represent" value="1" checked="checked" onclick="showcom('1')"/>&nbsp;个人<br/>
<input id="rep2" type="radio" name="represent" value="0" onclick="showcom('2')"/>&nbsp;公司</td>
</tr>
    <tr>
      <td colSpan="3">&nbsp;</td>
    </tr>
    <tr>
<tr id="com1" style="display:none;">
      <td align="right">公司名称</td>
      <td class="red" align="center"><span id="lblMandatory"><span style="color:#0265CB;"><b>*</b></span></span></td>
      <td><input name="comname" type="text" maxlength="100" id="txtCompany" tabindex="21" size="21"/></td>
    </tr>
    <tr id="com2" style="display:none;">
      <td align="right">公司类型</td>
      <td align="center"><span style="color:#0265CB;"><b>*</b></span></td>
      <td><select name="comstyle" id="selCompanyType" tabindex="22">
        <option value="">请选择...</option>
  <%
                for(int i=0;i<Common.COMPANYSTYLE.length;i++)
                {
                  out.print("<option value="+Common.COMPANYSTYLE[i][0]+" >"+Common.COMPANYSTYLE[i][1]);
                }
                %>
</select></td>
    </tr>
    <!--<tr>
      <td align="right">(其他)</td>
      <td>&nbsp;</td>
      <td><input name="comother" type="text" maxlength="50" id="txtCompanyTypeOther" tabindex="64" size="35" /></td>
    </tr>
    <tr>
      <td align="right">网站</td>
      <td>&nbsp;</td>
      <td><input name="web" type="text" maxlength="80" id="txtCompanyWebsite" tabindex="68" size="35" /></td>
    </tr>
    <tr>
      <td colSpan="3">&nbsp;</td>
    </tr>-->
    <tr>
      <td align="right">所属地区</td>
      <td class="red" align="center"><span style="color:#0265CB;"><b>*</b></span></td>
      <td> <select id="state" name="state" tabindex="23">
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
      <td height="28"><input name="city" type="text" maxlength="35" id="txtstate" tabindex="24" size="35"/></td>
    </tr>
    <tr>
      <td align="right">地址</td>
      <td class="red" align="center"></td>
      <td><input name="addr" type="text" maxlength="35" id="txtaddr1" tabindex="25" size="35" /></td>
    </tr>

    <tr>
      <td align="right">邮编</td>
      <td class="red" align="center"></td>
      <td><input name="zip" type="text" maxlength="25" id="txtzip" tabindex="26" size="35"/></td>
    </tr>

    <tr>
      <td colSpan="3">&nbsp;</td>
    </tr>


			<tr vAlign="top">
			  <td height="40" colspan="3" align="center" valign="middle"> <input type="submit" tabindex="28" value="完成" id="lzj_an"/></td>

  </table>
  </form>

    <script type="">
    function showcom(value)
  {
    if(value=='1')
    {
      document.getElementById('com1').style.display='none';
      document.getElementById('com2').style.display='none';
    }else{
      document.getElementById('com1').style.display='';
      document.getElementById('com2').style.display='';
    }
  }
    </script>
</body>

</HTML>

