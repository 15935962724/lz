<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="tea.ui.TeaSession"%>
<%@page import="tea.entity.site.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.resource.*"%>
<%@page import="tea.db.*"%>
<%@page import="tea.entity.member.*"%>
<%@page import="tea.entity.admin.*"%>
<%@page import="tea.entity.admin.orthonline.*"%>
<%@page import="java.util.Date"%>
<%
request.setCharacterEncoding("UTF-8");
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
TeaSession teasession = new TeaSession(request);
if (teasession._rv == null) {
  response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
  return;
}


String nexturl = teasession.getParameter("nexturl");
String community = teasession.getParameter("community");
StringBuffer sql = new StringBuffer();
StringBuffer param = new StringBuffer();
param.append("?id=").append(request.getParameter("id"));
param.append("&community=").append(community);
int hoid = 0;
if(teasession.getParameter("hoid")!=null && teasession.getParameter("hoid").length()>0)
{
  hoid = Integer.parseInt(teasession.getParameter("hoid"));
}

Hospital hobj = Hospital.find(hoid);

%>

<html>
<head>
<link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" language="javascript" src="/tea/tea.js"></script>
<title>医院信息编辑</title>
</head>
<body id="bodynone" >
<script>
function f_submit()
{
  if(form1.honame.value=='')
  {
    alert('医院名称不能为空.');
    form1.honame.focus();
    return false;
  }
   if(form1.provincial.value=='')
  {
    alert('所在省份不能为空.');
    form1.provincial.focus();
    return false;
  }
   if(form1.city.value=='')
  {
    alert('所在市区不能为空.');
    form1.city.focus();
    return false;
  }
//   if(form1.grade.value=='')
//  {
//    alert('医院级别不能为空.');
//    form1.grade.focus();
//    return false;
//  }
//   if(form1.hotype.value=='')
//  {
//    alert('医院性质不能为空.');
//    form1.hotype.focus();
//    return false;
//  }
//   if(form1.telephone.value=='')
//  {
//    alert('医院电话不能为空.');
//    form1.telephone.focus();
//    return false;
//  }
//   if(form1.email.value=='')
//  {
//    alert('电子邮箱不能为空.');
//    form1.email.focus();
//    return false;
//  }
//   if(form1.zip.value=='')
//  {
//    alert('邮政编码不能为空.');
//    form1.zip.focus();
//    return false;
//  }
//   if(form1.address.value=='')
//  {
//    alert('医院地址不能为空.');
//    form1.address.focus();
//    return false;
//  }

}
</script>
<h1>医院信息编辑</h1>

<form action="/servlet/EditHospital" name="form1"  method="POST" onsubmit="return f_submit();"><!--/servlet/EditDoctor-->

<input type="hidden" name="community" value="<%=community%>" />
<input type="hidden" name="nexturl" value="<%=nexturl%>" />
<input type="hidden" name="act" value="EditHospital"/>
<input type="hidden" name="hoid" value="<%=hoid%>"/>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td  align="right"><font color="red">*</font>&nbsp;医院名称</td>
    <td><input type="text" name="honame" value="<%if(hobj.getHoname()!=null)out.print(hobj.getHoname()); %>" size="70"/></td>
  </tr>
  <tr>
    <td  align="right"><font color="red">*</font>&nbsp;所在省份</td>
    <td><input type="text" name="provincial" value="<%if(hobj.getProvincial()!=null)out.print(hobj.getProvincial()); %>" /></td>
  </tr>
  <tr>
    <td  align="right"><font color="red">*</font>&nbsp;所在市区</td>
    <td><input type="text" name="city" value="<%if(hobj.getCity()!=null)out.print(hobj.getCity()); %>" /></td>
  </tr>
  <tr>
    <td  align="right">&nbsp;医院级别</td>
    <td><input type="text" name="grade" value="<%if(hobj.getGrade()!=null)out.print(hobj.getGrade()); %>" /></td>
  </tr>
  <tr>
    <td  align="right">&nbsp;医院性质</td>
    <td><input type="text" name="hotype" value="<%if(hobj.getHotype()!=null)out.print(hobj.getHotype()); %>" /></td>
  </tr>
  <tr>
    <td  align="right">&nbsp;医院电话</td>
    <td><input type="text" name="telephone" value="<%if(hobj.getTelephone()!=null)out.print(hobj.getTelephone()); %>" /></td>
  </tr>
  <tr>
    <td  align="right">&nbsp;电子邮箱</td>
    <td><input type="text" name="email" value="<%if(hobj.getEmail()!=null)out.print(hobj.getEmail()); %>" /></td>
  </tr>
  <tr>
    <td  align="right">&nbsp;邮政编码</td>
    <td><input type="text" name="zip" value="<%if(hobj.getZip()!=null)out.print(hobj.getZip()); %>" /></td>
  </tr>

  <tr>
    <td  align="right">&nbsp;医院网址</td>
    <td><input type="text" name="weburl" value="<%if(hobj.getWeburl()!=null)out.print(hobj.getWeburl()); %>" /></td>
  </tr>
  <tr>
    <td  align="right">&nbsp;医院地址</td>
    <td><input type="text" name="address" value="<%if(hobj.getAddress()!=null)out.print(hobj.getAddress()); %>" size="70"/></td>
  </tr>

  <tr>
    <td  align="right">&nbsp;医院介绍</td>
    <td><textarea cols="70" rows="4" name="introduce"><%if(hobj.getIntroduce()!=null)out.print(hobj.getIntroduce()); %></textarea></td>
  </tr>
</table>
<input type="submit" value="添加" />&nbsp;
<input type=button value="返回" onClick="javascript:history.back()">
</form>

<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
