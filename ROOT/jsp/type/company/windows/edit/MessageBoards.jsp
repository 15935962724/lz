<%@page contentType="text/html;charset=UTF-8" %>
<%
int count=Node.count(" AND father="+father73+" AND type=73");

%>


  <div id="edit_page2">
    <div id="edit_page2_wai_left">
      <div id="edit_page2_left">
        <table>
          <tr><td id="li_te"><span><%=r.getString(lang,"fj14p1xs")%></span></td></tr>
          <tr><td><span><a href="javascript:f_open('?url=EditMessageBoard')"><%=r.getString(lang,"fj14p1xt")%></a></span></td></tr>
        </table>
      </div>
    </div>
    <div id="edit_page2_wai_right">
      <div id="edit_page2_right"><span><%=r.getString(lang,"fj14p1xs")+" ( "+count+" )"%></span>
    </div>
    <table  cellspacing="0" cellpadding="0" id="page2_w_r_e_Products">
      <tr id="page2_w_r_e_p_tr"><td width="322"><%=r.getString(lang,"fj12hq46")%></td><td width="151"><%=r.getString(lang,"fj12hq4a")%></td><td><%=r.getString(lang,"fj12hq4i")%></td><td><%=r.getString(lang,"fj12hq4b")%></td></tr>
      <%
      Enumeration e73=Node.find(" AND father="+father73+" AND type=73 ORDER BY node DESC",pos,10);
      while(e73.hasMoreElements())
      {
        int n73=((Integer)e73.nextElement()).intValue();
        Node o73=Node.find(n73);
        out.print("<tr id=Notice_tr><td id=Notice_tr_td01><a href=javascript:f_open('.?url=ViewMessageBoard&node="+n73+"')>"+o73.getSubject(lang)+"</a></td>");
        out.print("<td>"+o73.getTimeToString()+"</td>");
        out.print("<td><a href=javascript:f_open('?url=Talkbacks&node="+n73+"')>"+Talkback.count(n73)+"</a></td>");
        out.print("<td><a href=javascript:f_open('?url=EditMessageBoard&node="+n73+"');><img src=/tea/image/eyp/images/page214.gif></a>");
        if(o73.isLayerExisted(lang))
        {
          out.print("<a href=\"javascript:f_open('/servlet/DeleteNode?node="+n73+"','"+r.getString(lang,"ConfirmDelete")+"');\"><img src=/tea/image/eyp/images/page215.gif></a>");
        }
        out.print("</td></tr>");
      }
      %>
      </table>
      <div id="page2_w_r_e_P_t_page"><%=new tea.htmlx.FPNL(lang,"?community="+como+"&url="+url+"&pos=",pos,count,10)%></div>

</div>
</div>
<div id="edit_page2_bottom"></div>
