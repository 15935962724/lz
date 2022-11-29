<%@page import="tea.entity.Entity"%>
<%@page contentType="text/html;charset=UTF-8" %><%@   page   language="java"   import="java.util.*"   %>
<%@ page import="tea.db.DbAdapter"%>
<%@ page import="tea.resource.Resource"%>
<%@ page import="tea.entity.admin.*" %>
<%@ page import="tea.ui.TeaSession" %>
<%@ page import="tea.entity.node.*" %>
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
 String nexturl =teasession.getParameter("nexturl");

int nodeshow = Integer.parseInt(teasession.getParameter("nodeshow"));

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


  %>

  <table   border="0" >
        <tr id="TableControl">
          <td><a href="###" onclick="f_a1('-','<%=year%>','<%=month%>');"><</a></td>
            <td><a href="###" onclick="f_a2('-','<%=year%>','<%=month%>');"><<</a></td>
              <td>
              <%
              out.print("&nbsp;"+years+"年"+tea.entity.Entity.MONTH_zh[(Integer.parseInt(month)+1)]+"月&nbsp;");
              %>
              </td>
              <td><a href="###" onclick="f_a2('+','<%=year%>','<%=month%>');" >>></a></td>
              <td><a href="###" onclick="f_a1('+','<%=year%>','<%=month%>');" >></a></td>
              <!-- <td width=28%><input   type=button   value="本月" onclick="location='/jsp/admin/flow/DayOrder.jsp?community=<%=community %>'"></td>-->
        </tr>
      </table>



  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <div   align=center>
      <tr id="tableonetr">
            <td nowrap ><font color="red">日</font></td>
            <td nowrap >一</td>
            <td nowrap >二</td>
            <td  nowrap >三</td>
            <td  nowrap >四</td>
            <td  nowrap >五</td>
            <td  nowrap><font color="green">六</font></td>
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
              String day = year+"-"+String.valueOf(Integer.parseInt(month)+1)+"-"+String.valueOf(days[i]);
              
              
              
              Date t =null;
          		if(days[i]!=null && days[i].length()>0)
          		{
          			t = Entity.sdf.parse(day);
          		}
          	
          
          		DayOrder dobj =DayOrder.find(DayOrder.getId(teasession._strCommunity,t)); 
          		
              out.print("<td ");

              if(days[i].length()>0)
              {
                  String ds= year+"-"+String.valueOf(Integer.parseInt(month)+1)+"-"+String.valueOf(days[i]);
                  boolean f = false;
                  out.print("   style=\"cursor:pointer\" title=\" ");
                 
                  //后台添加的信息显示 
                  StringBuffer sp =new StringBuffer("农历："+Entity.getNongli(Integer.parseInt(year),(Integer.parseInt(month)+1),Integer.parseInt(days[i])));
                
                   if(dobj.getAffaircontent()!=null && dobj.getAffaircontent().length()>0)
                    {
                  	 sp.append("&#10;"+Node.Html2Text(dobj.getAffaircontent()).replaceAll("<br>","&#10;").replaceAll("\n","").replaceAll("\r",""));
                    }
                   
                   //新闻
                    
                   
                  boolean rf = false;
                  
                  String sql = " and  father ="+teasession._nNode+" and  node in (select node from Report where  issuetime >="+DbAdapter.cite(ds+" 00:00")+" and issuetime <="+DbAdapter.cite(ds+" 23:59")+")";
               
                  
                  java.util.Enumeration e =Node.find(sql,0,Integer.MAX_VALUE);
                  while(e.hasMoreElements())
                  {
                    int nid = ((Integer)e.nextElement()).intValue();
                    Node nobj = Node.find(nid);
                    sp.append("&#10;");
                 	  sp.append("◇"+nobj.getSubject(teasession._nLanguage)+"&#10;");
                 		rf = true;
                  }
                
                
                   out.println(sp.toString());
                   
                   

                  out.print("\">"); 
                  
                  
                  
                  
                  if(rf)//如果有会议则显示连接
                  {
                	  out.print("<a id=\"colorhrefid\" target=\"_blank=\" href=\"/html/folder/"+nodeshow+"-"+teasession._nLanguage+".htm?community="+teasession._strCommunity+"&month="+month+"&year="+year+"&cid="+String.valueOf(Integer.parseInt(month)+1)+"#A"+String.valueOf(days[i])+"\" >");
                  }
               
                 
                     
                  if(thisMonth.get(thisMonth.YEAR)==Integer.parseInt(year)&&thisMonth.get(thisMonth.MONTH)==Integer.parseInt(month)&&thisMonth.get(thisMonth.DAY_OF_MONTH)==Integer.parseInt(days[i]))
                  {
                    out.print("<font class=red >"+days[i]+"</font>");
                  }else{

  	               if(f){
  	                 out.print("<font class=green >");
  	               }
               		  out.print(days[i]);
  	               if(f){
  	                 out.print("</font>");
  	               }
                 
                  }
                  if(rf)
                  {
                    out.print("</a>");
                  }
               
              }else {out.print(">");}
              
              out.print("</td>");
            }
            out.print("</tr>");
          }
          %>

    </div>
  </table>


</body>
</html>
