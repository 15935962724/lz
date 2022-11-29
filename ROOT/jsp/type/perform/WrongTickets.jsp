<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="tea.ui.TeaSession"%>
<%@page import="tea.entity.site.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.resource.*"%>
<%@page import="tea.db.*"%>
<%@page import="tea.entity.member.*"%>
<%@page import="tea.entity.admin.*"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Enumeration"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.math.BigDecimal"%>

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


String nexturl = request.getRequestURI()+"?"+request.getQueryString();
int type = 0;
if(teasession.getParameter("type")!=null && teasession.getParameter("type").length()>0)
{
	type = Integer.parseInt(teasession.getParameter("type"));	
}
StringBuffer sql = new StringBuffer();
StringBuffer param = new StringBuffer();
param.append("?id=").append(request.getParameter("id"));
param.append("&community=").append(teasession._strCommunity);
param.append("&type=").append(type);
sql.append(" and type =").append(type);

//演出时间
String time_c = teasession.getParameter("time_c");
if(time_c!=null && time_c.length()>0)
{
  sql.append(" AND pftime >= ").append(DbAdapter.cite(time_c));
  param.append("&time_c=").append(time_c);
}
String time_d = teasession.getParameter("time_d");
if(time_d!=null && time_d.length()>0)
{
  sql.append(" AND pftime <=").append(DbAdapter.cite(time_d));
  param.append("&time_d=").append(time_d);
}

//演出
int perform =0;

if(teasession.getParameter("perform")!=null && teasession.getParameter("perform").length()>0)
{
	perform = Integer.parseInt(teasession.getParameter("perform"));	
}
if(perform>0)
{
	sql.append(" and psid in (select psid from PerformStreak where node ="+perform+" ) ");
	param.append("&perform=").append(perform);
}

//场次
int performstreak = 0;

if(teasession.getParameter("performstreak")!=null && teasession.getParameter("performstreak").length()>0)
{
	performstreak = Integer.parseInt(teasession.getParameter("performstreak"));	
}

if(performstreak>0)
{
	sql.append(" and psid = "+performstreak);
	param.append("&performstreak=").append(performstreak);
}
//场馆
int venues = 0;
if(teasession.getParameter("venues")!=null && teasession.getParameter("venues").length()>0)
{
	venues = Integer.parseInt(teasession.getParameter("venues"));	
}
if(venues>0)
{
	sql.append(" and psid in (select psid from PerformStreak where venues ="+venues+" )");
	param.append("&venues= ").append(venues);
}
 
int pos = 0, pageSize = 20, count = 0;
if (request.getParameter("pos") != null) {
  pos = Integer.parseInt(request.getParameter("pos")); 
}
count = BouncePiao.count(teasession._strCommunity,sql.toString()); 
//sql.append(" order by times desc ");

    
%>

<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" language="javascript" src="/tea/tea.js"></script>
<script src="/tea/Calendar.js" type="text/javascript"></script>
<title><%if(type==0){out.print("退票统计");}else if(type ==1){out.print("废票统计");} %></title>
</head>

