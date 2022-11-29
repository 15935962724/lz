<%@page import="java.net.URLDecoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@page import="tea.entity.*"%>
<%@page import="tea.entity.member.*"%>
<%


Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}

int node = h.getInt("node");
int adminunitid = h.getInt("adminunitid");
String nexturl=h.get("nexturl");

//String result = SMessage.create(h.community,"webmaster","|","13581504421",h.language,"test");
//System.out.println(result);
%><html>
<head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/mt.js" type="text/javascript"></script>
<script>var pmt=parent.mt;</script>
<style>
.iframe{overflow:hidden}
</style>
</head>
<body class="iframe">
<form name="uploadForm" action="/servlet/EditMeetingApplicants?repository=participants/<%=node%>" method="post"  enctype="multipart/form-data" >
	<input type="hidden" name="act" value="uploadParticipants" />
	<input type="hidden" name="node" value="<%=node %>" />
	<input type="hidden" name="adminunitid" value="<%=adminunitid %>" />
	<input type="hidden" name="nexturl" value="<%=URLDecoder.decode(nexturl)%>" />
	<table align="center">
		<tr><td height="23px"></td></tr>
		<tr>
		  	<td>上传参会人员文件：</td>
		  	<td>
		  		<!-- <input type="text" name="participantsattch"/><input readonly class="file0" title="附件" alt="附件" types="*.xls;*.xlsx" /><input type="button" class="file1" value="替换..."/><input class='file2' type='button' value='删除' onclick='mt.adel(this)'/>　<em class="ems">注：只能上传一个附件，如有多个文档请打包上传。若再次上传将会覆盖前一次上传的附件。</em> -->
		  	<!-- <input type="text" name="attch"/> --><input type="file" name="destFile" id="destFile" accept="*.xls;*.xlsx" alt="附件" />
		  	</td>
		</tr>
		<tr><td colspan="2"><span style="color: red;">注：请上传由客户端导出的数据文件，格式应为 .xls,.xlsx。</span></td></tr>
		<tr><td height="5px"></td></tr>
		<tr><td height="23px"></td></tr>
	</table>
	<div align="center">
		<input type="button" value=" 确 定 " onClick="checkFile(this);" />
		<input type="button" value=" 取 消 " onClick="pmt.close();"/>
	</div>
</form>

<script>
function checkFile(obj){  
    //用元素的id获得该元素的值，从而进行判断选择的文件是否合法  
    var file = document.uploadForm.destFile.value ;  
    if(file==null||file==""){  
        alert("你还没有选择任何文件，不能上传!") ;  
        return ;  
    }  
    if(file.lastIndexOf(".")==-1){  
        alert("路径不正确!") ;  
        return ;  
    }  
    var allImgExt = ".xls|.xlsx|" ;  
    var extName = file.substring(file.lastIndexOf(".")) ;  
    if(allImgExt.indexOf(extName+"|")==-1){  
        errMsg="该文件类型不允许上传。请上传 "+allImgExt+" 类型的文件，当前文件类型为"+extName;  
        alert(errMsg);  
        return;  
    }
    //document.uploadForm.target="_ajax";
    obj.disabled=true;
    document.uploadForm.submit() ;  
}  

</script>
</body>
</html>
