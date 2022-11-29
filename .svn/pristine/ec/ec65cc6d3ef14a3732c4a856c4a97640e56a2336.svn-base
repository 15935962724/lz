<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.Resource"  %><%@ page  import="tea.entity.admin.cebbank.*" %><%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String _strId=request.getParameter("id");

Resource r=new Resource("/tea/resource/Annuity");

StringBuffer param=new StringBuffer();
param.append("&community=").append(teasession._strCommunity);
param.append("&id=").append(_strId);

StringBuffer sql=new StringBuffer();

String annuityplan=(request.getParameter("annuityplan"));
if(annuityplan!=null&&(annuityplan=annuityplan.trim()).length()>0)
{
  sql.append(" AND annuityplan LIKE ").append(DbAdapter.cite("%"+annuityplan+"%"));
  param.append("&annuityplan=").append(java.net.URLEncoder.encode(annuityplan,"UTF-8"));
}

String name=request.getParameter("name");
if(name!=null&&(name=name.trim()).length()>0)
{
  sql.append(" AND name LIKE ").append(DbAdapter.cite("%"+name.replaceAll(" ","%")+"%"));
  param.append("&name=").append(java.net.URLEncoder.encode(name,"UTF-8"));
}

String communityx=(request.getParameter("communityx"));
if(communityx!=null&&(communityx=communityx.trim()).length()>0)
{
  sql.append(" AND community LIKE ").append(DbAdapter.cite("%"+communityx+"%"));
  param.append("&communityx=").append(java.net.URLEncoder.encode(communityx,"UTF-8"));
}

String order=request.getParameter("order");
if(order==null)
order="annuityplan";
param.append("&order=").append(order);

String desc=request.getParameter("desc");
if(desc==null)
desc="ASC";
param.append("&desc=").append(desc);


int count=AnnuityPlan.count(sql.toString());

sql.append(" ORDER BY ").append(order).append(" ").append(desc);

%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT SRC="/tea/tea.js" type="text/javascript"></SCRIPT>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/jsp/criterion/js.js"></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<body>

<h1><%=r.getString(teasession._nLanguage,"1186541882453")%></h1>
<br>
<div id="head6"><img height="6" src="about:blank"></div>
<h2><%=r.getString(teasession._nLanguage,"1186541970453")%></h2>
   <form name=foEdit METHOD=get action="?" onSubmit="">
   <input type=hidden name="community" value="<%=teasession._strCommunity%>"/>
   <input type=hidden name="order" value="<%=order%>"/>
   <input type=hidden name="desc" value="<%=desc%>"/>
   <input type=hidden name="id" value="<%=_strId%>"/>

     <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr>
       <td><%=r.getString(teasession._nLanguage,"1186540009531")%><input name="annuityplan" size="10" value="<%if(annuityplan!=null)out.print(annuityplan);%>"></td>
       <td><%=r.getString(teasession._nLanguage,"1186540073562")%><input name="name" value="<%if(name!=null)out.print(name);%>"></td>
       <td><%=r.getString(teasession._nLanguage,"1186540121187")%><input name="communityx" value="<%if(communityx!=null)out.print(communityx);%>"></td>
       <td><input type="submit" value="查询"/></td>
     </tr>
</table>
</form>

<br>
<h2><%=r.getString(teasession._nLanguage,"1186542044687")%> ( <%=count%> )</h2>
     <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr id="tableonetr">
       <td nowrap>
         <%
         if("annuityplan".equals(order))
         {
           out.print("<A href=?desc="+("desc".equals(desc)?"asc":"desc")+param.toString()+" >计划号 "+("desc".equals(desc)?"▼":"▲")+"</a>");
         }else
         {
           out.print("<A href=?order=annuityplan&"+param.toString()+" >计划号</a>");
         }
         %></td>
         <td nowrap><%
         if("name".equals(order))
         {
           out.print("<A href=?desc="+("desc".equals(desc)?"asc":"desc")+param.toString()+" >名称 "+("desc".equals(desc)?"▼":"▲")+"</a>");
         }else
         {
           out.print("<A href=?order=name&"+param.toString()+" >名称</a>");
         }
         %></td>
         <td nowrap><%
         if("community".equals(order))
         {
           out.print("<A href=?desc="+("desc".equals(desc)?"asc":"desc")+param.toString()+" >社区 "+("desc".equals(desc)?"▼":"▲")+"</a>");
         }else
         {
           out.print("<A href=?order=community&"+param.toString()+" >社区</a>");
         }
         %></td>
         <td nowrap>&nbsp;</td>
       </tr>
     <%

java.util.Enumeration enumer=AnnuityPlan.find(sql.toString(),0,Integer.MAX_VALUE);
for(int index=1;enumer.hasMoreElements();index++)
{
  int id=((Integer)enumer.nextElement()).intValue();
  AnnuityPlan obj=AnnuityPlan.find(id);

%>
   <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
     <td nowrap><%=id==Integer.MAX_VALUE?"多个计划":String.valueOf(id)%></td>
     <td nowrap><%=obj.getName()%></td>
     <td nowrap><%=obj.getCommunity()%></td>
     <td nowrap><input type=button value="<%=r.getString(teasession._nLanguage,"CBEdit")%>" onClick="window.open('/jsp/admin/cebbank/EditAnnuityPlan.jsp?community=<%=teasession._strCommunity%>&annuityplan=<%=id%>&nexturl='+encodeURIComponent(document.location),'_self');">
     <input type=button value="<%=r.getString(teasession._nLanguage,"CBDelete")%>" onClick="if(confirm('你真想删除这个吗?')){window.open('/servlet/EditAnnuityPlan?community=<%=teasession._strCommunity%>&act=deleteannuityplan&annuityplan=<%=id%>&nexturl='+encodeURIComponent(document.location),'_self');this.disabled=true;}">
     </td>
 </tr>
<%
}
%>
</table>
<input type="button" value="<%=r.getString(teasession._nLanguage,"CBNew")%>" onClick="window.open('/jsp/admin/cebbank/EditAnnuityPlan.jsp?community=<%=teasession._strCommunity%>&annuityplan=-1&nexturl='+encodeURIComponent(document.location),'_self');">

<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>



