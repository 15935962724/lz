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
<h1>关联医院</h1>
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
<tr>
<th width='60'><label><input type="checkbox" id="all" />全选</label></th>
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
<tr class="ggpage"><td colspan='8' align='right' id='ggpage'></td></tr>
</table>
</div><div class='mt15'><a class="btn btn-primary" type="button" onclick="myact('addJoinho','0')">添加</a>&nbsp;&nbsp;<a class="btn btn-primary" type="button" onclick="myact('delJoinhoAll','0')">批量删除</a>&nbsp;&nbsp;<a class="btn btn-default" type="button" onclick="history.back(-1)">返回</a></div>

</form>

<script type="text/javascript" >

form2.nexturl.value=location.pathname+location.search;
function loadlist(pos){
	mypos = pos;
    var listtb = new page.loadPage({"url":"/ProcurementUnitServlet.do?act=findShopHospital&"+$("#form1").serialize(),"callBackFunc":createList,'page_size':'10','type':2,'page_size_max':'10','par':myurl,'showtype':1,'pos':pos,'showfun':loadlist});
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
			var boxDiv = $("<tr></tr>");
			var $name = $("<td><input type='checkbox' value='"+proObj.obj.id+"' name='joinHosp' /></td><td>"+(parseInt(i)+1+parseInt(mypos))+"</td><td>"+proObj.obj.name+"</td><td>"+proObj.obj.htype+"</td><td>"+proObj.obj.hgrader+"</td><td>"+proObj.obj.area_name+"</td><td>"+(proObj.obj.isstoporder==0?"<span>否</span>":"<span  style='color:red'>是</span>")+"</td><td><button type='button' class='btn btn-link' onclick=myact('del','"+proObj.obj.id+"')>删除</button></td>");
			boxDiv.append($name);
			listDiv.append(boxDiv);
		}
	}else{
		listDiv.append("<tr><td colspan='8' align='center'>暂无关联医院</td></tr>");
	}

}
//mtDiag.show("修改成功!");
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
  if(a=='joinho'){

      fn.ajax("/ProcurementUnitServlet.do",{"act":"joinHosp","puid":puid,"checkList":checkList,"checkNoList":checkNoList},function(data){
          if(data.type==0){
              mtDiag.show("操作执行成功!","alert",null,function(index){
                  parent.lary.close();
              });
          }else{
              mtDiag.show("系统异常，请重试!","msg");
          }
      });
  }
  if(a=="addJoinho"){
      layer.open({
          type: 2,
          title: '添加关联医院',
          shadeClose: true,
          area: ['80%', '80%'],
          closeBtn:1,
          content: '/jsp/yl/shop/AddJoinHospitals.jsp?puid='+puid, //iframe的url /jsp/yl/shop/ExpExcel.jsp
          end: function () {
              location.reload();
          }
      });
  }else if(a=="del"){
      mtDiag.show("您确定要移除关联医院吗?","confirm",function(){
          var checkNoList = ","+id;
          fn.ajax("/ProcurementUnitServlet.do",{"act":"joinHosp","puid":puid,"checkNoList":checkNoList},function(data){
              if(data.type==0){
                  mtDiag.show("操作执行成功!","alert",null,function (index) {
                      mtDiag.close();
                      loadlist(0);
                  });
              }else{
                  mtDiag.show("系统异常，请重试!","msg");
              }
          })
      },function(){
          mtDiag.show("取消移除!","msg");
      })

  }else if(a=="delJoinhoAll"){
      mtDiag.show("您确定要移除关联医院吗?","confirm",function(){
          var checkNoList = "";
          $("input:checkbox[name='joinHosp']").each(function(){
              if($(this).is(":checked")){
                  checkNoList += ",";
                  checkNoList += $(this).val();
              }
              console.log(checkNoList);
              if(checkNoList != "" && checkNoList != ","){
                  fn.ajax("/ProcurementUnitServlet.do",{"act":"joinHosp","puid":puid,"checkNoList":checkNoList},function(data){
                      if(data.type==0){
                          mtDiag.show("操作执行成功!","alert",null,function (index) {
                              mtDiag.close();
                              loadlist(0);
                              $("#all").prop("checked",false);
                          });
                      }else{
                          mtDiag.show("系统异常，请重试!","msg");
                      }
                  })
              }else{
                  mtDiag.show("未选择数据!","msg");
              }
          });
      },function(){
          mtDiag.show("取消移除!","msg");
      });

  }
}
</script>
</body>
</html>
