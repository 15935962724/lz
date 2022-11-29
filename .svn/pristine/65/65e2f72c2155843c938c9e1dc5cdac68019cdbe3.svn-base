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
  if(form1.ideauri)
  form1.ideauri.focus();
}
</script>
</head>
<body onLoad="defaultfocus();">

<h1>征求意见阶段</h1>
<br>
<div id="head6"><img height="6" src="about:blank"></div>
<br/>
<h2>编制组上报</h2>
<form action="/servlet/EditItem" method="post" enctype="multipart/form-data" name="form1" >
<input type=hidden name="act" value="idea"/>
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
         <td>征求意见稿</td>
         <td nowrap>
         <%
         if(obj.getIdeauri()==null||obj.getIdeauri().length()==0||(obj.getIdeatime()!=null&&!obj.isIdeaauditing()))
         {
           out.println("<input name=ideauri onchange=\"fview(this);\" type=file size=40 >");
         }
         if(obj.getIdeauri()!=null&&obj.getIdeauri().length()>0)
         {
           out.print("<A href=ItemDownload.jsp?act=ideauri&item="+item+" >"+obj.getIdeaname()+"</A>");
         }
         %>
         <a id="a_ideauri" href="###" style="display:none" ><img id="img_ideauri" align=absmiddle onerror="if(this.src.indexOf('defaut.gif')==-1)this.src='/tea/image/other/defaut.gif';" src=""/><span id="span_ideauri"></span></a>
		 </td>
       </tr>

	        <tr>
	          <td>征求意见稿编制说明</td>
              <TD>
                       <%
         if(obj.getExplainuri()==null||obj.getExplainuri().length()==0||(obj.getIdeatime()!=null&&!obj.isExplainauditing()))
         {
           out.println("<input name=explainuri onchange=\"fview(this);\"  type=file size=40 >");
         }
         if(obj.getExplainuri()!=null&&obj.getExplainuri().length()>0)
         {
           out.print("<A href=ItemDownload.jsp?act=explainuri&item="+item+" >"+obj.getExplainname()+"</A>");
         }
         %>
         <a id="a_explainuri" href="###" style="display:none" ><img id="img_explainuri" align=absmiddle onerror="if(this.src.indexOf('defaut.gif')==-1)this.src='/tea/image/other/defaut.gif';" src=""/><span id="span_explainuri"></span></a>

              </TD>
</tr>

	        <tr>
	          <td>技术背景研究报告</td>
              <TD>
                       <%
                       if(obj.getBackdropuri()==null||obj.getBackdropuri().length()==0||(obj.getIdeatime()!=null&&!obj.isBackdropauditing()))
                       {
                         out.println("<input name=backdropuri onchange=\"fview(this);\"  type=file size=40 >");
                       }
                       if(obj.getBackdropuri()!=null&&obj.getBackdropuri().length()>0)
                       {
                         out.print("<A href=ItemDownload.jsp?act=backdropuri&item="+item+" >"+obj.getBackdropname()+"</A>");
                       }
         %>
         <a id="a_backdropuri" href="###" style="display:none" ><img id="img_backdropuri" align=absmiddle onerror="if(this.src.indexOf('defaut.gif')==-1)this.src='/tea/image/other/defaut.gif';" src=""/><span id="span_backdropuri"></span></a>

              </TD>
</tr>
       <tr>
         <td>&nbsp;</td>
         <td nowrap>
         <%
         if(obj.getIdeauri()==null||obj.getIdeauri().length()==0||obj.getExplainuri()==null||obj.getExplainuri().length()==0||obj.getBackdropuri()==null||obj.getBackdropuri().length()==0||(obj.getIdeatime()!=null&&(!obj.isIdeaauditing()||!obj.isExplainauditing()||!obj.isBackdropauditing())))
         {
           out.print("<input type=submit value=提交 > <input type=reset value=重置 onClick=\"defaultfocus();\">");
         }
         %>
         <input type="button" value="返回" onClick="history.back();"/>
         </td>
       </tr>
  </table>
</form>
<h2>项目管理员下达</h2>
 <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
 <tr>
         <td>征求意见稿</td>
         <td nowrap>
        <%if(obj.getIdeatime()==null)out.print("未审核 ");else if(obj.isIdeaauditing())out.print("批准 ");else out.print("返回修改 ");%>
		 </td>
   </tr>

	        <tr>
	          <td>征求意见稿编制说明</td>
              <TD><%if(obj.getIdeatime()==null)out.print("未审核 ");else if(obj.isExplainauditing())out.print("批准 ");else out.print("返回修改 ");%>

              </TD>
</tr>

	        <tr style="display:none">
	          <td>技术背景研究报告</td>
              <TD><%if(obj.getIdeatime()==null)out.print("未审核 ");else if(obj.isBackdropauditing())out.print("批准 ");else out.print("返回修改 ");%>
              </TD>
</tr>
       <tr>
         <td>征求意见通知-征求意见</td>
         <td nowrap>
         <%
         if(obj.getIdeainformuri()!=null&&obj.getIdeainformuri().length()>0)
         {
           out.print("<A href=ItemDownload.jsp?act=ideainformuri&item="+item+" >"+obj.getIdeainformname()+"</A>");
         }
         %>		&nbsp; </td>
       </tr>
                    <tr>
         <td>征求意见通知-征求单位</td>
         <td nowrap>
         <%
         if(obj.getIdeainform2uri()!=null&&obj.getIdeainform2uri().length()>0)
         {
           out.print("<A href=ItemDownload.jsp?act=ideainform2uri&item="+item+" >"+obj.getIdeainform2name()+"</A>");
         }
         %>		&nbsp; </td>
       </tr>
<%--
       <tr>
         <td>意见反馈汇总表</td>
         <td nowrap>
         <%
         if(obj.getFeedbackuri()!=null&&obj.getFeedbackuri().length()>0)
         {
           out.print("<A href=ItemDownload.jsp?act=feedbackuri&item="+item+" >"+obj.getFeedbackname()+"</A>");
         }
         %>
         </td>
       </tr>
--%>
</table>
<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>

