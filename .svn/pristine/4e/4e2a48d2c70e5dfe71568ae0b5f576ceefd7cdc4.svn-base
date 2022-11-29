<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.ui.*" %>
<%@page import="tea.db.*" %>
<%@page import="tea.resource.*" %>
<%@page import="java.util.*" %>
<%@page import="java.io.*" %>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.entity.member.*" %>
<%@page import="tea.entity.site.*" %>
<%
Goods g34=Goods.find(node);
String sp=g34.getSmallpicture(lang);
if(sp==null||sp.length()==0)
{
  sp="";
}

%>
  <div id="page2">
    <div id="page2_wai_left">
      <div id="page2_left">
        <div id="page2_left_top"><%=r.getString(lang, "fj0vgqwk")%></div>
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
      <div id="page2_right_top"><font><a href=".?community=<%=como%>"><%=r.getString(lang,"fj0vgqw1")%></a> > <a href="?community=<%=como%>&url=Goodss"><%=wbs[14].getName(lang)%></a> > <%=n.getSubject(lang)%></font>
    </div>
  </div>
  <div id="page2_right_bottom">
    <div id="page2_r_b_title"><font><%=n.getSubject(lang)%></font><br><%=n.getTimeToString()%></div>

      <div id="Products_con_top"><img src="<%=sp%>" width="352" height="250"></div>
        <div id="Products_con_botton">
          <input type="button" value="<%=r.getString(lang, "fj2jrg2l")%>" onclick="f_buy(<%=node%>,'<%=teasession._rv%>')"/>　<input type="button" value="<%=r.getString(lang, "fj2jrg2m")%>" onclick="f_call(<%=node%>,'<%=n.getCreator()%>')"/></div>
          <div id="Products_con_title"><%=r.getString(lang, "fj14p1yu")%></div>
          <ul id="Products_con_Details">
            <li><font><%=r.getString(lang, "fj12hq4k")%>：</font><%=n.getSubject(lang)%></li>
            <li><font><%=r.getString(lang, "fj14p1yv")%>：</font><%=Node.find(n.getFather()).getSubject(lang)%></li>
            <li><font><%=r.getString(lang, "fj12hq4n")%>：</font><%=g34.getNo()%></li>
            <li><font><%=r.getString(lang, "fj12hq4o")%>：</font><%=g34.getSpec(lang)%></li>
            <li><font><%=r.getString(lang, "fj12hq4p")%>：</font><%=g34.getPrice()%></li>
            <li><font><%=r.getString(lang, "fj12hq4q")%>：</font><%=g34.getCapability(lang)%>个</li>
            <li><font><%=r.getString(lang, "fj12hq4r")%>：</font><%=n.getText(lang)%></li>
          </ul>
<div id="Products_con_title"><%=r.getString(lang, "fj12hq4i")%></div>
<table>
<%
Enumeration e34=Talkback.find(node,pos,10);
while(e34.hasMoreElements())
{
  int tid=((Integer)e34.nextElement()).intValue();
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

  Enumeration er34=TalkbackReply.findByTalkback(tid);
  while(er34.hasMoreElements())
  {
    int trid=((Integer)er34.nextElement()).intValue();
    TalkbackReply tr=TalkbackReply.find(trid);
    out.print("<tr><td id=td01>"+r.getString(lang, "fj14p1yw")+"</td>");
    out.print("<td id=td02></td>");
    out.print("<td id=td03></td>");
    out.print("<td id=td04>"+tr.getTimeToString()+"</td></tr>");
    out.print("<tr><td colspan=4 id=td"+trid+">"+tr.getText()+"</td></tr>");
  }
}
%>
</table>

<div id="Products_con_title"><%=r.getString(lang, "fj14p1yx")%></div>
<form action="/servlet/EditTalkback" method="post" onsubmit="return submitText(this.subject,'<%=r.getString(lang, "fj12hq4w")+"-"+r.getString(lang, "fj14p1yy")%>')
&&submitText(this.telephone,'<%=r.getString(lang, "fj12hq4w")+"-"+r.getString(lang, "fj14p1z1")%>')
&&submitText(this.content,'<%=r.getString(lang, "fj12hq4w")+"-"+r.getString(lang, "fj14p1z2")%>')">
<input type="hidden" name="node" value="<%=node%>"/>
<input type="hidden" name="nexturl" value="<%=request.getRequestURI()+"?"+request.getQueryString()%>">

<table cellspacing="0" cellpadding="0" id="Products_con_Message">
  <tr>
    <td id="Products_con_M_td01"><%=r.getString(lang, "fj14p1yy")%></td>
    <td id="Products_con_M_td02"><input name="subject" type="text"></td>
  </tr>
  <tr>
    <td id="Products_con_M_td01"><%=r.getString(lang, "fj14p1yz")%></td>
    <td id="Products_con_M_td02"><input name="address" type="text"></td>
  </tr>
  <tr>
    <td id="Products_con_M_td01"><%=r.getString(lang, "fj14p1z0")%></td>
    <td id="Products_con_M_td02"><input name="zip" type="text"></td>
  </tr>
  <tr>
    <td id="Products_con_M_td01"><%=r.getString(lang, "fj14p1z1")%></td>
    <td id="Products_con_M_td02"><input name="telephone" type="text"></td>
  </tr>
  <tr>
    <td id="Products_con_M_td01">E - Mail</td>
    <td id="Products_con_M_td02"><input name="email" type="text"></td>
  </tr>
  <tr>
    <td id="Products_con_M_td01" valign="top"><%=r.getString(lang, "fj14p1z2")%></td>
    <td id="Products_con_M_td02"><textarea name="content" cols="" rows=""></textarea></td>
  </tr>
</table>

<input id="Products_con_submit" type="submit" value="<%=r.getString(lang, "fj14p1z3")%>">
</form>

</div>
</div>
  </div>
  <div id="page2_bottom">
  </div>
