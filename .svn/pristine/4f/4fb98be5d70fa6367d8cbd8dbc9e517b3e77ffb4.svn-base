<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%><%@page import="tea.entity.*"%><%@page import="tea.entity.member.*"%><%@page import="tea.ui.*"%><%@page import="tea.entity.sup.*"%>
<%@page import="tea.entity.yl.shop.ShopHospital"%><%@page import="java.math.BigDecimal"%>
<%@page import="tea.entity.yl.shopnew.SetDataRecord"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}
String nexturl = h.get("nexturl");
int id=h.getInt("id");

ShopHospital sh = ShopHospital.find(id);

StringBuffer sql=new StringBuffer(), par=new StringBuffer();
int menuid=h.getInt("id");
par.append("?community="+h.community+"&id="+menuid);
int pos=h.getInt("pos");
par.append("&pos=");




%><html>
<head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src='/tea/jquery.js'></script>
</head>
<body onload="changeSelected();">
<h1>医院管理</h1>

<form name="form1" action="/ShopHospitals.do" method="post" target="_ajax" onSubmit="return mt.check(this)">
<input type="hidden" name="id" value="<%=id%>"/>
<input type="hidden" name="nexturl" value="<%=h.get("nexturl") %>"/>
<input type="hidden" name="act" value="editendtime"/>
<input type="hidden" name="issetinvoice" value=""/>
<input type="hidden" name="issetreply" value=""/>
<table id="tablecenter">
  <tr>
    <td align="right">医院名称：</td>
    <td><%=MT.f(sh.getName())%></td>
  </tr>
  
  
   <tr>
  	<td>已开票粒子数:</td>
	<td>
	
	<input type="text" name="oldisinvoice" id="oldisinvoice"  value="<%=sh.getOldisinvoice()==-1?"":sh.getOldisinvoice() %>"  onkeyup="value=value.replace(/[^\d]/g,'')"/>
	</td>
  </tr>
  <tr>
  	<td>未开票粒子数:</td>
	<td>
	
	<input type="text" name="oldnoinvoice" id="oldnoinvoice"  value="<%=sh.getOldnoinvoice()==-1?"":sh.getOldnoinvoice() %>"  onkeyup="value=value.replace(/[^\d]/g,'')"/>
	</td>
  </tr>
   <tr>
  	<td>未开票已开票粒子数日期节点:</td>
	<td>
	
	<input type="text" name="timespot" id="timespot" value="<%=MT.f(sh.getTimespot()) %>" readonly="readonly" onclick="mt.date(this)"/>
	</td>
  </tr>
  <tr>
  	<td>应收账款:</td>
	<td>
	<%
		String yingshou="";
	    if(sh.getOldnoreply()!=-1){
			
		
			Double nor=sh.getOldnoreply();
			
			yingshou=ShopHospital.getDecimal(nor);
			
			
		}
	%>
	<input type="text" name="oldnoreply" id="oldnoreply" value="<%=yingshou %>"   />
	
	</td>
  </tr>
  <tr>
  	<td>应收账款日期节点:</td>
	<td>
	
	<input type="text" name="timespot2" id="timespot2" value="<%=MT.f(sh.getTimespot2()) %>"  readonly="readonly" onclick="mt.date(this)"/>
	</td>
  </tr>
</table>
 	<%
        if(MT.f(sh.getTimespot())==""){
    %>
    <button class="btn btn-primary" type="button" onclick="return fnedit()">提交粒子数</button>&nbsp;&nbsp;&nbsp;&nbsp;
    <%
        }
    %>
    <%
        if(MT.f(sh.getTimespot2())==""){
    %>
    <button class="btn btn-primary" type="button" onclick="return fnedit2()">提交账款</button>&nbsp;&nbsp;&nbsp;&nbsp;
    <%
        }
    %>
    <button class="btn btn-default" type="button" onclick="location='<%=nexturl%>'">返回</button>&nbsp;&nbsp;&nbsp;&nbsp;
    <%
        if(MT.f(sh.getTimespot())!=""){
    %>
    <button class="btn btn-default" type="button" onclick="mt.act('delendtime',<%=id %>)">退回粒子数</button>
    <%
        }
    
        if(MT.f(sh.getTimespot2())!=""){
        List<SetDataRecord> lstRecord=SetDataRecord.find(" and status !=0 and hospitalid = "+sh.getId(), 0, Integer.MAX_VALUE);
        if(lstRecord.size()==0){
    %>
    <button class="btn btn-default" type="button" onclick="mt.act('delendtime2',<%=id %>)">退回账款</button>
    <%
        }
        }
    %>
