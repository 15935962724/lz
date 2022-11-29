<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.Resource" %><%@ page import="tea.entity.criterion.Item" %><%@ page import="tea.entity.*" %><%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");


TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String community=request.getParameter("community");
String nexturl=request.getParameter("nexturl");

String path=request.getParameter("path");


Resource r=new Resource();


%>
<html>
<head>
<link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script>
function defaultfocus()
{
  form1.question.focus();
}
</script>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "课件管理")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<div id="pathdiv">
<%
String paths[]=path.split("/");
out.print("><A href=/jsp/producer/EditProducer.jsp?community="+community+"&path=%2F"+paths[1]+"%2F"+paths[2]+"%2F"+paths[3]+"%2F >根目录</A>");
for(int i=4;i<paths.length;i++)
{
  StringBuffer sb=new StringBuffer("/");
  for(int j=1;j<=i;j++)
  {
    sb.append(paths[j]+"/");
  }
  out.print("><A href=/jsp/producer/EditProducer.jsp?community="+community+"&path="+java.net.URLEncoder.encode(sb.toString(),"UTF-8")+" >"+paths[i]+"</A>");
}
%>
</div>
<FORM action="/servlet/EditProducer" METHOD=POST enctype="multipart/form-data" name=form1 onSubmit="">
<input type='hidden' name=Node VALUE="<%=teasession._nNode%>">
<input type='hidden' name=community VALUE="<%=community%>">
<input type='hidden' name=action VALUE="">
<input type='hidden' name=path VALUE="<%=path%>">

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr><td>
  <%=r.getString(teasession._nLanguage, "创建文件夹")%>:
  </td>
  <td>
  <input type="TEXT" class="edit_input"  name=name >
  <input type="submit" value="<%=r.getString(teasession._nLanguage, "Submit")%>" onClick="form1.action.value='mkdir'; return(submitText(form1.name, '<%=r.getString(teasession._nLanguage, "InvalidName")%>'));">
</td></tr>

<tr><td>
  <%=r.getString(teasession._nLanguage, "上传文件")%>:
  </td>
  <td>
  <input type="file"   name=file><input type="checkbox" name="deco"/>解压文件
  <input type="submit" name="local" value="<%=r.getString(teasession._nLanguage, "Submit")%>" onClick="form1.action.value='upfile'; return(submitText(form1.file, '<%=r.getString(teasession._nLanguage, "InvalidFile")%>'));">
</td></tr>

</table>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr ID=tableonetr>
  <td>文件名
  <td>大小
  <td>时间
    <td>
</tr>
<%
java.text.DecimalFormat df=new java.text.DecimalFormat("#,###");

java.io.File files[]=new java.io.File(application.getRealPath(path)).listFiles();
if(files!=null)
{
  StringBuffer sb=new StringBuffer();
  for(int i=0;i<files.length;i++)
  {
    if(files[i].isDirectory())
    {
      out.print("<tr onmouseover=javascript:this.bgColor='#BCD1E9' onMouseOut=javascript:this.bgColor='' ><td>");
      out.print("<A href=\"/jsp/producer/EditProducer.jsp?community="+community+"&path="+java.net.URLEncoder.encode(path+files[i].getName()+"/","UTF-8")+"\" ><img align=absmiddle src=/tea/image/other/directory.gif />"+files[i].getName()+"</a>");
      out.print("<td align=right>&nbsp;");//+df.format(files[i].length())+"B");
      out.print("<td>"+Entity.sdf2.format(new java.util.Date(files[i].lastModified())));
      out.print("<td><input type=submit value="+r.getString(teasession._nLanguage, "CBDelete")+" onClick=\"form1.action.value='delete';if( confirm('"+r.getString(teasession._nLanguage,"ConfirmDelete")+"')){ form1.name.style.color='#FFFFFF'; form1.name.value='"+files[i].getName()+"'; return true;} else return false;\">");
    }else
    {
      String ex=files[i].getName();
      int j=ex.lastIndexOf(".");
      ex=ex.substring(j+1).toLowerCase();
      sb.append("<tr onmouseover=javascript:this.bgColor='#BCD1E9' onMouseOut=javascript:this.bgColor='' ><td>");
      sb.append("<A href=\""+path+files[i].getName()+"\" TARGET=_blank ><img align=absmiddle onerror=\"if(this.src.indexOf('defaut.gif')==-1)this.src='/tea/image/other/defaut.gif';\" src=/tea/image/other/"+ex+".gif />"+files[i].getName()+"</a>");
      sb.append("<td align=right>"+df.format(files[i].length())+"B");
      sb.append("<td>"+Entity.sdf2.format(new java.util.Date(files[i].lastModified())));
      sb.append("<td><input type=submit value="+r.getString(teasession._nLanguage, "CBDelete")+" onClick=\"form1.action.value='delete';if( confirm('"+r.getString(teasession._nLanguage,"ConfirmDelete")+"')){ form1.name.style.color='#FFFFFF'; form1.name.value='"+files[i].getName()+"';  return true;} else return false;\">");
    }
  }
  out.print(sb.toString());
}
%>
</table>
</FORM>


<div id="head6"><img height="6" src="about:blank"></div>
<%--<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>--%>
</body>
</html>

