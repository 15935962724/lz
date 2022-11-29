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
String name,picture,password,type;
if(cachet!=0)
{
  Cachet obj=Cachet.find(cachet);
  name=obj.getName();
  type=obj.getType();
  password=obj.getPassword();
  picture=obj.getPicture();
  if(picture!=null)
  {
    len=new java.io.File(application.getRealPath(picture)).length();
  }
}else
{
  name=picture=password=type="";
}


StringBuffer enc=new StringBuffer("0");
for(int i=0;i<password.length();i++)
{
  enc.append(","+(int)password.charAt(i));
}

%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type="text/javascript"></SCRIPT>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/mt.js" type="text/javascript"></SCRIPT>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/applet/office/ocx.js" type="text/javascript"></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<script language="JavaScript">
var enc=new Array(<%=enc.toString()%>);
function f_dec(a)
{
  var tmp=a?'<%=picture%>?':'';
  for(var i=1;i<enc.length;i++)
  {
    tmp+=String.fromCharCode(enc[i]);
  }
  return tmp;
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
  }
  form1.password.value=f_dec();
  form1.name.focus();
}
function f_submit()
{
  if(typeof(ocx)=="undefined")
  {
    alert("不能装载印章管理控件!!!");
    return false;
  }
  if(!submitText(form1.name, '<%=r.getString(teasession._nLanguage, "InvalidParameter")%>-名称')||!submitText(form1.type, '<%=r.getString(teasession._nLanguage, "InvalidParameter")%>-类型')||!submitText(form1.password, '<%=r.getString(teasession._nLanguage, "InvalidParameter")%>-密码')||(form1.cachet.value=="0"&&!submitText(form1.file, '<%=r.getString(teasession._nLanguage, "InvalidParameter")%>-图片')))
  {
    return false;
  }
  if(form1.password.value.length<6)
  {
    alert("密码长度不能小于6位");
    return false;
  }
  try
  {
    var path=mt.value(form1.file);
    if(path.length>0)
    {
      ocx.CreateNew(form1.name.value+"-"+form1.type.value,"<%=teasession._rv%>",form1.password.value,path);
      if(ocx.StatusCode!=0)
      {
        alert("创建印章文件错误.");
        return false;
      }
    }else
    {
      ocx.SignName =form1.name.value+"-"+form1.type.value;
      ocx.SignUser ="<%=teasession._rv%>";
      ocx.Password =form1.password.value;
    }
    ocx.SaveToURL(form1.action+"?cachet="+form1.cachet.value+"&community="+encodeURIComponent(form1.community.value)+"&repository=office&name="+encodeURIComponent(form1.name.value)+"&type="+encodeURIComponent(form1.type.value)+"&password="+encodeURIComponent(form1.password.value),"file");
    window.open(form1.nexturl.value,"_self");
    //form1.file.disabled=true;
  }catch(e)
  {
    alert("不能装载印章控件！");
  }
  return false;
}
</script>
</head>
<body onload="f_load()">
<h1>创建</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<BR>

<form name="form1" action="/servlet/EditCachet" onsubmit="return f_submit()">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>">
<input type="hidden" name="cachet" value="<%=cachet%>">
<input type="hidden" name="nexturl" value="<%=nexturl%>">

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td>名称:</td>
    <td><input name="name" value="<%=name%>" size="50" maxlength="100"></td>
  </tr>
  <tr>
    <td>类型:</td>
    <td><input name="type" value="<%=type%>"><input type="checkbox" name="type_c" onclick="form1.type.value='人名章'; form1.type.disabled=this.checked;" >人名章</td>
  </tr>
  <tr>
    <td>密码:</td>
    <td><input type="password" name="password" value="******" maxlength="32">(至少六位)</td>
  </tr>
  <tr>
    <td>浏览:</td>
    <td><input type="file" name="file" size="40"></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td nowrap>
      <input type="submit" value="提交">
      <input type="button" value="返回" onClick="history.back();">
    </td>
  </tr>
</table>
</form>


<script>var ocx=sign.show(f_dec(true));</script>

<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body></html>
