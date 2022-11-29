<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.db.DbAdapter" %><%@page import="tea.resource.Resource"  %><%@page  import="tea.entity.criterion.*" %><%@ page import="tea.ui.TeaSession" %><%@ page import="tea.entity.admin.AdminUnit" %><%
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

StringBuffer sql=new StringBuffer(" AND au.other3=0 AND au.community="+DbAdapter.cite(community));

String name=(request.getParameter("name"));
if(name!=null&&name.length()>0)
{
  sql.append(" AND au.name LIKE "+DbAdapter.cite("%"+name.replaceAll(" ","%")+"%"));
}
/*
String calling=request.getParameter("calling");
if(calling!=null&&calling.length()>0)
{
  sql.append(" AND ur.calling="+calling);
}

String specialty=(request.getParameter("specialty"));
if(specialty!=null&&specialty.length()>0)
{
  sql.append(" AND ur.specialty="+specialty);
}

String product=(request.getParameter("product"));
if(product!=null&&product.length()>0)
{
  sql.append(" AND ur.product LIKE "+DbAdapter.cite("%"+product+"%"));
}
*/
String have_a_project=(request.getParameter("have_a_project"));
if(have_a_project!=null&&have_a_project.length()>0)
{
  sql.append(" AND ur.have_a_project LIKE "+DbAdapter.cite("%"+have_a_project.replaceAll(" ","%")+"%"));
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

<h1>编辑单位资源</h1>
<br>
<div id="head6"><img height="6" src="about:blank"></div>
<h2>查询</h2>
   <FORM name=foEdit METHOD=get action="<%=request.getRequestURI()%>" onSubmit="">
   <input type=hidden name="community" value="<%=community%>"/>
     <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr>
       <td>名称
         <input name="name" id="name" value="<%if(name!=null)out.print(name);%>" ></td>
       <%-- <td>行业类别
	            <select name="calling" id="calling">
	   <option value="">------------
       <%
           for(int index=0;index<Unitres.CALLING_TYPE.length;index++)
           {
            out.print("<option value="+index);
            if(String.valueOf(index).equals(calling))
            out.println(" SELECTED ");
            out.println(" >"+Unitres.CALLING_TYPE[index]);
           }
           %></select>

	   </td>
       <td>专长类别
         <select name="specialty" id="specialty">
	   <option value="">------------
       <%
           for(int index=0;index<Unitres.SPECIALTY_TYPE.length;index++)
           {
            out.print("<option value="+index);
            if(String.valueOf(index).equals(specialty))
            out.println(" SELECTED ");
            out.println(" >"+Unitres.SPECIALTY_TYPE[index]);
           }
           %></select></td>

       <td>产品<input type=text name=product value="<%if(product!=null)out.print(product);%>">
       --%>
       <td>已做项目<input type=text name=have_a_project value="<%if(have_a_project!=null)out.print(have_a_project);%>"></td>
                <td><input type="submit" value="查询"/></td></tr>
</table>
</form>
<h2>列表</h2>
     <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr id="tableonetr">
     <td nowrap>&nbsp;</td>
       <td nowrap>名称</td>
         <TD nowrap>联系人</TD>
         <TD nowrap>已做项目</TD>
         <TD nowrap>行业</TD>
         <TD nowrap>专长</TD>
         <TD nowrap>&nbsp;</TD>
       </tr>
     <%

java.util.Enumeration enumer=Unitres.find(sql.toString());
for(int index=1;enumer.hasMoreElements();index++)
{
  int unit=((Integer)enumer.nextElement()).intValue();
  AdminUnit au_obj=AdminUnit.find(unit);
  Unitres obj=Unitres.find(unit);

  %>
        <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
         <td nowrap width="1"><%=index%></td>
         <td nowrap><%=au_obj.getName()%></td>
         <td nowrap><%if(obj.getLinkmanname()!=null)out.print(obj.getLinkmanname());%></td>
         <td nowrap><%if(obj.getHave_a_project()!=null)out.print(obj.getHave_a_project());%></td>
         <td nowrap><%if(obj.getCalling()!=null)out.print(obj.getCalling());%></td>
         <td nowrap><%if(obj.getSpecialty()!=null)out.print(obj.getSpecialty());%></td>
        <td nowrap><input type="button" value="编辑" onClick="window.open('/jsp/criterion/EditUnitres.jsp?community=<%=community%>&unit=<%=unit%>&nexturl=<%=nexturl%>&time=<%=System.currentTimeMillis()%>','_self');">
<!-- input type="button" onclick="if(confirm('<%=r.getString(teasession._nLanguage,"ConfirmDelete")%>')){window.location='/servlet/EditItem?act=EditExpertres&unit=<%=unit%>&item=0&community=<%=community%>&delete=ON&nexturl=<%=nexturl%>';}" value="删除"/ -->
</td>

 </tr>
  <%
}
     %>
</table>
<!--input type="button" value="添加" onClick="window.open('/jsp/criterion/EditExpertres.jsp?community=<%=community%>&expertres=0&nexturl=<%=nexturl%>','_self');"-->
<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>

