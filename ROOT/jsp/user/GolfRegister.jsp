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


tea.entity.site.Community community=tea.entity.site.Community.find(teasession._strCommunity);
String nexturl = teasession.getParameter("nexturl"); 
//邀请码
String invite =  teasession.getParameter("invite");
if(invite!=null && invite.length()>0)
{
	if(!Entity.isNumeric(invite))
	{
		out.print("邀请码参数不对");
		return ;
	}else
	{
		Profile p = Profile.find(Integer.parseInt(invite));
		if(!p.isExisted(p.getMember()))
		{
			out.print("你邀请码不正确");
			return ;
		}
	}
}

%>
<style type="text/css">
.tip
{
background:url(/tea/mt/msg.gif) no-repeat; padding-left:20px;
border:1px solid #40B3FF;
background-position:0 -150px;
background-color:#E5F5FF;
}
.err
{
background:url(/tea/mt/msg.gif) no-repeat; padding-left:20px;
border:1px solid #FF8080;
background-color:#FFF2F2;
}
.ok
{
background:url(/tea/mt/msg.gif) no-repeat; padding-left:20px;
background-position:0 -250px;
}
</style>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/tea/Calendar.js" type="text/javascript"></script>
<script src="/tea/city.js"></script>
<script src="/jsp/user/Golfscript.js"></script> 

<script type="text/javascript">
document.getElementsByName("city0").alt='aaa';
document.getElementsByName("city1").alt='bbb';


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




</script> 
<form name="form1" method="POST" action="/servlet/EditMember" enctype="multipart/form-data"  target="_ajax" onSubmit="t=$('member_info').innerHTML;if(t.length>1&&t!='&amp;nbsp;'){mt.show(t);return false;};return mt.check(this);">
<input type="hidden" name="node" value="<%=teasession._nNode%>">
<input type="hidden" name="nexturl" value="<%=nexturl%>">
<input type="hidden" name="act" value="GolfRegister">
<input type="hidden" name="community" value="<%=teasession._strCommunity %>">
<input type="hidden" name="invite" value="<%=invite %>"> 

