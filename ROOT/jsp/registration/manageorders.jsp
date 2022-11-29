<%@page contentType="text/html;charset=UTF-8"%>
<%@page import="tea.htmlx.*"%>
<%@page import="tea.db.*" %>
<%@page import="tea.ui.TeaSession"%>
<%@page import="tea.resource.*"%>
<%@page import="tea.entity.site.*"%>
<%@page import="tea.entity.member.Profile"%>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.node.*" %>

<%
  request.setCharacterEncoding("UTF-8");
  TeaSession teasession = new TeaSession(request);
  Resource r = new Resource("/tea/ui/util/SignUp1").add("/tea/htmlx/HtmlX");

  StringBuffer param=new StringBuffer("?community=").append(teasession._strCommunity);
  StringBuffer sql=new StringBuffer("  and d.state=0 and n.rcreator="+DbAdapter.cite(teasession._rv.toString()));


  StringBuffer param2=new StringBuffer("?community=").append(teasession._strCommunity);
  StringBuffer sql2=new StringBuffer(" and d.state >=1 and n.rcreator="+DbAdapter.cite(teasession._rv.toString()));

  Citypopedom cobj = Citypopedom.find(teasession._rv.toString());
  java.util.Enumeration ae = AdminUsrRole.find(teasession._strCommunity," and member ="+DbAdapter.cite(teasession._rv.toString())+" and role like "+DbAdapter.cite("%/"+5+"/%"),0,Integer.MAX_VALUE);
if(ae.hasMoreElements()){
  if(cobj.getCityid()==null )
  {
    response.sendError(403);
    return;
  }
  sql.append(" and d.node in (select node from Hostel where  ");
  sql2.append(" and d.node in (select node from Hostel where  ");
  String cm[] = cobj.getCityid().split("/");
  for(int i =1;i<cm.length;i++)
  {
    if(cobj.getCityid()!=null){
      sql.append(" city = ").append(Integer.parseInt(cm[i]));
      sql2.append(" city = ").append(Integer.parseInt(cm[i]));
    }
    if(cm.length-1>i){
      sql.append(" or ");
      sql2.append(" or ");
    }
  }

  sql.append(" )");
  sql2.append(" )");
}

  String member = request.getParameter("member");
  if(member!=null &&(member=member.trim()).length()>0)
  {
    sql.append(" and d.member like ").append(" ").append(DbAdapter.cite("%"+member+"%"));
    param.append("&member=").append(member);
  }

  String timek = request.getParameter("timek");
  if(timek!=null && (timek=timek.trim()).length()>0)
  {
    sql.append(" and d.destinedate>=").append(" ").append(DbAdapter.cite(timek));
    param.append("&destinedate=").append(timek);
  }
  String timej = request.getParameter("timej");
  if(timej!=null &&(timej=timej.trim()).length()>0)
  {
    sql.append(" and d.destinedate<=").append(" ").append(DbAdapter.cite(timej));
    param.append("&destinedate=").append(timej);
  }

  int count=Destine.countBy(teasession._strCommunity,sql.toString());
  int pos=0;
  int pageSize=10;
  if(teasession.getParameter("pos")!=null)
  {
    pos=Integer.parseInt(teasession.getParameter("pos"));
  }
  sql.append(" ORDER BY d.destinedate desc  ");
  int count2= Destine.countBy(teasession._strCommunity,sql2.toString());
  int pos2=0;
  int pageSize2=10;
  if(teasession.getParameter("pos2")!=null)
  {
    pos2=Integer.parseInt(teasession.getParameter("pos2"));
  }
sql2.append(" ORDER BY d.destinedate desc  ");
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<script>
   function f_deal(igd)
   {
     form1.destine.value=igd;
     form1.action='/jsp/registration/deal.jsp';
     form1.submit();
   }
</script>
<body id="bodynone">

<h1>订单审批</h1>
  <div id="head6">
    <img height="6" src="about:blank" alt="">
  </div>
  <FORM name="form1" METHOD="POST" action="">
  <input type="hidden" name="destine" value="">
  <input type="hidden" name="nexturl" value="<%=request.getRequestURL()%>"/>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td>会员ID：<input name="member" value="<%if(member!=null)out.print(member);%>" />&nbsp;
    订单时间：从
     <input name="timek" size="7"  value="<%if(timek!=null)out.print(timek);%>"><A href="###"><img onClick="showCalendar('form1.timek');" src="/tea/image/public/Calendar2.gif" align="top"/></a>
      到：
      <input name="timej" size="7"  value="<%if(timej!=null)out.print(timej);%>"><A href="###"><img onClick="showCalendar('form1.timej');" src="/tea/image/public/Calendar2.gif" align="top"/></a>
     &nbsp;<%--订单状态：<select name="state">
     <option value="0">全部</option>
     <option value="1">未受理</option>
     <option value="2">已经受理</option>
     <option value="3">已入住</option>
     <option value="4">未达</option>
     </select>--%>
   <input type="submit" value=" GO " />
    </td>

  </tr>
  </table>
