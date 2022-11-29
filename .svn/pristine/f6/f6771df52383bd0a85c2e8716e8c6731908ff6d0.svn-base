<%@page contentType="text/html; charset=UTF-8"%><%@page import="tea.entity.Http"%>
<%@page import="tea.entity.MT"%><%@page import="tea.entity.admin.AdminUsrRole"%><%@page import="tea.entity.member.Profile"%>
<%@page import="tea.entity.yl.shop.ShopHospital"%><%@page import="util.Config"%>
<%@page import="util.DateUtil"%>
<%@page import="java.util.ArrayList"%>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.Iterator" %>
<%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}
	int gaoke = Config.getInt("gaokeuser");//获取高科角色的id
    int junan = Config.getInt("junanuser");//获取君安角色的id
    int roleid=0;
    ArrayList arrayList = AdminUsrRole.find("AND member=" + h.member + "AND role like '%/" + gaoke + "/%'", 0, Integer.MAX_VALUE);
    if(arrayList.size()>0){//gaoke
        roleid=1;
    }
    ArrayList arrayList2 = AdminUsrRole.find("AND member=" + h.member + "AND role like '%/" + junan + "/%'", 0, Integer.MAX_VALUE);
    if(arrayList2.size()>0){//junan
        roleid=2;
    }
/*
String act=h.get("act");
if("action".equals(act))
{
  out.print("oper");
  return;
}*/
StringBuffer sql=new StringBuffer(),par=new StringBuffer();


int menuid=h.getInt("id");
par.append("?community="+h.community+"&id="+menuid);

String name = h.get("name");
if(!"".equals(name) && name != null){
	sql.append(" AND name like'%" + name + "%'");
	par.append("&name="+name);
}
String h_code = h.get("h_code");
if(!"".equals(h_code) && h_code != null){
	sql.append(" AND h_code ='" + h_code + "'");
	par.append("&h_code="+h_code);
}
String area = h.get("area");
if(!"".equals(area) && area != null){
	sql.append(" AND area ='" + area + "'");
	par.append("&area="+area);
}
String htype = h.get("htype");
if(!"".equals(htype) && htype != null){
	sql.append(" AND htype ='" + htype + "'");	
	par.append("&htype="+htype);
}
String hgrader = h.get("hgrader");
if(!"".equals(hgrader) && hgrader != null){
	sql.append(" AND hgrader ='" + hgrader + "'");	
	par.append("&hgrader="+hgrader);
}
String deadline = h.get("deadline","");
if(!"".equals(deadline) && deadline != null){
	sql.append(" AND datediff(d,getdate(),expirationDate) <= "+deadline );
	par.append("&deadline="+deadline);
}
int issign=h.getInt("issign",-1);
if(issign!=-1){
	sql.append(" and issign="+issign);
	par.append("&issign="+issign);
}

int pos=h.getInt("pos");
par.append("&pos=");
    if(roleid==1){//高科订单管理员
        sql.append("AND invoicePuid="+Config.getInt("gaoke"));
    }else if(roleid==2){//君安订单管理员
        sql.append("AND invoicePuid="+Config.getInt("junan"));
    }

int sum=ShopHospital.count(sql.toString());
String acts=h.get("acts","");

%>
<!DOCTYPE html><html><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/jsp/sup/sup.js" type="text/javascript"></script>
<!-- <script src="/tea/jquery.js" type="text/javascript"></script> -->
<script src="/tea/jquery-1.11.1.min.js"></script>
<script src="/tea/yl/top.js"></script>
</head>
<body>
<h1>医院管理</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" action="?" >
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="id" value="<%=menuid%>"/>
<table id="tablecenter" cellspacing="0">
	<tr>
  		<td class="th">医院名称：</td><td><input name="name" value="<%= MT.f(name)%>"/></td>
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
			<option value=""  >请选择</option>
			<option value="1"  <%=deadline.equals("1")?"selected":""%>>1天</option>
			<option value="5"  <%=deadline.equals("5")?"selected":""%>>5天内</option>
			<option value="30" <%=deadline.equals("30")?"selected":""%>>1个月内</option>
		</select></td>
		<td>是否设置了20天前有无签收订单</td>
		<td>
			<select name="issign">
				<option value="-1">请选择</option>
				<option value="1"
				<%
					if(issign==1){
						out.print("selected");
					}
				%>
				>是</option>
				<option value="0"
				<%
					if(issign==0){
						out.print("selected");
					}
				%>
				>否</option>
			</select>
		</td>
		<td>客商编码:</td>
		<td><input name="h_code" value="<%= MT.f(h_code)%>"/></td>
		<td></td>
		<td></td>
  	</tr>
  	<tr>
  		<td align="center"><button class="btn btn-primary" type="submit">查询</button></td>
		<%
            Profile profile = Profile.find(h.member);

            if("webmaster".equals(profile.member)){//20200715李双瑞，只有超级管理员可见%>
		<td align="center"><button class="btn btn-primary" type="button" onclick="daochu()">导出</button></td >

		<%}%>
		<td colspan="6"></td>
	</tr>
