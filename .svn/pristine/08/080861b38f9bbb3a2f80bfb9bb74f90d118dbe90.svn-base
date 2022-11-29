<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter"%><%@ page import="tea.resource.Resource"%><%@ page import="tea.entity.*" %><%@ page import="tea.entity.admin.*" %><%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

Http h=new Http(request);
int flow=h.getInt("flow");
int min=h.getInt("min");
String member=teasession._rv._strR;

%><html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>请选择处理笺</title>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<style type="text/css">
<!--
body
{
 margin: 10px;
 background-color:menu;
}
-->
</style>
<script>
</script>
</head>
<body>


<form name="form1" action="?" onsubmit="window.returnValue=form1.head.value;window.close();">

<table border='0' cellpadding='0' cellspacing='0' id="TableAnnex" >
  <tr><td class="TableAnnextitle">请选择:
<tr>
<td>
<select name="head" size='15' style='width:400px' mask="div" ondblclick="form1.onsubmit();">
<%
for(int i=min,j=0;j<10&&i<Flowbusiness.HEAD_TYPE.length;i++,j++)
{
  if(Flowbusiness.HEAD_TYPE[i].length()<1)continue;
  int rflow=0;
  if(i==5&&flow==6)
  rflow=11;//贵州桐梓河平行文、下行文发文流程
  else if(i==5&&flow==7)
  rflow=12;//贵州桐梓河上行文发文流程
  else if(i==6&&flow==6)
  rflow=13;//瓜州
  else if(i==6&&flow==7)
  rflow=14;//瓜州
  if(rflow>0&&Flowprocess.find(rflow,1).getMember().indexOf("/"+member+"/")==-1)continue;//贵州和瓜州 的权限判断
  out.print("<option value="+i+">"+Flowbusiness.HEAD_TYPE[i]+"</option>");
}
%>
</select>
</td>
<td valign='top' id="inputbutton">
  <input type="submit" value=" 确 定 "/>
  <input type="button" value=" 取 消 " onclick="window.close();"/>
</td>
</tr>
</table>
</form>
<script>
form1.head.selectedIndex=0;
</script>

</body>
</html>
