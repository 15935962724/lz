<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.DbAdapter"%><%@page import="java.text.SimpleDateFormat "%>
<%@page import="tea.entity.yl.shop.*"%><%@page import="tea.entity.yl.shopnew.*"%><%@page import="tea.entity.member.Profile"%>
<%@ page import="util.Config" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="java.math.BigDecimal" %>
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
//	puid1=puid;
}

/*if(puid1 > 0){
	sql.append(" and puid="+puid1);
}*/

//按医院查询

String hname=h.get("hname","");
if(hname.length()>0){
	sql.append(" and hospital like "+Database.cite("%"+hname+"%"));
	par.append("&hname="+h.enc(hname));
}
//按服务商查询

String pname=h.get("pname","");
if(pname.length()>0){
	
	sql.append(" and membername like "+Database.cite("%"+pname+"%"));
	par.append("&pname="+h.enc(pname));
}

//按索要日期查询
Date mdate1=h.getDate("mdate1");
if(mdate1!=null){
	
	sql.append(" and createdate >= "+DbAdapter.cite(mdate1));
	par.append("&mdate1="+MT.f(mdate1));
}
Date mdate2=h.getDate("mdate2");
if(mdate2!=null){
	
	sql.append(" and createdate <= "+DbAdapter.cite(mdate2));
	par.append("&mdate2="+MT.f(mdate2));
}



//按开票日期查询
Date makeoutdate1=h.getDate("makeoutdate1");
if(makeoutdate1!=null){
	sql.append(" and makeoutdate >= "+DbAdapter.cite(makeoutdate1));
	par.append("&makeoutdate1="+MT.f(makeoutdate1));
}
Date makeoutdate2=h.getDate("makeoutdate2");
if(makeoutdate2!=null){
	sql.append(" and makeoutdate <= "+DbAdapter.cite(makeoutdate2));
	par.append("&makeoutdate2="+MT.f(makeoutdate2));
}

//按状态查询
int status = h.getInt("status",-1);
	if(status>=0){
		sql.append(" and status = "+status);
		par.append("&status="+MT.f(status));
	}else {
		par.append("&status="+ status);
	}


	String invoiceno=h.get("invoiceno","");
	if(invoiceno.length()>0){

		sql.append(" and invoiceno like "+Database.cite("%"+invoiceno+"%"));
		par.append("&invoiceno="+h.enc(invoiceno));
	}


String[] TAB={"全部","待审核","待开发票","审核不通过","已开具发票","退票申请","已退票"};
String[] SQL={""," AND status = 0 "," AND status = 1 "," AND status = 3 "," AND status = 2 "," AND status = 4 "," AND status = 5 "};

int tab=h.getInt("tab",0);
par.append("&tab="+tab);

int pos=h.getInt("pos");
par.append("&pos=");

int size=20;

	int productPuid = h.getInt("productPuid");
	if(productPuid!=0){
		sql.append("AND hospitalid in(select id from shopHospital where productPuid="+productPuid+")");
	}
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
<script src="/jsp/yl/My97DatePicker/WdatePicker.js" type="text/javascript"></script>


</head>
<body>
<h1>发票管理</h1>
<form name="form1" action="?">
<input type="hidden" name="id" value="<%=menu%>"/>
<input type="hidden" name="tab" value="<%=tab%>"/>
<div class="radiusBox">
<table cellspacing="0" class='newTable'>
<thead>
<tr><td colspan='6'>查询</td></tr>
</thead>
	<td>发票号：<input type="text" name="invoiceno" value="<%=invoiceno %>"/>
	</td>
	<td>
		开票日期：
		<input class="Wdate" onfocus="WdatePicker({readOnly:true,maxDate:'%y-%M-%d'})" id="makeoutdate1" name="makeoutdate1" value="<%= MT.f(makeoutdate1) %>"/>
		——<input class="Wdate" onfocus="WdatePicker({readOnly:true,maxDate:'%y-%M-%d'})" id="makeoutdate2" name="makeoutdate2" value="<%= MT.f(makeoutdate2) %>"/>
	</td>
	<td nowrap="">状态：<select name="status">
		<option value="-1">请选择</option>
		<option value="0" <%=status==0?"selected=selected":""%> >未开具</option>
		<option value="1" <%=status==1?"selected=selected":""%> >已审核</option>
		<option value="2" <%=status==2?"selected=selected":""%> >已开具</option>
		<option value="3" <%=status==3?"selected=selected":""%> >审核不通过</option>
		<option value="4" <%=status==4?"selected=selected":""%> >退票申请中</option>
		<option value="5" <%=status==5?"selected=selected":""%> >已退票</option>
	</select></td>
