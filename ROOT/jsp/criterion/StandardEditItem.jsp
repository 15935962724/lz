<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter"  %><%@ page import="tea.resource.Resource" %><%@ page import="tea.entity.criterion.Item" %><%@ page import="tea.ui.TeaSession" %><%
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
  form1.standarduri.focus();
}


</script>
</head>
<body onLoad="defaultfocus();">

<h1>发布阶段</h1>
<br>
<div id="head6"><img height="6" src="about:blank"></div>
<br/>
<h2>标准处上报</h2>
<form action="/servlet/EditItem" method="post" enctype="multipart/form-data" name="form1" >
<input type=hidden name="act" value="standard"/>
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
         <td>标准发布稿</td>
         <td nowrap><input name="standarduri" onChange="fview(this);" type="file" size="40" >
         <%
         if(obj.getStandarduri()!=null&&obj.getStandarduri().length()>0)
         {
           out.print("<A href=ItemDownload.jsp?act=standarduri&item="+item+" >"+obj.getStandardname()+"</A>");
         }
         %>
         <a id="a_standarduri" href="###" style="display:none" ><img id="img_standarduri" align=absmiddle onerror="if(this.src.indexOf('defaut.gif')==-1)this.src='/tea/image/other/defaut.gif';" src=""/><span id="span_standarduri"></span></a>
</td>
       </tr>

	        <tr>
	          <td>标准发布公告</td>
              <TD><input name="sweaveuri" onChange="fview(this);" type="file" size="40"  id="sweaveuri">
                       <%
         if(obj.getSweaveuri()!=null&&obj.getSweaveuri().length()>0)
         {
           out.print("<A href=ItemDownload.jsp?act=sweaveuri&item="+item+" >"+obj.getSweavename()+"</A>");
         }
         %>
         <a id="a_sweaveuri" href="###" style="display:none" ><img id="img_sweaveuri" align=absmiddle onerror="if(this.src.indexOf('defaut.gif')==-1)this.src='/tea/image/other/defaut.gif';" src=""/><span id="span_sweaveuri"></span></a>
              </TD>
</tr>

<%--	        <tr>
	          <td>标准技术报告</td>
              <TD><input name="sbackdropuri"  onchange="fview(this);" type="file" size="40"  id="sbackdropuri">
                       <%
         if(obj.getSbackdropuri()!=null&&obj.getSbackdropuri().length()>0)
         {
           out.print("<A href=ItemDownload.jsp?act=sbackdropuri&item="+item+" >"+obj.getSbackdropname()+"</A>");
         }
         %>
         <a id="a_sbackdropuri" href="###" style="display:none" ><img id="img_sbackdropuri" align=absmiddle onerror="if(this.src.indexOf('defaut.gif')==-1)this.src='/tea/image/other/defaut.gif';" src=""/><span id="span_sbackdropuri"></span></a>
              </TD>
</tr>
--%>
       <tr>
         <td>&nbsp;</td>
         <td nowrap>
           <input type="submit" name="Submit" value="提交">
           <input type="reset" name="Submit2" value="重置" onClick="defaultfocus();">
           <input type="button" value="返回" onClick="history.back();"/>
         </td>
       </tr>
  </table>
</form>

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

