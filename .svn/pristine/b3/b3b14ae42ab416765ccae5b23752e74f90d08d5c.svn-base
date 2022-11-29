<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.Resource"  %><%@page  import="tea.entity.copyright.*" %><%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv == null)
{
	response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
	return;
}


String _strId=request.getParameter("id");

String author=request.getParameter("author");
String title=request.getParameter("title");
String startdate=request.getParameter("startdate");
String enddate=request.getParameter("enddate");

StringBuffer param = new StringBuffer();
param.append("&community=").append(teasession._strCommunity);
param.append("&id=").append(_strId);

StringBuffer sql = new StringBuffer();
if (author != null && (author = author.trim()).length() > 0)
{
	sql.append(" AND ( author1 LIKE ").append(DbAdapter.cite("%"+author+"%")).append(" OR author2 LIKE ").append(DbAdapter.cite("%"+author+"%")).append(")");
	param.append("&author=").append(java.net.URLEncoder.encode(author,"UTF-8"));
}
if (title != null && (title = title.trim()).length() > 0)
{
	sql.append(" AND title LIKE ").append(DbAdapter.cite("%"+title+"%"));
	param.append("&title=").append(java.net.URLEncoder.encode(title,"UTF-8"));
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
order="crnotice";
param.append("&order=").append(order);

String desc=request.getParameter("desc");
if(desc==null)
desc="desc";
param.append("&desc=").append(desc);

int count=Crnotice.count(teasession._strCommunity,sql.toString());

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

<h1>稿酬查询</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<h2>查询</h2>
   <FORM name=form1_crnq METHOD=get action="?" onSubmit="">
   <input type=hidden name="community" value="<%=teasession._strCommunity%>"/>
   <input type=hidden name="order" value="<%=order%>"/>
   <input type=hidden name="desc" value="<%=desc%>"/>
   <input type=hidden name="id" value="<%=_strId%>"/>

     <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr>
       <td>作者姓名:<input name="author" size="10" value="<%if(author!=null)out.print(author);%>"></td>
       <td>作品名称:<input name="title" value="<%if(title!=null)out.print(title);%>"></td>
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
         if("author1".equals(order))
         {
           out.print("<A href=?desc="+("desc".equals(desc)?"asc":"desc")+param.toString()+pos+" >作者姓名1 "+("desc".equals(desc)?"▼":"▲")+"</a>");
         }else
         {
           out.print("<A href=?order=author1"+param.toString()+pos+" >作者姓名1</a>");
         }
         %></td>
         <TD nowrap><%
         if("author2".equals(order))
         {
           out.print("<A href=?desc="+("desc".equals(desc)?"asc":"desc")+param.toString()+pos+" >作者姓名2 "+("desc".equals(desc)?"▼":"▲")+"</a>");
         }else
         {
           out.print("<A href=?order=author2"+param.toString()+pos+" >作者姓名2</a>");
         }
         %></TD>
         <TD nowrap><%
         if("title".equals(order))
         {
           out.print("<A href=?desc="+("desc".equals(desc)?"asc":"desc")+param.toString()+pos+" >作品名称 "+("desc".equals(desc)?"▼":"▲")+"</a>");
         }else
         {
           out.print("<A href=?order=title"+param.toString()+pos+" >作品名称</a>");
         }
         %></TD>
         <TD nowrap>&nbsp;</TD>
       </tr>
     <%
java.util.Enumeration enumer=Crnotice.find(teasession._strCommunity,sql.toString(),pos,25);
for(int index=1;enumer.hasMoreElements();index++)
{
  int id=((Integer)enumer.nextElement()).intValue();
  Crnotice obj=Crnotice.find(id);
  %>
  <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    <td width="1"><%=index%></td>
    <td>&nbsp;<%=obj.getAuthor1()%></td>
    <td>&nbsp;<%=obj.getAuthor2()%></td>
    <td>&nbsp;<%=obj.getTitle()%></td>
    <td><input type=button value=调看 onclick="window.open('/jsp/copyright/CrnoticeView.jsp?community=<%=teasession._strCommunity%>&crnotice=<%=id%>','','height=500,width=700,status=no,toolbar=no,menubar=no,location=no');" >
        <input type=button value=编辑 onclick="window.open('/jsp/copyright/EditCrnotice.jsp?community=<%=teasession._strCommunity%>&crnotice=<%=id%>&nexturl='+encodeURIComponent(location),'_self');" >
        <input type=button value=删除 onclick="if(confirm('确定删除吗？'))window.open('/servlet/EditCopyRight?community=<%=teasession._strCommunity%>&crnotice=<%=id%>&act=deletecrnotice&nexturl='+encodeURIComponent(location),'_self');" >
    </td>
 </tr>
<%
}
%>
<tr><td colspan="6" align="center"><%=new tea.htmlx.FPNL(teasession._nLanguage,"?"+param.toString(),pos,count)%></td></tr>
</table>

<input type=button value=添加 onclick="window.open('/jsp/copyright/EditCrnotice.jsp?community=<%=teasession._strCommunity%>&crnotice=0&nexturl='+encodeURIComponent(location),'_self');" >

<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>