<h2>未受理的订单<%=count%></h2>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">

    <tr id="tableonetr">
      <td nowrap>订单号</td>
      <td>会员ID</td>
      <td nowrap>酒店</td>
      <td nowrap>订单时间</td>
      <td nowrap>操作</td>
    </tr>
    <%
       java.util.Enumeration e = Destine.findBy(teasession._strCommunity,sql.toString(),pos,pageSize);
       if(!e.hasMoreElements())
       {
         out.print("<tr><td align=center colspan=4>暂无记录</td></tr>");
       }
       while(e.hasMoreElements())
       {
         int id = ((Integer)e.nextElement()).intValue();
         Destine d = Destine.find(id);
         Node n = Node.find(d.getNode());

         Hostel h = Hostel.find(d.getNode(),teasession._nLanguage);
       %>
       <tr  onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
         <td nowrap>
          <a href="/jsp/registration/DestineView.jsp?node=<%=n._nNode%>&destine=<%=d.getDestine()%>&roomprice=<%=d.getRoomprice()%>"><%=id%></a>
         </td>
         <td><a href="/jsp/registration/ProfileView.jsp?member=<%=java.net.URLEncoder.encode(d.getMember(),"UTF-8")%>"><%=d.getMember() %></a></td>
         <td>
           <a href="/jsp/registration/HostelView.jsp?node=<%=n._nNode%>"><%=n.getSubject(teasession._nLanguage) %></a>
         </td>
         <td><%=d.getDestinedateToString() %></td>
         <td>
         <input type="button" value="审核" onClick="f_deal('<%=id%>');"/>
         </td>
       </tr><%
       }if(count>pageSize){
       %>
       <tr>

         <td align="center" colspan="10"><%=new tea.htmlx.FPNL(teasession._nLanguage, request.getRequestURI()+param.toString() + "&pos=", pos, count,pageSize)%></td>
       </tr><%} %>

  </table>
  <h2>已受理的订单<%=count2 %></h2>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">

    <tr id="tableonetr">
      <td nowrap>订单号</td>
      <td nowrap>酒店</td>
      <td nowrap>订单时间</td>
      <td nowrap>状态</td>
    </tr>
    <%
       java.util.Enumeration e2 = Destine.findBy(teasession._strCommunity,sql2.toString(),pos2,pageSize2);
        if(!e2.hasMoreElements())
       {
         out.print("<tr><td align=center colspan=4>暂无记录</td></tr>");
       }
       while(e2.hasMoreElements())
       {
         int id2 = ((Integer)e2.nextElement()).intValue();
         Destine d2 = Destine.find(id2);
         Node n2 = Node.find(d2.getNode());
         Hostel h2 = Hostel.find(d2.getNode(),teasession._nLanguage);
       %>
       <tr  onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
         <td nowrap>
          <a href="/jsp/registration/DestineView.jsp?node=<%=n2._nNode%>&destine=<%=d2.getDestine()%>&roomprice=<%=d2.getRoomprice()%>"><%=id2%></a>
         </td>
         <td>
           <a href="/jsp/registration/HostelView.jsp?node=<%=n2._nNode%>"><%=n2.getSubject(teasession._nLanguage) %></a>
         </td>
         <td><%=d2.getDestinedateToString() %></td>
         <td>
         <%
         if(d2.getIdeatype()==0){
           out.print("<a href=#  onclick=\"javascript:window.open('/jsp/registration/dealcontent.jsp?destine="+id2+"','newjsp','width=500,height=400,scrollbars=1,top=400,left=400');\">审批通过</a>");
         }
         if(d2.getIdeatype()==1)
         {
            out.print("<a href=#  onclick=\"javascript:window.open('/jsp/registration/dealcontent.jsp?destine="+id2+"','newjsp','width=500,height=400,scrollbars=1,top=400,left=400');\">审批失败</a>");
         }
         %>
         </td>
       </tr><%
       }if(count2>pageSize2){
 %>
     <tr>

      <td align="center" colspan="4"><%=new tea.htmlx.FPNL(teasession._nLanguage, request.getRequestURI()+param2.toString() + "&pos2=", pos2, count2,pageSize2)%></td>
      </tr><%}%>
  </table>
  </FORM>

<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
  <script language="JavaScript">
   anole('',1,'#F2F2F2','#DEEEDB','','');
  </script>
</body>
</html>
</html>
