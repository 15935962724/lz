<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="tea.ui.TeaSession"%>
<%@page import="tea.entity.site.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.resource.*"%>
<%@page import="tea.db.*"%>
<%@page import="tea.entity.member.*"%>
<%@page import="tea.entity.admin.*"%>
<%@page import="java.util.Date"%>
<%@page import="tea.entity.admin.map.*" %>
 
<%
request.setCharacterEncoding("UTF-8");
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession = new TeaSession(request);


String nexturl = teasession.getParameter("nexturl");
//演出id
int pfid = teasession._nNode;


      
%>
 
 
  <table border="0" cellpadding="0" cellspacing="0" id="changcitable">
    <tr id="tableonetr">
      <TD nowrap>场次名称</TD>
      <TD nowrap>演出场馆</TD>
      <TD nowrap>演出时间</TD>
      <TD nowrap>操作</TD> 
    </tr>
	<%
	java.util.Enumeration  e = PerformStreak.find(teasession._strCommunity," and node = "+pfid,0,50);
    if(!e.hasMoreElements())  
    {
      out.print("<tr><td colspan=10 align=center>暂无演出场次</td></tr>");
    } 
 
    for(int i =1;e.hasMoreElements();i++)
    {
      int psid =((Integer)e.nextElement()).intValue();
      PerformStreak psobj = PerformStreak.find(psid);
      Node nobj = Node.find(psobj.getVenues());
      GMap gmobj = GMap.find(psobj.getVenues());
     
	 %>
  <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
        <td nowrap><%=psobj.getPsname()%></td>
        <td nowrap><%=nobj.getSubject(teasession._nLanguage) %>
	<%
		if(gmobj!=null)
		{
			out.print("<a href=/jsp/type/venues/GMapPreview.jsp?community="+teasession._strCommunity+"&node="+psobj.getVenues()+" target=_blank>(场馆位置)</a>  ");
		}
	 %>       
</td> 
        <td nowrap><%=psobj.getPftimeToString() %></td>
 <td nowrap>
 <%if(psobj.isTiems()){ %>
 <a href="/jsp/type/perform/OnlineReservations.jsp?psid=<%=psid %>&community=<%=teasession._strCommunity %>"  target=_blank>在线订票</a>
 <%}else {out.print("订票结束");} %>
 </td> 
</tr>
<%} %>
</table>



