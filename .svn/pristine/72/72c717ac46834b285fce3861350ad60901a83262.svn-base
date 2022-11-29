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
Report r39=Report.find(node);
String picture=r39.getPicture(lang);

int count=Node.count(" AND father="+father39+" AND type=39");
%>
  <div id="page2">
    <div id="page2_wai_left">
      <div id="page2_left">
        <div id="page2_left_top"><%=r.getString(lang,"fj0vgqwj")+" ( "+count+" )"%></div>
        <ul>
        <%
        Enumeration e39_=Node.find(" AND father="+father39+" AND type=39 ORDER BY node DESC",pos,10);
        if(!e39_.hasMoreElements())
        {
          out.print("<script>alert('"+r.getString(lang,"fj0vgqxa")+"');history.back();</script>");
          return;
        }
        for(int i=0;e39_.hasMoreElements();i++)
        {
          int n39=((Integer)e39_.nextElement()).intValue();
          if(i==0&&n.getType()!=39)
          {
            out.print("<script>window.location.replace('?community="+como+"&url=ViewReport&node="+n39+"');</script>");
            return;
          }
          Node o39=Node.find(n39);
          out.print("<li><a href=?community="+como+"&url=ViewReport&node="+n39);
          if(n39==node)
          {
            out.print(" style=color:#0C419A");
          }
          out.print(">"+o39.getSubject(lang)+"</a></li>");
        }
        %>
        </ul>
        <%=new tea.htmlx.FPNL(lang,"?community="+como+"&url="+url+"&node="+node+"&pos=",pos,count,10)%>
    </div>
  </div>
  <div id="page2_wai_right">
    <div id="page2_right">
      <div id="page2_right_top"><font><a href="?community=<%=como%>"><%=r.getString(lang,"fj0vgqw1")%></a> > <%=wbs[18].getName(lang)%> > <%=n.getSubject(lang)%></font>
    </div>
  </div>
  <div id="page2_right_bottom">
    <div id="page2_r_b_title"><font><%=n.getSubject(lang)%></font><br><%=n.getTimeToString()%></div>
    <%
    if(picture!=null&&picture.length()>0)
    {
      out.print("<div id=Products_con_top><img src="+picture+" width=290></div>");
    }
    %>
    <div id=page2_right_bottom_con2><%=n.getText(lang)%></div>
      	</div>
  </div></div>
  <div id="page2_bottom">
  </div>
