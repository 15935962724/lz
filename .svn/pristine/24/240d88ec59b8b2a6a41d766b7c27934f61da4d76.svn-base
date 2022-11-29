<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.Resource"  %><%@ page  import="tea.entity.admin.*" %><%@ page import="tea.ui.TeaSession" %><%
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

String name=request.getParameter("name");
if(name!=null&&(name=name.trim()).length()>0)
{
  sql.append(" AND name LIKE ").append(DbAdapter.cite("%"+name+"%"));
  param.append("&name=").append(java.net.URLEncoder.encode(name,"UTF-8"));
}


int pos=0;
if(request.getParameter("pos")!=null)
{
  pos=Integer.parseInt(request.getParameter("pos"));
}

int count=Worktype.count(community,sql.toString());

param.append("&pos=").append(pos);

String order=request.getParameter("order");
if(order==null)
order="name";
param.append("&order=").append(order);

String desc=request.getParameter("desc");
if(desc==null)
desc="asc";
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
<!--工作类型管理-->
<h1><%=r.getString(teasession._nLanguage,"1168592903312")%></h1>
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
       <td><%=r.getString(teasession._nLanguage,"1168575002906")%><!--名称--><input name="name" value="<%if(name!=null)out.print(name);%>"></td>
         <td><input type="submit" value="GO"/></td>
     </tr>
   </table>
</form>
<br>
<h2><%=r.getString(teasession._nLanguage,"1168575045718")+"( "+count+" )"%><!--列表--></h2>
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
         <td></td>
       </tr>
     <%

java.util.Enumeration enumer=Worktype.find(community,sql.toString(),pos,10);
for(int index=1;enumer.hasMoreElements();index++)
{
  int worktype=((Integer)enumer.nextElement()).intValue();
  Worktype obj=Worktype.find(worktype);

  %>
  <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    <td width="1"><%=index%></td>
    <td nowrap>&nbsp;<%=obj.getName(teasession._nLanguage)%></td>
    <td>
      <input type="button" value="<%=r.getString(teasession._nLanguage,"CBEdit")%>" onClick="window.open('/jsp/admin/workreport/EditWorktype.jsp?community=<%=community%>&worktype=<%=worktype%>&nexturl=<%=java.net.URLEncoder.encode(nexturl,"UTF-8")%>','_self');">
      <input type="button" value="<%=r.getString(teasession._nLanguage,"CBDelete")%>" onClick="if(confirm('<%=r.getString(teasession._nLanguage,"ConfirmDelete")%>')){window.open('/servlet/EditWorkreport?community=<%=community%>&worktype=<%=worktype%>&action=deleteworktype&nexturl=<%=java.net.URLEncoder.encode(nexturl,"UTF-8")%>','_self'); this.disabled=true;}">
    </td>
 </tr>
  <%
}
     %>
<tr><td colspan="7" align="center"><%=new tea.htmlx.FPNL(teasession._nLanguage,"?"+param.toString().replaceFirst("&pos=","&")+"&pos=",pos,count,10)%></td></tr>
</table>
<input type="button" value="<%=r.getString(teasession._nLanguage,"Add")%>" onClick="window.open('/jsp/admin/workreport/EditWorktype.jsp?community=<%=community%>&worktype=0&nexturl=<%=java.net.URLEncoder.encode(nexturl,"UTF-8")%>','_self');">

<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>


