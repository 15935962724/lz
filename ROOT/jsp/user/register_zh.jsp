<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.htmlx.*"%>
<%@ page import="tea.ui.TeaSession"%>
<%@ page import="tea.resource.*" %>
<%@ page import="tea.entity.member.*" %>
<%
request.setCharacterEncoding("UTF-8");
response.setHeader("progma","no-cache");
response.setHeader("Cache-Control","no-cache");
response.setDateHeader("Expires",0);
TeaSession teasession =new TeaSession(request);
tea.entity.site.Community community=tea.entity.site.Community.find(teasession._strCommunity);

Resource r = new Resource("/tea/ui/util/SignUp1").add("/tea/htmlx/HtmlX");
String act = request.getParameter("act");
String value= null;
if (act != null)
  {
     value = request.getParameter("value");
    if (act.equals("member")) {
      out.print(!Profile.isExisted(value));//&&!Profile.isLExisted(value,teasession._nLanguage));
    }

    return;
  }

  String nexturl = teasession.getParameter("nexturl");

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>


<script src="/tea/tea.js" type="text/javascript"></script>
<script type="">

function check(form)
{
  return submitText(form.member,'无效-会员名称')
  &&submitMem(form.checkID,'会员名称已存在')
  &&submitText(form.password,'无效-密码')
  &&submitText(form.conpwd,'无效-确认密码')
  &&submitEqual(form.password,form.conpwd,'两次密码输入不一致')
  &&submitText(form.name,'无效-姓名')
  &&submitText(form.birth,'无效-出生日期')
  &&submitText(form.national,'无效-民族')
  &&submitText(form.nactive,'无效-籍贯')
  &&submitText(form.bplace,'无效-出生地')
  &&submitText(form.political,'无效-政治面貌')
  &&submitText(form.card,'无效-身份证号')
  &&submitInteger(form.card,'无效-身份证号')
  &&submitLength(15,18,form.card,'无效-身份证号')
  &&checkImg(form.photo,'无效-照片文件格式')
  &&submitText(form.faddr,'无效-家庭住址')
  &&submitText(form.homephone,'无效-住宅电话')
  &&submitText(form.mobile,'无效-手机')
  &&submitInteger(form.mobile,'无效-手机')
  &&submitLength(11,12,form.mobile,'无效-手机')
  &&submitText(form.email,'无效-Email')
  &&submitEmail(form.email,'无效-Email')
  &&submitText(form.comname,'无效-单位名称')
  &&submitText(form.job,'无效-职务')
  &&submitText(form.cper,'无效-联系人')
  &&submitText(form.cjob,'无效-职务')
  &&submitText(form.cphone,'无效-电话');
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
function submitMem(text,alerttext)
{

  if(text.value=='true')
  {
    alert(alerttext);
    document.reg.member.focus();
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

function checkImg(text,alerttext)
{
  if(text.value.length>0){
    var i=text.value.lastIndexOf(".");
    var ext=text.value.substring(i);
    var  ext1=ext.toLowerCase();
    if(ext1!=".jpg" && ext1!=".png" && ext1!=".gif" && ext1!=".bmp")
    {
      alert(alerttext);
      return false;
    }
    return true;
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
var url = "?act="+act+"&value="+obj.value;
          url = encodeURI(url);
sendx(url,function(v)
  {

    if(v.indexOf('true')!=-1)
    {

      sv.innerHTML="<img src=/tea/image/public/check_right.gif>用户名可用";
      checkid.value="false";

    }else
    {

        sv.innerHTML="<img src=/tea/image/public/check_error.gif>用户名已存在";
         checkid.value="true";

    }
  }
  )
}

function f_jax(obj)
{
  var act=obj.name;
  var sv=document.getElementById('span_'+act);
  if(obj.value==""||obj.value==null)
  {
    sv.innerHTML="<img src=/tea/image/public/check_error.gif>不能为空";
    return;
  }
  sv.innerHTML="<img src=/tea/image/public/load.gif>";
  if(act=="password")
  {
    if(document.reg.password.value.length<6)
    {
    sv.innerHTML="<img src=/tea/image/public/check_error.gif>密码长度小于6位";
    }else
    {
    sv.innerHTML="<img src=/tea/image/public/check_right.gif>";
    }
  }
  if(act=="conpwd")
  {
    if(document.reg.conpwd.value.length<6)
    {
    sv.innerHTML="<img src=/tea/image/public/check_error.gif>确认密码长度小于6位";
    }else
    {
      if(document.reg.conpwd.value!=document.reg.password.value)
      {
      sv.innerHTML="<img src=/tea/image/public/check_error.gif>两次密码输入不一致";
      }else
      {
      sv.innerHTML="<img src=/tea/image/public/check_right.gif>";
      }
    }

  }
}
</script>
<style type="">
<%if(!teasession._strCommunity.equals("china-corea")){%>
#friendship_02{margin:0 auto;width:800px;background:url(/res/china-asean/u/0812/081240788.gif) repeat-x left bottom;height:38px;}
<%}%>
</style>
</head>
<body >


<div id="jspbefore" style="display:none">
<%=community.getJspBefore(teasession._nLanguage)%>
</div>
<%if(teasession._strCommunity.equals("china-corea")){%>
<div id="friendship"><img src="/res/china-corea/u/0811/081127512.gif"/></div>
<div id="friendship_02"><img src="/res/china-corea/u/0811/081127515.gif"/></div>
<div id="friendship_03"><img src="/res/china-corea/u/0811/081127519.gif"/></div>
<%}else{%>
<div id="friendship"><img src="/res/china-asean/u/0812/081240792.gif"/></div>
<div id="friendship_02"><img src="/res/china-asean/u/0812/081240793.gif"/></div>
<div id="friendship_03"><img src="/res/china-asean/u/0812/081240794.gif"/></div>
<%}%>


<form name="reg" action="/servlet/EditProfileZh" method="post" enctype="multipart/form-data"  onsubmit="return check(this);">
<input type="hidden" name="nexturl" value="<%=nexturl%>"/>
<input type="hidden" name="type" value="regist"/>
<input type="hidden" name="checkID" value="<%=!Profile.isExisted(request.getParameter("value"))%>"/>
<div id="members_Resume2">
  <table width="100%" border="0" cellspacing="0" cellpadding="0" ID="members">
    <tr>
      <td colspan="3" align="center" class="log_xinx">登陆信息</td>
    </tr>
    <tr>
      <td id="td_01">会员名称</td>
      <td id="td_02">*<input type="text" name="member" onBlur="f_ajax(this)"/></td>
      <td id="td_001"><span id="span_member">【会员名称&nbsp;由英文字母数字和下划线组成】</span></td>
    </tr>
    <tr>
      <td id="td_01">密　　码</td>
      <td id="td_02">*<input type="password" name="password" maxlength="12" onblur="f_jax(this)"/></td>
       <td id="td_001"><span id="span_password">【密　　码&nbsp;长度为6-12位】</span></td>
    </tr>
    <tr>
      <td id="td_01">确认密码</td>
      <td id="td_02">*<input type="password" name="conpwd" maxlength="12" onblur="f_jax(this)"/></td>
       <td id="td_001"><span id="span_conpwd">&nbsp;</span></td>
    </tr>
  </table>
</div>

  <br />
  <div id="members_Resume">
  <table width="100%" border="0" cellspacing="0" cellpadding="0" ID="members">
  <tr>
    <td>
    &nbsp;&nbsp;注册类型&nbsp;*
    <input id="ls" type="radio" name="regstyle" value="0" checked="checked"/><label for="ls">理事</label>
    <input id="zj" type="radio" name="regstyle" value="1"/><label for="zj">专家</label>
    <input id="mt" type="radio" name="regstyle" value="2"/><label for="mt">媒体</label>
    <input id="ty" type="radio" name="regstyle" value="3"/><label for="ty">特约通信员</label>
    </td>
  </tr>
  </table>
  </div>
  <br />
<div id="members_Resume">
  <table width="100%" border="0" cellspacing="0" cellpadding="0" ID="members">
    <tr>
      <td colspan="7" align="center"><b>基本信息</b></td>
    </tr>
    <tr>
      <td id="td_01">姓　名</td>
      <td id="td_02">*<input type="TEXT" name="name" value=""/></td>
      <td id="td_01">性　别</td>
      <td id="td_02">*<select name="sex">
<option value="1">男</option>
<option value="0">女</option>
</select></td>
      <td id="td_03">出生年月日</td>
      <td id="td_02">*<input type="TEXT" name="birth" readonly="readonly" onclick="new Calendar('1900', '2010', 0,'yyyy-MM-dd').show(this);"></td>
      <td rowspan="4" id="pc" width=120>

        <input type='button' name='aaa' style='position:absolute;' value='上传照片' />
      <input type='file' name='photo' style='position:absolute;width:77px;cursor:hand;filter:Alpha(opacity=0)' onchange="add_pic(this);"/><br />
<span id="ppc">上传照片尺寸为：100*135</span>
      </td>
    </tr>

    <tr>
      <td id="td_01">民　族</td>
      <td id="td_02">*<input type="TEXT" name="national" value=""/></td>
      <td id="td_01">籍　贯</td>
      <td id="td_02">*<input type="TEXT" name="nactive" value=""/></td>
      <td id="td_03">出　生　地</td>
      <td id="td_02">*<input type="TEXT" name="bplace" value=""/></td>
    </tr>
    <tr>
      <td id="td_01">政治面貌</td>
      <td id="td_02">*<input type="TEXT" name="political" value=""/></td>
      <td id="td_01">身份证号</td>
      <td colspan="3" id="td_05">*<input type="TEXT" name="card" value=""/></td>
    </tr>
    <tr>
      <td id="td_01">家庭住址</td>
      <td colspan="3" id="td_06">*<input type="TEXT" name="faddr" value=""/></td>
      <td id="td_03">邮　编</td>
      <td id="td_02"> &nbsp;&nbsp;<input type="TEXT" name="zip" value=""/></td>
    </tr>
    <tr>
      <td id="td_01">住宅电话</td>
      <td colspan="3" id="td_06">*<input type="TEXT" name="homephone" value=""/></td>
      <td id="td_03">手　机</td>
      <td colspan="2" id="td_07">*<input type="TEXT" name="mobile" value=""/></td>
    </tr>
    <tr>
      <td id="td_01">E-Mail</td>
      <td colspan="3" id="td_06">*<input type="TEXT" name="email" value=""/></td>
      <td id="td_03">个人网页</td>
      <td colspan="2" id="td_07"> &nbsp;&nbsp;<input type="TEXT" name="web" value=""/></td>
    </tr>
    <tr>
      <td id="td_01">单位名称</td>
      <td colspan="3" id="td_06">*<input type="TEXT" name="comname" value=""/></td>
      <td id="td_03">职　务</td>
      <td colspan="2" id="td_07">*<input type="TEXT" name="job" value=""/></td>
    </tr>
    <tr>
      <td id="td_01">单位电话</td>
      <td colspan="3" id="td_06">*<input type="TEXT" name="comphone" value=""/></td>
      <td id="td_03">传　真</td>
      <td colspan="2" id="td_07"> &nbsp;&nbsp;<input type="TEXT" name="fax" value=""/></td>
    </tr>
    <tr>
      <td id="td_01">单位地址</td>
      <td colspan="4" id="td_08"> &nbsp;&nbsp;<input type="TEXT" name="comaddr" value=""/></td>
      <td colspan="2"><table border="0" cellspacing="0" cellpadding="0"><tr>
        <td id="div_01">邮　编</td><td id="div_02"> &nbsp;&nbsp;<input type="TEXT" name="comzip" value=""/></td>
    </tr>
  </table>
      </td>
    </tr>
    <tr>
      <td id="td_01">其他社会<br/>职务</td>
      <td colspan="6" id="td_09"> &nbsp;&nbsp;<textarea name="otherjob" rows="5" cols="60"></textarea></td>
    </tr>
    <tr>
      <td id="td_01">联系人</td>
      <td colspan="3" id="td_06">*<input type="TEXT" name="cper" value=""/></td>
      <td id="td_03">职　务</td>
      <td colspan="2" id="td_07">*<input type="TEXT" name="cjob" value=""/></td>
    </tr>
    <tr>
      <td id="td_01">电　话</td>
      <td colspan="3" id="td_06">*<input type="TEXT" name="cphone" value=""/></td>
      <td id="td_03">传　真</td>
      <td colspan="2(R)" id="td_07"> &nbsp;&nbsp;<input type="TEXT" name="cfax" value=""/></td>
    </tr>
    <tr>
      <td colspan="2" id="td_10">希望协会将邮递资料寄往</td>
      <td colspan="5" id="td_11">&nbsp;&nbsp;<input type="CHECKBOX" name="zipsend0" value="0" id="29_0"/><label for=29_0>&nbsp;单　位　</label> <input type="CHECKBOX" name="zipsend1" value="1" id="29_1"/><label for=29_1>&nbsp;住　宅</label> </td>
    </tr>
    <tr>
      <td colspan="2" id="td_10">希望协会将有关消息发往</td>
      <td colspan="5" id="td_11">&nbsp;&nbsp;<input type="CHECKBOX" name="infosend0" value="0" id="30_0"/><label for=30_0>&nbsp;个人邮箱</label> <input type="CHECKBOX" name="infosend1" value="1" id="30_1"/><label for=30_1>&nbsp;传　真</label> </td>
    </tr>
    <table border="0" cellspacing="0" cellpadding="0" id="Resume"><tr id="tr_01"><td colspan="3">个人简历</td></tr>
      <tr id="tr_02"><td id="td_1">何年何月至何年何月</td><td id="td_2">在何地区何单位</td><td id="td_3">任（兼）何职</td></tr>
      <tr id="tr_03"><td id="td_1"><input type="TEXT" name="date1" value=""/></td><td id="td_2"><input type="TEXT" name="com1" value=""/></td><td id="td_3"><input type="TEXT" name="job1" value=""/></td></tr>
      <tr id="tr_03"><td id="td_1"><input type="TEXT" name="date2" value=""/></td><td id="td_2"><input type="TEXT" name="com2" value=""/></td><td id="td_3"><input type="TEXT" name="job2" value=""/></td></tr>
      <tr id="tr_03"><td id="td_1"><input type="TEXT" name="date3" value=""/></td><td id="td_2"><input type="TEXT" name="com3" value=""/></td><td id="td_3"><input type="TEXT" name="job3" value=""/></td></tr>
      <tr id="tr_03"><td id="td_1"><input type="TEXT" name="date4" value=""/></td><td id="td_2"><input type="TEXT" name="com4" value=""/></td><td id="td_3"><input type="TEXT" name="job4" value=""/></td></tr>
      <tr id="tr_03"><td id="td_1"><input type="TEXT" name="date5" value=""/></td><td id="td_2"><input type="TEXT" name="com5" value=""/></td><td id="td_3"><input type="TEXT" name="job5" value=""/></td></tr>
      <tr id="tr_03"><td id="td_1"><input type="TEXT" name="date6" value=""/></td><td id="td_2"><input type="TEXT" name="com6" value=""/></td><td id="td_3"><input type="TEXT" name="job6" value=""/></td></tr>
      <tr id="tr_03"><td id="td_1"><input type="TEXT" name="date7" value=""/></td><td id="td_2"><input type="TEXT" name="com7" value=""/></td><td id="td_3"><input type="TEXT" name="job7" value=""/></td></tr>
      <tr id="tr_03"><td id="td_1"><input type="TEXT" name="date8" value=""/></td><td id="td_2"><input type="TEXT" name="com8" value=""/></td><td id="td_3"><input type="TEXT" name="job8" value=""/></td></tr>
      <tr id="tr_03"><td id="td_1"><input type="TEXT" name="date9" value=""/></td><td id="td_2"><input type="TEXT" name="com9" value=""/></td><td id="td_3"><input type="TEXT" name="job9" value=""/></td></tr>
      <tr id="tr_03"><td id="td_1"><input type="TEXT" name="date10" value=""/></td><td id="td_2"><input type="TEXT" name="com10" value=""/></td><td id="td_3"><input type="TEXT" name="job10" value=""/></td></tr>
</table>

</div>
<table  border="0" cellspacing="0" cellpadding="0" ID="members_bottom2">
<tr>
<td colspan="5" align="center"><input id="isopen" type="checkbox" name="isopen" value="1"/><label for="isopen">是否公开会员资料</label></td>
</tr>
  <tr><td align="center"><input type="submit" value="注册"/>　<input type="reset" value="重置"/></td></tr>
</table>
  </form>
<div id="jspafter" style="display:none">
<%=community.getJspAfter(teasession._nLanguage)%>
</div>
<script type="">
if(top.location==self.location)
{
  jspbefore.style.display='';
  jspafter.style.display='';
}

//f_regmail();


</script>
<script>

function add_pic(obj){

  var pc = document.getElementById('ppc');
  var ph = document.reg.photo.value;
  if(ph.length>0)
  {
    pc.innerHTML=ph;
  }

}


</script>
<%@include file="/jsp/include/Canlendar4.jsp" %>
</body>
</html>


