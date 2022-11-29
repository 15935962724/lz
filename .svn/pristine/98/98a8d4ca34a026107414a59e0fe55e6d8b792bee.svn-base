<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="tea.htmlx.*"%>
<%@ page import="tea.ui.TeaSession"%>
<%@ page import="tea.resource.*" %>
<%@ page import="tea.entity.bpicture.*" %>
<%@ page import="tea.entity.admin.mov.*"%>
<%
TeaSession teasession =new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

int membertype = 0;
if(teasession.getParameter("membertype")!=null && teasession.getParameter("membertype").length()>0)
{
  membertype = Integer.parseInt(teasession.getParameter("membertype"));
}



MemberType myobj = MemberType.find(membertype);
RegisterInstall riobj = RegisterInstall.find(membertype);
Describes dbobj = Describes.find(membertype);
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
<body bgcolor="#ffffff">
<script type="text/javascript">
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
      if(isNaN(document.all.frmsrch.vertify.value))
      {
        alert("您输入的验证码不合法，应该输入纯数字！");
           frmsrch.vertify.focus();
        return false;
      }
    }
  }else
  {
    return false;
  }


}
</script>
<form name="frmsrch" method="POST" action="/servlet/EditMember" onsubmit="return f_edit(this);">
<input type="hidden" name="membertype" value="<%=membertype%>"/>
<input type="hidden" name="act" value="register"/>
<%=tea.entity.admin.mov.RegisterInstall.getNavigation((membertype),teasession._nLanguage) %>
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
out.print("<td><input type=text name=MemberId value=\"\"/>&nbsp;&nbsp;&nbsp;&nbsp;");
out.print("<input type=\"button\"  value=\"账号检测\" onClick=\"f_ajax();\"/>&nbsp;&nbsp;&nbsp;&nbsp;<span id=\"show\">&nbsp;</span></td>");
out.print("<td>");
if(dbobj.getMember()!=null && dbobj.getMember().length()>0){
  out.print(dbobj.getMember());
}
out.print("</td>");
out.print("</tr>");
%>

<tr>
  <td width="80" align="right">*&nbsp;密码：</td>
  <td><input type="password" name="EnterPassword" value=""/></td>
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
  <td><input type="password" name="ConfirmPassword" value=""/></td>
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
  out.print("<input type=\"text\" name=email value= >");
  out.print("</td>");
  if(dbobj.getEmail()!=null && dbobj.getEmail().length()>0){
    out.print("<td>"+dbobj.getEmail()+"</td>");
  }
  out.print("</tr>");
}



if(riobj.isRegister("firstname"))
{
  out.print("<tr><td align=\"right\">");
  if(riobj.isInspect("inspectfirstname"))
  out.print("*&nbsp;");
  out.print("姓名：</td><td>");
  out.print("<input type=\"text\" name=firstname value= >");
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
  out.print("<input type=\"radio\" name=\"sex\" value=\"1\" checked /> 先生");
  out.print("<input type=\"radio\" name=\"sex\" value=\"0\"  /> 女士");
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
  out.print("<input type=\"text\" name=card value= >");
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
  out.print(new tea.htmlx.TimeSelection("Birth", c.getTime()).toString());
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
  out.print(" <script>selectcard('State','City',null,'');</script>");
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
  out.print(" <input type=text size=50 name=address value=>");
  out.print("</td>");
  if(dbobj.getAddress()!=null && dbobj.getAddress().length()>0){
    out.print("<td>"+dbobj.getAddress()+"</td>");
  }
  out.print("</tr>");
}

if(riobj.isRegister("phonenumber") && riobj.getRestrictions()!=2)
{
  out.print("<tr><td align=\"right\">");
  if(riobj.isInspect("inspectphonenumber"))
  out.print("*&nbsp;");
  out.print("手机号码：</td><td>");
  out.print(" <input type=text  name=phonenumber value=\"\" maxlength=\"11\">");
  out.print("</td>");
  if(dbobj.getPhonenumber()!=null && dbobj.getPhonenumber().length()>0){
    out.print("<td>"+dbobj.getPhonenumber()+"</td>");
  }
  out.print("</tr>");
}

if(riobj.isRegister("zip"))
{
  out.print("<tr><td align=\"right\">");
  if(riobj.isInspect("inspectzip"))
  out.print("*&nbsp;");
  out.print("邮政编码：</td><td>");
  out.print(" <input type=text  name=zip value=\"\" maxlength=\"6\" >");
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
  out.print(" <input type=text  name=telephone value=\"\" maxlength=\"12\">");
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
  out.print(" <input type=text  name=fax value=\"\" maxlength=\"12\">");
  out.print("</td>");
  if(dbobj.getFax()!=null && dbobj.getFax().length()>0){
    out.print("<td>"+dbobj.getFax()+"</td>");
  }
  out.print("</tr>");
}
if(riobj.isRegister("position"))
{
   out.print("<tr><td align=\"right\">");
  if(riobj.isInspect("inspectposition"))
  out.print("*&nbsp;");
  out.print("职称：</td><td>");
  out.print(" <input type=text  name=position value=\"\" >");
  out.print("</td>");
  if(dbobj.getPosition()!=null && dbobj.getPosition().length()>0){
    out.print("<td>"+dbobj.getPosition()+"</td>");
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
  out.print(" <input type=text  name=organization value=\"\" >");
  out.print("</td>");
  out.print("<td>");
  if(dbobj.getOrganization()!=null && dbobj.getOrganization().length()>0){
    out.print(dbobj.getOrganization());
  }
  out.print("</td>");
  out.print("</tr>");
}
//科室 部门section
if(riobj.isRegister("section"))
{
  out.print("<tr><td align=\"right\">");
  if(riobj.isInspect("inspectsection"))
  out.print("*&nbsp;");
  out.print("科室(部门)：</td><td>");
  out.print(" <input type=text  name=section value=\"\" >");
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
  out.print(" <input type=text  name=degree value=\"\" >");
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
  out.print("<input type=\"text\"  name=vertify value=\"\" maxlength=\"4\"> <img src=\"/jsp/user/validate.jsp\" alt=\"vertify\">");
  out.print("</td>");
  if(dbobj.getVertify()!=null && dbobj.getVertify().length()>0){
    out.print("<td>"+dbobj.getVertify()+"</td>");
  }
  out.print("</tr>");
}
%>
</table>
<%
if(riobj.getClause()==1)//如果有服务条款 就显示上一步
{
  out.print("<input type=button value=上一步 onclick=window.open('/jsp/mov/SigUp.jsp?membertype="+membertype+"','_self'); > &nbsp;&nbsp;&nbsp;&nbsp;");
}
%>

<input type="submit" value="提交"/>
</form>

</body>

</html>

