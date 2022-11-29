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
  sql.append(" AND name LIKE "+DbAdapter.cite("%"+name.replaceAll("%"," ")+"%"));
}

String specialty=(request.getParameter("specialty"));
if(specialty!=null&&specialty.length()>0)
{
  sql.append(" AND specialty LIKE "+DbAdapter.cite("%"+specialty.replaceAll("%"," ")+"%"));
}

/*
String calling=request.getParameter("calling");
if(calling!=null&&calling.length()>0)
{
  sql.append(" AND calling="+calling);
}

String bookname=(request.getParameter("bookname"));
if(bookname!=null&&bookname.length()>0)
{
  sql.append(" AND bookname LIKE "+DbAdapter.cite("%"+bookname+"%"));
}

String article=(request.getParameter("article"));
if(article!=null&&article.length()>0)
{
  sql.append(" AND article LIKE "+DbAdapter.cite("%"+article+"%"));
}
*/
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

<h1>专家资源</h1>
<br>
<div id="head6"><img height="6" src="about:blank"></div>
<h2>查询</h2>
   <FORM name=foEdit METHOD=get action="<%=request.getRequestURI()%>" onSubmit="">
   <input type=hidden name="community" value="<%=community%>"/>
     <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr>
       <td nowrap>姓名<input name="name"   value="<%if(name!=null)out.print(name);%>" ></td>
<%--       <td nowrap>类别
	            <select name="calling" id="calling">
	   <option value="">------------
       <%
           for(int index=0;index<Expertres.CALLING_TYPE.length;index++)
           {
            out.print("<option value="+index);
            if(String.valueOf(index).equals(calling))
            out.println(" SELECTED ");
            out.println(" >"+Expertres.CALLING_TYPE[index]);
           }
           %></select>

	   </td>
       <td nowrap>类别
         <select name="specialty" id="specialty">
	   <option value="">------------
       <%
           for(int index=0;index<Expertres.SPECIALTY_TYPE.length;index++)
           {
            out.print("<option value="+index);
            if(String.valueOf(index).equals(specialty))
            out.println(" SELECTED ");
            out.println(" >"+Expertres.SPECIALTY_TYPE[index]);
           }
           %></select></td>

       <td nowrap>书名<input name=bookname type=text value="<%if(bookname!=null)out.print(bookname);%>" size="15">
       <td nowrap>文章<input name=article type=text value="<%if(article!=null)out.print(article);%>" size="15">
--%>
<td nowrap>专长<input name=specialty type=text value="<%if(specialty!=null)out.print(specialty);%>" >
	   </td>
                <td nowrap><input type="submit" value="查询"/></td></tr>
</table>
</form>
<h2>列表</h2>
     <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr id="tableonetr">
     <td nowrap>&nbsp;</td>
       <td nowrap>姓名</td>
         <TD nowrap>专长</TD>
         <TD nowrap>职务/职称</TD>
         <TD nowrap>单位</TD>
         <TD nowrap>&nbsp;</TD>
       </tr>
     <%

java.util.Enumeration enumer=Expertres.find(sql.toString());
for(int index=1;enumer.hasMoreElements();index++)
{
  int expertres=((Integer)enumer.nextElement()).intValue();
  Expertres obj=Expertres.find(expertres);

  %>
        <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
         <td width="1"><%=index%></td>
         <td nowrap><%=obj.getName()%></td>
         <td nowrap><%=obj.getSpecialty()%></td>
         <td nowrap><%=obj.getDuty()+" / "+obj.getTitle()%></td>
         <td><%=obj.getUnit()%></td>
        <td nowrap><input type="button" value="编辑" onClick="window.open('/jsp/criterion/EditExpertres.jsp?community=<%=community%>&expertres=<%=expertres%>&nexturl=<%=nexturl%>&time=<%=System.currentTimeMillis()%>','_self');">
<input type="button" onClick="if(confirm('<%=r.getString(teasession._nLanguage,"ConfirmDelete")%>')){window.location='/servlet/EditItem?act=EditExpertres&expertres=<%=expertres%>&item=0&community=<%=community%>&delete=ON&nexturl=<%=nexturl%>';}" value="删除"/>
</td>

 </tr>
  <%
}
     %>
</table>
<input type="button" value="添加" onClick="window.open('/jsp/criterion/EditExpertres.jsp?community=<%=community%>&expertres=0&nexturl=<%=nexturl%>','_self');">
<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>