</form>
<table id="tablecenter">
  <tr>
  	<td>序号</td>
  	<td>操作时间</td>
  	<td>操作人</td>
  	<td>操作</td>
  	<td>未开票粒子数</td>
  	<td>已开票粒子数</td>
  	<td>粒子数日期节点</td>
  	<td>应收账款</td>
  	<td>应收账款日期节点</td>
  	<td>回款金额</td>
  	<td>剩余回款</td>
  </tr>
  <%
  sql.append(" and hospitalid="+id);
  int sum=SetDataRecord.count(sql.toString());
  if(sum<1)
  {
    out.print("<tr><td colspan='8' class='noCont'>暂无记录!</td></tr>");
  }else
  {
       List<SetDataRecord> lstrecord=SetDataRecord.find(sql.toString()+" order by createdate desc ",pos, 5);
       for(int i=0;i<lstrecord.size();i++){
    	   SetDataRecord record=lstrecord.get(i);
  %>
  <tr>
  	<td><%=i+1 %></td>
  	<td><%=MT.f(record.getCreatedate(),1) %></td>
  	<td><%=Profile.find(record.getMember()).member %></td>
  	<td><%=SetDataRecord.ISBACK[record.getIsback()] %></td>
  	<td><%=record.getNoinvoice()==-1?"":record.getNoinvoice() %></td>
  	<td><%=record.getIsinvoice()==-1?"":record.getIsinvoice() %></td>
  	<td><%=MT.f(record.getTimespot())  %></td>
  	<td>
  		<%
  			if(record.getNoreply()==-1){
  				out.print("");
  			}else{
  				Double nor=record.getNoreply();
  				
  				out.print(ShopHospital.getDecimal(nor));
  				
  				
  			}
  		%>
  	</td>
  	<td><%=MT.f(record.getTimespot2())  %></td>
  	<td>
  		<%
  			
				Double rep=record.getReplymoney();
				
				out.print(ShopHospital.getDecimal(rep));
				
  				
  			
  		%>
  	</td>
  	<td>
  	<%
  			
				Double rem=record.getRemainmoney();
				if(rem.toString().indexOf("E")>-1){
					out.print(ShopHospital.getDecimal(rem));
				}else{
					out.print(rem);
				}
  				
  			
  		%>
  	</td>
  </tr>
  <%
       }
   if(sum>5)out.print("<tr><td colspan='10' align='right'>"+new tea.htmlx.FPNL(h.language,par.toString(),pos,sum,5));
  }
  %>
</table>
<script type="text/javascript">
$(document).ready(function(){
	if($("#setnoinvoice").attr("checked")==true){
		$("#setnoinvoice").val("1");
	}
	if($("#setnoreply").attr("checked")==true){
		$("#setnoreply").val("1");
	}
})
form1.nexturl.value=location.pathname+location.search;
mt.act=function(a,id)
{
  form1.act.value=a;
  form1.id.value=id;
  if(a=='delendtime'){
	  mt.show("确定要退回粒子数操作吗？",2);
		mt.ok=function(){
			form1.submit();
		}
  }
  if(a=='delendtime2'){
	  mt.show("确定要退回账款操作吗？",2);
		mt.ok=function(){
			form1.submit();
		}
  }
  
};
	//提交粒子数
    function fnedit(){
    	var oldisinvoice=$("#oldisinvoice").val();
    	var oldnoinvoice=$("#oldnoinvoice").val();
    	
    	
    	var timespot=$("#timespot").val();
    	if(oldisinvoice==''){
    		mt.show("请填写已开票粒子数！");
    		return false;
    	}
    	if(oldnoinvoice==''){
    		mt.show("请填写未开票粒子数！");
    		return false;
    	}
    	if(timespot==''){
    		mt.show("请填写日期节点！");
    		return false;
    	}
    	if(oldnoinvoice!=''&&timespot!=''){
    		
    		form1.submit();
    		
    	}
    }
	//提交账款
function fnedit2(){
    	
    	var oldnoreply=$("#oldnoreply").val();
    	var timespot2=$("#timespot2").val();
    	
    	if(oldnoreply==''){
    		mt.show("请填写应收账款！");
    		return false;
    	}
    	if(timespot2==''){
    		mt.show("请填写日期节点！");
    		return false;
    	}
    	if(oldnoreply!=''&&timespot2!=''){
    	
    			form1.act.value="editendtime2";
    			form1.submit();
    		
    	}
    	
    	
    }
    
</script>
</body>
</html>
