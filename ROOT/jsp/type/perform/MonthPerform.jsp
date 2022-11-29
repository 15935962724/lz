<%@page contentType="text/html;charset=UTF-8" %><%@   page   language="java"   import="java.util.*"   %>
<%@ page import="tea.db.DbAdapter"%>
<%@ page import="tea.resource.Resource"%>
<%@ page import="tea.entity.admin.*" %>
<%@ page import="tea.ui.TeaSession" %>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="tea.entity.node.*"%>
<%!   String   days[];   %>
<%

response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
//if(teasession._rv==null)
//{
  //  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  //  return;
  //}
  String community=teasession._strCommunity;


  String nexturl = request.getRequestURI()+"?node="+teasession._nNode+request.getContextPath();
  if(teasession.getParameter("nexturl")!=null)
  {
    nexturl = teasession.getParameter("nexturl");
  }

String id = teasession.getParameter("id");

  long l5 = System.currentTimeMillis();
  Date date = new Date(l5);
  Calendar calendar = Calendar.getInstance();
  calendar.setTime(date);


  int CUR_YEAR = calendar.get(1);
  int CUR_MON  = calendar.get(2) + 1;
  int CUR_DAY = calendar.get(5) ;

  String  SYEAR=request.getParameter("YEAR");
  String SMONTH=request.getParameter("MONTH");
  String FIELDNAME=request.getParameter("FIELDNAME");
  if(SYEAR==null)
  SYEAR =(new Integer(CUR_YEAR)).toString();
  if(SMONTH==null)
  SMONTH =(new Integer(CUR_MON)).toString();
  int YEAR=Integer.parseInt(SYEAR);
  int MONTH=Integer.parseInt(SMONTH);

SimpleDateFormat sdw = new SimpleDateFormat("E"); 
SimpleDateFormat sd = new SimpleDateFormat("yyyy-MM-dd");  


  String   year="";
  String   month="";

  year=teasession.getParameter("year");
  month=teasession.getParameter("month");


  days=new   String[42];
  for(int   i=0;i<42;i++)
  {
    days[i]="";
  }

  Calendar   thisMonth=Calendar.getInstance();
  if(month!=null&&(!month.equals("null")))
  {
    thisMonth.set(Calendar.MONTH,Integer.parseInt(month));
  }
  else
  {
    month=String.valueOf(thisMonth.get(Calendar.MONTH));
  }
  if(year!=null&&(!year.equals("null")))
  {
    thisMonth.set(Calendar.YEAR,Integer.parseInt(year));
  }else
  {
    year=String.valueOf(thisMonth.get(Calendar.YEAR));
  }



  thisMonth.setFirstDayOfWeek(Calendar.SUNDAY);
  thisMonth.set(Calendar.DAY_OF_MONTH,1);
  int   firstIndex=thisMonth.get(Calendar.DAY_OF_WEEK)-1;     //在星期几开始 是一号
  int   maxIndex=thisMonth.getActualMaximum(Calendar.DAY_OF_MONTH); //判断一个月多少天
  Date d = new Date();
  int dd = d.getDate();
  for(int   i=0;i<maxIndex;i++)
  {
    days[firstIndex+i]=String.valueOf(i+1);
  }
  int  years = Integer.parseInt(year);


  %>






<script type="text/javascript" language="javascript" src="/tea/tea.js"></script>
<script type="text/javascript">
function f_a2(igd,y,m)//月份的加减
  {
    var addy=y;
    var addm=m;

    if(igd=='+')
    {

      if((parseInt(addm)+1)==12)
      {
        addm = 0;
        addy = parseInt(addy)+1;
      }else
      {
        addm = parseInt(addm)+1;
      }
    }
    if(igd=='-')
    {
      if((parseInt(addm)+1)==1)
      {
        addm = 11;
        addy = parseInt(addy)-1;
      }else
      {
        addm = parseInt(addm)-1;
      }
    }
    var mm="/html/folder/"+Monthform.node.value+"-1.htm?community="+Monthform.community.value+"&month="+addm+"&year="+addy;
    window.open(mm,"_self");


  }
