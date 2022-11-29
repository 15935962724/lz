<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.DbAdapter"%>
<%@page import="tea.entity.yl.shop.*"%><%@page import="tea.entity.yl.shopnew.*"%>
<%@page import="tea.entity.member.Profile"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}

StringBuffer sql=new StringBuffer(),par=new StringBuffer("?");

sql.append(" AND fmember="+h.member);


Date time0=h.getDate("time0");
if(time0!=null)
{
  sql.append(" AND createdate>"+DbAdapter.cite(time0));
  par.append("&time0="+MT.f(time0));
}
Date time1=h.getDate("time1");
if(time1!=null)
{
  sql.append(" AND createdate<"+DbAdapter.cite(time1));
  par.append("&time1="+MT.f(time1));
}

String[] TAB={"未开票催缴","未回款催缴"};
String[] SQL={" AND type = 0 "," AND type = 1 "};

int tab=h.getInt("tab",0);
par.append("&tab="+tab);

int pos=h.getInt("pos");
par.append("&pos=");

int pos2=h.getInt("pos2",1);

%><!DOCTYPE html><html><head>
 <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>

 <link href="/mobjsp/yl/shopStyle.css" rel="stylesheet" type="text/css">
<link href="webcss.css" rel="stylesheet" type="text/css">

<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/jsp/sup/sup.js" type="text/javascript"></script>
<style>
.mt_data td,.mt_data th{padding:3px}
#tableweb td input.date {
<<<<<<< .mine
    width: 6em !important;}
=======
    width: 43% !important;}
>>>>>>> .r2151
</style>
<title>催缴记录</title>
</head>
<body style='min-height:300px'>
<header class="header">催缴记录</header>
<form name="form1" action="?">

<input type="hidden" name="tab" value="<%=tab%>"/>
<div class="query">
<table id="tableweb" cellspacing="0">
<tr>
    <td><input name="time0" value="<%=MT.f(time0)%>" onclick="mt.date(this)" class="date" placeholder="催缴时间"/>

	至&nbsp;<input name="time1" value="<%=MT.f(time1)%>" onclick="mt.date(this)" class="date" placeholder="催缴时间"/></td>

	<td><input type="submit" class="button" value="查询"/></td>
</tr>
</table>
</div>
</form>

<%out.print("<div class='switch'>");
for(int i=0;i<TAB.length;i++)
{ 
  out.print("<a href='javascript:mt.tab("+i+")' class='"+(i==tab?"current":"")+"'>"+TAB[i]+"（"+UrgedRecord.count(sql.toString()+SQL[i])+"）</a>");
}
out.print("</div>");
%>
<form name="form2" action="/ShopOrders.do" method="post" target="_ajax">
<input type="hidden" name="orderId"/>
<input type="hidden" name="status"/>
<input type="hidden" name="cancelReason"/>
<input type="hidden" name="tab" value="<%=tab%>"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<div class="resultlist" style="margin-bottom: 80px;">


<%
sql.append(SQL[tab]);

