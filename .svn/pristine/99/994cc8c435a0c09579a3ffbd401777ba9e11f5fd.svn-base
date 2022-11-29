<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter"%> 
<%@ page import="tea.resource.Resource"%>
<%@ page import="tea.entity.admin.*" %>
<%@ page import="tea.ui.TeaSession" %>
<%@ page import="java.io.*" %>
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

<h1>上下班查询结果 [ 2007年5月24日 至 2007年5月24日 共 1 天 ]</h1>

<div id="head6"><img height="6" src="about:blank"></div>
      

　  <br />
   <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr id="tableonetr">
    	 <td nowrap>日期</td>
         <td nowrap>上班 (8:00:00)</td>
         <td nowrap>下班 (11:30:00)</td> 
          <td nowrap>上班 (13:00:00)</td>
           <td nowrap>下班 (18:00:00)</td>
            <td nowrap>上班 (18:00:00)</td>
           <td nowrap>下班 (22:00:00)</td>
       </tr>
       <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
       		<td nowrap>2007-05-24 （ 周 四 ）</td>
       		<td nowrap>08:34:11 迟到</td>
       		<td nowrap>08:35:54 </td>
       		<td nowrap>08:36:04 </td>
       		<td nowrap>08:36:08  </td>
       		<td nowrap></td>
       		<td nowrap></td>
       	</tr>
</table>
<div id="head6"><img height="6" src="about:blank"></div>
<input type="button" value="返回上一页" onClick="history.back();">

</body>
</html>



