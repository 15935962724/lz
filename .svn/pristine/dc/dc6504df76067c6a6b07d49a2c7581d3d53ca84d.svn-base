<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="tea.htmlx.*"%>
<%@ page import="tea.ui.TeaSession"%>
<%@ page import="tea.resource.*" %>
<%@ page import="tea.entity.bpicture.*" %>
<%@ page import="tea.entity.admin.mov.*"%>
<%@ page import="tea.entity.member.*"%>
<%@ page import="tea.entity.admin.orthonline.Doctor"%>

<%@ page import="java.util.Date"%>
<%
TeaSession teasession =new TeaSession(request);

int membertype = 0;
if(teasession.getParameter("membertype")!=null && teasession.getParameter("membertype").length()>0)
{
  membertype = Integer.parseInt(teasession.getParameter("membertype"));
}
String act = teasession.getParameter("act");
//int membertype_jy = 0;
//if(teasession.getParameter("membertype_jy")!=null && teasession.getParameter("membertype_jy").length()>0)
//{
//  membertype_jy = Integer.parseInt(teasession.getParameter("membertype_jy"));
//}

MemberType myobj = MemberType.find(membertype);
RegisterInstall riobj = RegisterInstall.find(membertype);

Describes dbobj = Describes.find(membertype);
String invite=teasession.getParameter("invite");
if (invite==null) invite="0";
//如果有已经登录
String MemberId=null;//用户名
String EnterPassword=null;//密码
String email = null;//电子邮件
String firstname=null;//姓名
boolean sex=false;//性别
String card = null;// 身份证号
Date birth=new Date();//生日
String city=null;//省份
String address=null;//地址
String phonenumber=null;//手机号
String zip =null;//邮政编码
String telephone=null;//电话号码
String fax = null;//传真号码
String position=null;//职称
String organization=null;//单位
String section=null;//科室
String degree = null;//学历

if(teasession._rv != null)
{
  Profile pobj = Profile.find(teasession._rv.toString());
   MemberId=pobj.getMember();//用户名
   EnterPassword=pobj.getPassword();//密码
   email = pobj.getEmail();//电子邮件
   firstname=pobj.getFirstName(teasession._nLanguage);//姓名
   sex=pobj.isSex();//性别
   card = pobj.getCard();// 身份证号
   birth=pobj.getBirth();//生日
   city=pobj.getCity(teasession._nLanguage);//省份
   address=pobj.getAddress(teasession._nLanguage);//地址
   phonenumber=pobj.getMobile();//手机号
   zip =pobj.getZip(teasession._nLanguage);//邮政编码
   telephone=pobj.getTelephone(teasession._nLanguage);//电话号码
   fax = pobj.getFax(teasession._nLanguage);////传真号码
   position=pobj.getTitle(teasession._nLanguage);//职称
   organization=pobj.getOrganization(teasession._nLanguage);//单位
   section=pobj.getSection(teasession._nLanguage);//科室
   degree = pobj.getDegree(teasession._nLanguage);//学历
}


tea.entity.site.Community community = tea.entity.site.Community.find(teasession._strCommunity);
%>

<html>
<head>
<title>用户注册</title>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/card.js" type="text/javascript"></SCRIPT>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/load.js" type="text/javascript"></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

