<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.Resource"  %><%@page  import="tea.entity.copyright.*" %><%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv == null)
{
	response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
	return;
}


String _strId=request.getParameter("id");

String scrbid=request.getParameter("scrbid");
String reason=request.getParameter("reason");
String startdate=request.getParameter("startdate");
String enddate=request.getParameter("enddate");

StringBuffer param = new StringBuffer();
param.append("&community=").append(teasession._strCommunity);
param.append("&id=").append(_strId);

StringBuffer sql = new StringBuffer();
if (scrbid != null && (scrbid = scrbid.trim()).length() > 0)
{
	sql.append(" AND scrbid LIKE ").append(DbAdapter.cite("%"+scrbid+"%"));
	param.append("&scrbid=").append(java.net.URLEncoder.encode(scrbid,"UTF-8"));
}
if (reason != null && (reason = reason.trim()).length() > 0)
{
	sql.append(" AND reason LIKE ").append(DbAdapter.cite("%"+reason+"%"));
	param.append("&reason=").append(java.net.URLEncoder.encode(reason,"UTF-8"));
}
if (startdate != null && (startdate = startdate.trim()).length() > 0)
{
	sql.append(" AND canceldate>=").append(DbAdapter.cite(startdate));
	param.append("&startdate=").append(java.net.URLEncoder.encode(startdate,"UTF-8"));
}
if (enddate != null && (enddate = enddate.trim()).length() > 0)
{
	sql.append(" AND canceldate<").append(DbAdapter.cite(enddate));
	param.append("&enddate=").append(java.net.URLEncoder.encode(enddate,"UTF-8"));
}

String order=request.getParameter("order");
if(order==null)
order="crcancel";
param.append("&order=").append(order);

String desc=request.getParameter("desc");
if(desc==null)
desc="desc";
param.append("&desc=").append(desc);

int count=Crcancel.count(teasession._strCommunity,sql.toString());

sql.append(" ORDER BY ").append(order).append(" ").append(desc);

int pos=0;
String _strPos=request.getParameter("pos");
if(_strPos!=null)
{
	pos=Integer.parseInt(_strPos);
}
param.append("&pos=");

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<body>

<h1>计算机软件著作权登记撤销公告</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<h2>查询</h2>
   <FORM name=form1_crcq METHOD=get action="?" onSubmit="">
   <input type=hidden name="community" value="<%=teasession._strCommunity%>"/>
   <input type=hidden name="order" value="<%=order%>"/>
   <input type=hidden name="desc" value="<%=desc%>"/>
   <input type=hidden name="id" value="<%=_strId%>"/>
   
     <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr>
       <td>登记号:<input name="scrbid" size="10" value="<%if(scrbid!=null)out.print(scrbid);%>"></td>
       <td>宣告理由:<input name="reason" value="<%if(reason!=null)out.print(reason);%>"></td>
       <td>宣告日期:<input name="startdate" size="10" value="<%if(startdate!=null)out.print(startdate);%>"><input type="button" value="..." onclick="showCalendar('form1_crcq.startdate');">
       <input name="enddate" size="10"  value="<%if(enddate!=null)out.print(enddate);%>"><input type="button" value="..." onclick="showCalendar('form1_crcq.enddate');"></td>
       <td><input type="submit" value="查询"/></td></tr>
   </table>
</form>
<br>

<h2>列表 ( <%=count%> )</h2>
     <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr id="tableonetr">
     <td nowrap width="1">&nbsp;</td>
       <td>
         <%
         if("scrbid".equals(order))
         {
           out.print("<A href=?desc="+("desc".equals(desc)?"asc":"desc")+param.toString()+pos+" >登记号 "+("desc".equals(desc)?"▼":"▲")+"</a>");
         }else
         {
           out.print("<A href=?order=scrbid"+param.toString()+pos+" >登记号</a>");
         }
         %></td>
         <TD nowrap><%
         if("canceldate".equals(order))
         {
           out.print("<A href=?desc="+("desc".equals(desc)?"asc":"desc")+param.toString()+pos+" >撤销无效宣告日期 "+("desc".equals(desc)?"▼":"▲")+"</a>");
         }else
         {
           out.print("<A href=?order=canceldate"+param.toString()+pos+" >撤销无效宣告日期</a>");
         }
         %></TD>
         <TD nowrap><%
         if("reason".equals(order))
         {
           out.print("<A href=?desc="+("desc".equals(desc)?"asc":"desc")+param.toString()+pos+" >撤销无效宣告理由 "+("desc".equals(desc)?"▼":"▲")+"</a>");
         }else
         {
           out.print("<A href=?order=reason"+param.toString()+pos+" >撤销无效宣告理由</a>");
         }
         %></TD>
         <TD nowrap>&nbsp;</TD>
       </tr>
     <%
java.util.Enumeration enumer=Crcancel.find(teasession._strCommunity,sql.toString(),pos,25);
for(int index=1;enumer.hasMoreElements();index++)
{
  int id=((Integer)enumer.nextElement()).intValue();
  Crcancel obj=Crcancel.find(id);
  %>
  <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    <td width="1"><%=index%></td>
    <td>&nbsp;<%=obj.getScrbid()%></td>
    <td>&nbsp;<%=obj.getCanceldateToString()%></td>
    <td>&nbsp;<%=obj.getReason()%></td>
    <td><input type=button value=调看 onclick="window.open('/jsp/copyright/CrcancelView.jsp?community=<%=teasession._strCommunity%>&crcancel=<%=id%>','','height=500,width=700,status=no,toolbar=no,menubar=no,location=no');" >
        <input type=button value=编辑 onclick="window.open('/jsp/copyright/EditCrcancel.jsp?community=<%=teasession._strCommunity%>&crcancel=<%=id%>&nexturl='+encodeURIComponent(location),'_self');" >
        <input type=button value=删除 onclick="if(confirm('确定删除吗？'))window.open('/servlet/EditCopyRight?community=<%=teasession._strCommunity%>&crcancel=<%=id%>&act=deletecrcancel&nexturl='+encodeURIComponent(location),'_self');" >
    </td>
 </tr>
<%
}
%>
<tr><td colspan="6" align=center><%=new tea.htmlx.FPNL(teasession._nLanguage,"?"+param.toString(),pos,count)%></td></tr>
</table>

<input type=button value=添加 onclick="window.open('/jsp/copyright/EditCrcancel.jsp?community=<%=teasession._strCommunity%>&crcancel=0&nexturl='+encodeURIComponent(location),'_self');" >
<input type=button value=导入 onclick="window.open('/jsp/copyright/CrImport.jsp?community=<%=teasession._strCommunity%>&act=crcancel&nexturl='+encodeURIComponent(location),'_self');" >

<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>

