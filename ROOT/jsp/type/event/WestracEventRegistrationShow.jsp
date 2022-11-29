<%@page import="tea.entity.westrac.EventaccoMember"%>
<%@page import="tea.entity.util.Card"%>
<%@page import="tea.entity.westrac.Eventregistration"%>
<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.entity.node.Event"%>
<%@page import="tea.entity.node.Node"%>
<%@page import="tea.entity.admin.AdminRole"%>
<%@page import="tea.entity.admin.AdminUnit"%>
<%@page import="tea.entity.admin.AdminUsrRole"%>
<%@page import="java.net.URLEncoder"%> 
<%@ page import="tea.resource.Resource" %><%@ page import="tea.db.DbAdapter" %><%@ page import="tea.ui.TeaSession" %>
<%@page import="tea.entity.*"%><%@page import="tea.entity.volunteer.*" %><%@page import="tea.entity.member.*" %><%@page import="tea.resource.*" %><%@page import="java.io.*" %>
<%@page import="java.util.*"%>
<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);



if(teasession._rv==null)
{ 
	out.println("您还没有登录，请登录");
	response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
	return;
}
tea.entity.site.Community community=tea.entity.site.Community.find(teasession._strCommunity);
String nexturl = teasession.getParameter("nexturl"); 

Event eobj = Event.find(teasession._nNode,teasession._nLanguage);

int regid= 0;
if(teasession.getParameter("eid")!=null && teasession.getParameter("eid").length()>0)
{
	regid = Integer.parseInt(teasession.getParameter("eid"));	
}

Eventregistration regobj = Eventregistration.find(regid);
Profile pobj = Profile.find(regobj.getMember());

String mobile = Profile.find(teasession._rv.toString()).getMobile();
String email = Profile.find(teasession._rv.toString()).getEmail();
if(regobj.isExists())
{
	mobile = pobj.getMobile();
	email = pobj.getEmail();
}


%>
<html>
<head>
<base target="_ajax">
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/tea/Calendar.js" type="text/javascript"></script>
<script src="/tea/city2.js" type="text/javascript"></script>
<script type="text/javascript">
window.name='_ajax';


</script> 
</head>
 
<body topmargin="0" leftmargin="0" marginheight="0" marginwidth="0" scroll="yes">


<h1>报名会员的详细信息</h1>

<form name="form1" method="post" action="/servlet/EditEvent"  target="_ajax" >
<input type="hidden" name="node" value="<%=teasession._nNode%>">
<input type="hidden" name="nexturl" value="<%=nexturl%>">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>">

