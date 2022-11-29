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
/*
String act=h.get("act");
if("action".equals(act))
{
  out.print("oper");
  return;
}*/

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
<h1>医院管理</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form id='form1' name="form1" action="?" >
<input type="hidden" name="community" value="<%=h.community%>"/>
<table id="tablecenter" cellspacing="0">
	<tr>
  		<td>省（自治区/直辖市）:</td>
  		<td><select class="province_select" autocomplete="off" name="area" >
			<option value="">请选择省（自治区/直辖市）</option>
			<option value="7180">北京市</option>
			<option value="7182">天津市</option>
			<option value="7184">河北省</option>
			<option value="7186">山西省</option>
			<option value="7188">内蒙古自治区</option>
			<option value="7190">辽宁省</option>
			<option value="7192">吉林省</option>
			<option value="7194">黑龙江省</option>
			<option value="7196">上海市</option>
			<option value="7198">江苏省</option>
			<option value="7200">浙江省</option>
			<option value="7202">安徽省</option>
			<option value="7204">福建省</option>
			<option value="7206">江西省</option>
			<option value="7208">山东省</option>
			<option value="7210">河南省</option>
			<option value="7212">湖北省</option>
			<option value="7214">湖南省</option>
			<option value="7216">广东省</option>
			<option value="7218">广西壮族自治区</option>
			<option value="7220">海南省</option>
			<option value="7222">重庆市</option>
			<option value="7224">四川省</option>
			<option value="7226">贵州省</option>
			<option value="7228">云南省</option>
			<option value="7230">西藏自治区</option>
			<option value="7232">陕西省</option>
			<option value="7234">甘肃省</option>
			<option value="7236">青海省</option>
			<option value="7238">宁夏回族自治区</option>
			<option value="7240">新疆维吾尔族自治区</option>
			<option value="21508">新疆生产建设兵团</option>
		</select></td>
		<td>医院类别:</td>
		<td><select name="htype">
			<option value="">请选择医院类别</option>		
			<option value="综合医院">综合医院</option>
			<option value="乡镇卫生院">乡镇卫生院</option>
			<option value="医学专科研究所">医学专科研究所</option>
			<option value="急救中心">急救中心</option>
			<option value="疗养院">疗养院</option>
			<option value="妇幼保健院">妇幼保健院</option>
			<option value="专科医院">专科医院</option>
			<option value="门诊部">门诊部</option>
			<option value="中西医结合医院">中西医结合医院</option>
			<option value="街道卫生院">街道卫生院</option>
			<option value="护理院(站)">护理院(站)</option>
			<option value="专科疾病防治所(站、中心)">专科疾病防治所(站、中心)</option>
			<option value="专科疾病防治院">专科疾病防治院</option>
			<option value="妇幼保健所">妇幼保健所</option>
			<option value="民族医院">民族医院</option>
			<option value="社区卫生服务中心">社区卫生服务中心</option>
			<option value="其他卫生事业机构">其他卫生事业机构</option>
		</select></td>
		<td>医院等级:</td>
		<td><select name="hgrader">
			<option value="">请选择医院等级</option>
			<option value="二级">二级</option>
			<option value="二级二级">二级二级</option>
			<option value="二级甲等">二级甲等</option>
			<option value="二级乙等">二级乙等</option>
			<option value="二级丙等">二级丙等</option>
			<option value="二级未评">二级未评</option>
			<option value="二级其他">二级其他</option>
			<option value="三级甲等">三级甲等</option>
			<option value="三级乙等">三级乙等</option>
			<option value="三级未评">三级未评</option>
			<option value="三级其他">三级其他</option>
			<option value="三级未定等">三级未定等</option>
		</select></td>
  	</tr>
  	<tr>
  		<td>到期日-期限:</td>
		<td><select name="deadline">
			<option value="">请选择</option>
			<option value="1">1天</option>
			<option value="5">5天内</option>
			<option value="30">1个月内</option>
		</select></td>
		<td>是否设置了20天前有无签收订单</td>
		<td>
			<select name="issign">
				<option value="-1">请选择</option>
				<option value="1"
				>是</option>
				<option value="0"
				>否</option>
			</select>
		</td>
  	</tr>
  	<tr>
  		<td colspan="8" align="center"><button class="btn btn-primary" onclick="findhosp()" type="button">查询</button></td>
	</tr>
</table>
</form>

<form name="form2" action="/ShopHospitals.do" method="post" target="_ajax">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="id"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>

<div class='radiusBox'>
<table cellspacing="0" class='newTable'>
<thead>
<tr><td colspan='20'>列表<span class='sum'></span></td></tr>
</thead>
<tr>
<th><input type="checkbox" id="all"/>全选</th>
  <th width='60'>序号</th>
  <th>医院名称</th>
  <th>医院类别</th>
  <th>医院等级</th>
  <th>省（自治区/直辖市）</th>
  <th>到期日期</th>
  <th>剩余天数</th>
  <th>是否设置了20天前有无签收订单</th>
  <th>是否停止订货</th>
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
	var listtb = new page.loadPage({"url":"/ShopHospitals.do?act=findShopHospital&"+$("#form1").serialize(),"callBackFunc":createList,'page_size':'10','type':2,'page_size_max':'10','par':myurl,'showtype':1,'pos':pos,'showfun':loadlist});
	listtb.show();
}
loadlist(0);

function findhosp(){
	loadlist(0);
}
//待办
function createList(resultlist){
	if(resultlist.type==1){
		//location = '/html/gf/index.html?nexturl='+encodeURIComponent(window.location.pathname+window.location.search);
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
			var $name = $("<td><input type='checkbox' /></td><td>"+(parseInt(i)+1+parseInt(mypos))+"</td><td>"+proObj.obj.name+"</td><td><button type='button' class='btn btn-link' onclick=myact('edit','"+proObj.obj.id+"')>编辑</button></td>");
			boxDiv.append($name);
			listDiv.append(boxDiv);
		}
	}else{
		listDiv.append("<tr><td colspan='4'>暂无医院</td></tr>");
	}
}
//mtDiag.show("修改成功!");

function myact(a,id){
  form2.act.value=a;
  form2.id.value=id;
  if(a=='del')
  {
    mt.show('你确定要删除吗？',2,'form2.submit()');
  }else
  {
    if(a=='view'){
      form2.action='';
      form2.target=form2.method='';
      form2.submit();
    }else if(a=='edit'){
      form2.action='/jsp/yl/shop/ShopHospitalsEdit1.jsp';
      form2.target=form2.method='';
      form2.submit();
	}
    	
    
  }
}
</script>
</body>
</html>