</head>
<body>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="<%=community.getJspBeforePath(teasession._nLanguage)%>" type="text/javascript"></SCRIPT>
<script>
function f_member()
{
  if(frmsrch.MemberId.value=='')
  {
    if(<%=riobj.getRestrictions()==0%>)
    {
      alert("【用户名】不能为空！");

    }
    else if(<%=riobj.getRestrictions()==1%>)
    {
      alert("【电子信箱】不能为空！");
    }
    else if(<%=riobj.getRestrictions()==2%>)
    {
      alert("【手机号码】不能为空！");
    }
     frmsrch.MemberId.focus();
    return false;
  } else{

    if(<%=riobj.getRestrictions()==1%>)
    {
      var strReg="";
      var r;
      var str = frmsrch.MemberId.value;
      strReg=/^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/i;
      r=str.search(strReg);
      if(r==-1){
        alert("请正确填写【电子信箱】！");
          frmsrch.MemberId.focus();
        return false;
      }
    }else if(<%=riobj.getRestrictions()==2%>)
    {
      var str = document.frmsrch.MemberId.value;
      var reg=/^(((13[0-9]{1})|150|151|152|153|154|155|156|157|158|159)+\d{8})$/;
      if(!reg.test(str)){
        alert("请输入正确的【手机号码】！");
        frmsrch.MemberId.focus();
        return false;
      }
    }

  }
  return true;
}
function f_ajax()
{
  var value = frmsrch.MemberId.value;
  if(f_member()){
    var name ="MemberId";
    currentPos = "show";
    send_request("/jsp/mov/member_ajax.jsp?value="+encodeURIComponent(value)+"&name="+name);
  }else
  {
    return false;
  }
}
function f_edit()
{
  if(f_member()){

    if(frmsrch.EnterPassword.value.length<6 || frmsrch.EnterPassword.value.length>18)
    {
      alert("【密码】必须为6到18位之间！");
        frmsrch.EnterPassword.focus();
      return false;
    }
    if(frmsrch.ConfirmPassword.value!=frmsrch.EnterPassword.value)
    {
      alert("两次【密码】输入不一致!");
        frmsrch.ConfirmPassword.focus();
      return false;
    }


    if(<%=riobj.isInspect("inspectemail") && riobj.getRestrictions()!=1%>){
      var strReg="";
      var r;
      var str = frmsrch.email.value;
      strReg=/^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/i;
      r=str.search(strReg);
      if(r==-1){
        alert("请正确填写【电子信箱】！");
           frmsrch.email.focus();
        return false;
      }
    }

    if(<%=riobj.isInspect("inspectfirstname")%>)
    {
      if(frmsrch.firstname.value=='')
      {
        alert("请填写【姓名】！");
          frmsrch.firstname.focus();
        return false;
      }
    }
    if(<%=riobj.isInspect("inspectcard")%>)
    {
      var sID = frmsrch.card.value;
      if(!(/^\d{15}$|^\d{18}$|^\d{17}[xX]$/.test(sID)))
      {
        alert("【身份证】位数不正确，请填写15位或18位!");
        frmsrch.card.focus();
        return false;
      }
    }
    if(<%=riobj.isInspect("inspectstate")%>)
    {
      var sID = frmsrch.State.value;
      var sID2=frmsrch.City.value;
      if(sID=='' || sID2=='')
      {
        alert("请选择【省份】！");
         frmsrch.State.focus();
        return false;
      }
    }

    if(<%=riobj.isInspect("inspectaddress")%>)
    {
      if(frmsrch.address.value=='')
      {
        alert("请填写【通信地址】！");
           frmsrch.address.focus();
        return false;
      }
    }

    if(<%=riobj.isInspect("inspectphonenumber") && riobj.getRestrictions()!=2%>)
    {
      var sPhonenumber = document.frmsrch.phonenumber.value;
      var reg=/^(((13[0-9]{1})|150|151|152|153|154|155|156|157|158|159)+\d{8})$/;
      if(!reg.test(sPhonenumber)){
        alert("请输入正确的【手机号码】！");
        frmsrch.phonenumber.focus();
        return false;
      }
    }
    if(<%=riobj.isInspect("inspectzip")%>)
    {
      var sZip = document.frmsrch.zip.value
      if(sZip=='')
      {
        alert("【邮政编码】不能为空！");
           frmsrch.zip.focus();
        return false;
      }
      if(isNaN(document.all.frmsrch.zip.value))
      {
        alert("您输入的【邮政编码】不合法，应该输入纯数字！");
           frmsrch.zip.focus();
        return false;
      }
      if(sZip.length!=6)
      {
        alert("您输入的【邮政编码】位数不合法，应该输入6位数字！");
            frmsrch.zip.focus();
        return false;
      }
    }

    if(<%=riobj.isInspect("inspecttelephone")%>)
    {
      var sTelephone =frmsrch.telephone.value;
      if(sTelephone=='')
      {
        alert("【电话号码】不能为空！");
            frmsrch.telephone.focus();
        return false;
      }
      if(isNaN(document.all.frmsrch.telephone.value))
      {
        alert("您输入的【电话号码】不合法，应该输入纯数字！");
            frmsrch.telephone.focus();
        return false;
      }
    }
    if(<%=riobj.isInspect("inspectfax")%>)
    {
      var sFax =frmsrch.fax.value;
      if(sFax=='')
      {
        alert("【传真号码】不能为空！");
            frmsrch.fax.focus();
        return false;
      }
      if(isNaN(document.all.frmsrch.fax.value))
      {
        alert("您输入的【传真号码】不合法，应该输入纯数字！");
         frmsrch.fax.focus();
        return false;
      }
    }
// 职位inspectposition
if(<%=riobj.isInspect("inspectposition")%>)
{
  var sPosition =frmsrch.position.value;
  if(sPosition=='')
  {
    alert("【职称】不能为空！");
    frmsrch.position.focus();
    return false;
  }
}
//单位
if(<%=riobj.isInspect("inspectorganization")%>)
{
  var sOrganization =frmsrch.organization.value;
  if(sOrganization=='')
  {
    alert("【单位】不能为空！");
      frmsrch.organization.focus();
    return false;
  }
}
//科室 部门
if(<%=riobj.isInspect("inspectsection")%>)
{
  var sSection =frmsrch.section.value;
  if(sSection=='')
  {
    alert("【科室(部门)】不能为空！");
    frmsrch.section.focus();
    return false;
  }
}
//学历
if(<%=riobj.isInspect("inspectdegree")%>)
{
  var sDegree =frmsrch.degree.value;
  if(sDegree=='')
  {
    alert("【学历】不能为空！");
    frmsrch.degree.focus();
    return false;
  }
}
    if(<%=riobj.isInspect("inspectvertify")%>)
    {
      if(frmsrch.vertify.value=='')
      {
        alert("验证码不能为空！");
        frmsrch.vertify.focus();
        return false;
      }
      /*
      if(isNaN(document.all.frmsrch.vertify.value))
      {
        alert("您输入的验证码不合法，应该输入纯数字！");
           frmsrch.vertify.focus();
        return false;
      }
      */ 
    }
  }else
  {
    return false;
  }


}
</script>
<div class="RegProcess"><div class="Process00">注册流程：</div><div class="Process01">会员类型选择</div><div class="Process02">用户协议</div><div class="Process03" id="ProcessSpecial">填写基本信息</div><div class="Process04">注册成功</div></div>
<form name="frmsrch" method="POST" action="/servlet/EditMember" onSubmit="return f_edit(this);">
<input type="hidden" name="membertype" value="<%=membertype%>"/>

