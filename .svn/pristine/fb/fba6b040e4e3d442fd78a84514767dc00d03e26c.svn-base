<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter"%>
<%@ page import="tea.resource.Resource"%>
<%@ page import="tea.entity.admin.*" %>
<%@ page import="tea.ui.TeaSession" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
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

String member = teasession._rv.toString();//当前用户
AdminUsrRole au_obj=AdminUsrRole.find(teasession._strCommunity,member);

String ustr = "无部门";
if(au_obj.getUnit()>0)
{
	AdminUnit unobj = AdminUnit.find(au_obj.getUnit());
    ustr = unobj.getName();
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
function f_submit()
{
  if(form1.timek.value=='')
  {
    alert('起始时间不能为空！');
    return false;
  }
   if(form1.timej.value=='')
  {
    alert('截止时间不能为空！');
    return false;
  }
}
</script>
<h1>今日考勤 （ <%=ustr %> ）</h1>


<div id="head6"><img height="6" src="about:blank"></div>
<input type ="button" name="newbulletin" value="今日考勤情况" onClick="location='/jsp/admin/manage/Todaykq.jsp';">


<div id="head6"><img height="6" src="about:blank"></div>
　  <br />
<h1> 今日外出批示 （ <%=ustr %> ）</h1>
   <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr id="tableonetr">
    	 <td nowrap>部门</td>
         <td nowrap> 姓名</td>
         <td nowrap>外出原因</td>
         <td nowrap> 外出时间</td>
         <td nowrap>预计归来时间</td>
         <td nowrap>操作</td>
       </tr>
       <%
       		 java.util.Enumeration outen=Outs.findByCommunity(teasession._strCommunity," and type=2 and name='"+member+"' ");
        		if(!outen.hasMoreElements())
        		{
        		out.print("<tr><td nowrap ><font color=red><b>无外出人员!</b></font></td></tr>");
        		}else
        		while(outen.hasMoreElements())
                {
                  int outid = ((Integer)outen.nextElement()).intValue();
                  Outs outobj = Outs.find(outid);

                  //AdminUnit adobj = AdminUnit.find(outobj.getUn());
                  String m = "";
if(outobj.getMember()!=null && outobj.getMember().length()>0)
{
	m = outobj.getMember();	
}

                  AdminUsrRole adobj1 = AdminUsrRole.find(teasession._strCommunity,m);
                  AdminUnit adobj = AdminUnit.find(adobj1.getUnit());

                  tea.entity.member.Profile pf_obj=tea.entity.member.Profile.find(m);

        %>
       <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
       		<td nowrap><%if(adobj.getName()!=null){out.print(adobj.getName());}else{out.print("无部门");} %></td>
       		<td nowrap><%=pf_obj.getLastName(1)+pf_obj.getFirstName(1) %></td>
       		<td nowrap><%=outobj.getCause() %></td>
       		<td nowrap><%=outobj.getTime_w() %> </td>
       		<td nowrap><%=outobj.getTime_h() %></td>
       		<td nowrap><a href="/jsp/admin/manage/Disposal.jsp?outid=<%=outid %>&outtype=1" > 批准</a> <a href="/jsp/admin/manage/Disposal.jsp?outid=<%=outid %>&outtype=-1" >不批准</a> </td>
       	</tr>
       	<%
       		}
       	 %>
</table>

<div id="head6"><img height="6" src="about:blank"></div>
<h1> 请假批示 （ <%=ustr%> ）</h1>
 <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr id="tableonetr">
    	 <td nowrap>部门</td>
         <td nowrap> 姓名</td>
         <td nowrap>请假原因</td>
         <td nowrap> 开始日期</td>
         <td nowrap>结束日期</td>
         <td nowrap>申请类型</td>
         <td nowrap>操作</td>
       </tr>
       <%
       		java.util.Enumeration leaen=Leavec.findByCommunity(teasession._strCommunity," and (type=0 or type=2) and name='"+member+"' ");
        	if(!leaen.hasMoreElements()){out.print("<tr><td nowrap ><font color=red><b>无请假人员</b></font></td></tr>");}
        	while(leaen.hasMoreElements())
        	{
        		int leaid = ((Integer)leaen.nextElement()).intValue();
        		Leavec leaobj = Leavec.find(leaid);
        			//AdminUnit adobj = AdminUnit.find(leaobj.getUn());
        			
        			                 String m = "";
if(leaobj.getMember()!=null && leaobj.getMember().length()>0)
{
	m = leaobj.getMember();	
}
        			AdminUsrRole adobj1 = AdminUsrRole.find(teasession._strCommunity,m);
        			AdminUnit adobj = AdminUnit.find(adobj1.getUnit());
        			 tea.entity.member.Profile pf_obj=tea.entity.member.Profile.find(m);//得到的用户的姓名
        			//if(leaobj.getCause()!=null && leaobj.getCause().length()>0)
        			//{
 
        %>
       <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
       		<td nowrap><%if(adobj.getName()!=null){out.print(adobj.getName());}else{out.print("无部门");} %></td>
       		<td nowrap><%=pf_obj.getLastName(1)+pf_obj.getFirstName(1) %></td>
       		<td nowrap><%=leaobj.getCause() %></td> 
       		<td nowrap><%if(leaobj.getTime_j()!=null)out.print(leaobj.sdf2.format(leaobj.getTime_j()));%> </td>
       		<td nowrap><%if(leaobj.getTime_k()!=null)out.print(leaobj.sdf2.format(leaobj.getTime_k())); %></td>
       		<td nowrap>请假申请</td>
       		<td nowrap>
       		<%if(leaobj.getType()!=2){ %>
       		<a href ="/jsp/admin/manage/Disposal.jsp?leaids=<%=leaid %>&leatype=1">批准</a> <a href ="/jsp/admin/manage/Disposal.jsp?leaids=<%=leaid %>&leatype=-1">不批准</a> </td>
       	<%
       		}else{ 
       	 %>
       	 <a href ="/jsp/admin/manage/Disposal.jsp?leaids=<%=leaid %>&leatype=3">销假</a>
       	 <%} %>

       	</tr>
      <%
      	//	}
        	}
       %>
</table>



<div id="head6"><img height="6" src="about:blank"></div>
<h1>考勤记录查询与管理 （ <%=ustr%>  ）</h1>
<form name=form1 METHOD=post  action="/jsp/admin/manage/search.jsp" onclick="return f_submit();">
 <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr id="tableonetr">
     <td nowrap>起始日期:<input name="timek" size="7"  value="" readonly><A href="###"><img onclick="showCalendar('form1.timek');" src="/tea/image/public/Calendar2.gif" align="top"/></a>
         截至日期：<input name="timej" size="7"  value="" readonly><A href="###"><img onclick="showCalendar('form1.timej');" src="/tea/image/public/Calendar2.gif" align="top"/></a>
    <input type="submit" name="submit" value="考勤统计">
     </td>
       </tr>

</table>

</FORM>
<form name=form2 METHOD=post  action="/jsp/admin/manage/search2.jsp">
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">

       <tr id="tableonetr">

       		<td nowrap><input name="time_d" size="7"  value="" readonly><A href="###"><img onclick="showCalendar('form2.time_d');" src="/tea/image/public/Calendar2.gif" align="top"/>
       		<input type="submit" name="submit2" value="考勤明细" ></td>
       	</tr>

</table>
</FORM>

</body>
</html>


