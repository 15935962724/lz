<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.yl.shop.*"%><%@page import="tea.db.*"%><%@page import="tea.ui.yl.shop.*"%>
<%@page import="tea.entity.sup.*"%><%@page import="tea.entity.admin.*"%>
<%@page import="tea.entity.*"%>
<%@page import="util.DateUtil"%>
<%@ page import="util.Config" %><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}
/*
String act=h.get("act");
if("action".equals(act))
{
  out.print("oper");
  return;
}*/
    StringBuffer sql=new StringBuffer(),par=new StringBuffer();
    String name = h.get("name");
    if(!"".equals(name) && name != null){
        sql.append(" AND name like'%" + name + "%'");
        par.append("&name="+name);
    }

    int pos=h.getInt("pos");
    par.append("&pos=");

    int sum=ProcurementUnit.count(sql.toString());
    String acts=h.get("acts","");

%>
<!DOCTYPE html><html><head>

<!-- <script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/jsp/sup/sup.js" type="text/javascript"></script> -->
<!-- <script src="/tea/jquery.js" type="text/javascript"></script> -->
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/yl/jquery-1.7.js"></script>
<script src="/tea/yl/top.js"></script>

</head>
<body>
<h1>短信设置</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form id='form1' name="form1" action="?" >
<input type="hidden" name="community" value="<%=h.community%>"/>
<table id="tablecenter" cellspacing="0">

  	<tr>
        <td><input type="text" name="name" value="<%= MT.f(name)%>" />　<button class="btn btn-primary" onclick="findhosp()" type="button">查询</button></td>
	</tr>
</table>
</form>

<form name="form2" action="/ProcurementUnitServlet.do" method="post" target="_ajax">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="puid"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>

<div class='radiusBox'>
    <table cellspacing="0" class='newTable'>
        <thead>
            <tr><td colspan='20'>列表<span class='sum'></span></td></tr>
        </thead>
        <tr>

            <th width='60'>序号</th>
            <th>厂商名称</th>
            <th>创建日期</th>
            <th>排序</th>
            <th>操作</th>
        </tr>
        <tbody class='mytab'>

        </tbody>
        <tr><td colspan='10' align='right' id='ggpage'></td></tr>
    </table>
</div>


</form>

<script type="text/javascript" >
form2.nexturl.value=location.pathname+location.search;
function loadlist(pos){
	mypos = pos;
	var listtb = new page.loadPage({"url":"/ProcurementUnitServlet.do?act=findProcurementUnit&"+$("#form1").serialize(),"callBackFunc":createList,'page_size':'10','type':2,'page_size_max':'10','par':myurl,'showtype':1,'pos':pos,'showfun':loadlist});
	listtb.show();
}
loadlist(0);

function findhosp(){
	loadlist(0);
}
//待办
function createList(resultlist){
	if(resultlist.type==1){
		return;
	}
	if(resultlist.type==2){
		mtDiag.show(resultlist.mes);
		return;
	}
	$(".sum").html(resultlist.sum);
	var listDiv = $(".mytab");
	listDiv.html("");
	if(resultlist.data_list!=''){//是否存在数据
		for(var i=0;i<resultlist.data_list.length;i++){
			var proObj = resultlist.data_list[i];
			var boxDiv = $("<tr></tr>");
			var $name = $("<td>"+(parseInt(i)+1+parseInt(mypos))+"</td><td>"+proObj.obj.name+"</td><td>"+proObj.obj.time+"</td><td>"+proObj.obj.sort+"</td><td><button type='button' class='btn btn-link' onclick=myact('edit','"+proObj.obj.puid+"')>编辑</button></td>");
			boxDiv.append($name);
			listDiv.append(boxDiv);
		}
	}else{
		listDiv.append("<tr><td colspan='9'>暂无厂商</td></tr>");
	}
}
//mtDiag.show("修改成功!");

function myact(a,id){
  form2.act.value=a;
  form2.puid.value=id;
  form2.nexturl.value = "/jsp/yl/shop/ProcurementUnit.jsp";

    if(a=='edit'){
      form2.action='/jsp/yl/shop/ShopSMSSetting.jsp?puid='+id;
      form2.target=form2.method='';
      form2.submit();
	}
}
</script>
</body>
</html>
