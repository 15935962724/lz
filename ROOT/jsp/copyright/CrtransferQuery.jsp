<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.Resource"  %><%@page  import="tea.entity.copyright.*" %><%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);

String _strId=request.getParameter("id");

String scrbid=request.getParameter("scrbid");
String heir=request.getParameter("heir");
String passdate_from=request.getParameter("passdate_from");
String passdate_to=request.getParameter("passdate_to");

StringBuffer param = new StringBuffer();
param.append("&community=").append(teasession._strCommunity);
param.append("&id=").append(_strId);

StringBuffer sql = new StringBuffer();
if (scrbid != null && (scrbid = scrbid.trim()).length() > 0)
{
	sql.append(" AND scrbid LIKE ").append(DbAdapter.cite("%"+scrbid+"%"));
	param.append("&scrbid=").append(java.net.URLEncoder.encode(scrbid,"UTF-8"));
}
if (heir != null && (heir = heir.trim()).length() > 0)
{
	sql.append(" AND heir LIKE ").append(DbAdapter.cite("%"+heir+"%"));
	param.append("&heir=").append(java.net.URLEncoder.encode(heir,"UTF-8"));
}
if (passdate_from != null && (passdate_from = passdate_from.trim()).length() > 0)
{
	sql.append(" AND passdate_from>=").append(DbAdapter.cite(passdate_from));
	param.append("&passdate_from=").append(java.net.URLEncoder.encode(passdate_from,"UTF-8"));
}
if (passdate_to != null && (passdate_to = passdate_to.trim()).length() > 0)
{
	sql.append(" AND passdate_to=").append(DbAdapter.cite(passdate_to));
	param.append("&passdate_to=").append(java.net.URLEncoder.encode(passdate_to,"UTF-8"));
}

String order=request.getParameter("order");
if(order==null)
order="crtransfer";
param.append("&order=").append(order);

String desc=request.getParameter("desc");
if(desc==null)
desc="desc";
param.append("&desc=").append(desc);

int count=Crtransfer.count(teasession._strCommunity,sql.toString());

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
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<body>

<h1>计算机软件著作权转移备案公告</h1>
<br>
<div id="head6"><img height="6" src="about:blank"></div>

<h2>查询</h2>
   <FORM name=form_crtq METHOD=get action="?" onSubmit="">
   <input type=hidden name="community" value="<%=teasession._strCommunity%>"/>
   <input type=hidden name="order" value="<%=order%>"/>
   <input type=hidden name="desc" value="<%=desc%>"/>
   <input type=hidden name="id" value="<%=_strId%>"/>
   
     <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr>
       <td>登记号:<input name="scrbid" size="10" value="<%if(scrbid!=null)out.print(scrbid);%>"></td>
       <td>姓名:<input name="heir" value="<%if(heir!=null)out.print(heir);%>"></td>
       <td>批准日期:<input name="passdate_from" size="10" value="<%if(passdate_from!=null)out.print(passdate_from);%>"><input type="button" value="..." onclick="showCalendar('form_crtq.passdate_from');">
       <input name="passdate_to" size="10"  value="<%if(passdate_to!=null)out.print(passdate_to);%>"><input type="button" value="..." onclick="showCalendar('form_crtq.passdate_to');"></td>
       <td><input type="submit" value="查询"/></td></tr>
   </table>
</form>

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
         if("heir".equals(order))
         {
           out.print("<A href=?desc="+("desc".equals(desc)?"asc":"desc")+param.toString()+pos+" >权利继受人姓名 "+("desc".equals(desc)?"▼":"▲")+"</a>");
         }else
         {
           out.print("<A href=?order=heir"+param.toString()+pos+" >权利继受人姓名</a>");
         }
         %></TD>
         <TD nowrap><%
         if("heirnation".equals(order))
         {
           out.print("<A href=?desc="+("desc".equals(desc)?"asc":"desc")+param.toString()+pos+" >继受人国籍 "+("desc".equals(desc)?"▼":"▲")+"</a>");
         }else
         {
           out.print("<A href=?order=heirnation"+param.toString()+pos+" >继受人国籍</a>");
         }
         %></TD>
         <TD nowrap><%
         if("startdate".equals(order))
         {
           out.print("<A href=?desc="+("desc".equals(desc)?"asc":"desc")+param.toString()+pos+" >开始日期 "+("desc".equals(desc)?"▼":"▲")+"</a>");
         }else
         {
           out.print("<A href=?order=startdate"+param.toString()+pos+" >开始日期</a>");
         }
         %></TD>
         <TD nowrap><%
         if("enddate".equals(order))
         {
           out.print("<A href=?desc="+("desc".equals(desc)?"asc":"desc")+param.toString()+pos+" >结束日期 "+("desc".equals(desc)?"▼":"▲")+"</a>");
         }else
         {
           out.print("<A href=?order=enddate"+param.toString()+pos+" >结束日期</a>");
         }
         %></TD>
         <TD nowrap><%
         if("passdate".equals(order))
         {
           out.print("<A href=?desc="+("desc".equals(desc)?"asc":"desc")+param.toString()+pos+" >批准日期 "+("desc".equals(desc)?"▼":"▲")+"</a>");
         }else
         {
           out.print("<A href=?order=passdate"+param.toString()+pos+" >批准日期</a>");
         }
         %></TD>
         <TD nowrap>&nbsp;</TD>
       </tr>
     <%

java.util.Enumeration enumer=Crtransfer.find(teasession._strCommunity,sql.toString(),pos,25);
for(int index=1;enumer.hasMoreElements();index++)
{
  int id=((Integer)enumer.nextElement()).intValue();
  Crtransfer obj=Crtransfer.find(id);
  %>
  <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    <td width="1"><%=index%></td>
    <td>&nbsp;<%=obj.getScrbid()%></td>
    <td>&nbsp;<%=obj.getHeir()%></td>
    <td>&nbsp;<%=obj.getHeirnation()%></td>
    <td>&nbsp;<%=obj.getStartdateToString()%></td>
    <td>&nbsp;<%=obj.getEnddateToString()%></td>
    <td>&nbsp;<%=obj.getPassdateToString()%></td>
    <td><input type=button value=调看 onclick="window.open('/jsp/copyright/CrtransferView.jsp?community=<%=teasession._strCommunity%>&crtransfer=<%=id%>','','height=500,width=700,status=no,toolbar=no,menubar=no,location=no');" ></td>
 </tr>
<%
}
%>
<tr><td colspan="6"><%=new tea.htmlx.FPNL(teasession._nLanguage,"?"+param.toString(),pos,count)%></td></tr>
</table>


<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>


