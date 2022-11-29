<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.ui.*" %>
<%@page import="tea.db.*" %>
<%@page import="tea.resource.*" %>
<%@page import="java.util.*" %>
<%@page import="java.io.*" %>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.entity.member.*" %>
<%@page import="tea.entity.site.*" %>

  <div id="page2">
    <div id="page2_wai_left">
      <div id="page2_left">
        <div id="page2_left_top"></div>
    </div>
  </div>
  <div id="page2_wai_right">
    <div id="page2_right">
      <div id="page2_right_top"><font><a href="."><%=r.getString(lang,"fj0vgqw1")%></a> > <%=wbs[18].getName()%></font></div>
    </div>


<table cellspacing="0" cellpadding="0" id="page2_w_r_e_Products">
<tr id="page2_w_r_e_p_tr"><td width="322">标题</td><td width="151">发布时间</td></tr>
<%
int count=Node.count(" AND father="+father39+" AND type=39");
Enumeration e39=Node.find(" AND father="+father39+" AND type=39 ORDER BY node DESC",pos,10);
while(e39.hasMoreElements())
{
  int n39=((Integer)e39.nextElement()).intValue();
  Node o39=Node.find(n39);
  out.print("<tr id=Notice_tr><td id=Notice_tr_td01><a href=?community="+como+"&url=ViewReport&node="+n39+">"+o39.getSubject(lang)+"</a></td>");
  out.print("<td>"+o39.getTimeToString()+"</td>");
}
%>
</table>
<div id="page2_w_r_e_P_t_page"><%=new tea.htmlx.FPNL(lang,"?community="+como+"&url="+url+"&pos=",pos,count,10)%></div>


		  </div>
		</div>
  <div id="page2_bottom">
  </div>
