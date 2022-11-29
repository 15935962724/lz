<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.Resource"  %><%@ page  import="tea.entity.admin.*" %><%@ page  import="tea.entity.node.*" %><%@ page import="tea.ui.TeaSession" %><%
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

StringBuffer sql=new StringBuffer(" FROM Node n INNER JOIN NodeLayer nl ON n.node=nl.node WHERE n.hidden=0 AND n.finished=1 AND n.type=34 AND n.community=");//SELECT n.node,nl.subject
sql.append(DbAdapter.cite(community)).append(" AND nl.language="+teasession._nLanguage);


String name=request.getParameter("name");
if(name!=null&&(name=name.trim()).length()>0)
{
  sql.append(" AND nl.subject LIKE ").append(DbAdapter.cite("%"+name+"%"));
  param.append("&name=").append(java.net.URLEncoder.encode(name,"UTF-8"));
}



int pos=0,size=10;
if(request.getParameter("pos")!=null)
{
  pos=Integer.parseInt(request.getParameter("pos"));
}
param.append("&pos=").append(pos);

String fieldname=request.getParameter("fieldname");
if(fieldname==null)
{
  fieldname="form1.goods";
}



int count=0;
StringBuffer sb=new StringBuffer();
DbAdapter db=new DbAdapter();

try
{
  count=db.getInt("SELECT COUNT(*) "+sql.toString());
  db.executeQuery("SELECT n.node,nl.subject,n.time "+sql.toString());
  for (int l = 0; l < pos + size && db.next(); l++)
  {
    if (l >= pos)
    {
      int node=db.getInt(1);
      String subject=db.getString(2);
      java.util.Date time=db.getDate(3);
      sb.append("<tr onMouseOver=\"javascript:this.bgColor='#BCD1E9';\" onMouseOut=\"javascript:this.bgColor='';\" onclick=\"window.opener.document.").append(fieldname).append(".value=").append(node).append(";window.close();\">");
      sb.append("<td width=1 ><script>document.write(++i);</script></td>");
      sb.append("<td >").append(subject).append("</td>");
      sb.append("<td >").append(Node.sdf.format(time)).append("</td></tr>\r\n");
    }
  }
}finally
{
  db.close();
}


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
<!--客户或项目管理-->
<br>
<div id="head6"><img height="6" src="about:blank"></div>


<h2><%=r.getString(teasession._nLanguage,"1168574879546")%><!--查询--></h2>
   <form name=form1 METHOD=get action="?" onSubmit="">
   <input type=hidden name="community" value="<%=community%>"/>

   <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr>
       <td><%=r.getString(teasession._nLanguage,"1168575002906")%><!--名称--><input name="name" value="<%if(name!=null)out.print(name);%>"></td>
       <td><input type="submit" value="GO"/></td></tr>
   </table>
</form>
<br>
<h2><%=r.getString(teasession._nLanguage,"1168575045718")+"( "+count+" )"%><!--列表--></h2>
     <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr id="tableonetr">
     <td nowrap width="1"><script>var i=0;</script></td>
       <td nowrap><%=r.getString(teasession._nLanguage,"Subject")%></td>
       <td nowrap><%=r.getString(teasession._nLanguage,"CreateTime")%></td>
     </tr>
     <%=sb.toString()%>
<tr><td colspan="4" align="center"><%=new tea.htmlx.FPNL(teasession._nLanguage,"?"+param.toString().replaceFirst("&pos=","&")+"&pos=",pos,count,10)%></td></tr>
</table>

<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>


