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




%><html>
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
  form1.reviewcomments.focus();
}
</script>
</head>
<body onLoad="defaultfocus();">

<h1>送审阶段</h1>
<br>
<div id="head6"><img height="6" src="about:blank"></div>
<br/>
<h2>编制组上报</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
       <tr>
         <td>标准送审稿</td>
         <td nowrap><%
         boolean _bFormulatinguriExists=(obj.getFormulatinguri()!=null&&obj.getFormulatinguri().length()>0);
         if(_bFormulatinguriExists)
         {
           out.print("<A href=ItemDownload.jsp?act=formulatinguri&item="+item+" >"+obj.getFormulatingname()+"</A>　");

           java.io.File file=new java.io.File(application.getRealPath(obj.getFormulatinguri()));
           if(obj.getFormulatingtime()==null||obj.getFormulatingtime().getTime()-file.lastModified() <1)
           {
             out.print("<font color=#FF0000>未审核</font>");
           }else
           {
             out.print("<font color=#FF0000>已审核</font>");
           }
         }
         %>		 </td>
       </tr>

	        <tr>
	          <td>送审稿编制说明</td>
              <TD><%
               boolean _bFexplainuriExists=(obj.getFexplainuri()!=null&&obj.getFexplainuri().length()>0);
         if(_bFexplainuriExists)
         {
           out.print("<A href=ItemDownload.jsp?act=fexplainuri&item="+item+" >"+obj.getFexplainname()+"</A>　");

           java.io.File file=new java.io.File(application.getRealPath(obj.getFexplainuri()));
           if(obj.getFormulatingtime()==null||obj.getFormulatingtime().getTime()-file.lastModified() <1)
           {
             out.print("<font color=#FF0000>未审核</font>");
           }else
           {
             out.print("<font color=#FF0000>已审核</font>");
           }
         }
         %>              </TD>
</tr>

	        <tr>
	          <td>征求意见汇总处理表</td>
              <TD><%
              boolean _bFideauriExists=(obj.getFideauri()!=null&&obj.getFideauri().length()>0);
         if(_bFideauriExists)
         {
           out.print("<A href=ItemDownload.jsp?act=fideauri&item="+item+" >"+obj.getFideaname()+"</A>　");

           java.io.File file=new java.io.File(application.getRealPath(obj.getFideauri()));
           if(obj.getFormulatingtime()==null||obj.getFormulatingtime().getTime()-file.lastModified() <1)
           {
             out.print("<font color=#FF0000>未审核</font>");
           }else
           {
             out.print("<font color=#FF0000>已审核</font>");
           }
         }
         %>              </TD>
</tr>
 <tr>
	          <td>技术背景研究报告</td>
              <TD><%
              boolean _bFbackdropuriExists=(obj.getFbackdropuri()!=null&&obj.getFbackdropuri().length()>0);
         if(_bFbackdropuriExists)
         {
           out.print("<A href=ItemDownload.jsp?act=fbackdropuri&item="+item+" >"+obj.getFbackdropname()+"</A>");
         }
         %>              </TD>
</tr>
<tr>
	          <td>送审会会议纪要</td>
              <TD><%
              boolean _bFsummaryuriExists=(obj.getFsummaryuri()!=null&&obj.getFsummaryuri().length()>0);
         if(_bFsummaryuriExists)
         {
           out.print("<A href=ItemDownload.jsp?act=fsummaryuri&item="+item+" >"+obj.getFsummaryname()+"</A>　");

           java.io.File file=new java.io.File(application.getRealPath(obj.getFsummaryuri()));
           if(obj.getFormulatingtime()==null||obj.getFormulatingtime().getTime()-file.lastModified() <1)
           {
             out.print("<font color=#FF0000>未审核</font>");
           }else
           {
             out.print("<font color=#FF0000>已审核</font>");
           }
         }
         %>              </TD>
</tr>
  </table>
<h2>项目管理员下达</h2>
<form action="/servlet/EditItem" method="post" enctype="multipart/form-data" name="form1" >
<input type=hidden name="act" value="formulatingauditing"/>
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
        <input name="formulatingauditing" type="radio" value="true"   <%if(obj.isFormulatingauditing())out.print(" checked "); else if(!_bFormulatinguriExists)out.print(" onmouseup=\"f_force_grant(this);\" ");%> >批准
        <input name="formulatingauditing" type="radio" value="false" <%if(!obj.isFormulatingauditing())out.print(" checked ");else out.print(" onmouseup=\"f_force_deny(this);\" ");%>>返回修改
