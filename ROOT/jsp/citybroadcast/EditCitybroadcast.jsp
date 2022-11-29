<%@page contentType="text/html;charset=UTF-8" %><%@ page import="java.net.*"%><%@ page import="java.util.*"%><%@ page import="java.text.*"%><%@ page import="java.security.*"%><%@ page import="com.capinfo.crypt.*"%><%@ page import="tea.entity.member.*"%>
<%@ page import="tea.ui.*"%><%@ page import="java.math.*"%><%@ page import="tea.entity.csvclub.alipay.*"%><%@ page import="tea.entity.csvclub.encrypt.*" %><%@ page import="tea.entity.admin.mov.*" %><%@ page import="tea.entity.admin.*" %>
<%@ page import="tea.entity.citybcst.*" %>
<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");

TeaSession teasession = new TeaSession(request);
StringBuffer param=new StringBuffer();

String menu_id=(request.getParameter("id"));
if(menu_id!=null&&menu_id.length()>0)
{
  param.append("&id=").append(menu_id);
}

String num="0";
if(teasession.getParameter("num")!=null)
{
  num=teasession.getParameter("num");
}

int ids=0;
if(teasession.getParameter("ids")!=null && teasession.getParameter("ids").length()>0)
{
  ids=Integer.parseInt(teasession.getParameter("ids"));
}
CityBcst bcstobj = CityBcst.find(ids);

%>
<html>
<head>

<script> if(parent.lantk) { document.getElementsByTagName("LINK")[0].href="/res/csvclub/cssjs/community_02.css"; } </script>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type="" ></SCRIPT>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/jsp/csvclub/js.js" type=""></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache"/>
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache"/>
<META HTTP-EQUIV="Expires" CONTENT="0"/>
<title>城市服务管理广播社区信息员招聘</title>

<script language="JavaScript" src="calendar.js"></script>
<script language="javascript">


function find_sub()
{

  var   strReg="";
  var   r;
  var str = document.getElementById("email").value;
  strReg=/^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/i;
  r=str.search(strReg);

  if(form3.firstname.value=="" ||form3.firstname.value==null  )
  {
    alert("姓名不能为空，请重新填写！");
    return false;
  }
  if(form3.age.value=="" ||form3.age.value==null  )
  {
    alert("年龄不能为空，请重新填写！");
    return false;
  }
  if(form3.card.value=="" ||form3.card.value==null  )
  {
    alert("证件号不能为空，请重新填写！");
    return false;
  }

  if(form3.addr.value=="" ||form3.addr.value==null  )
  {
    alert("居住地址不能为空，请重新填写！");
    return false;
  }
    if(form3.zip.value=="" ||form3.zip.value==null  )
  {
    alert("邮政编码不能为空，请重新填写！");
    return false;
  }
  if(form3.telephone.value=="" ||form3.telephone.value==null  )
  {
    alert("联系电话不能为空，请重新填写！");
    return false;
  }
  return true;
}
function isIdCardNo(s)
{
  if ((s.length <15)||(s.length ==16)||(s.length ==17)||(s.length >18))
  {
    window.alert("身份证位数不正确！");
    return false;
  }
  slen=s.length-1;//身份证除最后一位外，必须为数字！
  for (i=0; i<slen; i++)
  {
    cc = s.charAt(i);
    if (cc <"0" || cc >"9")
    {
      window.alert("请填写正确的身份证号！");
      return false;
    }
  }
  return true;
}



var obj;
function f_ajax(v,n)
{
  obj=document.all(n).options;
  while(obj.length>1)obj[1]=null;
  if(v=="0")v="1111111111";
  sendx("/servlet/Ajax?act=cityname&value="+v,f_change);
}
function f_change(d)
{
  d=eval(d);
  for(var i=0;i<d.length;i++)
  {
    obj[i+1]=new Option(d[i][1],d[i][0]);
  }
  switch(obj.name)
  {
    case "street":
    form3.street.value="<%=bcstobj.getStreet()%>";
    if(form3.street.selectedIndex==-1)form3.street.selectedIndex=0;
    form3.street.onchange();
    break;
    case "community2":
    form3.community2.value="<%=bcstobj.getCommunity()%>";
    if(form3.community2.selectedIndex==-1)form3.community2.selectedIndex=0;
    break;
  }
}
function f_load()
{
  form3.city.onchange();
}
</script>
<link href="style.css" rel="stylesheet" type="text/css" />
<link href="../about/style.css" rel="stylesheet" type="text/css" />
</head>

