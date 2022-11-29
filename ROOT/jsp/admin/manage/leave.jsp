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
StringBuffer param=new StringBuffer("&community="+teasession._strCommunity);
StringBuffer sql=new StringBuffer(" and l.member = '"+teasession._rv+"' and l.type <> 3");

int leavetype =0;
if(request.getParameter("leavetype")!=null&&request.getParameter("leavetype").length()>0)
   leavetype = Integer.parseInt(request.getParameter("leavetype"));
if(leavetype!=0)
{

  sql.append(" AND l.leavetype="+leavetype);
  param.append("&leavetype="+leavetype);
}

int type =4;
if(request.getParameter("type")!=null&&request.getParameter("type").length()>0)
    type = Integer.parseInt(request.getParameter("type"));
if(type!=4)
{
  sql.append(" AND l.type="+type);
  param.append("&type="+type);
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



<h1>请假登记</h1>

<div id="head6"><img height="6" src="about:blank"></div>


　  <br />
<h2>查询</h2>
<form name=form1 METHOD=get  action="?">

  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td>请假类型<select name="leavetype">
      <%
         for(int i=0;i<Leavec.LEAVE_TYPE.length;i++)
         {
           out.print("<option value="+i);
           out.print(">"+Leavec.LEAVE_TYPE[i]);
           out.print("</option>");
         }
      %></select>
      </td>
        <td>状态<select name="type" >
             <option value="4">-------</option>
             <option value="0">领导尚未批示</option>
             <option value="1">领导已批准</option>
             <option value="-1">领导不批准</option>
             <option value="2">申请销假</option>
         </select></td>

            <td><input type="submit" value="查询"/></td>
    </tr>
  </table>
</FORM>
<form name=form1 METHOD=get  action="/jsp/admin/flow/EditFlow.jsp">
   <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr id="tableonetr">
    	 <td nowrap>请假原因</td>
         <td nowrap>请假类型</td>
         <td nowrap>请示领导</td>
         <td nowrap>开始日期</td>
         <td nowrap>结束日期</td>
         <td nowrap>状态</td>
         <td nowrap>操作</td>


       </tr>

      <%
      		java.util.Enumeration enumer = Leavec.findByCommunity(teasession._strCommunity,sql.toString());
        // out.println(sql.toString());
      		while(enumer.hasMoreElements())
      		{
      			int id = ((Integer)enumer.nextElement()).intValue();
      			Leavec obj = Leavec.find(id);
      			tea.entity.member.Profile probj = tea.entity.member.Profile.find(obj.getName());

       %>


       <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
       		<td nowrap><%=obj.getCause() %></td>
                <td nowrap><%=Leavec.LEAVE_TYPE[obj.getLeavetype()] %></td>
       		<td nowrap><%=probj.getLastName(teasession._nLanguage)+probj.getFirstName(teasession._nLanguage) %></td>
       		<td nowrap><%=obj.getTime_kToString() %></td>
       		<td nowrap><%=obj.getTime_jToString() %></td>
       		<td nowrap>
       			<%
       				if(obj.getType()==0){
       					out.print("领导尚未批示");
       				}
       				if(obj.getType()==1){
       					out.print("领导已批准");
       				}
       				if(obj.getType()==-1){
       					out.print("领导不批准");
       				}
       				if(obj.getType()==2)
       				{
       					out.print("申请销假");
       				}
       			 %>
       		</td>
       		<td nowrap>
       			<%
       				if(obj.getType()==0){
       					out.print("<a href =\"/jsp/admin/manage/Disposal.jsp?leaid="+id+"\">删除</a>");
       				}
       				if(obj.getType()==1){
       					out.print("<a href =\"/jsp/admin/manage/Disposal.jsp?type="+id+"\">申请销假</a>");
       				}
       				if(obj.getType()==-1){
       					out.print("<a href =\"/jsp/admin/manage/Disposal.jsp?leaid="+id+"\">删除</a>");
       				}
       				if(obj.getType()==2)
       				{
       					out.print("无");
       				}
       			 %>
       		</td>
       	</tr>
      <%
      		}
       %>

</table>

<input  type ="button" name="newbulletin" value="新建请假登记" onClick="location='/jsp/admin/manage/Newleave.jsp';">
<input  type ="button" name="newbulletin" value="请假历史记录" onClick="location='/jsp/admin/manage/anleave.jsp';">


</form>

</body>
</html>



