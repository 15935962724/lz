<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter"  %><%@ page import="tea.resource.Resource" %><%@ page import="tea.entity.criterion.*" %><%@ page import="tea.ui.TeaSession" %><%
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
  try
  {
    document.form1.leveluri.focus();
  }catch(e)
  {}
}


</script>
</head>
<body onLoad="defaultfocus();">

<h1>报批阶段</h1>
<br>
<div id="head6"><img height="6" src="about:blank"></div>
<br/>
<h2>编制组上报</h2>
<form action="/servlet/EditItem" method="post" enctype="multipart/form-data" name="form1" >
<input type=hidden name="act" value="level"/>
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
         <td>报批稿</td>
         <td nowrap>
         <%
         if(obj.getLeveluri()==null||obj.getLeveluri().length()==0||(obj.getLeveltime()!=null&&!obj.isLevelauditing()))
         {
           out.println("<input name=leveluri onchange=\"fview(this);\" type=file size=40 >");
         }
         if(obj.getLeveluri()!=null&&obj.getLeveluri().length()>0)
         {
           out.print("<A href=ItemDownload.jsp?act=leveluri&item="+item+" >"+obj.getLevelname()+"</A>");
         }
         %>
         <a id="a_leveluri" href="###" style="display:none" ><img id="img_leveluri" align=absmiddle onerror="if(this.src.indexOf('defaut.gif')==-1)this.src='/tea/image/other/defaut.gif';" src=""/><span id="span_leveluri"></span></a>
		 </td>
       </tr>

	        <tr>
	          <td>报批稿编制说明</td>
              <TD>
                       <%
         if(obj.getLexplainuri()==null||obj.getLexplainuri().length()==0||(obj.getLeveltime()!=null&&!obj.isLexplainauditing()))
         {
           out.println("<input name=lexplainuri onchange=\"fview(this);\"  type=file size=40 >");
         }
         if(obj.getLexplainuri()!=null&&obj.getLexplainuri().length()>0)
         {
           out.print("<A href=ItemDownload.jsp?act=lexplainuri&item="+item+" >"+obj.getLexplainname()+"</A>");
         }
         %>
         <a id="a_lexplainuri" href="###" style="display:none" ><img id="img_lexplainuri" align=absmiddle onerror="if(this.src.indexOf('defaut.gif')==-1)this.src='/tea/image/other/defaut.gif';" src=""/><span id="span_lexplainuri"></span></a>
              </TD>
</tr>

	        <tr>
	          <td>报批稿技术背景研究报告</td>
              <TD>
<%
if(obj.getLbackdropuri()==null||obj.getLbackdropuri().length()==0||(obj.getLeveltime()!=null&&!obj.isLbackdropauditing()))
{
  out.println("<input name=lbackdropuri onchange=\"fview(this);\"  type=file size=40 >");
}
if(obj.getLbackdropuri()!=null&&obj.getLbackdropuri().length()>0)
{
  out.print("<A href=ItemDownload.jsp?act=lbackdropuri&item="+item+" >"+obj.getLbackdropname()+"</A>");
}
%>
<a id="a_lbackdropuri" href="###" style="display:none" ><img id="img_lbackdropuri" align=absmiddle onerror="if(this.src.indexOf('defaut.gif')==-1)this.src='/tea/image/other/defaut.gif';" src=""/><span id="span_lbackdropuri"></span></a>
              </TD>
                </tr>

      <tr>
         <td>征求意见汇总处理表</td>
         <td nowrap><input name="lweaveuri" type="file" onChange="fview(this);" size="40"  id="lweaveuri">
           <%
         if(obj.getLweaveuri()!=null&&obj.getLweaveuri().length()>0)
         {
           out.print("<A href=ItemDownload.jsp?act=lweaveuri&item="+item+" >"+obj.getLweavename()+"</A>");
         }
         %>
         <a id="a_lweaveuri" href="###" style="display:none" ><img id="img_lweaveuri" align=absmiddle onerror="if(this.src.indexOf('defaut.gif')==-1)this.src='/tea/image/other/defaut.gif';" src=""/><span id="span_lweaveuri"></span></a>
         </td>
       </tr>

       <tr>
         <td>&nbsp;</td>
         <td nowrap>
         <%
         if(obj.getLeveluri()==null||obj.getLeveluri().length()==0||obj.getLexplainuri()==null||obj.getLexplainuri().length()==0||obj.getLbackdropuri()==null||obj.getLbackdropuri().length()==0||(obj.getLeveltime()!=null&&(!obj.isLevelauditing()||!obj.isLexplainauditing()||!obj.isLbackdropauditing())))
         {
           out.print("<input type=submit value=提交 > <input type=reset value=重置 onClick=\"defaultfocus();\">");
         }%>
           <input type="button" value="返回" onClick="history.back();"/>
         </td>
       </tr>
  </table>
</form>
<h2>项目管理员下达</h2>
 <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
	    <tr>
         <td>报批稿</td>
         <td nowrap>
<%if(obj.getLeveltime()==null)out.print("未审核");else out.print(obj.isLevelauditing()?"批准":"返回修改");%>
            </td>
       </tr>
	    <tr>
         <td>报批稿编制说明</td>
         <td nowrap>
<%if(obj.getLeveltime()==null)out.print("未审核");else out.print(obj.isLexplainauditing()?"批准":"返回修改");%>
    </td>
       </tr>	    <tr>
         <td>报批稿技术背景研究报告</td>
         <td nowrap>
         <%if(obj.getLeveltime()==null)out.print("未审核");else out.print(obj.isLbackdropauditing()?"批准":"返回修改");%>
      </td>
       </tr>
       <tr>
         <td>征求意见汇总处理表</td>
         <td nowrap>
         <%if(obj.getLeveltime()==null)out.print("未审核");else out.print(obj.isLweaveauditing()?"批准":"返回修改");%>
      </td>
       </tr>
<%--
       <tr>
         <td>标准编制工作报告</td>
         <td nowrap><%
         if(obj.getLweaveuri()!=null&&obj.getLweaveuri().length()>0)
         {
           out.print("<A href=ItemDownload.jsp?act=lweaveuri&item="+item+" >"+obj.getLweavename()+"</A>");
         }
         %></td>
       </tr>
--%>
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
<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>

