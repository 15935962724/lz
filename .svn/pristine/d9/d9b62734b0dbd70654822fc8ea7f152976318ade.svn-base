<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter"%>
<%@page import="java.util.*"%>
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

String host=request.getParameter("host");



Resource r=new Resource();


String ip=null;
int port=80;
boolean isNew=(host==null||host.length()<1);
if(!isNew)
{
  EarthHost obj=EarthHost.find(host);
  ip=obj.getIp();
  //port=obj.getPort();
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
    form1.host.focus();
  }catch(e)
  {
    form1.ip.focus();
  }
}
</script>
</head>
<body onLoad="defaultfocus();">

<h1>虚似主机-创建/编辑</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br/>
<form name="form1" action="/servlet/EditEarth" method="post" onSubmit="return submitText(this.host, '<%=r.getString(teasession._nLanguage, "InvalidParameter")%>-主机')&&submitText(this.ip, '<%=r.getString(teasession._nLanguage, "InvalidParameter")%>-IP')">
<input type=hidden name="community" value="<%=teasession._strCommunity%>"/>
<input type=hidden name="nexturl" value="<%=nexturl%>"/>
<input type=hidden name="act"  value="editearthhost"/>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td>主机</td>
    <td nowrap>
    <%
    if(isNew)
    out.print("<input name=host size=40>");
    else
    out.print("<input type=hidden name=host value='"+host+"' >"+host);
    %>
    </td>
  </tr>
  <tr>
    <td>IP</td>
    <td nowrap>
  <select name="ip">
  <option>-------------------</option>
  <%
  Enumeration e=EarthIp.find("",0,Integer.MAX_VALUE);
  while(e.hasMoreElements())
  {
    String _ip=(String)e.nextElement();
    out.print("<option value="+_ip);
    if(_ip.equals(ip))
    out.print(" SELECTED ");
    out.print(">"+_ip);
  }
  %>
  </select>
    </td>
  </tr>
</table>
<input type="submit"  value="提交">
<input type="reset"  value="重置" onClick="defaultfocus();">
<input type="button" value="返回" onClick="history.back();">
</form>

<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>



