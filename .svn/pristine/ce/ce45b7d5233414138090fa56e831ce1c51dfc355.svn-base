<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page import="tea.resource.Resource" %><%@ page import="tea.entity.criterion.Item" %><%@ page import="tea.ui.TeaSession" %><%
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
  if(form1.formulatinguri)
  form1.formulatinguri.focus();
}


</script>
</head>
<body onLoad="defaultfocus();">

<h1>送审阶段</h1>
<br>
<div id="head6"><img height="6" src="about:blank"></div>
<br/>
<h2>编制组上报</h2>
<form action="/servlet/EditItem" method="post" enctype="multipart/form-data" name="form1" >
<input type=hidden name="act" value="formulating"/>
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
         <td>标准送审稿</td>
         <td nowrap>
         <%
         if(obj.getFormulatinguri()==null||obj.getFormulatinguri().length()==0||(obj.getFormulatingtime()!=null&&!obj.isFormulatingauditing()))
         {
           out.println("<input name=formulatinguri onchange=\"fview(this);\"  type=file size=40 >");
         }
         if(obj.getFormulatinguri()!=null&&obj.getFormulatinguri().length()>0)
         {
           out.print("<A href=ItemDownload.jsp?act=formulatinguri&item="+item+" >"+obj.getFormulatingname()+"</A>");
         }
         %>
         <a id="a_formulatinguri" href="###" style="display:none" ><img id="img_formulatinguri" align=absmiddle onerror="if(this.src.indexOf('defaut.gif')==-1)this.src='/tea/image/other/defaut.gif';" src=""/><span id="span_formulatinguri"></span></a>
		 </td>
       </tr>

	        <tr>
	          <td>送审稿编制说明</td>
              <TD>
                       <%
         if(obj.getFexplainuri()==null||obj.getFexplainuri().length()==0||(obj.getFormulatingtime()!=null&&!obj.isFexplainauditing()))
         {
           out.println("<input name=fexplainuri onchange=\"fview(this);\"  type=file size=40 >");
         }
         if(obj.getFexplainuri()!=null&&obj.getFexplainuri().length()>0)
         {
           out.print("<A href=ItemDownload.jsp?act=fexplainuri&item="+item+" >"+obj.getFexplainname()+"</A>");
         }
         %>
                    <a id="a_fexplainuri" href="###" style="display:none" ><img id="img_fexplainuri" align=absmiddle onerror="if(this.src.indexOf('defaut.gif')==-1)this.src='/tea/image/other/defaut.gif';" src=""/><span id="span_fexplainuri"></span></a>
              </TD>
</tr>

	        <tr>
	          <td>征求意见汇总处理表</td>
              <TD>
              <%
              if(obj.getFideauri()==null||obj.getFideauri().length()==0||(obj.getFormulatingtime()!=null&&!obj.isFideaauditing()))
              {
                out.println("<input name=fideauri onchange=\"fview(this);\"  type=file size=40 >");
              }
         if(obj.getFideauri()!=null&&obj.getFideauri().length()>0)
         {
           out.print("<A href=ItemDownload.jsp?act=fideauri&item="+item+" >"+obj.getFideaname()+"</A>");
         }
         %>
           <a id="a_fideauri" href="###" style="display:none" ><img id="img_fideauri" align=absmiddle onerror="if(this.src.indexOf('defaut.gif')==-1)this.src='/tea/image/other/defaut.gif';" src=""/><span id="span_fideauri"></span></a>
              </TD>
</tr>
<tr>
  <td>技术背景研究报告</td>
  <TD>
  <%
  if(obj.getFbackdropuri()==null||obj.getFbackdropuri().length()==0||(obj.getFormulatingtime()!=null&&!obj.isFbackdropauditing()))
  {
    out.println("<input name=fbackdropuri onchange=\"fview(this);\"  type=file size=40 >");
  }
  if(obj.getFbackdropuri()!=null&&obj.getFbackdropuri().length()>0)
  {
    out.print("<A href=ItemDownload.jsp?act=fbackdropuri&item="+item+" >"+obj.getFbackdropname()+"</A>");
  }
  %>
  <a id="a_fbackdropuri" href="###" style="display:none" ><img id="img_fbackdropuri" align=absmiddle onerror="if(this.src.indexOf('defaut.gif')==-1)this.src='/tea/image/other/defaut.gif';" src=""/><span id="span_fbackdropuri"></span></a>
  </TD>
