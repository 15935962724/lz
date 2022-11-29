<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter"%>
<%@ page import="tea.resource.Resource"%>
<%@ page import="tea.resource.Common" %>
<%@ page import="tea.entity.admin.*" %>
<%@ page import="tea.ui.TeaSession" %>
<%@ page import="java.io.*" %>
<%@ page import="tea.entity.admin.sales.*" %>
<%@ page import="java.util.Date" %>



<style>
#intro1{width:100%;float:left;margin:0 auto;}
#cont1{line-height:150%;}
#intro4{width:20%;float:left;color:#999999;margin-top:10px;border-left:1px solid #DBDBDB}
#intro4 li{list-style:none;}
#intro4 ul{margin-left:5px;}
#Content2{padding-left:0px;}
#regi{text-align:center;width:100%;}
#xiangguan{color:#E00A1D;width:100%;border:1px solid #DBDBDB;line-height:200%;vertical-align:middle;text-align:center;border-left:none;}
#intro6 li{background-image:url(/res/redcome2007/u/0709/070957416.gif);background-repeat:no-repeat;background-position:5px 8px;line-height:200%;padding-left:16px;}
#login{border-left:1px solid #dbdbdb;border-top:1px solid #dbdbdb;}
#login td{background-color:#fff;font-size:12px;border-right:1px solid #dbdbdb;border-bottom:1px solid #dbdbdb;}
#login th{line-height:150%;font-size:12px;border-right:1px solid #dbdbdb;}
#lzj_an{width:45px;heihgt:18px;line-height:18px;text-align:center;background:#fff;border:1px solid #999999;font-size:12px;}
</style>
<%
request.setCharacterEncoding("UTF-8");

response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession=new TeaSession(request);

String tca = request.getParameter("tca");
if (tca != null)
  {
    String value = request.getParameter("value");

    if (tca.equals("email")) {
      out.print(!tea.entity.member.Profile.isExisted(value));//&&!Profile.isLExisted(value,teasession._nLanguage));
    }

    return;
  }

String show = "注意 *项必须填写";
if(teasession._rv==null)
{
  show="注意 *项必须填写";
}
else
{
  show="您已经是会员了，不需要在此注册！";
}
String community=teasession._strCommunity;

int laid = 0;
if(teasession.getParameter("laid")!=null && teasession.getParameter("laid").length()>0)
	laid = Integer.parseInt(teasession.getParameter("laid"));


int type = 0;
if(teasession.getParameter("type")!=null && teasession.getParameter("type").length()>0)
{
  type = Integer.parseInt(teasession.getParameter("type"));
}
String types="用户注册";
if(type==1)
{
  types ="企业用户注册";

}
else if(type==2)
{
 types ="个体用户注册";

}
else if(type==3)
{
 types ="合作伙伴注册";
}

%>


<script src="/tea/tea.js" type="text/javascript"></script>

<script type="text/javascript">
function sk(form)
{

  if(reged()
  &&submitText(form.email,'电子邮件不能为空')
  &&submitEmail(form.email,'Email格式不正确')
  &&check_user()
  &&submitText(form.pwd,'无效-密码')
  &&submitText(form.chpassword,'无效-确认密码')
  &&submitEqual(form.pwd,form.chpassword,'两次密码输入不一致')
  &&submitText(form.family,'姓不能为空')
  &&submitText(form.firsts,'名不能为空')
  &&submitText(form.corp,'公司不能为空')
  &&check_selected(form.calling,'请选择公司所属行业')
  &&check_selected(form.duty,'请选择一项职务')
  &&submitText(form.dept,'部门不能为空')
  &&submitText(form.country,'公司地址不能为空')
  &&submitText(form.postalcode,'邮编不能为空')
  &&submitInteger(form.postalcode,'邮编类型为数字')
  &&submitText(form.telephone,'联系电话不能为空')
  &&submitInteger(form.telephone,'联系电话类型为数字')
  &&check_selected(form.province,'请选择一项职务')
  &&submitText(form.city,'市不能为空')
  ){
    return true;
  }
  return false;
}

function check_selected(form,text){
  if(form.value == '0'){
    alert(text);
    form.focus();
    return false;
  }
  return true;
}

function check_user(){
  var ck = document.getElementById('checkID').value;

  if(ck == 'true'){
    alert('该电子邮件已存在!');
    form1.email.focus();
    return false;
  }
  return true;
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
	sendx("/jsp/admin/sales/LatencyCompany.jsp?tca="+act+"&value="+obj.value,function(v){
	    var   strReg="";
	    var   r;
	    var str = form1.email.value;
	    var re = /^(\w-*\.*)+@(\w-?)+(\.\w{2,})+$/
		if(re.test(str)){
		    if(v.indexOf('true')!=-1){
		        sv.innerHTML="<img src=/tea/image/public/check_right.gif>电子邮件可用";
		        checkid.value="false";
		    }else{
		        sv.innerHTML="<img src=/tea/image/public/check_error.gif>电子邮件已存在";
		        checkid.value="true";
		    }
		}else{
			sv.innerHTML="<img src=/tea/image/public/check_error.gif>电子邮件格式不正确";
		    checkid.value="true";
		}
	    /*
	    strReg=/^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/i;
	    r=str.search(strReg);
	    if(r==-1){
	      sv.innerHTML="<img src=/tea/image/public/check_error.gif>电子邮件格式不正确";
	      checkid.value="true";
	    }else{
	      if(v.indexOf('true')!=-1){
	        sv.innerHTML="<img src=/tea/image/public/check_right.gif>电子邮件可用";
	        checkid.value="false";
	      }else{
	        sv.innerHTML="<img src=/tea/image/public/check_error.gif>电子邮件已存在";
	        checkid.value="true";
	      }
	    }
	    */
  	})
}