<input type="hidden" name="act" value="WestracEventRegistra">
<input type="hidden" name="regid" value="<%=regid %>">



 <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
 
    <tr>
      <td align="right">会员编号：</td>
      <td><%=pobj.getCode()%> </td>
    </tr>
    <tr>
      <td align="right">用户名：</td>
      <td><%=regobj.getMember() %> </td>
    </tr>
     <tr>
      <td align="right">手机号：</td>
      <td><%=Entity.getNULL(mobile) %></td>
    </tr>
    
   
    
  <tr>
      <td align="right">现工作地：</td>
      <td><%
      if(regobj.getCity()!=null && regobj.getCity().length()>0){
      	Card cobj = Card.find(Integer.parseInt(regobj.getCity()));
      	 out.print(cobj.toString());
      	 out.print(regobj.getAddress()+"&nbsp;");
      }
      %>
     
      </td>
    </tr>
    
    
    
    <tr id="accoid" <%if(eobj.getCatering()==1){out.print("  style=\"display:none\" ");} %>>
      <td align="right">是否有随从人员：</td>
      <td>
      <%if(regobj.getAcco()==0){out.println("是");} %>
      <%if(regobj.getAcco()==1){out.println("否");} %>
        
        	<span id="accoquid" <%if(eobj.getCatering()==1  || regobj.getAcco()==1){out.println(" style=\"display:none\"");} %>>
        	人数：<%=regobj.getAccoquantity() %></span>
        
      </td>
    </tr>
    
    
    
    <tr id="accoidshow" <%if(eobj.getCatering()==1 || regobj.getAcco()==1){out.println(" style=\"display:none\"  ");}%>>
      <td colspan="2" id="accotdidshow" align="center"> 
      
      				
      				<%
      				
      					Enumeration em =EventaccoMember.find(" and eregid = "+regid,0,Integer.MAX_VALUE );
      				for(int j=1;em.hasMoreElements();j++)
      				{
      					int eid = ((Integer)em.nextElement()).intValue();
      					EventaccoMember emobj = EventaccoMember.find(eid);
      				
      				%>
				  <table border="0" cellpadding="0" cellspacing="0" id="tablecentershow">
					  <tr><td colspan="2">随行人员<%=j%>&nbsp;</td></tr>
					   <tr>
					      <td >姓名：<%=Entity.getNULL(emobj.getAcconame()) %></td>
					       <td >性别：
								<%if(emobj.getSex()==0){out.print(" 男 ");} %>
								<%if(emobj.getSex()==1){out.print(" 女 ");} %>
							
						  </td>
					    </tr>
					    <tr id="SignFrame">
						     <td >关系：<%=Eventregistration.ACCOREL_TYPE[emobj.getAccorel()] %>
								  
					         </td>
					          <td >身份证号：<%=Entity.getNULL(emobj.getCadr()) %></td>
					    </tr>
				  </table>
  
  				<%} %>
  
		</td>
    </tr>
    
    
      
    <tr id="accoid" <%if(eobj.getCatering()==1){out.print("  style=\"display:none\" ");} %>>
      <td align="right">是否安排餐饮：</td>
      <td>
         <%if(regobj.getCatering()==0){out.println(" 是");} %>
         <%if(regobj.getCatering()==1){out.println(" 否");} %>
      </td>
    </tr>
    <tr id="accocaterid" <%if(eobj.getCatering()==1 || regobj.getCatering()==1){out.print("  style=\"display:none\" ");} %>>
      <td colspan="2" id="accotdidshow" align="center">
      
      
				  <table border="0" cellpadding="0" cellspacing="0" id="tablecentershow">
					
					   <tr>
					      <td align="right">特殊要求：<%=Entity.getNULL(regobj.getSpecials()) %></td>
					    </tr>
					    
				  </table>
  
  
  
		</td>
    </tr>
    
   
   
   <tr id="stayid1" <%if(eobj.getStay()==1 ){out.print("  style=\"display:none\" ");} %>>
      <td align="right">是否需要安排住宿：</td>
      <td>
       <%if( regobj.getStay()==0){out.print("是 ");} %>
       <%if(regobj.getStay()==1){out.print("否 ");} %> 
        	
        
      </td>
    </tr> 
    
     <tr  id="stayid2" <%if(eobj.getStay()==1  || regobj.getStay()==1 ){out.print("  style=\"display:none\" ");} %>>
      <td colspan="3" align="center">
      <table border="0" cellpadding="0" cellspacing="0" id="tablecenter" style="margin-bottom:10px;">
		    <tr>
			    <td align="right">房间数：<%=regobj.getRoomnumber() %></td>
			    <td>房间类型：<%=Eventregistration.ACCOROOM_TYPE[regobj.getAccoroom()] %>
		         </td>
			      
		    </tr>
		     
		     <tr>
			      <td  colspan="2" >其他要求：<%=Entity.getNULL(regobj.getAccoother()) %></td>
			     
		        
		    </tr>
		    
		    </table>
      	
      </td>
      
       
      </td>
    </tr>
    
    
    
     <tr id="shuttleid1" <%if(eobj.getShuttle()==1){out.print("  style=\"display:none\" ");} %>>
      <td align="right">是否需要安排接送：</td>
      <td><%if( regobj.getShuttle()==0){out.print("是");} %>
      <%if(regobj.getShuttle()==1){out.print("否");} %>
        
      </td>


    </tr>
    
    
     <tr  id="shuttleid2"   <%if(eobj.getShuttle()==1 || regobj.getShuttle()==1){out.print("  style=\"display:none\" ");} %>>
      <td colspan="3" align="center">
      <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
		
		      
		     <tr>
		     
			      <td align="right">交通工具： </td>
			      <td>
			      
			       <%=Eventregistration.TRANSPORT_TYPE[regobj.getTransport()]%>
			      
			    </td>
			      
		        
		    </tr>
		    
		    <tr>
			      <td align="right">去程&nbsp;车次：</td>
			      <td><%=Entity.getNULL(regobj.getGotrainnumber()) %></td>
			      
		         
			      
		    </tr>
		      <tr>
			     <td align="right">到达日期：</td>
			     <td><%if(regobj.getReachtime()!=null)out.println(Entity.sdf.format(regobj.getReachtime())); %>
			     到达时间：
       <%=Entity.getNULL(regobj.getReachtimedate()) %>
			       </td>
      
		        
		    </tr>
		    <tr>
			      <td align="right">返程&nbsp;车次：</td>
			      <td><%=Entity.getNULL(regobj.getReturnrainnumber()) %></td>
			      
		         
			      
		    </tr>
		      <tr>
			     <td align="right">到达日期：</td>
			     <td><%if(regobj.getReturntime()!=null)out.println(Entity.sdf.format(regobj.getReturntime()));%>
			     到达时间：
      <%=Entity.getNULL(regobj.getReturntimedate()) %>
       </td>
     
		        
		    </tr>
		    
		    </table>
      	
      </td>
      
       
      </td>
    </tr>
    
    
  

  </table>
  <br>
  <center>
 
  <input type="button" value="关闭"  onClick="javascript:window.close();">

</center></form>

</body>
</html>

