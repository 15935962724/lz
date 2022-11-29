<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.DbAdapter"%>
<%@page import="tea.entity.yl.shop.*"%><%@page import="tea.entity.yl.shopnew.*"%>
<%@page import="java.util.Calendar"%><%@page import="java.text.SimpleDateFormat"%>
<%@page import="tea.entity.member.Profile"%><%


Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}
int menu=h.getInt("id");


//按年份查询

int year=h.getInt("year");
if(year==0){
	Calendar date = Calendar.getInstance();
    year=date.get(Calendar.YEAR);
	
}
//按医院查询

String hname=h.get("hname","");
//总账款（已开票的）
float[] totalarr=new float[12];
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
	//String sql=" and order_id in(select order_id from shoporder where 1=1 and DATEPART(mm,CreateDate) = "+(i+1)+" and datepart(yyyy,createdate) = "+year+" and status in(3,4,7) and ((isclear=0 or isclear is null)or(isclear=1 and invoicestatus=3)))";
	String sql="";
	String sql2="";
	float sum=0;
	float sum2=0;
	if(hname.length()>0){//有医院
		
		List<ShopHospital> lsthospital=ShopHospital.find(" and name="+Database.cite(hname), 0, Integer.MAX_VALUE);
		if(lsthospital.size()>0){
			ShopHospital hospital=lsthospital.get(0);
			float oldnoreply=hospital.getOldnoreply();
			if(oldnoreply>0){
				//这是医院设置了应收账款的
				String timespot=MT.f(hospital.getTimespot2());
				//基数：oldnoreply（应收账款）
				//总账款包括：isclear=0或null时的：未开票订单的金额+已开票订单的金额+基数
				//总账款包括：isclear=1时的：已开票订单的金额
				sql="  and order_id in("
						+"select order_id from shopOrder where order_id in"
						+"(select order_id from shopOrderDispatch where a_hospital="+Database.cite(hname)+")"
						+"and createdate>="+Database.cite(timespot)+" and createdate<"+Database.cite(ymd)+" and (isclear=0 or isclear is null) and status!=5 and status!=6)";
				sql2="  and order_id in("
						+"select order_id from shopOrder where order_id in"
						+"(select order_id from shopOrderDispatch where a_hospital="+Database.cite(hname)+")"
						+"and createdate>="+Database.cite(timespot)+" and createdate<"+Database.cite(ymd)+" and status!=5 and status!=6 and isclear=1 and invoicestatus=3)";
				sum=ShopOrderData.sumamount(sql)+oldnoreply;
				sum2=ShopOrderData.sumamount(sql2);
			}else{
				//这是医院没有设置应收账款时的
				//总账款包括：isclear=0或null时的：未开票订单的金额+已开票订单的金额
				//总账款包括：isclear=1时的：已开票订单的金额
				sql="  and order_id in("
						+"select order_id from shopOrder where order_id in"
						+"(select order_id from shopOrderDispatch where a_hospital="+Database.cite(hname)+")"
						+"and createdate<"+Database.cite(ymd)+" and (isclear=0 or isclear is null) and status!=5 and status!=6)";
				sql2="  and order_id in("
						+"select order_id from shopOrder where order_id in"
						+"(select order_id from shopOrderDispatch where a_hospital="+Database.cite(hname)+")"
						+"and createdate<"+Database.cite(ymd)+" and status!=5 and status!=6 and isclear=1 and invoicestatus=3)";
				sum=ShopOrderData.sumamount(sql);
				sum2=ShopOrderData.sumamount(sql2);
			}
		}
		
	}
	
	totalarr[i]=sum+sum2;
}
//未回款金额（应收账款）
float[] noreamountarr=new float[12];//未回款金额
for(int i=0;i<12;i++){
	
	//noreamountarr[i]=totalarr[i]-inamountarr[i];
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
	//String sql=" and order_id in(select order_id from shoporder where 1=1 and DATEPART(mm,CreateDate) = "+(i+1)+" and datepart(yyyy,createdate) = "+year+" and status in(3,4,7) and ((isclear=0 or isclear is null)or(isclear=1 and invoicestatus=3)))";
	String sql="";
	String sql2="";
	float sum=0;
	float sum2=0;
	if(hname.length()>0){//有医院
		//获取医院的单价
		float hdj=0;
		List<ShopOrderData> lstdata=ShopOrderData.find(" and order_id in(select order_id from shoporder where order_id in(select order_id from shoporderdispatch where a_hospital="+Database.cite(hname)+"))", 0, 1);
		if(lstdata.size()>0){
			ShopOrderData data=lstdata.get(0);
			hdj=data.getAgent_price();
		}
	    List<ShopHospital> lsthospital=ShopHospital.find(" and name="+Database.cite(hname), 0, Integer.MAX_VALUE);
		if(lsthospital.size()>0){
			ShopHospital hospital=lsthospital.get(0);
			float oldnoreply=hospital.getOldnoreply();
			if(oldnoreply>0){
				//这是医院设置应收账款的
				//未回款金额包括：isclear=0或null时的：已开票订单的金额+基数
				//未回款金额包括：isclear=1时的：已开票订单的金额
				String timespot=MT.f(hospital.getTimespot2());
				sql=" and order_id in"
						+"(select order_id from shopOrderDispatch where a_hospital="+Database.cite(hname)+")"
						+"and createdate>="+Database.cite(timespot)+" and createdate<"+Database.cite(ymd)+" and (isclear=0 or isclear is null) and status!=5 and status!=6";
				sql2=" and order_id in"
						+"(select order_id from shopOrderDispatch where a_hospital="+Database.cite(hname)+")"
						+"and createdate>="+Database.cite(timespot)+" and createdate<"+Database.cite(ymd)+" and status!=5 and status!=6 and isclear=1 and invoicestatus=3";
				sum=ShopOrder.sumisinvoiquantity(sql)*hdj-ShopOrder.summatchnum(sql)*hdj+oldnoreply;
				sum2=ShopOrder.sumisinvoiquantity(sql2)*hdj-ShopOrder.summatchnum(sql2)*hdj;
			}else{
				//这是医院没有设置应收账款的
				//未回款金额包括：isclear=0或null时的：已开票订单的金额
				//未回款金额包括：isclear=1时的：已开票订单的金额
				//公式：应收账款=已开票粒子数*单价-已回款总粒子数*单价
				sql=" and order_id in "
						+"(select order_id from shopOrderDispatch where a_hospital="+Database.cite(hname)+")"
						+"and createdate<"+Database.cite(ymd)+" and (isclear=0 or isclear is null) and status!=5 and status!=6";
				sql2=" and order_id in"
						+"(select order_id from shopOrderDispatch where a_hospital="+Database.cite(hname)+")"
						+"and createdate<"+Database.cite(ymd)+" and status!=5 and status!=6 and isclear=1 and invoicestatus=3";
				sum=ShopOrder.sumisinvoiquantity(sql)*hdj-ShopOrder.summatchnum(sql)*hdj;
				sum2=ShopOrder.sumisinvoiquantity(sql2)*hdj-ShopOrder.summatchnum(sql2)*hdj;
			}
		}
	}
	
	noreamountarr[i]=sum+sum2;
}
//已回款金额
float[] inamountarr=new float[12];
for(int i=0;i<12;i++){
	//noreamountarr[i]=totalarr[i]-inamountarr[i];
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
	//String sql=" and order_id in(select order_id from shoporder where 1=1 and DATEPART(mm,CreateDate) = "+(i+1)+" and datepart(yyyy,createdate) = "+year+" and status in(3,4,7) and ((isclear=0 or isclear is null)or(isclear=1 and invoicestatus=3)))";
	String sql="";
	String sql2="";
	float sum=0;
	float sum2=0;
	if(hname.length()>0){//有医院
		//获取医院的单价
		float hdj=0;

		//这是医院设置应收账款的
		//未回款金额包括：isclear=0或null时的：已开票订单的金额+基数
		//未回款金额包括：isclear=1时的：已开票订单的金额
		sql=" and order_id in"
				+"(select order_id from shopOrderDispatch where a_hospital="+Database.cite(hname)+")"
				+"and createdate<"+Database.cite(ymd)+" and (isclear=0 or isclear is null) and status!=5 and status!=6";
		sql2=" and order_id in"
				+"(select order_id from shopOrderDispatch where a_hospital="+Database.cite(hname)+")"
				+"and createdate<"+Database.cite(ymd)+" and status!=5 and status!=6 and isclear=1 and invoicestatus=3";
		sum=ShopOrder.summatchnum(sql)*hdj;
		sum2=ShopOrder.summatchnum(sql2)*hdj;
	
	}
	inamountarr[i]=sum+sum2;
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
<!-- <script src="/tea/Chart.min.js" type="text/javascript"></script>   -->
<script src="/tea/highcharts.js"></script> 
<script src="/tea/exporting.js"></script> 
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
var arr=new Array();  


<%
if(totalarr!=null)
{
 for(int i=0;i<totalarr.length;i++)
 {
%>
 arr[<%=i%>]=<%=totalarr[i] %>;
<%   }
}
%> 
var arr2=new Array();  


<%
if(noreamountarr!=null)
{
 for(int i=0;i<noreamountarr.length;i++)
 {
%>
 arr2[<%=i%>]=<%=noreamountarr[i] %>;
<%   }
}
%> 

var arr3=new Array();  


<%
if(inamountarr!=null)
{
 for(int i=0;i<inamountarr.length;i++)
 {
%>
 arr3[<%=i%>]=<%=inamountarr[i] %>;
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
    var a={ //图表展示容器，与div的id保持一致
        //默认是折线图，所以chart: {type:'line',},不用写
        title: { //头部
            text: '账款金额统计图', //text：标题的文本
            x: -20
        },
        
        xAxis: { //X坐标轴   categories类别
            categories: ['1月','2月','3月','4月','5月','6月','7月','8月','9月','10月','11月','12月'],
            plotLines: [{  //plotLines：标示线
                value: 2,  //定义在哪个值上显示标示线，这里是在x轴上刻度为3的值处垂直化一条线
                width: 2,  //标示线的宽度，2px
                dashStyle:'solid',  //默认值是solid实线，这里定义为虚线
                color: 'red',//线的颜色，定义为红色
            }]
        },
        yAxis: { //Y坐标轴
            title: {
                text: '账款金额'
            },
            plotLines: [{  //plotLines：标示线
                value: 2,  //定义在哪个值上显示标示线，这里是在x轴上刻度为3的值处垂直化一条线
                width: 1,  //标示线的宽度，2px
                dashStyle:'solid',  //默认值，这里定义为实线
                color: '#808080',//线的颜色，定义为灰色
            }]
        },
        tooltip: { //数据提示框
            valueSuffix: '元',  //highcharts 提供了 valuePrefix(前缀)、valueSuffix（后缀） 来给数据添加前缀及后缀
        },                        //比如说 valuePrefix: '￥', valueSuffix: '元'
        legend: { //图例
            layout: 'vertical',  //图例内容布局方式，有水平布局及垂直布局可选，对应的配置值是： “horizontal(水平)”， “vertical(垂直)”
            align: 'left',  //图例在图表中的对齐方式，有 “left”, "center", "right" 可选
            verticalAlign: 'middle',  //垂直对齐方式，有 'top'， 'middle' 及 'bottom' 可选
            borderWidth: 2 //边框宽度
        },
        series:[ //数据列
            {
                name: '总账款',
                data: []
            },{
                 name: '应收账款',
                 data:[]
            } ,{
                name: '已回款',
                data:[]
           } ],
            plotOptions: {//为每个节点显示值  
                line: {  
                    dataLabels: {  
                        enabled: true  
                    },  
                    enableMouseTracking: true  
                },  
            } 
    };
    for(var i = 0; i < arr.length;i++)
    { 
     a.series[0].data.push(arr[i]);
     a.series[1].data.push(arr2[i]);
     a.series[2].data.push(arr3[i]);
     
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
</script>
</body>
</html>
