<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter"%><%@page import="tea.resource.Resource" %>
<%@ page import="tea.entity.admin.ig.*" %><%@ page import="tea.ui.TeaSession" %>
<%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}


String nexturl=request.getParameter("nexturl");

int igdirectory=Integer.parseInt(request.getParameter("igdirectory"));



Resource r=new Resource();

int sort=0;
long len=0L;
String name,picture;
if(igdirectory!=0)
{
  Igdirectory obj=Igdirectory.find(igdirectory);
  name=obj.getName().replaceAll("\"","&quot;");
  picture=obj.getPicture();
  if(picture!=null)
  len=new java.io.File(application.getRealPath(picture)).length();
  sort=obj.getSort();
}else
{
  name=picture="";
}

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/jsp/criterion/js.js"></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script>
function defaultfocus()
{
  form1.name.focus();
}
</script>
</head>
<body onLoad="defaultfocus();">

<h1>创建</h1>
<br>
<div id="head6"><img height="6" src="about:blank"></div>
<br/>
<form action="/servlet/EditIg" method="post" enctype="multipart/form-data" name="form1" onSubmit="return submitText(this.name, '<%=r.getString(teasession._nLanguage, "InvalidParameter")%>-名称')">
<input type=hidden name="igdirectory" value="<%=igdirectory%>"/>
<input type=hidden name="community" value="<%=teasession._strCommunity%>"/>
<input type=hidden name="nexturl" value="<%=nexturl%>"/>
<input type=hidden name="act" value="editigdirectory"/>
      <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
       <tr>
        <td>名称</td>
         <td nowrap><input name="name" type="text" id="name" value="<%=name%>" size="40"></td>
       </tr>
       <tr>
         <td>缩略图</td>
         <td nowrap><input type=file  name="picture" > <%if(len>0)out.print(len+r.getString(teasession._nLanguage,"Bytes"));%>
         </td>
       </tr>
       <tr>
         <td>分类</td>
         <td nowrap>
           <select name="sort">
           <%
           for(int i=0;i<Igdirectory.SORT_TYPE.length;i++)
           {
             out.print("<option value="+i);
             if(i==sort)
             {
               out.print(" SELECTED ");
             }
             out.print(">"+Igdirectory.SORT_TYPE[i]);
           }
           %>
           </select>
         </td>
       </tr>
       <tr>
         <td>&nbsp;</td>
         <td nowrap>
           <input type="submit"  value="提交">
           <input type="reset"  value="重置" onClick="defaultfocus();">
           <input type="button" value="返回" onClick="history.back();">
         </td>
       </tr>
  </table>
</form>

<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>



