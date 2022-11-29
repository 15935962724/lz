<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.Resource"  %><%@ page  import="tea.entity.admin.sales.*" %><%@ page  import="tea.entity.admin.*" %><%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String community=teasession._strCommunity;

Resource r=new Resource("/tea/resource/Workreport");

StringBuffer param=new StringBuffer("&community="+community);
StringBuffer sql=new StringBuffer();

String menu_id=(request.getParameter("id"));
if(menu_id!=null&&menu_id.length()>0)
{
  param.append("&id=").append(menu_id);
}

String tel=(request.getParameter("tel"));
if(tel!=null&&tel.length()>0)
{
  sql.append(" AND tel LIKE ").append(DbAdapter.cite("%"+tel+"%"));
  param.append("&tel=").append(java.net.URLEncoder.encode(tel,"UTF-8"));
}

String name=request.getParameter("name");
if(name!=null&&(name=name.trim()).length()>0)
{
  sql.append(" AND name LIKE ").append(DbAdapter.cite("%"+name+"%"));
  param.append("&name=").append(java.net.URLEncoder.encode(name,"UTF-8"));
}

String fax=(request.getParameter("fax"));
if(fax!=null&&fax.length()>0)
{
  sql.append(" AND fax LIKE ").append(DbAdapter.cite("%"+fax+"%"));
  param.append("&fax=").append(java.net.URLEncoder.encode(fax,"UTF-8"));
}

String email=(request.getParameter("email"));
if(email!=null&&email.length()>0)
{
  sql.append(" AND email LIKE ").append(DbAdapter.cite("%"+email+"%"));
  param.append("&email=").append(java.net.URLEncoder.encode(email,"UTF-8"));
}


int pos=0;
if(request.getParameter("pos")!=null)
{
  pos=Integer.parseInt(request.getParameter("pos"));
}

int count=SalesLinkman.count(community,sql.toString());

param.append("&pos=").append(pos);

String order=request.getParameter("order");
if(order==null)
order="time";
param.append("&order=").append(order);

String desc=request.getParameter("desc");
if(desc==null)
desc="desc";
param.append("&desc=").append(desc);

sql.append(" ORDER BY ").append(order).append(" ").append(desc);

String nexturl=request.getRequestURI()+"?"+request.getQueryString();


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
<!--联系人-->
<h1><%=r.getString(teasession._nLanguage,"联系人")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br>

<h2><%=r.getString(teasession._nLanguage,"1168574879546")%><!--查询--></h2>
   <form name=form1 METHOD=get action="?" onSubmit="">
   <input type=hidden name="community" value="<%=community%>"/>
   <input type=hidden name="order" value="<%=order%>"/>
   <input type=hidden name="desc" value="<%=desc%>"/>
   <input type=hidden name="id" value="<%=request.getParameter("id")%>"/>

   <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr>
       <td><%=r.getString(teasession._nLanguage,"1168574945796")%><!--电话--><input name="tel" value="<%if(tel!=null)out.print(tel);%>"></td>
         <td><%=r.getString(teasession._nLanguage,"1168574969234")%><!--传真--><input name="fax" value="<%if(fax!=null)out.print(fax);%>"></td>
           <td>E-Mail<input name="email" value="<%if(email!=null)out.print(email);%>"></td>
             <td><%=r.getString(teasession._nLanguage,"1168575002906")%><!--名称--><input name="name" value="<%if(name!=null)out.print(name);%>"></td>
               <td><input type="submit" value="GO"/></td></tr>
   </table>
