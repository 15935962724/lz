<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter"%>
<%@ page import="tea.resource.Resource"%>
<%@ page import="tea.entity.admin.*" %>
<%@ page import="tea.ui.TeaSession" %>
<%@ page import="java.io.*" %>
<%@ page import="java.text.*" %>
<%@ page import="java.util.Date" %>
<%@ page  import="java.util.Calendar"%><%@page import="java.net.URLEncoder"%>

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

String timek = teasession.getParameter("timek");
String timej = teasession.getParameter("timej");



DateFormat format = new SimpleDateFormat("yy-MM-dd");
			Date a = format.parse(timek);
			Date b = format.parse(timej);
			 long c = b.getTime() - a.getTime();
			 long cc = (c/1000/60/60/24)+1;//两个日期相差的天数




//获得用户属于什么班

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
<%

 String member = teasession._rv.toString();//当前用户

            AdminUsrRole au_obj=AdminUsrRole.find(teasession._strCommunity,member);
            if(au_obj.isExists())
            {

            	AdminUnit unobj = AdminUnit.find(au_obj.getUnit());
            	String ustr = unobj.getName();

            	//if(au_obj.getUnit()==0 ){
            		//ustr = "无部门";
            	//}
            	//if( au_obj.getClasses()==2)
            	//{
            		//ustr="全体";
            	//}
            	//if(au_obj.getUnit()!=0 && au_obj.getClasses()!=2 ) //&& au_obj.getClasses()==1 )
            	//{
            	//	ustr = unobj.getName();
            	//}
 %>


<font color="#336699"><b>查询从 <%=timek %> 至 <%=timej %> 共</b></font><font color="red"> <%=cc %></font><font color="#336699"><b> 天的考勤记录，结果如下 </b></font>
<h1>上下班(<%=ustr %>)</h1>

<div id="head6"><img height="6" src="about:blank"></div>
　  <br />
<form name=form1 METHOD=get  action="/jsp/admin/flow/EditFlow.jsp">
   <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr id="tableonetr">
    	 <td nowrap>部门</td>
    	 <td nowrap>姓名</td>
         <td nowrap>上班迟到（次数） </td>
         <td nowrap>上班未登记（次数）</td>
         <td nowrap>下班早退（次数）</td>
          <td nowrap>下班未登记（次数）</td>

   			<td nowrap>操作</td>
       </tr>
       <%
       		//得到的是 那个部门的 什么上班类型
       		String str = DutyClass.GetNowDate();
       		String sql ="";
       		//if(au_obj.getClasses()==2)
        	//{
        		sql = " and '"+timek+"' <= days and days <= '"+timej+"'" ;
        	//}
        	//else
        	//{
        		//sql = " and '"+timek+"' <= days and days <= '"+timej+"' and unit="+au_obj.getUnit()+" ";

        	//}

        	java.util.Enumeration en = DutyClass.findBy(teasession._strCommunity,sql);
        	while(en.hasMoreElements()){
        		String usermember = ((String)en.nextElement()).toString();//用户的名字


        		 tea.entity.member.Profile pf_obj=tea.entity.member.Profile.find(usermember);//得到的用户的姓名
        		RankClass raobj = RankClass.find(pf_obj.getRclass());

		            AdminUsrRole aobj=AdminUsrRole.find(teasession._strCommunity,usermember);

		           //  if(aobj.isExists())
		            {
		            	AdminUnit auobj = AdminUnit.find(aobj.getUnit());

		            	//if(au_obj.getUnit()==aobj.getUnit()){


        %>
        <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
        	<td nowrap><%if(auobj.getName()!=null){out.print(auobj.getName());}else{out.print("无部门");} %> </td>
        	<td nowrap><%=pf_obj.getLastName(1)+pf_obj.getFirstName(1) %></td>
        	<td nowrap>
			<%
        		int aaa1 = DutyClass.getCou(teasession._strCommunity,usermember,pf_obj.getRclass(),raobj.getEnrol3(),raobj.getEnrol5(),13,"  and '"+timek+"' <= days and  days <='"+timej+"' ");
        	 	out.print(aaa1);
        	 %>
        	</td>
        	<td nowrap>
        	<%
        		int aaa2 = DutyClass.getCou(teasession._strCommunity,usermember,pf_obj.getRclass(),raobj.getEnrol3(),raobj.getEnrol5(),0,"  and '"+timek+"' <= days and  days <='"+timej+"' ");
        	 	out.print(aaa2);
        	 %>
        	</td>
        	<td nowrap>
        	<%

        		int aaa3 = DutyClass.getCou(teasession._strCommunity,usermember,pf_obj.getRclass(),raobj.getEnrol4(),raobj.getEnrol6(),246,"  and '"+timek+"' <= days and  days <='"+timej+"' ");
        	 	out.print(aaa3);
        	 %>
        	</td>
        	<td nowrap>
        		<%
        		int aaa4 = DutyClass.getCou(teasession._strCommunity,usermember,pf_obj.getRclass(),raobj.getEnrol4(),raobj.getEnrol6(),4,"  and '"+timek+"' <= days and  days <='"+timej+"' ");
        	 	out.print(aaa4);
        	 %>
        	</td>
        	<td nowrap><a href = "/jsp/admin/manage/user_duty.jsp?timek=<%=timek %>&timej=<%=timej %>&mem=<%=URLEncoder.encode(usermember,"UTF-8")%>">详细信息</a></td>

        </tr>
       <%
       			//	}
      		} 

       }
       %>

</table>
</form>

<div id="head6"><img height="6" src="about:blank"></div>
<h1> 请假人员 （ <%=ustr%> ）</h1>
 <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr id="tableonetr">
    	 <td nowrap>部门</td>
         <td nowrap> 姓名</td>
         <td nowrap>请假原因</td>
         <td nowrap> 开始日期</td>
         <td nowrap>结束日期</td>
         <td nowrap>状态</td>
         <td nowrap>操作</td>

       </tr>
       <%
       String asql ="";
      	//	 if(au_obj.getClasses()==2)
        	//{
        		asql = " and '"+timek+"' <= days and days <= '"+timej+"'   and type=2 or type=1" ;
        	//}
        	//if(au_obj.getClasses()==1)
        	//{
        	//	asql = " and '"+timek+"' <= days and days <= '"+timej+"' and unit="+au_obj.getUnit()+" ";
        	//}
        	//if(au_obj.getClasses()==0)
        	//{
        		//asql = " and '"+timek+"' <=days and days <= '"+timej+"' and unit = "+au_obj.getUnit()+" and member='"+member+"'";
        	//}
       		java.util.Enumeration leaen=Leavec.findByCommunity(teasession._strCommunity,asql);
        	if(!leaen.hasMoreElements()){out.print("<tr><td nowrap ><font color=red><b>无请假人员</b></font></td></tr>");}
        	while(leaen.hasMoreElements())
        	{
        		int leaid = ((Integer)leaen.nextElement()).intValue();
        			Leavec leaobj = Leavec.find(leaid);
        			  AdminUsrRole aobj=AdminUsrRole.find(teasession._strCommunity,leaobj.getMember());
        			AdminUnit adobj = AdminUnit.find(aobj.getUnit());
        			 tea.entity.member.Profile pf_obj=tea.entity.member.Profile.find(leaobj.getMember());//得到的用户的姓名
        		//if(au_obj.getUnit()==aobj.getUnit()){

        %>
       <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
       		<td nowrap><%if(adobj.getName()!=null){out.print(adobj.getName());}else{out.print("无部门");} %></td>
       		<td nowrap><%=pf_obj.getLastName(1)+pf_obj.getFirstName(1) %></td>
       		<td nowrap><%=leaobj.getCause() %></td>
       		<td nowrap><%=leaobj.sdf2.format(leaobj.getTime_k())%> </td>
       		<td nowrap><%=leaobj.sdf2.format(leaobj.getTime_j()) %></td>
       		<td nowrap><%
       				if(leaobj.getType()==1){out.print("现行");}
       				if(leaobj.getType()==2){out.print("已销假");}
			 %></td>
			 <td nowrap><a href = "/jsp/admin/manage/Disposal.jsp?LEAid=<%=leaid %>&timek=<%=timek %>&timej=<%=timej %>">删除</a></td>


       	</tr>
      <%
      		//}
      		}
       %>
</table>


<div id="head6"><img height="6" src="about:blank"></div>
<h1> 出差人员 （ <%=ustr%> ）</h1>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr id="tableonetr">
    	 <td nowrap>部门</td>
         <td nowrap> 姓名</td>
         <td nowrap>出差地点</td>
         <td nowrap> 开始日期</td>
         <td nowrap>结束日期</td>
         <td nowrap>状态</td>
         <td nowrap>操作</td>
       </tr>
       <%
        String esql ="";
      		 //if(au_obj.getClasses()==2)
        	//{
        		esql = " and '"+timek+"' <= times and times <= '"+timej+"'   " ;
        	//}
        	//if(au_obj.getClasses()==1)
        	//{
        		//esql = " and '"+timek+"' <= times and times <= '"+timej+"' and unit="+au_obj.getUnit()+" ";
        	//}
        	//if(au_obj.getClasses()==0)
        	//{
        		//esql = "and '"+timek+"' <=times and times <= '"+timej+"' and unit = "+au_obj.getUnit()+" and  member='"+member+"'";
        	//}
       		java.util.Enumeration eveen=Evection.findByCommunity(teasession._strCommunity,esql);

        	if(!eveen.hasMoreElements()){out.print("<tr><td nowrap ><font color=red><b>无出差人员</b></font></td></tr>");}
        	while(eveen.hasMoreElements())
        	{
        		int eveid = ((Integer)eveen.nextElement()).intValue();
        		Evection eveobj = Evection.find(eveid);


				    AdminUsrRole aobj=AdminUsrRole.find(teasession._strCommunity,eveobj.getMember());
        			AdminUnit eveadobj = AdminUnit.find(aobj.getUnit());
        			tea.entity.member.Profile pf_obj=tea.entity.member.Profile.find(eveobj.getMember());//得到的用户的姓名
        		//if(au_obj.getUnit()==aobj.getUnit()){


        %>

         <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
       		<td nowrap><%if(eveadobj.getName()!=null){out.print(eveadobj.getName());}else{out.print("无部门");} %></td>
       		<td nowrap><%=pf_obj.getLastName(1)+pf_obj.getFirstName(1) %></td>
       		<td nowrap><%=eveobj.getArea() %></td>
       		<td nowrap><%=eveobj.sdf.format(eveobj.getTime_k()) %> </td>
       		<td nowrap><%=eveobj.sdf.format(eveobj.getTime_j()) %></td>
       		<td nowrap>
       			<% 
       				if(eveobj.getType()==-1){out.print("在外");}
       				if(eveobj.getType()==1){out.print("返回");}
       			 %>
       		</td>
       		<td nowrap><a href = "/jsp/admin/manage/Disposal.jsp?EVEid=<%=eveid %>&timek=<%=timek %>&timej=<%=timej %>">删除</a></td>

       	</tr>
        <%}%>

</table>
<%
	}
 %>
<br><center><input type="button" class="BigButton" value="返回" onclick="location='/jsp/admin/manage/Inmanage.jsp'"></center><br>
</body>
</html>




