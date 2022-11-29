<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page import="tea.resource.Resource" %><%@ page import="tea.entity.criterion.*" %><%@ page import="tea.ui.TeaSession" %><%
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
  fclick();
}

function fclick()
{
  form1.informuri.disabled=form1.openauditing[1].checked;
}
</script>
</head>
<body onLoad="defaultfocus();">

<h1>项目开题阶段</h1>
<br>
<div id="head6"><img height="6" src="about:blank"></div>
<br/>
<h2>编制组上报</h2>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td>开题报告</td>
    <td nowrap><%
    boolean _bOpenuri=obj.getOpenuri()!=null&&obj.getOpenuri().length()>0;
    java.io.File _fOpenuri=null;
    if(_bOpenuri)
    {
      _fOpenuri=new java.io.File(application.getRealPath(obj.getOpenuri()));
      out.print("<A href=ItemDownload.jsp?act=openuri&item="+item+" >"+obj.getOpenname()+"</A>　");

      if(obj.getOpentime()==null||obj.getOpentime().getTime()-_fOpenuri.lastModified() <1)
      {
        out.print("<font color=#FF0000>未审核</font>");
      }else
      {
        out.print("<font color=#FF0000>已审核</font>");
      }
    }
    %>
    </td>
  </tr>

  <tr>
    <td>开题会议纪要</td>
    <TD><%
         boolean _bSummaryuri=obj.getSummaryuri()!=null&&obj.getSummaryuri().length()>0;

         if(_bSummaryuri)
         {
           out.print("<A href=ItemDownload.jsp?act=summaryuri&item="+item+" >"+obj.getSummaryname()+"</A>");

           java.io.File _fSummaryuri=new java.io.File(application.getRealPath(obj.getOpenuri()));
           if(obj.getOpentime()==null||obj.getOpentime().getTime()-_fSummaryuri.lastModified() <1)
           {
             out.print("<font color=#FF0000>未审核</font>");
           }else
           {
             out.print("<font color=#FF0000>已审核</font>");
           }
         }
         %>         </TD>
</tr>
  </table>

<h2>项目管理员下达</h2>
<form action="/servlet/EditItem" method="post" enctype="multipart/form-data" name="form1" >
<input type=hidden name="act" value="openauditing"/>
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
         <td>开题报告</td>
         <td nowrap>
           <input name="openauditing" type="radio" value="true" onClick="fclick();" <%if(obj.isOpenauditing())out.print(" checked "); else if(!_bOpenuri)out.print(" onmouseup=\"f_force_grant(this);\" ");%>>批准
           <input name="openauditing" type="radio" value="false" onClick="fclick();"  <%if(!obj.isOpenauditing())out.print(" checked ");else out.print(" onmouseup=\"f_force_deny(this);\" ");%>>返回修改
         </td>
       </tr>
	   <tr>
         <td>审查意见</td>
         <td nowrap><input type="file" size="40"  name="reviewcomments" >
         <%
         if(obj.getAreporturi_3()!=null&&obj.getAreporturi_3().length()>0)
         {
           out.print("<A href=ItemDownload.jsp?act=areporturi_3&item="+item+" >"+obj.getAreportname_3()+"</A>");
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
       <tr>
         <td>开题会议通知</td>
         <td nowrap><input name="informuri"  type="file" size="40" onChange="fview(this);"  id="informuri" <%if(obj.getOpenuri()==null||obj.getOpenuri().length()==0)out.print("disabled");%>>
         <%
         if(obj.getInformuri()!=null&&obj.getInformuri().length()>0)
         {
           out.print("<A href=ItemDownload.jsp?act=informuri&item="+item+" >"+obj.getInformname()+"</A>");
         }
         %>
         <a id="a_informuri" href="###" style="display:none" ><img id="img_informuri" align=absmiddle onerror="if(this.src.indexOf('defaut.gif')==-1)this.src='/tea/image/other/defaut.gif';" src=""/><span id="span_informuri"></span></a>
         </td>
       </tr>
       <tr>
         <td>开题会议纪要</td>
         <td nowrap>
           <input name="summaryauditing" type="radio" value="true" onClick="fclick();" <%if(obj.isSummaryauditing())out.print(" checked "); else if(!_bSummaryuri)out.print(" onmouseup=\"f_force_grant(this);\" ");%>>批准
           <input name="summaryauditing" type="radio" value="false" onClick="fclick();"  <%if(!obj.isSummaryauditing())out.print(" checked ");else out.print(" onmouseup=\"f_force_deny(this);\" ");%>>返回修改
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
<br>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr>
<td>注:</td>
</tr>
<tr><td>1.编制组还未传开题报告，<%=Item.ROLE_PRINCIPAL%>就不能发开题会议通知。</td>
</tr>
</table>
</body>
</html>

