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
  form1.reviewcomments.focus();
  fclick();
}
function fclick()
{
 form1.ideainformuri.disabled=form1.ideainform2uri.disabled=form1.ideaauditing[1].checked||form1.explainauditing[1].checked;
}

</script>
</head>
<body onLoad="defaultfocus();">

<h1>征求意见阶段</h1>
<br>
<div id="head6"><img height="6" src="about:blank"></div>
<br/>
<h2>编制组上报</h2>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
       <tr>
         <td>征求意见稿</td>
         <td nowrap><%
         boolean _bIdeauriExists=obj.getIdeauri()!=null&&obj.getIdeauri().length()>0;
         if(_bIdeauriExists)
         {
           out.print("<A href=ItemDownload.jsp?act=ideauri&item="+item+" >"+obj.getIdeaname()+"</A>　");

           java.io.File file=new java.io.File(application.getRealPath(obj.getIdeauri()));
           if(obj.getIdeatime()==null||obj.getIdeatime().getTime()-file.lastModified() <1)
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
	          <td>征求意见稿编制说明</td>
              <TD><%
              boolean _bExplainuriExists=(obj.getExplainuri()!=null&&obj.getExplainuri().length()>0);
         if(_bExplainuriExists)
         {
           out.print("<A href=ItemDownload.jsp?act=explainuri&item="+item+" >"+obj.getExplainname()+"</A>　");


           java.io.File file=new java.io.File(application.getRealPath(obj.getExplainuri()));
           if(obj.getIdeatime()==null||obj.getIdeatime().getTime()-file.lastModified() <1)
           {
             out.print("<font color=#FF0000>未审核</font>");
           }else
           {
             out.print("<font color=#FF0000>已审核</font>");
           }
         }
         %>              </TD>
</tr>

<tr><td>技术背景研究报告</td><TD>
<%
if(obj.getBackdropuri()!=null&&obj.getBackdropuri().length()>0)
{
  out.print("<A href=ItemDownload.jsp?act=backdropuri&item="+item+" >"+obj.getBackdropname()+"</A>");
}
%></TD></tr>
  </table>

<h2>项目管理员下达</h2>
<form action="/servlet/EditItem" method="post" enctype="multipart/form-data" name="form1" >
<input type=hidden name="act" value="ideaauditing"/>
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
        <input onClick="fclick();" name="ideaauditing" type="radio" value="true"  <%if(obj.isIdeaauditing())out.print(" checked "); else if(!_bIdeauriExists)out.print(" onmouseup=\"f_force_grant(this);\" "); %> >批准
        <input onClick="fclick();" name="ideaauditing" type="radio" value="false" <%if((obj.getIdeainformuri()!=null&&obj.getIdeainformuri().length()>0)||(obj.getIdeainform2uri()!=null&&obj.getIdeainform2uri().length()>0))out.print(" disabled ");else if(!obj.isIdeaauditing())out.print(" checked ");else out.print(" onmouseup=\"f_force_deny(this);\" ");%>>返回修改			    </td>
       </tr>

	        <tr>
	          <td>征求意见稿编制说明</td>
              <TD>
<input onClick="fclick();" name="explainauditing" type="radio" value="true" <%if(obj.isExplainauditing())out.print(" checked "); else if(!_bExplainuriExists)out.print(" onmouseup=\"f_force_grant(this);\" ");%> >批准
<input onClick="fclick();" name="explainauditing" type="radio" value="false" <%if((obj.getIdeainformuri()!=null&&obj.getIdeainformuri().length()>0)||(obj.getIdeainform2uri()!=null&&obj.getIdeainform2uri().length()>0))out.print(" disabled ");else if(!obj.isExplainauditing())out.print(" checked ");else out.print(" onmouseup=\"f_force_deny(this);\" ");%>>返回修改              </TD>
</tr>

<tr style="display:none"><td>技术背景研究报告</td><TD>
<input onClick="fclick();" name="backdropauditing" type="radio" value="true" checked>批准
<input onClick="fclick();" name="backdropauditing" type="radio" value="false" <%//if(!obj.isBackdropauditing())out.print(" checked ");%>>返回修改
</TD></tr>

<tr>
  <td>审查意见</td>
  <td nowrap><input name="reviewcomments" type="file" size="40" >
           <%
         if(obj.getAreporturi_4()!=null&&obj.getAreporturi_4().length()>0)
         {
           out.print("<A href=ItemDownload.jsp?act=areporturi_4&item="+item+" >"+obj.getAreportname_4()+"</A>");
         }
         %>
  </td>
       </tr>
	    <tr>
         <td>附言</td>
         <td nowrap>
  <textarea cols="30" name="reviewcommentstext" rows="3"></textarea></td>
</tr>
       <tr>
         <td>征求意见通知-征求意见</td>
         <td nowrap>
           <input name="ideainformuri" onChange="fview(this);" type="file" size="40">
         <%
         if(obj.getIdeainformuri()!=null&&obj.getIdeainformuri().length()>0)
         {
           out.print("<A href=ItemDownload.jsp?act=ideainformuri&item="+item+" >"+obj.getIdeainformname()+"</A>");
         }
         %>
         <a id="a_ideainformuri" href="#" style="display:none" ><img id="img_ideainformuri" align=absmiddle onerror="if(this.src.indexOf('defaut.gif')==-1)this.src='/tea/image/other/defaut.gif';" src=""/><span id="span_ideainformuri"></span></a>         </td>
       </tr>
              <tr>
         <td>征求意见通知-征求单位</td>
         <td nowrap>
           <input name="ideainform2uri" onChange="fview(this);"  type="file" size="40" >
         <%
         if(obj.getIdeainform2uri()!=null&&obj.getIdeainform2uri().length()>0)
         {
           out.print("<A href=ItemDownload.jsp?act=ideainform2uri&item="+item+" >"+obj.getIdeainform2name()+"</A>");
         }
         %>
         <a id="a_ideainform2uri" href="#" style="display:none" ><img id="img_ideainform2uri" align=absmiddle onerror="if(this.src.indexOf('defaut.gif')==-1)this.src='/tea/image/other/defaut.gif';" src=""/><span id="span_ideainform2uri"></span></a>         </td>
       </tr>
<%--
       <tr>
         <td>意见反馈汇总表</td>
         <td nowrap>
           <input name="feedbackuri"  onChange="fview(this);" type="file" size="40" >
         <%
         if(obj.getFeedbackuri()!=null&&obj.getFeedbackuri().length()>0)
         {
           out.print("<A href=ItemDownload.jsp?act=feedbackuri&item="+item+" >"+obj.getFeedbackname()+"</A>");
         }
         %>
         <a id="a_feedbackuri" href="#" style="display:none" ><img id="img_feedbackuri" align=absmiddle onerror="if(this.src.indexOf('defaut.gif')==-1)this.src='/tea/image/other/defaut.gif';" src=""/><span id="span_feedbackuri"></span></a>         </td>
       </tr>
--%>
          <tr>
         <td>&nbsp;</td>
         <td nowrap>
           <input type="submit" name="Submit" value="提交">
           <input name="next" type="submit" id="next" value="转下阶段">
           <input type="reset" name="Submit2" value="重置" onClick="defaultfocus();">
           <input type="button" value="返回" onClick="history.back();"/>         </td>
       </tr>
  </table>
</form>
<br>
<div id="head6"><img height="6" src="about:blank"></div>
<%--
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr><td>注:</td></tr>
<tr><td>1.审核和征求意见是两个过程，不能在审核阶段，发送征求意见通知；同时，不能在发征求意见通知后，再对审核进行操作。</td></tr>
</table>
--%>
</body>
</html>

