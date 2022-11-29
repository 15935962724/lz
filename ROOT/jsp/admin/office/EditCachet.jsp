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

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type="text/javascript"></SCRIPT>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/jsp/criterion/js.js"></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script>
function defaultfocus()
{
  form1.name.focus();
  if(form1.type.value=='人名章')
  {
    form1.type.disabled=true;
    form1.type_c.checked=true;
  }
}
function f_view()
{
  var vi=document.getElementById('vi');
  var url='/servlet/EditCachet?act=view&name='+encodeURIComponent(form1.name.value);
  if(!form1.type.disabled)
  {
    url=url+'&type='+encodeURIComponent(form1.type.value);
  }
  vi.src=url+"&ex=.png";
}
</script>
</head>
<body onLoad="defaultfocus();">

<h1>创建</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<BR>
<form name="form1" action="/servlet/EditCachet" method="post" enctype="multipart/form-data" onSubmit="return submitText(this.name, '<%=r.getString(teasession._nLanguage, "InvalidParameter")%>-名称')&&submitText(this.type, '<%=r.getString(teasession._nLanguage, "InvalidParameter")%>-类型')">
<input type=hidden name="cachet" value="<%=cachet%>"/>
<input type=hidden name="community" value="<%=teasession._strCommunity%>"/>
<input type=hidden name="nexturl" value="<%=nexturl%>"/>
<input type=hidden name="act" value="edit"/>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td>名称</td>
    <td nowrap><input name="name" type="text" value="<%=name%>" size="40"></td>
  </tr>
  <tr>
    <td>类型</td>
    <td nowrap><input name="type" type="text"  value="<%=type%>"><input type="checkbox" name="type_c" onclick="form1.type.value='人名章'; form1.type.disabled=this.checked;" >人名章</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td nowrap>
      <input type="submit" value="提交">
      <input type="reset" value="重置" onClick="defaultfocus();">
      <input type="button" value="返回" onClick="history.back();">
    </td>
  </tr>
</table>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<!--
  <tr>
    <td>名称</td>
    <td nowrap><input name="na6me" type="text" value="<%=name%>" size="40"></td>
  </tr>
  <tr>
    <td>类型</td>
    <td nowrap><input name="type6" type="text"  value="<%=type%>" size="40"></td>
  </tr>
-->
  <tr>
    <td>&nbsp;</td>
    <td nowrap>
      <input type="button" value="预览" onclick="f_view();">
    </td>
  </tr>
</table>
<img id="vi" src="<%=picture%>" onload="this.style.display=''; alphaPNG(this); " style="display:none;position:absolute;z-index:1;left:300px;top:200px;cursor:move;" onMouseDown="this.down=true; this.x=event.offsetX; this.y=event.offsetY; this.setCapture();" onMouseUp="if(this.down){ this.releaseCapture(); this.down=false; }" onMouseMove="if(this.down){ var x=event.clientX+document.body.scrollLeft; if(x<0) x=0; var y=event.clientY+document.body.scrollTop; if(y<0)y=0; this.style.left=x-this.x; this.style.top=y-this.y; }">
</form>

<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</HTML>
