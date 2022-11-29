<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.entity.yl.shop.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}
int sid=h.getInt("sid");
int product=h.getInt("product");
int tab=h.getInt("tab");
ShopProduct_data sd=ShopProduct_data.find(sid);

String nexturl = h.get("nexturl");
nexturl += "&product="+product+"&tab="+tab;

%><!DOCTYPE html><html><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/tea/ckeditor/ckeditor.js"></script>
</head>
<body>
<h1>添加/编辑</h1>

<form name="form1" action="/ShopProductDatas.do" method="post" enctype="multipart/form-data" target="_ajax" onsubmit="return mt.check(this)">
<input type="hidden" name="product_id" value="<%=product%>"/>
<input type="hidden" name="sid" value="<%=sid%>"/>
<input type="hidden" name="act" value="edit"/>
<input type="hidden" name="nexturl" value="<%=nexturl%>"/>

<table id="tablecenter" cellspacing="0">
  <tr>
    <td width="10%">产品详情类型</td>
    <td><input type="radio" name="type" value="0" onclick="typeOnclick()" <%=sd.type==0?"checked":"" %>>文章<input type="radio" value="1" name="type" onclick="typeOnclick()" <%=sd.type==1?"checked":"" %>>列表</td> 
  </tr>
  <tr>
    <td>产品详情标题</td>
    <td><input type="text" alt="标题" name="title" value="<%=MT.f(sd.title)%>"></td> 
  </tr>
  <%-- <tr id="logoTr">
    <td>产品详情logo</td>
    <td><input type="file" name="logo" value=""/>
    <%if(sd.logo != 0){ out.print("<a href="+Attch.find(sd.logo).path+"  target=_blank>"+Attch.find(sd.logo).length+"</a>字节");%><INPUT  id=CHECKBOX type="CHECKBOX" NAME=clear VALUE="1"  onclick='form1.logo.disabled=this.checked'>清空<%} %>
      </td>
  </tr> --%>
   <%-- <tr id="briefTr">
    <td>产品详情摘要</td>
    <td><textarea type="text" name="brief" rows="5" cols="100"><%=MT.f(sd.brief)%></textarea></td> 
  </tr> --%>
   <tr id="contentTr">
    <td>产品详情明细</td>
    <td><textarea type="text" name="content" style="display: none" class="ckeditor"><%=MT.f(sd.content)%></textarea></td> 
  </tr>
 
</table>

<div class="center mt15">
	<button class="btn btn-primary" type="submit">提交</button>&nbsp;&nbsp;&nbsp;&nbsp;
    <button class="btn btn-default" type="button" onclick="location='<%=nexturl%>'">返回</button></div>
</form>

<script>
mt.focus(form1);

typeOnclick();
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
		//document.getElementById("briefTr").style.display="none";
		document.getElementById("contentTr").style.display="none";
	}else{
		//document.getElementById("briefTr").style.display="table-row";
		document.getElementById("contentTr").style.display="table-row";
	}
}

</script>

</body>
</html>
