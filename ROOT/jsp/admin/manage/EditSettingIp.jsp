<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.entity.admin.*" %>
<%@ page import="tea.ui.TeaSession" %>
<%@ page import="java.io.*" %>
<%@ page import="tea.entity.member.*" %>
<%@ page import="tea.entity.node.*" %>
<%@ page import="tea.entity.RV" %>
<%
request.setCharacterEncoding("UTF-8");


response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}
String community=teasession._strCommunity;
String act = teasession.getParameter("act");

int ipid = 0;
if(teasession.getParameter("ipid")!=null && teasession.getParameter("ipid").length()>0)
{
  ipid = Integer.parseInt(teasession.getParameter("ipid"));
}

SettingIp sipobj = SettingIp.find(ipid);

if("Settingip".equals(act))
{
  String ip = teasession.getParameter("ip");
  String ip2 = teasession.getParameter("ip2");
  String ip3 = teasession.getParameter("ip3");
  if(ipid>0)
  {
    sipobj.set(ip,ip2,ip3);
  }else
  {
    SettingIp.create(ip,ip2,ip3,teasession._strCommunity);
  }
   out.print("<script>alert('ip记录设置成功！'); window.returnValue=1;window.close();</script>");
}
if("delete".equals(act))
{
  sipobj.delete();
  response.sendRedirect(teasession.getParameter("nexturl"));
  return;
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
</head>
<body>
<script type="">
window.name='tar';
function f_submit()
{
  if(form1.ip.value=='')
  {
     alert('请填写IP地址!');
     return false;
  }
}
</script>

<h1>设置IP</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br>
<h2>IP的格式可以是192.168.0.1固定格式也可以使192.168.0.*</h2>
<form action="?" name="form1" method="POST"  target="tar" onsubmit="return f_submit();">
<input type="hidden" name="act" value="Settingip"/>
<input type="hidden" name="ipid" value="<%=ipid%>"/>
<%
if("ip1".equals(act))
{
%>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr>
    	 <td nowrap>IP:</td>
         <td nowrap><input type="text" name="ip" value="<%if(sipobj.getIp()!=null)out.print(sipobj.getIp());%>"> </td>
       </tr>
</table>
<%}else if("ip2".equals(act)){ %>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr>
    	 <td nowrap>ip段:</td>
         <td nowrap>&nbsp;从&nbsp;<input type="text" name="ip2" value="<%if(sipobj.getIp3()!=null)out.print(sipobj.getIp3());%>"> &nbsp;到&nbsp;<input type="text" name="ip3" value="<%if(sipobj.getIp3()!=null)out.print(sipobj.getIp3());%>"></td>
       </tr>
</table>
<%} %>
<br />
<input type="submit" value="提交" >&nbsp;&nbsp;
<input type="button" value="关闭"  onClick="javascript:window.close();">
</form>


</body>
</html>
