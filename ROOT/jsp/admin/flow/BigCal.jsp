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




  String nexturl = request.getRequestURI()+"?node="+teasession._nNode+request.getContextPath();
  if(teasession.getParameter("nexturl")!=null)
  {
    nexturl = teasession.getParameter("nexturl");
  }

  int id =217732;


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
  <script>
  function f_a1(igd,y,m)//年份的 加减
  {

    var addy=y;
    if(igd=='+')
    {
      addy = parseInt(addy)+1;
    }
    if(igd=='-')
    {
      addy = parseInt(addy)-1;
    }

     var mm="?node=<%=teasession._nNode%>&community=<%=community%>&year="+addy+"&month="+m+"&id=<%=id%>";

      sendx("/jsp/admin/flow/BigCal_ajax.jsp"+mm,
      function(data)
      {
        document.all("show").innerHTML=data;
      }
      );
  }
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


    var mm="?node=<%=teasession._nNode%>&community=<%=community%>&year="+addy+"&month="+addm+"&nexturl=<%=nexturl%>&id=<%=id%>";
    // window.open(mm,"_self");
    sendx("/jsp/admin/flow/BigCal_ajax.jsp"+mm,
    function(data)
    {
      document.all("show").innerHTML=data;
    }
    );
  }

  </script>

  <form   name="sm"   method="post"   action="?">
  <input type="hidden" name="nexturl" value="<%=nexturl%>" />
    <input type="hidden" name="id" value="<%=teasession.getParameter("id")%>" />
      <input type="hidden" name="node" value="<%=teasession._nNode%>" />
    <span id="show">
     <div class="showtableol">
      <table   border="0"  id="TableConol">
        <tr id="TableControl">
          <td><a href="#" onclick="f_a1('-','<%=year%>','<%=month%>');"><%out.print("<"); %></a></td>
            <td><a href="#" onclick="f_a2('-','<%=year%>','<%=month%>');"><%out.print("<<"); %></a></td>
              <td>
              <%
             // out.print("<a href=\"#\" onclick='f_a3('"+year+"','"+month+"');'>");
              out.print("&nbsp;"+years+"&nbsp;年&nbsp;"+(Integer.parseInt(month)+1)+"&nbsp;月&nbsp;");
             // out.print("</a>");
              %>
              </td>
              <td><a href="#" onclick="f_a2('+','<%=year%>','<%=month%>');" >>></a></td>
              <td><a href="#" onclick="f_a1('+','<%=year%>','<%=month%>');" >></a></td>
              <!-- <td width=28%><input   type=button   value="本月" onclick="location='/jsp/admin/flow/DayOrder.jsp?community=<%=community %>'"></td>-->
        </tr>
      </table>
      </div>


      <table border="0" cellpadding="0" cellspacing="0" id="tableDate">
        <div   align=center>
          <tr id="tableonetr">
            <td nowrap ><font color="red">星期日</font></td>
            <td nowrap >星期一</td>
            <td nowrap >星期二</td>
            <td  nowrap >星期三</td>
            <td  nowrap >星期四</td>
            <td  nowrap >星期五</td>
            <td  nowrap><font color="green">星期六</font></td>
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
              out.print("<td onMouseOver=\"javascript:this.bgColor=\'#BCD1E9\'\" onMouseOut=\"javascript:this.bgColor=\'\'\"> ");

              if(days[i].length()>0)
              {
                String ds= year+"-"+String.valueOf(Integer.parseInt(month)+1)+"-"+String.valueOf(days[i]);
                boolean f = false;
              //  out.print(" title= ");
                String sql = " and  father ="+teasession._nNode+" and  node in (select node from Report where  issuetime ="+DbAdapter.cite(ds)+")";
                java.util.Enumeration e =Node.find(sql,0,Integer.MAX_VALUE);
                if(e.hasMoreElements())
                {
                  f = true;
                }
                out.print("<div id = dayid>");
                if(f)//如果有会议则显示连接
                {
                  out.print("<a href=javascript:window.open('/servlet/Node?node="+teasession._nNode+"&year="+year+"&month="+month+"&timeAmount="+day+"&id="+id+"','_self')>");
                }
                if(thisMonth.get(thisMonth.YEAR)==Integer.parseInt(year)&&thisMonth.get(thisMonth.MONTH)==Integer.parseInt(month)&&thisMonth.get(thisMonth.DAY_OF_MONTH)==Integer.parseInt(days[i]))
                {
                  out.print("<font color=red >"+days[i]+"日</font>");
                }else{
                  if(f){
                    out.print("<font color=green >");
                  }
                  out.print(days[i]+"日");
                  if(f){
                    out.print("</font>");
                  }
                }
                if(f)
                {
                  out.print("</a>");
                }
                out.print("</div>");
                //显示会议的主题
                while(e.hasMoreElements())
                {
                  int nid = ((Integer)e.nextElement()).intValue();
                  Node nobj = Node.find(nid);
                  out.print("<div class=list>◇");
                  out.print("<a href=javascript:window.open('/servlet/Node?node="+nid+"&language="+teasession._nLanguage+"','_self')>");
                  out.print(nobj.getSubject(teasession._nLanguage)+"</a></div>");
                  f = true;
                }


              }
              out.print("</td>");
            }
            out.print("</tr>");
          }
          %>

        </div>
      </table>
    </span>
  </FORM>
