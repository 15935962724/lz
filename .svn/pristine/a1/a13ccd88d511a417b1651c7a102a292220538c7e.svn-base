<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.entity.site.*" %><%@page import="java.io.*" %><%@page import="java.util.*" %><%@page import="tea.html.*" %><%@page import="tea.entity.site.*" %><%@page import="tea.entity.admin.*" %><%@page import="java.math.*" %><%@page import="tea.entity.member.*" %><%@page import="tea.db.DbAdapter"%><%@page import="tea.resource.*" %><%@page import="tea.entity.node.*" %><%@page import="tea.ui.*" %><% request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String field=teasession.getParameter("field");
if("POST".equals(request.getMethod()))
{
  String path=teasession.getParameter("file");
  out.print("<script>");
  if(path!=null)
  {
    out.print("dialogArguments.document.all('"+field+"').value=\""+path+"\"; alert('上传成功!!!');");
  }
  out.print("window.close();</script>");
  return;
}

%><html>
<head>
<title>起草文件</title>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<script src="/tea/tea.js" type="text/javascript"></script>
<style type="text/css">
<!--
body
{
 margin-left: 0px;
 margin-top: 0px;
 margin-right: 0px;
 margin-bottom: 0px;
 border:0px;
 background-color:menu;
}
-->
</style>
<script>

function f_submit(obj)
{
  var img=document.getElementById("img");
  img.style.display="";
  form1.submit();
  obj.disabled=true;
}
</script>
</head>
<body class="Pop_up">
<form name="form1" action="?" method="post" enctype="multipart/form-data">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="repository" value="flow"/>
<input type="hidden" name="field" value="<%=field%>"/>

<table border='0' cellpadding='0' cellspacing='0' id='TableAnnex' >
  <tr>
    <td  class='TableAnnextitle'>请上传文件:
  <tr>
    <td style="padding-top:10px;"><input type="file" name="file"  style="border:1px solid #404040;background:#fff;" /></td>
  </tr>
    <tr>
    <td style="padding-top:10px;">
    <script type="">
    var path=dialogArguments.document.all(form1.field.value).value;
    if(path&&path.length>5)
    {
      document.write("<input type='button' value=' 查 看 ' onclick=\"window.open('"+path+"');\" >");
    }
    </script>
      <input type='submit' value=' 确 定 ' onClick="f_submit(this);">　<input type='button' value=' 取 消 ' onclick='window.close();'>
    </td>
  </tr>
</table>
</form>
<img id="img" src="/tea/image/public/load2.gif" style="display:none"/>

</body>
</html>