function reged(){
if(form1.show.value=="您已经是会员了，不需要在此注册！")
  {
    alert(form1.show.value);
    return false;
  }
  return true;
}
</script>



<div id=intro1>
<form name=form1 METHOD=post  action="/servlet/EditLatency" onSubmit="return sk(this);">
<input type="hidden"  name="act" value="LatencyCompany"/>

<input type="hidden" name="checkID" value="<%=!tea.entity.member.Profile.isExisted(request.getParameter("value"))%>"/>
<input type="hidden" name="tca" value="reg"/>
<input type="hidden" name="type" value="<%=type%>">
<input type="hidden" name="show" value="<%=show%>" />


<table width="90%" border="0" align="center"  cellpadding="4" cellspacing="1" bgcolor="#F2F2F2" id="login">
    <tr>
      <th colspan="2"><b><%=Latency.LYTYPES[type]%> </b><br><%=show%></th>
    </tr>
    <tr>
      <td width="30%">电子邮件：</td>
      <td width="70%" class="right"><input type="text" name="email" size="30" maxlength="50" onBlur="f_ajax(this)" class="smallInput" >
          <font color="#cc0000">*</font>&nbsp;&nbsp;<span id="span_email" style="padding:2px 0 2px 0;font-size:12px;color:#7F7F7F;">请输入您的电子邮件</span></td>
    </tr>
    <tr>
      <td>口令：</td>
      <td class="right"><input name="pwd" type="password" class="smallInput" id="pwd" size="20" maxlength="25" >
        <font color="#cc0000">*</font></td>
    </tr>
    <tr>
      <td>确认口令：</td>
      <td class="right"><input name="chpassword" type="password" class="smallInput" id="chpassword" size="20" maxlength="25" >
          <font color="#cc0000">*</font></td>
    </tr>
    <tr>
      <td>称谓：</td>
      <td class="right">
      <%
      for(int i =0;i<Latency.SEXS.length;i++)
      {
        out.print("<input name=sex type=radio value="+i);
        if(i==0){
          out.print(" checked ");
        }
        out.print(">");
        out.print(Latency.SEXS[i]);
      }
      %>
 </td>
    </tr>
    <tr>
      <td>姓：</td>
      <td class="right"><input name="family" type="text" class="smallInput" id="LastName" size="20" maxlength="25" >
          <font color="#cc0000">*</font> </td>
    </tr>
    <tr>
      <td>名：</td>
      <td class="right"><input name="firsts" type="text" class="smallInput" id="FirstName" size="20" maxlength="25" >
          <font color="#cc0000">*</font> </td>
    </tr>
    <tr>
      <td>公司：</td>
      <td class="right"><input name="corp" type="text" class="smallInput" id="Company" size="20" maxlength="25" >
          <font color="#cc0000">*</font> </td>
    </tr>
    <tr>
      <td>公司所属行业：</td>
      <td class="right"><select name="calling">
  <%
  for(int i = 0 ;i<Common.SALES_CALLING.length;i++)
  {
    out.print("<option value ="+i);
    out.print(">"+Common.SALES_CALLING[i]);
    out.print("</option>");
  }
  %>
  </select>
        <font color="#cc0000">*</font> </td>
    </tr>
    <tr>
      <td>职务：</td>
      <td class="right">
 <select size="1" name="duty" tabindex='12' id="Role">
         <%
         for(int i =0;i<Latency.DUTYS.length;i++)
         {
           out.print("<option value="+i);
           out.print(">"+Latency.DUTYS[i]+"</option>");
         }
         %>
        </select>
<font color="#cc0000">*</font> </td>
    </tr>
    <tr>
      <td>部门：</td>
      <td class="right">
<input name="dept" type="text" class="smallInput" id="dept" size="20" maxlength="25" >
<font color="#cc0000">*</font> </td>
    </tr>
    <tr>
      <td>公司地址：</td>
      <td class="right"><input type="text" name="country" size="30" maxlength="100" class="smallInput" >
          <font color="#cc0000">*</font> </td>
    </tr>
    <tr>
      <td nowrap>邮政编码：</td>
      <td class="right"><input type="text" name="postalcode" size="10" maxlength="10" class="smallInput" >
          <font color="#cc0000">*</font> </td>
    </tr>
    <tr>

      <td>联系电话：</td>
      <td class="right">
        <input type="text" name="telephone" size="15" maxlength="40" class="smallInput" >
        <font color="#cc0000">*</font> </td>
    </tr>
    <tr>
      <td>传真：</td>
      <td class="right"><input name="inc_fax" type="text" class="smallInput" id="inc_fax" size="15" maxlength="40" ></td>
    </tr>
    <tr>
      <td>联系人手机：</td>

      <td class="right">
        <input type="text" name="handset" size="15" maxlength="40" class="smallInput" ></td>
    </tr>
    <tr>
      <td>省份：</td>
      <td class="right">
        <select name="province" id="province" >
	<%
        for(int i=0;i<Latency.PROVINCES.length;i++)
        {
          out.print("<option value="+i+">");
          out.print(Latency.PROVINCES[i]+"</option>");
        }

        %>
        </select>&nbsp;<font color="#cc0000">*</font>&nbsp;<!--<br><input name="city_ot" type="text" class="smallInput" id="city_ot" value="" size="15" maxlength="50" >&nbsp;其他-->
      </td>
    </tr>
    <tr>
      <td>城市：</td>

      <td class="right">
          <input name="city" type="text" class="smallInput" id="city_ot" value="" size="15" maxlength="50" >
          <font color="#cc0000">*</font></td>
    </tr>
<tr>
<td colspan="2" align="center"><input type="submit" value="提交"  id="lzj_an"></td>
</tr>
</table>
</FORM>
</div>







