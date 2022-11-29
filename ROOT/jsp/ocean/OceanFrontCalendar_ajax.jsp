<%@page contentType="text/html;charset=UTF-8" %><%@   page   language="java"   import="java.util.*"   %>
<%@ page import="tea.db.DbAdapter"%>
<%@ page import="tea.entity.*" %>
<%@ page import="tea.ui.TeaSession" %>
<%@ page import="tea.entity.node.*" %>
<%!   String   days[];   %>
<%

response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);


  String community=teasession._strCommunity;
 String nexturl =teasession.getParameter("nexturl");
 
 

int nodenexturl=0; //Integer.parseInt(teasession.getParameter("nodenexturl"));
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

//post时间
String timeAmount = teasession.getParameter("timeAmount");
if(timeAmount!=null && timeAmount.length()>0)
{
	
}else
{
timeAmount = Entity.sdf.format(new java.util.Date());
}

  %>
<div class="Yearbox">
  <table   border="0" >
        <tr id="TableControl">
          <td><a href="###" onclick="f_a1('-','<%=year%>','<%=month%>');"><img src="/res/Home/structure/yearl.gif"/></a></td>
            <td><a href="###" onclick="f_a2('-','<%=year%>','<%=month%>');"><img src="/res/Home/structure/monthl.gif"/></a></td>
              <td>
              <%
               out.print("&nbsp;"+years+"&nbsp;.&nbsp;");
    			int m =(Integer.parseInt(month)+1);
    			if(m<=9)
    			{
    				out.print("0"+m);
    			}else
    			{
    				out.print(m);
    			}

              %>
              </td>
              <td><a href="###" onclick="f_a2('+','<%=year%>','<%=month%>');" ><img src="/res/Home/structure/monthr.gif"/></a></td>
              <td><a href="###" onclick="f_a1('+','<%=year%>','<%=month%>');" ><img src="/res/Home/structure/yearr.gif"/></a></td>
              <!-- <td width=28%><input   type=button   value="本月" onclick="location='/jsp/admin/flow/DayOrder.jsp?community=<%=community %>'"></td>-->
        </tr>
      </table>
</div>
<div class="Datebox">
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <div   align="center">
     <tr id="tableonetr">
	            <td nowrap ="nowrap"><font color="red">SUN</font></td>
	            <td nowrap ="nowrap" >MON</td>
	            <td nowrap ="nowrap" >TUE</td>
	            <td  nowrap ="nowrap" >WED</td>
	            <td  nowrap ="nowrap" >THU</td>
	            <td  nowrap ="nowrap" >FRI</td>
	            <td  nowrap ="nowrap"><font color="green">SAT</font></td>
	         </tr>

          <%
          String Time = null;
          String Days[];
          Days=new   String[42];
          for(int   i=0;i<42;i++)
          {
            Days[i]="";
          }

          thisMonth.setTimeInMillis(System.currentTimeMillis());
          for(int j=0;j<6;j++)
          {
            out.print("<tr>");
            for(int   i=j*7;i<(j+1)*7;i++)
            {
              String day = year+"-"+String.valueOf(Integer.parseInt(month)+1)+"-"+String.valueOf(days[i]);//日期格式
              out.print("<td ");

              if(days[i].length()>0)
              {
                String ds= year+"-";
                //String.valueOf(Integer.parseInt(month)+1)+"-"+String.valueOf(days[i]);
                if((Integer.parseInt(month)+1)<=9)
                {	
                	ds =ds+"0"+String.valueOf(Integer.parseInt(month)+1)+"-";
                }else
                {
                	ds =ds+String.valueOf(Integer.parseInt(month)+1)+"-";
                }
                if(Integer.parseInt(days[i])<=9)
                {
                	ds = ds+"0"+days[i];
                }else
                {
                	ds = ds+days[i];
                }
                
                
                
                boolean f = false;
               
				
                out.print(">");
                
                int time_node = Node.getNode(ds,teasession._nNode);
                Node nobj = Node.find(time_node);
                
                
                if(time_node>0)//如果有会议则显示连接
                { 
                  out.print("<a href=\"javascript:window.open('?year="+year+"&month="+month+"&node="+nodenexturl+"&timeAmount="+ds+"','_self');\">");
                } 
               
                if(thisMonth.get(thisMonth.YEAR)==Integer.parseInt(year)&&thisMonth.get(thisMonth.MONTH)==Integer.parseInt(month)&&thisMonth.get(thisMonth.DAY_OF_MONTH)==Integer.parseInt(days[i]))
                {
                	
                	   Enumeration e2 = Node.find(" and father="+time_node+" and type = 39 and hidden = 0 ",0,1);
                	if(!e2.hasMoreElements())
                	{  
                		out.print("<font class=\"red\" >"+days[i]+"</font>");
                	}
                	while(e2.hasMoreElements())
                	{
                		int n2 = ((Integer)e2.nextElement()).intValue();
                		Node nobj2 = Node.find(n2);
                		Report robj2 = Report.find(n2);
                		if(robj2.getPicture(teasession._nLanguage)!=null && robj2.getPicture(teasession._nLanguage).length()>0)
                		{
                			out.print("<img width=\"100\" src="+robj2.getPicture(teasession._nLanguage)+"/>");
                		}else
                		{
                			out.print("<img width=\"100\" src=\"/jsp/ocean/imgdata.jpg\"/>");
                		}
                	}
                }else{
                
                
                Enumeration e2 = Node.find(" and father="+time_node+" and type = 39 and hidden = 0 ",0,1);
                	if(!e2.hasMoreElements())
                	{
                		 if(time_node>0){
		                 out.print("<font class=\"green\" >");
		               }
	             		  out.print(days[i]);
		               if(time_node>0){
		                 out.print("</font>");
		               }
                	}
                	while(e2.hasMoreElements())
                	{
                		int n2 = ((Integer)e2.nextElement()).intValue();
                		Node nobj2 = Node.find(n2);
                		Report robj2 = Report.find(n2);
                		if(robj2.getPicture(teasession._nLanguage)!=null && robj2.getPicture(teasession._nLanguage).length()>0)
                		{
                			out.print("<img width=\"100\" src="+robj2.getPicture(teasession._nLanguage)+"/>");
                		}else
                		{
                			out.print("<img width=\"100\" src=\"/jsp/ocean/imgdata.jpg\"/>");
                		}
                	}

	              
               
                }
                
                if(time_node>0)
                {
                  out.print("</a>");
                }
              }
              else
              {
               
               	out.print(">");
               }
              out.print("</td>");
            }
            out.print("</tr>");
          }
          %>

        </div>
  </table></div>
      <div class="datebottom"></div>

</body>
</html>
