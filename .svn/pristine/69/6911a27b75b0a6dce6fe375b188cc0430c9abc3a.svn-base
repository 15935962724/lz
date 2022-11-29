<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%><%@page import="tea.entity.tobacco.*"%>
<%@page import="tea.entity.markplus.MarkPlus"%>
<%

Http h=new Http(request,response);
if(h.member < 1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}

int markplus=h.getInt("markplus");
MarkPlus t=MarkPlus.find(markplus);

%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body >
<h1>添加/编辑</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" action="/EditMarkPlus.do?repository=markplus" method="post" enctype="multipart/form-data" target="_ajax" onSubmit="if(mt.check(this)){mt.show(null,0);}return false;">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="markplus" value="<%=markplus%>"/>
<input type="hidden" name="act" value="edit"/>
<input type="hidden" name="nexturl" value="<%=h.get("nexturl")%>"/>

<table id="tablecenter" cellspacing="0">
  <tr>
    <td width="10%">名称</td>
    <td align="left"><input name="name" value="<%=MT.f(t.getName())%>" alt="名称"/></td>
  </tr>
  <tr>
  	<td width="10%">上传图片</td>
    <td align="left">
    	<input type="file" name="path" id="path" accept="*.jpg;*.png;*.gif" data='<%=t.getPath()%>'/>
			注：格式应为 *.jpg,*.png,*.gif。
    </td>
  </tr>
  <tr>
  	<td width="10%">单位</td>
    <td align="left"><input name="unit" value="<%=MT.f(t.getUnit())%>" alt="单位"/></td>
  </tr>
  <tr>
  	<td width="10%">顺序</td>
    <td align="left"><input name="sequence" onkeyup="this.value=this.value.replace(/\D/g,'')" value="<%=MT.f(t.getSequence())%>" alt="顺序"/></td>
  </tr>
</table>

<br/>
<input type="button" value="提交" onClick="checkFile(this);"/> <input type="button" value="返回" onclick="location=form1.nexturl.value;"/>
</form>

<script>
function checkFile(obj){
    //用元素的id获得该元素的值，从而进行判断选择的文件是否合法
    var file = document.form1.path.value;
    if(file==null||file==""){
    	var data = document.form1.path.data;
    	if(data<1){
    		alert("你还没有选择任何文件，不能上传!");
            return;
    	}        
    }else{
    	if(file.lastIndexOf(".")==-1){
            alert("路径不正确!") ;
            return ;
        }
        var allImgExt = ".jpg|.png|.gif|" ;
        var extName = file.substring(file.lastIndexOf(".")) ;
        if(allImgExt.indexOf(extName+"|")==-1){
            errMsg="该文件类型不允许上传。请上传 "+allImgExt+" 类型的文件，当前文件类型为"+extName;
            alert(errMsg);
            return;
        }
    }    
    //document.form1.target="_ajax";
    obj.disabled=true;
    document.form1.submit() ;
}
</script>
</body>
</html>
