<%@page import="tea.entity.member.Profile"%>
<%@page contentType="text/html; charset=UTF-8"%>
<%@page import="java.util.*"%><%@page import="tea.db.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.entity.yl.shop.*"%><%

Http h=new Http(request,response);

int hospital=h.getInt("id");
StringBuffer sql=new StringBuffer(),par=new StringBuffer("?");
String hospital2=String.valueOf(hospital);
sql.append(" AND hospital="+DbAdapter.cite(hospital2));
StringBuffer sql2=new StringBuffer();
sql2.append(" AND hospital like "+DbAdapter.cite("%"+hospital2+"%"));

int pos=h.getInt("pos");
int sum=Profile.count(sql.toString());
par.append("&pos=");

%><!DOCTYPE html>
<html><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/jquery-1.3.1.min.js" type="text/javascript"></script>
</head>
<body>
<h1>设置签收人</h1>

<form action="/Members.do" target="_ajax"  onSubmit="return mt.check(this)" name="form3" method="post"  >
<input name="act" value="setsign" type="hidden" />
<input type="hidden" name="nexturl"/>
<input type="hidden" name="hospital" value="<%= hospital%>"/>
<div class='radiusBox'>
<table id="tdbor" cellspacing="0" class='newTable'>
<thead>
<tr><td colspan='4' class='bornone'>设置签收人</td></tr>
</thead>
	<tr>
		<td>签收人：</td>
		<td>
		<input type="hidden" name="profile" value=""/><input type="text" alt="会员" name="memberN" readonly value=""/>
		<button type="button" class="btn btn-primary btn-xs" onclick="showprofilesearch()">选择签收人</button>
		</td>
		<td><input type="checkbox" name="particles_sign" value="1"/>粒子签收
			<input type="checkbox" name="invoice_sign" value="1"/>发票签收</td>
		<td>
			<button type="submit" class="btn btn-primary">添加</button>
		</td>
	</tr>
</table></div>
</form>
<form name="form2" action="/Members.do" method="post" target="_ajax">
<input type="hidden" name="nexturl"/>
<input type="hidden" name="profile"/>
<input type="hidden" name="act" value="productdelete"/>
<input type="hidden" name="delone" />
<input type="hidden" name="hospitalid" />
<div class='radiusBox mt15'>
<table id="" cellspacing="0" class='newTable'>
<tr>
<!--   <th><input type="checkbox" onclick="mt.select(form2.dids,checked)"/></th> -->
  <th width='60'>序号</th>
  <th>用户名</th>
  <th>手机</th>
  <th>粒子签收</th>
  <th>发票签收</th>
  <th>操作</th>
</tr>
<%
if(sum < 0)
{
  out.print("<tr><td colspan='10' class='noCont'>暂无记录!</td></tr>");
}else
{
	List<Profile> shlist = Profile.find1(sql2.toString(), pos, 20);
	for(int i=0;i<shlist.size();i++){
		Profile pro = shlist.get(i);
  %>
  <tr onMouseOver="bgColor='#FFFFCA'" onMouseOut="bgColor=''">
<%--     <td><input type="checkbox" name="dids" value="<%= s1.getId()%>"/></td> --%>
    <td><%=i+1%></td>
    <td><%=MT.f(pro.getMember()) %></td>
    <td><%=MT.f(pro.getMobile()) %></td>
    <td><%=pro.particles_sign==1?"<img width='18px;' src='/tea/image/ok.png'/>":"<img width='18px;' src='/tea/image/no.png'/>" %></td>
    <td><%=pro.invoice_sign==1?"<img width='18px;' src='/tea/image/ok.png'/>":"<img width='18px;' src='/tea/image/no.png'/>" %></td>
    <%
        String member = pro.getMember();
        ArrayList<ShopOrderDispatch> shopOrderDispatches = ShopOrderDispatch.find(" AND a_consignees=" + Database.cite(member) + " AND a_hospital_id=" + hospital, 0, Integer.MAX_VALUE);
        Boolean isok = true;//是否可以删除
        String order_ids = "";
        for (int j = 0; j <shopOrderDispatches.size() ; j++) {//有未取消未签收订单不可删除
            ShopOrderDispatch sh = shopOrderDispatches.get(j);
            String order_id = sh.getOrder_id();
            ShopOrder byOrderId = ShopOrder.findByOrderId(order_id);
            if(byOrderId.getStatus()!=4){//未签收
                if(byOrderId.getStatus()!=5&&byOrderId.getStatus()!=7){//未取消
                    isok = false;
                    order_ids += byOrderId.getOrderId();
                }
            }
        }
        if(isok){
    %>
    <td><a href='javascript:void(0);' onclick="delsign(<%= pro.getProfile()%>,<%=hospital %>)">删除</a>
        <%}else {%>
    <td><a href='javascript:void(0);' onclick="no()">删除</a>
        <%}%>
    <!-- a href='javascript:void(0);' onclick="updatetime(<%= pro.getProfile()%>)">编辑</a></td -->
  </tr>
  <%}
}%>
</table>
</div>
<div class='mt15'><input type="button" onClick="location='<%= h.get("nexturl") %>';" value="返回" class="btn btn-primary"/></div>
<!-- <br/>
<button class="btn btn-primary" type="button" name="multi" onclick="f_act('productdelete',0)">批量删除</button> -->
</form>

<script>
//mt.disabled(form2.dids);
form2.nexturl.value=location.pathname+location.search;
form3.nexturl.value=location.pathname+location.search;
function f_act(a,id)
{
  form2.act.value=a;
  form2.did.value=id;
  if(a=='productdelete')
  {
	 var flag = false;
	 var carr = document.getElementsByName("dids");
	 for(var i=0;i<carr.length;i++){
		 if(carr[i].checked){
			 flag = true;
		 }
	 }
	 if(!flag){
		 mt.show("请选择数据！");
		 return;
	 }
    mt.show('你确定要删除吗？',2,'form2.submit()');
  }
}
function delsign(num,hid){
	mt.show('你确定要删除吗？',2);
	mt.ok=function(){
		form2.act.value = 'delsign';
		form2.profile.value = num;
		form2.hospitalid.value = hid;
		form2.submit();
	};
}
function showprofilesearch(){
	mt.show("/jsp/yl/shop/ProfileSearch.jsp",2,"查询签收人",900,500);
}
mt.receive=function(h,n){
	form3.profile.value=h;
	form3.memberN.value=n;
}

function updatetime(num){
	form2.did.value=num;
	form2.action=('/jsp/yl/shop/ShopHospitalSetExpiration.jsp');
	form2.target='_self';form2.method='get';form2.submit();
	//location = "/jsp/yl/shop/ShopHospitalSetExpiration.jsp?nexturl="+form2.nexturl.value+"&hid="+num;
}

/* function fchange(value,b)
{
  sendx("/jsp/admin/edn_ajax.jsp?act=selhos&hosid="+value,function(data){
	  $("#"+b).html(data.trim());
  });
  selchange($("#"+b)[0]);
}
function tchange(value,b)
{
  sendx("/jsp/admin/edn_ajax.jsp?act=seltype&typeid="+value,function(data){
	  $("#"+b).html(data.trim());
  });
}
function selchange(obj){
	var index = obj.selectedIndex;
	if(index==1){
		tchange(1,"membertype");
	}else if(index>1){
		tchange(0,"membertype");
	}else{
		$("#membertype").html("<option value='-1'>请选择</option>");
	}
} */
function no() {
    mt.show('有未签收订单不可删除');
}
</script>
</body>
</html>
