<%@page contentType="text/html;charset=UTF-8" %>
<%
int count=Node.count(" AND father="+father50+" AND type=50");

%>
  <div id="edit_page2">
    <div id="edit_page2_wai_left">
      <div id="edit_page2_left">
        <table>
          <tr><td id="li_te"><span><%=r.getString(lang,"fj12hq4z")%></span></td></tr>
          <tr><td><span><a href="javascript:f_open('?url=EditJob')"><%=r.getString(lang,"fj12hq50")%></a></span></td></tr>
        </table>
      </div>
    </div>
    <div id="edit_page2_wai_right">
      <div id="edit_page2_right"><span><%=r.getString(lang,"fj12hq4z")+" ( "+count+" )"%></span>
    </div>

    <table  cellspacing="0" cellpadding="0" id="page2_w_r_e_Products">
      <tr id="page2_w_r_e_p_tr"><td width="322"><%=r.getString(lang,"fj12hq46")%></td><td width="151"><%=r.getString(lang,"fj12hq4a")%></td><td><%=r.getString(lang,"fj12hq4b")%></td></tr>
      <%
      Enumeration e50=Node.find(" AND father="+father50+" AND type=50 ORDER BY node DESC",pos,10);
      while(e50.hasMoreElements())
      {
        int n50=((Integer)e50.nextElement()).intValue();
        Node o50=Node.find(n50);
        out.print("<tr id=Notice_tr><td id=Notice_tr_td01><a href=javascript:f_open('.?url=ViewJob&node="+n50+"');>"+o50.getSubject(lang)+"</a></td>");
        out.print("<td>"+o50.getTimeToString()+"</td>");
        out.print("<td><a href=javascript:f_open('?url=EditJob&node="+n50+"');><img src=/tea/image/eyp/images/page214.gif></a> ");
        if(o50.isLayerExisted(lang))
        {
          out.print("<a href=\"javascript:f_open('/servlet/DeleteNode?node="+n50+"','"+r.getString(lang,"ConfirmDelete")+"');\"><img src=/tea/image/eyp/images/page215.gif></a>");
        }
        out.print("</td></tr>");
      }
      %>
      </table>
      <div id="page2_w_r_e_P_t_page"><%=new tea.htmlx.FPNL(lang,"?community="+como+"&url="+url+"&pos=",pos,count,10)%></div>
</div>
</div>
  <div id="edit_page2_bottom"></div>
