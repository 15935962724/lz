<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.DbAdapter"%><%@page import="java.text.SimpleDateFormat "%>
<%@page import="tea.entity.yl.shop.*"%><%@page import="tea.entity.yl.shopnew.*"%><%@page import="tea.entity.member.Profile"%>
<%@ page import="util.Config" %><%


Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}
int menu=h.getInt("id");
StringBuffer sql=new StringBuffer(),par=new StringBuffer("?");
par.append("&id="+menu);

int puid = Config.getInt(h.get("puid"));
//int puid1 = h.getInt("puid1");
    if(puid!=-1){

        sql.append(" and puid = "+puid);
        par.append("&puid="+h.get("puid"));
    }



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

String[] TAB={"待审核","审核通过","审核不通过"};
String[] SQL={" AND status = 0 "," AND status = 1 "," AND status = 2 "};

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

<style type="text/css">
.newTable tr:hover{background:#fff !important;}
</style>
</head>
<body>
<h1>回款匹配发票管理</h1>
<form name="form1" action="?">
<input type="hidden" name="id" value="<%=menu%>"/>
<input type="hidden" name="tab" value="<%=tab%>"/>
<div class="radiusBox">
<table cellspacing="0" class='newTable'>
<thead>
<tr><td colspan='4'>查询</td></tr>
</thead>
<tr>
  <td>医院：<input type="text" name="hname" id="hname" value="<%=hname %>"/>
	<input id="hospitalsel" onclick="showhospitalsearch()" type="button" value="请选择"/>  
  </td>

  <td>服务商：<input type="text" name="pname" id="pname" value="<%=pname %>"/>
	<input id="hospitalsel" onclick="mt.show('/jsp/yl/shopnew/SelProfile_shop.jsp',1,'选择服务商',500,500)" type="button" value="请选择"/>  
  </td>

    <%--<%
        if(puid == null){
    %>
    <td width="20%">厂商：
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
  <td><input type="submit" class="button" value="查询"/></td>
  
</tr>
</table>
</div>
</form>

<%out.print("<div class='switch'>");
for(int i=0;i<TAB.length;i++)
{ 
  out.print("<a href='javascript:mt.tab("+i+")' class='"+(i==tab?"current":"")+"'>"+TAB[i]+"（"+BackInvoice.count(sql.toString()+SQL[i])+"）</a>");
}
out.print("</div>");
%>
<form name="form2" action="/ReplyMoneys.do" method="post" target="_ajax">

<input type="hidden" name="tab" value="<%=tab%>"/>
<input type="hidden" name="id" value="<%=menu %>"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<input type="hidden" name="backid" />
<input type="hidden" name="nobackreason" />
<div class='radiusBox mt15'>
<table  id="" cellspacing="0" class='newTable'>
<tr>
  
  <th>序号</th>
  <th>回款编号</th>
  <th>类型</th>
  <th>回款单位</th>
  <th>服务商</th>
  <th>回款金额</th>
  <%
  if(Config.getInt("gaoke")==puid){//高科
	  out.print("<th>实际回款金额</th>");
  }
  %>
  <th>服务商匹配金额</th>
  <th>挂款金额</th>
   <%
  if(Config.getInt("gaoke")==puid){//高科
	  out.print("<th>实际挂款金额</th>");
  }
  %>
  <th>应收账款</th>
  <th>剩余应收账款</th>
  <th>回款时间</th>
  <th>状态</th>
  <th>进项税返还政策</th>
  <th>操作</th>
  
</tr>
<%
sql.append(SQL[tab]);
int sum=BackInvoice.count(sql.toString());
if(sum<1)
{
  out.print("<tr><td colspan='11' align='center'>暂无记录!</td></tr>");
}else
{
 
  List<BackInvoice> lstback=BackInvoice.find(sql.toString()+" order by createdate desc ", pos, size);
  for(int i=0;i<lstback.size();i++)
  {
	  BackInvoice back=lstback.get(i);
	  ShopHospital hospital=ShopHospital.find(back.getHospitalid());//回款单位
	  Profile profile=Profile.find(back.getMember());//服务商
	  String replyids=back.getReplyid();//回款id
	  String[] replyidarr=replyids.split(",");
		  double guakuan = 0;
		  //double huikuan = 0;
		  
		  float deductPrice = HangWith.findDeductPriceBid(back.getId());
		  float replyPrice = HangWith.findReplyPricePriceBid(back.getId());//原始金额

		  float cha = 0;
		  //System.out.println(deductPrice);
			if(deductPrice>0){
				cha = back.getHangamount()-deductPrice;
			}
			float replyamount1 = back.getReplyamount() - cha;
		  
	  for(int j=0;j<replyidarr.length;j++){
		  String re=replyidarr[j];
		  ReplyMoney reply=ReplyMoney.find(Integer.parseInt(re));//回款
		  if(j==0){
			  
		  
%>
<tr>
    <td rowspan="<%=replyidarr.length %>"><%=i+1 %></td>
    <td><%=reply.getCode() %></td>
    <td><%=ReplyMoney.typeARR[reply.getType()] %></td>
    <td rowspan="<%=replyidarr.length %>"><%=hospital.getName() %></td>
    <td rowspan="<%=replyidarr.length %>"><%=profile.member %></td>
    <%-- <td><%=ShopHospital.getDecimal((double)reply.getReplyPrice()) %></td> --%>
    <td rowspan="<%=replyidarr.length %>"><%= back.getReplyamount() %></td><!-- 回款金额 -->
    <%
  if(Config.getInt("gaoke")==puid){//高科
	 %>
	 <td rowspan="<%=replyidarr.length %>"><%= replyamount1 %></td><!-- 实际回款金额 -->
	 <%
  }
  %>
    <td rowspan="<%=replyidarr.length %>"><%=ShopHospital.getDecimal((double)back.getMatchamount()) %></td>
    <%-- <td rowspan="<%=replyidarr.length %>"><%=ShopHospital.getDecimal((double)back.getHangamount()) %></td> --%>
    <td >
   <%
  guakuan = back.getHangamount();
   if(replyidarr.length==1){
        //高科
       if(Config.getInt("gaoke")==puid){
          if(replyPrice>0){
              out.print(replyPrice);
          }else{
              out.print(guakuan);
          }
       }else{
           out.print(guakuan);
       }


   }else{
	   out.print("0");
   }
   float deductprice = HangWith.findDeductPriceBid(back.getId());
   //out.print(ShopHospital.getDecimal((double)back.getHangamount()));
   %>
    </td>
    <%
    if(Config.getInt("gaoke")==puid){//高科
    	%>
    	<td rowspan="<%=replyidarr.length %>"><%
    	if(deductprice>0){
    		out.print(deductprice);
    	}else{
    		out.print(guakuan);
    	}
    %></td>
    	<%
    }
    %>
    <td rowspan="<%=replyidarr.length %>"><%= ShopHospital.getDecimal((double)back.getOldnoreply()) %></td>
    <td rowspan="<%=replyidarr.length %>"><%=ShopHospital.getDecimal((double)back.getSoldnoreply()) %></td>
    <td><%=MT.f(reply.getReplyTime()) %></td>
    <td rowspan="<%=replyidarr.length %>"><%=BackInvoice.STATUS[back.getStatus()] %></td>
    <%

        int shinvoice = 0;
        try{
            String[] invoiceidarr=back.getInvoiceid().split(",");
            for(int x=0;x<invoiceidarr.length;x++) {
                shinvoice = Integer.parseInt(invoiceidarr[x]);
            }
        }catch (Exception e){

        }

        int phpuid = InvoiceData.getPuid(shinvoice);

        Invoice invoice1 = Invoice.find(shinvoice);
        ProcurementUnitJoin pj = ProcurementUnitJoin.find(phpuid,profile.profile,invoice1.getHospitalid());
        //ProcurementUnitJoin pj = ProcurementUnitJoin.find(phpuid,profile.profile);
    %>
    <td rowspan="<%=replyidarr.length %>"><%=Profile.TAX[Integer.parseInt(MT.f(pj.tax,0))] %></td>
    <td rowspan="<%=replyidarr.length %>">
    	<button type="button" class="btn btn-link" onclick="mt.act('data','<%=back.getId() %>')">查看详情</button>
    	<%
    		if(back.getStatus()==0){
    	%>
    	<button type="button" class="btn btn-link" onclick="mt.act('backyes','<%=back.getId() %>')">审核通过</button>
    	<button type="button" class="btn btn-link" onclick="mt.act('backno','<%=back.getId() %>')">审核不通过</button>
    	<%
    		}
    	%>
    </td>	
	
</tr>
<%
		  }else{
%>
<tr>
    <td><%=reply.getCode() %></td>
    <td><%=ReplyMoney.typeARR[reply.getType()] %></td>
    <%-- <td><%=ShopHospital.getDecimal((double)reply.getReplyPrice()) %><%= huikuan %></td> --%><!-- 回款金额 -->
    <td><% 
    	if(replyidarr.length-1==j){
    		out.print(guakuan);
    	}else{
    		out.print("0");
    	}
    %></td>
    <td><%=MT.f(reply.getReplyTime()) %></td>
    	
	
</tr>
<%			  
		  }
	  }
  }
  if(sum>20)out.print("<tr class='fenye'><td colspan='11' align='right'>"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,20));
}%>
</table>
</div>
</form>
<div class='center mt15'>
    <button class="btn btn-primary" type="button" onclick="dcorder()">导出</button>
    <%
        if(tab == 1){
            out.print("<button class=\"btn btn-primary\" type=\"button\" onclick=\"expConfirm()\">导出客户回款确认明细表</button>");
        }
    %>
</div>
<form action="/ReplyMoneys.do" name="form3"  method="post" target="_ajax" >
	<input name="act" value="expbackinvoice" type="hidden" />
	<input type='hidden' name="sql" value="<%=sql.toString() %>" />
</form>
<form action="/ReplyMoneys.do" name="form4"  method="post" target="_ajax" >
    <input name="act" value="expConfirm" type="hidden" />
    <input type="hidden" name="status" value="<%=tab%>"/>
</form>


<script>
form2.nexturl.value=location.pathname+location.search;

mt.act=function(a,backid)
{
  form2.act.value=a;
  form2.backid.value=backid;
  if(a=='data')
  {
	  form2.action="/jsp/yl/shopnew/BackInvoiceDatas.jsp";
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

    function expConfirm(){
        form4.submit();
    }


//mt.show('/jsp/yl/shopnew/Selhospital_shop.jsp',1,'选择医院',500,500)
</script>
</body>
</html>
