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

</head>
<body>
<div id="head6"><img height="6" src="about:blank"></div>
<form id='form1' name="form1" action="?" >
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="puid" value="<%= puid %>"/>

<table id="tablecenter" cellspacing="0">

  	<tr>
        <td><input type="text" name="name" value="" />　<button class="btn btn-primary" onclick="findhosp()" type="button">查询</button></td>
	</tr>
</table>
</form>

<form name="form2" action="/ProcurementUnitServlet.do" method="post" target="_ajax">
<input type="hidden" name="community" value="<%=h.community%>"/>
    <input type="hidden" name="puid" value="<%= puid %>"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>

<div class='radiusBox'>
<table cellspacing="0" class='newTable'>
<thead>
<tr><td colspan='20'>列表<span class='sum'></span></td></tr>
</thead>
<tr><th width='60'><label><input type="checkbox" id="all" />全选</label>  </th>
    <th width='60'>序号</th>
    <th>医院名称</th>
    <th>医院类别</th>
    <th>医院等级</th>
    <th>省(自治区/直辖市)</th>
    <th>是否停止供货</th>
  <th>操作</th>
</tr>
<tbody class='mytab'>
	
</tbody>
<tr><td colspan='8' align='right' id='ggpage'></td></tr>
</table>
</div><div class='mt15'><a class="btn btn-primary" type="button" onclick="myact('addJoinhoAll','0')">批量添加</a></div>

</form>

<script type="text/javascript" >
form2.nexturl.value=location.pathname+location.search;
function loadlist(pos){
	mypos = pos;
    var listtb = new page.loadPage({"url":"/ProcurementUnitServlet.do?act=findShopHospitalNo&"+$("#form1").serialize(),"callBackFunc":createList,'page_size':'10','type':2,'page_size_max':'10','par':myurl,'showtype':1,'pos':pos,'showfun':loadlist});
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
			var $name = $("<td><input type='checkbox' value='"+proObj.obj.id+"' name='joinHosp' /></td><td>"+(parseInt(i)+1+parseInt(mypos))+"</td><td>"+proObj.obj.name+"</td><td>"+proObj.obj.htype+"</td><td>"+proObj.obj.hgrader+"</td><td>"+proObj.obj.area_name+"</td><td>"+(proObj.obj.isstoporder==0?"<span>否</span>":"<span  style='color:red'>是</span>")+"</td><td><button type='button' class='btn btn-link' onclick=myact('addJoinho','"+proObj.obj.id+"')>关联</button></td>");
			boxDiv.append($name);
			listDiv.append(boxDiv);
		}
	}else{
		listDiv.append("<tr><td colspan='8' align='center'>暂无医院</td></tr>");
	}
}
$("#all").change(function(){
    var flage =$(this).is(":checked");
    $("input[name='joinHosp']").each(function(){
        $(this).prop("checked",flage);
    })
});
function myact(a,id){
  var puid = getParam("puid");
  form2.act.value=a;
  form2.nexturl.value = "/jsp/yl/shop/ProcurementUnit.jsp";
  if(a=='addJoinho'){

      var checkList = ","+id;

      fn.ajax("/ProcurementUnitServlet.do",{"act":"joinHosp","puid":puid,"checkList":checkList},function(data){
          if(data.type==0){
              mtDiag.show("操作执行成功!","msg",500);
              loadlist(0);
          }else{
              mtDiag.show("系统异常，请重试!","msg");
          }
      });
  }else if(a=="addJoinhoAll"){
      var checkList = "";
      $("input:checkbox[name='joinHosp']").each(function(){
          if($(this).is(":checked")){
              checkList += ",";
              checkList += $(this).val();
          }
          if (checkList != "" && checkList !=","){
              fn.ajax("/ProcurementUnitServlet.do",{"act":"joinHosp","puid":puid,"checkList":checkList},function(data){
                  if(data.type==0){
                      mtDiag.show("操作执行成功!","msg")
                      loadlist(0);
                      $("#all").prop("checked",false);
                  }else{
                      mtDiag.show("系统异常，请重试!","msg");
                  }
              });
          }else{
              mtDiag.show("未选择数据!","msg");
          }
      })
  }
}
</script>
</body>
</html>
