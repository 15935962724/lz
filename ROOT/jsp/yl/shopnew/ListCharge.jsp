<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.DbAdapter"%><%@page import="java.text.SimpleDateFormat "%>
<%@page import="tea.entity.yl.shop.*"%><%@page import="tea.entity.yl.shopnew.*"%><%@page import="tea.entity.member.Profile"%>
<%@ page import="util.Config" %>
<%@ page import="java.text.DecimalFormat" %>
<%


Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}
int menu=h.getInt("id");
StringBuffer sql=new StringBuffer(),par=new StringBuffer("?");
par.append("&id="+menu);

Integer puid = Config.getInt(h.get("puid"));
//int puid1 = h.getInt("puid1");

if(puid != null) {
    sql.append(" and puid=" + puid);
    par.append("&puid=" + h.get("puid"));
//    puid1=puid;
}

/*if(puid1 > 0){
    sql.append(" and puid="+puid1);
}*/

//按医院查询

String hname=h.get("hname","");
if(hname.length()>0){
	sql.append(" and hospitalid in(select id from shophospital where name like "+Database.cite("%"+hname+"%")+")");
	par.append("&hname="+h.enc(hname));
}
//按服务商查询

String pname=h.get("pname","");
if(pname.length()>0){
	
	sql.append(" and member in(select profile from profile where member like "+Database.cite("%"+pname+"%")+")");
	par.append("&pname="+h.enc(pname));
}
//按服务费时间查询
Date time0=h.getDate("time0");
if(time0!=null)
{
  sql.append(" AND createdate>="+DbAdapter.cite(time0));
  par.append("&time0="+MT.f(time0));
}
Date time1=h.getDate("time1");
if(time1!=null)
{
  sql.append(" AND createdate<="+DbAdapter.cite(time1));
  par.append("&time1="+MT.f(time1));
}

String[] TAB={"无发票","部分发票","全部发票","已通知服务商","财务审核通过"};
String[] SQL={" and backid in(select id from backinvoice where  matchamount=0 and soldnoreply !=oldnoreply and status=1) "," and backid in(select id from backinvoice where matchamount>0 and oldnoreply != soldnoreply and status=1) "," and backid in(select id from backinvoice where  oldnoreply = soldnoreply and status=1) "," and istzfws = 1 ", " and istzfws = 2 "};

int tab=h.getInt("tab",0);
par.append("&tab="+tab);

int pos=h.getInt("pos");
par.append("&pos=");

int size=20;

%><!DOCTYPE html><html><head>
<script>
var ls=parent.document.getElementsByTagName("HEAD")[0];
document.write(ls.innerHTML);
var arr=parent.document.getElementsByTagName("LINK");
for(var i=0;i<arr.length;i++)
{
	  document.write("<link href='"+arr[i].href+"' rel='"+arr[i].rel+"' type='text/css'>");
}

</script> 

<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/jsp/sup/sup.js" type="text/javascript"></script>
<script src="/tea/jquery-1.11.1.min.js"></script>


</head>
<body>
<h1>服务费管理</h1>
<form name="form1" action="?">
<input type="hidden" name="id" value="<%=menu%>"/>
<input type="hidden" name="tab" value="<%=tab%>"/>
<div class="radiusBox">
<table cellspacing="0" class='newTable'>
<thead>
<tr><td colspan='5'>查询</td></tr>
</thead>
<tr>
  <td>医院：<input type="text" name="hname" id="hname" value="<%=hname %>"/>
	<input id="hospitalsel" onclick="showhospitalsearch()" type="button" value="请选择"/>  
  </td>
    <%--<%
        if(puid == null){
    %>
    <td nowrap="">厂商：
        <select name="puid1">
            <option>请选择</option>
            <%
                List<ProcurementUnit> puList = ProcurementUnit.find("", 0, 10);
                for (int i = 0; i < puList.size(); i++) {
                    out.print("<option "+(puid1==puList.get(i).getPuid()?"selected='selected'":"")+" value='"+puList.get(i).getPuid()+"'>"+puList.get(i).getName()+"</option>");
                }
            %>
        </select>
    </td>
    <%
        }
    %>--%>
  <td>服务商：<input type="text" name="pname" id="pname" value="<%=pname %>"/>
	<input id="hospitalsel" onclick="mt.show('/jsp/yl/shopnew/SelProfile_shop.jsp',1,'选择服务商',500,500)" type="button" value="请选择"/>  
  </td>
  <td>时间：<input name="time0" value="<%=MT.f(time0)%>" onclick="mt.date(this)" class="date"/>  至  <input name="time1" value="<%=MT.f(time1)%>" onclick="mt.date(this)" class="date"/>  
  </td>
  <td><input type="submit" class="button" value="查询"/></td>
  
