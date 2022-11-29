<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.ui.*" %>
<%@page import="tea.db.*" %>
<%@page import="tea.resource.*" %>
<%@page import="java.util.*" %>
<%@page import="java.io.*" %>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.entity.member.*" %>
<%@page import="tea.entity.site.*" %>
<%

int count=Node.count(" AND father="+father87+" AND type=87");

%>
  <div id="page2">
    <div id="page2_wai_left">
      <div id="page2_left">
        <div id="page2_left_top"><%=r.getString(lang,"fj14p1ys")%></div>
        <ul>
        <%
        Enumeration e87_=Node.find(" AND father="+father87+" AND type=87 ORDER BY node DESC",pos,10);
        if(!e87_.hasMoreElements())
        {
          out.print("<script>alert('"+r.getString(lang,"fj0vgqxa")+"');history.back();</script>");
          return;
        }
        for(int i=0;e87_.hasMoreElements();i++)
        {
          int n87=((Integer)e87_.nextElement()).intValue();
          if(i==0&&n.getType()!=87)
          {
            out.print("<script>window.location.replace('?community="+como+"&url=ViewBulletinBoard&node="+n87+"');</script>");
            return;
          }
          Node o87=Node.find(n87);
          out.print("<li><a href=?community="+como+"&url=ViewBulletinBoard&node="+n87);
          if(n87==node)
          {
            out.print(" style=color:#0C419A");
          }
          out.print(">"+o87.getSubject(lang)+"</a></li>");
        }
        %>
        </ul>
        <%=new tea.htmlx.FPNL(lang,"?community="+como+"&url="+url+"&pos=",pos,count,10)%>
    </div>
  </div>
  <div id="page2_wai_right">
    <div id="page2_right">
      <div id="page2_right_top"><font><a href="?community=<%=como%>"><%=r.getString(lang,"fj0vgqw1")%></a> > <%=r.getString(lang,"fj0vgqwb")%> > <%=n.getSubject(lang)%></font>
    </div>
  </div>
  <div id="page2_right_bottom">
    <div id="page2_r_b_title"><font><%=n.getSubject(lang)%></font><br><%=n.getTimeToString()%></div>
    <%=n.getText(lang)%>
      	</div>
  </div>
  <div id="page2_bottom">
  </div>
