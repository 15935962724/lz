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
	out.println("您没有登录，请登录后操作");
	return;
}
 
tea.entity.site.Community community=tea.entity.site.Community.find(teasession._strCommunity);
String nexturl = teasession.getParameter("nexturl"); 
String member = teasession.getParameter("member");
Profile p = Profile.find(member);

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/tea/Calendar.js" type="text/javascript"></script>
<script src="/tea/city.js"></script>
<script src="/jsp/user/Golfscript.js"></script>

<script type="text/javascript">

function f_sub()
{
	

	if(form1.member.value=='')
	{
		document.getElementById("member_id").innerHTML='用户名不能为空';
		form1.member.focus();
		return false;
	}else if(form1.member.value.indexOf("<")!=-1||form1.member.value.indexOf(">")!=-1)
	{
		document.getElementById("member_id").innerHTML='用户名中含有非法字符';
		form1.member.focus();
		return false;
	}
	
	if(form1.membername.value=='')
	{
		document.getElementById("membername_id").innerHTML='姓名不能为空';
		form1.membername.focus();
		return false;
		
	}
	document.getElementById("membername_id").innerHTML='';
	
	
	if(form1.EnterPassword.value.length<6 || form1.EnterPassword.value.length>18)
    {
       
        document.getElementById("EnterPassword_id").innerHTML='密码必须为6到18位之间';
        form1.EnterPassword.focus();
        return false;
    }
	document.getElementById("EnterPassword_id").innerHTML='';
  
    if(form1.ConfirmPassword.value!=form1.EnterPassword.value)
    { 
       document.getElementById("ConfirmPassword_id").innerHTML='两次密码输入不一致';
       form1.ConfirmPassword.focus();
       return false;
   }
    document.getElementById("ConfirmPassword_id").innerHTML='';
   
    

    if(form1.mobile.value=='')
    {
    	  document.getElementById("mobile_id").innerHTML='手机不能为空';
   	    form1.mobile.focus();
   	    return false;
    }else
    {
    	var str = form1.mobile.value;
      //  var reg=/^(((13[0-9]{1})|150|151|152|153|154|155|156|157|158|159)+\d{8})$/;
var reg=/^(((13[0-9]{1})|(18[0-9]{1})|150|151|152|153|154|155|156|157|158|159)+\d{8})$/;
      if(!reg.test(str)){
        	document.getElementById("mobile_id").innerHTML='手机格式不正确';
       	    form1.mobile.focus();
       	    return false;
        }
    }
    
    document.getElementById("mobile_id").innerHTML='';
    
    if(form1.birth.value=='')
    {
    	  document.getElementById("birth_id").innerHTML='生日不能为空';
   	    form1.birth.focus();
   	    return false;
    }
    
    document.getElementById("birth_id").innerHTML='';
    
    
	if(form1.city0.value=='')
	{
		document.getElementById("city_id").innerHTML='现工作地省份不能为空';
   	    form1.city0.focus();
   	    return false;
	}
	document.getElementById("city_id").innerHTML='';	
	if(form1.city1.value=='')
	{
		document.getElementById("city_id").innerHTML='现工作地市不能为空';
   	    form1.city1.focus();
   	    return false;
	}
	document.getElementById("city_id").innerHTML='';
	if(form1.address.value==''){
		
		document.getElementById("city_id").innerHTML='现工作地详细地址不能为空';
   	    form1.address.focus();
   	    return false;
	}
	
	document.getElementById("city_id").innerHTML='';
	

	form1.submit();

	 
	
}


function f_xp(igd,igdstrid,igdname,igdpingpai)
{

	 sendx("/jsp/admin/edn_ajax.jsp?act=ewmxp&wm="+igd+"&igdname="+igdname+"&igdpingpai="+igdpingpai,
			 function(data)
			 {
		 		if(data!=''&&data.length>1)
		 			{
		 			data = data.trim();
				 	document.getElementById(igdstrid).innerHTML=data;
		 			}
			 }
			 );	
}

function f_x()
{
	f_xp('<%=p.getXpinpai()%>','xxinghaoid','xxinghao','<%=p.getXxinghao()%>');
	
}



