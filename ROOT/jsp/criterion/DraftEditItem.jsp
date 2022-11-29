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
    form1.drafturl.focus();
  }catch(e)
  {}
}
</script>
</head>
<body onLoad="defaultfocus();">

<h1>项目起草阶段</h1>
<br>
<div id="head6"><img height="6" src="about:blank"></div>
<br/>
<h2>编制组上报</h2>
<form action="/servlet/EditItem" method="post" enctype="multipart/form-data" name="form1" >
<input type=hidden name="act" value="draft"/>
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
         <td>起草阶段文档</td>
         <td nowrap>
         <table border="0" cellpadding="0" cellspacing="0">
         <tr><td align="left">
         <%
         //if(obj.getDrafturl()==null||obj.getDrafturl().length()==0||(obj.getOpentime()!=null&&!obj.isSummaryauditing()))
         {
           out.print("<input name=drafturi  onchange=\"fview(this);\" type=file size=40  ></td><td>");
         }

         java.util.Enumeration enumer=Itemfilehistory.find(item,"drafturi");
         while(enumer.hasMoreElements())
         {
           int itemfilehistory=((Integer)enumer.nextElement()).intValue();
           Itemfilehistory history=Itemfilehistory.find(itemfilehistory);
           java.io.File file=new java.io.File(application.getRealPath(history.getUri()));
           out.print("<A href=ItemDownload.jsp?act=drafturi&item="+item+"&itemfilehistory="+itemfilehistory+" >"+history.getName()+"</A>("+obj.sdf2.format(new java.util.Date(file.lastModified()))+")<br/>");
         }
         if(obj.getDrafturi()!=null&&obj.getDrafturi().length()>0)
         {
           java.io.File file=new java.io.File(application.getRealPath(obj.getDrafturi()));
           out.print("<A href=ItemDownload.jsp?act=drafturi&item="+item+" >"+obj.getDraftname()+"</A>("+obj.sdf2.format(new java.util.Date(file.lastModified()))+") 　 </td><td><input type=\"button\" value=\"删除\" onclick=\"window.open('/jsp/criterion/DocDeleteItem.jsp?community="+community+"&item="+item+"&act=drafturi&nexturl="+java.net.URLEncoder.encode(nexturl,"UTF-8")+"','_self');\"/>");
         }
         %>
         <a id="a_drafturi" href="###" style="display:none" ><img id="img_drafturi" align=absmiddle onerror="if(this.src.indexOf('defaut.gif')==-1)this.src='/tea/image/other/defaut.gif';" src=""/><span id="span_drafturi"></span></a>

         </td>
         </tr>
         </table>

         </td>
       </tr>

       <tr>
        <td>申请进入下一阶段</td>
         <td nowrap>
         <input name="draftnext" type="radio" value="false" <%if(!obj.isDraftnext())out.print(" checked ");else out.print(" disabled ");%>/>否
         <input name="draftnext" type="radio" value="true" <%if(obj.isDraftnext())out.print(" checked ");%>/>是
         </td>
       </tr>
       <tr>
         <td>&nbsp;</td>
         <td nowrap>
           <%
           //if(obj.getOpenuri()==null||obj.getOpenuri().length()==0||obj.getSummaryuri()==null||obj.getSummaryuri().length()==0||(obj.getOpentime()!=null&&!obj.isSummaryauditing()))
           {
             out.print("<input type=submit value=提交 > <input type=reset value=重置 onClick=\"defaultfocus();\">");
           }
           %>
           <input type="button" value="返回" onClick="history.back();"/>
         </td>
       </tr>
  </table>
</form>
<%--
<h2>项目管理员下达</h2>
 <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
       <tr>
         <td>开题会议通知</td>
         <td nowrap>
         <%
         if(obj.getInformuri()!=null&&obj.getInformuri().length()>0)
         {
           out.print("<A href=ItemDownload.jsp?act=informuri&item="+item+" >"+obj.getInformname()+"</A>");
         }
         %>		 </td>
       </tr> <tr>
         <td><!--开题会议纪要-->开题报告审查</td>
         <td nowrap><%if(obj.getOpentime()==null)out.print("未审核 ");else if(obj.isSummaryauditing())out.print("批准 ");else out.print("返回修改 ");%>
         </td>
       </tr>
  </table>
  --%>
<br>
<div id="head6"><img height="6" src="about:blank"></div>
<br>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter" style="">
<tr>
<td>注:</td>
</tr>
<tr><td>1.该阶段主要是上传文档，文档不用审核。</td></tr>
</table>
</body>
</html>