</table>
</form>
<script>
//sup.hquery();
</script>

<form name="form2" action="/ShopHospitals.do" method="post" target="_ajax">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="id"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>

<div class='radiusBox'>
<table cellspacing="0" class='newTable'>
<thead>
<tr><td colspan='20'><span>列表 <%=sum%>&nbsp;</span><span class='mt15'><button class='btn btn-primary' type='button' onclick="mt.act('edit','0')">添加</button>&nbsp;<button id='button' onclick="mt.act('setissign','0')" class='btn btn-primary' type='button' disabled='disabled'>改变签收设置</button>
&nbsp;<button class='btn btn-primary' type='button' onclick="mt.act('expex','0')">导入医院</button>&nbsp;<button class='btn btn-primary' type='button' onclick="mt.act('crm_exp','0')">导入CRMID</button></span></td></tr>
</thead>
<tr>
<th><input type="checkbox" id="all"/>全选</th>
  <th width='60'>序号</th>
  <th>CRM编码</th>
  <th>医院名称</th>
  <th>医院类别</th>
  <th>医院等级</th>
  <th>省（自治区/直辖市）</th>
  <th>到期日期</th>
  <th>剩余天数</th>
  <th>是否设置了20天前有无签收订单</th>
  <th>是否停止订货</th>
  <th>医院服务商</th>
  <th>操作</th>
</tr>
<%
if(sum<1)
{
  out.print("<tr><td colspan='8' class='noCont'>暂无记录!</td></tr>");
}else
{
    if(roleid==0) {
		sql.append(" order by expirationDate ");
	}
  Iterator it=ShopHospital.find(sql.toString(),pos,15).iterator();
  for(int i=1+pos;it.hasNext();i++)
  {
    ShopHospital sh=(ShopHospital)it.next();
  %>
  <tr>
  	<td><input type="checkbox" name="issigns" value="<%=sh.getId() %>"/></td>
    <td align="center"><%=i %></td>
    <td><%=MT.f(sh.getHos_code()) %></td>
    <td><%=MT.f(sh.getName()) %></td>
    <td><%=MT.f(sh.getHtype()) %></td>
    <td><%=MT.f(sh.getHgrader()) %></td>
    <td align="center"><%=MT.f(sh.getArea_name())%></td>
    <td><%=MT.f(sh.getExpirationDate()) %></td>
    <td><%=sh.getExpirationDate()!=null?DateUtil.datesub2(sh.getExpirationDate(),new Date()):"-" %></td>
    <td><%=sh.getIssign()==0?"<span style='color:red'>否</span>":"<span>是</span>" %></td>
    <td><%=sh.getIsstoporder()==0?"<span>否</span>":"<span  style='color:red'>是</span>" %></td>

		<%
            int id = sh.getId();
            ArrayList arrayList1 = Profile.find1("AND hospitals like '%" + id + "%'", 0, 1);
            if (arrayList1.size()!=0){
                Profile p = (Profile) arrayList1.get(0);
                %>
      <td><%=MT.f(p.getMember())%></td>
            <%}else {%>
              <td></td>
            <%}
        %>

    <td nowrap><%
    //if(acts.contains("oper"))
    //{
      out.println("<button type=\"button\" class=\"btn btn-link\" onclick=\"mt.act('edit',"+sh.getId()+")\">编辑</button>");
      out.println("<button type=\"button\" class=\"btn btn-link\" onclick=\"mt.act('del',"+sh.getId()+")\">删除</button>");
      out.println("<button type=\"button\" class=\"btn btn-link\" onclick=\"mt.act('sign',"+sh.getId()+")\">设置签收人</button>");
      out.println("<button type=\"button\" class=\"btn btn-link\" onclick=\"mt.act('setissign',"+sh.getId()+")\">改变签收设置</button>");
      out.println("<button type=\"button\" class=\"btn btn-link\" onclick=\"mt.act('endtime',"+sh.getId()+")\">三期预设数据</button>");
      out.println("<button type=\"button\" class=\"btn btn-link\" onclick=\"mt.act('editname',"+sh.getId()+")\">变更医院名称</button>");
		if(sh.getIssign()==0){
			out.println("<button type=\"button\" class=\"btn btn-link\" onclick=\"mt.act('updateissign',"+sh.getId()+")\">设置未签收不可订</button>");
		}else {
			out.println("<button type=\"button\" class=\"btn btn-link\" onclick=\"mt.act('updateissign',"+sh.getId()+")\">设置未签收可订</button>");
		}
    //}
    %></td>
  </tr>
  <%
  }
  if(sum>15)out.print("<tr><td colspan='12' align='right'>"+new tea.htmlx.FPNL(h.language,par.toString(),pos,sum,15));
}%>
</table>
</div>
<%
//if(acts.contains("oper"))
	
