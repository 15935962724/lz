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
<title>履友管理高级查询</title>

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
var citynum=0;
function addAddress(){
	var sindex=document.form1.city0.selectedIndex;
	var p=document.form1.city0.options[sindex].text;
	var v1=document.form1.city0.value;
	
	var sindex2=document.form1.city1.selectedIndex;
	var p2=document.form1.city1.options[sindex2].text;
	var v2=document.form1.city1.value;
	
	var txtadd=document.form1.address.value;
	var bo=false;
	var con="",val="";
	if(p!="--------------"){
		con=con+p;
		bo=true;
	}else{
		v1=" ";
	}
		val=val+v1+"-";
		
	if(p2!="--------------"){
		con=con+"-"+p2;
		bo=true;
	}else{
		v2=" ";
	}
		val=val+v2+"-";
	
	if(txtadd.trim()!=""){
		if(con.trim()==""){
			con=con+txtadd;
		}else{
		con=con+"-"+txtadd;
		}
		bo=true;
	}else{
		txtadd=" ";
	}
	val=val+txtadd+";";
	if(con.trim()!=""&&bo){
	var sel=document.getElementById("selText").innerHTML;
	sel+="<input type='hidden' id='cityVal"+citynum+"' value='"+val+"'  style='float:left;' /><span  id='cityLab"+citynum+"' style='float:left;'>"+con+"</span><span id='cityClo"+citynum+"'  style='border:1px solid #333;width:10px;height:11px;overflow:hidden;line-height:7px;float:left;color:red;' onmouseover='mv(this);' onclick='clearSel("+citynum+");' ><b>×</b></span>";
	
	document.getElementById("selText").innerHTML=sel;
	}
	
	citynum++;
}
function mv(s){
	s.style.cursor="hand";
}
function clearSel(star){
		document.getElementById("cityVal"+star).value="";
		document.getElementById("cityLab"+star).innerHTML="";
		document.getElementById("cityClo"+star).innerHTML="";
		document.getElementById("cityClo"+star).style.display="none";
}
function sea_sub(){
	var cityvs=document.getElementById("cityvals");
	var txtcityvs=document.getElementById("txtcityvals");
	cityvs.value="";
	txtcityvs.value="";
	for(var i=0;i<citynum;i++){
		var cityval=document.getElementById("cityVal"+i).value;
		if(cityval.trim()!=""){
			cityvs.value=cityvs.value+cityval;
			var cityLab=document.getElementById("cityLab"+i).innerHTML;
			if(txtcityvs.value!=""){
			txtcityvs.value=txtcityvs.value+"+"+cityLab;
			}else{
			txtcityvs.value=txtcityvs.value+cityLab;
			}
		}
	}
	f_sub();
}
</script> 
<form name="form1" method="POST" action="/jsp/westrac/WestracMember.jsp" >
<input type="hidden" name="node" value="<%=teasession._nNode%>">
<input type="hidden" name="nexturl" value="<%=nexturl%>">
<input type="hidden" name="cityvals" id="cityvals" value="">
<input type="hidden" name="txtcityvals" id="txtcityvals" value="">

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
      <td align="right" rowspan="2">现工作地：</td>
      <td><span style="float:left;">已选条件：</span><span id="selText"  style="float:left;"></span></td>
      
    </tr>
    <tr>
     <td>
       	<script>mt.city("city0","city1",null,"");</script>
     
    <input type="text" name="address" value="" title="详细地址">&nbsp;<span id="city_id"></span><input type="button" onclick="addAddress();" value="添加"/>
      </td>
     
     </tr>
     
   
    <tr>
      <td align="right">民族：</td>
      <td>
        <input type="text"  maxlength=16  class="edit_input" name="zzracky" value="">
      </td>
    </tr>
  
         
    <tr>
      <td align="right">学历：</td>
      <td> 
       	  <select name="degree">
       	  	<%
       	  		for(int i=0;i<Profile.DEGREE_TYPE.length;i++)
       	  		{
       	  			out.print("<option value="+i);
       	  			
       	  			out.print(">"+Profile.DEGREE_TYPE[i]);
       	  			out.print("</option>");
       	  			
       	  		}
       	  	%>
       	  </select>
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
      <td align="right">推荐人用户名：</td>
      <td>
 			<input type="text"    class="edit_input" name="tjmember" value="">
      </td>
    </tr>
      
      <tr>
      <td  align="right">是否有上岗证：</td>
      <td>
	      <input type="radio" name="sfshanggang" value="0">&nbsp;是
	      <input type="radio" name="sfshanggang" value="1">&nbsp;否
      </td>
     
    </tr>
     
      <tr>
      <td align="right">发证机关：</td>
      <td>
 			<input type="text"    class="edit_input" name="fazhengjiguan" value="">
      </td>
    </tr>
     <tr>
      <td align="right">操作年限：</td>
      <td>
 			<input type="text"    class="edit_input" name="caozuonianxian" value="">
      </td>
    </tr>
    
      <tr>
      <td align="right">现操作机型：</td>
      <td>
 			<select name="xpinpai" onchange="f_xp(this.value,'xxinghaoid','xxinghao','0');">
 				<option value="0">品牌</option>
 				<%
 				java.util.Enumeration e = WomenOptions.find(teasession._strCommunity, " and type= 0",0,Integer.MAX_VALUE);
 		        while(e.hasMoreElements())
 		       {
 		            int wid = ((Integer)e.nextElement()).intValue();
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
 			</span>
 			<input type="text"     name="xqita" value="">
      </td>
    </tr>
     <tr>
      <td align="right">曾操作机型：</td>
      <td>
 			<select name="cpinpai" onchange="f_xp(this.value,'cxinghaoid','cxinghao','0');">
 				<option value="0">品牌</option>
 				<%
	 				java.util.Enumeration e2 = WomenOptions.find(teasession._strCommunity, " and type= 0",0,Integer.MAX_VALUE);
	 		        while(e2.hasMoreElements())
	 		       {
	 		            int wid = ((Integer)e2.nextElement()).intValue();
	 		            WomenOptions obj = WomenOptions.find(wid);
	 		            out.println("<option value="+wid);
	 		          
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
 			<input type="text"     name="cqita"  value="">
      </td>
    </tr>
    
     <tr>
      <td align="right">机主相关：</td>
      <td>
 			姓名：<input type="text"    class="edit_input" name="jzname" value="">
 			型号：<input type="text"    class="edit_input" name="jzxinghao" value="">
      </td>
    </tr>
    <tr>
      <td>&nbsp;</td>
      <td>
 			序列号：<input type="text"    class="edit_input" name="jzxuliehao" value="">
      </td>
    </tr>
     <tr>
      <td>&nbsp;</td>
      <td>
 			联系方式：<input type="text"    class="edit_input" name="jzlianxi" value="">
      </td>
    </tr>
     <tr>
     <td align="right">爱好：</td>
      <td>
 			<textarea rows="3" cols="60" name="aihao"></textarea>
      </td>
    </tr>
  </table>
</span>
  
  
  
  <br>
  <center>
  <INPUT TYPE=submit ID="submit1"  VALUE="查询" onClick="sea_sub();">&nbsp;
  <INPUT TYPE=submit ID="submit1"  VALUE="返回" onClick="javascript:history.go(-1)">
  
  
</center></form>
</body>
</html>



