<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.DbAdapter"%>
<%@page import="tea.entity.yl.shop.*"%><%@page import="tea.entity.member.Profile"%>
<%@ page import="util.Config" %><%
// 发票管理 - 企业号
Http h=new Http(request,response);
h.setCook("community", "Home", -1);
//String nexturl = h.get("nexturl","/mobjsp/yl/shop/ShopOrderDispatchs.jsp");
    int qywxMember = h.getInt("qywxMember");
    if(qywxMember>0){
        h.member = qywxMember;
    }
if(h.member<1){
    String param = request.getQueryString();
    String url = request.getRequestURI();
    if(param != null)
        url = url + "?" + param;
  response.sendRedirect("/PhoneProjectReport.do?act=qy&agentid=4&nexturl="+Http.enc(url));
  return;
}

int menu=h.getInt("id");
StringBuffer sql=new StringBuffer(),par=new StringBuffer();
par.append("?id="+menu);

//sql.append(" AND isLzCategory=0");// AND isLzCategory=1
//par.append("&isLzCategory=0");//&isLzCategory=1

String order_id=h.get("order_id","");
if(order_id.length()>0)
{
  sql.append(" AND so.order_id LIKE "+Database.cite("%"+order_id+"%"));
  par.append("&order_id="+h.enc(order_id));
}

Date time0=h.getDate("time0");
if(time0!=null)
{
  sql.append(" AND so.createDate>"+DbAdapter.cite(time0));
  par.append("&createDate="+MT.f(time0));
}
Date time1=h.getDate("time1");
if(time1!=null)
{
  sql.append(" AND so.createDate<"+DbAdapter.cite(time1));
  par.append("&createDate="+MT.f(time1));
}

/* String username=h.get("username","");
if(username.length()>0)
{
  sql.append(" AND ml.lastname+ml.firstname LIKE "+Database.cite("%"+username+"%"));
  par.append("&username="+h.enc(username));
} */

String member=h.get("member","");
if(member.length()>0)
{
  sql.append(" AND m.member LIKE "+Database.cite("%"+member+"%"));
  par.append("&member="+h.enc(member));
}

String company=h.get("company","");
if(company.length()>0)
{
  sql.append(" AND sod.n_company LIKE "+Database.cite("%"+company+"%"));
  par.append("&company="+h.enc(company));
}

String consignees=h.get("consignees","");
if(consignees.length()>0)
{
  sql.append(" AND sod.n_consignees LIKE "+Database.cite("%"+consignees+"%"));
  par.append("&consignees="+h.enc(consignees));
}

    Integer puid = Config.getInt(h.get("puid"));
//int puid1 = h.getInt("puid1");

    if(puid != null) {
        sql.append(" and so.puid=" + puid);
        par.append("&puid=" + h.get("puid"));
//	puid1=puid;
    }


String[] TAB={"全部发票","未开具发票","已开具发票","退货重开发票"};
String[] SQL={" AND so.invoiceStatus!=0"," AND (so.invoiceStatus=1 or so.invoiceStatus=2)"," AND so.invoiceStatus=3"," AND se.type = 1 "};

int tab=h.getInt("tab",0);
par.append("&tab="+tab);

int pos=h.getInt("pos");
par.append("&pos=");



%><!DOCTYPE html><html><head>
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/jsp/sup/sup.js" type="text/javascript"></script>
<link href="/mobjsp/yl/shopStyle.css" rel="stylesheet" type="text/css">


</head>
<body>
<header class="header"><!-- <a href="javascript:history.go(-1)"></a> -->发票管理</header>

<form name="form1" action="?">
<input type="hidden" name="id" value="<%=menu%>"/>
<input type="hidden" name="tab" value="<%=tab%>"/>
<input type="hidden" name="puid" value="<%=h.get("puid")%>"/>
<div class='radiusBox bg'>
<ul class="seachr">
<li class='bold'>查询</li>
 <li><span>订单编号：</span><input name="order_id" placeholder="订单编号" value="<%=MT.f(order_id)%>"/></li>
 <li><span>用户名：</span><input name="member" placeholder="用户名" value="<%=MT.f(member)%>"/></li>
<li><span>订单时间：</span><input name="time0" type="date" placeholder="订单时间" value="<%=MT.f(time0)%>" class="date"/></li>
 <li><span>至：</span><input name="time1" value="<%=MT.f(time1)%>" type="date" class="date"/></li>

<li><span>开票单位:</span><input name="company" placeholder="开票单位" value="<%=MT.f(company)%>"/></li>
<li><span>发票接收人:</span><input name="consignees" placeholder="发票接收人" value="<%=MT.f(consignees)%>"/></li>
 <li><button type="submit">查询</button></li>
</ul>
</div>
</form>


<%out.print("<div class='switch'><ul id='ulwidth'>");
for(int i=0;i<TAB.length;i++)
{ 
  out.print("<li><a href='javascript:mt.tab("+i+")' class='"+(i==tab?"current":"")+"'>"+TAB[i]+"<em>"+ShopOrder.count(sql.toString()+SQL[i])+"</em></a></li>");
}
out.print("</ul></div>");
%>

    <script>
        var sumw = 0;
        var ulWidth = document.getElementById("ulwidth");
        var liWidth = document.getElementById("ulwidth").getElementsByTagName("li");
        for(var i=0;i<liWidth.length;i++){
            var liWidths = liWidth[i].clientWidth;
            sumw += liWidths;
            //alert(liWidths);
            //ulWidth.style.width= liWidths+i;
        }
        ulWidth.style.width=sumw+"px";
        
    </script>
    