%>

</form>
<form action="/ShopOrders.do" name="form3" method="post" target="_ajax">
	<input name="act" value="exp_yiyuan" type="hidden"/>
	<input name="puid" value="<%=roleid%>" type="hidden"/>

</form>
<script>

//全选操作
$("#all").click(function(){  
	
	if ($("#all").prop('checked')) {  
		
		  $(":checkbox").prop("checked", true);  
	} else {  
			
		  $(":checkbox").prop("checked", false);  
	}  
	var len = $("input:checkbox:checked").length; 
	if(len==0){
		$('#button').attr('disabled',"true");
		
	}else{
		$('#button').removeAttr("disabled"); 
	}
	
});
//单选操作
$("input[name='issigns']").click(function(){  
	
	var len = $("input[name='issigns']:checked").length; 
	if(len==0){
		$('#button').attr('disabled',"true");
		
	}else{
		$('#button').removeAttr("disabled"); 
	}
	var alllen=document.getElementsByName("issigns").length;
	
	if(len<alllen){
		$("#all").prop("checked", false);  
	}
	if(len==alllen){
		$("#all").prop("checked", true);  
	}

});

form2.nexturl.value=location.pathname+location.search;
mt.act=function(a,id,b)
{
  form2.act.value=a;
  form2.id.value=id;
  if(a=='del')
  {
    mt.show('你确定要删除吗？',2,'form2.submit()');
  }else if(a=='updateissign'){
      form2.action='/ShopOrderSigns.do';
      mt.show('你确定要改变20天未签收是否下单状态吗？',2,'form2.submit()');
  }else
  {
    if(a=='view'){
      form2.action='';
      form2.target=form2.method='';
      form2.submit();
    }else if(a=='edit'){
      form2.action='/jsp/yl/shop/ShopHospitalsEdit.jsp';
      form2.target=form2.method='';
      form2.submit();
	}else if(a=='sign'){
    	form2.action='/jsp/yl/shop/ShopHospitalSign.jsp';
    	form2.target=form2.method='';
        form2.submit();
    }else if(a=='setissign'){
    	mt.show("是否确定改变当前选中医院的签收设置？",2);
		mt.ok=function(){
			if(id==0){
	    		var obj=document.getElementsByName('issigns'); //选择所有name="'test'"的对象，返回数组 
	    		//取到对象数组后，我们来循环检测它是不是被选中 
	    		var s=''; 
	    		for(var i=0; i<obj.length; i++){ 
	    		if(obj[i].checked) s+=obj[i].value+','; //如果选中，将value添加到变量s中 
	    		} 
	    		form2.id.value=s;
	    	}
	    	form2.submit();
		}
    	
    }else if(a=='endtime'){
    	form2.action='/jsp/yl/shop/HospitalEndtimeEdit.jsp';
        form2.target=form2.method='';
        form2.submit();
    }else if(a=='editname'){
        form2.action='/jsp/yl/shop/ShopHospitalsNameEdit.jsp';
        form2.target=form2.method='';
        form2.submit();
  	}else if(a=='expex'){
  		layer.open({
  		  type: 2,
  		  title: '导入文件',
  		  shadeClose: true,
  		  area: ['95%', '95%'],
  		  content: '/jsp/yl/shop/ExpExcelEditHospital.jsp' //iframe的url /jsp/yl/shop/ExpExcel.jsp
  		});
  	}else if("crm_exp"){
        layer.open({
            type: 2,
            title: '导入文件',
            shadeClose: true,
            area: ['95%', '95%'],
            content: '/jsp/yl/shop/ExpExcelEditHospital.jsp?type=2' //iframe的url /jsp/yl/shop/ExpExcel.jsp
        });
	}
    	
    
  }
};
$(function(){
	//var area = $("area");
	$("select[name='area']").val("<%= area%>");
	$("select[name='htype']").val("<%= htype%>");
	$("select[name='hgrader']").val("<%= hgrader%>");
});
function daochu() {
    layer.open({
        type: 2,
        title: '导出选择',
        shadeClose: true,
        area: ['30%', '30%'],
        content: '/jsp/yl/shop/select_puid.jsp'
    });
}
</script>
</body>
</html>
