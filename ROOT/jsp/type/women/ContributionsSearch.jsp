<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="tea.ui.TeaSession"%>
<%@page import="tea.entity.site.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.resource.*"%>
<%@page import="tea.db.*"%>
<%@page import="tea.entity.member.*"%>

<%@page import="java.net.URLEncoder"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="tea.entity.women.*" %>
<%
    response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);


%>
<link href="/tea/ym/skin/bluebar/ymPrompt.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" language="javascript" src="/tea/tea.js"></script>
<script type="text/javascript" language="javascript" src="/tea/ym/ymPrompt.js"></script>


<script>

function f_sub()
{
/*
	if(form1.name1.value==''){
		alert("请填写姓名");
		form1.name1.focus();
		return false;
	}
	*/
	if(form1.bh1.value==''){
		alert("请填写收据编号");
		form1.bh1.focus();
		return false;
	} 

	//sendx("/jsp/admin/edn_ajax.jsp?act=CSPAYTYPE&type1=1&name1="+encodeURIComponent(form1.name1.value)+"&bh1="+encodeURIComponent(form1.bh1.value),
	sendx("/jsp/admin/edn_ajax.jsp?act=CSPAYTYPE&type1=1&bh1="+encodeURIComponent(form1.bh1.value),
		 function(data)
		 {
		   if(data!=''&&data.length>1)//如果有这个用户  则写入Cookie
		   {
 			if(data.trim()=='false'){
 				alert("对不起，您所输入的信息有误");
 				return false;
 			}else
 			{

 				ymPrompt.win({message:data,width:700,height:550,msgCls:'myContent',title:'个人捐助信息查询'})
 			}
		   }
		 }
		 );
}
function f_sub2()
{
/*
	if(form2.name2.value==''){
		alert("请填写企业/集体名称");
		form2.name2.focus();
		return false;
	}
	*/
	if(form2.bh2.value==''){
		alert("请填写收据编号");
		form2.bh2.focus();
		return false;
	}

	sendx("/jsp/admin/edn_ajax.jsp?act=CSPAYTYPE&type1=2&name2="+encodeURIComponent(form2.name2.value)+"&bh2="+encodeURIComponent(form2.bh2.value),
		 function(data)
		 {
		   if(data!=''&&data.length>1)//如果有这个用户  则写入Cookie
		   {
 			if(data.trim()=='false'){
 				alert("对不起，您所输入的信息有误");
 				return false;
 			}else
 			{

 				ymPrompt.win({message:data,width:700,height:550,msgCls:'myContent',title:'企业/集体捐助信息查询'})
 			}
		   }
		 }
		 );
}
</script>


<form action="?" name="form1" method="post">


 <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
 	<tr>
 		<td class="td01" align="center" colspan="2"></td>
 	</tr>
 		<!--<tr>
 		<td align="right">姓名：</td>
	      <td class="td03"> <input type="text" name="name1" value=""/></td>

 		</tr>-->
 	<tr>
 		<td align="right">收据编号：</td>
 		 <td class="td03"><input type="text" name="bh1" value=""/></td>
 	</tr>
 		<tr>
 		<td class="td04" colspan="2"><input style="background:url(/res/mothercellar/1012/10129935.jpg) no-repeat; width:37px;border:0px;" type="button" value="" onclick="f_sub();"></td>
 	</tr>
 	 </table>
 </form>

<%--
 <form action="?" name="form2" method="post">
 	 <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
 	<tr>
 		<td class="td02" align="center" colspan="2"></td>
 	</tr>
 		<tr>
 		<td align="right">企业/集体名称：</td>
	      <td class="td03"><input type="text" name="name2" value=""/></td>

 		</tr>
 		<tr>
 		<td align="right">收据编号：</td>
 		<td class="td03"><input type="text" name="bh2" value=""/></td>
 	</tr>
 	<tr>
 			<td class="td04" colspan="2"><input style="background:url(/res/mothercellar/1012/10129935.jpg) no-repeat; width:37px;border:0px;" type="button" value="" onclick="f_sub2();"></td>
 	</tr>

 </table>
</form>

--%>
