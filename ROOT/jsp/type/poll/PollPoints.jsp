
<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>
<%

r.add("/tea/ui/node/type/poll/EditPoll");
String community=request.getParameter("community");
if(community==null)
community=node.getCommunity();


int param_poll=0;
if(request.getParameter("poll")!=null)
{
  param_poll=Integer.parseInt(request.getParameter("poll"));
}

%><html>
<head>
<link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="">
function td_calendar(fieldname)
{
  myleft=document.body.scrollLeft+event.clientX-event.offsetX-80;
  mytop=document.body.scrollTop+event.clientY-event.offsetY+140;
  window.showModalDialog("/jsp/include/Calendar.jsp?FIELDNAME="+fieldname,self,"edge:raised;scroll:0;status:0;help:0;resizable:1;dialogWidth:280px;dialogHeight:205px;dialogTop:"+mytop+"px;dialogLeft:"+myleft+"px");
}
</script>
</head>
<body>
 <h1><%=r.getString(teasession._nLanguage, "Poll")%></h1>
 <br>
<div id="head6"><img height="6" src="about:blank" alt="" ></div>

<form action="<%=request.getRequestURI()%>" method="post" name="form1">
<input type="hidden" name="Node" value="<%=teasession._nNode%>"/>

<%
if(request.getParameter("id")!=null)out.print("<input type=hidden name=id value="+request.getParameter("id")+" >");
%>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
   <tr>
   <td>
    <select name="poll">
    <%
DbAdapter dbadapter=new DbAdapter();
try
{
  dbadapter.executeQuery("SELECT node FROM Node WHERE options1&0x20000000!=0 AND type=3 AND node IN(SELECT node FROM Node WHERE community="+DbAdapter.cite(community)+")");
  while(dbadapter.next())
  {
    Node obj=Node.find(dbadapter.getInt(1));

    if(param_poll==0)
    param_poll=obj._nNode;

    out.print("<option value="+obj._nNode);
    if(param_poll==obj._nNode)
    {
      out.print(" SELECTED ");
    }
    out.print(">"+obj.getSubject(teasession._nLanguage));
  }
}catch(Exception e)
{
}finally
{
 // dbadapter.close();
}





StringBuffer sql=new StringBuffer();

if(param_poll>0)
{
  sql.append(" AND node="+param_poll);
}

String begin=request.getParameter("begin");
if(begin==null)
begin="";
else
if(begin.length()>0)
{
  sql.append(" AND time>="+DbAdapter.cite(begin));
}

String end=request.getParameter("end");
if(end==null)
end="";
else
if(end.length()>0)
{
  sql.append(" AND time<"+DbAdapter.cite(end));
}

String point_from=request.getParameter("point_from");
if(point_from==null)
point_from="";
else
if(point_from.length()>0)
{
  sql.append(" AND point>="+DbAdapter.cite(point_from));
}

String point_to=request.getParameter("point_to");
if(point_to==null)
point_to="";
else
if(point_to.length()>0)
{
  sql.append(" AND point<"+DbAdapter.cite(point_to));
}

String order=request.getParameter("order");
if(order==null)
{
  order="time DESC";
}
sql.append(" ORDER BY "+order);
%>
</select>
</td>
<td>
<input type="hidden" name="order" value="<%=order%>"/>
<%=r.getString(teasession._nLanguage,"Time")%>:
  <input name="begin" readonly="readonly" type="text" size="9" value="<%=begin%>">
  <img onClick="td_calendar('form1.begin');" align="absmiddle" src="/tea/image/public/Calendar2.gif" style="cursor:hand;" >--
  <input name="end" readonly="readonly" type="text" size="9" value="<%=end%>">
  <img onClick="td_calendar('form1.end');" align="absmiddle" style="cursor:hand;"  src="/tea/image/public/Calendar2.gif">

</td>
<td>
<%=r.getString(teasession._nLanguage,"Point")%>:
<input name="point_from" type="text" size="5" value="<%=point_from%>">--<input name="point_to" type="text" size="5" value="<%=point_to%>">
</td>
<td>
<input type="submit" value="GO"/>
</td>
</table>
</form>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
   <tr id="tableonetr">
   <td><%=r.getString(teasession._nLanguage,"MemberId")%></td>
      <td>
                <%
          if(order.equals("point DESC"))
          out.print("<A href=\"#\" onclick=\"form1.order.value='point ASC';form1.submit();\" >"+r.getString(teasession._nLanguage,"Point")+"↓</A>");
          else
          if(order.equals("point ASC"))
          out.print("<A href=\"#\" onclick=\"form1.order.value='point DESC';form1.submit();\" >"+r.getString(teasession._nLanguage,"Point")+"↑</A>");
          else
          out.print("<A href=\"#\" onclick=\"form1.order.value='point DESC';form1.submit();\" >"+r.getString(teasession._nLanguage,"Point")+"</A>");
          %>
      </td>
      <td>
          <%
          if(order.equals("time DESC"))
          out.print("<A href=\"#\" onclick=\"form1.order.value='time ASC';form1.submit();\" >"+r.getString(teasession._nLanguage,"Time")+"↓</A>");
          else
          if(order.equals("time ASC"))
          out.print("<A href=\"#\" onclick=\"form1.order.value='time DESC';form1.submit();\" >"+r.getString(teasession._nLanguage,"Time")+"↑</A>");
          else
          out.print("<A href=\"#\" onclick=\"form1.order.value='time DESC';form1.submit();\" >"+r.getString(teasession._nLanguage,"Time")+"</A>");
          %>
      </td>
   </tr>
<%


try
{
  dbadapter.executeQuery("SELECT pollpoint FROM PollPoint WHERE NOT member IS NULL"+sql.toString());
  while(dbadapter.next())
  {
    int pollpoint=dbadapter.getInt(1);
    PollPoint obj=PollPoint.find(pollpoint);
%>
 <tr onmouseover="javascript:this.bgColor='#BCD1E9'" onmouseout="javascript:this.bgColor=''" >
   <td><A href="/jsp/type/poll/PollResults2.jsp?community=<%=community%>&member=<%=obj.getMember()%>" ><%=obj.getMember()%></A></td>
   <td><%=obj.getPoint()%></td>
   <td><%=obj.getTime()%></td>
   </tr>
<%
  }
}catch(Exception e)
{
}finally
{
  dbadapter.close();
}%>

</table>



<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</html>

