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
String nexturl = "/jsp/westrac/WestracUpgradeMember2.jsp";
if(teasession._rv==null)
{
	out.println("您没有登录，请登录后操作");
	return;
}


String member = teasession._rv.toString();
Profile p = Profile.find(member);

if(p.getMembertype()==2)
{
	out.print("<SCRIPT LANGUAGE=JAVASCRIPT SRC=\"/tea/ym/ymPrompt.js\" type=\"\"></SCRIPT>");
	out.print("<link href=\"/tea/ym/skin/dmm-green/ymPrompt.css\" rel=\"stylesheet\" type=\"text/css\">");

		out.println("<script>");
		out.println("ymPrompt.win({message:'<br><center>您申请的履友用户正在等待审核，请耐心等待...!</center>',width:300,height:100,handler:noTitlebar,btn:[['关闭']],titleBar:false});");
		out.println("function noTitlebar(){parent.ymPrompt.close();}");
		out.println("</script>");
		return;
}
if(p.getMembertype()==1)
{
	out.print("<SCRIPT LANGUAGE=JAVASCRIPT SRC=\"/tea/ym/ymPrompt.js\" type=\"\"></SCRIPT>");
	out.print("<link href=\"/tea/ym/skin/dmm-green/ymPrompt.css\" rel=\"stylesheet\" type=\"text/css\">");

		out.println("<script>");
		out.println("ymPrompt.win({message:'<br><center>您已经是履友会员了，不需要升级了...!</center>',width:300,height:100,handler:noTitlebar,btn:[['关闭']],titleBar:false});");
		out.println("function noTitlebar(){parent.ymPrompt.close();}");
		out.println("</script>");
		return;
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
<link href="/res/westrac/cssjs/12L1.css" rel="stylesheet" type="text/css"/>
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

f_xp('<%=p.getXpinpai()%>','xxinghaoid','xxinghao','<%=p.getXxinghao()%>');
f_xp('<%=p.getCpinpai()%>','cxinghaoid','cxinghao','<%=p.getCxinghao()%>');
</script>
<form name="form1" method="POST" action="/servlet/EditMember"  target="_ajax" onSubmit="return mt.check(this);">
<input type="hidden" name="node" value="<%=teasession._nNode%>">
<input type="hidden" name="nexturl" value="<%=nexturl%>">
<input type="hidden" name="act2" value="WestracUpgradeMemberRegister">
<input type="hidden" name="act" value="EditWestracMmeber">
<input type="hidden" name="EnterPassword" value="<%=p.getPassword() %>">


<input type="hidden"   name="member" value="<%=member %>">
<input type="hidden"   name="code" value="<%=p.getCode() %>">

 <table border="0" cellpadding="0" cellspacing="0" class="regtable" id="tablecenter">
   <tr>
      <td align="right" nowrap="nowrap" class="td01"><span id="btid">*</span>&nbsp;会员编号：</td>
           <td><%=p.getCode() %></td>

    </tr>
    <tr>
      <td align="right" nowrap="nowrap" class="td01"><span id="btid">*</span>&nbsp;用户名：</td>
           <td><%=member %></td>

    </tr>
    <tr>
      <td align="right" nowrap="nowrap" class="td01">E-mail：</td>
      <td>
       	<input type="text"    class="edit_input" name="email" value="<%=Entity.getNULL(p.getEmail()) %>"><span class="tixing"><font>&nbsp;邮箱是联系我们、订阅信息、找回密码的必要手段，请正确填写。如您还没有邮箱，请马上<a href="http://reg.email.163.com/mailregAll/reg0.jsp?from=email163&regPage=163" target="_blank">注册</a>一个。</font></span>
      </td>
    </tr>

	<tr>
      <td align="right" nowrap="nowrap" class="td01"><span id="btid">*</span>&nbsp;姓名：</td>
      <td>
        <input type="text"    name="membername" value="<%=Entity.getNULL(p.getFirstName(teasession._nLanguage)) %>"  onfocus="mt.f_membername(this)" onblur="mt.f_membername(this)" alt="姓名"><span id="membername_info"></span>
      </td>
    </tr>
    <tr>
      <td align="right" nowrap="nowrap" class="td01"><span id="btid">*</span>&nbsp;性别：</td>
      <td>
       	<select name="sex">
       		<option value="1" <%if(!p.isSex()){out.println(" selected ");} %>>男</option>
       		<option value="0" <%if(p.isSex()){out.println(" selected ");} %>>女</option>
       	</select>
      </td>
    </tr>

     <tr>
      <td align="right" nowrap="nowrap" class="td01"><span id="btid">*</span>&nbsp;身份证号：</td>
      <td>
       	<input type="text"    class="edit_input" name="card" value="<%=Entity.getNULL(p.getCard()) %>" onfocus="mt.f_card(this)" onblur="mt.f_card(this)" alt="身份证"><span id="card_info"><font>请填写您真实身份证号，否则将无法领取奖品</font></span>
      </td>
    </tr>
    <tr>
      <td align="right" nowrap="nowrap" class="td01"><span id="btid">*</span>&nbsp;手机：</td>
      <td>
       	<input type="text"    class="edit_input" name="mobile" onfocus="mt.f_mobile(this)"  value="<%=p.getMobile() %>" onblur="mt.f_mobile(this)" alt="手机号"><span id="mobile_info"></span>
      </td>
    </tr>
    <tr>
      <td align="right" nowrap="nowrap" class="td01"><span id="btid">*</span>&nbsp;生日：</td>
      <td>

        <input id="birth" name="birth" size="7"  value="<%if(p.getBirth()!=null)out.print(Entity.sdf.format(p.getBirth())); %>"  style="cursor:pointer" readonly="readonly"  onfocus="mt.f_birth(this)"  onblur="mt.f_birth(this)" alt="生日"  onClick="new Calendar().show('form1.birth');">
        <img style="margin-bottom:-8px;" style="cursor:pointer"  src="/tea/image/bbs_edit/table.gif"  style="cursor:pointer" onclick="new Calendar().show('form1.birth');" />
       <span id="birth_info"></span>
      </td>
    </tr>
       <tr>
      <td align="right" nowrap="nowrap" class="td01"><span id="btid">*</span>&nbsp;现工作地：</td>
      <td>

       	<script>mt.city("city0","city1",null,'<%=p.getProvince(teasession._nLanguage) %>');</script>


    详细地址:<input type="text" name="address" value="<%=p.getAddress(teasession._nLanguage) %>" onfocus="mt.f_address(this)"   onblur="mt.f_address(this)" alt="现工作地详细地址" >
       <span id="city0_info"></span>
    <span id="address_info"></span>
      </td>
    </tr>


   <tr>
   	<td align="right" nowrap="nowrap" class="td01"><span id="btid">*</span>&nbsp;从何得知履友联盟？</td>
   	<td>
   	<%
   	String invite=null;
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
   			哪次培训：<input type="text"    name="trainname" value=""  onfocus="mt.f_trainname(this)" onblur="mt.f_trainname(this)" alt="那次培训"><span id="trainname_info"></span>

   			<br>
   			培训地点：<input type="text"    name="trainaddress" value=""  onfocus="mt.f_trainaddress(this)" onblur="mt.f_trainaddress(this)" alt="培训地点"><span id="trainaddress_info"></span>
   			<br>
   			培训时间：<input type="text"    name="traintime" value=""  onfocus="mt.f_traintime(this)" onblur="mt.f_traintime(this)" alt="培训时间"><span id="traintime_info"></span>
   		</span>
   		<span id="tjmemberid"  <%if(invite!=null && invite.length()>0){out.print(" style=display:'' ");}else{out.print("  style=\"display:none\"  ");} %>><br>
   		推荐人会员编号或用户名：<%
      	if(invite!=null && invite.length()>0)
      	{
      		Profile pobj = 	Profile.find(Integer.parseInt(invite));
      		out.println("会员编号："+pobj.getCode());
      		out.println("用户名："+pobj.getMember());
      	}else{
      %>
 			<input type="text"    class="edit_input" name="tjmember" value=""  onfocus="mt.f_tm(this)" onblur="mt.f_tm(this)" min='4' maxlength="20" alt="推荐人会员编号或用户名"><span id="tjmember_info"></span>

      <%} %>
   		</span>
   		<span id="belsellid" style="display:none"><br>
   			销售员姓名：<input type="text"    name="belsell" value=""  onfocus="mt.f_belsell(this)" onblur="mt.f_belsell(this)" alt="销售员姓名"><span id="belsell_info"></span>
   		</span>
   		 <span id="source_info"></span>

   	</td>
   </tr>


      <tr>
      <td colspan="2">
      	<input type="checkbox" name="xybcheck" id="xybcheck" value="1" onclick="f_xybcheck();" >
      	为了使我们能够提供更多更好的个性化服务，您可以填写完整的准确个人资料，我们将对您的资料严格保密，在任何情况下，我们都不会透露给任何第三方.

      </td>

    </tr>
     <tr>
      <td colspan="2" class="td03">
      <input type="checkbox" name="agreement" alt="会员协议"/>我已阅读并同意<a href="/html/folder/49-1.htm" target="_blank">《履友协议》</a>

      </td>

    </tr>

  </table>
  <script>



  </script>

 <span id="welid" style="display:none">

 <table border="0" cellpadding="0" cellspacing="0" id="tablecenter" class="regtable">




    <tr>
      <td align="right" class="td01">民族：</td>
      <td>
        <input type="text"  maxlength=16  class="edit_input" name="zzracky" value="<%=Entity.getNULL(p.getZzracky()) %>">
      </td>
    </tr>

	<tr>
      <td align="right" class="td01">固定电话：</td>
      <td>
        <input type="text"    class="edit_input" name="telephone" value="<%=Entity.getNULL(p.getTelephone(teasession._nLanguage)) %>">
      </td>
    </tr>
     <tr>
      <td align="right" class="td01">家庭所在地：</td>
      <td>
       	 	<script>mt.city("zzhkszd0","zzhkszd1",null,"<%=p.getZzhkszd(teasession._nLanguage) %>");</script>

    详细地址:<input type="text" name="paddress" value="<%=Entity.getNULL(p.getPAddress(teasession._nLanguage)) %>" title="详细地址">
      </td>
    </tr>
     <tr>
      <td align="right" class="td01">现通讯地址：</td>
      <td>
       	<script>mt.city("state0","state1",null,"<%=p.getState(teasession._nLanguage) %>");</script>

    详细地址:<input type="text" name="organization" value="<%=Entity.getNULL(p.getOrganization(teasession._nLanguage)) %>" title="详细地址">
      </td>
    </tr>
     <tr>
      <td align="right" class="td01">邮编：</td>
      <td>
       	<input type="text"    class="edit_input" name="zip" value="<%=Entity.getNULL(p.getZip(teasession._nLanguage)) %>">
      </td>
    </tr>

    <tr>
      <td align="right" class="td01">QQ：</td>
      <td>
       	<input type="text"    class="edit_input" name="msn" value="<%=Entity.getNULL(p.getMsnID()) %>">
      </td>
    </tr>




      <tr>
      <td  align="right" class="td01">是否有上岗证：</td>
      <td>
	      <input type="radio" name="sfshanggang" value="0"  <%if(p.getSfshanggang()==0){out.println(" checked ");} %> >&nbsp;是
	      <input type="radio" name="sfshanggang" value="1"  <%if(p.getSfshanggang()==1){out.println(" checked ");} %> >&nbsp;否
      </td>

    </tr>

      <tr>
      <td align="right" class="td01">发证机关：</td>
      <td>
 			<input type="text"    class="edit_input" name="fazhengjiguan" value="<%=Entity.getNULL(p.getFazhengjiguan()) %> ">
      </td>
    </tr>
     <tr>
      <td align="right" class="td01">操作年限：</td>
      <td>
 			<input type="text"    class="edit_input" name="caozuonianxian" value="<%=Entity.getNULL(p.getCaozuonianxian()) %> ">
      </td>
    </tr>

      <tr>
      <td align="right" class="td01">现操作机型：</td>
      <td>
 			<select name="xpinpai" onchange="f_xp(this.value,'xxinghaoid','xxinghao','0');">
 				<option value="0">品牌</option>
 				<%
 				java.util.Enumeration e = WomenOptions.find(" AND community="+DbAdapter.cite(teasession._strCommunity)+" and type= 0",0,Integer.MAX_VALUE);
 		        while(e.hasMoreElements())
 		       {
 		            int wid = ((Integer)e.nextElement()).intValue();
 		            WomenOptions obj = WomenOptions.find(wid,teasession._nLanguage);
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
 			</span>
 			<input type="text"     name="xqita" value="<%=Entity.getNULL(p.getXqita()) %>">
      </td>
    </tr>
     <tr>
      <td align="right" class="td01">曾操作机型：</td>
      <td>
 			<select name="cpinpai" onchange="f_xp(this.value,'cxinghaoid','cxinghao','0');">
 				<option value="0">品牌</option>
 				<%
	 				java.util.Enumeration e2 = WomenOptions.find(" AND community="+DbAdapter.cite(teasession._strCommunity)+" and type= 0",0,Integer.MAX_VALUE);
	 		        while(e2.hasMoreElements())
	 		       {
	 		            int wid = ((Integer)e2.nextElement()).intValue();
	 		            WomenOptions obj = WomenOptions.find(wid,teasession._nLanguage);
	 		            out.println("<option value="+wid);
	 		           if(p.getCpinpai()==wid)
	 		            {
	 		            	out.println(" selected ");
	 		            }

	 		            out.println(">"+obj.getWoname());
	 		            out.print("</option>");
	 		       }
 				%>
 			</select>
 				<span id="cxinghaoid">
	 			<select name="cxinghao">
	 				<option value="0">型号</option>
	 			</select>
 			</span>
 			<input type="text"     name="cqita"  value="<%=Entity.getNULL(p.getCqita()) %>">
      </td>
    </tr>
     <tr>
      <td align="right" class="td01">机主相关：</td>
      <td>
 			姓名:<input type="text"    class="edit_input" name="jzname" value="<%=Entity.getNULL(p.getJzname()) %>">
 			型号:<input type="text"    class="edit_input" name="jzxinghao" value="<%=Entity.getNULL(p.getJzxinghao()) %>">
      </td>
    </tr>
    <tr>
      <td>&nbsp;</td>
      <td>
 			序列号:<input type="text"    class="edit_input" name="jzxuliehao" value="<%=Entity.getNULL(p.getJzxuliehao()) %>">
      </td>
    </tr>
     <tr>
      <td>&nbsp;</td>
      <td>
 			联系方式:<input type="text"    class="edit_input" name="jzlianxi" value="<%=Entity.getNULL(p.getJzlianxi()) %>">
      </td>
    </tr>
     <tr>
     <td align="right" class="td01">爱好：</td>
      <td>
 			<textarea rows="3" cols="60" name="aihao"><%=Entity.getNULL(p.getAihao()) %></textarea>
      </td>
    </tr>
  </table>
</span>



  <br>
  <center>
  <INPUT TYPE=submit ID="submit1" class="edit_button" VALUE="提交" >&nbsp;


</center></form>