<body onLoad="f_load()">
<form name="form3" action="/servlet/EditCityBcst" method="POST">
<input type="hidden" name="act" value="EditCitybroadcast" />
<input type="hidden" name="ids" value="<%=ids%>" />
<TABLE border="0" CELLPADDING="0" CELLSPACING="0" id="tablecenter">
  <tr>
 <td> <font color=red>*</font>姓名： </td>  <td><input type="text" name="firstname"   value="<%if(bcstobj.getFirstname()!=null)out.print(bcstobj.getFirstname());%>"/> </td>
  <td> <font color=red>*</font>性别： </td>  <td><select name="sex"><option value="0">男</option><option value="1">女</option></select> </td>
</tr>
  <tr>
 <td> <font color=red>*</font>年龄： </td>  <td><input type="text" name="age"  mask="float" maxlength="2" value="<%if(bcstobj.getAge()!=null)out.print(bcstobj.getAge());%>"/> </td>
  <td> 身份证号码： </td>  <td><input type="text" name="card"  value="<%if(bcstobj.getCard()!=null)out.print(bcstobj.getCard());%>"/></td>
</tr>
  <tr>
 <td> 所在城区： </td>  <td colspan="3">
   城区  <select  name="city" onChange="f_ajax(value,'street')"><option  value="0">-------</option>
   <%
   Enumeration eu = Cityname.findByCommunity(" and levelid=1 ",0,8);
   for(int i=0;eu.hasMoreElements();i++)
   {
     int cityid= Integer.parseInt(String.valueOf(eu.nextElement()));
     Cityname cityobj = Cityname.find(cityid);
     out.print("<option value="+cityid);
     if(bcstobj.getCity()==cityid)
     {
       out.print(" selected ");
     }
     out.print(">"+cityobj.getCityname()+"</option>");
   }
   %>

 </select>　
   街道<select name="street"  onChange="f_ajax(value,'community2')"><option value="0" >-------</option><option value="5000">其他</option>
</select>　
   社区<select name="community2"><option  value="0">-------</option></select> </td>
   </tr>
   <tr id="lzj_wu_bd">
     <td>如果没有<br>您所在城区：</td>
	 <td colspan="3">城区&nbsp;<input name="other" value="<%if(bcstobj.getOther()!=null)out.print(bcstobj.getOther());%>" />
	 　
   街道&nbsp;<input name="other2" value="<%if(bcstobj.getOther2()!=null)out.print(bcstobj.getOther2());%>" />
       　
   社区&nbsp;<input name="other3" value="<%if(bcstobj.getOther3()!=null)out.print(bcstobj.getOther3());%>" /></td></tr>
 <tr><td nowrap="nowrap"><font color=red>*</font>居住地址：</td>
   <td colspan="3" class="td06"><input type="TEXT" name="addr" value="<%if(bcstobj.getAddr()!=null)out.print(bcstobj.getAddr());%>"/></td>
</tr>
<tr><td><font color=red>*</font>邮政编码：</td><td><input type="TEXT" name="zip" value="<%if(bcstobj.getZip()!=null)out.print(bcstobj.getZip());%>" mask="float" maxlength="6"  /></td>
  <td>职业：</td><td ><input type="TEXT" name="zhiye" value="<%if(bcstobj.getZhiye()!=null)out.print(bcstobj.getZhiye());%>"/></td></tr>
<tr><td><font color=red>*</font>联系电话：</td><td><input type="TEXT" name="telephone" value="<%if(bcstobj.getTelephone()!=null)out.print(bcstobj.getTelephone());%>" maxlength="13"/></td>
  <td>E-mail：</td><td><input type="TEXT" name="email" value="<%if(bcstobj.getEmail()!=null)out.print(bcstobj.getEmail());%>"/></td></tr>
<tr><td><font color=red>*</font>个人简介：</td><td colspan="3"><textarea name="intro" rows="5" cols="60"><%if(bcstobj.getIntro()!=null)out.print(bcstobj.getIntro());%></textarea></td></tr>
<tr><td align="center" colspan="4"><input type="submit" value="提交" onClick="return find_sub()" id="lzj_an" /></td>
</tr>
</table>
</form>
</body>
</html>