<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="act" value="register"/>
<input type="hidden" name="act2" value="<%=act%>"/>
 <input type="hidden" name="invite" value="<%=invite%>"/>
<div class="RegInf">
<div class="top">普通会员注册：下面带红色<span>*</span>号的为必填内容　　<span class="Bold">只需填写简单信息即可完成普通会员注册，同时获得20个积分，成功邀请一位新会员加入本网可获得10个积分。</span></div>
<table  border="0" cellpadding="0" cellspacing="0" id="tablecenter">

<%

if(riobj.getRestrictions()==0)
{
  out.print("<tr><td width=80 align=\"right\">*&nbsp;用户名：");
}else if(riobj.getRestrictions()==1)
{
  out.print("<tr><td width=80 align=\"right\">*&nbsp;电子信箱：");
  //out.print("<td><input type=text name=MemberId value=\"\"/>&nbsp;&nbsp;&nbsp;&nbsp;");
}else if(riobj.getRestrictions()==2)
{
  out.print("<tr><td width=80 align=\"right\">*&nbsp;手机号码：");
}
out.print("<td><input type=text name=MemberId value=");
if(MemberId!=null)
{
  out.print(MemberId);
  out.print("  readonly ");//变灰，修改信息时候不能修改用户名
}
out.print(">&nbsp;&nbsp;&nbsp;&nbsp;");
out.print("<input type=\"button\"  value=\"账号检测\" onClick=\"f_ajax();\"");
if(MemberId!=null)
{
   out.print(" disabled ");//变灰，修改信息时候不能修改用户名
}
out.print(">&nbsp;&nbsp;&nbsp;&nbsp;<span id=\"show\">&nbsp;</span></td>");
out.print("<td>");
if(dbobj.getMember()!=null && dbobj.getMember().length()>0){
  out.print(dbobj.getMember());
}
out.print("</td>");
out.print("</tr>");
%>

