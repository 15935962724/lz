<%@page contentType="text/html;charset=UTF-8" %><%@   page   language="java"   import="java.util.*"   %>
<%@ page import="tea.db.DbAdapter"%>
<%@ page import="tea.resource.Resource"%>
<%@ page import="tea.entity.admin.*" %>
<%@ page import="tea.ui.TeaSession" %>
<%@ page import="tea.entity.member.*" %>
<%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}
String community=teasession._strCommunity;
StringBuffer param=new StringBuffer();
StringBuffer strshow=new StringBuffer();
String member = teasession._rv.toString();//当前用户
AdminUsrRole au_obj=AdminUsrRole.find(teasession._strCommunity,member);


param.append("?id=").append(request.getParameter("id"));
Date dates = new Date();
Calendar cc = Calendar.getInstance();
cc.setTime(dates);


String yy = null,mm = null,dd = null;

yy = String.valueOf(cc.get(cc.YEAR));

mm = String.valueOf(cc.get(cc.MONTH)+1);

dd = String.valueOf(cc.get(cc.DATE));


String year = "";
if(teasession.getParameter("year")!=null && teasession.getParameter("year").length()>0)
{
  year=teasession.getParameter("year");
}
else
{
  year = yy;
}
String month = "";
if(teasession.getParameter("month")!=null && teasession.getParameter("month").length()>0)
{
  month=teasession.getParameter("month");
}
else
{
  month=mm;
}
String date = "";
if(teasession.getParameter("date")!=null && teasession.getParameter("date").length()>0)
{
  date = teasession.getParameter("date");
}
else
{
  date = dd;
}
String Time ="";
if(Integer.parseInt(month)<10){
  Time = year+"-0"+month+"-"+date;
}
if(Integer.parseInt(date)<10){
  Time = year+"-"+month+"-0"+date;
}
if(Integer.parseInt(month)<10 && Integer.parseInt(date)<10)
{
  Time = year+"-0"+month+"-0"+date;
}else{
  Time =year+"-"+month+"-"+1;;
}


StringBuffer sql=new StringBuffer(" and  member in (select member from AdminUsrRole where community="+DbAdapter.cite(community)+")"+" and time>"+DbAdapter.cite(Time));
String oname = "",time_k="",time_j="";


if(teasession.getParameter("oname")!=null && teasession.getParameter("oname").length()>0)
{
  oname= teasession.getParameter("oname");
  sql.append(" and  member in (select member from profilelayer where  lastname+firstname like ").append(DbAdapter.cite("%"+oname+"%")+")");
  param.append("&oname=").append(oname);


}
if(teasession.getParameter("time_k")!=null && teasession.getParameter("time_k").length()>0)
{
  time_k= teasession.getParameter("time_k");
  sql.append("  and  time>").append(DbAdapter.cite(time_k));
  param.append("&time_k=").append(time_k);
  strshow.append("从").append(time_k).append("开始");
  Time=time_k;
}
else
{

 strshow.append("从").append(Time).append("开始");

}
if(teasession.getParameter("time_j")!=null && teasession.getParameter("time_j").length()>0)
{
  time_j= teasession.getParameter("time_j");
  sql.append("  and  time<").append(DbAdapter.cite(time_j));
  param.append("&time_j=").append(time_j);
  strshow.append("到").append(time_j);
}

strshow.append("的日程安排");
int pos = 0, pageSize = 10, count = 0;
if (request.getParameter("pos") != null) {
  pos = Integer.parseInt(request.getParameter("pos"));
}
count =DayOrder.count(teasession._strCommunity,sql.toString());
String o=request.getParameter("o");
if(o==null)
{
  o="time";
}
boolean aq=Boolean.parseBoolean(request.getParameter("aq"));
sql.append(" ORDER BY ").append(o).append(" ").append(aq?"DESC":"ASC");
param.append("&o=").append(o).append("&aq=").append(aq);
strshow.append("，总计："+count);
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT SRC="/tea/tea.js" type="text/javascript"></SCRIPT>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/image/ig/ig_iframe.js"></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
    <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
      <META HTTP-EQUIV="Expires" CONTENT="0">
        <script type="">

        function f_order(v)
        {
          var aq=form2.aq.value=="true";
          if(form2.o.value==v)
          {
            form2.aq.value=!aq;
          }else
          {
            form2.o.value=v;
          }
          form2.action="?";
          form2.submit();
        }
        </script>
        </head>
        <body>
        <h1>日程安排管理
        </h1>
        <h2>查询</h2>

        <form name=form2 METHOD=get  action="/jsp/admin/flow/DayOrderGL.jsp">
          <input type="hidden" name="o" VALUE="<%=o%>">
          <input type="hidden" name="aq" VALUE="<%=aq%>">
          <input type="hidden" name="id" value="<%=request.getParameter("id")%>" >
          <input type="hidden" name="act"  value="" >
          <table id="tablecenter">
            <tr>
              <td>姓名：</td><td><input name="oname" value="<%if(oname!=null)out.print(oname);%>" /></td> <td>开始时间：</td><td>
                <input name="time_k" size="7"  value="<%if(time_k!=null)out.print(time_k);%>"><A href="###"><img onclick="showCalendar('form2.time_k');" src="/tea/image/public/Calendar2.gif" align="top"/></a>&nbsp;到&nbsp;
                  <input name="time_j" size="7"  value="<%if(time_j!=null)out.print(time_j);%>"><A href="###"><img onclick="showCalendar('form2.time_j');" src="/tea/image/public/Calendar2.gif" align="top"/></a>
