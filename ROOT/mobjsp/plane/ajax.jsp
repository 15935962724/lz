<%@page import="tea.db.DbAdapter"%>
<%@page import="tea.entity.order.Order"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="tea.entity.Http"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<%
request.setCharacterEncoding("UTF-8");
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
Http h=new Http(request);
String act=h.get("act", "");
if("week".equals(act)){
	int type=h.getInt("type", 1);
	SimpleDateFormat sf1 = new SimpleDateFormat("HH:mm");
	SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy年MM月dd日");
	String[] dayInt = new String[]
	        {"一","二","三","四","五","六","日"};
	String time=h.get("datetime");
	//通过日历获取下一天日期  
	Calendar cal = Calendar.getInstance();  
	cal.setTime(sdf.parse(time));
	StringBuffer htm=new StringBuffer();
	StringBuffer timehtm=new StringBuffer();
	StringBuffer tophtm=new StringBuffer();
	for(int i=1;i<=7;i++){
		if(type==0&&i==1){
			cal.add(Calendar.DAY_OF_YEAR, -7);
		}else{
			cal.add(Calendar.DAY_OF_YEAR, +1);
		}
		String nextDate = sdf.format(cal.getTime());
		System.out.println(nextDate);
	    if(i==1){
	    	timehtm.append(nextDate+"-");
		}else if(i==7){
			timehtm.append(nextDate);
		}
	    int shang=Order.count(" and code like "+DbAdapter.cite("FC%")+" and reserveTime="+DbAdapter.cite(sdf.parse(nextDate))+" and beginTime<"+DbAdapter.cite(sf1.parse("12:00")));
	    int xia=Order.count(" and code like "+DbAdapter.cite("FC%")+" and reserveTime="+DbAdapter.cite(sdf.parse(nextDate))+" and beginTime>"+DbAdapter.cite(sf1.parse("12:00")));
	    htm.append("<div class='li'><span class='datetime'><p class='nd'>"+nextDate+"</p><p>周"+dayInt[dayForWeek(sf.format(sdf.parse(nextDate)))-1]+"</p></span><a href='###' "+(shang==0?"onclick=submitform('"+sf.format(sdf.parse(nextDate))+"','08:00',this)":"")+" ><span class='"+(shang==0?"ok":"no")+"' >上午</span></a><a href='###' "+(xia==0?"onclick=submitform('"+sf.format(sdf.parse(nextDate))+"','14:00',this)":"")+"><span class='"+(xia==0?"ok":"no")+"'>下午</span></a></div>");  	

	    	
	}
	String left="<a href='###' onclick=send('"+timehtm.toString().split("[-]")[0]+"','0')>＜</a>";
	if(timehtm.toString().split("[-]")[0].equals(sdf.format(new Date()))){
		left="<a href='###'>＜</a>";
	}
	tophtm.append("<span class='left'>"+left+"</span>"+
		    "<span class='mid' id='mid'>"+timehtm.toString()+"</span>"+
		    "<span class='right'><a href='###' onclick=send('"+timehtm.toString().split("[-]")[1]+"','1')>＞</a></span>");
	out.print(htm.toString()+"@"+tophtm.toString());
}
%>