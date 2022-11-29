<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter"%>
<%@ page import="tea.resource.Resource"%>
<%@ page import="tea.entity.admin.*" %>
<%@ page import="tea.ui.TeaSession" %>
<%@ page import="java.io.*" %>
<%@ page import ="java.util.Date" %>
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

int id = 0 ;
if(teasession.getParameter("id")!=null && teasession.getParameter("id").length()>0)
	id = Integer.parseInt(teasession.getParameter("id"));

Books obj = Books.find(id);
int unit = 0,booksort=0,amount=0,bound=0,  fettle =0;
String bookname =null,number=null,concern=null,locus=null,
 content=null,human=null, remark =null,author=null;
//Date times =null;
Date times = null;
float price=0;

if(id>0)
{
	unit = obj.getUnit();
	booksort = obj.getBooksort();
	bookname=obj.getBookname();
	number= obj.getNumber();
	author = obj.getAuthor();
	concern = obj.getConcern();
	locus = obj.getLocus();
	times = obj.getTimes();
	amount = obj.getAmount();
	price =  obj.getPrice();
	content = obj.getContent();
	bound = obj.getBound();
	fettle = obj.getFettle();
	human = obj.getHuman();
	remark = obj.getRemark();

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
<script>

	function sub(){
		if(form1.unit.value==0)
		{alert("请选择部门");
		return false;}
		if(form1.bookname.value=="")
		{alert("请填写书名");
		return false;}
		if(form1.booksort.value==0)
		{alert("请选择类别");
		return false;}
		if(form1.times.value=="")
		{alert("请选择时间");
		return false;}

	}
</script>


<h1> 新建图书  </h1>
<div id="head6"><img height="6" src="about:blank"></div>
<form name=form1 METHOD=post  action="/servlet/EditBooks" onsubmit="return sub(this);">
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<input type="hidden" value="<%=id %>" name ="id">

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
            		out.print("<option value="+au_obj.getUnit());
				  	if(unit==au_obj.getUnit())
				  		 out.print(" selected ");
				  	out.print(">"+obj_au.getName()+"</option>");
            	}
            	if(au_obj.getUnit()==0 &&  au_obj.getClasses()!=2)
            	{
            		  AdminUnit obj_au=  AdminUnit.find(au_obj.getUnit());
            		out.print("<option value="+au_obj.getUnit());
				  	if(unit==au_obj.getUnit())
				  		 out.print(" selected ");
				  	out.print(">无部门</option>");
            	}
            	if(au_obj.getClasses()==1)
            	{
            		  AdminUnit obj_au=  AdminUnit.find(au_obj.getUnit());
            		out.print("<option value="+au_obj.getUnit());
				  	if(unit==au_obj.getUnit())
				  		 out.print(" selected ");
				  	out.print(">"+obj_au.getName()+"</option>");
            	}
				if(au_obj.getClasses()==2)
				{
					sql ="";

				  java.util.Enumeration enumer = AdminUnit.findByCommunity(teasession._strCommunity,sql);//得到的部门

				 		// out.print("<option value=\"-1\">全部部门");
					  //	out.print("</option>");
				  while(enumer.hasMoreElements())
				  {
                      AdminUnit obj_au=(AdminUnit)enumer.nextElement();
                      int ide=obj_au.getId();

					  	out.print("<option value="+ide);
					  	if(unit==ide)
					  	out.print("selected");
					  	out.print(">"+obj_au.getName()+"</option>");
					}

				}
				 out.print("</select>");
    		 }
    	  %>
		</td>
    </tr>
    <tr>
    	<td nowrap>书名:</td>
    	<td nowrap><input type="text" value="<%if(bookname!=null){out.print(bookname);} %>" name="bookname" size="33" maxlength="100"></td>
    </tr>
    <tr>
   		<td nowrap>图书类别:</td>
   		<td nowrap><select name="booksort"><option value="0">------</option>
   		<%
   			java.util.Enumeration em = Sort.findByCommunity(teasession._strCommunity,"");
   			while(em.hasMoreElements())
   			{
   				int ids = ((Integer)em.nextElement()).intValue();
   				Sort objs = Sort.find(ids);
   				out.print("<option value="+ids);
   				if(booksort==ids)
   					out.print(" selected");
   				out.print(">"+objs.getSortname()+"</option>");
   			}
   		 %>

   		</select></td>
    </tr>
    <tr>
    	<td nowrap>作者:</td>
    	<td nowrap><input type="text" value="<%if(author!=null){out.print(author);} %>" name="author" size="33" maxlength="100"></td>
    </tr>
    <tr>
    	<td nowrap>图书编号:</td>
    	<td nowrap><input type="text" value="<%if(number!=null)out.print(number); %>" name="number" size="33" maxlength="100"></td>
    </tr>
    <tr>
    	<td nowrap>出版社:</td>
    	<td nowrap><input type="text" value="<%if(concern!=null)out.print(concern); %>" name="concern" size="33" maxlength="100"></td>
    </tr>
      <tr>
    	<td nowrap>出版社日期：</td>
    	<td nowrap><input name="times" size="7"  value="<%if(times!=null)out.print(times); %>" readonly><A href="###"><img onclick="showCalendar('form1.times');" src="/tea/image/public/Calendar2.gif" align="top"/></a></td>
    </tr>
    <tr>
    	<td nowrap>存放地点:</td>
    	<td nowrap><input type="text" value="<%if(locus!=null)out.print(locus); %>" name="locus" size="33" maxlength="100"></td>
    </tr>
    <tr>
    	<td nowrap>数量:</td>
    	<td nowrap><input type="text" value="<%if(amount!=0)out.print(amount); %>" name="amount" size="33" maxlength="100"></td>
    </tr>
    <tr>
    	<td nowrap>价格:</td>
    	<td nowrap><input type="text" value="<%if(price!=0)out.print(price); %>" name="price" size="33" maxlength="100"></td>
    </tr>
        <tr>
    	<td nowrap>内容简介:</td>
    	<td nowrap>    <textarea cols=37 rows=3 name="content" wrap="yes"><%if(content!=null)out.print(content); %></textarea></td>
    </tr>
     <tr>
   		<td nowrap>借阅范围:</td>
   		<td nowrap><select name="bound"><option value="0">------</option>
   		<option value="1" <%if(bound==1)out.print("  selected"); %>>本部门</option>
   		<option value="2" <%if(bound==2)out.print("  selected"); %>>全体</option>
   		</select></td>
    </tr>
     <tr>
   		<td nowrap>借阅状态:</td>
   		<td nowrap><select name="fettle"><option value="0">------</option>
   		<option value="1" <%if(fettle==1)out.print(" selected"); %>>以借出</option>
   		<option value="2" <%if(fettle==2)out.print(" selected"); %>>未借出</option>
   		</select></td>
    </tr>
    <tr>
    	<td nowrap>借阅人:</td>
    	<td nowrap><input type="text" value="<%if(human!=null)out.print(human); %>" name="human" size="33" maxlength="100"></td>
    </tr>
	    <tr>
    	<td nowrap>备注:</td>
    	<td nowrap><input type="text" value="<%if(remark!=null)out.print(remark); %>" name="remark" size="33" maxlength="100"></td>
    </tr>
</table>
 <input type="submit" value="提交"> &nbsp;&nbsp;<input type="button" value="返回" onclick="location='record.jsp'">
</FORM>
</body>
</html>



