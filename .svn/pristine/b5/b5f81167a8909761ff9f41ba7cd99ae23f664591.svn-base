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

<h1>新建排班类型</h1>

<div id="head6"><img height="6" src="about:blank"></div>
<input  type ="button" name="newbulletin" value="新建排班类型" onClick="location='/jsp/admin/manage/Newrankclass.jsp?community=<%=community %>';">
<h1>已定义排班类型 </h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name=form1 METHOD=get  action="/jsp/admin/flow/EditFlow.jsp">
   <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr id="tableonetr">
    	 <td nowrap>编号</td>
         <td nowrap>排班类型说明</td>
         <td nowrap>第1次登记</td>
         <td nowrap>第2次登记</td>
         <td nowrap>第3次登记</td>
         <td nowrap>第4次登记</td>
         <td nowrap>第5次登记</td>
         <td nowrap>第6次登记</td>
         <td nowrap >操作</td>
   
       </tr>
 <%
	java.util.Enumeration enumer = RankClass.findByCommunity(teasession._strCommunity,"");
	int i = 1;
	while(enumer.hasMoreElements())
	{
		int id=((Integer)enumer.nextElement()).intValue();
		RankClass obj = RankClass.find(id);
 %>
       <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
       		<td nowrap><%=i %></td>
       		<td nowrap><%=obj.getRankClass() %></td>
       		<td nowrap><%=obj.getEnrol1()%><%if(obj.getDuty1().equals("1")){out.print("上班");}else{out.print("下班");}  %> </td>
       		<td nowrap><%=obj.getEnrol2()%><%if(obj.getDuty2().equals("1")){out.print("上班");}else{out.print("下班");}  %> </td>
       		<td nowrap><%=obj.getEnrol3()%><%if(obj.getDuty3().equals("1")){out.print("上班");}else{out.print("下班");}  %> </td>
       		<td nowrap><%=obj.getEnrol4()%><%if(obj.getDuty4().equals("1")){out.print("上班");}else{out.print("下班");}  %> </td>
       		<td nowrap><%if(obj.getEnrol5().length()>0 && obj.getEnrol5()!=null){out.print(obj.getEnrol5());if(obj.getDuty5().equals("1")){out.print("上班");}else{out.print("下班");}  } %></td>
       		<td nowrap><%if(obj.getEnrol6().length()>0 && obj.getEnrol6()!=null){out.print(obj.getEnrol6());if(obj.getDuty6().equals("1")){out.print("上班");}else{out.print("下班");}  } %></td>
       		<td nowrap><a href ="/jsp/admin/manage/Newrankclass.jsp?id=<%=id %>">编辑</a>  <a href ="/jsp/admin/manage/Disposal.jsp?id=<%=id %>&DELETE=DELETE" onClick="return window.confirm('您确定要删除此内容吗？');">删除</a></td>
       </tr>
<%
	i++;
      }//while
%>
</table>
<input type="button" value="返回上一页" onClick="history.back();">
</form>

</body>
</html>