</script>
  <FORM   name="Monthform"   method="post"   action="?">
<input type="hidden" name="community" value="<%=teasession._strCommunity %>">
  <input type="hidden" name="nexturl" value="<%=nexturl%>" />
    <input type="hidden" name="id" value="<%=teasession.getParameter("id")%>" />
<input type="hidden" name="node" value="<%=teasession._nNode %>">
    <div class="Arrangements">
     <div class="title">月度演出安排</div>
   <div class="function">
      <table   border="0" >
        <tr id="TableControl">
         
            <td><a href="#" onClick="f_a2('-','<%=year%>','<%=month%>');"><img src="/res/REDCOME/0909/09099937.gif"></a></td>
            <td><a href="#" onClick="f_a2('-','<%=year%>','<%=month%>');">上一月</a></td>
              <td class="date">
                  <input type="button" value="<% out.print(years+"年"+(Integer.parseInt(month)+1)+"月"); %>" onClick="location='/html/folder/<%=teasession._nNode %>-1.htm?community=<%=teasession._strCommunity %>'"></td>
               <td><a href="#" onClick="f_a2('+','<%=year%>','<%=month%>');">下一月</a></td>
             <td><a href="#" onClick="f_a2('+','<%=year%>','<%=month%>');" ><img src="/res/REDCOME/0909/09099939.gif"></a></td>
             
              <!-- <td width=28%><input   type=button   value="本月" onclick="location='/jsp/admin/flow/DayOrder.jsp?community=<%=community %>'"></td>-->
        </tr>
      </table>
</div></div>
  <div class="ArrangementsList">
      <table border="0" cellpadding="0" cellspacing="0">
       
        

          <% 
          String Time = null;
          String Days[];
          Days=new   String[35];
          for(int i=0;i<35;i++)
          {
            Days[i]="";
          }

          thisMonth.setTimeInMillis(System.currentTimeMillis());
          	ArrayList al = new ArrayList();
          for(int j=0;j<35;j++)
          {
         
              if(days[j]!=null && days[j].length()>0)
              {
	              if(Integer.parseInt(days[j])%4==1){
	                 out.print("<tr>");
	              }
	                 out.print("<td  class=top align=center>");
	                 //星期
	                 Date ddd =sd.parse(String.valueOf(years)+"-"+String.valueOf(Integer.parseInt(month)+1)+"-"+days[j]);  
            	   
               	  	 out.print(sdw.format(ddd)+"&nbsp;&nbsp;");
               		 
               		 out.print(String.valueOf(Integer.parseInt(month)+1)+"月"+days[j]+"日");
               	
               		al.add(days[j]);
               		
               		 out.print("</td>");
	              if(Integer.parseInt(days[j])%4==0){
	              	 out.print("</tr>");
	              	    
	              	 out.print("<tr>");
	              	 for(int di =0;di<al.size();di++)
	              	 {
	              	 	out.print("<td class=con>");
	              	   out.print(PerformStreak.getPerformS(String.valueOf(years)+"-"+String.valueOf(Integer.parseInt(month)+1)+"-"+al.get(di),teasession));
	              	 //  System.out.println(String.valueOf(years)+"-"+String.valueOf(Integer.parseInt(month)+1)+"-"+al.get(di));
	              	   
	              	 	out.print("</td>");
	              	 }
	              	 al.clear();
	              	 out.print("</tr>");
	              	
	              }
	             
	           
              } 
            
          } 
             out.print("</tr>");
             out.print("<tr>");
	        	 for(int di =0;di<al.size();di++)
	         {
	             out.print("<td>");
	             out.print(PerformStreak.getPerformS(String.valueOf(years)+"-"+String.valueOf(Integer.parseInt(month)+1)+"-"+al.get(di),teasession));
	            // System.out.println(String.valueOf(years)+"-"+String.valueOf(Integer.parseInt(month)+1)+"-"+al.get(di));
	             out.print("</td>");
	         }
	         out.print("</tr>");
          %>


      </table>
</div>
  </FORM>