</td>
   </tr>

	        <tr>
	          <td>送审稿编制说明</td>
              <TD>
                <input name="fexplainauditing" type="radio" value="true"   <%if(obj.isFexplainauditing())out.print(" checked "); else if(!_bFexplainuriExists)out.print(" onmouseup=\"f_force_grant(this);\" ");%> >批准
                <input name="fexplainauditing" type="radio" value="false" <%if(!obj.isFexplainauditing())out.print(" checked ");else out.print(" onmouseup=\"f_force_deny(this);\" ");%>>返回修改

              </TD>
</tr>

	        <tr>
	          <td>征求意见汇总处理表</td>
              <TD>
			  			  <input name="fideaauditing" type="radio" value="true" <%if(obj.isFideaauditing())out.print(" checked "); else if(!_bFideauriExists)out.print(" onmouseup=\"f_force_grant(this);\" ");%>>批准
			  			  <input name="fideaauditing" type="radio" value="false" <%if(!obj.isFideaauditing())out.print(" checked ");else out.print(" onmouseup=\"f_force_deny(this);\" ");%>>返回修改
              </TD>
</tr>
	<tr>
         <td>审查意见</td>
         <td nowrap><input name="reviewcomments" type="file" size="40" >
         <%
         if(obj.getAreporturi_5()!=null&&obj.getAreporturi_5().length()>0)
         {
           out.print("<A href=ItemDownload.jsp?act=areporturi_5&item="+item+" >"+obj.getAreportname_5()+"</A>");
         }
         %>
  </td>
       </tr>
	    <tr>
         <td>附言</td>
         <td nowrap>
         <textarea cols="30" name="reviewcommentstext" rows="3"></textarea>
         </td>
       </tr>

<tr style="display:none">
         <td>技术背景研究报告</td>
         <td nowrap>
<input name="fbackdropauditing" type="radio" value="true" checked>批准
<input name="fbackdropauditing" type="radio" value="false" <%//if(!obj.isFbackdropauditing())out.print(" checked ");%>>返回修改
</td>
    </tr>
       <tr>
         <td>送审会通知<!--征求意见--></td>
         <td nowrap><input name="finformuri" onChange="fview(this);" type="file" size="40">
        <%
         if(obj.getFinformuri()!=null&&obj.getFinformuri().length()>0)
         {
           out.print("<A href=ItemDownload.jsp?act=finformuri&item="+item+" >"+obj.getFinformname()+"</A>");
         }
         %>
         <a id="a_finformuri" href="###" style="display:none" ><img id="img_finformuri" align=absmiddle onerror="if(this.src.indexOf('defaut.gif')==-1)this.src='/tea/image/other/defaut.gif';" src=""/><span id="span_finformuri"></span></a>
         </td>
       </tr>
<%--              <tr>
         <td>送审会通知-征求单位</td>
         <td nowrap><input name="finform2uri" onChange="fview(this);" type="file" size="40">
        <%
         if(obj.getFinform2uri()!=null&&obj.getFinform2uri().length()>0)
         {
           out.print("<A href=ItemDownload.jsp?act=finform2uri&item="+item+" >"+obj.getFinform2name()+"</A>");
         }
         %>
         <a id="a_finform2uri" href="###" style="display:none" ><img id="img_finform2uri" align=absmiddle onerror="if(this.src.indexOf('defaut.gif')==-1)this.src='/tea/image/other/defaut.gif';" src=""/><span id="span_finform2uri"></span></a>

         </td>
       </tr>
--%>
       <tr>
         <td>送审会会议纪要</td>
         <td nowrap>
           <input name="fsummaryauditing" type="radio" value="true" <%if(obj.isFsummaryauditing())out.print(" checked "); else if(!_bFsummaryuriExists)out.print(" onmouseup=\"f_force_grant(this);\" ");%> >批准
<input name="fsummaryauditing" type="radio" value="false" <%if(!obj.isFsummaryauditing())out.print(" checked ");else out.print("  onmouseup=\"f_force_deny(this);\"  ");%>>返回修改</td>
       </tr>

          <tr>
         <td>&nbsp;</td>
         <td nowrap>
           <input type="submit" name="Submit" value="提交">
		   <input name="next" type="submit" id="next" value="转下阶段">
           <input type="reset" name="Submit2" value="重置" onClick="defaultfocus();">
           <input type="button" value="返回" onClick="history.back();"/>
         </td>
       </tr>
  </table>
</form>
<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>