</tr>
</table>
</div>
</form>

<%out.print("<div class='switch'>");
for(int i=0;i<TAB.length;i++)
{ 
  out.print("<a href='javascript:mt.tab("+i+")' class='"+(i==tab?"current":"")+"'>"+TAB[i]+"（"+Charge.count(sql.toString()+SQL[i])+"）</a>");
}
out.print("</div>");
%>
<form name="form2" action="/Charges.do" method="post" target="_ajax">

<input type="hidden" name="tab" value="<%=tab%>"/>
<input type="hidden" name="id" value="<%=menu %>"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<input type="hidden" name="chargeid" />
<input type="hidden" name="nobackreason" />
<div class='radiusBox mt15'>
<table  id="" cellspacing="0" class='newTable'>
<tr>
  
  <th>序号</th>
  <th>服务费编号</th>
  <th>医院</th>
  <th>厂商</th>
  <th>服务商</th>
  <%--<th>应付服务费</th>
  <th>进项税返还</th>--%>
  <th>应付服务费总额</th>

    <th>暂扣账款金额</th>
    <th>归还账款金额</th>
    <th>服务费结算比例</th>
    <th>服务费最终结算金额</th>

  <th>时间</th>
  <th>状态</th>
  <th>操作</th>
  
</tr>
<%
sql.append(SQL[tab]);

