<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.DbAdapter"%>
<%@page import="tea.entity.yl.shop.*"%><%@page import="tea.entity.member.Profile"%><%

//订单管理-全部-企业号

Http h=new Http(request,response);

h.setCook("community", "Home", -1);
String nexturl = h.get("nexturl","/mobjsp/yl/shop/ShopOrders.jsp");
    int qywxMember = h.getInt("qywxMember");
    if(qywxMember>0){
        h.member = qywxMember;
    }
if(h.member<1){
  response.sendRedirect("/PhoneProjectReport.do?act=qy&agentid=1&nexturl="+Http.enc(nexturl));
  return;
}

int menu=h.getInt("id");
StringBuffer sql=new StringBuffer(),par=new StringBuffer();
par.append("?id="+menu);

String order_id=h.get("order_id","");
if(order_id.length()>0)
{
  sql.append(" AND order_id LIKE "+Database.cite("%"+order_id+"%"));
  par.append("&order_id="+h.enc(order_id));
}

Date time0=h.getDate("time0");
if(time0!=null)
{
  sql.append(" AND createDate>"+DbAdapter.cite(time0));
  par.append("&createDate="+MT.f(time0));
}
Date time1=h.getDate("time1");
if(time1!=null)
{
  sql.append(" AND createDate<"+DbAdapter.cite(time1));
  par.append("&createDate="+MT.f(time1));
}

String member=h.get("member","");
if(member.length()>0)
{
  sql.append(" AND m.member LIKE "+Database.cite("%"+member+"%"));
  par.append("&member="+h.enc(member));
}

String[] TAB={"全部订单","未付款","确认发货","出库","买家已收货","已取消"};
String[] SQL={" AND status!=6"," AND status=0"," AND status=1"," AND (status=2 or status=3)"," AND status=4"," AND status=5"};

int tab=h.getInt("tab",0);
par.append("&tab="+tab);

int pos=h.getInt("pos");
par.append("&pos=");



%><!DOCTYPE html><html><head>

<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>


<!-- <link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"> -->
<link href="/res/Home/cssjs/14113995L1.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/jsp/sup/sup.js" type="text/javascript"></script>
<link href="/mobjsp/yl/shopStyle.css" rel="stylesheet" type="text/css">

</head>
<body>
<h1>订单管理</h1>
<form name="form1" action="?">
<input type="hidden" name="id" value="<%=menu%>"/>
<input type="hidden" name="tab" value="<%=tab%>"/>
    
<div class='radiusBox bg'>
<h3>查询</h3>
<ul class="seachr">
 <li><span>订单编号：</span><input name="order_id" placeholder="订单编号" value="<%=MT.f(order_id)%>"/></li>
 <li><span>用户名：</span><input name="member" placeholder="用户名" value="<%=MT.f(member)%>"/></li>
