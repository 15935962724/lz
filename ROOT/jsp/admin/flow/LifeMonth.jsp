<%@page contentType="text/html;charset=UTF-8" %><%@   page   language="java"   import="java.util.*"   %>
<%@ page import="tea.db.DbAdapter"%>
<%@ page import="tea.resource.Resource"%>
<%@ page import="tea.entity.admin.*" %>
<%@ page import="tea.ui.TeaSession" %>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.entity.Entity"%>

<%!   String   days[];   %>
<% 

response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);

  String community=teasession._strCommunity;


  String nexturl = request.getRequestURI()+"?node="+teasession._nNode+request.getContextPath();
  if(teasession.getParameter("nexturl")!=null)
  {
    nexturl = teasession.getParameter("nexturl");
  }

	String id = teasession.getParameter("id");
	int rid = 0;
	if(teasession.getParameter("rid")!=null){
		rid = Integer.parseInt(teasession.getParameter("rid"));
	}
  long l5 = System.currentTimeMillis();
  Date date = new Date(l5);
  Calendar calendar = Calendar.getInstance();
  calendar.setTime(date);


  int CUR_YEAR = calendar.get(1);
  int CUR_MON  = calendar.get(2) + 1;
  int CUR_DAY = calendar.get(7) ;

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
   // var mm="/jsp/admin/flow/LifeMonth.jsp?community="+Monthform.community.value+"&month="+addm+"&year="+addy;
    window.open(mm,"_self");


  }
</script>
  <FORM   name="Monthform"   method="post"   action="?">
<input type="hidden" name="community" value="<%=teasession._strCommunity %>">
  <input type="hidden" name="nexturl" value="<%=nexturl%>" />
    <input type="hidden" name="id" value="<%=teasession.getParameter("id")%>" />
<input type="hidden" name="node" value="<%=teasession._nNode %>">
    <div class="Arrangements">
   
   <div class="function">
      <table   border="0" >
        <tr id="TableControl">
         
            <td><a href="#" onClick="f_a2('-','<%=year%>','<%=month%>');"><img src="/res/daoxie/1111/1111990.jpg"></a></td>
          
              <td class="date">
              <%
                  
                    out.print("&nbsp;&nbsp;&nbsp;"+years+"年&nbsp;"+tea.entity.Entity.MONTH_zh[(Integer.parseInt(month)+1)]+"月&nbsp;&nbsp;&nbsp;");
              %>

                  </td>
               
             <td><a href="#" onClick="f_a2('+','<%=year%>','<%=month%>');" ><img src="/res/daoxie/1111/1111991.jpg"></a></td>
             
              <!-- <td width=28%><input   type=button   value="本月" onclick="location='/jsp/admin/flow/DayOrder.jsp?community=<%=community %>'"></td>-->
        </tr>
      </table>
</div></div>
  <div class="ArrangementsList">
      
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
          		
              out.print("<td id=\"dxd\" valign=\"top\"> ");

              if(days[i].length()>0)
              {
                String ds= year+"-"+String.valueOf(Integer.parseInt(month)+1)+"-"+String.valueOf(days[i]);
                boolean f = false;
               
               

               // out.print("\">");
                
                
                out.println("<span id=\"dxdayid2\"> ");
                
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
                out.println("</span>");
                

                //后台添加的信息显示 
                String sc = "<br><span id=\"dxdayid\">农历："+Entity.getNongli(Integer.parseInt(year),(Integer.parseInt(month)+1),Integer.parseInt(days[i]))+"</span>";
              
                 if(dobj.getAffaircontent()!=null && dobj.getAffaircontent().length()>0)
                  {
                	 sc = sc+"<br>"+dobj.getAffaircontent();
                  }
                   
                 out.println(sc);
                 
                 String sql = " and type=39 and hidden = 0 and  father ="+rid+" and  node in (select node from Report where  issuetime >="+DbAdapter.cite(ds+" 00:00")+" and issuetime <="+DbAdapter.cite(ds+" 23:59")+")";
                 
           	 	java.util.Enumeration e =Node.find(sql,0,Integer.MAX_VALUE);
                
           	 //	out.println(sql); 
                 while(e.hasMoreElements()) 
                 {
                   int nid = ((Integer)e.nextElement()).intValue();
                   Node nobj = Node.find(nid);
                 
						
						 //标题
		                   out.print("<div class=title><a href=/html/report/"+nid+"-"+teasession._nLanguage+".htm  target=_blank> ");
                   //标题
                   out.print(nobj.getSubject(teasession._nLanguage));
                   out.print("</a></div>");
                   
						 
                  
                   
                 }

                 
               
              }else{out.println("&nbsp;");}
              
              out.print("</td>");
            }
            out.print("</tr>");
          }
          %>

        </div>
      </table>
</div>
  </FORM>