int sum=UrgedRecord.count(sql.toString());
if(sum<1)
{
  out.print("<div style='text-align:center;width:100%;'>暂无记录!</div>");
}else
{
  
  List<UrgedRecord> lstrecord=UrgedRecord.find(sql.toString()+" order by createdate desc ",pos,1);
  for(int i=0;i<lstrecord.size();i++)
  {
	  UrgedRecord record=lstrecord.get(i);
	  String orderids=record.getOrderid();
	  String[] orderidarr=orderids.split(",");
	  int size=orderidarr.length;
	  if(orderidarr.length>10){
		  size=10;
	  }
	  int endpage=pos2*size;
	  if(endpage>orderidarr.length){
		  endpage=orderidarr.length;
	  }
	  for(int j=(pos2-1)*10;j<endpage;j++){
		  
	  String orderid=orderidarr[j];
	  ShopOrder t=ShopOrder.findByOrderId(orderid);
	  
	  ShopOrderDispatch sod = ShopOrderDispatch.findByOrderId(t.getOrderId());
	  
	  String querySql = " AND order_id="+DbAdapter.cite(t.getOrderId());
  	  List<ShopOrderData> sodList = ShopOrderData.find(querySql,0,Integer.MAX_VALUE);
  	  ShopOrderData odata=new ShopOrderData(0);
  	  if(sodList.size()>0){
  		 odata=sodList.get(0);
  	  }
  	  String uname = MT.f(Profile.find(t.getMember()).member);
      int status = t.getStatus();
      String statusContent = "";
      if(status==0)
    	  statusContent = "等待付款";
      else if(status==1||status==2)
    	  statusContent = "等待发货";
      else if(status==3)
    	  statusContent = "等待收货";
      else if(status==4)
    	  statusContent = "已完成";
      else if(status==5)
    	  statusContent = "<a href='###' onclick=\"mt.show('"+MT.f(t.getCancelReason())+"');\">已取消</a>";
  %>
  <ul>
  <%
  	if(j==(pos2-1)*10){
  %>
    
    <li><span><%=MT.f(record.getCreatedate(),1) %></span></li>
  <%
  	}
  %>
    <li>
    	<span>订单编号：<%=MT.f(t.getOrderId()) %></span>
    	<span><%=statusContent %></span>
    </li>
    <li><span><%=MT.f(sod.getA_hospital()) %></span></li>
   
    <li>
    	<span>数量：<%=odata.getQuantity() %></span>
    	<span><%=MT.f(t.getCreateDate(),1) %></span>
    </li>
   
    
  </ul>
  
  <%
  }
	  int orderlength=orderidarr.length;
	if(orderlength>10){
		int totalpage=0;
		if(orderlength%10==0){
			totalpage=orderlength/10;
		}else{
			totalpage=orderlength/10+1;
		}
	%>
	<ul>
	<li>
	<%
	if(pos2!=1){
		out.print("<a href='/mobjsp/yl/shopwebnew/ListUrged_wx.jsp?tab="+tab+"&pos="+pos+"&time0="+time0+"&time1="+time1+"&pos2="+(pos2-1)+"'>上一页</a>");
	}
	if(totalpage<=10){
		for(int p=1;p<=totalpage;p++){
			if(pos2==p){
				out.print("<a><span style='color:#666'>"+p+"</span></a>&nbsp;");
			}else{
		%>
			
			<a href='/mobjsp/yl/shopwebnew/ListUrged_wx.jsp?tab=<%=tab %>&pos=<%=pos %>&time0=<%=time0 %>&time1=<%=time1 %>&pos2=<%=p %>'><%=p %></a>&nbsp;
			
			
		<%
			}
		}
	}else{
		int jiedian0=1;//开始
		int jiedian=10;//最后
		if(pos2<=jiedian){
			jiedian=10;
			jiedian0=1;
		}else if(pos2>jiedian){
			if(pos2%jiedian!=0){
				jiedian0=(pos2/jiedian)*jiedian+1;
				jiedian=jiedian0+9;
				
			}else if(pos2%jiedian==0){
				jiedian0=((pos2-1)/jiedian)*jiedian+1;
				jiedian=jiedian0+9;
			}
			
		}
		if(jiedian>totalpage){
			jiedian=totalpage;
		}
		for(int p=jiedian0;p<=jiedian;p++){
			if(pos2==p){
				out.print("<a><span style='color:#666'>"+p+"</span></a>&nbsp;");
			}else{
		%>
			
			<a href='/mobjsp/yl/shopwebnew/ListUrged_wx.jsp?tab=<%=tab %>&pos=<%=pos %>&time0=<%=time0 %>&time1=<%=time1 %>&pos2=<%=p %>'><%=p %></a>&nbsp;
			
			
		<%
			}
		}
	}
	if(pos2!=totalpage){
		out.print("<a href='/mobjsp/yl/shopwebnew/ListUrged_wx.jsp?tab="+tab+"&pos="+pos+"&time0="+time0+"&time1="+time1+"&pos2="+(pos2+1)+"'>下一页</a>");
	}
	%>
	</li>
	</ul>
	<%
	}
  }
  if(sum>1)out.print("<div class='page'>"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,1)+"</div>");
  
}%>

</div>

<div class='center mt15 btnbottom'><button class="btn btn-primary" type="button" onclick="dcorder()">导出</button></div>

</form>
<form action="/ShopOrders.do" name="form3"  method="post" target="_ajax" >
	<input name="act" value="exp_urged" type="hidden" />
	
		<input type='hidden' name="sql" value="<%= sql.toString() %>" />
</form>
<script>

function dcorder(){
	form3.submit();
}
mt.fit();
</script>
</body>
</html>