<li><span>订单时间：</span><input name="time0" type="date" placeholder="订单时间" value="<%=MT.f(time0)%>" class="date"/></li>
 <li><span>至：</span><input name="time1" value="<%=MT.f(time1)%>" type="date" class="date"/></li>
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
    

    
<form name="form2" action="/ShopOrders.do" method="post" target="_ajax">
<input type="hidden" name="orderId"/>
<input type='hidden' name='soeid' value=''>
<input type='hidden' name='type' value=''>
<input type="hidden" name="status"/>
<input type="hidden" name="tab" value="<%=tab%>"/>
<input type="hidden" name="id" value="<%=menu %>"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<input type='hidden' name='remarks'>
<div class='radiusBox newlist'>
<%
sql.append(SQL[tab]);
int lizinum=0,othernum=0;
int sum=ShopOrder.count(sql.toString());
if(sum<1)
{
  out.print("<div class='nenecont'>暂无记录!</div>");
}else
{
  sql.append(" order by createDate desc");
  Iterator it=ShopOrder.find(sql.toString(),pos,20).iterator();
  for(int i=1+pos;it.hasNext();i++)
  {
	  ShopOrder t=(ShopOrder)it.next();
      String orderId=t.getOrderId();
      
      /* String uname = MT.f(Profile.find(t.getMember()).getName(h.language));
      if(uname.trim()==null||uname.trim().equals("")||uname.trim().length()<1){
    	  uname = Profile.find(t.getMember()).member;
      } */
      String uname = MT.f(Profile.find(t.getMember()).member);
      
      ShopOrderExpress soe=null;
      ArrayList list =ShopOrderExpress.find(" and order_id="+DbAdapter.cite(t.getOrderId()),0,1);
      soe = list.size() < 1 ? new ShopOrderExpress(0):(ShopOrderExpress)list.get(0);
      
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
        <li class="lines"><span class="pder">订单：<%=t.getOrderId()%></span><span class="nub oks"><%if(tab==0){%><%=statusContent%><%}%></span>
        </li>
            <li class="lines"><span class="uname">用户：<%=uname%></span><span class="titme">时间：<%=MT.f(t.getCreateDate(),1)%></span></li>
        <li class="lines mn">订单金额：<strong><em>&yen;<%=MT.f((double)t.getAmount(),2)%></em></strong></li> 
       

   
  <li class="btn">
    	<%
    	if(status==1||(status==0&&Profile.find(t.getMember()).isvip==1))
    		out.println("<button type='button' class='btn btn-link' onclick=\"mt.act('status','"+orderId+"',2,'发货');\">确认发货</button>");
    	if(status==2)
    	{
    		out.println("<button type='button' class='btn btn-link' onclick=\"mt.act('exp','"+orderId+"',"+soe.id+",1);\">"+(soe.time==null?"添加出厂信息":"修改出厂信息")+"</button>");
    		if(soe.time!=null)
    			out.println("<button type='button' class='btn btn-link' onclick=\"mt.act('status','"+orderId+"',3,'出库');\">完成出库</button>");
    	}
    	if(!t.isPayment()&&status==1&&status==4)
    		out.println("<button type='button' class='btn btn-link' onclick=\"mt.act('payment','"+orderId+"');\">确认收款</button>");
    	%>
    	 <button type="button" class="btn btn-link" onclick="mt.act('data','<%=orderId%>')">查看详情</button>
    	 <%
    	 if("webmaster".equals(Profile.find(h.member).member))
    	 {
    	 %>
    	 <button type="button" class="btn btn-link" onclick="mt.act('del','<%=orderId%>')">删除</button>
    	 <%
    	 }
    	 %>
    	 <%
    	 //out.print("<button type='button' class='btn btn-link' onclick=\"mt.act('updateremarks','"+orderId+"',2,'"+MT.f(t.getRemarks())+"');\">备注</button>");
    	 %>
             
             
    </li>
    </ul>
 
  <%}
  if(sum>20)out.print("<div class='page'>"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,20));
}%>
</div>
           
</form>
<script>
form2.nexturl.value=location.pathname+location.search;
mt.act=function(a,id,status,statusContent)
{
  form2.act.value=a;
  form2.orderId.value=id;
  if(a=='del')
  {
    mt.show('你确定要删除吗？',2,'form2.submit()');
  }else if(a=='status')
  {
	  form2.status.value=status;
	  mt.show('你确定要“'+statusContent+'”吗？',2,'form2.submit()');
  }else if(a=='data')
  {
	  form2.action=("/mobjsp/yl/shop/ShopOrderDatas.jsp");
	  form2.target='_self';form2.method='get';form2.submit();
  }else if(a=='payment')
  {
	  mt.show('你确定要“确认收款”吗？',2,'form2.submit()');
  }else if(a=='exp')
  {
	  form2.soeid.value=status;
	  form2.type.value=statusContent;
	  form2.action=("/mobjsp/yl/shop/ShopExpressEdit.jsp");
	  form2.target='_self';form2.method='get';form2.submit();
  }else if(a=='updateremarks'){
	  mt.show("<textarea id='_content' cols='33' rows='6' title='备注'>"+statusContent+"</textarea>",2,'备注',348);
      mt.ok=function()
      {
        var t=$$('_content');
        /* if(t.value=='')
        {
          alert('“取消订单原因”不能为空！');
          return false;
        } */
        form2.remarks.value=t.value;
        form2.submit();
      };
  }
};
</script>
</body>
</html>
