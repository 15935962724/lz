<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%><%@page import="tea.entity.*"%><%@page import="tea.ui.*"%><%@page import="tea.entity.sup.*"%>
<%@page import="tea.entity.yl.shop.ShopHospital"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}






%><html>
<head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/yl/jquery-1.7.js"></script>
<script src="/tea/yl/top.js"></script>
<!-- <script src="/tea/mt.js" type="text/javascript"></script>
<script src='/tea/jquery.js'></script> -->
</head>
<body >
<h1>医院管理</h1>

<form id='form1' name="form1" action="/ShopHospitals.do" method="post" target="_ajax" onSubmit="return mt.check(this)">
<input type="hidden" name="hid" value=""/>
<input type="hidden" name="nexturl" value=""/>
<!-- <input type="hidden" name="act" value="edit"/> -->
<input type="hidden" name="area_name" value=""/>
<input type="hidden" name="addflag" value=""/>
<input type="hidden" name="issign" value="" />
<table id="tablecenter">
  <tr>
    <td align="right">医院名称：</td>
    <td><input name="name" value="" readonly size="31" alt="名称"/></td>
  </tr>
  <tr>
  	<td>省（自治区/直辖市）:</td>
 		<td><select class="province_select" autocomplete="off" id="_area" name="area" onchange="selectArea()" >
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
  </tr>
  <tr>
  	<td>医院类别:</td>
	<td><select name="htype" id="_htype">
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
  </tr>
  <tr>
  	<td>医院等级:</td>
	<td><select name="hgrader" id="_hgrader">
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
  	<td>未回款预警值:</td>
	<td><input type="text" name="noreplywarn" value="" onkeyup="value=value.replace(/[^\d]/g,'')"/></td>
  </tr>
  <tr>
  	<td>未回款报警值:</td>
	<td><input type="text" name="noreplyalarm" value=""  onkeyup="value=value.replace(/[^\d]/g,'')"/></td>
  </tr>
  <tr>
  	<td>未开票粒子数预警值:</td>
	<td><input type="text" name="noinvoicewarn" value=""  onkeyup="value=value.replace(/[^\d]/g,'')"/></td>
  </tr>
  <tr>
  	<td>未开票粒子数报警值:</td>
	<td><input type="text" name="noinvoicealarm" value=""  onkeyup="value=value.replace(/[^\d]/g,'')"/></td>
  </tr>
  <tr>
  	<td>是否停止订货:</td>
	<td></td>
  </tr>
</table>
    <button class="btn btn-primary" type="button" onclick="fnedit()">提交</button>&nbsp;&nbsp;&nbsp;&nbsp;
    <%-- <%
    	if(sh.getIsstoporder()==0){
    		out.print("<button class='btn btn-primary' onclick=\"mt.act('stoporder',"+sh.getId()+")\">停止订货</button>");
    	}else{
    		out.print("<button class='btn btn-primary' onclick=\"mt.act('nostoporder',"+sh.getId()+")\">取消停止订货</button>");
    	}
    %> --%>
    <button class="btn btn-default" type="button" onclick="location=''">返回</button>
</form>

<script type="text/javascript">

var hid = getParam("id");
var nexturl = getParam("nexturl");
form1.nexturl.value = decodeURIComponent(nexturl);
form1.hid.value = hid;


fn.ajax("/ShopHospitals.do?act=findHosp","hid="+hid,function(data){
	//console.log(data);
	if(data.type>0){
		if(data.type==1){
			//location = '/html/gf/index.html?nexturl='+encodeURIComponent(window.location.pathname+window.location.search);
			return;
		}
		mtDiag.close();
		mtDiag.show(data.mes);
		return;
	}else{
		form1.name.value = data.obj.name;
		form1.area.value = data.obj.area;
		form1.htype.value = data.obj.htype;
		form1.hgrader.value = data.obj.hgrader;
		form1.noreplywarn.value = data.obj.noreplywarn;
		form1.noreplyalarm.value = data.obj.noreplyalarm;
		form1.noinvoicealarm.value = data.obj.noinvoicealarm;
		
		form1.area_name.value = data.obj.area_name;
		form1.addflag.value = data.obj.addflag;
		form1.issign.value = data.obj.issign;
	}
});


//form1.nexturl.value=location.pathname+location.search;
/* mt.act=function(a,id)
{
  form1.act.value=a;
  form1.id.value=id;
  
  form1.submit();
}; */
	//给地区名称area_name赋值
	/* function selectArea(){
		var selectIndex = document.getElementById("_area").selectedIndex;//获得是第几个被选中了
		var selectText = document.getElementById("_area").options[selectIndex].text //获得被选中的项目的文本
		form1.area_name.value = selectText;
	}

	//初始
	function changeSelected(){
		changeAreaSelected();
		changeHtypeSelected();
		changeHgraderSelected();
	} */
    //省市
    <%-- function changeAreaSelected(){  
    	var selectedValue = '<%= sh.getArea()%>';  
        jsSelectItemByValue(document.getElementById("_area"),selectedValue);  
    }

    //医院类型
     function changeHtypeSelected(){  
    	var selectedValue = '<%= sh.getHtype()%>';  
        jsSelectItemByValue(document.getElementById("_htype"),selectedValue);  
    }

    //医院等级
     function changeHgraderSelected(){  
    	var selectedValue = '<%= sh.getHgrader()%>';  
        jsSelectItemByValue(document.getElementById("_hgrader"),selectedValue);  
    } --%>

    //控制select option是否选中
    function jsSelectItemByValue(objSelect,objItem) {  
        for(var i=0;i<objSelect.options.length;i++) {  
            if(objSelect.options[i].value == objItem) {  
                objSelect.options[i].selected = true;  
                break;  
            }  
        }  
    }
    function fnedit(){
    	fn.ajax("/ShopHospitals.do?act=editHosp",$("#form1").serialize(),function(data){
    		//console.log(data);
    		if(data.type>0){
    			if(data.type==1){
    				//location = '/html/gf/index.html?nexturl='+encodeURIComponent(window.location.pathname+window.location.search);
    				return;
    			}
    			mtDiag.close();
    			mtDiag.show(data.mes);
    			return;
    		}else{
    			mtDiag.show("操作成功！","alert",null,form1.nexturl.value);//点击确定后，跳转到首页
    		}
    	});
    	//form1.submit();
    	<%-- var oldnoinvoice=$("#oldnoinvoice").val();
    	
    	var oldnoreply=$("#oldnoreply").val();
    	var timespot=$("#timespot").val();
    	
    	if(oldnoinvoice!=''&&timespot!=''){
    		
    		mt.send("/ShopHospitals.do?act=checkinvoice&timespot="+timespot+"&hospitalid=<%=id %>",function(d)
    				{
    		
    					        if(d=='1')
    					        {
    					        	
    					        	mt.show("尚有该医院未处理的发票，不能提交未开票粒子数、应收账款和日期节点！");
    					        	
    					        }else{
    					        	form1.submit();
    					        }
    					    });
    	} --%>
    	
    	
    }
    
</script>
</body>
</html>
