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
SimpleDateFormat sd = new SimpleDateFormat("yyyy");
Date d = new Date();
int  year= Integer.parseInt(sd.format(d));

if(teasession.getParameter("year")!=null && teasession.getParameter("year").length()>0)
{
	year = Integer.parseInt(teasession.getParameter("year"));
}
StringBuffer sql = new StringBuffer();
StringBuffer param = new StringBuffer();
param.append("?community=").append(teasession._strCommunity);
   

sql.append(" AND pftime >='"+year+"-01-01' AND pftime <= '"+year+"-12-31' ");
param.append("&year=").append(year);
int pos = 0, pageSize = 5, count = 0;
if (request.getParameter("pos") != null) {
  pos = Integer.parseInt(request.getParameter("pos"));
}
count = PerformStreak.count(teasession._strCommunity,sql.toString());
  %>
<script type="text/javascript" language="javascript" src="/tea/tea.js"></script>

<script>
function f_a2(igd,y)//月份的加减
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
    var mm="/html/folder/"+form1.node.value+"-1.htm?community="+form1.community.value+"&year="+addy;
    window.open(mm,"_self");

  }
</script>
  <FORM   name="form1"   method="post"   action="?">
<input type="hidden" name="community" value="<%=teasession._strCommunity %>">
  <input type="hidden" name="nexturl" value="<%=nexturl%>" />
   <input type="hidden" name="node" value="<%=teasession._nNode%>" />
    <input type="hidden" name="id" value="<%=teasession.getParameter("id")%>" />
<div class="Arrangements">
   <div class="title">年度演出安排</div>
   <div class="function">
      <table   border="0" > 
        <tr id="TableControl">

            <td><a href="#" onClick="f_a2('-','<%=year%>');"><img src="/res/REDCOME/0909/09099937.gif"></a></td>
            <td><a href="#" onClick="f_a2('-','<%=year%>');"><%=year-1 %>年</a></td>
              <td class="date">
                  <input type="button" value="<% out.print("&nbsp;"+year+"&nbsp;年&nbsp;"); %>" onClick="location='/html/folder/<%=teasession._nNode %>-1.htm?community=<%=teasession._strCommunity %>'"></td>
               <td><a href="#" onClick="f_a2('+','<%=year%>');"><%=year+1 %>年</a></td>
             <td><a href="#" onClick="f_a2('+','<%=year%>');" ><img src="/res/REDCOME/0909/09099939.gif"></a></td>

              <!-- <td width=28%><input   type=button   value="本月" onclick="location='/jsp/admin/flow/DayOrder.jsp?community=<%=community %>'"></td>-->
        </tr>
      </table>
</div></div>
    <div class="RecommendedList">
       <div class="Con Special">
         <ul>
        <%
            sql.append("  order by pftime desc ");
        	Enumeration e = PerformStreak.find(teasession._strCommunity,sql.toString(),pos,pageSize);
        	if(!e.hasMoreElements())
   			{
      			 out.print("<li class=null>暂无记录</li>");
   			}
        	while(e.hasMoreElements())
        	{
        		int psid = ((Integer)e.nextElement()).intValue();
        		PerformStreak pfsobj = PerformStreak.find(psid);
        		Node nobj = Node.find(pfsobj.getNode()); //演出名称
        		Perform pfobj = Perform.find(pfsobj.getNode(),teasession._nLanguage);
        		//演出场馆
        		Node nobj2 = Node.find(pfsobj.getVenues());
        %>
		 <li>
         <table border="0" cellspacing="0" cellpadding="0">
        <tr>
        <td class="left"><div class="Thumbnail">
			<img src="<%=pfobj.getIntropicture() %>" width="20"></div></td>
        <td class="right">
        	<table border="0" cellspacing="0" cellpadding="0">
			<tr><td class="td01"><a href="/servlet/Node?node=<%=pfsobj.getNode() %>&em=0&language=<%=teasession._nLanguage %>&psid=<%=psid %>"><%=nobj.getSubject(teasession._nLanguage) %></a></td><td class="td02">
			
			<%if(pfsobj.isTiems()){ %>
			<a href="/jsp/type/perform/OnlineReservations.jsp?psid=<%=psid %>&community=<%=teasession._strCommunity %>">在线订票</a>
			<%}else{out.print("订票结束");} %> 
			</td></tr>    
			<tr><td class="td03">演出时间：<%=pfsobj.getPftimeToString() %></td>
            <td class="td04">
			演出场馆：<%=nobj2.getSubject(teasession._nLanguage) %></td></tr>
            </table>
			<div class="Tickets">演出票价：<%=PriceSubarea.getPriceSubareaPrice(psid,teasession._strCommunity) %></div>
			<div class="Introduction"><span class="title">剧情介绍：</span>
			<%
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
			 %><br>

		 </div>
        </td>
        </tr>
        </table>
        </li>
<%} %>
 </ul>
        </div>
 <%if (count > pageSize) {  %>
       <div class=Paging><%=new tea.htmlx.FPNL(teasession._nLanguage,request.getRequestURI()+param.toString()+"&pos=",pos,count,pageSize)%>    </div>
      <%}  %>
 </div>

  </FORM>
