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
StringBuffer sql=new StringBuffer(),par=new StringBuffer();


int menuid=h.getInt("id");
par.append("?community="+h.community+"&id="+menuid);

String name = h.get("name");
if(!"".equals(name) && name != null){
	sql.append(" AND name like'%" + name + "%'");
	par.append("&name="+h.enc(name));
}
String area = h.get("area");
if(!"".equals(area) && area != null){
	sql.append(" AND area ='" + area + "'");	
	par.append("&area="+h.enc(area));
}
String htype = h.get("htype");
if(!"".equals(htype) && htype != null){
	sql.append(" AND htype ='" + htype + "'");	
	par.append("&htype="+h.enc(htype));
}
String hgrader = h.get("hgrader");
if(!"".equals(hgrader) && hgrader != null){
	sql.append(" AND hgrader ='" + hgrader + "'");	
	par.append("&hgrader="+h.enc(hgrader));
}
String deadline = h.get("deadline");
if(!"".equals(deadline) && deadline != null){
	sql.append(" AND datediff(d,getdate(),expirationDate) <= "+deadline );
}
int issign=h.getInt("issign",-1);
if(issign!=-1){
	sql.append(" and issign="+issign);
	par.append("&issign="+issign);
}

int pos=h.getInt("pos");
par.append("&pos=");

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
		</tr><tr>
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
  	<tr>
  		<td colspan="8" align="center"><button class="btn btn-primary" type="submit">查询</button></td>
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
<tr><td colspan='10'>列表 <%=sum%></td></tr>
</thead>
<tr>
  <th width='60'>序号</th>
  <th>医院名称</th>
  <th>医院类别</th>
  <th>医院等级</th>
  <th>省（自治区/直辖市）</th>
  <th>操作</th>
</tr>
<%
if(sum<1)
{
  out.print("<tr><td colspan='8' class='noCont'>暂无记录!</td></tr>");
}else
{
	sql.append(" order by expirationDate ");
  Iterator it=ShopHospital.find(sql.toString(),pos,10).iterator();
  for(int i=1+pos;it.hasNext();i++)
  {
    ShopHospital sh=(ShopHospital)it.next();
  %>
  <tr>
    <td align="center"><%=i%></td>
    <td><%=MT.f(sh.getName())%></a></td>
    <td><%=MT.f(sh.getHtype())%></a></td>
    <td><%=MT.f(sh.getHgrader())%></a></td>
    <td align="center"><%=MT.f(sh.getArea_name())%></td>
    <td nowrap><%
    //if(acts.contains("oper"))
    //{
      out.println("<button type=\"button\" class=\"btn btn-link\" onclick=\"sethid('"+sh.getId()+"','"+sh.getName()+"')\">选择</button>");
    //}
    %></td>
  </tr>
  <%
  }
  if(sum>10)out.print("<tr><td colspan='10' align='right'>"+new tea.htmlx.FPNL(h.language,par.toString(),pos,sum,10));
}%>
</table>
</div>

</form>

<script>

function sethid(id,name){
	//alert(1);
	parent.mt.sethid(id,name);
	parent.mt.close();
	//parent.mtsethid(id,name);
}

$(function(){
	//var area = $("area");
	$("select[name='area']").val("<%= area%>");
	$("select[name='htype']").val("<%= htype%>");
	$("select[name='hgrader']").val("<%= hgrader%>");
});

</script>
</body>
</html>
