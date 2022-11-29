<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.entity.yl.shop.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}
int sid=h.getInt("sid");
int category=h.getInt("category");
ShopProduct_data sd=ShopProduct_data.find(sid);

String nexturl = h.get("nexturl");

%><!DOCTYPE html><html><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/tea/ckeditor/ckeditor.js"></script>
</head>
<body>
<h1>添加/编辑</h1>

<form name="form1" action="/ShopProductDatas.do" method="post" enctype="multipart/form-data" target="_ajax" onsubmit="return mt.check(this)&&checkFile()">
<input type="hidden" name="category" value="<%=category%>"/>
<input type="hidden" name="sid" value="<%=sid%>"/>
<input type="hidden" name="act" value="edit"/>
<input type="hidden" name="nexturl" value="<%=nexturl%>"/>

<input type="hidden" name="type" value="0"/>
<input type="hidden" name="showtype" value="0"/>

<table id="tablecenter" cellspacing="0">
  <tr>
    <td>标题</td>
    <td><input type="text" alt="标题" name="title" value="<%=MT.f(sd.title)%>"></td> 
  </tr>
  <%-- <tr id="logoTr">
    <td>分类详情logo</td>
    <td><input type="file" name="logo" value=""/>
    <%if(sd.logo != 0){ out.print("<a href="+Attch.find(sd.logo).path+"  target=_blank>"+Attch.find(sd.logo).length+"</a>字节");%><INPUT  id=CHECKBOX type="CHECKBOX" NAME=clear VALUE="1"  onclick='form1.logo.disabled=this.checked'>清空<%} %>
      </td>
  </tr> --%>
   <%-- <tr id="briefTr">
    <td>分类详情摘要</td>
    <td><textarea type="text" name="brief" rows="5" cols="100"><%=MT.f(sd.brief)%></textarea></td> 
  </tr> --%>
   <tr id="contentTr">
    <td>描述</td>
    <td><textarea type="text" name="content" style="display: none" class="ckeditor"><%=MT.f(sd.content)%></textarea></td> 
  </tr>
 
</table>

<br/>
	<button class="btn btn-primary" type="submit">提交</button>&nbsp;&nbsp;&nbsp;&nbsp;
    <button class="btn btn-default" type="button" onclick="location='<%=nexturl%>&nexturl=/jsp/yl/shop/ShopCategoryList.jsp?category=<%= category%>'">返回</button>
</form>

<script>
mt.focus(form1);

function typeOnclick(){
	var typeVal;	
	var chkObjs = document.getElementsByName("type");
	for(var i=0;i<chkObjs.length;i++){
	    if(chkObjs[i].checked){
	   	 typeVal = i;
	        break;
	    }
	}
	if(typeVal==1){
		document.getElementById("briefTr").style.display="none";
		document.getElementById("contentTr").style.display="none";
		document.getElementById("showtype0").style.display="none";
		document.getElementById('showtype1').childNodes[0].checked=true;
	}else{
		document.getElementById("briefTr").style.display="table-row";
		document.getElementById("contentTr").style.display="table-row";
		document.getElementById("showtype0").style.display="table-row";
	}
	reLogo();
}
typeOnclick();

function reLogo(){
	var typeVal;
	var showtypeVal;
	var chkObjs = document.getElementsByName("type");
	var chkObjs2 = document.getElementsByName("showtype");
	for(var i=0;i<chkObjs.length;i++){
	    if(chkObjs[i].checked){
	   	 	typeVal = i;
	        break;
	    }
	}
	
	for(var i=0;i<chkObjs2.length;i++){
	    if(chkObjs2[i].checked){
	    	showtypeVal = i;
	        break;
	    }
	}
	if(typeVal==0&&showtypeVal==0)
		document.getElementById("logoTr").style.display="table-row";
	else
		document.getElementById("logoTr").style.display="none";
}
reLogo();

function checkFile(){  
    //用元素的id获得该元素的值，从而进行判断选择的文件是否合法  
    var file = form1.logo.value;
    
    var allImgExt = ".jpg|.png|.gif|" ;  
    var extName = file.substring(file.lastIndexOf(".")) ;  
    if(allImgExt.indexOf(extName+"|")==-1){  
        errMsg="该文件类型不允许上传。请上传 "+allImgExt+" 类型的文件，当前文件类型为"+extName;  
        mt.show(errMsg);  
        return false;  
    }
}

</script>

</body>
</html>
