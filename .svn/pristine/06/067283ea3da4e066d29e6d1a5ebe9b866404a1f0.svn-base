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
String ainame=request.getParameter("ainame");
String writingname=request.getParameter("writingname");
String writingtype=request.getParameter("writingtype");

StringBuffer param = new StringBuffer();
param.append("&community=").append(teasession._strCommunity);
param.append("&id=").append(_strId);

StringBuffer sql = new StringBuffer();
if (scrbid != null && (scrbid = scrbid.trim()).length() > 0)
{
	sql.append(" AND scrbid LIKE ").append(DbAdapter.cite("%"+scrbid+"%"));
	param.append("&scrbid=").append(java.net.URLEncoder.encode(scrbid,"UTF-8"));
}
if (ainame != null && (ainame = ainame.trim()).length() > 0)
{
	sql.append(" AND ainame LIKE ").append(DbAdapter.cite("%"+ainame+"%"));
	param.append("&ainame=").append(java.net.URLEncoder.encode(ainame,"UTF-8"));
}
if (writingname != null && (writingname = writingname.trim()).length() > 0)
{
	sql.append(" AND writingname LIKE ").append(DbAdapter.cite("%"+writingname+"%"));
	param.append("&writingname=").append(java.net.URLEncoder.encode(writingname,"UTF-8"));
}
if (writingtype != null && (writingtype = writingtype.trim()).length() > 0)
{
	sql.append(" AND writingtype LIKE ").append(DbAdapter.cite("%"+writingtype+"%"));
	param.append("&writingtype=").append(java.net.URLEncoder.encode(writingtype,"UTF-8"));
}

String order=request.getParameter("order");
if(order==null)
order="crbulletin";
param.append("&order=").append(order);

String desc=request.getParameter("desc");
if(desc==null)
desc="desc";
param.append("&desc=").append(desc);

int count=Crbulletin.count(teasession._strCommunity,sql.toString());

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

<h1>各类作品著作权登记公告</h1>
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
       <td>作者姓名:<input name="ainame" value="<%if(ainame!=null)out.print(ainame);%>"></td>
       <td>作品名称:<input name="writingname" value="<%if(writingname!=null)out.print(writingname);%>"></td>
       <td>作品类别:<input name="writingtype" value="<%if(writingtype!=null)out.print(writingtype);%>"></td>
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
         if("ainame".equals(order))
         {
           out.print("<A href=?desc="+("desc".equals(desc)?"asc":"desc")+param.toString()+pos+" >作者姓名 "+("desc".equals(desc)?"▼":"▲")+"</a>");
         }else
         {
           out.print("<A href=?order=ainame"+param.toString()+pos+" >作者姓名</a>");
         }
         %></TD>
         <TD nowrap><%
         if("writingname".equals(order))
         {
           out.print("<A href=?desc="+("desc".equals(desc)?"asc":"desc")+param.toString()+pos+" >作品名称 "+("desc".equals(desc)?"▼":"▲")+"</a>");
         }else
         {
           out.print("<A href=?order=writingname"+param.toString()+pos+" >作品名称</a>");
         }
         %></TD>
         <TD nowrap><%
         if("writingtype".equals(order))
         {
           out.print("<A href=?desc="+("desc".equals(desc)?"asc":"desc")+param.toString()+pos+" >作品类型 "+("desc".equals(desc)?"▼":"▲")+"</a>");
         }else
         {
           out.print("<A href=?order=writingtype"+param.toString()+pos+" >作品类型</a>");
         }
         %></TD>
         <TD nowrap>&nbsp;</TD>
       </tr>
     <%

java.util.Enumeration enumer=Crbulletin.find(teasession._strCommunity,sql.toString(),pos,25);
for(int index=1;enumer.hasMoreElements();index++)
{
  int id=((Integer)enumer.nextElement()).intValue();
  Crbulletin obj=Crbulletin.find(id);
  %>
  <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    <td width="1"><%=index%></td>
    <td>&nbsp;<%=obj.getScrbid()%></td>
    <td>&nbsp;<%=obj.getAiname()%></td>
    <td>&nbsp;<%=obj.getWritingname()%></td>
    <td>&nbsp;<%=obj.getWritingtype()%></td>
    <td><input type=button value=调看 onclick="window.open('/jsp/copyright/CrbulletinView.jsp?community=<%=teasession._strCommunity%>&crbulletin=<%=id%>','','height=500,width=700,status=no,toolbar=no,menubar=no,location=no');" >
        <input type=button value=编辑 onclick="window.open('/jsp/copyright/EditCrbulletin.jsp?community=<%=teasession._strCommunity%>&crbulletin=<%=id%>&nexturl='+encodeURIComponent(location),'_self');" >
        <input type=button value=删除 onclick="if(confirm('确定删除吗？'))window.open('/servlet/EditCopyRight?community=<%=teasession._strCommunity%>&crbulletin=<%=id%>&act=deletecrbulletin&nexturl='+encodeURIComponent(location),'_self');" >
    </td>
 </tr>
<%
}
%>
<tr><td colspan="6"><%=new tea.htmlx.FPNL(teasession._nLanguage,"?"+param.toString(),pos,count)%></td></tr>
</table>

<input type=button value=添加 onclick="window.open('/jsp/copyright/EditCrbulletin.jsp?community=<%=teasession._strCommunity%>&crbulletin=0&nexturl='+encodeURIComponent(location),'_self');" >

<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>

