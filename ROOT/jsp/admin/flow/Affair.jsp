<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter"%>
<%@ page import="tea.resource.Resource"%>
<%@ page import="tea.entity.admin.*" %>
<%@ page import="tea.ui.TeaSession" %>
<%@ page   language="java"   import="java.util.*"   %>
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
String year = teasession.getParameter("year");
String month = teasession.getParameter("month");
String date = teasession.getParameter("date");

Date dates = new Date();
Calendar cc = Calendar.getInstance();
cc.setTime(dates);

String yy = null,mm = null,dd = null;

yy = String.valueOf(cc.get(cc.YEAR));

mm = String.valueOf(cc.get(cc.MONTH)+1);

dd = String.valueOf(cc.get(cc.DATE));

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
            function f_open(y,m,d,aid)
            {
              window.open("/jsp/admin/flow/NewAffair.jsp?community=<%=teasession._strCommunity%>&year="+y+"&month="+m+"&date="+d+"&aid="+aid,"iFrame2");

            }
            </script>
            </head>
            <body>
              <h2>管理日程安排 &nbsp;(<%=year %>年<%=month %>月<%=date %>日)</h2>
              <form name=form1 METHOD=get  action="/jsp/admin/flow/EditFlow.jsp">
              <span id="scheduleList">
                <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
                  <tr id="tableonetr">
                    <!--td nowrap="nowrap">序号</td-->
                    <td nowrap>姓名</td>
                    <td nowrap>开始时间</td>
                    <td nowrap>结束时间</td>
                    <td nowrap>事务类型</td>
                    <td nowrap>事务内容</td>
                    <td nowrap>状态</td>
                    <td nowrap >操作</td>
                  </tr>
                  <%
                  String member = teasession._rv.toString();//当前用户

                  AdminUsrRole au_obj=AdminUsrRole.find(teasession._strCommunity,member);
                  // if(au_obj.isExists())
                  // {

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
                      Time =year+"-"+month+"-"+date;;
                    }

                    //String  sql =(" and  member in (select member from AdminUsrRole where community="+DbAdapter.cite(community)+")"+" and time>="+DbAdapter.cite(Time)+" and member="+DbAdapter.cite(teasession._rv._strR.toString()));
                    
                    String  sql =(" and  member in (select p.member from AdminUsrRole a inner join Profile p on a.member = p.profile where a.community="+DbAdapter.cite(community)+")"+" and time>="+DbAdapter.cite(Time)+" and member="+DbAdapter.cite(teasession._rv._strR.toString()));
                    
                    java.util.Enumeration e = DayOrder.findByCommunity(teasession._strCommunity,sql);

                    if(!e.hasMoreElements())
                    {
                      out.print("<tr><td colspan=7><font color=red><b>暂无日程安排</b></font></td></tr>");
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
                        <td ><%=obj.getAffaircontent() %></td>
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
                        <td nowrap="nowrap"  ><a href="/jsp/admin/flow/NewAffair.jsp?community=<%=community %>&year=<%=year%>&month=<%=month%>&date=<%=date %>&aid=<%=id %>">编辑</a> &nbsp;<a href ="/jsp/admin/flow/NewAffair.jsp?community=<%=community %>&year=<%=year%>&month=<%=month%>&date=<%=date %>&aid=<%=id %>&DELETE=DELETE" onClick="return window.confirm('您确定要删除此内容吗？');">删除</a></td>



                      </tr>
                      <%
                      index++;
                    }
                    %>
                    </table></span>
                    <p><a href="/jsp/admin/flow/NewAffair.jsp?community=<%=teasession._strCommunity%>&year=<%=year %>&month=<%=month %>&date=<%=date %>" >添加</a>&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" value="返回" onClick="history.back();"></p>
</form>
            </body>
</HTML>




