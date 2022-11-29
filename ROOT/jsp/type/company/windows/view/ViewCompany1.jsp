<%@page contentType="text/html;charset=UTF-8" %>
<%

String content=n.getText(lang);
String pic=c.getPicture(lang);
%>


<div id="page2">
  <div id="page2_wai_left">
    <div id="page2_left">

<div id="page2_left_top"><%=wbs[19].getName(lang)%></div>
<ul>
  <li><a href="?community=<%=como%>&url=ViewCompany0"><%=wbs[2].getName(lang)%></a></li>
  <li><a href="?community=<%=como%>&url=ViewCompany1" style="color:#0C419A"><%=wbs[1].getName(lang)%></a></li>
  <li><a href="?community=<%=como%>&url=ViewCompany2"><%=wbs[3].getName(lang)%></a></li>
  <li><a href="?community=<%=como%>&url=ViewCompany3"><%=wbs[7].getName(lang)%></a></li>
</ul>
</div>
</div>

<div id="page2_wai_right">
  <div id="page2_right">
    <div id="page2_right_top"><font><a href="?community=<%=como%>"><%=r.getString(lang,"fj0vgqw1")%></a> > <%=wbs[1].getName(lang)%></font></div>
  </div>
  <div id="page2_right_bottom">
    <div id="page2_r_b_title"><font><%=wbs[1].getName(lang)%></font></div>
  </div>


    <div id="page2_right_bottom_img"><%if(pic!=null&&pic.length()>0)out.print("<img src="+pic+" width=353 height=251>");%></div>
    <div id="page2_right_bottom_con"><%=content%></div>



</div>
</div>
<div id="page2_bottom"></div>