</form>
<br>
<h2><%=r.getString(teasession._nLanguage,"1168575045718")+"( "+count+" )"%><!--列表--></h2>
<form method="POST" action="/servlet/EditExportExcel" name="form1">
 <input type="hidden" name="sql" value="">
  <input type="hidden" name="files" value="affiliation">
     <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr id="tableonetr">
     <td nowrap width="1"></td>
       <td nowrap>
         <%
         if("name".equals(order))
         {
           out.print("<A href=?desc="+("desc".equals(desc)?"asc":"desc")+param.toString()+" >"+r.getString(teasession._nLanguage,"1168575002906")+" "+("desc".equals(desc)?"▼":"▲")+"</a>");
         }else
         {
           out.print("<A href=?order=name&"+param.toString()+" >"+r.getString(teasession._nLanguage,"1168575002906")+"</a>");
         }
         %></td>
          <td nowrap><%
         if("client".equals(order))
         {
           out.print("<A href=?desc="+("desc".equals(desc)?"asc":"desc")+param.toString()+" >"+r.getString(teasession._nLanguage,"客户名称")+" "+("desc".equals(desc)?"▼":"▲")+"</a>");
         }else
         {
           out.print("<A href=?order=client&"+param.toString()+" >"+r.getString(teasession._nLanguage,"客户名称")+"</a>");
         }
         %></td>
         <td nowrap><%
         if("tel".equals(order))
         {
           out.print("<A href=?desc="+("desc".equals(desc)?"asc":"desc")+param.toString()+" >"+r.getString(teasession._nLanguage,"1168574945796")+" "+("desc".equals(desc)?"▼":"▲")+"</a>");
         }else
         {
           out.print("<A href=?order=tel&"+param.toString()+" >"+r.getString(teasession._nLanguage,"1168574945796")+"</a>");
         }
         %></td>
         <td nowrap><%
         if("email".equals(order))
         {
           out.print("<A href=?desc="+("desc".equals(desc)?"asc":"desc")+param.toString()+" >E-Mail "+("desc".equals(desc)?"▼":"▲")+"</a>");
         }else
         {
           out.print("<A href=?order=email&"+param.toString()+" >E-Mail</a>");
         }
         %></td>
         <td nowrap><!--邮编-->
         <%
         if("postcode".equals(order))
         {
           out.print("<A href=?desc="+("desc".equals(desc)?"asc":"desc")+param.toString()+" >"+r.getString(teasession._nLanguage,"1168575152750")+" "+("desc".equals(desc)?"▼":"▲")+"</a>");
         }else
         {
           out.print("<A href=?order=postcode&"+param.toString()+" >"+r.getString(teasession._nLanguage,"1168575152750")+"</a>");
         }
         %></td>
         <td nowrap><!--时间-->
         <%
         if("time".equals(order))
         {
           out.print("<A href=?desc="+("desc".equals(desc)?"asc":"desc")+param.toString()+" >"+r.getString(teasession._nLanguage,"CreateTime")+" "+("desc".equals(desc)?"▼":"▲")+"</a>");
         }else
         {
           out.print("<A href=?order=time&"+param.toString()+" >"+r.getString(teasession._nLanguage,"CreateTime")+"</a>");
         }
         %></td>
         <td></td>
       </tr>
     <%

java.util.Enumeration enumer=SalesLinkman.find(community,sql.toString(),pos,20);
for(int index=1;enumer.hasMoreElements();index++)
{
  int saleslinkman=((Integer)enumer.nextElement()).intValue();
  SalesLinkman obj=SalesLinkman.find(saleslinkman);

  %>
  <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    <td width="1"><%=index%></td>
    <td nowrap>&nbsp;<a href="/jsp/admin/sales/ViewSalesLinkman.jsp?community=<%=teasession._strCommunity%>&saleslinkman=<%=saleslinkman%>"><%=obj.getName(teasession._nLanguage)%></a></td>
    <td nowrap>
    <%
    int client=obj.getClient();
    if(client>0)
    {
       if(obj.isClienttype())
       {
         Workproject wp=Workproject.find(client);
         out.print(wp.getName(teasession._nLanguage));
       }else
       {
         Latency l=Latency.find(client);
         out.print(l.getFamily()+l.getFirsts());
       }
    }
%>
</td>
    <td nowrap>&nbsp;<%=obj.getTel()%></td>
    <td>&nbsp;<a href="mailto:<%=obj.getEmail()%>" ><%=obj.getEmail()%></a></td>
    <td>&nbsp;<%=obj.getPostcode()%></td>
    <td>&nbsp;<%=obj.getTimeToString()%></td>
    <td>
      <input type="button" value="<%=r.getString(teasession._nLanguage,"CBEdit")%>" onClick="window.open('/jsp/admin/sales/EditSalesLinkman.jsp?community=<%=community%>&saleslinkman=<%=saleslinkman%>&nexturl=<%=java.net.URLEncoder.encode(nexturl,"UTF-8")%>','_self');">
      <input type="button" value="<%=r.getString(teasession._nLanguage,"CBDelete")%>" onClick="if(confirm('<%=r.getString(teasession._nLanguage,"ConfirmDelete")%>')){window.open('/servlet/EditWorkreport?community=<%=community%>&saleslinkman=<%=saleslinkman%>&action=deletesaleslinkman&nexturl=<%=java.net.URLEncoder.encode(nexturl,"UTF-8")%>','_self'); this.disabled=true;}">
    </td>
 </tr>
  <%
}
     %>
<tr><td colspan="7" align="center"><%=new tea.htmlx.FPNL(teasession._nLanguage,"?"+param.toString().replaceFirst("&pos=","&")+"&pos=",pos,count,20)%></td></tr>
</table>
<input type="submit" name="exportall" value="导出Excel表" >
</form>
<input type="button" value="<%=r.getString(teasession._nLanguage,"Add")%>" onClick="window.open('/jsp/admin/sales/EditSalesLinkman.jsp?community=<%=community%>&saleslinkman=0&nexturl=<%=java.net.URLEncoder.encode(nexturl,"UTF-8")%>','_self');">

<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>



