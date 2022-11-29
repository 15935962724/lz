<%@page contentType="text/html;charset=UTF-8"%>
<%@page import="tea.htmlx.*"%>
<%@page import="tea.db.*"%>
<%@page import="tea.ui.TeaSession"%>
<%@page import="tea.resource.*"%>
<%@page import="tea.entity.site.*"%>
<%@page import="tea.entity.member.Profile"%>
<%@page import="tea.entity.admin.*"%>
<%@page import="tea.entity.node.*"%>
<jsp:useBean id="sms" scope="page" class="tea.entity.node.Sms"/>
<%

  request.setCharacterEncoding("UTF-8");
  TeaSession teasession = new TeaSession(request);

  Resource r = new Resource("/tea/ui/util/SignUp1").add("/tea/htmlx/HtmlX");

  StringBuffer param=new StringBuffer();
  param.append("?community=").append(teasession._strCommunity);
  StringBuffer sql=new StringBuffer("  and caller =").append(DbAdapter.cite(teasession._rv.toString()));

  StringBuffer param2=new StringBuffer();
  param2.append("?community=").append(teasession._strCommunity);
  StringBuffer sql2=new StringBuffer(" and t.member="+DbAdapter.cite(teasession._rv.toString()));


String timek = request.getParameter("timek");
  if(timek!=null && (timek=timek.trim()).length()>0)
  {
    sql2.append(" and d.destinedate>=").append(" ").append(DbAdapter.cite(timek));
    param2.append("&destinedate=").append(timek);
  }
  String timej = request.getParameter("timej");
  if(timej!=null &&(timej=timej.trim()).length()>0)
  {
    sql2.append(" and d.destinedate<").append(" ").append(DbAdapter.cite(timej));
    param2.append("&destinedate=").append(timej);
  }


int count=Profile.countByCommunity(teasession._strCommunity,sql.toString());
int pos=0;
int pageSize=10;
if(teasession.getParameter("Pos")!=null)
{
  pos=Integer.parseInt(teasession.getParameter("Pos"));
}

int count2=Telephonist.countBy(teasession._strCommunity,sql2.toString());
int pos2=0;
int pageSize2=10;
if(teasession.getParameter("Pos2")!=null)
{
  pos2=Integer.parseInt(teasession.getParameter("Pos2"));
}

sql2.append("  ORDER BY destinedate desc ");

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body id="bodynone">
<script type="">
function f_deal(igd)
   {
     form1.destine.value=igd;
     form1.action='/jsp/registration/orderdeal.jsp';
     form1.submit();
   }
</script>
<div id="tablebgnone" class="register">
  <h1>话务员</h1>
  <div id="head6">
    <img height="6" src="about:blank" alt="">
  </div>
  <FORM name="form1" METHOD="POST" action="/jsp/registration/scallerwork.jsp">
  <input type="hidden" name="destine" value="">
  <input type="hidden" name="nexturl" value="<%=request.getRequestURL()%>"/>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td align="center">
        订单时间：从：
        <input name="timek" size="7"  value="<%if(timek!=null)out.print(timek);%>"><A href="###"><img onClick="showCalendar('form1.timek');" src="/tea/image/public/Calendar2.gif" align="top"/></a>
        &nbsp;&nbsp;
        到：
       <input name="timej" size="7"  value="<%if(timej!=null)out.print(timej);%>"><A href="###"><img onClick="showCalendar('form1.timej');" src="/tea/image/public/Calendar2.gif" align="top"/></a>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <input type="submit" value=" GO "/>
      </td>
    </tr>
  </table>
<h2>话务员创建的用户列表：共<%=count%>位</h2>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr id="tableonetr">
      <td nowrap>会员ID</td>
      <td nowrap>姓名</td>
      <td nowrap>性别</td>
      <td nowrap>联系方式</td>
    </tr>
    <%
    java.util.Enumeration e = Profile.findByCommunity(teasession._strCommunity,sql.toString(),pos,pageSize);
     if(!e.hasMoreElements())
       {
         out.print("<tr><td align=center colspan=10>暂无记录</td></tr>");
       }
    while(e.hasMoreElements())
    {
      String member = ((String)e.nextElement());
      Profile p = Profile.find(member);
      %>
      <tr  onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
        <td>
          <a href="/jsp/registration/ProfileView.jsp?member=<%=java.net.URLEncoder.encode(p.getMember(),"UTF-8")%>"><%=p.getMember()%></a>
        </td>
        <td><%=p.getLastName(teasession._nLanguage)+p.getFirstName(teasession._nLanguage) %></td>
        <td><%
        if(p.isSex())
        out.print("女");
        else
        out.print("男");
        %></td>
        <td><%=p.getMobile()%></td>
      </tr>
      <%
      }if(count>pageSize){
        %>
        <tr>
          <td>&nbsp;</td>
          <td align="center"><%=new tea.htmlx.FPNL(teasession._nLanguage, request.getRequestURI()+param.toString() + "&Pos=", pos, count,pageSize)%></td>
        </tr><%} %>
  </table>
    <h2>该话务员下订单列表：共<%=count2%>份</h2>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">

  <tr id="tableonetr">
    <td nowrap>订单号</td>
    <td nowrap>酒店</td>
    <td nowrap>订单时间</td>
    <td nowrap>订单状态</td>
    <td nowrap>&nbsp;</td>
  </tr>
  <%
     java.util.Enumeration e2 = Telephonist.findBy(teasession._strCommunity,sql2.toString(),pos2,pageSize2);
      if(!e2.hasMoreElements())
       {
         out.print("<tr><td align=center colspan=10>暂无记录</td></tr>");
       }
     while(e2.hasMoreElements())
     {
       int id = ((Integer)e2.nextElement()).intValue();
       Telephonist t =Telephonist.find(id);
       Destine d = Destine.find(id);
       Node n = Node.find(d.getNode());
  %>
  <tr  onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    <td>
    <a href="/jsp/registration/DestineView.jsp?node=<%=d.getNode()%>&destine=<%=d.getDestine()%>&roomprice=<%=d.getRoomprice()%>"> <%=id%></a>
    </td>
    <td> <a href="/jsp/registration/HostelView.jsp?node=<%=d.getNode()%>"><%=n.getSubject(teasession._nLanguage) %></a></td>
    <td><%=d.getDestinedateToString()%></td>
    <td><%=Destine.STATE[d.getState()]%></td>
    <td>
    <%
    if(d.getState()==0)
    {
      out.print("<input type=button value=通知 onclick=\"f_deal('"+id+"');\">");
    }else{out.print("&nbsp;");}
    %>
    </td>
  </tr>
 <%}
 if(count2>pageSize2){
 %>
 <tr>
   <td>&nbsp;</td>
     <td align="center"><%=new tea.htmlx.FPNL(teasession._nLanguage, request.getRequestURI()+param2.toString() + "&Pos2=", pos2, count2,pageSize2)%></td>
 </tr><%} %>
 </table>
  </FORM>
    <script language="JavaScript">
 anole('',1,'#F2F2F2','#DEEEDB','','');
  /*tr_tableid, // table id
  num_header_offset,// 表头行数
  str_odd_color, // 奇数行的颜色
  str_even_color,// 偶数行的颜色
  str_mover_color, // 鼠标经过行的颜色
  str_onclick_color // 选中行的颜色
  */
  </script>
</body>
</html>
</html>
