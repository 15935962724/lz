<%@page contentType="text/html;charset=UTF-8" %>
<%


int count=Node.count(" AND father="+father73+" AND type=73");
%>
<div id="page2">
  <div id="page2_wai_left">
    <div id="page2_left">

<div id="page2_left_top"><%=wbs[20].getName(lang)%></div>
<ul>
<%
Enumeration e73=Node.find(" AND father="+father73+" AND type=73 ORDER BY node DESC",pos,10);
if(!e73.hasMoreElements())
{
  out.print("<script>alert('"+r.getString(lang,"fj0vgqxa")+"');history.back();</script>");
  return;
}
for(int i=0;e73.hasMoreElements();i++)
{
  int n73=((Integer)e73.nextElement()).intValue();
  if(i==0&&n.getType()!=73)
  {
    out.print("<script>window.location.replace('?community="+como+"&url=ViewMessageBoard&node="+n73+"');</script>");
    return;
  }
  Node o73=Node.find(n73);
  out.print("<li><a href=?community="+como+"&url=ViewMessageBoard&node="+n73);
  if(n73==node)
  {
    out.print(" style=color:#0C419A");
  }
  out.print(">"+o73.getSubject(lang)+"</a></li>");
}
%>
</ul>
<%=new tea.htmlx.FPNL(lang,"?community="+como+"&url="+url+"&node="+node+"&pos=",pos,count,10)%>
</div>
</div>

<div id="page2_wai_right">
  <div id="page2_right">
    <div id="page2_right_top"><font><a href="?community=<%=como%>"><%=r.getString(lang,"fj0vgqw1")%></a> > <%=wbs[20].getName(lang)%> > <%=n.getSubject(lang)%></font></div>
  </div>
  <div id="page2_right_bottom">
    <div id="page2_r_b_title"><font><%=n.getSubject(lang)%></font><br><%=n.getTimeToString()%></div>
  </div>

<table cellspacing="0" cellpadding="0" id="page2_w_r_e_Notice">
  <tr>
    <td><%=n.getText(lang)%></td>
  </tr>
</table>

<div id="Products_con_title"><%=r.getString(lang,"fj12hq4i")%></div>
<table id="messageboard">
<%
e73=Talkback.find(node,pos,10);
while(e73.hasMoreElements())
{
  int tid=((Integer)e73.nextElement()).intValue();
  Talkback tb=Talkback.find(tid);
  String subject=tb.getSubject(lang);
  String content=tb.getContent(lang);
  if(subject==null||content==null)continue;
  subject=subject.replaceAll("<","&lt;");
  content=content.replaceAll("<","&lt;");
  out.print("<tr><td id=td01>"+subject+"</td>");
  out.print("<td id=td02>"+tb.getTelephone(lang)+"</td>");
  out.print("<td id=td03>"+tb.getEmail(lang)+"</td>");
  out.print("<td id=td04>"+tb.getTimeToString()+"</td></tr>");
  out.print("<tr><td colspan=4>"+content+"</td></tr>");

  Enumeration er73=TalkbackReply.findByTalkback(tid);
  while(er73.hasMoreElements())
  {
    int trid=((Integer)er73.nextElement()).intValue();
    TalkbackReply tr=TalkbackReply.find(trid);
    out.print("<tr><td id=td01>"+r.getString(lang,"fj14p1yw")+"</td>");
    out.print("<td id=td02></td>");
    out.print("<td id=td03></td>");
    out.print("<td id=td04>"+tr.getTimeToString()+"</td></tr>");
    out.print("<tr><td colspan=4 id=td"+trid+">"+tr.getText()+"</td></tr>");
  }
}
%>
</table>


<div id="Products_con_title"><%=r.getString(lang,"fj14p1yx")%></div>
<form action="/servlet/EditTalkback" method="post" onsubmit="return submitText(this.subject,'<%=r.getString(lang,"fj12hq4w")+"-"+r.getString(lang,"fj14p1yy")%>')
&&submitText(this.telephone,'<%=r.getString(lang,"fj12hq4w")+"-"+r.getString(lang,"fj14p1z1")%>')
&&submitText(this.content,'<%=r.getString(lang,"fj12hq4w")+"-"+r.getString(lang,"fj14p1z2")%>')">
<input type="hidden" name="node" value="<%=node%>"/>
<input type="hidden" name="nexturl" value="<%=request.getRequestURI()+"?"+request.getQueryString()%>">

<table cellspacing="0" cellpadding="0" id="Products_con_Message">
  <tr>
    <td id="Products_con_M_td01"><%=r.getString(lang,"fj14p1yy")%></td>
    <td id="Products_con_M_td02"><input name="subject" type="text"></td>
  </tr>
  <tr>
    <td id="Products_con_M_td01"><%=r.getString(lang,"fj14p1yz")%></td>
    <td id="Products_con_M_td02"><input name="address" type="text"></td>
  </tr>
  <tr>
    <td id="Products_con_M_td01"><%=r.getString(lang,"fj14p1z0")%></td>
    <td id="Products_con_M_td02"><input name="zip" type="text"></td>
  </tr>
  <tr>
    <td id="Products_con_M_td01"><%=r.getString(lang,"fj14p1z1")%></td>
    <td id="Products_con_M_td02"><input name="telephone" type="text"></td>
  </tr>
  <tr>
    <td id="Products_con_M_td01">E - Mail</td>
    <td id="Products_con_M_td02"><input name="email" type="text"></td>
  </tr>
  <tr>
    <td id="Products_con_M_td01" valign="top"><%=r.getString(lang,"fj14p1z2")%></td>
    <td id="Products_con_M_td02"><textarea name="content" cols="" rows=""></textarea></td>
  </tr>
</table>

<input id="Products_con_submit" type="submit" value="<%=r.getString(lang,"fj14p1z3")%>">
</form>


  </div>
  </div>
  <div id="page2_bottom"></div>