</td>
<td><input value="查询" type="submit"  /></td>
            </tr>
          </table>





</form>
<h2>(<%=strshow.toString()%>)</h2>
<form name=form1 METHOD=get  action="/jsp/admin/flow/EditFlow.jsp">
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">

    <tr id="tableonetr">
      <!--td nowrap="nowrap">序号</td-->
      <td nowrap><a href="javascript:f_order('member');">姓名</a>
      <%
      if(o.equals("member"))
      {
        if(aq)
        out.print("↓");
        else
        out.print("↑");
      }
      %></td>
      <td nowrap><a href="javascript:f_order('time');">开始时间</a>
      <%
      if(o.equals("time"))
      {
        if(aq)
        out.print("↓");
        else
        out.print("↑");
      }
      %></td>
      <td nowrap>结束时间</td>
      <td nowrap>事务类型</td>
      <td nowrap>事务内容</td>
      <td nowrap>状态</td>
    </tr>
    <%
    java.util.Enumeration e = DayOrder.findByCommunity(teasession._strCommunity,sql.toString(),pos,10);

    if(!e.hasMoreElements())
    {
      out.print("<tr><td><font color=red><b>暂无日程安排</b></font></td></tr>");
    }
    int index=1;
    while(e.hasMoreElements()){
      int id = ((Integer)e.nextElement()).intValue();
      DayOrder obj = DayOrder.find(id);
      Profile probj = Profile.find(obj.getMember());
      obj.getSubtimeToString();/////////////////////////改改改
      %>
      <tr >
        <!--td width="1"><%=index %></td-->
        <td nowrap="nowrap"><%=probj.getName(teasession._nLanguage)%></td>
        <td  nowrap="nowrap"><%
        out.print(obj.getTimeToString()+"　");
        if(obj.getBegintime()<10){
          out.print("0"+obj.getBegintime()+":");
        }else
        {
          out.print(obj.getBegintime()+":");
        }
        if(obj.getBegintime1()<10){
          out.print("0"+obj.getBegintime1());
        }else
        {
          out.print(obj.getBegintime1());
        }
        %></td>
        <td ><%
        if(obj.getEndtime()<10){
          out.print("0"+obj.getEndtime()+":");
        }else
        {
          out.print(obj.getEndtime()+":");
        }
        if(obj.getEndtime1()<10){
          out.print("0"+obj.getEndtime1());
        }else
        {
          out.print(obj.getEndtime1());
        }
        %></td>
        <td ><%
        Worktype wor =Worktype.find(obj.getAffairtype());
        out.print(wor.getName(teasession._nLanguage));
        %></td>
        <td ><!--a href="/jsp/admin/flow/AffairContent.jsp?community=<%=community %>&year=<%=year%>&month=<%=month%>&date=<%=date %>&aid=<%=id %>"  target="_blank"--><%=obj.getAffaircontent() %><!--/a--></td>
        <td >
        <%
        int end = 0,end1=0;
        if(obj.getEndtime()==0)
        {
          end =24;
        }else{
          end=obj.getEndtime();
        }
        if(obj.getEndtime1()==0)
        {
          end1 =24;
        }else{
          end1=obj.getEndtime1();
        }
        Date d = new Date();
        Calendar   thisMonth=Calendar.getInstance();


        String oy="";
        String om="";
        String od="";
        String times[] = obj.getTimeToString().split("-");
        if(times.length!=1)
        {
          oy = times[0];
          om = times[1];
          od = times[2];
        }
        else
        {
          oy=yy;
          om=mm;
          od=dd;
        }

        if(Integer.parseInt(yy)<Integer.parseInt(oy))
        {
          out.print("<font color='#0000AA'>未至</font>");
        }else if(Integer.parseInt(yy)==Integer.parseInt(oy))
        {
          if(Integer.parseInt(mm)<(Integer.parseInt(om)))
          {
            out.print("<font color='#0000AA'>未至</font>");
          }else if((Integer.parseInt(mm))==(Integer.parseInt(om)))
          {
            if(Integer.parseInt(dd)<(Integer.parseInt(od)))
            {
              out.print("<font color='#0000AA'>未至</font>");
            }else if(Integer.parseInt(dd)==Integer.parseInt(od))
            {
              if(end>d.getHours())
              {
                out.print("<font color='#0000AA'>未至</font>");
              }
              if(end==d.getHours())
              {
                if(end1>d.getMinutes())
                {
                  out.print("<font color='#0000AA'>未至</font>");
                }else
                {
                  out.print("<font color='#FF0000'>过期</font>");
                }
              }
              if(end<d.getHours())
              {
                out.print("<font color='#FF0000'>过期</font>");
              }
            }
            if(Integer.parseInt(dd)>Integer.parseInt(od))
            {
              out.print("<font color='#FF0000'>过期</font>");
            }
          }
          else
          {
            out.print("<font color='#FF0000'>过期</font>");
          }
        }else
        {
          out.print("<font color='#FF0000'>过期</font>");
        }
        %>
        </td>
      </tr>
      <%
      index++;
    }
    %>
    <tr><td colspan="6"  align="center" style="padding-right:5px;"> <%=new tea.htmlx.FPNL(teasession._nLanguage,param.toString().replaceFirst("&pos=","&")+"&pos=",pos,count,10)%></td></tr>

  </table>
</form>
        </body>
</html>