<tr>
  <td>医院：<input type="text" name="hname" id="hname" value="<%=hname %>"/>
	<input id="hospitalsel" onclick="mt.show('/jsp/yl/shopnew/Selhospital_shop.jsp',1,'选择医院',500,500)" type="button" value="请选择"/>  
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
	<td>厂商：
		<select name="productPuid">
			<%
				List<ProcurementUnit> pulist = ProcurementUnit.find(" AND puid <>"+ Config.getInt("tongfu"),0,Integer.MAX_VALUE);
				if(productPuid==0){%><option>请选择</option><%}
				for (int j = 0; j < pulist.size(); j++) {
					ProcurementUnit pu = pulist.get(j);
					%>
					<option value="<%=pu.getPuid()%>" <%=productPuid==pu.getPuid()?"selected='selected'":""%>><%=pu.getName()%></option>
			<%
				}
			%>
		</select>
	</td>
  <td>
	  索要发票日期：
  <input class="Wdate" onfocus="WdatePicker({readOnly:true,maxDate:'%y-%M-%d'})" id="createdate1" name="mdate1" value="<%= MT.f(mdate1) %>"/>
——<input class="Wdate" onfocus="WdatePicker({readOnly:true,maxDate:'%y-%M-%d'})" id="createdate2" name="mdate2" value="<%= MT.f(mdate2) %>"/>
  </td>
  <td><input type="submit" class="button" value="查询"/></td>
  
</tr>
</table>
</div>
</form>

<%out.print("<div class='switch'>");
for(int i=0;i<TAB.length;i++)
{ 
  out.print("<a href='javascript:mt.tab("+i+")' class='"+(i==tab?"current":"")+"'>"+TAB[i]+"（"+Invoice.count(sql.toString()+SQL[i])+"）</a>");
}
out.print("</div>");
%>
<form name="form2" action="/Invoices.do" method="post" target="_ajax">

<input type="hidden" name="tab" value="<%=tab%>"/>
<input type="hidden" name="id" value="<%=menu %>"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<input type="hidden" name="invoiceid" />
<input type="hidden" name="reason" />
<input type="hidden" name="nobackreason" />
<div class='radiusBox mt15'>
<table  id="" cellspacing="0" class='newTable'>
<tr>
  
	<th>序号</th>
	<th>发票号</th>
	<th>服务商公司</th>
	<th>服务商</th>
	<th>医院</th>
	<th>厂商</th>
	<th>索要发票时间</th>
	<th>开票日期</th>
	<th>申请开票数量</th>
	<%
		if(puid==((int)Config.getInt("gaoke"))){%>
	<th>开票单价</th>
		<%}
	%>
	<th>申请开票金额</th>
	<%
		if(puid==((int)Config.getInt("gaoke"))){
			out.print("<th>开票活度</th>");
		}
		if(puid!=Config.getInt("tongfu")){
			out.print("<th>计提服务费</th>");
		}
	%>
	<th>服务费发票</th>
	<th>状态</th>
	<th>操作</th>
  
</tr>
<%
sql.append(SQL[tab]);

