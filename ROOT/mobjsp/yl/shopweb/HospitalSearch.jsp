<%@page import="tea.entity.MT"%>
<%@page import="java.util.List"%>
<%@page import="tea.entity.yl.shop.ShopHospital"%>
<%@page import="tea.entity.Database"%>
<%@page import="tea.entity.Http"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
</head>
<body>
<h1>查询医院</h1>
<%
	Http h=new Http(request,response);
	StringBuffer sql=new StringBuffer(),par=new StringBuffer("?");
	String inpname = h.get("inpname");
	String hosname = MT.f(h.get("hosname"));
	par.append("&inpname="+inpname);
	if(!hosname.equals("")){
		sql.append(" AND name like "+Database.cite("%"+hosname+"%"));
		par.append("&hosname="+hosname);
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
	int pos=h.getInt("pos");
	int sum=ShopHospital.count(sql.toString());
	par.append("&pos=");

%>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<table id="tablecenter" cellspacing="0" style="background:none;" >
<form action="">
<input name="inpname" value="<%= inpname %>" type="hidden" />
<tr>
  		<td class="th">名称：</td><td><input name="hosname" value="<%=hosname %>" /></td>
  		</tr>
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
  		</tr>
		<tr>
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
		</tr>
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
		<td colspan="2"><input type="submit" value="查询" /></td>
	</tr>
</form>
</table>
<table id="tablecenter" cellspacing="0" style="background:none;">
  <td>医院名称</td>
  <td>医院类别</td>
  <td>医院等级</td>
  <td>省（自治区/直辖市）</td>
  <td>操作</td>
				<%
				if(sum<0)
				{
				  out.print("<tr><td colspan='6' align='center'>暂无记录!</td></tr>");
				}else
				{
					List<ShopHospital> shlist = ShopHospital.find(sql.toString(), pos, 20);
					for(int i=0;i<shlist.size();i++){
						ShopHospital sh = shlist.get(i);
						%>
						<tr>
    <td><%=MT.f(sh.getName())%></a></td>
    <td><%=MT.f(sh.getHtype())%></a></td>
    <td><%=MT.f(sh.getHgrader())%></a></td>
    <td align="center"><%=MT.f(sh.getArea_name())%></td>
    <td><a href="javascript:void(0);" onclick="parent.sme.mt.receive('<%= sh.getId() %>','<%= sh.getName() %>');parent.mt.close();">选择</a></td>
    </tr>
						<%
					}
				}
				%>
			<%
  				if(sum>20)out.print("<tr><td>"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,20));
			%>
			</table>
<script type="text/javascript">
	var pmt=parent.sme.mt;
	function ret(h){
	pmt.receive(h,'<%=inpname%>');
	parent.mt.close();
	}
</script>
</body>
</html>