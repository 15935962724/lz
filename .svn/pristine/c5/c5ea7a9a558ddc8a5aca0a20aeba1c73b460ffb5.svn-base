<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter"%> 
<%@ page import="tea.resource.Resource"%>
<%@ page import="tea.entity.admin.*" %>
<%@ page import="tea.entity.member.*" %>
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
int apid =0;
if(teasession.getParameter("apid")!=null && teasession.getParameter("apid").length()>0)
{
	apid = Integer.parseInt(teasession.getParameter("apid"));
}

int vehicle=0,unit=0,mileage=0;
String chauffeur =null,man=null,destination=null,findingmanid=null,attemper=null,cause=null,remark=null;
Date times1 =null,times2=null;
Applys apobj = Applys.find(apid);
if(apid>0)
{
				vehicle = apobj.getVehicle();
				chauffeur = apobj.getChauffeur();
				man = apobj.getMan();
				unit = apobj.getUnit();
				times1 = apobj.getTimes1();
				times2 =apobj.getTimes2();
				destination =apobj.getDestination();
				mileage = apobj.getMileage();
				findingmanid = apobj.getFindingmanid();
				attemper =apobj.getAttemper();
				cause =apobj.getCause();
				remark = apobj.getRemark();
}

%>

<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script language="javascript" src="/jsp/admin/vehicle/load.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<script type="text/javascript">



  
function LoadWindow()
{
	  loc_x=document.body.scrollLeft+event.clientX-event.offsetX-100;
 	 loc_y=document.body.scrollTop+event.clientY-event.offsetY+140;
	var sFeatures = "edge:raised;scroll:0;status:0;help:0;resizable:1;dialogWidth:320px;dialogHeight:245px;dialogTop:"+loc_y+"px;dialogLeft:"+loc_x+"px";
	var url = "/jsp/admin/vehicle/NewDepartment.jsp";
	var aio ="";
	var arr =window.showModalDialog(url,aio,sFeatures);
	if(arr!=null){
			var arr1 = arr.split(",");
			document.all.unit1.value=arr1[0];
			document.all.unit.value = arr1[1];
	}	
	
}
function LoadWindow1()
{
		  loc_x=document.body.scrollLeft+event.clientX-event.offsetX-100;
 	 loc_y=document.body.scrollTop+event.clientY-event.offsetY+140;
	var sFeatures = "edge:raised;scroll:0;status:0;help:0;resizable:1;dialogWidth:320px;dialogHeight:245px;dialogTop:"+loc_y+"px;dialogLeft:"+loc_x+"px";
	var url = "/jsp/admin/vehicle/NewDepartment1.jsp";
	var aio ="";
	var arr =window.showModalDialog(url,aio,sFeatures);
	if(arr!=null){
		var arr1 = arr.split(",");
			document.all.findingmanid.value=arr1[0];
			document.all.findingman.value = arr1[1];
			
	}	
}


function showDetail()
{
	
	var vid = form1.vehicle.value;
	var a =vid.split("#"); 

	currentPos = "allalist";
	send_request("/jsp/admin/vehicle/apply2.jsp?vehicle="+a[0]);
	form1.chauffeur.value=a[1];
}

