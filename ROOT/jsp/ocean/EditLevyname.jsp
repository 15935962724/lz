<%@page contentType="text/html;charset=UTF-8" %><%@ page import="java.net.*"%><%@ page import="java.util.*"%><%@ page import="java.text.*"%><%@ page import="java.security.*"%><%@ page import="com.capinfo.crypt.*"%>
<%@ page import="tea.entity.member.*"%><%@ page import="tea.ui.*"%><%@ page import="java.math.*"%><%@ page import="tea.entity.csvclub.alipay.*"%><%@ page import="tea.entity.csvclub.encrypt.*" %>
<%@ page import="tea.entity.admin.mov.*" %><%@ page import="tea.entity.admin.*" %><%@ page import="tea.entity.ocean.*" %>
<%

response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");

TeaSession teasession = new TeaSession(request);
int ids = 0;
if(teasession.getParameter("ids")!=null && teasession.getParameter("ids").length()>0)
{
  ids = Integer.parseInt(teasession.getParameter("ids"));
}
StringBuffer param=new StringBuffer();
String menu_id=(request.getParameter("id"));
if(menu_id!=null&&menu_id.length()>0)
{
  param.append("&id=").append(menu_id);
}

LevyName lobj  = LevyName.find(ids);
%>
<% 
if(ids!=0){  %>  <html><head>
<link href="http://www.bj-sea.com/tea/CssJs/bj-sea.css" rel="stylesheet" type="text/css"></head>
<body><h1>海洋馆名称征集申请表</h1>s<%}%>
<script type="">
function find_sub()
{
  if(form1.dolphin.value=="" ||form1.dolphin.value==null  )
  {
    //alert("海豚王子的名字不能为空，请重新填写！");
    alert("白鲸王子的名字不能为空，请重新填写！");
    return false;
  }
  if(form1.bigprincess.value=="" ||form1.bigprincess.value==null  )
  {
    //alert("大公主的名字不能为空，请重新填写！");
    alert("白鲸公主的名字不能为空，请重新填写！");
    return false;
  }
  if(form1.littleprincess.value=="" ||form1.littleprincess.value==null  )
  {
    //alert("小公主的名字不能为空，请重新填写！");
    //return false;
  }
  if(form1.moral.value=="" ||form1.moral.value==null  )
  {
    alert("寓意不能为空，请重新填写！");
    return false;
  }
  if(form1.firstname.value=="" ||form1.firstname.value==null  )
  {
    alert("姓名不能为空，请重新填写！");
    return false;
  }
  if(form1.card.value=="" ||form1.card.value==null  )
  {
    alert("身份证号不能为空，请重新填写！");
    return false;
  }
  if(form1.tel.value=="" ||form1.tel.value==null  )
  {
    alert("联系电话不能为空，请重新填写！");
    return false;
  }else if(form1.tel.value.length<11)
  {
    alert("联系方式的格式为：010-88757576 或 13812345678");
    return false;
  }
  if(isIdCardNo(form1.card.value))
  {
    return true;
  }else
  {
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
</script><form  name="form1" action="/servlet/EditLevyName" method="POST" enctype="multipart/form-data">
<input  type="hidden" value="EditLevyname" name="act"/>
<input  type="hidden" value="<%=ids%>" name="ids"/>
<input type="hidden" name="oceanorder" value=""/>
<table  border="0" <%if(ids!=0){  %> id="tablecenter"  <%}%>>
  <tr><td><font color="red">*</font><!--为海豚王子起的名字：-->为白鲸王子起的名字：</td><td><input name="dolphin" value="<%if(lobj.getDolphin()!=null)out.print(lobj.getDolphin());%>"  maxlength="4" /></td>
</tr>
<tr><td><font color="red">*</font><!--为大公主起的名字：-->为白鲸公主起的名字：</td><td><input name="bigprincess" value="<%if(lobj.getBigprincess()!=null)out.print(lobj.getBigprincess());%>"  maxlength="4" /></td>
</tr>
<!--
<tr><td><font color="red">*</font>为小公主起的名字：</td><td><input name="littleprincess" value="<%if(lobj.getLittleprincess()!=null)out.print(lobj.getLittleprincess());%>"  maxlength="4" /></td>
</tr>
-->
<tr><td><font color="red">*所起名字寓意：</font></td><td><textarea name="moral" cols="20" rows="4"><%if(lobj.getMoral()!=null)out.print(lobj.getMoral());%></textarea></td>
</tr>
<tr><td><font color="red">*</font>您的姓名：</td><td><input name="firstname" value="<%if(lobj.getFirstname()!=null)out.print(lobj.getFirstname());%>" maxlength="12" /></td>
</tr>
<tr><td><font color="red">*</font>您的性别：</td><td>男<input type="radio" name="sex" value="1" checked="checked" <%if(lobj.getSex()==1)out.print("checked");%>/> <%if(lobj.getSex()==1)out.print("checked");%>　女<input type="radio" name="sex" value="0" <%if(lobj.getSex()==0)out.print("checked");%>/></td>
</tr>
<tr><td><font color="red">*</font>您的身份证号码：</td><td><input name="card" value="<%if(lobj.getCard()!=null)out.print(lobj.getCard());%>" maxlength="18"  /></td>
</tr>
<tr><td><font color="red">*</font>您的联系电话：	</td><td><input name="tel" value="<%if(lobj.getTel()!=null)out.print(lobj.getTel());%>"  maxlength="15"  /></td>
</tr>
<tr><td align="center"><input type="submit" value="提交" onclick="return find_sub()" />　</td>
</tr>
</table>
</form>
<%if(ids!=0){  %>  </body></html>  <%}%>