<tr>
  <td width="80" align="right">*&nbsp;密码：</td>
  <td><input type="password" name="EnterPassword" value="<%if(EnterPassword!=null)out.print(EnterPassword);%>"/></td>
    <td>
    <%
    if(dbobj.getPassword()!=null && dbobj.getPassword().length()>0)
    {
      out.print(dbobj.getPassword());
    }
    %>
  </td>
</tr>
<tr>
  <td width="80"  align="right">*&nbsp;确认密码：</td>
  <td><input type="password" name="ConfirmPassword" value="<%if(EnterPassword!=null)out.print(EnterPassword); %>"/></td>
   <td>
  <%if(dbobj.getConfirmpassword()!=null && dbobj.getConfirmpassword().length()>0)
  {
    out.print(dbobj.getConfirmpassword());
  }
    %>
 </td>
</tr>

<%
//  restrictions
if(riobj.isRegister("email") && riobj.getRestrictions()!=1)
{
  out.print("<tr><td align=\"right\">");
  if(riobj.isInspect("inspectemail"))
  out.print("*&nbsp;");
  out.print("电子邮件：</td><td>");
  out.print("<input type=\"text\" name=email value= ");
  if(email!=null&&email.length()>0)
  {
    out.print(email);
  }
  out.print(" > ");
  out.print("</td>");
  if(dbobj.getEmail()!=null && dbobj.getEmail().length()>0){
    out.print("<td>"+dbobj.getEmail()+"</td>");
  }
  out.print("</tr>");
}
if(riobj.isRegister("phonenumber") && riobj.getRestrictions()!=2)
{
  out.print("<tr><td align=\"right\">");
  if(riobj.isInspect("inspectphonenumber"))
  out.print("*&nbsp;");
  out.print("手机：</td><td>");
  out.print(" <input type=text  name=phonenumber value=\"");
  if(phonenumber!=null&&phonenumber.length()>0)
  {
    out.print(phonenumber);
  }
  out.print("\" maxlength=\"11\"> ");
  out.print("</td>");
  if(dbobj.getPhonenumber()!=null && dbobj.getPhonenumber().length()>0){
    out.print("<td>"+dbobj.getPhonenumber()+"</td>");
  }
  out.print("</tr>");
}


if(riobj.isRegister("firstname"))
{
  out.print("<tr><td align=\"right\">");
  if(riobj.isInspect("inspectfirstname"))
  out.print("*&nbsp;");
  out.print("姓名：</td><td>");
  out.print("<input type=\"text\" name=firstname value= ");
  if(firstname!=null&&firstname.length()>0)
  {
    out.print(firstname);
  }
  out.print(" > ");
  out.print("</td>");
  if(dbobj.getFirstname()!=null && dbobj.getFirstname().length()>0){
    out.print("<td>"+dbobj.getFirstname()+"</td>");
  }
  out.print("</tr>");
}
if(riobj.isRegister("sex"))
{
  out.print("<tr><td align=\"right\">");

  //if(riobj.isInspect("inspectsex"))
  out.print("*&nbsp;");
  out.print("性别：</td><td>");
  out.print("<input type=\"radio\" name=\"sex\" value=\"1\" ");
  if(sex)
  {
    out.print(" checked ");
  }
  out.print(" > 先生");
  out.print("<input type=\"radio\" name=\"sex\" value=\"0\" ");
  if(!sex)
  {
     out.print(" checked ");
  }
  out.print(" /> 女士");
  out.print("</td>");
  if(dbobj.getSex()!=null && dbobj.getSex().length()>0){
    out.print("<td>"+dbobj.getSex()+"</td>");
  }
  out.print("</tr>");
}

