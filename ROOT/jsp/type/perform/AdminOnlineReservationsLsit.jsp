<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="tea.ui.TeaSession"%>
<%@page import="tea.entity.site.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.resource.*"%>
<%@page import="tea.db.*"%>
<%@page import="tea.entity.member.*"%>
<%@page import="tea.entity.admin.*"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>

<%
request.setCharacterEncoding("UTF-8");
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession = new TeaSession(request);
if (teasession._rv == null) {
  response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
  return;
}

//场次查询
String nexturl = teasession.getParameter("nexturl");
StringBuffer sql = new StringBuffer();
StringBuffer param = new StringBuffer();
param.append("?id=").append(request.getParameter("id"));
param.append("&community=").append(teasession._strCommunity);

//判断出票时间
   
sql.append(" and stardrawtime <= "+DbAdapter.cite(PerformStreak.sdf2.format(new Date()))+" and enddrawtime >= "+DbAdapter.cite(PerformStreak.sdf2.format(new Date())));

//演出名称
String subject = teasession.getParameter("subject");
if(subject!=null && subject.length()>0)
{
  sql.append(" AND node IN (SELECT node FROM Nodelayer WHERE subject LIKE "+DbAdapter.cite("%"+subject+"%")+")");
  param.append("&subject=").append(java.net.URLEncoder.encode(subject,"UTF-8"));
}
//演出场馆
int venues =0;    
if(teasession.getParameter("venues")!=null && teasession.getParameter("venues").length()>0)
{
  venues = Integer.parseInt(teasession.getParameter("venues")); 
  if(venues>0)
  {
    sql.append(" AND venues ="+venues);
    param.append("&venues=").append(venues);
  }
}
//演出时间
String time_c = teasession.getParameter("time_c");
if(time_c!=null && time_c.length()>0)
{
  sql.append(" AND pftime >=").append(DbAdapter.cite(time_c));
  param.append("&time_c=").append(time_c);
}
String time_d = teasession.getParameter("time_d");
if(time_d!=null && time_d.length()>0)
{
  sql.append(" AND pftime <=").append(DbAdapter.cite(time_d));
  param.append("&time_d=").append(time_d);
}
//具体到演出时间的日期
String pftime = teasession.getParameter("pftime");
if(pftime!=null && pftime.length()>0)
{
  sql.append(" AND pftime > ").append(DbAdapter.cite(pftime+" 00:00 "));
   sql.append(" AND pftime < ").append(DbAdapter.cite(pftime+" 23:59 "));
  param.append("&pftime=").append(pftime);
}


int pos = 0, pageSize = 20, count = 0;
if (request.getParameter("pos") != null) {
  pos = Integer.parseInt(request.getParameter("pos"));
}
count = PerformStreak.count(teasession._strCommunity,sql.toString());

tea.entity.site.Community community = tea.entity.site.Community.find(teasession._strCommunity);

sql.append(" order by times desc ");


%>

<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" language="javascript" src="/tea/tea.js"></script>
<script src="/tea/Calendar.js" type="text/javascript"></script>
<title>现场售票</title>
</head>


<body id="bodynoneVotes">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="<%=community.getJspBeforePath(teasession._nLanguage)%>" type="text/javascript"></SCRIPT>
<div class="content">
<h1>现场售票</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1">
  <input type="hidden" name="nexturl" value="<%=nexturl%>"/>
    <input type="hidden" name="id" value="<%=teasession.getParameter("id") %>">
  <input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>

<table border="0" cellpadding="0" cellspacing="0" class="Search">
  <tr>
    <td>演出名称：</td>
    <td class="td01"><input type="text" name="subject" value="<%if(subject!=null)out.print(subject);%>" ></td>
     <td>演出场馆：</td>
    <td class="td02">
        <select name="venues">
           <option value="0">--演出场馆--</option>
           <%

              java.util.Enumeration en = Node.find(" and community="+DbAdapter.cite(teasession._strCommunity)+" and type=92 and hidden = 0",0,100);
              while(en.hasMoreElements())
              {
                int nid = ((Integer)en.nextElement()).intValue();
                Node nobj = Node.find(nid);
                out.print("<option value="+nid);
                if(venues==nid)
                {
                      out.print(" selected ");
                }
                out.print(">"+nobj.getSubject(teasession._nLanguage));
                out.print("</option>");
              }

           %>
        </select>
    </td>
    <td>演出日期：</td>
    <td class="td03">从&nbsp;
        <input id="time_c" name="time_c" size="7"  value="<%if(time_c!=null)out.print(time_c);%>" readonly="readonly">
        <img style="margin-bottom:-8px;" src="/tea/image/bbs_edit/table.gif" onClick="new Calendar().show('form1.time_c');" />
        &nbsp;到&nbsp;
        <input id="time_d" name="time_d" size="7"  value="<%if(time_d!=null)out.print(time_d);%>" readonly="readonly">
        <img style="margin-bottom:-8px;" src="/tea/image/bbs_edit/table.gif" onClick="new Calendar().show('form1.time_d');" />
      </td>
   <!--    <td><input type="text" name="pftime" value="<%if(pftime!=null)out.print(pftime);%>"/></td> -->
  <td class="td04"><input type="submit" value=""/></td>
  </tr>
</table> 

  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr id="tableonetr">
      <td nowrap >序号</td>
      <td nowrap>演出名称</td>
      <TD nowrap>场次名称</TD>
      <TD nowrap>演出场馆</TD>
      <TD nowrap>演出时间</TD>
      <TD nowrap>操作</TD>
    </tr>
    <%
    java.util.Enumeration  e = PerformStreak.find(teasession._strCommunity,sql.toString(),pos,pageSize);
    if(!e.hasMoreElements())
    {
      out.print("<tr><td colspan=10 align=center>暂无演出信息</td></tr>");
    } 
    for(int i =1;e.hasMoreElements();i++)
    {
      int psid =((Integer)e.nextElement()).intValue();
      PerformStreak psobj = PerformStreak.find(psid);
      Node nobj = Node.find(psobj.getVenues());
      SimpleDateFormat sdf = new SimpleDateFormat("E");
            // hobj.setQuantity(hobj.getQuantity()+1);
            	Node nobj2 = Node.find(psobj.getNode()); //演出名称
      %>      
      <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
        <td width="1"><%=i+pos %></td>
        <td nowrap><%=nobj2.getSubject(teasession._nLanguage) %></td>
        <td nowrap><%=psobj.getPsname()%></td>
        <td nowrap><%=nobj.getSubject(teasession._nLanguage) %></td>
        <td nowrap><%=psobj.getPftimeToString() %>&nbsp;<%=sdf.format(psobj.getPftime()) %></td>
		 
        <td nowrap align=center>  
		<a href="/jsp/type/perform/AdminOnlineReservations.jsp?psid=<%=psid %>" >售票</a>
        </td>
      </tr>
      <%} %>
      <%if (count > pageSize) {  %>
      <tr> <td colspan="10"><%=new tea.htmlx.FPNL(teasession._nLanguage,request.getRequestURI()+param.toString()+"&pos=",pos,count,pageSize)%>    </td> </tr>
      <%}  %>
  </table>

  </form>
  <div id="head6"><img height="6" src="about:blank"></div>
  </div>
    <SCRIPT LANGUAGE=JAVASCRIPT SRC="<%=community.getJspAfterPath(teasession._nLanguage)%>" type="text/javascript"></SCRIPT>
</body>

</html>
