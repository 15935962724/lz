<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter"%>
<%@ page import="tea.resource.Resource"%>
<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter"%>
<%@ page import="tea.resource.Resource"%>
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
String nexturl = request.getRequestURI()+"?"+request.getContextPath();

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
<script>
function f_ip(igd,igd2)
{
  var y ='edge:raised;scroll:0;status:0;help:0;resizable:0;dialogWidth:357px;dialogHeight:275 px;';
  var url = '/jsp/admin/manage/EditSettingIp.jsp?act='+igd+'&ipid='+igd2;
  var rs =  window.showModalDialog(url,self,y);
  if(rs==1)
  {
    window.open(location.href+"?t="+new Date().getTime(),window.name);
  }
}
</script>
<h1>设置ip</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br>
<form action="?" name="form1">
<input type="hidden" name="ipid"/>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr id="tableonetr">
    	 <td nowrap>IP</td>
         <td nowrap>操作</td>
       </tr>
       <%
       java.util.Enumeration e = SettingIp.find(teasession._strCommunity,"",0,Integer.MAX_VALUE);
       if(!e.hasMoreElements())
       {
         out.print("<tr><td colspan=10 align=center>暂无记录</td></tr>");
       }

       while(e.hasMoreElements()){

         int ipid = ((Integer)e.nextElement()).intValue();
         SettingIp sipobj = SettingIp.find(ipid);
       %>

       <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
         <td><a href="#" onclick="f_ip('ip1','<%=ipid%>');" title="点击这里可以修改固定ip" style="cursor:pointer"><%if(sipobj.getIp()!=null)out.print(sipobj.getIp()); %></a></td>
         <td><a href="/jsp/admin/manage/EditSettingIp.jsp?act=delete&ipid=<%=ipid%>&nexturl=<%=java.net.URLEncoder.encode(nexturl,"UTF-8")%>">删除</a></td>
       </tr>
       <%} %>
</table>

<br />
<input type="button" value="添加ip"  onclick="f_ip('ip1','0');">&nbsp;&nbsp;
<input type=button value="返回" onClick="javascript:history.back()">
<!--<input type="button" value="添加ip段"  onclick="f_ip('ip2','0');"/>-->
</form>

</body>
</html>








