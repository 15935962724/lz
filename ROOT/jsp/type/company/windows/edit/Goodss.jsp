<%@page contentType="text/html;charset=UTF-8" %>
<%
StringBuffer sql=new StringBuffer();
sql.append(" AND path LIKE "+DbAdapter.cite(n34.getPath()+"%")+" AND type=34");

int count=Node.count(sql.toString());

sql.append(" ORDER BY node DESC");


%>


  <div id="edit_page2">
    <div id="edit_page2_wai_left">
      <div id="edit_page2_left">

<table>
  <tr>
    <td id="li_te"><span><%=r.getString(lang,"fj0vgqxc")%></span> </td>
  </tr>
  <tr>
    <td><span><a href="javascript:f_open('?url=GoodsCategory')"><%=r.getString(lang,"fj0vgqxd")%></a></span> </td>
  </tr>
  <tr>
    <td><span><a href="javascript:f_open('?url=EditGoods')"><%=r.getString(lang,"fj0vgqxe")%></a></span></td>
  </tr>
</table>

      </div>
    </div>
    <div id="edit_page2_wai_right">
      <div id="edit_page2_right"><span><%=r.getString(lang,"fj0vgqxc")%></span>
    </div>

    <table  cellspacing="0" cellpadding="0" id="page2_w_r_e_Products">
      <tr id="page2_w_r_e_p_tr"><td width="221"><%=r.getString(lang,"fj12hq4f")%></td><td width="112"><%=r.getString(lang,"fj12hq4g")%></td><td width="92"><%=r.getString(lang,"fj12hq4h")%></td><td width="65"><%=r.getString(lang,"fj12hq4i")%></td><td><%=r.getString(lang,"fj12hq4b")%></td></tr>
      <%
      Enumeration e34=Node.find(sql.toString(),pos,10);
      while(e34.hasMoreElements())
      {
        int id34=((Integer)e34.nextElement()).intValue();
        Node o34=Node.find(id34);
        out.print("<tr id=Notice_tr><td id=Notice_tr_td01><a href=javascript:f_open('.?url=ViewGoods&node="+id34+"')>"+o34.getSubject(lang)+"</a></td>");
        out.print("<td>"+Node.find(o34.getFather()).getSubject(lang)+"</td>");
        out.print("<td>"+o34.getTimeToString()+"</td>");
        out.print("<td><a href=javascript:f_open('?url=Talkbacks&node="+id34+"')>"+Talkback.count(id34)+"</a></td>");
        out.print("<td><a href=javascript:f_open('?url=EditGoods&node="+id34+"');><img src=/tea/image/eyp/images/page214.gif></a> ");
        if(o34.isLayerExisted(lang))
        {
          out.print("<a href=\"javascript:f_open('/servlet/DeleteNode?node="+id34+"','"+r.getString(lang,"ConfirmDelete")+"');\"><img src=/tea/image/eyp/images/page215.gif></a>");
        }
        out.print("</td></tr>");
      }
      %>
      </table>
      <div id="page2_w_r_e_P_t_page"><%=new tea.htmlx.FPNL(lang,"?community="+como+"&url="+url+"&pos=",pos,count,10)%></div>
</div>
  </div>
  <div id="edit_page2_bottom"></div>