function f_source()
{
	if(form1.source.value==1)
	{
		//培训
		document.getElementById("trainid").style.display='';
		document.getElementById("tjmemberid").style.display='none';  
		document.getElementById("belsellid").style.display='none';   
	}else if(form1.source.value==2)
	{
		//履友推荐
		document.getElementById("trainid").style.display='none';
		document.getElementById("belsellid").style.display='none';   
		document.getElementById("tjmemberid").style.display=''; 
		
	}else if(form1.source.value==3)
	{
		//销售员推荐
		document.getElementById("belsellid").style.display='';  
		document.getElementById("trainid").style.display='none';
		document.getElementById("tjmemberid").style.display='none';  
	}else
	{
		document.getElementById("belsellid").style.display='none';  
		document.getElementById("trainid").style.display='none';
		document.getElementById("tjmemberid").style.display='none';  
	}
	
}
</script> 
</head>
  
<body onload="f_x();">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="<%=community.getJspBeforePath(teasession._nLanguage)%>" type="text/javascript"></SCRIPT>
<h1>俱乐部高级会员&nbsp;(<%=member %>)&nbsp;编辑</h1>

<form name="form1" method="POST" action="/servlet/EditMember" enctype="multipart/form-data">

<input type="hidden" name="nexturl" value="<%=nexturl%>">
<input type="hidden" name="act" value="EditGolfMmeber">
<input type="hidden"   name="member" value="<%=member %>">
<input type="hidden"   name="community" value="<%=teasession._strCommunity %>">
<input type="hidden"   name="code" value="<%=p.getCode() %>">

 <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
 
 <tr>
      <td align="right"><span id="btid">*</span>&nbsp;会员编号：</td>
      <td>
        <%=Entity.getNULL(p.getCode()) %>
      </td>
    </tr>
     <tr>
      <td align="right">E-mail：</td>
      <td>
       	<input type="text"    class="edit_input" name="email" value="<%=Entity.getNULL(p.getEmail()) %>">&nbsp;
     <!--   	邮箱是联系我们、订阅信息、找回密码的必要手段，请正确填写。如您还没有邮箱，请马上去<a herf="http://reg.email.163.com/mailregAll/reg0.jsp?from=163mail_right">注册</a>一个。 -->
      </td>
    </tr>
    
    <tr>
      <td align="right"><span id="btid">*</span>&nbsp;用户名：</td>
      <td>
        <%=Entity.getNULL(member) %>
      </td>
    </tr>
    
	<tr>
      <td align="right"><span id="btid">*</span>&nbsp;姓名：</td>
      <td>
        <input type="text"    class="edit_input" name="membername" value="<%=Entity.getNULL(p.getFirstName(teasession._nLanguage)) %>">&nbsp;<span id="membername_id"></span>
      </td>
    </tr>
    <tr>
      <td align="right"><span id="btid">*</span>&nbsp;性别：</td>
      <td>
       	<select name="sex">
       		<option value="1" <%if(!p.isSex()){out.println(" selected ");} %>>男</option>
       		<option value="0" <%if(p.isSex()){out.println(" selected ");} %>>女</option>
       	</select>
      </td>
    </tr>
    <tr>
      <td align="right"><span id="btid">*</span>&nbsp;密码：</td>
      <td>
       	<input type="password"   class="edit_input" name="EnterPassword" value="<%=p.getPassword() %>">&nbsp;<span id="EnterPassword_id"></span>
      </td>
    </tr>
     <tr>
      <td align="right"><span id="btid">*</span>&nbsp;确认密码：</td>
      <td>
       	<input type="password"    class="edit_input" name="ConfirmPassword" value="<%=p.getPassword() %>">&nbsp;<span id="ConfirmPassword_id"></span>
      </td>
    </tr>
   
    <tr>
      <td align="right"><span id="btid">*</span>&nbsp;手机：</td>
      <td>
       	<input type="text"    class="edit_input" name="mobile" value="<%=p.getMobile() %>">&nbsp;<span id="mobile_id"></span>
      </td>
    </tr>
    <tr>
      <td align="right"><span id="btid">*</span>&nbsp;生日：</td>
      <td>
        <input id="birth" name="birth" size="7"  value="<%if(p.getBirth()!=null)out.print(Entity.sdf.format(p.getBirth())); %>"  style="cursor:pointer" readonly="readonly" onclick="new Calendar().show('form1.birth');"> 
        <img style="margin-bottom:-8px;" style="cursor:pointer"  src="/tea/image/bbs_edit/table.gif"  style="cursor:pointer" onclick="new Calendar().show('form1.birth');" />
       &nbsp;<span id="birth_id"></span>
      </td>
    </tr>
       <tr>
      <td align="right"><span id="btid">*</span>&nbsp;现工作地：</td>
      <td>
       	<script>mt.city("city0","city1",null,'<%=p.getProvince(teasession._nLanguage) %>');</script>
     
    详细地址:<input type="text" name="address" value="<%=p.getAddress(teasession._nLanguage) %>" title="详细地址">&nbsp;<span id="city_id"></span>
      </td>
    </tr>
      <tr>
      <td></td>
      <td>
      	<input type="checkbox" name="xybcheck" id="xybcheck" value="1" <%if(p.getType()==1)out.println(" checked"); %> onclick="f_xybcheck();" >&nbsp;
      	用户的详细信息
      </td>
     
    </tr>
    
      <tr>
      <td></td>
      <td>
      <input type="checkbox" name="xybcheck2" id="xybcheck2" value="1" <%if("1".equals(p.getwoid2()))out.println(" checked"); %> onclick="f_xybcheck2();" >
      &nbsp;
      告知我们您的所属企业及相关信息，为以后的会员企业服务做数据准备.
      
      </td>
     
    </tr>
    
      <%if(teasession._rv!=null  && p.getMembertype()==2 && AdminUsrRole.find(teasession._strCommunity,teasession._rv.toString()).isExists() ) {%>
     <tr>
      <td></td>
      <td>
      <input type="radio" name="membertype" value="1">通过审核&nbsp;&nbsp;
      <input type="radio" name="membertype" value="3">未通过审核&nbsp;&nbsp;
      </td>
     
    </tr>
    <%} %>

  </table>


 <span id="welid"  <%if(p.getType()==0)out.println(" style=\"display:none\""); %>>
    
 <table border="0" cellpadding="0" cellspacing="0" id="tablecenter" >
 
   <tr>
   	<td align="right">从何得知时高尔夫俱尔部的？</td>
   	<td>
   		<select name="source" onchange="f_source();">
   			<option value="0">-选择-</option>
   			<%
   				for(int i=1;i<Profile.SOURCE_TYPE_golf.length;i++)
   				{
   					out.print("<option value="+i);
   					if(p.getSource()==i)
   					{
   						out.println(" selected ");
   					}
   					out.print(">"+Profile.SOURCE_TYPE_golf[i]);
   					out.print("</option>"); 
   				}
   			%>
   		</select>
   		&nbsp; 
   		<span id="trainid" <%if(p.getSource()==1){out.println(" style=\"display:''\" ");}else{out.print(" style=\"display:none\"");} %>>
   			哪次培训：<input type="text" name="trainname" value="<%=Entity.getNULL(p.getTraintime()) %>">&nbsp;
   			培训地点：<input type="text" name="trainaddress" value="<%=Entity.getNULL(p.getTrainaddress()) %>">&nbsp;
   			培训时间：<input type="text" name="traintime" value="<%=Entity.getNULL(p.getTraintime()) %>">
   		</span>
   		<span id="tjmemberid" <%if(p.getSource()==2){out.println(" style=\"display:''\" ");}else{out.print(" style=\"display:none\"");} %>>
   		推荐人会员编号或用户名：
 			<input type="text"    class="edit_input" name="tjmember" value="<%=Entity.getNULL(p.getTjmember()) %>"  onfocus="mt.f_tm(this)" onblur="mt.f_tm(this)" min='4' maxlength="20" alt="推荐人会员编号或用户名">
 			<span id="tjmember_info"></span>
      
 
   		</span>
   		<span id="belsellid" <%if(p.getSource()==3){out.println(" style=\"display:''\" ");}else{out.print(" style=\"display:none\"");} %>>
   			销售员姓名：<input type="text" name="belsell" value="<%=Entity.getNULL(p.getBelsell()) %>">
   		</span>
   	</td>  
   </tr> 
    
   
  
     <tr>
      <td align="right">民族：</td>
      <td>
        <input type="text"  maxlength=16  class="edit_input" name="zzracky" value="<%=Entity.getNULL(p.getZzracky()) %>">
      </td>
    </tr>
    
	<tr>
      <td align="right">固定电话：</td>
      <td>
        <input type="text"    class="edit_input" name="telephone" value="<%=Entity.getNULL(p.getTelephone(teasession._nLanguage)) %>
        ">
      </td>
    </tr>
     <tr>
      <td align="right">家庭所在地：</td>
      <td>
       	 	<script>mt.city("zzhkszd0","zzhkszd1",null,"<%=p.getZzhkszd(teasession._nLanguage) %>");</script>
     
    详细地址:<input type="text" name="paddress" value="<%=Entity.getNULL(p.getPAddress(teasession._nLanguage)) %>" title="详细地址">
      </td>
    </tr>
     <tr>
      <td align="right">现通讯地址：</td>
      <td>
       	<script>mt.city("state0","state1",null,"<%=p.getState(teasession._nLanguage) %>");</script>
     
    详细地址:<input type="text" name="organization" value="<%=Entity.getNULL(p.getOrganization(teasession._nLanguage)) %>" title="详细地址">
      </td>
    </tr>
     <tr>
      <td align="right">邮编：</td>
      <td>
       	<input type="text"    class="edit_input" name="zip" value="<%=Entity.getNULL(p.getZip(teasession._nLanguage)) %>">
      </td>
    </tr>
    
    <tr>
      <td align="right">QQ：</td>
      <td>
       	<input type="text"    class="edit_input" name="msn" value="<%=Entity.getNULL(p.getMsnID()) %>">
      </td>
    </tr>
 
      
       <tr>
      <td align="right">现使用球具：</td>
      <td>
 			<select name="xpinpai" onchange="f_xp(this.value,'xxinghaoid','xxinghao','0');">
 				<option value="0">品牌</option>
 				<%
 				java.util.Enumeration ec = WomenOptions.find(teasession._strCommunity, " and type= 0",0,Integer.MAX_VALUE);
 		        while(ec.hasMoreElements())
 		       {
 		            int wid = ((Integer)ec.nextElement()).intValue();
 		            WomenOptions obj = WomenOptions.find(wid);
 		            out.println("<option value="+wid);
 		            if(p.getXpinpai()==wid)
 		            { 
 		            	out.println(" selected ");
 		            }
 		            out.println(">"+obj.getWoname());
 		            out.print("</option>");
 		       }
 				%>
 			</select>
 			<span id="xxinghaoid">
	 			<select name="xxinghao">
	 				<option value="0">型号</option>
	 				
	 			</select>
 			</span>其他:
 			<input type="text"     name="xqita" value="<%=Entity.getNULL(p.getXqita()) %>">
      </td>
    </tr>
      
      
      
   
   <tr>
   		<td align="right">身高：</td>
   		<td>
   			<input type="text"    class="edit_input" name="memberheight" value="<%=Entity.getNULL(p.getMemberheight()) %>">
   		</td>
   </tr>
   <tr>
   		<td align="right">球龄：</td>
   		<td>
   			<input type="text"    class="edit_input" name="ballage" value="<%=Entity.getNULL(p.getBallage()) %>">
   		</td>
   </tr>
   <tr>
   		<td align="right">差点or平均成绩：</td>
   		<td>
   			<input type="text"    class="edit_input" name="almostscore" value="<%=Entity.getNULL(p.getAlmostscore()) %>">
   		</td>
   </tr>
    <tr>
   		<td align="right">喜欢的：</td>
   		<td>
   			<input type="text"    class="edit_input" name="likeitems" value="<%=Entity.getNULL(p.getLikeitems()) %>">&nbsp;(木，球道，铁木，铁，推)
   		</td>
   </tr>
     <tr>
   		<td align="right">手尺：</td>
   		<td>
   			<input type="text"    class="edit_input" name="handfoot" value="<%=Entity.getNULL(p.getHandfoot()) %>">
   		</td>
   </tr>
    <tr>
   		<td align="right">手碗到地面距离：</td>
   		<td>
   			<input type="text"    class="edit_input" name="gdistance" value="<%=Entity.getNULL(p.getGdistance()) %>">
   		</td>
   </tr>
   <tr>
   		<td align="right">用手：</td>
   		<td>
   			<input type="text"    class="edit_input" name="yhand" value="<%=Entity.getNULL(p.getYhand()) %>">
   		</td>
   </tr>
   <tr>
   		<td align="right">挥杆节奏：</td>
   		<td>
   			<input type="text"    class="edit_input" name="swingrhythm" value="<%=Entity.getNULL(p.getSwingrhythm()) %>">
   		</td>
   </tr>
        </table>