<div class="RegSelect"><input type="radio" name="type" value="0" onClick="window.open('/html/folder/32-1.htm','_self');">&nbsp;论坛会员&nbsp;&nbsp;&nbsp;&nbsp;
<input type="radio" name="type" value="1" checked="checked">&nbsp;高级会员</div>
 <table border="0" cellpadding="0" cellspacing="0" class="regtable" id="tablecenter">
     <tr>
      <td  colspan="2" class="Step1">
      1.填写基本信息&nbsp;&nbsp;&nbsp;&nbsp;
      2.验证信息&nbsp;&nbsp;&nbsp;&nbsp;
      3.注册成功
      </td>
     
    </tr>
    <tr>
      <td align="right" nowrap="nowrap" class="td01"><span id="btid">*</span>&nbsp;用户名：</td>
           <td><input name="member" onfocus="mt.f_m(this)" onblur="mt.f_m(this)" min='4' maxlength="20" alt="用户名"><span id="member_info"></span></td>
    
    </tr>
    <tr>
      <td align="right" nowrap="nowrap" class="td01">E-mail：</td>
      <td>
       	<input type="text"    class="edit_input" name="email" value=""><span class="tixing"><font>&nbsp;邮箱是联系我们、订阅信息、找回密码的必要手段，请正确填写。如您还没有邮箱，请马上<a href="http://reg.email.163.com/mailregAll/reg0.jsp?from=email163&regPage=163" target="_blank">注册</a>一个。</font></span>
      </td>
    </tr>
     
	<tr>
      <td align="right" nowrap="nowrap" class="td01"><span id="btid">*</span>&nbsp;姓名：</td>
      <td> 
        <input type="text"    name="membername" value=""  onfocus="mt.f_membername(this)" onblur="mt.f_membername(this)" alt="姓名"><span id="membername_info"></span>
      </td>
    </tr>
    <tr>
      <td align="right" nowrap="nowrap" class="td01"><span id="btid">*</span>&nbsp;性别：</td>
      <td>
       	<select name="sex">
       		<option value="1">男</option>
       		<option value="0">女</option>
       	</select>
      </td>
    </tr>
    <tr>
      <td align="right" nowrap="nowrap" class="td01"><span id="btid">*</span>&nbsp;密码：</td>
      <td>
       	<input type="password"    name="EnterPassword" onfocus="mt.f_p(this)" onblur="mt.f_p(this)" min='6' maxlength="20" alt="密码"><span id="EnterPassword_info"></span>
       	
       	   
      </td>
    </tr>
     <tr>
      <td align="right" nowrap="nowrap" class="td01"><span id="btid">*</span>&nbsp;确认密码：</td>
      <td>
       	<input type="password"    class="edit_input" name="ConfirmPassword" onfocus="mt.f_3(this)" onblur="mt.f_3(this)" alt="确认密码"><span id="ConfirmPassword_info"></span>
      </td>
    </tr>
   
    <tr>
      <td align="right" nowrap="nowrap" class="td01"><span id="btid">*</span>&nbsp;手机：</td>
      <td>
       	<input type="text"    class="edit_input" name="mobile" onfocus="mt.f_mobile(this)"  onblur="mt.f_mobile(this)" alt="手机号"><span id="mobile_info"></span>
      </td> 
    </tr>
    <tr>
      <td align="right" nowrap="nowrap" class="td01"><span id="btid">*</span>&nbsp;生日：</td>
      <td> 
 
        <input id="birth" name="birth" size="7"  value=""  style="cursor:pointer" readonly="readonly"  onfocus="mt.f_birth(this)"  onblur="mt.f_birth(this)" alt="生日"  onClick="new Calendar().show('form1.birth');">
        <img style="margin-bottom:-8px;" style="cursor:pointer"  src="/tea/image/bbs_edit/table.gif"  style="cursor:pointer" onclick="new Calendar().show('form1.birth');" />
       <span id="birth_info"></span>
      </td>
    </tr>
       <tr>
      <td align="right" nowrap="nowrap" class="td01"><span id="btid">*</span>&nbsp;现工作地：</td>
      <td>
       	<script>mt.city("city0","city1",null,"");</script>
     
    详细地址:<input type="text" name="address" value="" onfocus="mt.f_address(this)"   onblur="mt.f_address(this)" alt="现工作地详细地址" >
       <span id="city0_info"></span>
    <span id="address_info"></span>
      </td>
    </tr>
      <tr>
      <td colspan="2">
      	<input type="checkbox" name="xybcheck" id="xybcheck" value="1" onclick="f_xybcheck();" >
      	为了使我们能够提供更多更好的个性化服务，您可以填写完整的准确个人资料，我们将对您的资料严格保密，在任何情况下，我们都不会透露给任何第三方.
      	
      </td>
    </tr>
  
    
  </table>

  
 <span id="welid" style="display:none">
    
 <table border="0" cellpadding="0" cellspacing="0" id="tablecenter" >
   
   <tr>
   	<td align="right">从何得知时高尔夫俱尔部的？</td>
   	<td>
   	<%
   	if(invite!=null && invite.length()>0)
  	{
   		out.print(Profile.SOURCE_TYPE_golf[2]);
  	}else{
   	%>
   		<select name="source" onchange="f_source();">
   			<option value="0">-选择-</option>
   			<%
   				for(int i=1;i<Profile.SOURCE_TYPE_golf.length;i++)
   				{
   					out.print("<option value="+i);
   					
   					out.print(">"+Profile.SOURCE_TYPE_golf[i]);
   					out.print("</option>");  
   				}
   			%>
   		</select>
   		<%} %>
   		&nbsp; 
   		<span id="trainid" style="display:none"><br>
   			哪次培训：<input type="text" name="trainname"><br>
   			培训地点：<input type="text" name="trainaddress"><br>
   			培训时间：<input type="text" name="traintime">
   		</span>
   		<span id="tjmemberid"  <%if(invite!=null && invite.length()>0){out.print(" style=display:'' ");}else{out.print("  style=\"display:none\"  ");} %>><br>
   		推荐人会员编号或用户名：<% 
      	if(invite!=null && invite.length()>0)
      	{
      		Profile p = 	Profile.find(Integer.parseInt(invite));
      		out.println("会员编号："+p.getCode());
      		out.println("用户名："+p.getMember());
      	}else{
      %>
 			<input type="text"    class="edit_input" name="tjmember" value=""  onfocus="mt.f_tm(this)" onblur="mt.f_tm(this)" min='4' maxlength="20" alt="推荐人会员编号或用户名"><span id="tjmember_info"></span>
      
      <%} %>
   		</span>
   		<span id="belsellid" style="display:none"><br>
   			销售员姓名：<input type="text" name="belsell">
   		</span>
   	</td>  
   </tr> 
    
    
    <tr>
      <td align="right">民族：</td>
      <td>
        <input type="text"  maxlength=16  class="edit_input" name="zzracky" value="">
      </td>
    </tr>
    
	<tr>
      <td align="right">固定电话：</td>
      <td>
        <input type="text"    class="edit_input" name="telephone" value="">
      </td>
    </tr>
     <tr>
      <td align="right">家庭所在地：</td>
      <td>
       	 	<script>mt.city("zzhkszd0","zzhkszd1",null,"");</script>
     
    详细地址:<input type="text" name="paddress" value="" title="详细地址">
      </td>
    </tr>
     <tr>
      <td align="right">现通讯地址：</td>
      <td>
       	<script>mt.city("state0","state1",null,"");</script>
     
    详细地址:<input type="text" name="organization" value="" title="详细地址">
      </td>
    </tr>
     <tr>
      <td align="right">邮编：</td>
      <td>
       	<input type="text"    class="edit_input" name="zip" value="">
      </td>
    </tr>
     
    <tr>
      <td align="right">QQ：</td>
      <td>
       	<input type="text"    class="edit_input" name="msn" value="">
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
 			<input type="text"     name="xqita" value="">
      </td>
    </tr>
      
   
   <tr>
   		<td align="right">身高：</td>
   		<td>
   			<input type="text"    class="edit_input" name="memberheight" value="">
   		</td>
   </tr>
   <tr>
   		<td align="right">球龄：</td>
   		<td>
   			<input type="text"    class="edit_input" name="ballage" value="">
   		</td>
   </tr>
   <tr>
   		<td align="right">差点or平均成绩：</td>
   		<td>
   			<input type="text"    class="edit_input" name="almostscore" value="">
   		</td>
   </tr>
    <tr>
   		<td align="right">喜欢的：</td>
   		<td>
   			<input type="text"    class="edit_input" name="likeitems" value="">&nbsp;(木，球道，铁木，铁，推)
   		</td>
   </tr>
     <tr>
   		<td align="right">手尺：</td>
   		<td>
   			<input type="text"    class="edit_input" name="handfoot" value="">
   		</td>
   </tr>
    <tr>
   		<td align="right">手碗到地面距离：</td>
   		<td>
   			<input type="text"    class="edit_input" name="gdistance" value="">
   		</td>
   </tr>
   <tr>
   		<td align="right">用手：</td>
   		<td>
   			<input type="text"    class="edit_input" name="yhand" value="">
   		</td>
   </tr>
   <tr>
   		<td align="right">挥杆节奏：</td>
   		<td>
   			<input type="text"    class="edit_input" name="swingrhythm" value="">
   		</td>
   </tr>
   
   
  </table>
