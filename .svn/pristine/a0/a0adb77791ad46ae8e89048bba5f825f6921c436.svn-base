<%@page import="tea.entity.westrac.EventaccoMember"%>
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
	out.println("<script>alert('您还没有登录，请登录');parent.ymPrompt.close();</script>");
	
	//response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
	
	return;
}

/* if(Profile.find(teasession._rv.toString()).getMembertype()==0)
{
	out.println("<script>alert('您是普通会员，请升级到高级会员...');parent.ymPrompt.close();</script>");	
	return;
} */
 
if(Profile.find(teasession._rv.toString()).getMembertype()==2)
{
	out.println("<script>alert('您的高级会员升级，管理员正在审核，请耐心等待...');parent.ymPrompt.close();</script>");	
	return;
}

tea.entity.site.Community community=tea.entity.site.Community.find(teasession._strCommunity);
String nexturl = teasession.getParameter("nexturl"); 

Event eobj = Event.find(teasession._nNode,teasession._nLanguage);

String member = teasession._rv.toString();
if(teasession.getParameter("member")!=null && teasession.getParameter("member").length()>0)
{
	member = teasession.getParameter("member");	
}



int regid= 0;
if(teasession.getParameter("eid")!=null && teasession.getParameter("eid").length()>0)
{
	regid = Integer.parseInt(teasession.getParameter("eid"));	
}
if(regid==0 &&Eventregistration.isBool(teasession._nNode, member))//不是修改的时候
{
	if(teasession._rv.toString().equals(member))
	{
		out.println("<script>alert('您已经报名，不能重复报名，请选择其他活动');parent.ymPrompt.close();</script>");
	}else
	{
		out.println("<script>alert('您已经报名，不能重复报名，请选择其他活动');window.close();</script>");
	}
	//response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
	
	return;
}



 
Eventregistration regobj = Eventregistration.find(regid);
Profile pobj = Profile.find(regobj.getMember());

String mobile = Profile.find(member).getMobile();

String city =String.valueOf( pobj.getProvince(teasession._nLanguage));
String address = pobj.getAddress(teasession._nLanguage);

if(regobj.isExists())
{
	mobile = regobj.getMobile();
	city = regobj.getCity();
	address=regobj.getAddress();
	
}


%>
<html>
<head>
<base target="_ajax">
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/tea/Calendar.js" type="text/javascript"></script>
<script src="/tea/city.js" type="text/javascript"></script>
<script type="text/javascript">
window.name='_ajax';
function f_sub()
{
	if(form1.mobile.value=='')
	{
		alert("请填写手机号.");
		form1.mobile.focus();
		return false;
	}else
	{
		var sPhonenumber = document.form1.mobile.value;
	     
	      var reg=/^(((13[0-9]{1})|(18[0-9]{1})|150|151|152|153|154|155|156|157|158|159)+\d{8})$/;
	      if(!reg.test(sPhonenumber)){
	         alert("您填写的手机号格式不正确，请重新填写.");
	        form1.mobile.focus();
	        return false;
	      } 
	}
	
	
	if(form1.city0.value=='')
	{
		alert("现通讯地址省份不能为空");
   	    form1.city0.focus();
   	    return false;
	}
	document.getElementById("city_id").innerHTML='';	
	if(form1.city1.value=='')
	{
		alert("现通讯地址市区不能为空");
   	    form1.city1.focus();
   	    return false;
	}
	document.getElementById("city_id").innerHTML='';
	if(form1.address.value==''){
		
		alert("现通讯地址详细地址不能为空");
   	    form1.address.focus();
   	    return false;
	}

	//选择性判断
	//随行人员
	if(f_che('acco')==0)//选择的是
	{
		
		
		if(form1.accoquantity.value==0)
		{
			alert('请输入随行人员人数');
			form1.accoquantity.focus();
			return false;
		}else
		{
			var ac = form1.accoquantity.value;
			for(i =1;i<=ac;i++)
			{
				var acname = document.getElementById('acconame'+i);
				// alert(acname.value);
				if(acname.value=='')
				{
					alert('请输入随行人员姓名');
					acname.focus();
					return false;
				}
				
				var accadr = document.getElementById('cadr'+i);
				if(accadr.value=='')
				{
					alert('请输入随行人员身份证');
					accadr.focus();
					return;
				}
				
				
			}
		}
	}
	
	//安排住处
	if(f_che('stay')==0)//选择的是
	{
		
		if(form1.roomnumber.value==0)
		{
			alert('请输入房间数');
			form1.roomnumber.focus();
			return false;
		}
	}
	
	
	if(f_che('shuttle')==0)//选择的是
	{
		
		if(form1.gotrainnumber.value==0)
		{
			alert('请输入去程 车次');
			form1.gotrainnumber.focus();
			return false;
		}
		if(form1.reachtime.value=='')
		{
			alert('请输入去程 到达日期');
			form1.reachtime.focus();
			return false;
		}
		if(form1.reachtimedate.value=='')
		{
			alert('请输入去程 到达时间');
			form1.reachtimedater.focus();
			return false;
		}
		if(form1.returnrainnumber.value=='')
		{
			alert('请输入返程 车次');
			form1.returnrainnumber.focus();
			return false;
		}
		if(form1.returntime.value=='')
		{
			alert('请输入返程 到达日期');
			form1.returntime.focus();
			return false;
		}
		if(form1.returntimedate.value=='')
		{
			alert('请输入返程 到达时间');
			form1.returntimedate.focus();
			return false;
		}
		
	}
	
	
	
	
	form1.submit();
	
}
function f_che(igdname)
{
	
	var ck = document.getElementsByName(''+igdname); 
	var flat = 0;
	
	for(var i = 0; i < ck.length; i++) {
		
		if(ck[i].checked) {
			flat = ck[i].value;
		}
	}
	return flat;
}

