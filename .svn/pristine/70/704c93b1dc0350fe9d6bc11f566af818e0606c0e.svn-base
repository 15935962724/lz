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
  try
  {
    form1.lsinformuri.focus();
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

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
       <tr>
         <td>报批稿</td>
         <td nowrap><%
         boolean _bLeveluriExists=(obj.getLeveluri()!=null&&obj.getLeveluri().length()>0);
         if(_bLeveluriExists)
         {
           out.print("<A href=ItemDownload.jsp?act=leveluri&item="+item+" >"+obj.getLevelname()+"</A>　");

           java.io.File file=new java.io.File(application.getRealPath(obj.getLeveluri()));
           if(obj.getLeveltime()==null||obj.getLeveltime().getTime()-file.lastModified() <1)
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
	          <td>报批稿编制说明</td>
              <TD><%
              boolean _bLexplainuriExists=(obj.getLexplainuri()!=null&&obj.getLexplainuri().length()>0);
         if(_bLexplainuriExists)
         {
           out.print("<A href=ItemDownload.jsp?act=lexplainuri&item="+item+" >"+obj.getLexplainname()+"</A>　");

           java.io.File file=new java.io.File(application.getRealPath(obj.getLexplainuri()));
           if(obj.getLeveltime()==null||obj.getLeveltime().getTime()-file.lastModified() <1)
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
  <td>报批稿技术背景研究报告</td>
  <TD><%
  boolean _bLbackdropuriExists=(obj.getLbackdropuri()!=null&&obj.getLbackdropuri().length()>0);
  if(_bLbackdropuriExists)
  {
    out.print("<A href=ItemDownload.jsp?act=lbackdropuri&item="+item+" >"+obj.getLbackdropname()+"</A>　");

    java.io.File file=new java.io.File(application.getRealPath(obj.getLbackdropuri()));
    if(obj.getLeveltime()==null||obj.getLeveltime().getTime()-file.lastModified() <1)
    {
      out.print("<font color=#FF0000>未审核</font>");
    }else
    {
      out.print("<font color=#FF0000>已审核</font>");
    }
  }
         %></TD>
</tr>
<tr>
  <td>征求意见汇总处理表</td>
  <TD><%
  boolean _bLweaveauditingExists=(obj.getLweaveuri()!=null&&obj.getLweaveuri().length()>0);
  if(_bLweaveauditingExists)
  {
    out.print("<A href=ItemDownload.jsp?act=lweaveuri&item="+item+" >"+obj.getLweavename()+"</A>　");

    java.io.File file=new java.io.File(application.getRealPath(obj.getLweaveuri()));
    if(obj.getLeveltime()==null||obj.getLeveltime().getTime()-file.lastModified() <1)
    {
      out.print("<font color=#FF0000>未审核</font>");
    }else
    {
      out.print("<font color=#FF0000>已审核</font>");
    }
  }
         %></TD>
</tr>
  </table>

<h2>项目管理员下达</h2>
<form action="/servlet/EditItem" method="post" enctype="multipart/form-data" name="form1" >
<input type=hidden name="act" value="levelauditing"/>
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
           <input name="levelauditing" type="radio" value="true"  <%if(obj.isLevelauditing())out.print(" checked "); else if(!_bLeveluriExists)out.print(" onmouseup=\"f_force_grant(this);\" ");%>>批准
           <input name="levelauditing" type="radio" value="false" <%if(!obj.isLevelauditing())out.print(" checked ");else out.print("  onmouseup=\"f_force_deny(this);\"  ");%>>返回修改
         </td>
       </tr>
       <tr>
         <td>报批稿编制说明</td>
         <td nowrap>
           <input name="lexplainauditing" type="radio" value="true" <% if(obj.isLexplainauditing())out.print(" checked "); else if(!_bLexplainuriExists)out.print(" onmouseup=\"f_force_grant(this);\" ");%>>批准
           <input name="lexplainauditing" type="radio" value="false" <%if(!obj.isLexplainauditing())out.print(" checked ");else out.print(" onmouseup=\"f_force_deny(this);\" ");%>>返回修改
         </td>
       </tr>
       <tr>
         <td>报批稿技术背景研究报告</td>
         <td nowrap>
           <input name="lbackdropauditing" type="radio" value="true" <%if(obj.isLbackdropauditing())out.print(" checked "); else if(!_bLbackdropuriExists)out.print(" onmouseup=\"f_force_grant(this);\" ");%>>批准
           <input name="lbackdropauditing" type="radio" value="false" <%if(!obj.isLbackdropauditing())out.print(" checked ");else out.print(" onmouseup=\"f_force_deny(this);\" ");%>>返回修改
         </td>
       </tr>
       <tr>
         <td>征求意见汇总处理表</td>
         <td nowrap>
           <input name="lweaveauditing" type="radio" value="true" <%if(obj.isLweaveauditing())out.print(" checked "); else if(!_bLweaveauditingExists)out.print(" onmouseup=\"f_force_grant(this);\" ");%>>批准
           <input name="lweaveauditing" type="radio" value="false" <%if(!obj.isLweaveauditing())out.print(" checked ");else out.print(" onmouseup=\"f_force_deny(this);\" ");%>>返回修改
         </td>
       </tr>
        <tr>
         <td>审查意见</td>
         <td nowrap><input type="file" size="40"  name="reviewcomments" >
         <%
         if(obj.getAreporturi_6()!=null&&obj.getAreporturi_6().length()>0)
         {
           out.print("<A href=ItemDownload.jsp?act=areporturi_6&item="+item+" >"+obj.getAreportname_6()+"</A>");
         }
         %>
  </td>
       </tr>
	    <tr>
         <td>附言</td>
         <td nowrap>
         <textarea cols="39" name="reviewcommentstext" rows="3"></textarea>        </td>
       </tr>

	        <tr>
	          <td>局长专题会议通知</td>
              <TD><input name="lsinformuri" type="file" onChange="fview(this);" size="40"  id="lsinformuri">
                <%
         if(obj.getLsinformuri()!=null&&obj.getLsinformuri().length()>0)
         {
           out.print("<A href=ItemDownload.jsp?act=lsinformuri&item="+item+" >"+obj.getLsinformname()+"</A>");
         }
         %>
         <a id="a_lsinformuri" href="###" style="display:none" ><img id="img_lsinformuri" align=absmiddle onerror="if(this.src.indexOf('defaut.gif')==-1)this.src='/tea/image/other/defaut.gif';" src=""/><span id="span_lsinformuri"></span></a>
              </TD>
</tr>

<tr>
  <td>局长专题会议纪要</td>
  <TD><input name="lssummaryuri" type="file" onChange="fview(this);"  size="40"  id="lssummaryuri">
  <%
  if(obj.getLssummaryuri()!=null&&obj.getLssummaryuri().length()>0)
  {
    out.print("<A href=ItemDownload.jsp?act=lssummaryuri&item="+item+" >"+obj.getLssummaryname()+"</A>");
  }
  %>
  <a id="a_lssummaryuri" href="###" style="display:none" ><img id="img_lssummaryuri" align=absmiddle onerror="if(this.src.indexOf('defaut.gif')==-1)this.src='/tea/image/other/defaut.gif';" src=""/><span id="span_lssummaryuri"></span></a>
  </TD>
</tr>
	        <tr>
	          <td>总局局务会议通知</td>
              <TD><input name="lginformuri" type="file"  onChange="fview(this);" size="40"  id="lginformuri">
                <%
         if(obj.getLginformuri()!=null&&obj.getLginformuri().length()>0)
         {
           out.print("<A href=ItemDownload.jsp?act=lginformuri&item="+item+" >"+obj.getLginformname()+"</A>");
         }
         %>
         <a id="a_lginformuri" href="###" style="display:none" ><img id="img_lginformuri" align=absmiddle onerror="if(this.src.indexOf('defaut.gif')==-1)this.src='/tea/image/other/defaut.gif';" src=""/><span id="span_lginformuri"></span></a>
              </TD>
</tr>
       <tr>
         <td>总局局务会议纪要</td>
         <td nowrap>
<input name="lgsummaryuri" type="file"  onChange="fview(this);"  size="40"  id="lgsummaryuri">
         <%
         if(obj.getLgsummaryuri()!=null&&obj.getLgsummaryuri().length()>0)
         {
           out.print("<A href=ItemDownload.jsp?act=lgsummaryuri&item="+item+" >"+obj.getLgsummaryname()+"</A>");
         }
         %>
         <a id="a_lgsummaryuri" href="###" style="display:none" ><img id="img_lgsummaryuri" align=absmiddle onerror="if(this.src.indexOf('defaut.gif')==-1)this.src='/tea/image/other/defaut.gif';" src=""/><span id="span_lgsummaryuri"></span></a>
         </td>
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
<br />
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr><td>注:</td></tr>
<tr><td>1.技术背景研究报告不是必须上报，因此也不用必须审核通过.</td></tr>
</table>
</body>
</html>