</tr>

<tr>
	          <td>送审会会议纪要</td>
              <TD>
                       <%
                       if(obj.getFsummaryuri()==null||obj.getFsummaryuri().length()==0||(obj.getFormulatingtime()!=null&&!obj.isFsummaryauditing()))
                       {
                         out.println("<input name=fsummaryuri onchange=\"fview(this);\"  type=file size=40 >");
                       }
         if(obj.getFsummaryuri()!=null&&obj.getFsummaryuri().length()>0)
         {
           out.print("<A href=ItemDownload.jsp?act=fsummaryuri&item="+item+" >"+obj.getFsummaryname()+"</A>");
         }
         %>
                  <a id="a_fsummaryuri" href="###" style="display:none" ><img id="img_fsummaryuri" align=absmiddle onerror="if(this.src.indexOf('defaut.gif')==-1)this.src='/tea/image/other/defaut.gif';" src=""/><span id="span_fsummaryuri"></span></a>
              </TD>
</tr>
       <tr>
         <td>&nbsp;</td>
         <td nowrap>
                  <%
         if(obj.getFormulatinguri()==null||obj.getFormulatinguri().length()==0||obj.getFexplainuri()==null||obj.getFexplainuri().length()==0||obj.getFideauri()==null||obj.getFideauri().length()==0||obj.getFbackdropuri()==null||obj.getFbackdropuri().length()==0||obj.getFsummaryuri()==null||obj.getFsummaryuri().length()==0||(obj.getFormulatingtime()!=null&&(!obj.isFormulatingauditing()||!obj.isFexplainauditing()||!obj.isFideaauditing()||!obj.isFbackdropauditing()||!obj.isFsummaryauditing())))
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
         <td>标准送审稿</td>
         <td nowrap>
        <%if(obj.getFormulatingtime()==null)out.println("未审核 ");else if(obj.isFormulatingauditing())out.print("批准 ");else out.print("返回修改 ");%>
		 </td>
   </tr>

	        <tr>
	          <td>送审稿编制说明</td>
              <TD><%if(obj.getFormulatingtime()==null)out.println("未审核 ");else if(obj.isFexplainauditing())out.print("批准 ");else out.print("返回修改 ");%>

              </TD>
</tr>

	        <tr>
	          <td>征求意见汇总处理表</td>
              <TD><%if(obj.getFormulatingtime()==null)out.println("未审核 ");else if(obj.isFideaauditing())out.print("批准 ");else out.print("返回修改 ");%>
              </TD>
</tr>
<tr style="display:none">
         <td>技术背景研究报告</td>
         <td nowrap><%if(obj.getFormulatingtime()==null)out.println("未审核 ");else if(obj.isFbackdropauditing())out.print("批准 ");else out.print("返回修改 ");%> </td>
       </tr>
       <tr>
         <td>送审会通知<!--征求意见--></td>
         <td nowrap>
         <%
         if(obj.getFinformuri()!=null&&obj.getFinformuri().length()>0)
         {
           out.print("<A href=ItemDownload.jsp?act=finformuri&item="+item+" >"+obj.getFinformname()+"</A>");
         }
         %>		&nbsp; </td>
         </tr>
<%--
         <tr>
           <td>送审会通知-征求单位</td>
           <td nowrap>
           <%
           if(obj.getFinform2uri()!=null&&obj.getFinform2uri().length()>0)
           {
             out.print("<A href=ItemDownload.jsp?act=finform2uri&item="+item+" >"+obj.getFinform2name()+"</A>");
           }
           %>		&nbsp; </td>
           </tr>
--%>
       <tr>
         <td>送审会会议纪要</td>
         <td nowrap>
           <%if(obj.getFormulatingtime()==null)out.println("未审核 ");else if(obj.isFsummaryauditing())out.print("批准 ");else out.print("返回修改 ");%>
           &nbsp;
         </td>
       </tr>

  </table>
<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>

