<%@page contentType="text/html;charset=UTF-8" %>
<%
int count=Node.count(" AND father="+father87+" AND type=87");

%>
  <div id="edit_page2">
    <div id="edit_page2_wai_left">
      <div id="edit_page2_left">
		<table>
			<tr><td id="li_te"><span>公告列表</span>
			</td></tr>
			<tr><td><span><a href="javascript:f_open('?url=EditBulletinBoard')">添加公告</a></span>
			</td></tr>
		</table>
		</div>
		</div>
		<div id="edit_page2_wai_right">
		  <div id="edit_page2_right"><span>公告列表(<%=count%>)</span>
		  </div>

		  <table  cellspacing="0" cellpadding="0" id="page2_w_r_e_Products">
                    <tr id="page2_w_r_e_p_tr"><td width="322">标题</td><td width="151">发布时间</td><td>操作</td></tr>
                    <%
                    Enumeration e87=Node.find(" AND father="+father87+" AND type=87 ORDER BY node DESC",pos,10);
                    while(e87.hasMoreElements())
                    {
                      int n87=((Integer)e87.nextElement()).intValue();
                      Node o87=Node.find(n87);
                      out.print("<tr id=Notice_tr><td id=Notice_tr_td01><a href=javascript:f_open('.?url=ViewBulletinBoard&node="+n87+"')>"+o87.getSubject(lang)+"</a></td>");
                      out.print("<td>"+o87.getTimeToString()+"</td>");
                      out.print("<td><a href=javascript:f_open('?url=EditBulletinBoard&node="+n87+"');><img src=/tea/image/eyp/images/page214.gif></a> <a href=javascript:f_open('/servlet/DeleteNode?node="+n87+"','确认删除?');><img src=/tea/image/eyp/images/page215.gif></a></td></tr>");
                    }
                    %>
		  </table>
		  <div id="page2_w_r_e_P_t_page"><%=new tea.htmlx.FPNL(lang,"?community="+como+"&url="+url+"&pos=",pos,count,10)%></div>

		</div>
  </div>
  <div id="edit_page2_bottom"></div>
