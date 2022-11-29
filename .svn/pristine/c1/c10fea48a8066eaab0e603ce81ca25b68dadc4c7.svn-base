<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter"%>
<%@page import="tea.resource.Resource" %>
<%@page import="tea.entity.admin.earth.*" %>
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

String ip=request.getParameter("ip");



Resource r=new Resource();


String name=null;
int port=80;
int node=0 ;
boolean isNew=(ip==null||ip.length()<1);
if(!isNew)
{
  EarthIp obj=EarthIp.find(ip);
  name=obj.getName();
  port=obj.getPort();
  node=obj.getNode();
}else
{

}

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/jsp/criterion/js.js"></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script>
function defaultfocus()
{
  try
  {
    form1.ip.focus();
  }catch(e)
  {
    form1.name.focus();
  }
}

</script>
</head>
<body onLoad="defaultfocus();">

<h1>创建</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br/>
<form name="form1" action="/servlet/EditEarth" method="post" onSubmit="return submitText(this.ip, '<%=r.getString(teasession._nLanguage, "InvalidParameter")%>-IP')&&submitText(this.name, '<%=r.getString(teasession._nLanguage, "InvalidParameter")%>-名称')&&submitInteger(this.port, '<%=r.getString(teasession._nLanguage, "InvalidParameter")%>-端口')">
<input type=hidden name="community" value="<%=teasession._strCommunity%>"/>
<input type=hidden name="nexturl" value="<%=nexturl%>"/>
<input type='hidden' name="act" value="editearthip"/>
<%
if(!isNew)out.print("<input type='hidden' name='oldip' value="+ip+">");
%>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td>IP</td>
    <td nowrap>
    <%
    //if(isNew)
    out.print("<input name='ip' id=text1 size=40 onkeypress='inputFloat();' value='"+ip+"'>");
    //else
    //out.print("<input type=hidden name=ip value='"+ip+"' >"+ip);
    %>
    </td>
  </tr>
  <tr>
    <td>名称</td>
    <td nowrap><input name="name" value="<%if(name!=null)out.print(name);%>" size="40"></td>
  </tr>
  <tr>
    <td>端口</td>
    <td nowrap><input name="port" value="<%=port%>" onkeypress="inputInteger();"></td>
  </tr>
  <tr>
    <td>节点</td>
    <td nowrap><input name="nodex" value="<%=node%>" onkeypress="inputInteger();"></td>
  </tr>
</table>
<input type="submit" value="提交">
<input type="reset" value="重置" onClick="defaultfocus();">
<input type="button" value="返回" onClick="history.back();">
</form>

<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
