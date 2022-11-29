<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter"%>
<%@ page import="tea.resource.Resource"%>
<%@ page import="tea.entity.admin.*" %>
<%@ page import="tea.ui.TeaSession" %>
<%@ page import="java.io.*" %>
<%
request.setCharacterEncoding("UTF-8");


response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}
String community=teasession._strCommunity;

int listdelete =0;
if(teasession.getParameter("listdelete")!=null)
{
	listdelete= Integer.parseInt(teasession.getParameter("listdelete"));
	Books obj = Books.find(listdelete);
	obj.delete();
	response.sendRedirect("/jsp/admin/books/record.jsp");
	return ;
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


<h1>管理设置</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<input type="button" value="新建图书" onClick="location='/jsp/admin/books/newbook.jsp'" >
<br>
<%
/*
	java.util.Enumeration enu = books.findByCommunity(teasession._strCommunity,"");
	out.print(enu.hasMoreElements());
	while(enu.hasMoreElements())
	{

	}
*/
 %>
<h1> 管理图书  </h1>
<div id="head6"><img height="6" src="about:blank"></div>
<form name=form1 METHOD=post  action="/jsp/admin/books/list.jsp" onsubmit="return sub(this);">
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<input type="hidden" value="record" name = record>
     <tr >
   		<td nowrap>部门：</td>
   		<td nowrap>
	<%

	 String member = teasession._rv.toString();//当前用户

            AdminUsrRole au_obj=AdminUsrRole.find(teasession._strCommunity,member);
            if(au_obj.isExists())
            {
             out.print("<select name=\"unit\">");
             out.print("<option value=\"0\">----------</option>");
    	 		 String sql = " and unit="+au_obj.getUnit()+" and classes="+au_obj.getClasses()+" and creator = '"+member+"'";
        		 if(au_obj.getUnit()!=0 && au_obj.getClasses()==0)
            	{
            		 AdminUnit obj_au=  AdminUnit.find(au_obj.getUnit());
            		out.print("<option value="+au_obj.getUnit()+" >");
				  	out.print(obj_au.getName());
				  	out.print("</option>");
            	}
            	if(au_obj.getUnit()==0 &&  au_obj.getClasses()!=2)
            	{
            		 AdminUnit obj_au=  AdminUnit.find(au_obj.getUnit());
            		out.print("<option value="+au_obj.getUnit()+">");
				  	out.print("无部门");
				  	out.print("</option>");
            	}
            	if(au_obj.getClasses()==1)
            	{
            		 AdminUnit obj_au=  AdminUnit.find(au_obj.getUnit());
            		out.print("<option value="+au_obj.getUnit()+">");
				  	out.print(obj_au.getName());
				  	out.print("</option>");
            	}
				if(au_obj.getClasses()==2)
				{
					sql ="";

				  java.util.Enumeration enumer = AdminUnit.findByCommunity(teasession._strCommunity,sql);//得到的部门

				 		 out.print("<option value=\"-1\">全部部门");
					  	out.print("</option>");
				  while(enumer.hasMoreElements())
				  {
                    AdminUnit obj_au=(AdminUnit)enumer.nextElement();
                    int ide=obj.getId();

                    out.print("<option value="+ide+">");
                    out.print(obj_au.getName());
                    out.print("</option>");
                  }

				}
				 out.print("</select>");
    		 }
    	  %>
		</td>
    </tr>
    <tr>
   		<td nowrap>图书类别:</td>
   		<td nowrap><select name="booksort"><option value="0">------</option>
   		<%
   			java.util.Enumeration em = Sort.findByCommunity(teasession._strCommunity,"");
   			String dd =Duty.GetNowDate();
   			while(em.hasMoreElements())
   			{
   				int id = ((Integer)em.nextElement()).intValue();
   				Sort obj = Sort.find(id);
   				out.print("<option value="+id+">");
   				out.print(obj.getSortname());
   				out.print("</option>");
   			}
   		 %>
   		</select></td>
    </tr>
    <tr>
    	<td nowrap>书名:</td>
    	<td nowrap><input type="text" value="" name="bookname" size="33" maxlength="100"></td>
    </tr>
   <tr>
    	<td nowrap>作者:</td>
    	<td nowrap><input type="text" value="" name="author" size="33" maxlength="100"></td>
    </tr>
    <tr>
    	<td nowrap>图书编号:</td>
    	<td nowrap><input type="text" value="" name="number" size="33" maxlength="100"></td>
    </tr>
    <tr>
    	<td nowrap>出版社:</td>
    	<td nowrap><input type="text" value="" name="concern" size="33" maxlength="100"></td>
    </tr>
      <tr>
    	<td nowrap>出版社日期：</td>
    	<td nowrap><input name="times" size="7"  value="<%=dd %>" readonly><A href="###"><img onclick="showCalendar('form1.times');" src="/tea/image/public/Calendar2.gif" align="top"/></a></td>
    </tr>
    <tr>
    	<td nowrap>存放地点:</td>
    	<td nowrap><input type="text" value="" name="locus" size="33" maxlength="100"></td>
    </tr>

</table>
 <input type="submit" value="查询">
</FORM>
</body>
</html>



