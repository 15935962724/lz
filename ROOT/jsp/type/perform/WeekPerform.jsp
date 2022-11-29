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
/*
Calendar   now=Calendar.getInstance();
  int   year1,month1,date1,hour1,minute1,second1;
  year1=now.get(Calendar.YEAR);
  month1=now.get(Calendar.MONTH)+1;
  date1=now.get(Calendar.DATE);
  hour1=now.get(Calendar.DAY_OF_WEEK); //Calendar.DAY_OF_WEEK
  minute1=now.get(Calendar.MINUTE);
  second1=now.get(Calendar.SECOND);
 */




SimpleDateFormat sdw = new SimpleDateFormat("E");
SimpleDateFormat sd = new SimpleDateFormat("yyyy-MM-dd");

Date date = new Date();

 Calendar cal = Calendar.getInstance();

 String jt = sd.format(cal.getTime());



Calendar c = new GregorianCalendar();

int qint = 7;
if(teasession.getParameter("qint")!=null && teasession.getParameter("qint").length()>0)
{
  qint = Integer.parseInt(teasession.getParameter("qint"));
}

int isi = 0;
if(teasession.getParameter("isi")!=null && teasession.getParameter("isi").length()>0)
{
  isi = Integer.parseInt(teasession.getParameter("isi"));
  Calendar c2 = Calendar.getInstance();
  c2.add(Calendar.DATE, isi);
  date = c2.getTime();
}

%>






<script type="text/javascript" language="javascript" src="/tea/tea.js"></script>
<script>
function f_a2(str,igd,igd2)
{
  var qint2= igd;
  var isi2 = igd2;
  if(str=="-")
  {
   qint2= parseInt(igd)-7;
    isi2 = parseInt(igd2)-7;
  }else if(str=="+")
  {
   qint2= parseInt(igd)+7;
   isi2 = parseInt(igd2)+7;
  }else
  {
    qint2 =7;
    isi2=0;
  }
	//weekform.qint.value=qint2;
	//weekform.isi.value=isi2;
//	weekform.submit(); 
	   
   //var mm="/jsp/type/perform/WeekPerform.jsp?community="+weekform.community.value+"&qint="+qint2+"&isi="+isi2+"&id="+weekform.id.value;
  var mm ="/html/folder/"+weekform.node.value+"-1.htm?qint="+qint2+"&isi="+isi2+"&community="+weekform.community.value;
  window.open(mm,"_self");
} 
</script>
  <FORM   name="weekform"   method="post"   action="?">
<input type="hidden" name="community" value="<%=teasession._strCommunity %>">
<input type="hidden" name="node" value="<%=teasession._nNode %>">
    <input type="hidden" name="id" value="<%=teasession.getParameter("id")%>" />

    <div class="Arrangements">
     <div class="title">一周演出安排</div>
   <div class="function">
      <table   border="0" >
        <tr id="TableControl">

            <td><a href="#" onClick="f_a2('-','<%=qint%>','<%=isi%>');"><img src="/res/REDCOME/0909/09099937.gif"></a></td>
            <td><a href="#" onClick="f_a2('-','<%=qint%>','<%=isi%>');">上一周</a></td>
              <td class="date">
                  <input type="button" value="本周" onClick="f_a2('','<%=qint%>','<%=isi%>');"></td>
               <td><a href="#" onClick="f_a2('+','<%=qint%>','<%=isi%>');">下一周</a></td>
             <td><a href="#" onClick="f_a2('+','<%=qint%>','<%=isi%>');" ><img src="/res/REDCOME/0909/09099939.gif"></a></td>

              <!-- <td width=28%><input   type=button   value="本月" onclick="location='/jsp/admin/flow/DayOrder.jsp?community=<%=community %>'"></td>-->
        </tr>
      </table> 
</div></div>
 <div class="PerWeek">
    
    	          <% //isi qint

          c.setFirstDayOfWeek(Calendar.MONDAY);

         for(int i=0;i<7;i++)
          {

            c.setTime(date);
            c.set(Calendar.DAY_OF_WEEK, c.getFirstDayOfWeek() + i); // Sunday
             out.print("<ul><li><div class=WeekTitle><div>");
             out.print(sdw.format(c.getTime()));
             out.print("&nbsp;");
             out.print(sd.format(c.getTime()));
             out.print("</div></div>");
             out.print("<div class=RecommendedList><div class=Con><ul>");
               //out.print(PerformStreak.getPerformS(sd.format(c.getTime()),teasession));
               String sql =" AND pftime  > '"+sd.format(c.getTime())+" 00:00' AND pftime <'"+sd.format(c.getTime())+" 23:59' order by pftime desc ";
               java.util.Enumeration  e = PerformStreak.find(teasession._strCommunity,sql,0,200);
               if(!e.hasMoreElements())
               {
                 out.print("<li class=No>暂无演出信息</li>");
               }


               while(e.hasMoreElements())
               {
                 int psid = ((Integer)e.nextElement()).intValue();
                 PerformStreak pfsobj = PerformStreak.find(psid);
                 Node nobj = Node.find(pfsobj.getNode()); //演出名称
                 Perform pfobj = Perform.find(pfsobj.getNode(),teasession._nLanguage);

                 //演出场馆
                 Node nobj2 = Node.find(pfsobj.getVenues());
                 //图片
                 out.print("<li><table border=0 cellspacing=0 cellpadding=0><tr><td class=left><div class=Thumbnail><img src= "+pfobj.getIntropicture() +"></div></td>");
                 //演出名称
                 out.print("<td class=right><table border=0 cellspacing=0 cellpadding=0><tr><td class=td01><a href = ");
                 out.print("/servlet/Node?node="+pfobj.getNode()+"&em=0&language="+teasession._nLanguage+" >");
                 out.print(nobj.getSubject(teasession._nLanguage));
                 out.print("</a>");
                   out.print("</td>");
				   //在线订票
                    out.print("<td class=td02>");
				   if(pfsobj.isTiems())
				   { 
				   		out.print("<a href=\"/jsp/type/perform/OnlineReservations.jsp?psid="+psid+"&community="+teasession._strCommunity+"\">在线订票</a>");
				   }else
				   {
					   out.print("订票结束");
				   }     
				   out.print("</td></tr>");
                   //演出时间 
                   out.print("<tr><td class=td03>演出时间：");
                   out.print(pfsobj.getPftimeToString());
                   out.print("</td>");
                   //演出场馆
                   out.print("<td class=td04>演出场馆：");
                   out.print(nobj2.getSubject(teasession._nLanguage) );
                   out.print("</td></tr></table>");
                   //演出票价
                   out.print("<div class=Tickets>演出票价：");
                   out.print(PriceSubarea.getPriceSubareaPrice(psid,teasession._strCommunity) );
                   out.print("</div>");
                   //剧情介绍：
                   out.print("<div class=Introduction><span class=title>剧情介绍：</span>");
                   String text = nobj.getText(teasession._nLanguage);
					text = Node.Html2Text(text);
					if(text!=null && text.length()>0)
					{
						if(text.length()>20)
						{

							out.print(text.substring(0,20)+"...");
						}else
						{
							out.print(text);
						}
					}
                    out.print("</div></td></tr></table></li>");
                


               }

             // out.print(sd.format(c.getTime()),teasession));
               out.print("</ul></div></div></li></ul>");
      

        }

          %>
</div>
  </FORM>

