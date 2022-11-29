<%@page import="util.Config"%>
<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.DbAdapter"%>
<%@page import="tea.entity.yl.shop.*"%><%@page import="tea.entity.yl.shopnew.*"%><%@page import="tea.entity.member.Profile"%><%


Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}
int menu=h.getInt("id");
StringBuffer sql=new StringBuffer(),par=new StringBuffer("?");
par.append("&id="+menu);

 sql.append(" AND member="+h.member);
par.append("&member="+h.member);
sql.append(" AND applyUnit=0");
//按医院查询

String hname=h.get("hname","");
if(hname.length()>0){
	sql.append(" and hospital like "+Database.cite("%"+hname+"%"));
	par.append("&hname="+h.enc(hname));
}

int puid = h.getInt("puid",-1);
if(puid!=-1){
	sql.append(" AND puid = "+puid);
	  par.append("&puid="+puid);
}

String[] TAB={"全部","未完成开票","已完成开票","审核不通过","退票申请","已退票"};
String[] SQL={""," AND status = 0 "," AND status = 2 "," AND status = 3 "," AND status= 4 "," AND status = 5 "};

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
<style>
.mt_data td,.mt_data th{padding:3px}

input[type=text]::-ms-clear{

                display: none;

                 

            }

            input::-webkit-search-cancel-button{

                display: none;

            }  

            input.t {

                border:1px solid #fff;

                background:#fff;            

                padding-left:5px; 

                height:30px; 

                line-height:30px ;

                font-size:12px;

                font-color: #004779;

                 

            } 
</style>

</head>
<body style='min-height:300px'>
<form name="form1" action="?">
<input type="hidden" name="id" value="<%=menu%>"/>
<input type="hidden" name="tab" value="<%=tab%>"/>
<div class="query">
<table id="tablecenter" cellspacing="0">
<tr>
  <td>医院：<input type="text" name="hname" id="hname" value="<%=hname %>"/>
	<input id="hospitalsel" onclick="mt.show('/jsp/yl/shopwebnew/Selhospital.jsp',1,'选择医院',500,500)" type="button" value="请选择"/>  
  </td>
  <td>厂商：
  <select name='puid'>
	  <option value=''>请选择</option>
	  <option <%= (puid==Config.getInt("tongfu")?"selected='selected'":"") %> value='<%= Config.getInt("tongfu") %>'>同辐</option>
	  <option <%= (puid==Config.getInt("gaoke")?"selected='selected'":"") %> value='<%= Config.getInt("gaoke") %>'>高科</option>
	  <option <%= (puid==Config.getInt("junan")?"selected='selected'":"") %> value='<%= Config.getInt("junan") %>'>君安</option>
  </select>
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

<div class="results">
<table id="tablecenter" cellspacing="0">
<tr id="tableonetr">
  
  <td class="td2">序号</td>
  <td class="td3">发票号</td>
  <td class="td4">医院</td>
  <td class="td5">索要发票时间</td>
  <td class="td6">申请开票数量</td>
  <td class="td7">申请开票金额</td>
  <td class="td8">状态</td>
  <td class="td8">厂商</td>
  <td class="td9">操作</td>
  
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
  for(int i=0;i<lstinvoice.size();i++)
  {
	  Invoice invoice=lstinvoice.get(i);
	  String statuscontent="";
	  if(invoice.getStatus()==0||invoice.getStatus()==1){
		  statuscontent="未开具";
	  }else if(invoice.getStatus()==2){
		  statuscontent="已开具";
	  }else if(invoice.getStatus()==3){
		  statuscontent="审核不通过";
	  }else if(invoice.getStatus()==4){
		  statuscontent="退票申请中";
	  }else if(invoice.getStatus()==5){
		  statuscontent="已退票";
	  }
%>
<tr>
	
	<td><%=i+1 %></td>
	<td><%=MT.f(invoice.getInvoiceno()) %></td>
	<td><%=MT.f(invoice.getHospital()) %></td>
	<td><%=MT.f(invoice.getCreatedate(),1) %></td>
	<td><%=invoice.getNum() %></td>
	<td><%=invoice.getAmount() %></td>
	<td><%=statuscontent %></td>
	<td><%= ProcurementUnit.findName(invoice.getPuid()) %></td>
	<td><a href="javascript:mt.act('data',<%=invoice.getId() %>)">查看</a>&nbsp;&nbsp;
	<%
		if(invoice.getStatus()==3){
	%>
	<a href="javascript:mt.show('<%=MT.f(invoice.getReason()) %>')">查看拒绝原因</a>
	<%		
		}
		if(invoice.getStatus()==2){
	%>
	<a href="javascript:mt.act('back',<%=invoice.getId() %>)">申请退票</a>
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



<script>
mt.act=function(a,invoiceid)
{
  
  if(a=='data')
  {
	  
	  //window.open("InvoiceDatas.jsp?invoiceid="+invoiceid);
	  parent.location="/html/folder/18031330-1.htm?invoiceid="+invoiceid+"&nexturl=/html/folder/17100785-1.htm"+location.search;

  }else if(a=='back'){
	  //InvoiceBack.jsp
	  mt.send("/Invoices.do?act=iscanback&invoiceid="+invoiceid,function(d)
				{
		 
					        if(d=='1')
					        {
					        	mt.show("该发票已申请回款匹配，不能申请退票！");
					        	return false;
					        }else{
					        	///jsp/yl/shopwebnew/InvoiceBack.jsp
					        	parent.location="/html/folder/18031331-1.htm?invoiceid="+invoiceid+"&nexturl=/html/folder/18031294-1.htm"+location.search;
					        }
					    });
	  

  }
};
mt.receive=function(v,n,h){
	document.getElementById("hname").value=v;
	};
mt.fit();
</script>
</body>
</html>
