<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.DbAdapter"%>
<%@page import="tea.entity.yl.shop.*"%><%@page import="tea.entity.yl.shopnew.*"%>
<%@page import="java.util.Calendar"%>
<%@page import="tea.entity.member.Profile"%>
<%@ page import="util.Config" %><%


Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}
int menu=h.getInt("id");


int puid = Config.getInt(h.get("puid"));

//按年份查询

int year=h.getInt("year");
if(year==0){
	Calendar date = Calendar.getInstance();
    year=date.get(Calendar.YEAR);
	
}
//按医院查询

String hname=h.get("hname","");
int weikai=0;//医院设置中的未开数量
int yikai=0;//医院设置中的已开数量
if(hname.length()>0){
	//获取未开数量和已开数量
			List<ShopHospital> lsthospital=ShopHospital.find(" and name ="+Database.cite(hname), 0, 1);
			if(lsthospital.size()>0){
				ShopHospital ht=lsthospital.get(0);
				weikai=ht.getOldnoinvoice();
				yikai=ht.getOldisinvoice();
				if(weikai==-1){
					weikai=0;
				}
				if(yikai==-1){
					yikai=0;
				}
			}
}
//总粒数
int[] numarr=new int[12];
for(int i=0;i<12;i++){
	//String sql=" and order_id in(select order_id from shoporder where DATEPART(mm,CreateDate) = "+(i+1)+" and datepart(yyyy,createdate) = "+year+" and status in(3,4,7) and ((isclear=0 or isclear is null)or(isclear=1 and invoicestatus=3)))";
	//拼接年-月-日
	String ymd="";
	int y=0;
	int m=0;
	if(i==11){
		y=year+1;
		m=1;
	}else{
		y=year;
		m=i+2;
		
	}
	ymd=y+"-"+m+"-01";
	String sql="";
	//String sql2="";
	
	if(hname.length()>0){//有医院
		//sql：未开票数量 sql2：已开票数量  sql+sql:总数量
		sql="  and order_id in("
			+"select order_id from shopOrder where order_id in"
			+"(select order_id from shopOrderDispatch where a_hospital="+Database.cite(hname)+")"
			+"and createdate<"+Database.cite(ymd)+" and (isclear=0 or isclear is null) and status!=5 and status!=6) AND puid = "+puid;
		/* sql2="  and order_id in("
				+"select order_id from shopOrder where order_id in"
				+"(select order_id from shopOrderDispatch where a_hospital="+Database.cite(hname)+")"
				+"and createdate<"+Database.cite(ymd)+" and status!=5 and status!=6 and isclear=1 and invoicestatus=3)"; */
		
	}else{
		//没有医院
		sql=" and order_id in(select order_id from shopOrder where createdate<"+Database.cite(ymd)+" and (isclear=0 or isclear is null) and status!=5 and status!=6) AND puid = "+puid;
		//sql2=" and order_id in(select order_id from shopOrder where createdate<"+Database.cite(ymd)+" and status!=5 and status!=6 and isclear=1 and invoicestatus=3)";
	}
	/* int sum=ShopOrderData.sumquantity(sql);
	int sum2=ShopOrderData.sumquantity(sql2); */
	
	int sum=ShopOrder.sumnoinvoiquantity(sql)+weikai;
	int sum2=ShopOrder.sumisinvoiquantity(sql)+yikai;
	numarr[i]=sum+sum2;
}
//已开票粒数
int[] invoicenumarr=new int[12];
for(int i=0;i<12;i++){
	//拼接年-月-日
	String ymd="";
	int y=0;
	int m=0;
	if(i==11){
		y=year+1;
		m=1;
	}else{
		y=year;
		m=i+2;
		
	}
	ymd=y+"-"+m+"-01";
	//String sql=" and  DATEPART(mm,CreateDate) = "+(i+1)+" and datepart(yyyy,createdate) = "+year+" and status in(3,4,7) and ((isclear=0 or isclear is null)or(isclear=1 and invoicestatus=3))";
	String sql="";
	//String sql2="";
	if(hname.length()>0){//有医院
		/* sql="  and order_id in("
			+"select order_id from shopOrder where order_id in"
			+"(select order_id from shopOrderDispatch where a_hospital="+Database.cite(hname)+")"
			+"and createdate<"+Database.cite(ymd)+" and (isclear=0 or isclear is null) and status!=5 and status!=6)"; */
		sql="  and order_id in("
				+"select order_id from shopOrder where order_id in"
				+"(select order_id from shopOrderDispatch where a_hospital="+Database.cite(hname)+")"
				+"and createdate<"+Database.cite(ymd)+" and (isclear=0 or isclear is null) and status!=5 and status!=6) AND puid = "+puid;
		/* sql2="  and order_id in("
			+"select order_id from shopOrder where order_id in"
			+"(select order_id from shopOrderDispatch where a_hospital="+Database.cite(hname)+")"
			+"and createdate<"+Database.cite(ymd)+" and status!=5 and status!=6 and isclear=1 and invoicestatus=3)"; */
	}else{
		//没有医院
		sql=" and order_id in(select order_id from shopOrder where createdate<"+Database.cite(ymd)+" and (isclear=0 or isclear is null) and status!=5 and status!=6) AND puid = "+puid;
		//sql=" and order_id in(select order_id from shopOrder where createdate<"+Database.cite(ymd)+" and status!=5 and status!=6 and isclear=1 and invoicestatus=3)";
	}
	int sum=ShopOrder.sumisinvoiquantity(sql)+yikai;
	//int sum2=ShopOrder.sumisinvoiquantity(sql2);
	//invoicenumarr[i]=sum+sum2;
	invoicenumarr[i]=sum;
}
//未开票粒数
/* int[] noinvoicenumarr=new int[12];
for(int i=0;i<12;i++){
	noinvoicenumarr[i]=numarr[i]-invoicenumarr[i];
} */
//未开票粒数
int[] noinvoicenumarr=new int[12];
for(int i=0;i<12;i++){
	//拼接年-月-日
	String ymd="";
	int y=0;
	int m=0;
	if(i==11){
		y=year+1;
		m=1;
	}else{
		y=year;
		m=i+2;
		
	}
	ymd=y+"-"+m+"-01";
	//String sql=" and  DATEPART(mm,CreateDate) = "+(i+1)+" and datepart(yyyy,createdate) = "+year+" and status in(3,4,7) and ((isclear=0 or isclear is null)or(isclear=1 and invoicestatus=3))";
	String sql="";
	//String sql2="";
	if(hname.length()>0){//有医院
		/* sql="  and order_id in("
			+"select order_id from shopOrder where order_id in"
			+"(select order_id from shopOrderDispatch where a_hospital="+Database.cite(hname)+")"
			+"and createdate<"+Database.cite(ymd)+" and (isclear=0 or isclear is null) and status!=5 and status!=6)"; */
		sql="  and order_id in("
				+"select order_id from shopOrder where order_id in"
				+"(select order_id from shopOrderDispatch where a_hospital="+Database.cite(hname)+")"
				+"and createdate<"+Database.cite(ymd)+" and (isclear=0 or isclear is null) and status!=5 and status!=6) AND puid = "+puid;
		/* sql2="  and order_id in("
			+"select order_id from shopOrder where order_id in"
			+"(select order_id from shopOrderDispatch where a_hospital="+Database.cite(hname)+")"
			+"and createdate<"+Database.cite(ymd)+" and status!=5 and status!=6 and isclear=1 and invoicestatus=3)"; */
	}else{
		//没有医院
		sql=" and order_id in(select order_id from shopOrder where createdate<"+Database.cite(ymd)+" and (isclear=0 or isclear is null) and status!=5 and status!=6) AND puid = "+puid;
		//sql=" and order_id in(select order_id from shopOrder where createdate<"+Database.cite(ymd)+" and status!=5 and status!=6 and isclear=1 and invoicestatus=3)";
	}
	int sum=ShopOrder.sumnoinvoiquantity(sql)+weikai;
	//int sum2=ShopOrder.sumisinvoiquantity(sql2);
	//invoicenumarr[i]=sum+sum2;
	noinvoicenumarr[i]=sum;
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
<script src="/tea/Chart.js"></script> 

<script src="/tea/highcharts.js"></script> 
<script src="/tea/exporting.js"></script> 
<!-- <script src="/tea/Chart.min.js" type="text/javascript"></script>   -->
</head>
<body>
<h1>统计图</h1>
<form name="form1" action="?">
<input type="hidden" name="id" value="<%=menu%>"/>

<div class="radiusBox">
<table cellspacing="0" class='newTable'>
<thead>
<tr><td colspan='3'>查询</td></tr>
</thead>
<tr>
  <td>年份：
  	<select name="year" id="sel"></select>
  </td>
  <td>医院：<input type="text" name="hname" id="hname" value="<%=hname %>" readonly/>
	<input id="hospitalsel" onclick="mt.show('/jsp/yl/shopnew/Selhospital_shop.jsp',1,'选择医院',500,450)" type="button" value="请选择"/>
	<input type="button" value="清空医院" onclick="fnclearhname()"/>  
  </td>
  
  <td><input type="submit" class="button" value="查询"/></td>
  
</tr>
</table>
</div>
</form>
<div id="container" style="width: 100%">
<!-- <canvas id="myChart" width="800" height="400"></canvas> -->
</div>

<script type="text/javascript">
var arr2=new Array();  


<%
if(numarr!=null)
{
 for(int i=0;i<numarr.length;i++)
 {
%>
 arr2[<%=i%>]=<%=numarr[i] %>;
<%   }
}
%> 

var arr3=new Array();  


<%
if(invoicenumarr!=null)
{
 for(int i=0;i<invoicenumarr.length;i++)
 {
%>
 arr3[<%=i%>]=<%=invoicenumarr[i] %>;
<%   }
}
%> 

var arr4=new Array();  


<%
if(noinvoicenumarr!=null)
{
 for(int i=0;i<noinvoicenumarr.length;i++)
 {
%>
 arr4[<%=i%>]=<%=noinvoicenumarr[i] %>;
<%   }
}
%> 

$(function(){
	var year=<%=year %>; //获取选中的年份，没选中是当前年份
	 var year2=new Date().getFullYear();
	    
	   var sel = document.getElementById ('sel');//获取select下拉列表
	   for ( var i = 2010; i <= year2; i++)//循环添加2010到当前年份
	   {
	       var option = document.createElement ('option');
	       option.value = i;
	       if(i==year){
	    	   option.selected='selected';
	       }  
	       var txt = document.createTextNode (i);
	       option.appendChild (txt);
	       sel.appendChild (option);
	   }
	   
	   //开始
	   //结束
    var a={ //图表展示容器，与div的id保持一致
        //默认是折线图，所以chart: {type:'line',},不用写
        title: { //头部
            text: '粒子数统计图', //text：标题的文本
            x: -20
        },
        
        xAxis: { //X坐标轴   categories类别
            categories: ['1月','2月','3月','4月','5月','6月','7月','8月','9月','10月','11月','12月']
        },
        yAxis: { //Y坐标轴
            title: {
                text: '粒子数'
            }
        },
        tooltip: { //数据提示框
            valueSuffix: '粒',  //highcharts 提供了 valuePrefix(前缀)、valueSuffix（后缀） 来给数据添加前缀及后缀
            crosshairs: [{
                width: 1,
                color: 'red'
            }, {
                width: 1,
                color: 'red'
            }],
            shared: true
        },                        //比如说 valuePrefix: '￥', valueSuffix: '元'
        credits:{
        	enabled:false  
        },
        series:[ //数据列
            {  //数据列中的 name 代表数据列的名字，并且会显示在数据提示框（Tooltip）及图例（Legend）中
                name: '总粒数',
                data:[]
                
            },{
                name: '已开票粒子数',
                data: []
            },{
                 name: '未开票粒子数',
                 data:[]
            }],
            plotOptions: {//为每个节点显示值  
                
                spline: {
                    marker: {
                       radius: 4,
                       lineColor: '#666666',
                       lineWidth: 1
                    }
                 }
            } 
    };
    for(var i = 0; i < arr2.length;i++)
    { 
     a.series[0].data.push(arr2[i]);//将数组arr2中的值写入data
     a.series[1].data.push(arr3[i]);//将数组arr3中的值写入data
     a.series[2].data.push(arr4[i]);//将数组arr4中的值写入data
    } 
    $('#container').highcharts(a);
});
Highcharts.setOptions({
    lang: {
            printChart:"打印图表",
              downloadJPEG: "下载JPEG 图片" ,
              downloadPDF: "下载PDF文档"  ,
              downloadPNG: "下载PNG图片"  ,
              downloadSVG: "下载SVG矢量图"
    }
});

mt.receive=function(v,n,h){
  

document.getElementById("hname").value=v;
};

function fnclearhname(){
	var hname=$("#hname").val();
	if(hname!=""){
		$("#hname").val("");
	}
}
</script>
</body>
</html>
