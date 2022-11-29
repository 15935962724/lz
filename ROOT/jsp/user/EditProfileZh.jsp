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
String member = request.getParameter("member");
if(member == null){
  member = teasession._rv._strR;
}
Profile p = Profile.find(member);
ProfileZh pz = ProfileZh.find(member);
String nexturl = request.getParameter("nexturl");
if(nexturl==null){
 nexturl = request.getRequestURI();
}
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>


<script src="/tea/tea.js" type="text/javascript"></script>
<script type="">

function check(form)
{
  return submitText(form.name,'无效-姓名')
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

</script>
</head>
<body >


<div id="jspbefore" style="display:none">
  <%=community.getJspBefore(teasession._nLanguage)%>
</div>
<div id="friendship"><img src="/res/china-corea/u/0811/081127512.gif"/></div>
<div id="friendship_02"><img src="/res/china-corea/u/0811/081127515.gif"/></div>
<div id="friendship_03"><img src="/res/china-corea/u/0811/081127519.gif"/></div>



<form name="uper" action="/servlet/EditProfileZh" method="post" enctype="multipart/form-data"  onsubmit="return check(this);">
<input type="hidden" name="type" value="update"/>
<input type="hidden" name="member" value="<%=member%>"/>
<input type="hidden" name="nexturl" value="<%=nexturl%>"/>
<input type="hidden" name="phtot" value="<%=pz.getPhoto()%>"/>
<div id="members_Resume">
  <table width="100%" border="0" cellspacing="0" cellpadding="0" ID="members">
    <tr>
      <td id="td_01">姓　名</td>
      <td id="td_02">*<input type="TEXT" name="name" value="<%=pz.getName()%>"/></td>
        <td id="td_01">性　别</td>
        <td id="td_02">*<select name="sex">
          <option value="1" <%if(p.isSex())out.print("selected");%>>男</option>
          <option value="0" <%if(!p.isSex())out.print("selected"); %>>女</option>
</select></td>
<td id="td_03">出生年月日</td>
<td id="td_02">*<input type="TEXT" name="birth" value="<%=p.getBirthToString()%>" readonly="readonly" onclick="new Calendar('1900', '2010', 0,'yyyy-MM-dd').show(this);"></td>
  <td rowspan="4" id="pc" width=120>
    <input type='button' name='aaa' style='position:absolute;' value='上传照片' />
    <input type='file' name='photo' value="<%if(pz.getPhoto()!=null)out.print(pz.getPhoto());%>" style='position:absolute;width:77px;cursor:hand;filter:Alpha(opacity=0)' onchange="add_pic(this);"/><br />
    <span id="ppc"><%if(pz.getPhoto()!=null){if(pz.getPhoto().length()!=4){%><img alt="" src="<%=pz.getPhoto()%>" width="100" height="135" /><%}} %></span>
  </td>
    </tr>

    <tr>
      <td id="td_01">民　族</td>
      <td id="td_02">*<input type="TEXT" name="national" value="<%=pz.getNationnal()%>"/></td>
        <td id="td_01">籍　贯</td>
        <td id="td_02">*<input type="TEXT" name="nactive" value="<%=pz.getNactive()%>"/></td>
          <td id="td_03">出　生　地</td>
          <td id="td_02">*<input type="TEXT" name="bplace" value="<%=pz.getBplace()%>"/></td>
    </tr>
    <tr>
      <td id="td_01">政治面貌</td>
      <td id="td_02">*<input type="TEXT" name="political" value="<%=pz.getPolitical()%>"/></td>
        <td id="td_01">身份证号</td>
        <td colspan="3" id="td_05">*<input type="TEXT" name="card" value="<%=pz.getCard()%>"/></td>
    </tr>
    <tr>
      <td id="td_01">家庭住址</td>
      <td colspan="3" id="td_06">*<input type="TEXT" name="faddr" value="<%=pz.getFaddr()%>"/></td>
        <td id="td_03">邮　编</td>
        <td id="td_02">&nbsp;&nbsp;<input type="TEXT" name="zip" value="<%=pz.getZip()%>"/></td>
    </tr>
    <tr>
      <td id="td_01">住宅电话</td>
      <td colspan="3" id="td_06">*<input type="TEXT" name="homephone" value="<%=pz.getHomephone()%>"/></td>
        <td id="td_03">手　机</td>
        <td colspan="2" id="td_07">*<input type="TEXT" name="mobile" value="<%=p.getMobile()%>"/></td>
    </tr>
    <tr>
      <td id="td_01">E-Mail</td>
      <td colspan="3" id="td_06">*<input type="TEXT" name="email" value="<%=p.getEmail()%>"/></td>
        <td id="td_03">个人网页</td>
        <td colspan="2" id="td_07">&nbsp;&nbsp;<input type="TEXT" name="web" value="<%=pz.getWeb()%>"/></td>
    </tr>
    <tr>
      <td id="td_01">单位名称</td>
      <td colspan="3" id="td_06">*<input type="TEXT" name="comname" value="<%=pz.getComname()%>"/></td>
        <td id="td_03">职　务</td>
        <td colspan="2" id="td_07">*<input type="TEXT" name="job" value="<%=pz.getJob()%>"/></td>
    </tr>
    <tr>
      <td id="td_01">单位电话</td>
      <td colspan="3" id="td_06">*<input type="TEXT" name="comphone" value="<%=pz.getComphone()%>"/></td>
        <td id="td_03">传　真</td>
        <td colspan="2" id="td_07"> &nbsp;&nbsp;<input type="TEXT" name="fax" value="<%=pz.getFax()%>"/></td>
    </tr>
    <tr>
      <td id="td_01">单位地址</td>
      <td colspan="4" id="td_08"> &nbsp;&nbsp;<input type="TEXT" name="comaddr" value="<%=pz.getComaddr()%>"/></td>
        <td colspan="2"><table border="0" cellspacing="0" cellpadding="0"><tr>
          <td id="div_01">邮　编</td><td id="div_02"> &nbsp;&nbsp;<input type="TEXT" name="comzip" value="<%=pz.getComzip()%>"/></td>
    </tr>
  </table>
        </td>
</tr>
<tr>
  <td id="td_01">其他社会<br/>职务</td>
  <td colspan="6" id="td_09"> &nbsp;&nbsp;<textarea name="otherjob" rows="5" cols="60"><%=pz.getOtherjob()%></textarea></td>
</tr>
<tr>
  <td id="td_01">联系人</td>
  <td colspan="3" id="td_06">*<input type="TEXT" name="cper" value="<%=pz.getCper()%>"/></td>
    <td id="td_03">职　务</td>
    <td colspan="2" id="td_07">*<input type="TEXT" name="cjob" value="<%=pz.getCjob() %>"/></td>
</tr>
<tr>
  <td id="td_01">电　话</td>
  <td colspan="3" id="td_06">*<input type="TEXT" name="cphone" value="<%=pz.getCphone()%>"/></td>
    <td id="td_03">传　真</td>
    <td colspan="2" id="td_07"> &nbsp;&nbsp;<input type="TEXT" name="cfax" value="<%=pz.getCfax()%>"/></td>
</tr>
<tr>
  <td colspan="2" id="td_10">希望协会将邮递资料寄往</td>
  <td colspan="5" id="td_11"> &nbsp;&nbsp;<input type="CHECKBOX" name="zipsend0" value="0" <%if(pz.getZipsend().contains("0"))out.print("checked");%> id="29_0"/><label for=29_0>&nbsp;单　位　</label> <input type="CHECKBOX" name="zipsend1" <%if(pz.getZipsend().contains("1"))out.print("checked");%> value="1" id="29_1"/><label for=29_1>&nbsp;住　宅</label> </td>
</tr>
<tr>
  <td colspan="2" id="td_10">希望协会将有关消息发往</td>
  <td colspan="5" id="td_11"> &nbsp;&nbsp;<input type="CHECKBOX" name="infosend0" value="0" <%if(pz.getInfosend().contains("0"))out.print("checked");%> id="30_0"/><label for=30_0>&nbsp;个人邮箱</label> <input type="CHECKBOX" name="infosend1" <%if(pz.getInfosend().contains("1"))out.print("checked");%> value="1" id="30_1"/><label for=30_1>&nbsp;传　真</label> </td>
</tr>
<table border="0" cellspacing="0" cellpadding="0" id="Resume"><tr id="tr_01"><td colspan="3">个人简历</td></tr>
  <tr id="tr_02"><td id="td_1">何年何月至何年何月</td><td id="td_2">在何地区何单位</td><td id="td_3">任（兼）何职</td></tr>
  <%
  String resume = pz.getResume();
  String[] trsume = resume.split(",");
  int  cnt=0,start  =  0;
  while(start!=resume.length()){
    int i = resume.indexOf(",",start);
    if(i!=-1)
    {
      cnt++;
      start=i+1;
    }
    else
    break;
  }
  String sm=null;
  for(int i = 1; i <cnt;i++)
  {
    out.print("<tr id=\"tr_03\">");
    String[] tdsume = trsume[i].split("`");

    for(int j = 0; j <3; j++)
    {
      if(tdsume[j].equals("　"))
      {
        sm = "";
      }else
      {
        sm = tdsume[j];
      }
      out.print("<td id=\"td_"+(j+1)+"\"><input type=text name="+ProfileZh.res[j]+i+" value="+sm+" ></td>");
    }
    out.print("</tr>");
  }
  %>
  </table>

</div>
<table  border="0" cellspacing="0" cellpadding="0" ID="members_bottom2">
<tr>
<td id="td_12" colspan="5" align="center"><input id="isopen" type="checkbox" name="isopen" value="1" <%if(pz.getIsopen()==1)out.print("checked");%>/><label for="isopen">是否公开会员资料</label></td>
</tr>
  <tr><td align="center"><input type="submit" value="修改"/>　<%if(request.getParameter("back")!=null){%><input type="button" value="返回" onclick="window.location.href='/jsp/user/ApprovalPer.jsp';"/><%}%></td></tr>
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


</script>
<script>

function add_pic(obj){

  var pc = document.getElementById('ppc');

  var ph = document.uper.photo.value;
  document.uper.phtot.value=ph;
  if(ph.length>0)
  {
    pc.innerHTML=ph;
  }

}


</script>
<%@include file="/jsp/include/Canlendar4.jsp" %>
</body>
</html>


