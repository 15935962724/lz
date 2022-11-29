<%@page import="tea.entity.Http"%>
<%@page import="tea.db.DbAdapter"%>
<%@page import="tea.entity.order.Order"%>
<%@page import="tea.entity.MT"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.0//EN" "http://www.wapforum.org/DTD/xhtml-mobile10.dtd">
<%!
public static int dayForWeek(String pTime) throws Exception {
	  SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
	  Calendar c = Calendar.getInstance();
	  c.setTime(format.parse(pTime));
	  int dayForWeek = 0;
	  if(c.get(Calendar.DAY_OF_WEEK) == 1){
	   dayForWeek = 7;
	  }else{
	   dayForWeek = c.get(Calendar.DAY_OF_WEEK) - 1;
	  }
	  return dayForWeek;
	 }
%>
<style>
#cur{background-color: #FFA500}
.no{color:red }
.ok{color:green}
</style>
<script src="/tea/mt.js"></script>
<script src="/tea/jquery.js"></script>
<%
Http h=new Http(request);
int id=h.getInt("id", 1);
Date date = new Date(); 
SimpleDateFormat sf1 = new SimpleDateFormat("HH:mm");
SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
SimpleDateFormat sdf = new SimpleDateFormat("yyyy年MM月dd日");
String[] dayInt = new String[]
        {"一","二","三","四","五","六","日"};
String nowDate = sdf.format(date);   
//通过日历获取下一天日期  
Calendar cal = Calendar.getInstance();  
cal.setTime(sdf.parse(nowDate));
StringBuffer htm=new StringBuffer();
StringBuffer timehtm=new StringBuffer();
StringBuffer tophtm=new StringBuffer();
for(int i=1;i<=7;i++){
	String nextDate=nowDate;
	if(i!=1){
		cal.add(Calendar.DAY_OF_YEAR, +1);
		nextDate = sdf.format(cal.getTime());
	}
	System.out.println(nextDate);
    if(i==1){
    	timehtm.append(nextDate+"-");
	}else if(i==7){
		timehtm.append(nextDate);
	}
    int shang=Order.count(" and community="+DbAdapter.cite(h.community)+" and code like "+DbAdapter.cite("FC%")+" and reserveTime="+DbAdapter.cite(sdf.parse(nextDate))+" and beginTime<"+DbAdapter.cite(sf1.parse("12:00")));
    int xia=Order.count(" and community="+DbAdapter.cite(h.community)+" and code like "+DbAdapter.cite("FC%")+" and reserveTime="+DbAdapter.cite(sdf.parse(nextDate))+" and beginTime>"+DbAdapter.cite(sf1.parse("12:00")));
    htm.append("<div class='li'><span class='datetime'><p class='nd'>"+nextDate+"</p><p>周"+dayInt[dayForWeek(sf.format(sdf.parse(nextDate)))-1]+"</p></span><a href='###' "+(shang==0?"onclick=submitform('"+sf.format(sdf.parse(nextDate))+"','08:00',this)":"")+" ><span class='"+(shang==0?"ok":"no")+"' >上午</span></a><a href='###' "+(xia==0?"onclick=submitform('"+sf.format(sdf.parse(nextDate))+"','14:00',this)":"")+"><span class='"+(xia==0?"ok":"no")+"'>下午</span></a></div>");  	
}
String left="<a href='###' onclick=send('"+timehtm.toString().split("[-]")[0]+"','0')>＜</a>";
if(timehtm.toString().split("[-]")[0].equals(sdf.format(date))){
	left="<a href='###'>＜</a>";
}
tophtm.append("<span class='left'>"+left+"</span>"+
	    "<span class='mid' id='mid'>"+timehtm.toString()+"</span>"+
	    "<span class='right'><a href='###' onclick=send('"+timehtm.toString().split("[-]")[1]+"','1')>＞</a></span>");
%>
<form method="post" action="/Orders.do" name="form1">
<input type="hidden" name="act" value="FCsubmit">
<input type="hidden" name="date" value="">
<input type="hidden" name="id" value="<%=id%>">
<input type="hidden" name="nexturl" value="/xhtml/flight737sim/folder/14040062-1.htm">
<input type="hidden" name="clock" value="">
<input type="hidden" name="community" value="<%=h.community%>">
<span class="top" id="top">
 <%=tophtm.toString()%>
</span>
<div id="zhong">
<%=htm.toString()%>
</div>
<div class="xia">
<p class="p1">姓名<input name="name" type="text" value=""/></p>
<p class="p2">电话<input name="mobile" type="text" value=""/></p>
</div>
<div class="butt">
<input type="button" onclick=verify() value="预约" class="button">
</div>
</form>
<script>
function submitform(a,b,t){
	form1.date.value=a;
	form1.clock.value=b;
	if(document.getElementById("cur")!=null)
		document.getElementById("cur").setAttribute("id","block");
	t.childNodes[0].setAttribute("id","cur");
}
function verify(){
	if(form1.date.value==""){
		alert("请选择预约时间");
		return;
	}else if(form1.name.value==""){
		alert("请填写您的姓名");
		return;
	}else if(form1.mobile.value==""){
		alert("请填写您的手机号码");
		return;
	}
	form1.submit();
}
function send(a,b){
	mt.send("/mobjsp/plane/ajax.jsp?act=week&datetime="+a+"&type="+b,function(data){
		data=data.trim();
		document.getElementById("zhong").innerHTML=data.split("@")[0];
		document.getElementById("top").innerHTML=data.split("@")[1];
	});
}
</script>