<form name="form2" action="/ShopOrderDispatchs.do" method="post" target="_ajax">
<input type="hidden" name="dispatch"/>
<input type="hidden" name="tab" value="<%=tab%>"/>
<input type="hidden" name="id" value="<%=menu %>"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<input type="hidden" name="invoiceStatus" value="3"/>
<div class='radiusBox newlist'>

<%
sql.append(SQL[tab]);
int lizinum=0,othernum=0;
int sum=ShopOrder.count(sql.toString());
if(sum<1)
{
  out.print("<ul class='nenecont'><li>暂无记录!</li></ul>");
}else
{
  sql.append(" order by so.createDate desc");
  Iterator it=ShopOrder.find(sql.toString(),pos,20).iterator();
  for(int i=1+pos;it.hasNext();i++)
  {
	  ShopOrder t = (ShopOrder)it.next();
	  ShopOrderDispatch sod=ShopOrderDispatch.findByOrderId(t.getOrderId());
	  
	  /* String uname = MT.f(Profile.find(t.getMember()).getName(h.language));
      if(uname.trim()==null||uname.trim().equals("")||uname.trim().length()<1){
    	  uname = Profile.find(t.getMember()).member;
      } */
      String uname = MT.f(Profile.find(t.getMember()).member);
      
      int status = t.getStatus();
      String statusContent = "";
      if(status==0)
    	  statusContent = "未付款";
      else if(status==1)
    	  statusContent = "确认发货";
      else if(status==2)
    	  statusContent = "未出库";
      else if(status==3)
    	  statusContent = "已出库";
      else if(status==4)
    	  statusContent = "已完成";
      else if(status==5)
    	  statusContent = "已取消";
      
  %>

  <ul>
	<li><span class="pder">订单编号：<%=t.getOrderId()%></span>  <!-- <span class="nub">序号：<strong><%=i%></strong></span> --></li>
	<li>用户名：<%=uname%></li>
	<li>下单时间：<%=MT.f(t.getCreateDate(),1)%></li>
	<li><span class="uname">发票接收人：<%=MT.f(sod.getN_consignees())%></span><span class="titme">电话：<%=MT.f(sod.getN_telphone())%></span></li>
	<li>开票单位：<%=MT.f(sod.getN_company())%></li>
	<li>地址：<%=MT.f(sod.getN_address())%></li>
      <li>厂商：<%=MT.f(ProcurementUnit.findName(t.getPuid()))%></li>

    <%-- <td><%=statusContent%></td> --%>
  <li class="btn"> 
    <%
    	if(t.getInvoiceStatus()==1||t.getInvoiceStatus()==2)
    	{
    		out.print("<button type='button' onclick=\"mt.act('invoice',"+sod.getId()+")\">开具发票</button>");
    		if(t.getInvoiceStatus()==2)
        		out.print("<button type='button' onclick=\"mt.act('submitInvoice',"+sod.getId()+")\">完成</button>");
    	}else if(t.getInvoiceStatus()==3)
    	{
    		if(tab == 3){
	    		ShopExchanged se = ShopExchanged.findByOrderId(t.getOrderId());
	    		if(se.id > 0){
	    			if("".equals(MT.f(sod.getN_invoiceNoNew())))
	    				out.print("<button type='button' onclick=\"mt.act('invoice_edit',"+sod.getId()+")\">开具发票</button>");
	    			else
	    				out.print("<button type='button' onclick=\"mt.act('invoice_edit',"+sod.getId()+")\">查看</button>");
	    		}
    		}else{
    			//out.print("<button type='button' class='btn btn-link' onclick=\"mt.act('print',"+sod.getId()+")\">打印</button>");
    			out.print("<button type='button' onclick=\"mt.act('view',"+sod.getId()+")\">查看发票</button>");
    		}
    	}
    %>
    	
    	
    </li>
    </ul>


  <%}
  if(sum>20)out.print("<div class='page'>"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,20));
}%>
</div>
</div>
</form>

<script>
form2.nexturl.value=location.pathname+location.search;
mt.act=function(a,id)
{
  form2.act.value=a;
  form2.dispatch.value=id;
  if(a=='del')
  {
    mt.show('你确定要删除吗？',2,'form2.submit()');
  }else if(a=='invoice')
  {
    form2.action='/mobjsp/yl/shop/ShopOrderDispatchInvoice.jsp';form2.target='_self';form2.method='get';form2.submit();
  }else if(a=='submitInvoice')
  {
	form2.submit();
  }else if(a=='view')
  {
	form2.action='/mobjsp/yl/shop/ShopOrderDispatchView.jsp';form2.target='_self';form2.method='get';form2.submit();
  }else if(a=='print'){
	  form2.action='/mobjsp/yl/shop/ShopOrderDispatchPrint.jsp';form2.target='_self';form2.method='get';form2.submit();
  }else if(a=='invoice_edit'){
	  mt.show("/mobjsp/yl/shop/ShopInvoiceEdit.jsp?id="+id,2,"添加新的发票号",500,220);
  }
};
</script>
</body>
</html>
