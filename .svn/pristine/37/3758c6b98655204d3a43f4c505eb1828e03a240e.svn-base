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
String classno=request.getParameter("classno");
String swname=request.getParameter("swname");
String author=request.getParameter("author");

StringBuffer param = new StringBuffer();
param.append("&community=").append(teasession._strCommunity);
param.append("&id=").append(_strId);

StringBuffer sql = new StringBuffer();
if (scrbid != null && (scrbid = scrbid.trim()).length() > 0)
{
	sql.append(" AND scrbid LIKE ").append(DbAdapter.cite("%"+scrbid+"%"));
	param.append("&scrbid=").append(java.net.URLEncoder.encode(scrbid,"UTF-8"));
}
if (classno != null && (classno = classno.trim()).length() > 0)
{
	sql.append(" AND classno LIKE ").append(DbAdapter.cite("%"+classno+"%"));
	param.append("&classno=").append(java.net.URLEncoder.encode(classno,"UTF-8"));
}
if (swname != null && (swname = swname.trim()).length() > 0)
{
	sql.append(" AND swname LIKE ").append(DbAdapter.cite("%"+swname+"%"));
	param.append("&swname=").append(java.net.URLEncoder.encode(swname,"UTF-8"));
}
if (author != null && (author = author.trim()).length() > 0)
{
	sql.append(" AND author LIKE ").append(DbAdapter.cite("%"+author+"%"));
	param.append("&author=").append(java.net.URLEncoder.encode(author,"UTF-8"));
}

String order=request.getParameter("order");
if(order==null)
order="crbookin";
param.append("&order=").append(order);

String desc=request.getParameter("desc");
if(desc==null)
desc="desc";
param.append("&desc=").append(desc);

int count=Crbookin.count(teasession._strCommunity,sql.toString());

sql.append(" ORDER BY ").append(order).append(" ").append(desc);

int pos=0;
String _strPos=request.getParameter("pos");
if(_strPos!=null)
{
	pos=Integer.parseInt(_strPos);
}
param.append("&pos=");

%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<body>

<h1>计算机软件著作权登记公告</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<h2>查询</h2>
   <FORM name=form1 METHOD=get action="?" onSubmit="">
   <input type=hidden name="community" value="<%=teasession._strCommunity%>"/>
   <input type=hidden name="order" value="<%=order%>"/>
   <input type=hidden name="desc" value="<%=desc%>"/>
   <input type=hidden name="id" value="<%=_strId%>"/>

     <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr>
       <td>登记号:<input name="scrbid" size="10" value="<%if(scrbid!=null)out.print(scrbid);%>"></td>
       <td>分类号:<input name="classno" value="<%if(classno!=null)out.print(classno);%>"></td>
       <td>软件名称:<input name="swname" value="<%if(swname!=null)out.print(swname);%>"></td>
       <td>著作者姓名:<input name="author" value="<%if(author!=null)out.print(author);%>"></td>
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
         if("classno".equals(order))
         {
           out.print("<A href=?desc="+("desc".equals(desc)?"asc":"desc")+param.toString()+pos+" >分类号 "+("desc".equals(desc)?"▼":"▲")+"</a>");
         }else
         {
           out.print("<A href=?order=classno"+param.toString()+pos+" >分类号</a>");
         }
         %></TD>
         <TD nowrap><%
         if("swname".equals(order))
         {
           out.print("<A href=?desc="+("desc".equals(desc)?"asc":"desc")+param.toString()+pos+" >软件名称 "+("desc".equals(desc)?"▼":"▲")+"</a>");
         }else
         {
           out.print("<A href=?order=swname"+param.toString()+pos+" >软件名称</a>");
         }
         %></TD>
         <TD nowrap><%
         if("author".equals(order))
         {
           out.print("<A href=?desc="+("desc".equals(desc)?"asc":"desc")+param.toString()+pos+" >作者姓名 "+("desc".equals(desc)?"▼":"▲")+"</a>");
         }else
         {
           out.print("<A href=?order=author"+param.toString()+pos+" >作者姓名</a>");
         }
         %></TD>
         <TD nowrap>&nbsp;</TD>
       </tr>
     <%

java.util.Enumeration enumer=Crbookin.find(teasession._strCommunity,sql.toString(),pos,25);
for(int index=1;enumer.hasMoreElements();index++)
{
  int id=((Integer)enumer.nextElement()).intValue();
  Crbookin obj=Crbookin.find(id);
  %>
  <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    <td width="1"><%=index%></td>
    <td>&nbsp;<%=obj.getScrbid()%></td>
    <td nowrap>&nbsp;<%=obj.getClassno()%></td>
    <td>&nbsp;<%=obj.getSwname()%></td>
    <td>&nbsp;<%=obj.getAuthor()%></td>
    <td><input type=button value=调看 onclick="window.open('/jsp/copyright/CrbookinView.jsp?community=<%=teasession._strCommunity%>&crbookin=<%=id%>','','height=500,width=700,status=no,toolbar=no,menubar=no,location=no');" >
        <input type=button value=编辑 onclick="window.open('/jsp/copyright/EditCrbookin.jsp?community=<%=teasession._strCommunity%>&crbookin=<%=id%>&nexturl='+encodeURIComponent(location),'_self');" >
        <input type=button value=删除 onclick="if(confirm('确定删除吗？'))window.open('/servlet/EditCopyRight?community=<%=teasession._strCommunity%>&crbookin=<%=id%>&act=deletecrbookin&nexturl='+encodeURIComponent(location),'_self');" >
    </td>
 </tr>
<%
}
%>
<tr><td colspan="6"><%=new tea.htmlx.FPNL(teasession._nLanguage,"?"+param.toString(),pos,count)%></td></tr>
</table>

<input type=button value=添加 onclick="window.open('/jsp/copyright/EditCrbookin.jsp?community=<%=teasession._strCommunity%>&crbookin=0&nexturl='+encodeURIComponent(location),'_self');" >
<input type=button value=导入 onclick="window.open('/jsp/copyright/CrImport.jsp?community=<%=teasession._strCommunity%>&act=crbookin&nexturl='+encodeURIComponent(location),'_self');" >

<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>


