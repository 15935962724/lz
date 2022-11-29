<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.Resource"  %><%@page  import="tea.entity.copyright.*" %><%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv == null)
{
	response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
	return;
}

String _strId=request.getParameter("id");

String zzxm=request.getParameter("zzxm");
String zzbm=request.getParameter("zzbm");
String zzsfzh=request.getParameter("zzsfzh");
String zzdz=request.getParameter("zzdz");
String zzyb=request.getParameter("zzyb");

StringBuffer param = new StringBuffer();
param.append("&community=").append(teasession._strCommunity);
param.append("&id=").append(_strId);

StringBuffer sql = new StringBuffer();
if (zzxm != null && (zzxm = zzxm.trim()).length() > 0)
{
	sql.append(" AND zzxm LIKE ").append(DbAdapter.cite("%"+zzxm+"%"));
	param.append("&zzxm=").append(java.net.URLEncoder.encode(zzxm,"UTF-8"));
}
if (zzbm != null && (zzbm = zzbm.trim()).length() > 0)
{
	sql.append(" AND zzbm LIKE ").append(DbAdapter.cite("%"+zzbm+"%"));
	param.append("&zzbm=").append(java.net.URLEncoder.encode(zzbm,"UTF-8"));
}
if (zzsfzh != null && (zzsfzh = zzsfzh.trim()).length() > 0)
{
	sql.append(" AND zzsfzh LIKE ").append(DbAdapter.cite(zzsfzh));
	param.append("&zzsfzh=").append(java.net.URLEncoder.encode(zzsfzh,"UTF-8"));
}
if (zzdz != null && (zzdz = zzdz.trim()).length() > 0)
{
	sql.append(" AND zzdz LIKE ").append(DbAdapter.cite(zzdz));
	param.append("&zzdz=").append(java.net.URLEncoder.encode(zzdz,"UTF-8"));
}
if (zzyb != null && (zzyb = zzyb.trim()).length() > 0)
{
	sql.append(" AND zzyb LIKE ").append(DbAdapter.cite(zzyb));
	param.append("&zzyb=").append(java.net.URLEncoder.encode(zzyb,"UTF-8"));
}

String order=request.getParameter("order");
if(order==null)
order="crzzba";
param.append("&order=").append(order);

String desc=request.getParameter("desc");
if(desc==null)
desc="desc";
param.append("&desc=").append(desc);

int count=Crzzba.count(teasession._strCommunity,sql.toString());

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

<h1>作者信息备案</h1>
<br>
<div id="head6"><img height="6" src="about:blank"></div>

<h2>查询</h2>
   <FORM name=form1_crnq METHOD=get action="?" onSubmit="">
   <input type=hidden name="community" value="<%=teasession._strCommunity%>"/>
   <input type=hidden name="order" value="<%=order%>"/>
   <input type=hidden name="desc" value="<%=desc%>"/>
   <input type=hidden name="id" value="<%=_strId%>"/>

     <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr>
       <td>作者姓名:<input name="zzxm" size="10" value="<%if(zzxm!=null)out.print(zzxm);%>"></td>
       <td>作者笔名:<input name="zzbm" value="<%if(zzbm!=null)out.print(zzbm);%>"></td>
       <td>身份证号:<input name="zzsfzh" value="<%if(zzsfzh!=null)out.print(zzsfzh);%>"></td>
       <td>作者地址:<input name="zzdz" value="<%if(zzdz!=null)out.print(zzdz);%>"></td>
       <td>邮政编码:<input name="zzyb" value="<%if(zzyb!=null)out.print(zzyb);%>"></td>
       <td><input type="submit" value="查询"/></td></tr>
   </table>
</form>

