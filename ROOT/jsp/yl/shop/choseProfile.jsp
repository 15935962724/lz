<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.yl.shop.*"%><%@page import="tea.db.*"%><%@page import="tea.ui.yl.shop.*"%>
<%@page import="tea.entity.sup.*"%><%@page import="tea.entity.admin.*"%>
<%@page import="tea.entity.*"%>
<%@page import="util.DateUtil"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}
int puid = h.getInt("puid");

%>
<!DOCTYPE html><html><head>

<!-- <script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/jsp/sup/sup.js" type="text/javascript"></script> -->
<!-- <script src="/tea/jquery.js" type="text/javascript"></script> -->
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/yl/jquery-1.7.js"></script>
<script src="/tea/yl/top.js"></script>
<style>
    .mytab{
        cursor: pointer;
    }
</style>
</head>
<body>
<div id="head6"><img height="6" src="about:blank"></div>
<form id='form1' name="form1" action="?" >
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="puid" value="<%= puid %>"/>

<table id="tablecenter" cellspacing="0">

  	<tr>
        <td><input type="text" name="member" value="" />　<button class="btn btn-primary" onclick="findhosp()" type="button">查询</button></td>
	</tr>
</table>
</form>

<form name="form2" action="/ServiceInvoices.do" method="post" target="_ajax">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="puid" value="<%= puid %>"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>

<div class='radiusBox'>
<table cellspacing="0" class='newTable'>
<thead>
<tr><td colspan='20'>列表<span class='sum'></span></td></tr>
</thead>
<tr>
  <th width='60'>序号</th>
  <th>服务商名称</th>
  <th>手机号</th>
  <th>电子邮箱</th>
  <%--<th>公司名称</th>--%>
</tr>
<tbody class='mytab'>
	
</tbody>
<tr class="ggpage"><td colspan='5' align='right' id='ggpage'></td></tr>
</table>
</div>


</form>

<script type="text/javascript" >

form2.nexturl.value=location.pathname+location.search;

function loadlist(pos){
	mypos = pos;
    var listtb = new page.loadPage({"url":"/ServiceInvoices.do?act=joinProfile&"+$("#form1").serialize(),"callBackFunc":createList,'page_size':'10','type':2,'page_size_max':'10','par':myurl,'showtype':1,'pos':pos,'showfun':loadlist});
	listtb.show();
}
loadlist(0);

function findhosp(){
	loadlist(0);
}
//待办
function createList(resultlist){
    if(resultlist.sum<=10){
        $(".ggpage").hide();
    }
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
			var boxDiv = $("<tr class='transmit'></tr>");
			var $name = $("<td>"+(parseInt(i)+1+parseInt(mypos))+"</td><td class='proflie' style='display:none;'>"+proObj.profile+"</td><td class='member'>"+proObj.member+"</td><td>"+proObj.mobile+"</td><td>"+proObj.email+"</td>");//<td>"+proObj.company+"</td>
			boxDiv.append($name);
			listDiv.append(boxDiv);
		}
	}else{
		listDiv.append("<tr><td colspan='5' align='center'>暂无关联服务商</td></tr>");
	}
    var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
    $('.transmit').on('click', function(){
        var profile = $(this).children(".proflie").text();
        parent.location.href="/jsp/yl/shop/mateInvoices.jsp?puid=<%=puid%>&profile="+profile;
        parent.layer.close(index);

    });

}

</script>
</body>
</html>
