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

String act=request.getParameter("act");

java.text.DateFormat df=java.text.DateFormat.getDateTimeInstance();
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/jsp/criterion/js.js"></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<script>
function defaultfocus()
{
  //form1.informuri.focus();
}
function fdelete()
{
  for(var i=0;i<form1.elements.length;i++)
  {
    if(form1.elements[i].type=="checkbox"&&form1.elements[i].checked)
    {
      return confirm("确认删除?");
    }
  }
  alert("请选中要删除的项.");
  return false;
}
</script>
</head>
<body onLoad="defaultfocus();">

<h1>删除文档</h1>
<br>
<div id="head6"><img height="6" src="about:blank"></div>
<br/>
<form action="/servlet/EditItem" method="post"  name="form1" onsubmit="return fdelete();" >
<input type=hidden name="act" value="docdeleteitem"/>
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
       <%
       if("drafturi".equals(act))
       {
         out.print("<tr><td>起草阶段文档</td><td nowrap>");
         java.util.Enumeration enumer=Itemfilehistory.find(item,act);
         while(enumer.hasMoreElements())
         {
           int itemfilehistory=((Integer)enumer.nextElement()).intValue();
           Itemfilehistory history=Itemfilehistory.find(itemfilehistory);
           java.io.File file=new java.io.File(application.getRealPath(history.getUri()));
           out.print("<input name=itemfilehistory type=checkbox value="+itemfilehistory+" ><A href=ItemDownload.jsp?act=drafturi&item="+item+"&itemfilehistory="+itemfilehistory+" >"+history.getName()+"</A>("+df.format(new java.util.Date(file.lastModified()))+")<br/>");
         }
         if(obj.getDrafturi()!=null&&obj.getDrafturi().length()>0)
         {
           java.io.File file=new java.io.File(application.getRealPath(obj.getDrafturi()));
           out.print("<input name=doc_act type=checkbox value=drafturi ><A href=ItemDownload.jsp?act=drafturi&item="+item+" >"+obj.getDraftname()+"</A>("+df.format(new java.util.Date(file.lastModified()))+")");
         }
         out.print("</td></tr>");
       }
       %>
       <tr>
         <td>&nbsp;</td>
         <td nowrap>
           <input type="submit" name="Submit" value="提交" onclick="">
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
<tr><td>1.删除的文档不可恢复。</td>
</tr>
</table>
</body>
</html>


