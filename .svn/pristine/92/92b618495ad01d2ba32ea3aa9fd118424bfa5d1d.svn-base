<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.entity.yl.shop.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}
int sid=h.getInt("sid");
int data_id=h.getInt("data_id");
ShopProduct_data_list sd=ShopProduct_data_list.find(sid);

String nexturl = h.get("nexturl");

%><!DOCTYPE html><html><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/tea/ckeditor/ckeditor.js"></script>
</head>
<body>
<h1>添加/编辑</h1>

<form name="form1" action="/ShopProductDatalists.do" method="post" enctype="multipart/form-data" target="_ajax" onsubmit="return mt.check(this)">
<input type="hidden" name="data_id" value="<%=data_id%>"/>
<input type="hidden" name="sid" value="<%=sid%>"/>
<input type="hidden" name="act" value="edit"/>
<input type="hidden" name="nexturl" value="<%=nexturl%>"/>

<table id="tablecenter" cellspacing="0">
  
  <tr>
    <td>标题</td>
    <td><input type="text" alt="标题" name="title" value="<%=MT.f(sd.title)%>"></td> 
  </tr>
  <tr>
    <td>详情logo</td>
    <td><input type="file" name="logo" value=""/>
    <%if(sd.logo != 0){ out.print("<a href="+Attch.find(sd.logo).path+"  target=_blank>"+Attch.find(sd.logo).length+"</a>字节");%><INPUT  id=CHECKBOX type="CHECKBOX" NAME=logoclear VALUE="1"  onclick='form1.logo.disabled=this.checked'>清空<%} %>
      </td>
  </tr>
  <tr>
    <td>附件</td>
    <td><input type="file" name="attch" value=""/>
    <%if(sd.attch != 0){ out.print("<a href="+Attch.find(sd.attch).path+"  target=_blank>"+Attch.find(sd.attch).length+"</a>字节");%><INPUT  id=CHECKBOX type="CHECKBOX" NAME=attchclear VALUE="1"  onclick='form1.logo.disabled=this.checked'>清空<%} %>
      </td>
  </tr>
   <%-- <tr>
    <td>产品详情相关摘要</td>
    <td><textarea type="text" name="brief" rows="5" cols="100"><%=MT.f(sd.brief)%></textarea></td> 
  </tr> --%>
   <tr>
    <td>产品详情相关明细</td>
    <td><textarea type="text" name="content" style="display: none" class="ckeditor"><%=MT.f(sd.content)%></textarea></td> 
  </tr>
 
</table>

<br/>
	<button class="btn btn-primary" type="submit">提交</button>&nbsp;&nbsp;&nbsp;&nbsp;
    <button class="btn btn-default" type="button" onclick="location='<%=nexturl%>'">返回</button>
</form>

<script>
mt.focus(form1);

function checkFile(){  
    //用元素的id获得该元素的值，从而进行判断选择的文件是否合法  
    var file = form1.logo.value ;  
    if(file==null||file==""){  
        mt.show("你还没有选择任何文件，不能上传!") ;  
        return false;  
    }  
    if(file.lastIndexOf(".")==-1){  
    	mt.show("路径不正确!") ;  
        return false;  
    }  
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
