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
  //form1.lweaveuri.focus();
}


</script>
</head>
<body onLoad="defaultfocus();">

<h1>发布阶段</h1>
<br>
<div id="head6"><img height="6" src="about:blank"></div>
<br/>
<h2>标准处上报</h2>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td>标准布稿</td>
    <td nowrap>

	         <%
         if(obj.getStandarduri()!=null&&obj.getStandarduri().length()>0)
         {
           out.print("<A href=ItemDownload.jsp?act=standarduri&item="+item+" >"+obj.getStandardname()+"</A>");
         }
         %>

	  </td>
  </tr>
  <tr>
    <td>标准发布公告</td>
    <TD><%
         if(obj.getSweaveuri()!=null&&obj.getSweaveuri().length()>0)
         {
           out.print("<A href=ItemDownload.jsp?act=sweaveuri&item="+item+" >"+obj.getSweavename()+"</A>");
         }
         %>    </TD>
  </tr>
<%--
  <tr>
    <td>标准技术报告</td>
    <TD><%
         if(obj.getSbackdropuri()!=null&&obj.getSbackdropuri().length()>0)
         {
           out.print("<A href=ItemDownload.jsp?act=sbackdropuri&item="+item+" >"+obj.getSbackdropname()+"</A>");
         }
         %>    </TD>
  </tr>
  --%>
</table>


<h2>项目管理员下达</h2>
<form action="/servlet/EditItem" method="post" enctype="multipart/form-data" name="form1" >
<input type=hidden name="act" value="standardauditing"/>
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
         <td>&nbsp;</td>
         <td nowrap>
           <input type="submit" name="next" value="项目结束">
           <input type="button" value="返回" onClick="history.back();"/>
         </td>
       </tr>
  </table>
</form>

<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>

