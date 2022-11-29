<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter"%> 
<%@ page import="tea.resource.Resource"%>
<%@ page import="tea.entity.admin.*" %>
<%@ page import="tea.ui.TeaSession" %>
<%@ page import="java.io.*" %>
<%@ page import="java.text.*" %>
<%@ page import="java.util.Date" %>
<%@ page  import="java.util.Calendar"%>
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
 

int  unit = Integer.parseInt(teasession.getParameter("unit"));
int arrclass = Integer.parseInt(teasession.getParameter("arrclass"));



RankClass raobj = RankClass.find(arrclass);//获得用户属于什么班
  
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

<h1>今日上下班查询结果</h1>

<div id="head6"><img height="6" src="about:blank"></div>
　  <br />
<form name=form1 METHOD=get  action="/jsp/admin/flow/EditFlow.jsp">
   <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr id="tableonetr">
    	 <td nowrap>部门</td>
    	 <td nowrap>姓名</td>
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
       		//得到的是 那个部门的 什么上班类型
       		String str = DutyClass.GetNowDate();
       		String sql ="";
       		
        		sql = " and days ='"+str+"'  ";
        	
        		//sql = " and days ='"+str+"' ";
        	
       		java.util.Enumeration en = DutyClass.findByCommunity(teasession._strCommunity,sql);
        	
        	while(en.hasMoreElements()){
        		int id = ((Integer)en.nextElement()).intValue();
        		DutyClass obj = DutyClass.find(id);//得到的是上班时的 登记信息
        		//AdminUnit auobj = AdminUnit.find(obj.getUnit());//得到的用户的部门名字
        		
        			AdminUsrRole adobj1 = AdminUsrRole.find(teasession._strCommunity,obj.getMember());
        			AdminUnit auobj = AdminUnit.find(adobj1.getUnit());
        			
        		 tea.entity.member.Profile pf_obj=tea.entity.member.Profile.find(obj.getMember());//得到的用户的姓名
        		 if(unit==adobj1.getUnit()){
        		
        %>
        <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
        	<td nowrap><%if(auobj.getName()!=null){out.print(auobj.getName());}else{out.print("无部门");} %></td>
        	<td nowrap><%=pf_obj.getLastName(1)+pf_obj.getFirstName(1) %></td>
        	<td nowrap>
        		<%
        		DateFormat ff = new SimpleDateFormat("HH:mm");
        		if(raobj.getEnrol1()!=null && raobj.getEnrol1().length()>0 && obj.getBinday1()!=null){
        			Date aa =  ff.parse(raobj.getEnrol1());//得到 排班规定的时间
        			Date bb = ff.parse(obj.getBinday1().toString().substring(10,16));
        			out.print(obj.getBinday1().toString().substring(10,16));//得到上班的时间
        			if(aa.compareTo(bb)==-1)//判断上班状态
        			{
        				out.print("<span id=cdid>迟到</span>");
        			}
        		}else
        		{
        			out.print("未登记");
        		}
        			
        		 %>
        	</td>
        	<td nowrap><%
        		if(raobj.getEnrol2()!=null && raobj.getEnrol2().length()>0 && obj.getBinday2()!=null){
        			Date a2 =  ff.parse(raobj.getEnrol2());//得到 排班规定的时间
        			Date b2 = ff.parse(obj.getBinday2().toString().substring(10,16));
        			out.print(obj.getBinday2().toString().substring(10,16));//得到上班的时间
        			if(a2.compareTo(b2)==1)//判断上班状态
        			{
        				out.print("<span id=ztid>早退</span>");
        			}
        		}else
        		{
        			out.print("未登记");
        		}
        	%>
        	</td>
        	<td nowrap><%
        		if(raobj.getEnrol3()!=null && raobj.getEnrol3().length()>0 && obj.getBinday3()!=null)
        		{
        			Date a3 = ff.parse(raobj.getEnrol3());
        			Date b3 = ff.parse(obj.getBinday3().toString().substring(10,16));
        			out.print(obj.getBinday3().toString().substring(10,16));
        			if(a3.compareTo(b3)==-1)
        			{
        				out.print("<span id=cdid>迟到</span>");
        			}
        		}else
        		{
        			out.print("未登记");
        		}
        	 %>
        	</td>
        	<td nowrap>
        		<%
        		if(raobj.getEnrol4()!=null && raobj.getEnrol4().length()>0 && obj.getBinday4()!=null)
        		{
        			Date a4 = ff.parse(raobj.getEnrol4());
        			Date b4 = ff.parse(obj.getBinday4().toString().substring(10,16));
        			out.print(obj.getBinday4().toString().substring(10,16));
        			if(a4.compareTo(b4)==1)
        			{
        				out.print("<span id=ztid>早退</span>");
        			}
        		}else
        		{
        			out.print("未登记");
        		}
        	 %>
        	</td>
        	
        	<%
        		if(raobj.getEnrol5()!=null & raobj.getEnrol5().length()>0)
        		{
        	 %>
        	<td nowrap>
        		<%
        			if(obj.getBinday5()!=null)
        			{
        				Date a5 = ff.parse(raobj.getEnrol5());
        				Date b5 = ff.parse(obj.getBinday5().toString().substring(10,16));
        				out.print(obj.getBinday5().toString().substring(10,16));
        				if(a5.compareTo(b5)==-1)
        				{
        					out.print("<span id=cdid>迟到</span>");
        				}
        			}else
        			{
        				out.print("未登记");
        			}
        		 %>
        	</td>
        	<%
        		}
        		if(raobj.getEnrol6()!=null && raobj.getEnrol6().length()>0)
        		{
        	 %>
        	<td nowrap>
        		<%
        			if(obj.getBinday6()!=null)
        			{
        				Date a6 = ff.parse(raobj.getEnrol6());
        				Date b6 = ff.parse(obj.getBinday6().toString().substring(10,16));
        				out.print(obj.getBinday6().toString().substring(10,16));
        				if(a6.compareTo(b6)==-1)
        				{
        					out.print("<span id=cdid>迟到</span>");
        				}
        			}else
        			{
        				out.print("未登记");
        			}
        		 %>
        	
        	</td>
        	<%
        		}
        	 %>
        </tr>
        <%
        	}
        	}
         %>

</table>
</form>
<br><center><input type="button" class="BigButton" value="返回" onclick="history.back();"></center><br>
</body>
</html>



