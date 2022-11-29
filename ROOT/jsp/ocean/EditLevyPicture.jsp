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
LevyPicture lpoj =LevyPicture.find(ids);
%>
<%
if(ids!=0){%><html><head><link href="http://www.bj-sea.com/tea/CssJs/bj-sea.css" rel="stylesheet" type="text/css"></head>
<body><h1>海洋馆图片征集申请表</h1><%}%>
<script type="">
function find_sub()
{
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
</script>
<form  name="form1" action="/servlet/EditLevyName" method="POST" enctype="multipart/form-data">
<input  type="hidden" value="EditLevyPicture" name="act"/>
<input  type="hidden" value="<%=ids%>" name="ids"/>
<input type="hidden" name="oceanorder" value=""/>
<table  border="0" <%if(ids!=0){  %> id="tablecenter"  <%}%>>
  <tr>
    <tr><td>您的姓名：</td><td><input name="firstname" value="<%if(lpoj.getFirstname()!=null)out.print(lpoj.getFirstname());%>" /></td></tr>
    <tr><td>您的联系电话：	</td><td><input name="tel" value="<%if(lpoj.getTel()!=null)out.print(lpoj.getTel());%>" /></td></tr>
    <tr><td>您的身份证号码：</td><td><input name="card" value="<%if(lpoj.getCard()!=null)out.print(lpoj.getCard());%>" maxlength="18"  /></td></tr>
    <tr><td>在线上传：</td><td><input name="path" type="file" value="" /></td></tr>
    <%
    if(lpoj.getPath()!=null)
    {
      %>
      <tr><td>作品显示</td><td><img alt="" src="<%=lpoj.getPath()%>" /></td>
      </tr>

      <%
    }
    %>
    <tr><td><input type="submit" value="提交" onclick="return find_sub()" />　</td>
  </tr>
</table>
</form>
<%if(ids!=0){%></body></html><%}%>


