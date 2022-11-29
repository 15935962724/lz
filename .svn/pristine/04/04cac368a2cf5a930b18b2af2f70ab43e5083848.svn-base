<%@page contentType="text/html;charset=UTF-8" %>
<%

StringBuffer sql39=new StringBuffer();
sql39.append(" AND father="+father39+" AND type=39");

int count=Node.count(sql39.toString());

sql39.append(" ORDER BY node DESC");
%>


  <div id="edit_page2">
    <div id="edit_page2_wai_left">
      <div id="edit_page2_left">
        <table>
          <tr><td id="li_te"><span><%=r.getString(lang,"fj0vgqwj")%></span></td>   </tr>
          <tr><td><span><a href="javascript:f_open('?url=EditReport')"><%=r.getString(lang,"fj12hq49")%></a></span></td></tr>
        </table>
      </div>
		</div>
		<div id="edit_page2_wai_right">
		  <div id="edit_page2_right"><span><%=r.getString(lang,"fj0vgqwj")+" ( "+count+" )"%></span>
		  </div>

		  <table  cellspacing="0" cellpadding="0" id="page2_w_r_e_Products">
                    <tr id="page2_w_r_e_p_tr">
                      <td width="322"><%=r.getString(lang,"fj12hq46")%></td>
                      <td width="151"><%=r.getString(lang,"fj12hq4a")%></td>
                      <td><%=r.getString(lang,"fj12hq4b")%></td>
                    </tr>
                    <%
                    Enumeration e39=Node.find(sql39.toString(),pos,10);
                    while(e39.hasMoreElements())
                    {
                      int n39=((Integer)e39.nextElement()).intValue();
                      Node o39=Node.find(n39);
                      out.print("<tr id=Notice_tr><td id=Notice_tr_td01><a href=javascript:f_open('.?url=ViewReport&node="+n39+"')>"+o39.getSubject(lang)+"</a></td>");
                      out.print("<td>"+o39.getTimeToString()+"</td>");
                      out.print("<td><a href=javascript:f_open('?url=EditReport&node="+n39+"');><img src=/tea/image/eyp/images/page214.gif></a>");
                      if(o39.isLayerExisted(lang))
                      {
                        out.print(" <a href=\"javascript:f_open('/servlet/DeleteNode?node="+n39+"','"+r.getString(lang,"ConfirmDelete")+"');\"><img src=/tea/image/eyp/images/page215.gif></a>");
                      }
                      out.print("</td></tr>");
                    }
                    %>
		  </table>
		  <div id="page2_w_r_e_P_t_page"><%=new tea.htmlx.FPNL(lang,"?community="+como+"&url="+url+"&pos=",pos,count,10)%></div>
		</div>
  </div>
  <div id="edit_page2_bottom"></div>
