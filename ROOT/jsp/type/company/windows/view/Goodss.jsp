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
        <div id="page2_left_top"><%=r.getString(lang,"fj0vgqwk")%><!--产品类别--></div>
        <ul>
        <%
        Enumeration e34_=Node.find(" AND father="+folder34+" AND type=1",0,200);
        while(e34_.hasMoreElements())
        {
          int id34=((Integer)e34_.nextElement()).intValue();
          Node o34=Node.find(id34);
          out.print("<li><a href=#Menu="+id34+" onclick=DoMenu('"+id34+"')>"+o34.getSubject(lang)+"</a></li>");

          out.print("<ul id="+id34+" class=collapsed>");
          Enumeration e34=Node.find(" AND father="+id34+" AND type=34",0,20);
          while(e34.hasMoreElements())
          {
            id34=((Integer)e34.nextElement()).intValue();
            o34=Node.find(id34);
            out.print("<li><a href=?community="+como+"&url=ViewGoods&node="+id34+">"+o34.getSubject(lang)+"</a></li>");
          }
          out.print("</ul>");
        }
        %>
          </ul>
    </div>
  </div>
  <div id="page2_wai_right">
    <div id="page2_right">
      <div id="page2_right_top"><font><a href="?community=<%=como%>"><%=r.getString(lang,"fj0vgqw1")%></a> > <%=wbs[14].getName(lang)%></font></div>
    </div>
    <div id="page2_right_bottom">

      <ul id="Products_li">
      <%
      Enumeration e34=Node.find(" AND path LIKE "+DbAdapter.cite(n34.getPath()+"%")+" AND type=34 ORDER BY node DESC",pos,10);
      while(e34.hasMoreElements())
      {
        int id34=((Integer)e34.nextElement()).intValue();
        Node o34=Node.find(id34);
        Goods g34=Goods.find(id34);
        String pic=g34.getSmallpicture(lang);
        if(pic==null||pic.length()==0)
        {
          pic="/tea/image/eyp/goods_no_photo.jpg";
        }
        out.print("<li><table id=Products_li_table cellspacing=0 cellpadding=0>");
        out.print("<tr><td id=Products_li_t_img><img src="+pic+"></td></tr>");
        out.print("<tr><td id=Products_li_t_01><a href=?community="+como+"&url=ViewGoods&node="+id34+">"+o34.getSubject(lang)+"</a></td></tr>");
        out.print("<tr><td id=Products_li_t_02>￥：<font>"+g34.getPrice()+"元</font></td></tr>");
        out.print("<tr><td id=Products_li_t_03><input type=button value="+r.getString(lang,"fj0vgqwo")+" onclick=f_buy("+id34+",'"+teasession._rv+"')>　<input type=button value="+r.getString(lang,"fj0vgqwp")+" onclick=window.open('?community="+como+"&url=ViewGoods&node="+id34+"','_self')></td></tr></table></li>");
      }
      %>
      </ul>
      <div id="Paging"><%=new tea.htmlx.FPNL(lang,"?community="+como+"&url="+url+"&pos=",pos,10)%></div>




</div>
		</div>
  </div>
  <div id="page2_bottom">
  </div>


