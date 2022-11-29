<%@page contentType="text/html;charset=UTF-8" %><%@ page import="java.util.*"%>
<%@page import="tea.entity.node.access.*" %><%@page import="tea.ui.*"%><%@page import="tea.resource.*" %>

<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
%>
<%!// 一个同步用的锁 
  private static final Object lock = new Object();%> 
<%
//int oldpv= 10809664;
//int oldip=8366701;

//int oldpv= 0; 
//int oldip=0;

 
TeaSession teasession = new TeaSession(request);
int oldpv= NodeAccessLast.countOldPv(teasession._strCommunity) ;
int oldip= NodeAccessLast.countOldIp(teasession._strCommunity) ;


if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
  return;
}
long lo=System.currentTimeMillis();
Resource r=new Resource();
r.add("/tea/resource/fun");
DecimalFormat df=new DecimalFormat("#,##0");
DecimalFormat df2=new DecimalFormat("#,##0.00");
NodeAccess na=NodeAccess.find(teasession._strCommunity);
int daytotal=na.getDayTotal1();

long alltotal=0;
long temp=na.getAllTotal()+oldpv;
synchronized (lock) { 
if (application.getAttribute("edn.nodeaccess_"+teasession._strCommunity)!=null)
{
  alltotal=((Long)application.getAttribute("edn.nodeaccess_"+teasession._strCommunity)).longValue();
   if (alltotal<temp) alltotal=temp;
 }else
 {
 alltotal=temp;
 }
application.setAttribute("edn.nodeaccess_"+teasession._strCommunity,new Long(alltotal));
}
%>


<html>
<head>
<title>访问统计</title>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<style type="text/css">
.gra{border:1px solid #666666;width:12px;height:12px}
</style>
</head>
<body id="bodynone">

<h1><%=r.getString(teasession._nLanguage,"1216019187725")%></h1>


<table width="90%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr id="tableonetr">
    <td> <span class="hands" ><a href="/jsp/count/?node=<%=teasession._nNode%>&community=<%=teasession._strCommunity%>"><%=r.getString(teasession._nLanguage,"1216022010118")%></a> </span></td>
    <td> <span class="hands" ><a href="/jsp/count/?node=<%=teasession._nNode%>&community=<%=teasession._strCommunity%>&act=hot"><%=r.getString(teasession._nLanguage,"1216022690568")%></a></span></td>
    <td> <span class="hands" ><a href="/jsp/count/?node=<%=teasession._nNode%>&community=<%=teasession._strCommunity%>&act=searchhot"><%=r.getString(teasession._nLanguage,"1216022765132")%></a></span></td>
    <td> <span class="hands" ><a href="/jsp/count/?node=<%=teasession._nNode%>&community=<%=teasession._strCommunity%>&act=hour"><%=r.getString(teasession._nLanguage,"1216022819618")%></a></span></td>
    <td> <span class="hands" ><a href="/jsp/count/?node=<%=teasession._nNode%>&community=<%=teasession._strCommunity%>&act=day"><%=r.getString(teasession._nLanguage,"1216022898463")%></a></span></td>
    <td> <span class="hands" ><a href="/jsp/count/?node=<%=teasession._nNode%>&community=<%=teasession._strCommunity%>&act=month"><%=r.getString(teasession._nLanguage,"1216022955527")%></a></span></td>
    <td> <span class="hands" ><a href="/jsp/count/?node=<%=teasession._nNode%>&community=<%=teasession._strCommunity%>&act=where"><%=r.getString(teasession._nLanguage,"1216023013028")%></a></span></td>
    <td> <span class="hands" ><a href="/jsp/count/?node=<%=teasession._nNode%>&community=<%=teasession._strCommunity%>&act=referer"><%=r.getString(teasession._nLanguage,"1216023053966")%></a></span></td>
    <td> <span class="hands"><a href="/jsp/count/?node=<%=teasession._nNode%>&community=<%=teasession._strCommunity%>&act=last20"><%=r.getString(teasession._nLanguage,"1216023125155")%></a></span></td>
    <td> <span class="hands"><a href="/jsp/count/?node=<%=teasession._nNode%>&community=<%=teasession._strCommunity%>&act=online"><%=r.getString(teasession._nLanguage,"1216023172109")%></a></span></td>
    <%--
    <td> <span class="hands"><a href="/jsp/count/?node=<%=teasession._nNode%>&community=<%=teasession._strCommunity%>&act=9000_day">卡-日统计</a></span></td>
    <td> <span class="hands"><a href="/jsp/count/?node=<%=teasession._nNode%>&community=<%=teasession._strCommunity%>&act=9000_where">卡-地区统计</a></span></td>
    --%>
  </tr>
</table>



<div id=load >
<br>
<br>
<br>
<img src="/tea/image/public/load.gif" align="top"><%=r.getString(teasession._nLanguage,"1216023262720")%>...
</div>
<%
out.flush();
try{
  String act=request.getParameter("act");
  if ("searchhot".equals(act))
  {
    %>
    <%@include file="/jsp/count/searchhot.jsp"%>
    <%
    } else if ("hot".equals(act))
    {
      %>
      <%@include file="/jsp/count/hot.jsp"%>
      <%
      } else if ("hotbymonth".equals(act))
      {
          %>
          <%@include file="/jsp/count/hotbymonth.jsp"%>
          <%
          }  else if ("hour".equals(act))
      {
        %>
        <%@include file="/jsp/count/hour.jsp"%>
        <%
        } else if ("day".equals(act))
        {
          %>
          <%@include file="/jsp/count/day.jsp"%>
          <%
          }else if ("dayip".equals(act))
          {
              %>
              <%@include file="/jsp/count/dayip.jsp"%>
              <%
              }else if ("daypv".equals(act))
              {
                  %>
                  <%@include file="/jsp/count/daypv.jsp"%>
                  <%
                  } else if ("month".equals(act))
          {
            %>
            <%@include file="/jsp/count/month.jsp"%>
            <%
            } else if ("monthip".equals(act))
            {
                %>
                <%@include file="/jsp/count/monthip.jsp"%>
                <%
                }else if ("monthpv".equals(act))
                {
                    %>
                    <%@include file="/jsp/count/monthpv.jsp"%>
                    <%
                    }else if ("where".equals(act))
            {
              %>
              <%@include file="/jsp/count/where.jsp"%>
              <%
              } else if ("referer".equals(act))
              {
                %>
                <%@include file="/jsp/count/referer.jsp"%>
                <%
                }else if ("last20".equals(act))
                {
                  %>
                  <%@include file="/jsp/count/last20.jsp"%>
                  <%
                  }else if ("online".equals(act))
                  {
                    %>
                    <%@include file="/jsp/count/Online.jsp"%>
                    <%
                    }else if ("ColumnContrast".equals(act))
                    {
                        %>
                        <%@include file="/jsp/count/ColumnContrast.jsp"%>
                        <%
                        }else
                    {
                      %>
                      <%@include file="/jsp/count/main.jsp"%>
                      <%
                      }
                    }catch(Exception e)
                    {e.printStackTrace();}
%>

<br>
<div id="bottom6"><img height="6"></div>

<br>
<%=r.getString(teasession._nLanguage,"1216023344003")%>:<%=(System.currentTimeMillis()-lo)/1000f%><%=r.getString(teasession._nLanguage,"Seconds")%><br>


<script>
var load=document.getElementById('load');
load.style.display='none';
</script>