int sum=Invoice.count(sql.toString());
if(sum<1)
{
  out.print("<tr><td colspan='11' align='center'>暂无记录!</td></tr>");
}else
{
 
  List<Invoice> lstinvoice=Invoice.find(sql.toString()+" order by createdate desc ", pos, size);
	System.out.println("sql="+sql.toString());
  for(int i=0;i<lstinvoice.size();i++)
  {
	  Invoice invoice=lstinvoice.get(i);
	  String makeoutDate = invoice.getMakeoutdate()==null?"-":MT.f(invoice.getMakeoutdate());
	  String statuscontent="";
	  if(invoice.getStatus()==0){
		  statuscontent="未开具";
	  }else if(invoice.getStatus()==1){
		  statuscontent="已审核";
	  }else if(invoice.getStatus()==2){
		  statuscontent="已开具";
	  }else if(invoice.getStatus()==3){
		  statuscontent="审核不通过";
	  }else if(invoice.getStatus()==4){
		  statuscontent="退票申请中";
	  }else if(invoice.getStatus()==5){
		  statuscontent="已退票";
	  }

      int phpuid = InvoiceData.getPuid(invoice.getId());

      //ProcurementUnitJoin puj = ProcurementUnitJoin.find(phpuid, invoice.getMember());
	  ProcurementUnitJoin puj = ProcurementUnitJoin.find(phpuid, invoice.getMember(),invoice.getHospitalid());

	  Profile profile = Profile.find(invoice.getMember());
	  Map<String,Double> imap =  Invoice.getTaxAmount(puj.tax, invoice.getId(), 0.9844, 1.13);
	  double mysum = imap.get("chargeamountsum")+imap.get("taxamount");
	  BigDecimal b2=new BigDecimal(mysum);
	  double taxamount2=b2.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();



      int mateType = invoice.getMateType();
      String mate = mateType==0?"<font color=green>未匹配</font>":"<font color='#999'>已匹配</font>";

%>
<tr>
	
	<td><%=pos+i+1 %></td>
	<td><%=MT.f(invoice.getInvoiceno()) %></td>
	<td><%=MT.f(puj.getCompany())%></td>
	<td><%=MT.f(profile.getMember()) %></td>
	<td><%=MT.f(invoice.getHospital()) %></td>
	<td><%=MT.f(ProcurementUnit.findName(puid))%></td>
	<td><%=MT.f(invoice.getCreatedate(),1) %></td>
	<td><%=makeoutDate%></td>

	<td><%=invoice.getNum() %></td>
	<%
		if(puid==((int)Config.getInt("gaoke"))){%>
		    <td><%=invoice.getAmount()/invoice.getNum()%></td>
		<%}
	%>
	<td><%=invoice.getAmount() %></td>
	<%
		if(puid==((int)Config.getInt("gaoke"))){
			out.print("<td>"+MT.f(invoice.getActivity())+"</td>");
		}
		if(puid!=Config.getInt("tongfu")){
			out.print("<td>"+taxamount2+"</td>");
		}
	%>
	<td><%=mate %></td>
	<td><%=statuscontent %></td>
	<td>
		<a href="javascript:mt.act('data',<%=invoice.getId() %>)">查看</a>&nbsp;&nbsp;
		<%
			if(invoice.getStatus()==0){
		%>
		<a href="javascript:mt.act('confirm',<%=invoice.getId() %>)">确认开票</a>&nbsp;&nbsp;
		<a href="javascript:mt.act('refuse',<%=invoice.getId() %>)">拒绝开票</a>&nbsp;&nbsp;
		<%
			}
			if(invoice.getStatus()==1||(invoice.getStatus()==2&&MT.f(invoice.getCourierno(),"")!="")||invoice.getStatus()==4){
		%>
		<a href="javascript:mt.act('show',<%=invoice.getId() %>)">查看开票信息</a>&nbsp;&nbsp;
		<%		
			}
			if(invoice.getStatus()==2&&MT.f(invoice.getCourierno(),"")==""){
		%>
		<%-- <a href="javascript:mt.act('courier',<%=invoice.getId() %>)">补填快递单号</a>&nbsp;&nbsp; --%>
		<a href="javascript:mt.act('courier',<%=invoice.getId() %>)">补填快递单号</a>&nbsp;&nbsp;
		<%
			}
			if(invoice.getStatus()==4){
			
		%>
		<a href="javascript:mt.act('backyes',<%=invoice.getId() %>)">同意退票</a>&nbsp;&nbsp;
		<a href="javascript:mt.act('backno',<%=invoice.getId() %>)">拒绝退票</a>&nbsp;&nbsp;
		<%
			}
			if(invoice.getStatus()==2&&MT.f(invoice.getCourierno(),"")!=""){
		%>
		<a href="javascript:mt.act('print',<%=invoice.getId() %>)">打印发票随行单</a>&nbsp;&nbsp;
		<%
			}
		%>
		
	</td>
</tr>
<%
  }
  if(sum>20)out.print("<tr class='fenye'><td colspan='14' align='right'>"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,20));
}%>
</table>
</div>
</form>
<div class='center mt15'><button class="btn btn-primary" type="button" onclick="dcorder()">导出</button></div>
<form action="/Invoices.do" name="form3"  method="post" target="_ajax" >
	<input name="act" value="exp_invoice" type="hidden" />
		<input type='hidden' name="sql" value="<%= sql.toString() %>" />
</form>

<script>
form2.nexturl.value=location.pathname+location.search;
mt.act=function(a,invoiceid)
{
  form2.act.value=a;
  form2.invoiceid.value=invoiceid;
  if(a=='data')
  {
	  form2.action="/jsp/yl/shopnew/InvoiceDatas_shop.jsp";
	  form2.target='_self';form2.method='get';form2.submit();
	  
  }else if(a=='confirm'){
	  form2.action="/jsp/yl/shopnew/InvoiceMakeout.jsp";
	  form2.target='_self';form2.method='get';form2.submit();
  }else if(a=="show"){
	  form2.action="/jsp/yl/shopnew/InvoiceShow.jsp";
	  form2.target='_self';form2.method='get';form2.submit();
  }else if(a=="courier"){
	  form2.action="/jsp/yl/shopnew/InvoiceMakeout.jsp";
	  form2.target='_self';form2.method='get';form2.submit(); 
  }else if(a=="refuse"){
	 
	  mt.show("<textarea id='_q' cols='28' rows='5'></textarea>",2,"拒绝原因");
	  mt.ok=function()
	  {
	    var v=document.getElementById("_q").value;
		if(v==''||v=='undefined')return;
		
		form2.reason.value = v;
		form2.submit();
		
	  }
  }else if(a=="backyes"){
	  mt.show("是否同意退票？",2);
		mt.ok=function(){
			form2.submit();
		}
  }else if(a=="backno"){
	  mt.show("<textarea id='_q' cols='28' rows='5'></textarea>",2,"拒绝原因");
	  mt.ok=function()
	  {
	    var v=document.getElementById("_q").value;
		if(v==''||v=='undefined'){
			alert("请填写拒绝原因！");
			return;
		}
	
		form2.nobackreason.value = v;
		form2.submit();
		
	  }
  }else if(a=="print"){
	  form2.action=("/jsp/yl/shopnew/InvoicePrint.jsp");
	  form2.target='_self';form2.method='get';form2.submit();
  }
};

mt.receive=function(v,n,h){
  

document.getElementById("hname").value=v;
};

mt.receive2=function(v,n,h){
	  

	document.getElementById("pname").value=v;
	};
	

	function dcorder(){
		
		form3.submit();
	}
</script>
</body>
</html>