</span>
  <table border="0" cellpadding="0" cellspacing="0" class="regtable" id="tablecenter">
  <tr>
      <td colspan="2"><input type="checkbox" name="xybcheck2" id="xybcheck2" value="1" onclick="f_xybcheck2();" >
      	告知我们您的所属企业及相关信息，为以后的会员企业服务做数据</td>
</tr>
</table>
  
 <span id="welid2" style="display:none">
    
 <table border="0" cellpadding="0" cellspacing="0" id="tablecenter" >
  <tr>
   		<td align="right">企业名称：</td>
   		<td>
   			<input type="text"    class="edit_input" name="entername" value=""  maxlength="40" >
   		</td>
   </tr>
   
   <tr>
   		<td align="right">企业LOGO或图片：</td>
   		<td>
   			<input type="file"    class="edit_input" name="enterpic" value=""  >
   		</td>
   </tr>
   <tr>
   		<td align="right">企业网址：</td>
   		<td>
   			<input type="text"    class="edit_input" name="enterwebsite" value=""  maxlength="40" >
   		</td>
   </tr>
    <tr>
   		<td align="right">企业联系方式：</td>
   		<td>
   			<input type="text"    class="edit_input" name="entercontact" value=""  maxlength="40" >
   		</td>
   </tr>
   
    <tr>
   		<td align="right">企业地址：</td>
   		<td>
   			<input type="text"    class="edit_input" name="enteraddress" value=""  maxlength="40" >
   		</td>
   </tr>
    <tr>
   		<td align="right">企业服务与产品：</td>
   		<td>
   			<input type="text"    class="edit_input" name="enterproduct" value=""  maxlength="40" >
   		</td>
   </tr>
   
    <tr>
   		<td align="right">企业微博地址：</td>
   		<td>
   			<input type="text"    class="edit_input" name="enterweibo" value=""  maxlength="40" >
   		</td>
   </tr>
    <tr>
   		<td align="right">个人微博地址：</td>
   		<td>
   			<input type="text" maxlength="40"    class="edit_input" name="personalweibo" value="">
   		</td> 
   </tr>
   <tr>
   		<td align="right">企业介绍：</td>
   		<td>
   			<textarea rows="3" cols="50" name="entertext" maxlength="900" ></textarea>
   		</td>
   </tr>  
 </table>
 </span>
<table border="0" cellpadding="0" cellspacing="0" class="regtable" id="tablecenter">
  <tr>
      <td colspan="2">
      <input type="checkbox" name="agreement" alt="会员协议"/>我已阅读并同意<a href="/html/folder/49-1.htm" target="_blank">《FashionGOLF服务条款》</a>
      	
      </td>
       
    </tr>
 </table>
  <br>
  <center>
  <INPUT TYPE=submit ID="submit1" class="edit_button" VALUE="注册" >&nbsp;
  
  
</center></form>




