<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter" %>
<%@ page  import="tea.resource.Resource"  %>
<%@ page  import="tea.entity.admin.*" %>
<%@ page import="tea.ui.TeaSession" %>
<%@ page import ="java.util.Date" %>
<%@ page import="java.util.*" %>
<%@ page import="tea.entity.member.*" %>

<%
request.setCharacterEncoding("UTF-8");


TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String community=teasession._strCommunity;
String year = teasession.getParameter("year");
String month = teasession.getParameter("month");
String date = teasession.getParameter("date");


%>


<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT SRC="/tea/tea.js" type="text/javascript"></SCRIPT>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/image/ig/ig_iframe.js"></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<script type="">
  function f_open(y,m,d,aid)
  {
    window.open("/jsp/admin/flow/NewAffair.jsp?community=<%=teasession._strCommunity%>&year="+y+"&month="+m+"&date="+d+"&aid="+aid,"iFrame2");

  }
</script>
</head>
<body>
<br>
<!--h2>新建事务&nbsp;(<%=year %>年<%=month %>月<%=date %>日)</h2-->
<div id="head6"><img height="6" src="about:blank"></div>
<!--input  type ="button" name="newbulletin" value="新建事务" onClick="location='/jsp/admin/flow/NewAffair.jsp?community=<%=community %>&year=<%=year%>&month=<%=month%>&date=<%=date %>';"-->

<h2>管理日程安排 &nbsp;(<%=year %>年<%=month %>月<%=date %>日)</h2>
   <form name=form1 METHOD=get  action="/jsp/admin/flow/EditFlow.jsp">
   <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr id="tableonetr">
     <!--td nowrap="nowrap">序号</td-->
       <td nowrap>姓名</td>
     	<td nowrap>开始时间</td>
         <td nowrap>结束时间</td>
         <td nowrap>事务类型</td>
         <td nowrap>事务内容</td>
         <td nowrap>状态</td>

       </tr>
       <%
       String member = teasession._rv.toString();//当前用户

            AdminUsrRole au_obj=AdminUsrRole.find(teasession._strCommunity,member);
            // if(au_obj.isExists())
           // {

           	String Time ="";
       		if(Integer.parseInt(month)<10){
       				 Time = year+"-0"+month+"-"+date;
       		}
       		if(Integer.parseInt(date)<10){
              		Time = year+"-"+month+"-0"+date;
            }
            if(Integer.parseInt(month)<10 && Integer.parseInt(date)<10)
            {
            	Time = year+"-0"+month+"-0"+date;
            }else{
            	Time =year+"-"+month+"-"+date;;
            }

            	String  sql = " and l.member = '"+member+"'  and l.time >"+DbAdapter.cite(Time);

       		java.util.Enumeration e = DayOrder.findByCommunity(teasession._strCommunity,sql);


           // java.util.Enumeration teme = DayOrder.findByCommunity(teasession._strCommunity," and l.member="+DbAdapter.cite(member)+" and l.time ="+DbAdapter.cite(Time)+"");

           	if(!e.hasMoreElements())
       		{
       			out.print("<tr><td><font color=red><b>暂无日程安排</b></font></td></tr>");
       		}
                int index=1;
       		while(e.hasMoreElements()){
       		int id = ((Integer)e.nextElement()).intValue();
       		DayOrder obj = DayOrder.find(id);
            Profile probj = Profile.find(obj.getMember());


       		//String Time = year+"-"+month+"-"+date;
       		//out.print(Time+obj.getTime().toString().substring(0,10));

       		//if(Time.equals(obj.getTime().toString().substring(0,10)))
       		//{
       %>
    <tr >
    <!--td width="1"><%=index %></td-->
    <td nowrap="nowrap"><%=probj.getName(teasession._nLanguage)%></td>
     	 <td  nowrap="nowrap"><%
         out.print(obj.getTimeToString()+"　");
     	 	if(obj.getBegintime()<10){
     	 		out.print("0"+obj.getBegintime()+":");
     	 	}else
     	 	{
     	 		out.print(obj.getBegintime()+":");
     	 	}
     	 	if(obj.getBegintime1()<10){
     	 		out.print("0"+obj.getBegintime1());
     	 	}else
     	 	{
     	 		out.print(obj.getBegintime1());
     	 	}
     	 %></td>
         <td ><%
		if(obj.getEndtime()<10){
     	 		out.print("0"+obj.getEndtime()+":");
     	 	}else
     	 	{
     	 		out.print(obj.getEndtime()+":");
     	 	}
     	 	if(obj.getEndtime1()<10){
     	 		out.print("0"+obj.getEndtime1());
     	 	}else
     	 	{
     	 		out.print(obj.getEndtime1());
     	 	}
		%></td>
         <td ><%
	         	Worktype wor =Worktype.find(obj.getAffairtype());
	         	out.print(wor.getName(teasession._nLanguage));
          %></td>
         <td ><a href="/jsp/admin/flow/AffairContent.jsp?community=<%=community %>&year=<%=year%>&month=<%=month%>&date=<%=date %>&aid=<%=id %>"  target="_blank"><%=obj.getAffaircontent() %></a></td>
         <td >
         <%
     		 int end = 0,end1=0;
     		 if(obj.getEndtime()==0)
     		 {
     		 	 end =24;
     		 }else{
     			  end=obj.getEndtime();
     		 }
     		 if(obj.getEndtime1()==0)
     		 {
     		 	 end1 =24;
     		 }else{
     			  end1=obj.getEndtime1();
     		 }
     		 Date d = new Date();
     		  Calendar   thisMonth=Calendar.getInstance();
     		String y=String.valueOf(thisMonth.get(Calendar.YEAR));

	     	if(Integer.parseInt(year)>Integer.parseInt(y))
	     	{
	     		out.print("<font color='#0000AA'>未至</font>");
	     	}else if(Integer.parseInt(year)==Integer.parseInt(y))
	     	{
	     		if((Integer.parseInt(month))>(d.getMonth()+1))
	     		{
	     			out.print("<font color='#0000AA'>未至</font>");
	     		}
	     		if((Integer.parseInt(month))==(d.getMonth()+1))
	     		{
	     			if(Integer.parseInt(date)>d.getDate())
	     			{
	     				out.print("<font color='#0000AA'>未至</font>");
	     			}
	     			if(Integer.parseInt(date)==d.getDate())
	     			{
	     				if(end>d.getHours())
		     			{
		     				out.print("<font color='#0000AA'>未至</font>");
		     			}
						 if(end==d.getHours())
	     				{
		     				if(end1>d.getMinutes())
		     				{
		     					out.print("<font color='#0000AA'>未至</font>");
		     				}else
		     				{
		     					out.print("<font color='#FF0000'>过期</font>");
		     				}
	     				}
		     			if(end<d.getHours())
		     			{
		     				out.print("<font color='#FF0000'>过期</font>");
		     			}
	     			}
	     			if(Integer.parseInt(date)<d.getDate())
	     			{
	     				out.print("<font color='#FF0000'>过期</font>");
	     			}
	     		}
	     		if((Integer.parseInt(month)+1)<(d.getMonth()+1))
	     		{
	     			out.print("<font color='#FF0000'>过期</font>");
	     		}
	     	}else
	     	{
	     		out.print("<font color='#FF0000'>过期</font>");
	     	}

     	 %>
         </td>



    </tr>
 <%
 index++;
 }
  %>
</table>
</form>
<!--input  type ="button" name="newbulletin" value="返回" onClick="location='/jsp/admin/flow/DayOrder.jsp?community=<%=community %>'"-->

</body>
</HTML>




