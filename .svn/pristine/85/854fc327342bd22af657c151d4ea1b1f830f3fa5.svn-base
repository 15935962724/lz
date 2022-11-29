<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.db.DbAdapter" %><%@page import="tea.resource.Resource"  %><%@page  import="tea.entity.criterion.*" %><%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}
String nexturl=java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8");

String community=request.getParameter("community");

Resource r=new Resource();

StringBuffer sql=new StringBuffer();

String name=(request.getParameter("name"));
if(name!=null&&name.length()>0)
{
  sql.append(" AND name LIKE "+DbAdapter.cite("%"+name+"%"));
}

String calling=request.getParameter("calling");
if(calling!=null&&calling.length()>0)
{
  sql.append(" AND calling LIKE "+DbAdapter.cite("%"+calling+"%"));
}

String specialty=(request.getParameter("specialty"));
if(specialty!=null&&specialty.length()>0)
{
  sql.append(" AND specialty LIKE "+DbAdapter.cite("%"+specialty+"%"));
}

String author=(request.getParameter("author"));
if(author!=null&&author.length()>0)
{
  sql.append(" AND author LIKE "+DbAdapter.cite("%"+author+"%"));
}

%>
<html>
<head>
<link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/jsp/criterion/js.js"></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<body>

<h1>参考文献</h1>
<br>
<div id="head6"><img height="6" src="about:blank"></div>
<h2>查询</h2>
   <FORM name=foEdit METHOD=get action="<%=request.getRequestURI()%>" onSubmit="">
   <input type=hidden name="community" value="<%=community%>"/>
     <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr>
       <td>名称<input name="name" id="name" value="<%if(name!=null)out.print(name);%>" ></td>
       <td>行业类别<input name="calling" id="calling" value="<%if(calling!=null)out.print(calling);%>"></td>
       <td>专长类别<input name="specialty" id="specialty" value="<%if(specialty!=null)out.print(specialty);%>"></td>
       <td>作者<input type=text name=author value="<%if(author!=null)out.print(author);%>"></td>
         <td><input type="submit" value="查询"/></td></tr>
</table>
</form>
<h2>列表</h2>
     <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr id="tableonetr">
     <td  nowrap width="1">&nbsp;</td>
       <td nowrap>名称</td>
         <TD nowrap>行业类别</TD>
         <TD nowrap>专长类别</TD>
         <TD nowrap>作者</TD>
         <TD nowrap>时间</TD>
         <TD nowrap>&nbsp;</TD>
       </tr>
     <%

java.util.Enumeration enumer=Referenceres.find(sql.toString());
for(int index=1;enumer.hasMoreElements();index++)
{
  int referenceres=((Integer)enumer.nextElement()).intValue();
  Referenceres obj=Referenceres.find(referenceres);

  %>
        <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
         <td nowrap width="1"><%=index%></td>
         <td nowrap><%=obj.getName()%></td>
         <td nowrap><%=obj.getCalling()%></td>
         <td nowrap><%=obj.getSpecialty()%></td>
         <td><%=obj.getAuthor()%></td>
         <td><%=obj.getTimeToString()%></td>
        <td nowrap><input type="button" value="编辑" onClick="window.open('/jsp/criterion/EditReferenceres.jsp?community=<%=community%>&referenceres=<%=referenceres%>&nexturl=<%=nexturl%>&time=<%=System.currentTimeMillis()%>','_self');">
<input type="button" onclick="if(confirm('<%=r.getString(teasession._nLanguage,"ConfirmDelete")%>')){window.location='/servlet/EditItem?act=EditReferenceres&referenceres=<%=referenceres%>&item=0&community=<%=community%>&delete=ON&nexturl=<%=nexturl%>';}" value="删除"/>
</td>

 </tr>
  <%
}
     %>
</table>
<input type="button" value="添加" onClick="window.open('/jsp/criterion/EditReferenceres.jsp?community=<%=community%>&referenceres=0&nexturl=<%=nexturl%>','_self');">
<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>