</span>



      
      
 <span id="welid2" style="display:none">
    
 <table border="0" cellpadding="0" cellspacing="0" id="tablecenter" >
  <tr>
   		<td align="right">企业名称：</td>
   		<td>
   			<input type="text"    class="edit_input" name="entername" value="<%=Entity.getNULL(p.getEntername()) %>"  maxlength="40" >
   		</td>
   </tr>
   <%
   	String epic = null;
   	long epiclen = 0;

   	if(p.getEnterpic()!=null && p.getEnterpic().length()>0)
   	{
   		epic = p.getEnterpic();
   		epiclen = new File(application.getRealPath(epic)).length();
   		     
   	}
   %>
   <tr>
   		<td align="right">企业LOGO或图片：</td>
   		<td>
   			<input type="file"    class="edit_input" name="enterpic" value="<%=Entity.getNULL(p.getEnterpic()) %>"  >&nbsp;
   			<%
   				if(epiclen>0)
   				{
   					out.print("<a href='"+epic+"' target='_blank'>"+epiclen + "字节</a>");
   			        out.print("<input id='checkbox' type='checkbox' name='clearpic' onclick='form1.enterpic.disabled=this.checked'>&nbsp;清空");
   			      
   				}
   			%>
   		</td>
   </tr>
   <tr>
   		<td align="right">企业网址：</td>
   		<td>
   			<input type="text"    class="edit_input" name="enterwebsite" value="<%=Entity.getNULL(p.getEnterwebsite()) %>"  maxlength="40" >
   		</td>
   </tr>
    <tr>
   		<td align="right">企业联系方式：</td>
   		<td>
   			<input type="text"    class="edit_input" name="entercontact" value="<%=Entity.getNULL(p.getEntercontact()) %>"  maxlength="40" >
   		</td>
   </tr>
   
    <tr>
   		<td align="right">企业地址：</td>
   		<td>
   			<input type="text"    class="edit_input" name="enteraddress" value="<%=Entity.getNULL(p.getEnteraddress()) %>"  maxlength="40" >
   		</td>
   </tr>
    <tr>
   		<td align="right">企业服务与产品：</td>
   		<td>
   			<input type="text"    class="edit_input" name="enterproduct" value="<%=Entity.getNULL(p.getEnterproduct()) %>"  maxlength="40" >
   		</td>
   </tr>
   
    <tr>
   		<td align="right">企业微博地址：</td>
   		<td>
   			<input type="text"    class="edit_input" name="enterweibo" value="<%=Entity.getNULL(p.getEnterweibo()) %>"  maxlength="40" >
   		</td>
   </tr>
    <tr>
   		<td align="right">个人微博地址：</td>
   		<td>
   			<input type="text" maxlength="40"    class="edit_input" name="personalweibo" value="<%=Entity.getNULL(p.getPersonalweibo()) %>">
   		</td> 
   </tr>
   <tr>
   		<td align="right">企业介绍：</td>
   		<td>
   			<textarea rows="3" cols="50" name="entertext" maxlength="900" ><%=Entity.getNULL(p.getEntertext()) %></textarea>
   		</td>
   </tr>
   
  
 </table>
 </span>
      

<br>
  <center>
  <%if(p.getMembertype()==2) {%>
  <INPUT TYPE=button ID="submit1" class="edit_button" VALUE="审核用户信息" onclick="f_sub();">&nbsp;
  <%}else{ %>
  <INPUT TYPE=button ID="submit1" class="edit_button" VALUE="提交用户信息" onclick="f_sub();">&nbsp;
  <%} %>
  <input type="button" name="reset" value="返回" onClick="window.open('<%=nexturl%>','_self');">
  
  
</center></form>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="<%=community.getJspAfterPath(teasession._nLanguage)%>" type="text/javascript"></SCRIPT>

</body>
</html>