// 输入随行人员数字
function f_q()
{

	  var re = /^[0-9]+.?[0-9]*$/;   //判断字符串是否为数字     //判断正整数 /^[1-9]+[0-9]*]*$/  
	if(!re.test(form1.accoquantity.value))
	{
		document.getElementById('accqid').innerHTML='输入的必须是数字';
		form1.accoquantity.focus();
		form1.accoquantity.value=1;
		return false;
	}
	
	  if(form1.accoquantity.value>10)
		 {
		   document.getElementById('accqid').innerHTML='只能输入10';
			form1.accoquantity.focus();
			form1.accoquantity.value=1;
			//return false;
		 }
	  if(form1.countwemember.value>form1.accoquantity.value)
		  {
		 		//document.getElementById('accqid').innerHTML='您输入随行人员小于原有人员，请手动删除';
		 		alert('您输入随行人员小于原有人员，请手动删除');
				form1.accoquantity.focus();
				form1.accoquantity.value=form1.countwemember.value;
				return false;
		  }

	  

	    sendx("/jsp/admin/edn_ajax.jsp?act=werq&igd="+form1.accoquantity.value+"&regid="+form1.regid.value,
			 function(data)
			 {
	
			 // alert("4444->>>>."+data.length+"--"+data);
			 
			//document.write(data);
			   if(data!=''&&data.length>1)//如果有这个用户  则写入Cookie .trim()
			   { 
					//data = data.trim();
				   document.getElementById("accotdidshow").innerHTML=data;
			   }
			 }
			 );
	
} 

function f_subdelete(igd)
{
	 sendx("/jsp/admin/edn_ajax.jsp?act=werqdelete&igd="+igd+"&regid="+form1.regid.value,
			 function(data)
			 {
	
			 // alert("4444->>>>."+data.length+"--"+data);
			 
			//document.write(data);
			   if(data!=''&&data.length>1)//如果有这个用户  则写入Cookie .trim()
			   { 
					//data = data.trim();
					 window.location.reload();
				 
			   }
			 }
			 );
}

</script> 
</head>
 
<body topmargin="0" leftmargin="0" marginheight="0" marginwidth="0" scroll="yes">


