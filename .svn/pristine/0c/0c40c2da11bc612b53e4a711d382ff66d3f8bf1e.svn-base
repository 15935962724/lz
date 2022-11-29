<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="tea.ui.TeaSession"%>
<%@page import="tea.entity.site.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.resource.*"%>
<%@page import="tea.db.*"%>
<%@page import="tea.entity.member.*"%>
<%@page import="tea.entity.admin.*"%>
<%@page import="java.util.Date"%>

<%
request.setCharacterEncoding("UTF-8");
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession = new TeaSession(request);



StringBuffer sql = new StringBuffer("");
StringBuffer param = new StringBuffer();
param.append("?id=").append(request.getParameter("id"));
param.append("&community=").append(teasession._strCommunity);

//演出名称
String subject = teasession.getParameter("subject");
if(subject!=null && subject.length()>0)
{
  sql.append(" AND node IN (SELECT node FROM Nodelayer WHERE subject LIKE "+DbAdapter.cite("%"+subject+"%")+")");
  param.append("&subject=").append(java.net.URLEncoder.encode(subject,"UTF-8"));
}
//演出场馆
int venues =0;
if(teasession.getParameter("venues")!=null && teasession.getParameter("venues").length()>0)
{
  venues = Integer.parseInt(teasession.getParameter("venues"));
  if(venues>0)
  {
    sql.append(" AND venues ="+venues);
    param.append("&venues=").append(venues);
  }
}
//演出时间
String time_c = teasession.getParameter("time_c");
if(time_c!=null && time_c.length()>0)
{
  sql.append(" AND pftime >=").append(DbAdapter.cite(time_c));
  param.append("&time_c=").append(time_c);
}
String time_d = teasession.getParameter("time_d");
if(time_d!=null && time_d.length()>0)
{
  sql.append(" AND pftime <=").append(DbAdapter.cite(time_d));
  param.append("&time_d=").append(time_d);
}
//具体到演出时间的日期
String pftime = teasession.getParameter("pftime");
if(pftime!=null && pftime.length()>0)
{
  sql.append(" AND pftime > ").append(DbAdapter.cite(pftime+" 00:00 "));
   sql.append(" AND pftime < ").append(DbAdapter.cite(pftime+" 23:59 "));
  param.append("&pftime=").append(pftime);
}

int pos = 0, pageSize = 20, count = 0;
if (request.getParameter("pos") != null) {
  pos = Integer.parseInt(request.getParameter("pos"));
}
count =PerformStreak.count(teasession._strCommunity,sql.toString());



sql.append(" order by pftime desc ");


%>








 <div class="RecommendedList">
       <div class="Con Special">
         <ul>

    <%
 
    java.util.Enumeration  e = PerformStreak.find(teasession._strCommunity,sql.toString(),pos,pageSize);
    if(!e.hasMoreElements())
    {
      out.print("<li class=null>暂无演出信息</li>");
    }


        	while(e.hasMoreElements())
        	{
        		int psid = ((Integer)e.nextElement()).intValue();
        		PerformStreak pfsobj = PerformStreak.find(psid);
        		Node nobj = Node.find(pfsobj.getNode()); //演出名称
        		Perform pfobj = Perform.find(pfsobj.getNode(),teasession._nLanguage);
        		//演出场馆
        		Node nobj2 = Node.find(pfsobj.getVenues());

            // hobj.setQuantity(hobj.getQuantity()+1);
      %>
     <li>
         <table border="0" cellspacing="0" cellpadding="0">
        <tr>
        <td class="left"><div class="Thumbnail">
			<img src="<%=pfobj.getIntropicture() %>" width="20"></div></td>
        <td class="right"> 
        	<table border="0" cellspacing="0" cellpadding="0">
			<tr><td class="td01">
			<a href="/servlet/Node?node=<%=pfsobj.getNode() %>&em=0&language=<%=teasession._nLanguage %>&psid=<%=psid %>"><%=nobj.getSubject(teasession._nLanguage) %></a></td><td class="td02">
			<%if(pfsobj.isTiems()){ %>
				<a href="/jsp/type/perform/OnlineReservations.jsp?psid=<%=psid %>&community=<%=teasession._strCommunity %>">在线订票</a>  
			<%}else{out.print("订票结束");} %>
		
			
			</td></tr>
			<tr><td class="td03">演出时间：<%=pfsobj.getPftimeToString() %></td>
            <td class="td04">
			演出场馆：<%=nobj2.getSubject(teasession._nLanguage) %></td></tr>
            </table>
			<div class="Tickets">演出票价：<%=PriceSubarea.getPriceSubareaPrice(psid,teasession._strCommunity) %></div>
			<div class="Introduction"><span>剧情介绍：</span>
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
      <%if (count > pageSize) {  %>
      <tr> <td colspan="10"><%=new tea.htmlx.FPNL(teasession._nLanguage,request.getRequestURI()+param.toString()+"&pos=",pos,count,pageSize)%>    </td> </tr>
      <%}  %>
 </ul>
        </div>



</div>

