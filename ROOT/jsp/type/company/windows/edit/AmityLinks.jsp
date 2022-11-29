<%@page contentType="text/html;charset=UTF-8" %>
<%
int count=Node.count(" AND father="+father78+" AND type=78");



%>

  <div id="edit_page2">
    <div id="edit_page2_wai_left">
      <div id="edit_page2_left">
        <table>
          <tr><td id="li_te"><span>合作伙伴列表</span>
</td></tr>
<tr><td><span><a href="javascript:f_open('?url=EditAmityLink')">添加合作伙伴</a></span>
</td></tr>
        </table>
		</div>
		</div>
		<div id="edit_page2_wai_right">
		  <div id="edit_page2_right"><span>合作伙伴列表(<%=count%>)</span>
		  </div>

		  <table  cellspacing="0" cellpadding="0" id="page2_w_r_e_Products">
                    <tr id="page2_w_r_e_p_tr"><td width="322">名称</td><td width="151">链接时间</td><td>操作</td></tr>
                    <%
                    Enumeration e78=Node.find(" AND father="+father78+" AND type=78 ORDER BY node DESC",pos,10);
                    while(e78.hasMoreElements())
                    {
                      int n78=((Integer)e78.nextElement()).intValue();
                      Node o78=Node.find(n78);
                      AmityLink al78=AmityLink.find(n78,lang);
                      out.print("<tr id=Notice_tr><td id=Notice_tr_td01><a href="+al78.getUrl()+" target=_blank>"+o78.getSubject(lang)+"</a></td>");
                      out.print("<td>"+o78.getTimeToString()+"</td>");
                      out.print("<td><a href=javascript:f_open('?url=EditAmityLink&node="+n78+"');><img src=/tea/image/eyp/images/page214.gif></a> <a href=javascript:f_open('/servlet/DeleteNode?node="+n78+"','确认删除?');><img src=/tea/image/eyp/images/page215.gif></a></td></tr>");
                    }
                    %>
		  </table>
		  <div id="page2_w_r_e_P_t_page"><%=new tea.htmlx.FPNL(lang,"?community="+como+"&url="+url+"&pos=",pos,count,10)%></div>
		</div>
  </div>
  <div id="edit_page2_bottom"></div>