int sum=Charge.count(sql.toString());
if(sum<1)
{
  out.print("<tr><td colspan='11' align='center'>暂无记录!</td></tr>");
}else
{
 
  List<Charge> lstcharge=Charge.find(sql.toString()+" order by createdate desc ", pos, size);
  for(int i=0;i<lstcharge.size();i++)
  {
	  Charge charge=lstcharge.get(i);
	  ShopHospital hospital=ShopHospital.find(charge.getHospitalid());//医院
	  Profile profile=Profile.find(charge.getMember());//服务商

      BackInvoice back = BackInvoice.find(charge.getBackid());


%>
<tr>
    <td><%=i+1 %></td>
    <td><%=charge.getChargecode() %></td>
    <td><%=hospital.getName() %></td>
    <td><%=ProcurementUnit.findName(puid)%></td>
    <td><%=profile.member %></td>
    <%--<td><%=charge.getPayable() %></td>
    <td><%=charge.getInputtax() %></td>--%>
    <%
        DecimalFormat df = new DecimalFormat("0.00");// 保留小数点后二位
        double v0 = Double.parseDouble(df.format(charge.getTotal()));
    %>
    <td><%=v0 %></td>
    <td><%= back.getQianamount()%></td>
    <td><%= back.getHuanamount()%></td>
    <td><%= BackInvoice.deductionRecordTypeARR[back.getDeductionRecordType()]%></td>
    <td>
        <%
           float deductionRecordTypeARRnum =  BackInvoice.deductionRecordTypeARRnum[back.getDeductionRecordType()];
            float deductionRecordAmount = 0;

            double v1 = Double.parseDouble(df.format(charge.getTotal()*deductionRecordTypeARRnum));

            if(back.getQianamount()>0){//欠款
                v1 = v1 - back.getQianamount();
            }
            if(back.getHuanamount()>0){//还款
                v1 = v1 + back.getHuanamount();
            }
            double v2 = Double.parseDouble(df.format(v1));

            out.print(v2);
        %>
    </td>

    <td><%=MT.f(charge.getCreatedate(),1) %></td>
    <td><%=Charge.ISTZFWS[charge.getIstzfws()] %></td>
    <td>
    	<button type="button" class="btn btn-link" onclick="mt.act('data','<%=charge.getId() %>')">查看详情</button>
    	<%
    		if(charge.getStatus()==0){
    	%>
    	<button type="button" class="btn btn-link" onclick="mt.act('backyes','<%=charge.getId() %>')">审核通过</button>
    	<button type="button" class="btn btn-link" onclick="mt.act('backno','<%=charge.getId() %>')">审核不通过</button>
    	<%
    		}if(tab!=0){
    	%>
    	<button type="button" class="btn btn-link" onclick="mt.act('dcdata','<%=charge.getId() %>')">导出服务费确认单</button>
    	<button type="button" class="btn btn-link" onclick="mt.act('dctzdata','<%=charge.getId() %>')">导出服务费支付通知单</button>
    	<%			
    			
    		}
    			if(charge.getIstzfws()==0){
    	%>
    	<button type="button" class="btn btn-link" onclick="mt.act('tzfws','<%=charge.getId() %>')">通知服务商</button>
    	<%
    			}
    			if(charge.getIstzfws()==1){
    	%>
    	<button type="button" class="btn btn-link" onclick="mt.act('cwshtg','<%=charge.getId() %>')">财务审核通过</button>
    	
    	<%
    			}
    	%>
    </td>	
	
</tr>

<%			  
		 
	  
  }
  if(sum>20)out.print("<tr class='fenye'><td colspan='11' align='right'>"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,20));
}%>
</table>
</div>
<%
	if(tab==3||tab==4){
%>
<div class='center mt15'><button class="btn btn-primary" type="button" onclick="dcorder()">导出</button></div>
<%
	}
%>
</form>
<form action="/Charges.do" name="form3"  method="post" target="_ajax" >
	<input name="act" value="exp_sh" type="hidden" />
	<input type='hidden' name="sql" value="<%= sql.toString() %>" />
</form>

<script>
form2.nexturl.value=location.pathname+location.search;
mt.act=function(a,chargeid)
{
  form2.act.value=a;
  form2.chargeid.value=chargeid;
  if(a=='data')
  {
	  form2.action="/jsp/yl/shopnew/ChargeDatas.jsp";
	  form2.target='_self';form2.method='get';form2.submit();
	  
  }else if(a=='backyes'){
	  mt.show("确定审核通过吗？",2);
		mt.ok=function(){
			form2.submit();
		}
  }else if(a=="backno"){
	  mt.show("<textarea id='_q' cols='28' rows='5'></textarea>",2,"拒绝原因");
	  mt.ok=function()
	  {
	    var v=document.getElementById("_q").value;
		if(v==''||v=='undefined')return;
		
		form2.nobackreason.value = v;
		form2.submit();
		
	  }
  }else if(a=="dcdata"){
	//  form2.act.value="test";
	  form2.submit();
  }else if(a=="dctzdata"){
	  form2.submit();
  }else if(a=="tzfws"){
	  form2.submit();
  }else if(a=="cwshtg"){
	  form2.submit();
  }
};

mt.receive=function(v,n,h){
  

document.getElementById("hname").value=v;
};

mt.receive2=function(v,n,h){
	  

	document.getElementById("pname").value=v;
	};
function showhospitalsearch(){
	
	mt.show("/jsp/yl/shopnew/Selhospital_shop.jsp",1,"查询医院",900,500);	
}
function dcorder(){
	form3.submit();
}

</script>
</body>
</html>
