<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.entity.node.Event"%>
<%@page import="tea.entity.node.Node"%>
<%@page import="tea.entity.lvyou.LvyouJobCatagory"%>
<%@page import="tea.entity.lvyou.LvyouModels "%>

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
<script src="/jsp/custom/westrac/script.js"></script>

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
	
	      document.getElementById("submit1").disabled=false;
		  document.getElementById("submit1").value='注册';

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
<form name="form1" method="POST" action="/servlet/EditMember"  target="_ajax" onSubmit="t=$('member_info').innerHTML;if(t.length>1&&t!='&amp;nbsp;'){mt.show(t);return false;};return mt.check(this);">
<input type="hidden" name="node" value="<%=teasession._nNode%>">
<input type="hidden" name="nexturl" value="/html/westrac/folder/17-1.htm">

<input type="hidden" name="act" value="TelWestracRegister">
<input type="hidden" name="invite" value="<%=invite %>">

 <table border="0" cellpadding="0" cellspacing="0" class="regtable" id="tablecenter">
     
    <tr>
      <td align="right" nowrap="nowrap" class="td01"><span id="btid">*</span>&nbsp;用户名：</td>
      <td><input name="member" onfocus="mt.f_m(this)" onblur="mt.f_m(this)" min='4' maxlength="20" alt="用户名"></td>
	</tr>
    <tr><td colspan="2" class="td03"><div id="member_info"></div></td>
    </tr>
   

	<tr>
      <td align="right" nowrap="nowrap" class="td01"><span id="btid">*</span>&nbsp;姓名：</td>
      <td>
        <input type="text"    name="membername" value=""  onfocus="mt.f_membername(this)" onblur="mt.f_membername(this)" alt="姓名">
      </td>
    </tr>
    <tr><td colspan="2" class="td03"><div id="membername_info"></div></td></tr>
    <tr>
      <td align="right" nowrap="nowrap" class="td01"><span id="btid">*</span>&nbsp;性别：</td>
      <td>
       	<select name="sex">
       		<option value="1">男</option>
       		<option value="0">女</option>
       	</select>
      </td>
    </tr>
    <tr><td colspan="2" ></td></tr>
    <tr>
      <td align="right" nowrap="nowrap" class="td01"><span id="btid">*</span>&nbsp;密码：</td>
      <td>
       	<input type="password"    name="EnterPassword" onfocus="mt.f_p(this)" onblur="mt.f_p(this)" min='6' maxlength="20" alt="密码">
        </td>
    </tr>
	<tr><td colspan="2" class="td03"><div id="EnterPassword_info"></div></td></tr>
     <tr>
      <td align="right" nowrap="nowrap" class="td01"><span id="btid">*</span>&nbsp;确认密码：</td>
      <td>
       	<input type="password"    class="edit_input" name="ConfirmPassword" onfocus="mt.f_3(this)" onblur="mt.f_3(this)" alt="确认密码">
      </td>
    </tr>
    <tr><td colspan="2" class="td03"><div id="ConfirmPassword_info"></div></td></tr>
    
    <tr>
      <td align="right" nowrap="nowrap" class="td01"><span id="btid">*</span>&nbsp;手机：</td>
      <td>
       	<input type="text" class="edit_input" name="mobile" onfocus="mt.f_mobile(this)"  onblur="mt.f_mobile(this)" alt="手机号">
      </td>
    </tr>
    <tr><td colspan="2" class="td03"><div id="mobile_info"></div></td></tr>
    <tr>
      <td align="right" nowrap="nowrap" class="td01"><span id="btid">*</span>&nbsp;身份类型：</td>
      <td>
      <select name="wsttype" >
      <%
      ArrayList<LvyouJobCatagory> catatList =LvyouJobCatagory.find();
      for(int i=0;i<catatList.size();i++)
      {
    	  LvyouJobCatagory cata=(LvyouJobCatagory)catatList.get(i);
    	  out.print("<option value="+i+">"+cata.getName());
      }
      
     
      %>
      </select>
      </td>
    </tr>
    <tr><td colspan="2" ></td></tr>

       <tr>
      <td align="right" nowrap="nowrap" class="td01"><span id="btid">*</span>&nbsp;现工作地：</td>
      <td>
       	<script>mt.city("city0","city1",null,"");</script>
       </td>
    </tr>
    <tr><td colspan="2" class="td03"><div id="city0_info"></div>
       <span id="address_info"></span></td></tr>

     <!--<tr>
   	<td align="right" nowrap="nowrap" colspan="2"><span id="btid">*</span>&nbsp;从何得知履友联盟？</td>
    </tr>
    <tr><td class="td01"></td>
   	<td>
   	<%
   	if(invite!=null && invite.length()>0)
  	{
   		out.print(Profile.SOURCE_TYPE[2]);
  	}else{
   	%>
   		<select name="source" onchange="f_source();" alt="从何得知履友联盟">
   			<option value="">-选择-</option>
   			<%
   				for(int i=1;i<Profile.SOURCE_TYPE.length;i++)
   				{
   					out.print("<option value="+i);

   					out.print(">"+Profile.SOURCE_TYPE[i]);
   					out.print("</option>");
   				}
   			%>
   		</select>
   		<%} %>
   		&nbsp;
   		<span id="trainid" style="display:none"><br>
   			哪次培训：<input type="text"    name="trainname" value=""  onfocus="mt.f_trainname(this)" onblur="mt.f_trainname(this)" alt="那次培训"><div id="trainname_info"></div>

   			<br>
   			培训地点：<input type="text"    name="trainaddress" value=""  onfocus="mt.f_trainaddress(this)" onblur="mt.f_trainaddress(this)" alt="培训地点"><div id="trainaddress_info"></div>
   			<br>
   			培训时间：<input type="text"    name="traintime" value=""  onfocus="mt.f_traintime(this)" onblur="mt.f_traintime(this)" alt="培训时间"><div id="traintime_info"></div>
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
   			销售员姓名：<input type="text"    name="belsell" value=""  onfocus="mt.f_belsell(this)" onblur="mt.f_belsell(this)" alt="销售员姓名"><div id="belsell_info"></div>
   			销售员手机号：<input type="text"     name="tjmobile" value=""  onfocus="mt.f_belsellphone(this)" onblur="mt.f_belsellphone(this)" alt="销售员手机号"><div id="tjmobile_info"></div>
   			  
   		</span>
   		 <span id="source_info"></span>

   	</td>
    </tr>-->
     <tr>
      <td colspan="2" style="padding-left:10px;">
      <input type="checkbox" name="agreement" alt="会员协议"/>我已阅读并同意<a href="###" onclick="javascript:mt.show('　　凡本网站注册会员参与本站内容提供和论坛讨论必须遵守中华人民共和国法律法规。会员单独承担发表内容的责任。',1,'《威斯特会员协议》')">《履友协议》</a>

      </td>

    </tr>

  </table>
  <center>
  <INPUT ID="submit1" class="edit_button" type="image" src="/res/westrac/structure/submit_btn.png" VALUE="注册" onclick="form1.submit()">
</center></form>