function sub()
{
	if(form1.vehicle.value==0)
	{
		alert("请选择车牌号!");
		return false;
	}
	if(form1.unit.value=="")
	{
		alert("请选择用车部门！");
		return false;
	}
	if(form1.timek.value=="")
	{
		alert("请选择开始时间");
		return false;
	}
	if(form1.timej.value=="")
	{
		alert("请选择结束时间");
		return false;
	}
	if(form1.findingman.value=="")
	{
		alert("请选择审批部门!");
		return false;
	}
	if(form1.attemper.value==0)
	{
		alert("请选择调度员!");
		return false;
	}
}
</script>
<body onLoad ="showDetail();">
<form name=form1 METHOD=post  action="/servlet/EditApplys" onsubmit="return sub(this);">
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<input type="hidden" name="apid" value="<%=apid %>">
<input type="hidden" name="member" value="<%=teasession._rv %>">
     <tr > 
     
   		<td nowrap>车牌号：</td>
   		<td nowrap>
	   		 <select name="vehicle"  onchange="showDetail();">
	   		 <option value="0">----------</option>
	         		<%
	         			java.util.Enumeration veh = Manage.findByCommunity(teasession._strCommunity,"");
	         			while(veh.hasMoreElements())
	         			{
	         				int vehid =((Integer)veh.nextElement()).intValue();
	         				Manage vehobj = Manage.find(vehid);
	         				out.print("<option value="+vehid+"#"+vehobj.getChauffeur());
	         				if(vehicle==vehid)
	         					out.print(" SELECTED");
	         				out.print(">"+vehobj.getVehicle()+"</option>");
	         			}
	         		 %>
	        </select> &nbsp;
	        <a href="/jsp/admin/vehicle/prearrange.jsp" target="_blank">预约情况</a>      
        </td>
        <td nowrap>司 机：</td>
        <td nowrap><input type="text" name ="chauffeur" value="" size="11" maxlength="100" readonly></td>
    </tr>
    <tr>
    	 <td nowrap > 用 车 人：</td>
    	 <td nowrap> <input type="text" name="man" value="<%if(man!=null)out.print(man); %>" size="20" maxlength="100" ></td>
    
	     <td nowrap> 用车部门：</td>
	     <%
	     		 AdminUnit obj_au=  AdminUnit.find(unit);
	      %>
	     <td nowrap> <input type="text" name="unit1" value="<%if(unit!=0)out.print(obj_au.getName()); %>" size=20 maxlength=100 readonly>
	     <input type="hidden" value="<%if(unit!=0)out.print(unit); %>" name="unit">
	     		<input type="button" value="选择" onClick="LoadWindow();"> 
	     </td>
     </tr>
     <tr>
     <%
     		String t = "";
     		int begintime =0;
     		  int begintime1 =0;
     		  
     		if(times1!=null)
     		{
     			t = times1.toString().substring(0,10);
     			begintime = Integer.parseInt(times1.toString().substring(11,13));
     			begintime1 = Integer.parseInt(times1.toString().substring(14,15));
     			
     		}
      %>
     	 <td nowrap> 起始时间：</td><td><input name="timek" size="7"  value="<%if(times1!=null)out.print(t); %>" readonly><A href="###"><img onclick="showCalendar('form1.timek');" src="/tea/image/public/Calendar2.gif" align="top"/></a>
     	  <select name="begintime"  >
  <%
  		
        for(int I=0;I<=23;I++)
        {
        	if(I<10)
        	{
  		
%>
          <option value="<%=I%>" <%if(I==begintime)out.print("SELECTED"); %>><%="0"+I%></option>
          <%}else{ %>
           <option value="<%=I%>" <%if(I==begintime)out.print("SELECTED"); %>><%=I%></option>
<%
			}
        }
%>
        </select>
        :
        <select name="begintime1" >
  <%
  

        for(int I=0;I<=59;I++)
        {

         if(I<10)
        	{
  %>
          <option value="<%=I%>" <%if(I==begintime1)out.print("SELECTED"); %>><%="0"+I%></option>
          <%}else{ %>
           <option value="<%=I%>" <%if(I==begintime1)out.print("SELECTED"); %>><%=I%></option>
<%
			}
        }
%>
        </select>
     	 
     	 
     	 </td>
     	  <%
	     	  	
	     		int begintime2 =0;
	     		  int begintime22 =0;
	     		  String t2="";
	     		if(times1!=null)
	     		{
	     			 t2 = times2.toString().substring(0,10);
	     			begintime2 = Integer.parseInt(times2.toString().substring(11,13));
	     			begintime22 = Integer.parseInt(times2.toString().substring(14,15));
	     			
	     		}
     	   %>
     	  <td nowrap> 结束时间：</td><td><input name="timej" size="7"  value="<%if(times2!=null)out.print(t2); %>" readonly><A href="###"><img onclick="showCalendar('form1.timej');" src="/tea/image/public/Calendar2.gif" align="top"/></a>
     	  <select name="begintime2"  >
  <%

        for(int I=0;I<=23;I++)
        {
        	if(I<10)
        	{
  		
%>
          <option value="<%=I%>" <%if(I==begintime2)out.print("SELECTED"); %>><%="0"+I%></option>
          <%}else{ %>
           <option value="<%=I%>" <%if(I==begintime2)out.print("SELECTED"); %>><%=I%></option>
<%
			}
        }
%>
        </select>
        :
        <select name="begintime22" >
  <%

        for(int I=0;I<=59;I++)
        {

         if(I<10)
        	{
  %>
          <option value="<%=I%>" <%if(I==begintime22)out.print("SELECTED"); %>><%="0"+I%></option>
          <%}else{ %>
           <option value="<%=I%>" <%if(I==begintime22)out.print("SELECTED"); %>><%=I%></option>
<%
			}
        }