<h2>列表 ( <%=count%> )</h2>
     <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr id="tableonetr">
     <td nowrap width="1">&nbsp;</td>
       <td>
         <%
         if("zzxm".equals(order))
         {
           out.print("<A href=?desc="+("desc".equals(desc)?"asc":"desc")+param.toString()+pos+" >作者姓名 "+("desc".equals(desc)?"▼":"▲")+"</a>");
         }else
         {
           out.print("<A href=?order=zzxm"+param.toString()+pos+" >作者姓名</a>");
         }
         %></td>
         <TD nowrap><%
         if("zzbm".equals(order))
         {
           out.print("<A href=?desc="+("desc".equals(desc)?"asc":"desc")+param.toString()+pos+" >作者笔名 "+("desc".equals(desc)?"▼":"▲")+"</a>");
         }else
         {
           out.print("<A href=?order=zzbm"+param.toString()+pos+" >作者笔名</a>");
         }
         %></TD>
         <TD nowrap><%
         if("zzsfzh".equals(order))
         {
           out.print("<A href=?desc="+("desc".equals(desc)?"asc":"desc")+param.toString()+pos+" >身份证号 "+("desc".equals(desc)?"▼":"▲")+"</a>");
         }else
         {
           out.print("<A href=?order=zzsfzh"+param.toString()+pos+" >身份证号</a>");
         }
         %></TD>
        <TD nowrap><%
         if("zzdz".equals(order))
         {
           out.print("<A href=?desc="+("desc".equals(desc)?"asc":"desc")+param.toString()+pos+" >作者地址 "+("desc".equals(desc)?"▼":"▲")+"</a>");
         }else
         {
           out.print("<A href=?order=zzdz"+param.toString()+pos+" >作者地址</a>");
         }
         %></TD>
        <TD nowrap><%
         if("zzyb".equals(order))
         {
           out.print("<A href=?desc="+("desc".equals(desc)?"asc":"desc")+param.toString()+pos+" >邮政编码 "+("desc".equals(desc)?"▼":"▲")+"</a>");
         }else
         {
           out.print("<A href=?order=zzyb"+param.toString()+pos+" >邮政编码</a>");
         }
         %></TD>
        <TD nowrap><%
         if("zzdh".equals(order))
         {
           out.print("<A href=?desc="+("desc".equals(desc)?"asc":"desc")+param.toString()+pos+" >作者电话 "+("desc".equals(desc)?"▼":"▲")+"</a>");
         }else
         {
           out.print("<A href=?order=zzdh"+param.toString()+pos+" >作者电话</a>");
         }
         %></TD>
         <TD nowrap>&nbsp;</TD>
       </tr>
     <%
java.util.Enumeration enumer=Crzzba.find(teasession._strCommunity,sql.toString(),pos,25);
for(int index=1;enumer.hasMoreElements();index++)
{
  int id=((Integer)enumer.nextElement()).intValue();
  Crzzba obj=Crzzba.find(id);
  %>
  <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    <td width="1"><%=index%></td>
    <td>&nbsp;<%=obj.getZzxm()%></td>
    <td>&nbsp;<%=obj.getZzbm()%></td>
    <td>&nbsp;<%=obj.getZzsfzh()%></td>
    <td>&nbsp;<%=obj.getZzdz()%></td>
    <td>&nbsp;<%=obj.getZzyb()%></td>
    <td>&nbsp;<%=obj.getZzdh()%></td>
    <td><input type=button value=调看 onclick="window.open('/jsp/copyright/CrzzbaView.jsp?community=<%=teasession._strCommunity%>&crzzba=<%=id%>','','height=500,width=700,status=no,toolbar=no,menubar=no,location=no');" >
    <input type=button value=编辑 onclick="window.open('/jsp/copyright/EditCrzzba.jsp?community=<%=teasession._strCommunity%>&crzzba=<%=id%>&nexturl='+encodeURIComponent(location),'_self');" >
    <input type=button value=删除 onclick="if(confirm('确定删除吗？'))window.open('/servlet/EditCopyRight?community=<%=teasession._strCommunity%>&crzzba=<%=id%>&act=deletecrzzba&nexturl='+encodeURIComponent(location),'_self');" >
    </td>
 </tr>
<%
}
%>
<tr><td colspan="6"><%=new tea.htmlx.FPNL(teasession._nLanguage,"?"+param.toString(),pos,count)%></td></tr>
</table>

<input type=button value=添加 onclick="window.open('/jsp/copyright/EditCrzzba.jsp?community=<%=teasession._strCommunity%>&crzzba=0&nexturl='+encodeURIComponent(location),'_self');" >

<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>