<form name="form1" method="post" action="/servlet/EditEvent"  target="_ajax" >
<input type="hidden" name="node" value="<%=teasession._nNode%>">
<input type="hidden" name="nexturl" value="<%=nexturl%>">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>">
<input type="hidden" name="member" value="<%=member%>">
<input type="hidden" name="act" value="WestracEventRegistra">
<input type="hidden" name="regid" value="<%=regid %>">
<input type="hidden" name="show" value="<%=teasession.getParameter("show") %>">
<input type="hidden" name="countwemember" value="<%=EventaccoMember.Count(" and eregid="+regid) %>">

<input name='txtTRLastIndex' type='hidden' id='txtTRLastIndex' value="1" />


 <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
      <td colspan="10">请填写您联系方式</td>
      </td>
    </tr> 
     <tr>
      <td align="right"><span id="btid">*</span>&nbsp;手机号：</td>
      <td>
        <input type="text"  maxlength=11  class="edit_input" name="mobile" value="<%=Entity.getNULL(mobile) %>">
      </td>
    </tr>
    
   
    
	<tr>
      <td align="right"><span id="btid">*</span>&nbsp;现工作地：</td>
      <td>
       	<script>mt.city("city0","city1",null,'<%=city%>');</script>
     
    详细地址:<input type="text" name="address" value="<%=address %>" title="详细地址">&nbsp;<span id="city_id"></span>
      </td>
    </tr>
    
    
    
    
    <tr id="accoid" >
      <td align="right">是否有随从人员：</td>
      <td>
        <input type="radio"   class="edit_input" name="acco"  value="0" checked onClick="document.getElementById('accoquid').style.display='';document.getElementById('accoidshow').style.display='';"" >&nbsp;是&nbsp;&nbsp;
        <input type="radio"   class="edit_input" name="acco"  value="1" <%if(eobj.getCatering()==1  || regobj.getAcco()==1){out.println(" checked");} %>   onclick="document.getElementById('accoquid').style.display='none';document.getElementById('accoidshow').style.display='none';">&nbsp;否&nbsp;&nbsp;
        	<span id="accoquid" <%if(eobj.getCatering()==1  || regobj.getAcco()==1){out.println(" style=\"display:none\"");} %>>
        	人数：<input onKeyUp="f_q();" type=text name="accoquantity" size=4 value="<%=regobj.getAccoquantity() %>"></span><span id="accqid"></span>
        
      </td>
    </tr>
    
    
    <tr id="accoidshow" >
      <td colspan="2" id="accotdidshow" align="center">
      
      				
      				<%
      				 
      					Enumeration em =EventaccoMember.find(" and eregid = "+regid,0,Integer.MAX_VALUE );
      				for(int j=1;em.hasMoreElements();j++)
      				{
      					int eid = ((Integer)em.nextElement()).intValue();
      					EventaccoMember emobj = EventaccoMember.find(eid);
      				
      				%>
				  <table border="0" cellpadding="0" cellspacing="0" id="tablecentershow">
					  <tr><td colspan="2">随行人员<%=j%>&nbsp;<a href="###" onClick="f_subdelete('<%=eid%>');">删除</a></td></tr>
					   <tr>
					      <td >姓名：<input type="text" name="acconame<%=j %>" id="acconame<%=j %>" value="<%=Entity.getNULL(emobj.getAcconame()) %>"></td>
					       <td >性别：
								 <select name="sex<%=j %>" id="sex<%=j %>">
								        	<option value="0" <%if(emobj.getSex()==0){out.print(" selected ");} %>>男</option>
								        	<option value="1" <%if(emobj.getSex()==1){out.print(" selected ");} %>>女</option>
								 </select>
						  </td>
					    </tr>
					    <tr id="SignFrame">
						     <td >关系：
								  <select name="accorel<%=j %>"  id="accorel<%=j %>">
						         	<%
						         		for(int i=0;i<Eventregistration.ACCOREL_TYPE.length;i++)
						         		{
						         			out.println("<option value= "+i);
						         			if(emobj.getAccorel()==i)
						         			{
						         				out.println(" selected ");
						         			}
						         			out.println(">"+Eventregistration.ACCOREL_TYPE[i]);
						         			out.println("</option>");
						         		}
						         	%>
					        	 </select> 
					         </td>
					          <td >身份证号：<input type="text" name="cadr<%=j %>" id="cadr<%=j %>"  value="<%=Entity.getNULL(emobj.getCadr()) %>" maxlength="18"></td>
					    </tr>
				  </table>
  
  				<%} %>
  
		</td>
    </tr>
    
    
    
    <tr id="accoid" <%if(eobj.getCatering()==1){out.print("  style=\"display:none\" ");} %>>
      <td align="right">是否安排餐饮：</td>
      <td>
        <input type="radio"   class="edit_input" name="catering"  value="0" <%if(eobj.getCatering()==0 || regobj.getCatering()==0){out.println(" checked");} %>  onclick="document.getElementById('accocaterid').style.display='';">&nbsp;是&nbsp;&nbsp;
        <input type="radio"   class="edit_input" name="catering" value="1" <%if(eobj.getCatering()==1  || regobj.getCatering()==1){out.println(" checked");} %>   onclick="document.getElementById('accocaterid').style.display='none';">&nbsp;否&nbsp;&nbsp;
      </td>
    </tr>
    <tr id="accocaterid" <%if(eobj.getCatering()==1 || regobj.getCatering()==1){out.print("  style=\"display:none\" ");} %>>
      <td colspan="2" id="accotdidshow" align="center">
      
      
				  <table border="0" cellpadding="0" cellspacing="0" id="tablecentershow">
					
					   <tr>
					      <td >特殊要求：
					     <textarea rows="3" cols="60" name="specials"><%=Entity.getNULL(regobj.getSpecials()) %></textarea></td>
					    </tr>
					    
				  </table>
  
  
  
		</td>
    </tr>
    
    
    

   
   <tr id="stayid1" <%if(eobj.getStay()==1 ){out.print("  style=\"display:none\" ");} %>>
      <td align="right">是否需要安排住宿：</td>
      <td>
        <input type="radio"   class="edit_input" name="stay" value="0" <%if(eobj.getStay()==0 || regobj.getStay()==0){out.print("  checked");} %>   onclick="document.getElementById('stayid2').style.display='';">&nbsp;是&nbsp;&nbsp;
        <input type="radio"   class="edit_input" name="stay" value="1" <%if(eobj.getStay()==1 || regobj.getStay()==1){out.print("  checked ");} %>  onclick="document.getElementById('stayid2').style.display='none';">&nbsp;否&nbsp;&nbsp;
        	
        
      </td>
    </tr> 
    
     <tr  id="stayid2" <%if(eobj.getStay()==1  || regobj.getStay()==1 ){out.print("  style=\"display:none\" ");} %>>
      <td colspan="3" align="center">
      <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
		    <tr>
			    <td align="right">房间数：<input type="text" name="roomnumber" value="<%=regobj.getRoomnumber() %>" size=4></td>
			    <td>房间类型：<select name="accoroom">
		         <%
		         		for(int i=0;i<Eventregistration.ACCOROOM_TYPE.length;i++)
		         		{
		         			out.println("<option value= "+i);
		         			if(regobj.getAccoroom()==i)
		         			{
		         				out.println(" selected ");
		         			}
		         			out.println(">"+Eventregistration.ACCOROOM_TYPE[i]);
		         			out.println("</option>");
		         		}
		         	%>
		         </select></td>
			      
		    </tr>
		     
		     <tr>
			      <td  colspan="2" nowrap="nowrap">其他要求：<textarea rows="3"  cols="60" name="accoother"  maxlength="300"><%=Entity.getNULL(regobj.getAccoother()) %></textarea></td>
			     
		        
		    </tr>
		    
		    </table>
      	
      </td>
      
       
      </td>
    </tr>
    
    
     <tr id="shuttleid1" <%if(eobj.getShuttle()==1){out.print("  style=\"display:none\" ");} %>>
      <td align="right">是否需要安排接送：</td>
      <td>
        <input type="radio"   class="edit_input" name="shuttle" value="0"  <%if(eobj.getShuttle()==0 || regobj.getShuttle()==0){out.print("  checked");} %>   onclick="document.getElementById('shuttleid2').style.display='';">&nbsp;是&nbsp;&nbsp;
        <input type="radio"   class="edit_input" name="shuttle" value="1"   <%if(eobj.getShuttle()==1 || regobj.getShuttle()==1){out.print("  checked");} %>   onclick="document.getElementById('shuttleid2').style.display='none';">&nbsp;否&nbsp;&nbsp;

      </td>


    </tr>
    
    
     <tr  id="shuttleid2"   <%if(eobj.getShuttle()==1 || regobj.getShuttle()==1){out.print("  style=\"display:none\" ");} %>>
      <td colspan="3" align="center">
      <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
		
		      
		     <tr>
		     
			      <td align="right">交通工具：</td><td> <select name="transport">
			      
			       <%
		         		for(int i=0;i<Eventregistration.TRANSPORT_TYPE.length;i++)
		         		{
		         			out.println("<option value= "+i);
		         			if(regobj.getTransport()==i)
		         			{
		         				out.println(" selected ");
		         			}
		         			out.println(">"+Eventregistration.TRANSPORT_TYPE[i]);
		         			out.println("</option>");
		         		}
		         	%>
			      
			      </select></td>
			      
		        
		    </tr>
		    
		    <tr>
			      <td align="right">去程&nbsp;车次：</td>
			      <td><input type="text" name="gotrainnumber" value="<%=Entity.getNULL(regobj.getGotrainnumber()) %>"></td>
			      
		         
			      
		    </tr>
		      <tr>
			     <td align="right">到达日期：</td>
			     <td>
        <input id="reachtime" name="reachtime" size="7"  value="<%if(regobj.getReachtime()!=null)out.println(Entity.sdf.format(regobj.getReachtime())); %>"  style="cursor:pointer" readonly="readonly" onClick="new Calendar().show('form1.reachtime');"> 
        <img style="margin-bottom:-8px;" style="cursor:pointer"  src="/tea/image/bbs_edit/table.gif"  style="cursor:pointer" onclick="new Calendar().show('form1.reachtime');" />
      到达时间：<input type=text name="reachtimedate" value="<%=Entity.getNULL(regobj.getReachtimedate()) %>">
       </td>
       </tr>
      
		    <tr>
			      <td align="right">返程&nbsp;车次：</td>
			      <td><input type="text" name="returnrainnumber" value="<%=Entity.getNULL(regobj.getReturnrainnumber()) %>"></td>
			      
		         
			      
		    </tr>
		      <tr>
			     <td align="right">到达日期：</td>
			     <td>
			     
        <input id="returntime" name="returntime" size="7"  value="<%if(regobj.getReturntime()!=null)out.println(Entity.sdf.format(regobj.getReturntime()));%>"  style="cursor:pointer" readonly="readonly" onClick="new Calendar().show('form1.returntime');"> 
        <img style="margin-bottom:-8px;" style="cursor:pointer"  src="/tea/image/bbs_edit/table.gif"  style="cursor:pointer" onclick="new Calendar().show('form1.returntime');" />
       到达时间：  <input type=text name="returntimedate" value="<%=Entity.getNULL(regobj.getReturntimedate()) %>">
       </td>
       </tr>
      
		    
		    </table>
      	
      </td>
      
       
      </td>
    </tr>
    
    
   
 
  </table>
  <br>
  <center>
  <INPUT TYPE=button name="GoFinish" ID="edit_GoFinish" class="edit_button" VALUE="确定" onClick="f_sub();">&nbsp;
  <%if(regid>0){ %>
  <input type="button" name="reset" value="取消"   onClick="window.close();">
  <%}else if(teasession._rv.toString().equals(member))
	{ %>
  <input type="button" value="关闭"  onClick="parent.ymPrompt.close();">
  <%}else{ %>
  <input type="button" value="关闭"  onClick="window.close();">
  <%} %>
</center></form>

</body>
</html>

