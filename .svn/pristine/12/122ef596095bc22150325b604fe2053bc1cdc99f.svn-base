<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" import="tea.resource.Resource" %><%@ page import="tea.entity.criterion.Item" %><%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String community=request.getParameter("community");

//Resource r=new Resource();

String nexturl=request.getParameter("nexturl");

int item=Integer.parseInt(request.getParameter("item"));

Item obj=Item.find(item);

java.io.File file=new java.io.File(application.getRealPath("/item/"+obj.getCode()));
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
<script type="">
function fclick(index)
{
  var img_obj=document.getElementById('img'+index);
  var tr_obj=document.all('tr'+index);
  if(img_obj.src.indexOf('tree_plus')!=-1)
  {
    img_obj.src='/tea/image/tree/tree_minus.gif';
    if(tr_obj.style)
      tr_obj.style.display='';
    for(var i=0;i<tr_obj.length;i++)
    {
      tr_obj[i].style.display='';
    }
  }else
  {
    img_obj.src='/tea/image/tree/tree_plus.gif';
    if(tr_obj.style)
    tr_obj.style.display='none';
    for(var i=0;i<tr_obj.length;i++)
    {
      tr_obj[i].style.display='none';
    }
  }
}
</script>
</head>
<body>

<h1>存档管理</h1>
<br>
<div id="head6"><img height="6" src="about:blank"></div>

<form action="/servlet/EditItem" method="post">
<input type="hidden" name="act" value="EditArchiveItems">
<input type="hidden" name="item" value="<%=item%>">
<input type="hidden" name="nexturl" value="<%=nexturl%>">

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
		 <tr><td nowrap>计划号</td><TD nowrap><%=obj.getCode()%></TD></tr>
		 <tr><TD nowrap>名称</TD><TD nowrap><%=obj.getName()%></TD></tr>
                 <tr><TD nowrap>存档日期</TD><TD nowrap><%if(file.exists())out.print(new java.util.Date(file.lastModified()).toLocaleString());%></TD></tr>
		 <tr>
                   <TD nowrap>路径</TD>
                   <TD nowrap><%=file.getAbsoluteFile()%></TD></tr>
</table>
  <input  type="submit" value="存档">
  <input  type="button" value="返回" onclick="history.back();">
</form>
<br>
<h2>存档的文件列表</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr id="tableonetr"><td nowrap>文件名</td>
    <TD nowrap>大小</TD> </tr>
<%
java.io.File files[]=file.listFiles();
if(files!=null)
for(int index=0;index<files.length;index++)
{
  if(files[index].isDirectory())
  {
    java.io.File file2s[]=files[index].listFiles();
    out.print("<tr onMouseOver=\"javascript:this.bgColor='#BCD1E9'\" onMouseOut=\"javascript:this.bgColor=''\"><td><A href=javascript:fclick("+index+"); ><img id=img"+index+" src=/tea/image/tree/tree_minus.gif  align=absmiddle><img style=display:none align=absmiddle src=/tea/image/other/directory.gif >"+files[index].getName()+"</a></td><td>"+file2s.length+"个</td></tr>");
    for(int j=0;j<file2s.length;j++)
    {//
      String name=file2s[j].getName();
      String ex=name.substring((name.lastIndexOf(".")+1));
      out.print("<tr id=tr"+index+"  onMouseOver=\"javascript:this.bgColor='#BCD1E9'\" onMouseOut=\"javascript:this.bgColor=''\"><td><img src=/tea/image/tree/tree_line.gif  align=absmiddle><img src=/tea/image/tree/tree_blank.gif  align=absmiddle><A href=/item/"+obj.getCode()+"/"+files[index].getName()+"/"+name+" ><img  align=absmiddle src=/tea/image/other/"+ex+".gif onerror=if(this.src.indexOf('defaut.gif')==-1)this.src='/tea/image/other/defaut.gif'; >"+name+"</a></td><td>"+file2s[j].length()+"B</td></tr>");
    }
  }else
  {
    out.print("<tr onMouseOver=\"javascript:this.bgColor='#BCD1E9'\" onMouseOut=\"javascript:this.bgColor=''\"><td><A href=/item/"+obj.getCode()+"/"+files[index].getName()+" >"+files[index].getName()+"</a></td><td>"+files[index].length()+"B</td></tr>");
  }
}
%>
</table>

<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>


