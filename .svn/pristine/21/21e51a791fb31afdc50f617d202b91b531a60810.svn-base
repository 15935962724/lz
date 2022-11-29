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
#intro1{width:79%;float:left;padding-left:20px;padding-right:25px;}
#cont1{line-height:150%;}
#intro4{width:20%;float:left;color:#999999;margin-top:10px;border-left:1px solid #DBDBDB}
#intro4 li{list-style:none;}
#intro4 ul{margin-left:5px;}
#Content2{padding-left:0px;}
#regi{text-align:center;width:100%;}
#xiangguan{color:#E00A1D;width:100%;border:1px solid #DBDBDB;line-height:200%;vertical-align:middle;text-align:center;border-left:none;}
#intro6 li{background-image:url(/res/redcome2007/u/0709/070957416.gif);background-repeat:no-repeat;background-position:5px 8px;line-height:200%;padding-left:16px;}
#login td{background-color:#fff;}
</style>
<%
request.setCharacterEncoding("UTF-8");

response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession=new TeaSession(request);
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

<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<script type="">
function sk()
{
  if(form1.pwd.value!=form1.chpassword.value)
  {
    alert("密码错误，请重新填写。");
    return false;
  }else if(form1.pwd.value==null || form1.pwd.value=="")
  {
    alert("密码不能为空！");
    return false;
  }else if(form1.chpassword.value==null || form1.chpassword.value=="")
  {
    alert("密码不能为空！");
    return false;
  }else if(form1.family.value==null || form1.family.value=="")
  {
   alert("姓不能为空！");
    return false;
  }else if(form1.firsts.value==null || form1.firsts.value=="")
  {
    alert("名不能为空！");
    return false;
  }else if(form1.corp.value==null || form1.corp.value=="")
  {
    alert("公司不能为空！");
    return false;
  }else if(form1.telephone.value==null || form1.telephone.value=="")
  {
    alert("联系电话不能为空！");
    return false;
  }else if(form1.show.value=="您已经是会员了，不需要在此注册！")
  {
    alert(form1.show.value);
    alert("您已经是会员了，请返回首页！");
    return false;
  }
}
</script>

</head>
<body>

<div id=intro1>
<form name=form1 METHOD=post  action="/servlet/EditLatency" onSubmit="return sub(this);">
<input type="hidden"  name="act" value="LatencyCompany"/>
<input type="hidden" name="type" value="<%=type%>">
<input type="hidden" name="show" value="<%=show%>" />


<table width="100%" border="0"  cellpadding="4" cellspacing="1" bgcolor="#DBDBDB" id="login">
    <tr>
      <th colspan="2"><b><%=Latency.LYTYPES[type]%> </b><br><%=show%></th>
    </tr>
    <tr>
      <td width="30%">电子邮件：</td>
      <td width="70%" class="right"><input type="text" name="email" size="30" maxlength="50" class="smallInput" >
          <font color="#cc0000">*</font></td>
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
        out.print("<input name=sex type=radio value="+i+">");
        out.print(Latency.SEXS[i]);
      }
      %>
<font color="#cc0000">*</font> </td>
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
        <select name="province" id="province" onchange = "return chcity();">
	<%
        for(int i=0;i<Latency.PROVINCES.length;i++)
        {
          out.print("<option value="+i+">");
          out.print(Latency.PROVINCES[i]+"</option>");
        }

        %>
        </select>&nbsp;<font color="#cc0000">*</font>&nbsp;<br><input name="city_ot" type="text" class="smallInput" id="city_ot" value="" size="15" maxlength="50" >&nbsp;其他
      </td>
    </tr>
    <tr>
      <td>城市：</td>

      <td class="right">
          <input name="city" type="text" class="smallInput" id="city_ot" value="" size="15" maxlength="50" >
          <font color="#cc0000">*</font></td>
    </tr>
<tr>
<td colspan="2" align="center"><input type="submit" value="提交"  onclick="return sk()"></td>
</tr>
</table>
</FORM>
</div>
</body>


</html>