%>
        </select>
     	  
     	  </td>
     </tr>
      <tr>
	      <td nowrap > 目 的 地：</td>
	      <td nowrap>
	        <input type="text" name="destination" value="<%if(destination!=null)out.print(destination); %>" size="20" maxlength="100" >
	      </td>
	      <td nowrap> 里　　程：</td>
	      <td nowrap>
	        <input type="text" name="mileage" value="<%if(mileage!=0)out.print(mileage); %>" size="10" maxlength="14"> (公里)
	      </td>
    </tr>
     <tr>
     	 <td nowrap> 部门审批人：</td>
     	
     	 <td nowrap> <input type="text" name="findingman" size="13"  value="<%if(findingmanid!=null && findingmanid.length()>0){tea.entity.member.Profile pf_objs=tea.entity.member.Profile.find(findingmanid);out.print(pf_objs.getLastName(1)+pf_objs.getFirstName(1)); }%>" readonly>&nbsp;<input type="button" value="指定"  onClick="LoadWindow1();"></td>
    	<input type="hidden" value="<%if(findingmanid!=null && findingmanid.length()>0)out.print(findingmanid); %>" name="findingmanid">
    	 <td nowrap > 调 度 员：</td>
     	 <td nowrap>
	        <select name="attemper" >
	        <option value="0">-------</option>
	        <%
	        	java.util.Enumeration atten = Attemper.findByCommunity(teasession._strCommunity,"");
	        	while(atten.hasMoreElements())
	        	{
	        		String m =((String)atten.nextElement()).toString();
	        		Attemper attobj = Attemper.find(m);
	        		String member[] = attobj.getNames().split(",");
	        		for(int i = 0;i<member.length;i++)
	        		{
	        			  tea.entity.member.Profile pf_obj=tea.entity.member.Profile.find(member[i]);
	        			  out.print("<option value="+member[i]);
	        			  if(attemper!=null)
	        			  {
	        			  	 if(attemper.equals(member[i]))
	        			  	out.print(" SELECTED");
	        			  }
	        			 
	        			  out.print(">"+pf_obj.getLastName(1)+pf_obj.getFirstName(1)+"</option>");
	        			  
	        		}
	        		
	        	}	
	         %>
	         
	        </select>  (注：负责审批)
      	 </td>
     </tr>
      <tr>
	      <td nowrap > 在线调度<br>人员：</td>
	      <td nowrap colspan="3">
	      <%

	      	java.util.Enumeration on = OnlineList.findByCommunity(teasession._strCommunity,"");
	      	while(on.hasMoreElements())
	      	{
				String sessionid = ((String)on.nextElement()).toString();
				OnlineList onobj = OnlineList.find(sessionid);
				if(onobj.getMember()!=null&&onobj.isOnline())
						out.print(onobj.getMember()+",");  	
	      	}	
	       %>
	      </td>
    </tr>  
     <tr>
	      <td nowrap > 事　　由：</td>
	      <td nowrap colspan="3"><textarea name="cause"  cols="74" rows="2"><%if(cause!=null)out.print(cause); %></textarea></td>
    </tr> 
    <tr>
      <td nowrap> 备　　注：</td>
      <td nowrap colspan="3">
        <textarea name="remark"  cols="74" rows="2"><%if(remark!=null)out.print(remark); %></textarea>
      </td>
    </tr>
   <tr>
      <td nowrap > 提醒调度员：</td>
      <td nowrap colspan="3">
    	  <input type="checkbox" name="checkbox1" id="" checked><label for="SMS_REMIND1">使用内部短信提醒</label>&nbsp;</td>
  </tr>
   <tr>
    	<td nowrap >通知申请人：</td>
    	<td nowrap colspan="3"><input type="checkbox" name="checkbox2" id="" checked><label for="SMS_REMIND">使用内部短信提醒</label>&nbsp;&nbsp;  </td>
  </tr>
  <tr class="TableControl">
      <td nowrap colspan="4" align="center">
        <input type="submit" value="保存">&nbsp;&nbsp;
        <input type="reset" value="重填">&nbsp;&nbsp;
       
      </td>
    </tr>
</table>
</FORM>
<table><tr><td id ="allalist"><img src=/tea/image/public/load.gif>正在加载...</td></tr></table>
</body>
</html>



