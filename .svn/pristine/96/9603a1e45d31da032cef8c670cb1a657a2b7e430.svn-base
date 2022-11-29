<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="tea.entity.Http" %>
<%@ page import="tea.entity.node.Node" %>
<%@ page import="java.util.Enumeration" %>
<%
	String host=request.getRequestURL().substring(0, request.getRequestURL().length()-request.getRequestURI().length());
	Http h=new Http(request);
	

	int node=18;
	Enumeration e=Node.find(" and type=39 and finished=1 and hidden=0", 0, 1);
	if(e.hasMoreElements()){
		int nt=(Integer)e.nextElement();
		node=Node.find(nt).getFather();
	}
	
	int size=10;
	if(h.getInt("size")>0){
		size=h.getInt("size");
	}
	
	int words=20;
	if(h.getInt("words")>0){
		words=h.getInt("words");
	}
	
	int width=600;
	int height=292;
	
%>

<html>

	<head>
		<title>预览</title>
		<link href="/res/<%=h.community %>/cssjs/community.css" rel="stylesheet" type="text/css">
		<script src="/tea/mt.js" type="text/javascript"></script>
		<script src="/jsp/view/jscolor/jscolor.js" type="text/javascript"></script>
		<script>
			mt.preview=function(){
				var width="";
				if(form1.autowidth.checked){
					width="100%";
					document.getElementById("width").disabled=true;
				}else{
					width=form1.width.value;
					document.getElementById("width").disabled=false;
				}
				var title=true;
				if(form1.autotitle.checked){
					title=false;
				}
				
				var stime=true;
				if(form1.autotime.checked){
					stime=false;
					
				}
				
				var frm="<%=host%>/jsp/view/PreviewInfo.jsp?node="+form1.node.value+"&size="+form1.size.value+"&title="+title+"&stime="+stime+"&fsize="+form1.fsize.value+"&color="+form1.color.value+"&words="+form1.words.value
						+"&btlcolor="+form1.btlcolor.value+"&acolor="+form1.acolor.value+"&ahover="+form1.ahover.value;	
				var pview="<iframe width='"+width+"' height='"+form1.height.value+"' frameborder='no' scrolling='no' src='"+frm+"'></iframe>";
				form1.txtview.value=pview;
				
				document.getElementById("t").innerHTML="";
				document.getElementById("t").innerHTML=pview;
			}
			
			mt.copy=function(){
				var content=document.getElementById("txtview").value;
				//window.clipboardData.setData("Text",content); 
				
				
				if(window.clipboardData) {  
		            window.clipboardData.clearData();  
		            window.clipboardData.setData("Text", content);  
		    	}else{
		    		alert("被浏览器拒绝，请切换至兼容模式或者手动复制。");
		   	 		return false;
		       }
			}
		</script>
	</head>
<style>
.fl{float:left;width:35%; clear:both}
.fr{float:left;width:35%;}
</style>
	<body onLoad="mt.preview();">
		
		<h1>引用设置</h1>
		<form name="form1">
        <div class="fl">
		<table id="tablecenter" cellspacing="0" >
			<tr  id="tableonetr">
				<td>节点号：</td>
				<td><input type="text" name="node" onBlur="mt.preview();" size="5" value="<%=node%>"/></td>
			</tr>
			
			<tr>
				<td>宽：<input type="text" name="width" id="width" onBlur="mt.preview();" size="5"  value="<%=width%>"/>px</td>
				<td>高：<input type="text" name="height" onBlur="mt.preview();" size="5"  value="<%=height%>"/>px</td>
			</tr>
			<tr>
				<td ><input type="checkbox" name="autowidth" onClick="mt.preview();"/>宽度自动适应</td>
				<td ><input type="checkbox" name="autotitle"  onClick="mt.preview();" checked/>显示标题栏</td>
			</tr>
			<tr>
				<td >标题栏颜色：<input type="text" class="color" value="#d6f3f7" name="btlcolor" size="6" readonly onChange="mt.preview();" ></td>
				<td >字体颜色：<input type="text" class="color" value="#2881AD" name="color" size="6" readonly onChange="mt.preview();" ></td>
			</tr>
			<tr>
				<td >链接色：<input type="text" class="color" value="#00141F" name="acolor" size="6" readonly onChange="mt.preview();" ></td>
				<td >鼠标悬停色：<input type="text" class="color" value="#FD3592" name="ahover" size="6" readonly onChange="mt.preview();" ></td>
			</tr>
			<tr>
				<td>每行显示<input type="text" name="words" onBlur="mt.preview();" size="3"  value="<%=words%>"/>字</td>
				<td>显示<input type="text" name="size" onBlur="mt.preview();" size="3"  value="<%=size%>"/>条</td>
			</tr>
			<tr>
				<td >选择字号：<select name="fsize" onChange="mt.preview();">
									<option value="16">16</option>
									<option value="15">15</option>
									<option value="14" selected>14</option>
									<option value="13">13</option>
									<option value="12">12</option>
							</select>px
				
				
				</td>
				<td ><input type="checkbox" name="autotime"  onClick="mt.preview();" checked/>显示新闻创建时间</td>
			</tr>
			<tr>
				<td colspan="2">设置完成，获得嵌入的代码</td>
			</tr>
			<tr>
				<td colspan="2"><textarea name="txtview" id="txtview" rows="5" cols="50"></textarea><br/>
					<input type="button" value="复制代码" onClick="mt.copy();">
				</td>
			</tr>
		</table>
		</div>
        <div class="fr">
		<table id="tablecenter" cellspacing="0" >
			<tr  id="tableonetr">
				<td>效果预览</td>
			</tr>
			<tr>
				<td colspan="2" id="t">
				</td>
			</tr>
		
	
		</table>
        </div>
		</form>
	</body>
</html>