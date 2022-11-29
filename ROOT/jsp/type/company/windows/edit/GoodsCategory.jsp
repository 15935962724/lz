<%@page contentType="text/html;charset=UTF-8" %>
<%

int count=Node.count(" AND father="+folder34+" AND type=1");

%>
<script>
function f_edit34(node,subject)
{
  form1.node.value=node;
  form1.subject.value=subject;
  form1.subject.focus();
}
</script>
<form name="form1" action="/servlet/EditCompanyWindows" method="post" onsubmit="return submitText(this.subject,'<%=r.getString(teasession._nLanguage, "InvalidSubject")%>')">
<input type="hidden" name="node" value="<%=folder34%>">
<input type="hidden" name="nexturl" value="<%=request.getRequestURI()+"?"+request.getQueryString()%>">
<input type="hidden" name="act" value="category34">


  <div id="edit_page2">
    <div id="edit_page2_wai_left">
      <div id="edit_page2_left">

<table>
  <tr>
    <td><span><a href="javascript:f_open('?url=Goodss')"><%=r.getString(lang,"fj0vgqxc")%></a></span> </td>
  </tr>
  <tr>
    <td id="li_te"><span><%=r.getString(lang,"fj0vgqxd")%></span> </td>
  </tr>
  <tr>
    <td><span><a href="javascript:f_open('?url=EditGoods')"><%=r.getString(lang,"fj0vgqxe")%></a></span> </td>
  </tr>
</table>

      </div>
    </div>
    <div id="edit_page2_wai_right">
      <div id="edit_page2_right"><span><%=r.getString(lang,"fj0vgqxd")+" ( "+count+" )"%></span>
    </div>

    <div id="page2_w_r_e_p_style"></div>

<div id="page2_w_r_e_p_s_top">
  <input name="subject" type="text" id="page2_w_r_e_p_s_top_input01">
  <input type="submit" id="page2_w_r_e_p_s_top_input02" value="<%=r.getString(lang,"fj14p1y6")%>" />
</div>

<table  cellspacing="0" cellpadding="0" id="page2_w_r_e_P_table">
  <tr id="page2_w_r_e_P_t_tr01">
    <td  width="323"><%=r.getString(lang,"fj12hq4f")%></td>
    <td><%=r.getString(lang,"fj12hq4b")%></td>
  </tr>
  <%
  Enumeration e34=Node.find(" AND father="+folder34+" AND type=1",0,200);
  for(int i34=0;e34.hasMoreElements();i34++)
  {
    int id34=((Integer)e34.nextElement()).intValue();
    Node o34=Node.find(id34);
    int c34=Node.count(" AND father="+id34);
    out.print("<tr><td><a href=javascript:f_open('.?url=Goodss') id=s"+id34+">"+o34.getSubject(lang)+"</a> ( "+c34+" )</td>");
    out.print("<td><a href=javascript:; onclick=f_edit34("+id34+",s"+id34+".innerHTML);><img src=/tea/image/eyp/images/page214.gif></a> ");
    if(i34!=0)
    {
      if(o34.isLayerExisted(lang))
      {
        out.print("<a href=\"javascript:"+(c34<1?"f_open('/servlet/DeleteNode?node="+id34+"','"+r.getString(lang,"ConfirmDelete")+"');":"alert('"+r.getString(lang,"fj12hq4j")+"');")+"\"><img src=/tea/image/eyp/images/page215.gif></a></td></tr>");
      }
    }
  }
  %>
</table>
<div id="page2_w_r_e_P_t_page"><%=new tea.htmlx.FPNL(lang,"?community="+como+"&url="+url+"&pos=",pos,count,10)%></div>


</div>
  </div>
  <div id="edit_page2_bottom"></div>

</form>
<script>
form1.subject.focus();
</script>
