<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.DbAdapter"%>
<%@page import="tea.entity.yl.shop.*"%><%@page import="tea.entity.yl.shopnew.*"%>
<%@page import="java.util.Calendar"%>
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
int[] numarr=new int[12];
for(int i=0;i<12;i++){
	String sql=" and order_id in(select order_id from shoporder where DATEPART(mm,CreateDate) = "+(i+1)+" and datepart(yyyy,createdate) = "+year+" and status = 4 )";
	int sum=ShopOrderData.sumquantity(sql);
	numarr[i]=sum;
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
  
  
  <td><input type="submit" class="button" value="查询"/></td>
  
</tr>
</table>
</div>
</form>
<div style="width: 100%">
<canvas id="myChart" width="800" height="400"></canvas>
</div>
<script type="text/javascript">

$(document).ready(function(){
	 var year=<%=year %>; //获取选中的年份，没选中是当前年份
	 var year2=new Date().getFullYear();
	    alert(year);
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
})
	

	
    


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

//用于存放图表上的数据
var lineChartData = {  
//表的X轴参数
labels : ["1月","2月","3月","4月","5月","6月","7月","8月","9月","10月","11月","12月"],
datasets : [
    
           /*  {
          	  label: "My First dataset",

             fillColor : "transparent",     //背景色，常用transparent透明
             strokeColor : "rgba(220,220,220,1)",  //线条颜色，也可用"#ffffff"
             pointColor : "rgba(220,220,220,1)",   //点的填充颜色
             pointStrokeColor : "#fff",            //点的外边框颜色
             data : [0,0,0,0,0,0,0,0,0,0,0,0]      //点的Y轴值 
            
          },  */
		   {
		   	label: "订货粒数",
		
		       fillColor : "transparent",
		       strokeColor : "rgba(151,187,205,1)",
		       pointColor : "rgba(151,187,205,1)",
		       pointStrokeColor : "#fff",
		       data : []    //data中的参数，通过下方for循环，获取arr2中的数据
		   } 
  ]
}
for(var i = 0; i < arr2.length;i++)
{ 
 lineChartData.datasets[0].data.push(arr2[i]);//将数组arr2中的值写入data
} 

//定义图表的参数   
var defaults = {    
    scaleStartValue :null,     // Y 轴的起始值
    scaleLineColor : "rgba(0,0,0,.1)",    // Y/X轴的颜色
    scaleLineWidth : 1,        // X,Y轴的宽度
    scaleShowLabels : true,    // 刻度是否显示标签, 即Y轴上是否显示文字   
    scaleLabel : "1", // Y轴上的刻度,即文字  
    scaleFontFamily : "'Arial'",  // 字体  
    scaleFontSize : 20,        // 文字大小 
    scaleFontStyle : "normal",  // 文字样式  
    scaleFontColor : "#666",    // 文字颜色  
    scaleShowGridLines : true,   // 是否显示网格  
    scaleGridLineColor : "rgba(0,0,0,.05)",   // 网格颜色
    scaleGridLineWidth : 2,      // 网格宽度  
    bezierCurve : false,         // 是否使用贝塞尔曲线? 即:线条是否弯曲     
    pointDot : true,             // 是否显示点数  
    pointDotRadius : 8,          // 圆点的大小  
    pointDotStrokeWidth : 1,     // 圆点的笔触宽度, 即:圆点外层边框大小 
    datasetStroke : true,        // 数据集行程
    datasetStrokeWidth : 2,      // 线条的宽度, 即:数据集
    datasetFill : false,         // 是否填充数据集 
    animation : true,            // 是否执行动画  
    animationSteps : 60,          // 动画的时间   
    animationEasing : "easeOutQuart",    // 动画的特效   
    onAnimationComplete : null   // 动画完成时的执行函数   
   
    }
    
window.onload = function(){
	
    var ctx = document.getElementById("myChart").getContext("2d");
    
    //window.myLine = new Chart(ctx).Line(lineChartData,defaults); 
     window.myLine=new Chart(ctx, {
        type:'line',
        data: lineChartData,
        defaults:defaults
      
  });  
  /* window.myLine = new Chart(ctx, {
	    type: 'line',
	    data: lineChartData,
	    options: defaults
	});  */
   
}
</script>
</body>
</html>
