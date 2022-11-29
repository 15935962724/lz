<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter"%>
<%@page import="tea.resource.Resource"%>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.member.*" %>
<%@page import="tea.ui.TeaSession" %>
<%@page import="java.io.*" %>
<%@page import="java.text.*" %>
<%@page import="java.net.*" %>
<%@page import="java.util.*" %>
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

String time_s = teasession.getParameter("time_s");
String time_e = teasession.getParameter("time_e");

DateFormat format = new SimpleDateFormat("yy-MM-dd");
Date a = format.parse(time_s);
Date b = format.parse(time_e);
long c = b.getTime() - a.getTime();
long cc = (c/1000/60/60/24)+1;//两个日期相差的天数


// Calendar   cal=Calendar.getInstance();
// cal.setTime(format.parse("2007-5-29"));
// out.println((cal.get(Calendar.DAY_OF_WEEK)-1));//判断日期是星期几

Profile pf_obj=Profile.find(teasession._rv._strV);
RankClass raobj = RankClass.find(pf_obj.getRclass());//获得用户属于什么班
if(!raobj.isExists())
{
  response.sendRedirect("/jsp/info/Alert.jsp?info="+URLEncoder.encode("对不起,管理员还没有给你还没有设置'考勤排班类型'.","UTF-8"));
  return;
}

%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<body>

<h1>上下班查询结果 [ <%=time_s %> 至 <%=time_e %> 共 <%=cc %> 天 ]</h1>

<div id="head6"><img height="6" src="about:blank"></div>
　  <br />
<form name=form1 METHOD=get  action="/jsp/admin/flow/EditFlow.jsp">
   <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr id="tableonetr">
    	 <td nowrap>日期</td>
         <td nowrap>上班 (<%=raobj.getEnrol1() %>)</td>
         <td nowrap>下班 (<%=raobj.getEnrol2() %>)</td>
         <td nowrap>上班 (<%=raobj.getEnrol3() %>)</td>
          <td nowrap>下班 (<%=raobj.getEnrol4() %>)</td>
          <%
          		if(raobj.getEnrol5()!=null && raobj.getEnrol5().length()>0)
          		{
           %>
           <td nowrap>上班 (<%=raobj.getEnrol5() %>)</td>
           <%
           		}
           		if(raobj.getEnrol6()!=null && raobj.getEnrol6().length()>0)
          		{
            %>
            <td nowrap>下班 (<%=raobj.getEnrol6() %>)</td>
            <%
            	}
             %>
       </tr>
       <%
       		java.util.Enumeration en = DutyClass.findByCommunity(teasession._strCommunity," and member ='"+teasession._rv+"' and  '"+time_s+"'<=   days and  days <='"+time_e+"'");

       		while(en.hasMoreElements())
       		{
       			int reid = ((Integer)en.nextElement()).intValue();
       			DutyClass reobj = DutyClass.find(reid);
        %>
         <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
       		<td nowrap><%=DutyClass.sdf.format(reobj.getDays())%> （ 周 <% out.print(DutyClass.GetDay(DutyClass.sdf.format(reobj.getDays()).toString().substring(0,10)));	 %> ）</td>
       		<td nowrap>
       			<%
       			DateFormat ff = new SimpleDateFormat("HH:mm");
       			if(reobj.getBinday1()!=null && raobj.isExists()&& raobj.getEnrol1().length()>0)
       			{
	       				out.print(reobj.getBinday1().toString().subSequence(10,16));

					Date aa = ff.parse(raobj.getEnrol1());//规定的时间
					Date bb = ff.parse(reobj.getBinday1().toString().substring(10,16));	//当前时间
				//out.print(a+"----"+b);
					if(aa.compareTo(bb)==-1)
					{
							out.print("迟到");
					}
				}else
				{
					out.print("未登记");
				}
       			 %>

       		</td>
       		<td nowrap>
       			<%
       				if(reobj.getBinday2()!=null && raobj.isExists()&& raobj.getEnrol2().length()>0){
       					out.print(reobj.getBinday2().toString().substring(10,16));
       					Date aa2 =ff.parse(raobj.getEnrol2());
       					Date bb2 = ff.parse(reobj.getBinday2().toString().substring(10,16));
       					if(aa2.compareTo(bb2)==1)
				    	{
				    		out.print("早退");
				    	}
       				}else
       				{out.print("未登记");}
       			 %>
       		</td>
       		<td nowrap>
					<%
       				if(reobj.getBinday3()!=null && raobj.isExists()&&raobj.getEnrol3().length()>0){
       					out.print(reobj.getBinday3().toString().substring(10,16));
       					Date aa3 =ff.parse(raobj.getEnrol3());
       					Date bb3 = ff.parse(reobj.getBinday3().toString().substring(10,16));
       					if(aa3.compareTo(bb3)==-1)
				    	{
				    		out.print("迟到");
				    	}
       				}else
       				{out.print("未登记");}
       			 %>
			</td>
       		<td nowrap><%
       				if(reobj.getBinday4()!=null &&  raobj.isExists()&& raobj.getEnrol4().length()>0){
       					out.print(reobj.getBinday4().toString().substring(10,16));
       					Date aa4 =ff.parse(raobj.getEnrol4());
       					Date bb4 = ff.parse(reobj.getBinday4().toString().substring(10,16));
       					if(aa4.compareTo(bb4)==1)
				    	{
				    		out.print("早退");
				    	}
       				}else
       				{out.print("未登记");}
       			 %></td>
       		<%
       		if(raobj.getEnrol5()!=null &&  raobj.isExists()&& raobj.getEnrol5().length()>0)
          		{
          	 %>
       		<td nowrap><%
					if(reobj.getBinday5()!=null && raobj.getEnrol5().length()>0){
       					out.print(reobj.getBinday5().toString().substring(10,16));
       					Date aa5 =ff.parse(raobj.getEnrol5());
       					Date bb5 = ff.parse(reobj.getBinday5().toString().substring(10,16));
       					if(aa5.compareTo(bb5)==-1)
				    	{
				    		out.print("迟到");
				    	}
       				}else
       				{out.print("未登记");}
       		%>
			</td>
       		<%
       			}
       			if(raobj.getEnrol6()!=null &&  raobj.isExists()&& raobj.getEnrol6().length()>0)
          		{
       		 %>
       		<td nowrap>
					<%
						if(reobj.getBinday6()!=null && raobj.getEnrol6().length()>0){
       					out.print(reobj.getBinday6().toString().substring(10,16));
       					Date aa6 =ff.parse(raobj.getEnrol6());
       					Date bb6 = ff.parse(reobj.getBinday6().toString().substring(10,16));
       					if(aa6.compareTo(bb6)==1)
				    	{
				    		out.print("早退");
				    	}
       				}else
       				{out.print("未登记");}
					 %>
			</td>
       		<%
       			}
       		 %>
       	</tr>
       	<%
       		}
       	 %>

</table>
</form>
<br><center><input type="button" class="BigButton" value="返回" onclick="history.back();"></center><br>
</body>
</html>