if(riobj.isRegister("card"))
{
  out.print("<tr><td align=\"right\">");
  if(riobj.isInspect("inspectcard"))
  out.print("*&nbsp;");
  out.print("身份证号：</td><td>");
  out.print("<input type=\"text\" name=card value= ");
  if(card!=null&&card.length()>0)
  {
    out.print(card);
  }
  out.print(" > ");
  out.print("</td>");
  if(dbobj.getCard()!=null && dbobj.getCard().length()>0){
    out.print("<td>"+dbobj.getCard()+"</td>");
  }
  out.print("</tr>");
}
if(riobj.isRegister("birthyear"))
{
  out.print("<tr><td align=\"right\">");
  //if(riobj.isInspect("inspectbirthyear"))
  out.print("*&nbsp;");
  out.print("出生日期：</td><td>");
  java.util.Calendar c= java.util.Calendar.getInstance();
  c.set(java.util.Calendar.YEAR,c.get(java.util.Calendar.YEAR)-30);
  if(birth==null)
  {
    birth =c.getTime();
  }
  out.print(new tea.htmlx.TimeSelection("Birth", birth));
  out.print("</td>");
  if(dbobj.getBirthyear()!=null && dbobj.getBirthyear().length()>0){
    out.print("<td>"+dbobj.getBirthyear()+"</td>");
  }
  out.print("</tr>");
}

if(riobj.isRegister("state"))
{
  out.print("<tr><td align=\"right\">");
  if(riobj.isInspect("inspectstate"))
  out.print("*&nbsp;");
  out.print("省份：</td><td>");
  if(city!=null&&city.length()>0)
  {

  }else
  {
     city ="null";
  }

  out.print(" <script>selectcard('State','City',null,'"+city+"');</script>");
  out.print("</td>");
  if(dbobj.getState()!=null && dbobj.getState().length()>0){
    out.print("<td>"+dbobj.getState()+"</td>");
  }
  out.print("</tr>");
}

if(riobj.isRegister("address"))
{
  out.print("<tr><td align=\"right\">");
  if(riobj.isInspect("inspectaddress"))
  out.print("*&nbsp;");
  out.print("通信地址：</td><td>");
  out.print(" <input type=text size=50 name=address value=\"");
  if(address!=null&&address.length()>0)
  {
    out.print(address);
  }
  out.print("\" > ");
  out.print("</td>");
  if(dbobj.getAddress()!=null && dbobj.getAddress().length()>0){
    out.print("<td>"+dbobj.getAddress()+"</td>");
  }
  out.print("</tr>");
}



if(riobj.isRegister("zip"))
{
  out.print("<tr><td align=\"right\">");
  if(riobj.isInspect("inspectzip"))
  out.print("*&nbsp;");
  out.print("邮政编码：</td><td>");
  out.print(" <input type=text  name=zip value=\"");
  if(zip!=null&&zip.length()>0)
  {
    out.print(zip);
  }
  out.print("\" maxlength=\"6\" > ");
  out.print("</td>");
  if(dbobj.getZip()!=null && dbobj.getZip().length()>0){
    out.print("<td>"+dbobj.getZip()+"</td>");
  }
  out.print("</tr>");
}

if(riobj.isRegister("telephone"))
{
  out.print("<tr><td align=\"right\">");
  if(riobj.isInspect("inspecttelephone"))
  out.print("*&nbsp;");
  out.print("电话号码：</td><td>");
  out.print(" <input type=text  name=telephone value=\"");
  if(telephone!=null&&telephone.length()>0)
  {
    out.print(telephone);
  }
  out.print("\" maxlength=\"12\"> ");
  out.print("</td>");
  if(dbobj.getTelephone()!=null && dbobj.getTelephone().length()>0){
    out.print("<td>"+dbobj.getTelephone()+"</td>");
  }
  out.print("</tr>");
}
if(riobj.isRegister("fax"))
{
  out.print("<tr><td align=\"right\">");
  if(riobj.isInspect("inspectfax"))
  out.print("*&nbsp;");
  out.print("传真号码：</td><td>");
  out.print(" <input type=text  name=fax value=\"");
  if(fax!=null&&fax.length()>0)
  {
    out.print(fax);
  }
  out.print("\" maxlength=\"12\"> ");
  out.print("</td>");
  if(dbobj.getFax()!=null && dbobj.getFax().length()>0){
    out.print("<td>"+dbobj.getFax()+"</td>");
  }
  out.print("</tr>");
}
//单位,organization