<body id="bodynone" onLoad="f_onload();" >
<script>
function f_onload()
{
    f_perform();
	
}
//选择演出 显示场次
function f_perform()
{
	      sendx("/jsp/type/perform/PerformOrders_ajax.jsp?acttype=OrderPiaoList&act=TicketStatistice_f_perform&perform="+form1.perform.value+"&community="+form1.community.value+"&performstreak=<%=performstreak%>",
		  function(data)
		  {
		    document.getElementById("showxx").innerHTML=data.trim();
		  }
		  );
}
</script>          
<h1><%if(type==0){out.print("退票统计");}else if(type ==1){out.print("废票统计");} %></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" action="?" method="POST">
  <input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
  <input type="hidden" name="id" value="<%=request.getParameter("id")%>" >

  <table border="0" cellpadding="0" cellspacing="0" id="tableSearch">
    <tr>
    	<td nowrap>演出时间：&nbsp;从&nbsp;
        <input id="time_c" name="time_c" size="7"  value="<%if(time_c!=null)out.print(time_c);%>" readonly="readonly">
        <img style="margin-bottom:-8px;" style="cursor:pointer"  src="/tea/image/bbs_edit/table.gif" onclick="new Calendar().show('form1.time_c');" />
        &nbsp;到&nbsp;
        <input id="time_d" name="time_d" size="7"  value="<%if(time_d!=null)out.print(time_d);%>" readonly="readonly">
        <img style="margin-bottom:-8px;" style="cursor:pointer"  src="/tea/image/bbs_edit/table.gif" onclick="new Calendar().show('form1.time_d');" />
    	</td>
    	<td nowrap>演　　出：&nbsp;<select name="perform" onChange="f_perform();">
	  			<option value="0">--选择演出--</option>
			<%
			Enumeration pfen = Node.find(" and type = 55 and hidden = 0 and community = "+DbAdapter.cite(teasession._strCommunity),0,Integer.MAX_VALUE);
			while(pfen.hasMoreElements())
			{
				int nid = ((Integer)pfen.nextElement()).intValue();
				Node nobj = Node.find(nid);
				out.print("<option value= "+nid);
				if(perform==nid)
				{
					out.print(" selected ");
				}
				out.print(">"+nobj.getSubject(teasession._nLanguage));
				out.print("</option>");
			}
			%>
	      </select>　
      </td>
      </tr>
      <tr> 
    	<td nowrap>场　　次：&nbsp;<span id ="showxx">
  				<select name="performstreak" ><option value=0>--选择场次--</option></select>
  			</span></td>
  		<td  nowrap>场　　馆：&nbsp;<select name="venues"><option value="0">--选择场馆--</option>
  			<%
  				java.util.Enumeration ve  = Node.find(" and type = 92 and hidden = 0 and community = "+DbAdapter.cite(teasession._strCommunity),0,Integer.MAX_VALUE);
  			while(ve.hasMoreElements())
  			{
  				int nid = ((Integer)ve.nextElement()).intValue();
  				Node nobj = Node.find(nid);
  				out.print("<option value ="+nid);
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
     </tr>   
     <tr>
     	<td colspan="3" align="center"><input type="submit" value="" class="SearchInput"></td>
     </tr>
  </table> 
  </form>
  <form name="form2" action="/servlet/ExportPerformExcel" method="POST">
    <input type="hidden" name="files" value="<%if(type==0){out.print("退票统计");}else if(type ==1){out.print("废票统计");} %>">
  <input type="hidden" name="act" value="WrongTickets">
  <input type="hidden" name="sql" value="<%=sql.toString() %>">
    <input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <TR id="tableonetr">
      <TD nowrap>票据编号</TD>
      <TD nowrap>演出名称</TD>
      <TD nowrap>演出场馆</TD>
      <TD nowrap>座位位置</TD>
      <TD nowrap>演出时间</TD>
      <TD nowrap>演出价格</TD>
      <TD nowrap>售票员</TD>
    </TR>
   <%
   	  Enumeration pen = BouncePiao.find(sql.toString(),pos,pageSize);
      BigDecimal  tp = new BigDecimal("0");
      if(!pen.hasMoreElements())
      {
          out.print("<tr><td colspan=10 align=center>暂无记录</td></tr>");
      }
      	for(int i =1;pen.hasMoreElements();i++)
      	{
      		int orderdetails_id = ((Integer)pen.nextElement());
      		BouncePiao  bpobj = BouncePiao.find(orderdetails_id); 
      		PerformStreak psobj =PerformStreak.find(bpobj.getPsid());
      		Node nobj1 = Node.find(psobj.getNode());
      		Node nobj2 = Node.find(psobj.getVenues());
      		Venues vobj = Venues.find(psobj.getVenues());
      		tp = tp.add(bpobj.getPrice());
   %> 
      <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
        <td><%=orderdetails_id %></td>
        <td><%=nobj1.getSubject(teasession._nLanguage) %></td>
        <td><%=nobj2.getSubject(teasession._nLanguage) %></td>
          <td><%=bpobj.getWeizhi() %></td>
       <td><%=BouncePiao.sdf2.format(bpobj.getPftime()) %></td>
       <td><%=bpobj.getPrice() %></td>
       <td><%=bpobj.getMember() %></td>
      </tr>
    <%} %>
      <%if (count > pageSize) {  %>
      <tr> <td colspan="10"><%=new tea.htmlx.FPNL(teasession._nLanguage,request.getRequestURI()+param.toString()+"&pos=",pos,count,pageSize)%>    </td> </tr>
      <%}  %>
  </table>
	
	<table>
		<tr> 
			<td>合计：&nbsp;错票&nbsp;<%=count %>&nbsp;张票&nbsp;&nbsp;&nbsp;总金额：&nbsp;<%=tp %>&nbsp;元</td>
		</tr>
	</table>
		<table>
		<tr>
			<td><input type="submit" value="" class="Export"></td>
		</tr>
	</table>

  </form>


  <div id="head6"><img height="6" src="about:blank"></div>

</body>
</html>
