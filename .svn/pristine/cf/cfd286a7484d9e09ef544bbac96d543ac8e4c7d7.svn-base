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
%>
<html>
<head>
<title>俱乐部高级会员高级查询</title>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/tea/Calendar.js" type="text/javascript"></script>
<script src="/tea/city.js"></script>
</head>
<body >



<script type="text/javascript">


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
<form name="form1" method="POST" action="/jsp/user/GolfMember.jsp" >
<input type="hidden" name="node" value="<%=teasession._nNode%>">
<input type="hidden" name="nexturl" value="<%=nexturl%>">


<table border="0" CELLPADDING="0" CELLSPACING="0" id="tablecenter"> 
    <tr>
      <td align="right">会员编号：</td>
      <td>
        <input type="text"    class="edit_input" name="code" value="" >&nbsp;<span id="member_id"></span>
      </td>
    </tr>
     
    <tr>
      <td align="right">用户名：</td>
      <td>
        <input type="text"    class="edit_input" name="memberid" value="" >&nbsp;<span id="member_id"></span>
      </td>
    </tr>
    
    <td align="right">注册时间：</td>
    <td>从&nbsp;
        <input id="time_c" name="time_c" size="7"  value=""  style="cursor:pointer" readonly="readonly" onclick="new Calendar().show('form1.time_c');"> 
        <img style="margin-bottom:-8px;" style="cursor:pointer"  src="/tea/image/bbs_edit/table.gif"  style="cursor:pointer" onclick="new Calendar().show('form1.time_c');" />
        &nbsp;到&nbsp;
        <input id="time_d" name="time_d" size="7"  value=""  style="cursor:pointer" readonly="readonly" onclick="new Calendar().show('form1.time_d');" >
        <img style="margin-bottom:-8px;" style="cursor:pointer"  src="/tea/image/bbs_edit/table.gif"   style="cursor:pointer" onclick="new Calendar().show('form1.time_d');" />
     </td>
    
	<tr>
      <td align="right">姓名：</td>
      <td>
        <input type="text"    class="edit_input" name="membername" value="">&nbsp;<span id="membername_id"></span>
      </td>
    </tr>
    <tr>
      <td align="right">性别：</td>
      <td>
       	<select name="sex">
       		<option value="">性别</option>
       		<option value="1">男</option>
       		<option value="0">女</option>
       	</select>
      </td>
    </tr>
   
     <tr>
      <td align="right">身份证号：</td>
      <td>
       	<input type="text"    class="edit_input" name="card" value="">&nbsp;<span id="card_id"></span>
      </td>
    </tr>
    <tr>
      <td align="right">手机：</td>
      <td>
       	<input type="text"    class="edit_input" name="mobile" value="">&nbsp;<span id="mobile_id"></span>
      </td>
    </tr>
    <tr>
      <td align="right">生日：</td>
      <td>
 从
        <input id="birth" name="birth" size="7"  value=""  style="cursor:pointer" readonly="readonly" onClick="new Calendar().show('form1.birth');"> 
        <img style="margin-bottom:-8px;" style="cursor:pointer"  src="/tea/image/bbs_edit/table.gif"  style="cursor:pointer" onclick="new Calendar().show('form1.birth');" />
        到
        <input id="birth2" name="birth2" size="7"  value=""  style="cursor:pointer" readonly="readonly" onClick="new Calendar().show('form1.birth2');"> 
        <img style="margin-bottom:-8px;" style="cursor:pointer"  src="/tea/image/bbs_edit/table.gif"  style="cursor:pointer" onclick="new Calendar().show('form1.birth2');" />
         </td>
    </tr>
       <tr>
      <td align="right">现工作地：</td>
      <td>
       	<script>mt.city("city0","city1",null,"");</script>
     
    <input type="text" name="address" value="" title="详细地址">&nbsp;<span id="city_id"></span>
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
     
    详细地址：<input type="text" name="paddress" value="" title="详细地址">
      </td>
    </tr>
     <tr>
      <td align="right">现通讯地址：</td>
      <td>
       	<script>mt.city("state0","state1",null,"");</script>
     
    详细地址：<input type="text" name="organization" value="" title="详细地址">
      </td>
    </tr>
     <tr>
      <td align="right">邮编：</td>
      <td>
       	<input type="text"    class="edit_input" name="zip" value="">
      </td>
    </tr>
     <tr>
      <td align="right">E-mail：</td>
      <td>
       	<input type="text"    class="edit_input" name="email" value="">
      </td>
    </tr>
    <tr>
      <td align="right">QQ：</td>
      <td>
       	<input type="text"    class="edit_input" name="msn" value="">
      </td>
    </tr>
    
    <tr>
      <td align="right">推荐人会员编号：</td>
      <td>
 			<input type="text"    class="edit_input" name="tjmember" value="">
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
   <tr>
   		<td align="right">企业名称：</td>
   		<td>
   			<input type="text"    class="edit_input" name="entername" value=""  maxlength="40" >
   		</td>
   </tr>
   
   <tr>
   		<td align="right">企业LOGO或图片：</td>
   		<td>
   			<input type="text"    class="edit_input" name="enterpic" value=""  >
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
  
  
  
  <br>
  <center>
  <INPUT TYPE=submit ID="submit1"  VALUE="查询" onClick="f_sub();">&nbsp;
  <INPUT TYPE=submit ID="submit1"  VALUE="返回" onClick="javascript:history.go(-1)">
  
  
</center></form>
</body>
</html>