if(riobj.isRegister("organization"))
{
  out.print("<tr><td align=\"right\">");
  if(riobj.isInspect("inspectorganization"))
  out.print("*&nbsp;");
  out.print("单位：</td><td>");

  out.print(" <input type=text  name=organization value= ");
  if(organization!=null&&organization.length()>0)
  {
    out.print(organization);
  }
  out.print(" > ");
  out.print("</td>");
  out.print("<td>");
  if(dbobj.getOrganization()!=null && dbobj.getOrganization().length()>0){
    out.print(dbobj.getOrganization());
  }
  out.print("</td>");
  out.print("</tr>");
}


if(riobj.isRegister("position"))
{
   out.print("<tr><td align=\"right\">");
  if(riobj.isInspect("inspectposition"))
  out.print("*&nbsp;");
  out.print("职称：</td><td>");
  %>
   <select name="position">
        <option value="0">--请选择职称1--</option>
        <%
        for(int i =1;i<Doctor.JISHU_ZHICHENG.length;i++)
        {
          out.print("<option value="+i);

          out.print(">"+Doctor.JISHU_ZHICHENG[i]);
          out.print("</option>");
        }
        %>
        </select>
  <%/*
  out.print("<select  name=position>");
   // out.print("<input type=text  name=position value=");
 // if(position!=null&&position.length()>0)
  //{
   // out.print(position);
  //}
  out.print("<option value='住院医师'>住院医师</option> ");
  out.print("<option value='主治医师'>主治医师</option> ");
  out.print("<option value='副主治医师'>副主治医师</option> ");
   out.print("<option value='主任医师'>主任医师</option> ");
    out.print("</select> ");
*/
  //out.print("> ");
  out.print("</td>");
  if(dbobj.getPosition()!=null && dbobj.getPosition().length()>0){
    out.print("<td>"+dbobj.getPosition()+"</td>");
  }
  out.print("</tr>");
}

//科室 部门section
if(riobj.isRegister("section"))
{
  out.print("<tr><td align=\"right\">");
  if(riobj.isInspect("inspectsection"))
  out.print("*&nbsp;");
  out.print("科室(部门)：</td><td>");
  out.print(" <input type=text  name=section value= ");
  if(section!=null&&section.length()>0)
  {
    out.print(section);
  }
  out.print(" > ");
  out.print("</td>");
  out.print("<td>");
  if(dbobj.getSection()!=null && dbobj.getSection().length()>0){
    out.print(dbobj.getSection());
  }
  out.print("</td>");
  out.print("</tr>");
}
//学历
if(riobj.isRegister("degree"))
{
  out.print("<tr><td align=\"right\">");
  if(riobj.isInspect("inspectdegree"))
  out.print("*&nbsp;");
  out.print("学历：</td><td>");
  out.print(" <input type=text  name=degree value= ");
  if(degree!=null&&degree.length()>0)
  {
    out.print(degree);
  }
  out.print(" > ");
  out.print("</td>");
  out.print("<td>");
  if(dbobj.getDegree()!=null && dbobj.getDegree().length()>0){
    out.print(dbobj.getDegree());
  }
  out.print("</td>");
  out.print("</tr>");
}
//验证码
if(riobj.isRegister("vertify"))
{
  out.print("<tr><td align=\"right\">");
  if(riobj.isInspect("inspectvertify"))
  out.print("*&nbsp;");
  out.print("验证码：</td><td>");
 // out.print("<input type=\"text\"  name=vertify value=\"\" maxlength=\"4\"> <img src=\"/jsp/user/validate.jsp\" alt=\"vertify\">");
  out.print("<input name='vertify' alt='验证码' size='10'><img id='vcodeImg'  align='absmiddle' class='CodeImg'  src='/NFasts.do?act=verify'/><a href='###'   style='cursor:pointer'  onClick='reloadVcode();'>重新获得验证码</a>");
  out.print("</td>");
  if(dbobj.getVertify()!=null && dbobj.getVertify().length()>0){
    out.print("<td>"+dbobj.getVertify()+"</td>");
  }
  out.print("</tr>");
}
%>

</table>
<input type="submit" value="" class="edit_sub"/>　　
<input type="reset" name="button" class="edit_res" value="" />

</form>
</div>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="<%=community.getJspAfterPath(teasession._nLanguage)%>" type="text/javascript"></SCRIPT>
</body>

</html>

