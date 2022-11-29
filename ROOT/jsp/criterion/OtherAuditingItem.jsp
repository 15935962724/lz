<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.Resource" %><%@ page import="tea.entity.criterion.*" %><%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");
TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String community=request.getParameter("community");
String nexturl=request.getParameter("nexturl");

int item=Integer.parseInt(request.getParameter("item"));


Resource r=new Resource();


  Item obj=Item.find(item);




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
<script>
function defaultfocus()
{
  form1.otheruri.focus();
}


</script>
</head>
<body onLoad="defaultfocus();">

<h1>其它阶段</h1>
<br>
<div id="head6"><img height="6" src="about:blank"></div>
<br/>
<form action="/servlet/EditItem" method="post" enctype="multipart/form-data" name="form1" >
<input type=hidden name="act" value="other"/>
<input type=hidden name="item" value="<%=item%>"/>
<input type=hidden name="community" value="<%=community%>"/>
<input type=hidden name="nexturl" value="<%=nexturl%>"/>
     <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr><td>项目计划号</td>
         <TD><%=obj.getCode()%></TD>
</tr>
       <tr>

        <td>项目名称</td>
         <td nowrap><%=obj.getName()%></td>
       </tr>
       <tr>
         <td>其它文件1</td>
         <td nowrap><%
         if(obj.getOtheruri()!=null&&obj.getOtheruri().length()>0)
         {
           out.print("<A href=ItemDownload.jsp?act=otheruri&item="+item+" >"+obj.getOthername()+"</A>");
         }
         %>		 </td>
       </tr>

	        <tr>
	          <td>其它文件2</td>
              <TD><%
         if(obj.getOther2uri()!=null&&obj.getOther2uri().length()>0)
         {
           out.print("<A href=ItemDownload.jsp?act=other2uri&item="+item+" >"+obj.getOther2name()+"</A>");
         }
         %>              </TD>
</tr>
  </table>
</form>
<input type="button" value="返回" onClick="history.back();"/>
<!--


<h2>项目管理员下达</h2>
 <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
	    <tr>
         <td>报批稿</td>
         <td nowrap>
<%=obj.isLevelauditing()?"批准":"返回修改"%>
          </td>
       </tr>
	    <tr>
         <td>报批稿编制说明</td>
         <td nowrap>
		 <%=obj.isLexplainauditing()?"批准":"返回修改"%>
    </td>
       </tr>	    <tr>
         <td>报批稿技术背景研究报告</td>
         <td nowrap>
		  <%=obj.isLbackdropauditing()?"批准":"返回修改"%>
      </td>
       </tr>
 <tr>
         <td>标准编制工作报告</td>
         <td nowrap><%
         if(obj.getLweaveuri()!=null&&obj.getLweaveuri().length()>0)
         {
           out.print("<A href=ItemDownload.jsp?act=lweaveuri&item="+item+" >"+obj.getLweavename()+"</A>");
         }
         %></td>
   </tr>

	        <tr>
	          <td>局长专题会议通知</td>
              <TD><%
         if(obj.getLsinformuri()!=null&&obj.getLsinformuri().length()>0)
         {
           out.print("<A href=ItemDownload.jsp?act=lsinformuri&item="+item+" >"+obj.getLsinformname()+"</A>");
         }
         %></TD>
</tr>

	        <tr>
	          <td>局长专题会议纪要</td>
              <TD><%
         if(obj.getLssummaryuri()!=null&&obj.getLssummaryuri().length()>0)
         {
           out.print("<A href=ItemDownload.jsp?act=lssummaryuri&item="+item+" >"+obj.getLssummaryname()+"</A>");
         }
         %></TD>
</tr>
	        <tr>
	          <td>总局局务会议通知</td>
              <TD><%
         if(obj.getLginformuri()!=null&&obj.getLginformuri().length()>0)
         {
           out.print("<A href=ItemDownload.jsp?act=lginformuri&item="+item+" >"+obj.getLginformname()+"</A>");
         }
         %></TD>
</tr>
       <tr>
         <td>总局局务会议纪要</td>
         <td nowrap><%
         if(obj.getLgsummaryuri()!=null&&obj.getLgsummaryuri().length()>0)
         {
           out.print("<A href=ItemDownload.jsp?act=lgsummaryuri&item="+item+" >"+obj.getLgsummaryname()+"</A>");
         }
         %>		&nbsp; </td>
       </tr>
</table>

-->
<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>

