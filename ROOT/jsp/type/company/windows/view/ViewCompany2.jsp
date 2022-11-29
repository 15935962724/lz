<%@page contentType="text/html;charset=UTF-8" %>
<%

String qualification[] = c.getQualification();
%>

  <div id="page2">
    <div id="page2_wai_left">
      <div id="page2_left">

<div id="page2_left_top"><%=wbs[19].getName(lang)%></div>
<ul>
  <li><a href="?community=<%=como%>&url=ViewCompany0"><%=wbs[2].getName(lang)%></a></li>
  <li><a href="?community=<%=como%>&url=ViewCompany1"><%=wbs[1].getName(lang)%></a></li>
  <li><a href="?community=<%=como%>&url=ViewCompany2" style="color:#0C419A"><%=wbs[3].getName(lang)%></a></li>
  <li><a href="?community=<%=como%>&url=ViewCompany3"><%=wbs[7].getName(lang)%></a></li>
</ul>
</div>
</div>

<div id="page2_wai_right">
  <div id="page2_right">
    <div id="page2_right_top"><font><a href="?community=<%=como%>"><%=r.getString(lang,"fj0vgqw1")%></a> > <%=wbs[3].getName(lang)%></font></div>
  </div>
  <div id="page2_right_bottom">
    <div id="page2_r_b_title"><font><%=wbs[3].getName(lang)%></font></div>
  </div>



    <table cellspacing="0" cellpadding="0" id="page2_w_r_e_Overview">
    <%
    for(int i=0;i<qualification.length;i++)
    {
      out.print("<tr><td align=center>");
      if(qualification[i]!=null&&qualification[i].length()>0)
      {
          out.print("<img src="+qualification[i]+" width=250 height=180>");
      }
    }
    %>
    </table>

</div>
  </div>
  <div id="page2_bottom"></div>


