<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter"%>
<%@page import="tea.resource.Resource" %>
<%@page import="tea.entity.admin.office.*" %>
<%@page import="tea.ui.TeaSession" %>
<%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}


String nexturl=request.getParameter("nexturl");

int cachet=Integer.parseInt(request.getParameter("cachet"));

Resource r=new Resource();

long len=0L;
String name,picture,type;
if(cachet!=0)
{
  Cachet obj=Cachet.find(cachet);
  name=obj.getName();
  type=obj.getType();
  picture=obj.getPicture();
  if(picture!=null)
  {
    len=new java.io.File(application.getRealPath(picture)).length();
  }
}else
{
  name=picture=type="";
}

%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<script language="JavaScript">
 //如果成功状态，显示当前印章信息
function ShowSignInfo()
{
    document.all("SignName").value = ntkosignctl.SignName;
    document.all("SignUser").value = ntkosignctl.SignUser;
    document.all("Password").value = ntkosignctl.Password;
    document.all("SignWidth").innerHTML = ntkosignctl.SignWidth;
    document.all("SignHeight").innerHTML = ntkosignctl.SignHeight;
}

function CreateNew()
{
  if(submitText(form1.name, '<%=r.getString(teasession._nLanguage, "InvalidParameter")%>-名称')&&submitText(form1.type, '<%=r.getString(teasession._nLanguage, "InvalidParameter")%>-类型')&&submitText(form1.file, '<%=r.getString(teasession._nLanguage, "InvalidParameter")%>-图片'))
  {
    ntkosignctl.CreateNew(form1.name.value,form1.member.value,form1.password.value,form1.file.value);
    if(ntkosignctl.StatusCode==0)
    {
      return true;
    }
    alert("创建印章文件错误.");
  }
  return false;
}
function f_load()
{
  if(form1.cachet.value!="0")
  {
    if(form1.type.value=='人名章')
    {
      form1.type.disabled=true;
      form1.type_c.checked=true;
    }
    ntkosignctl.OpenFromURL("<%=picture%>",form1.password.value);
  }
}
function SaveToURL()
{
  if(CreateNew())
  {
    ntkosignctl.SaveToURL(form1.action+"?act=control&cachet="+form1.cachet.value+"&name="+encodeURIComponent(form1.name.value)+"&type="+encodeURIComponent(form1.type.value),"file");
    window.open(form1.nexturl.value,"_self");
  }
  return false;
}
</script>
</head>
<body onload="f_load()">
<h1>创建</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br/>

<form name="form1" action="/servlet/EditCachet">
<input type="hidden" name="cachet" value="<%=cachet%>">
<input type="hidden" name="nexturl" value="<%=nexturl%>">
<input type="hidden" name="member" value="webmaster">
<input type="hidden" name="password" value="">

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr><td>名称:</td><td><input name="name" value="<%=name%>" size="40"></td></tr>
  <tr><td>类型:</td><td><input name="type" value="<%=type%>"><input type="checkbox" name="type_c" onclick="form1.type.value='人名章'; form1.type.disabled=this.checked;" >人名章</td></tr>
    <tr><td>浏览:</td><td><input type="file" name="file" size="40"></td></tr>
  <tr>
    <td>&nbsp;</td>
    <td nowrap>
      <input type="submit" value="提交" onclick="return SaveToURL()">
      <input type="button" value="返回" onClick="history.back();">
    </td>
  </tr>
</table>
</form>

<script src="/tea/applet/office/GenOcxObj.js"></script>

<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
