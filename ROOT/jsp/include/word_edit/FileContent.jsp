<%@page contentType="text/html;charset=utf-8" %><%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(request.getMethod().equals("POST"))
{
  byte by[]=teasession.getBytesParameter("uploadfile");
  if(by!=null)
  {

    java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyMM");
    String year = sdf.format(new java.util.Date());
    String path = "/res/" + teasession._strCommunity + "/u/" + year + "/";
    java.io.File f = new java.io.File(getServletContext().getRealPath(path));
    if (!f.exists())
    {
      f.mkdirs();
    }
    java.io.File file=java.io.File.createTempFile(year,".gif",f);
    java.io.FileOutputStream fos=new java.io.FileOutputStream(file);
    fos.write(by);
    fos.close();
    %>

    <script language=javascript>
    var obj=parent.dialogArguments.dialogArguments;

    if (!obj) obj=parent.dialogArguments;

    parent.insetIMG('<%=path+file.getName()%>');
    </script>

    <%
  }
//  return;
}


%>








<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312">
      <style type="text/css">
table{
	font-size:12px;
}

body{
	overflow:hidden;
	margin:0px;
	padding:0px;
	padding-top:1px;
}
      </style>
<script type="text/javascript">
function _cancel()
{
  window.close();
}

function insetIMG(_sVal)
{
  if(_sVal == "") return;
  var html = "<img src='" + _sVal + "' />";
  if(window.Event)
  {
    var oRTE = opener.getFrameNode(opener.sRTE);
    oRTE.document.execCommand('insertHTML', false, html);
  }else
  {
    var oRTE = dialogArguments.getFrameNode(dialogArguments.sRTE);
    oRTE.focus();
    var oRng = oRTE.document.selection.createRange();
    oRng.pasteHTML(html);
    oRng.collapse(false);
    oRng.select();
  }
  window.close();
}

function _submit()
{
  var obj=document.getElementById('wordEditer_IMG_SRC');
  if(obj.value.length<8)
  {
//    alert(d_file.document);
    d_file.myform.submit();
  }else
  {
    insetIMG(obj.value);
  }
  return false;
}
</script>
      </head>
      <body >

      <form action="?" method=post name=myform enctype="multipart/form-data">

<table border="0" cellpadding="0" cellspacing="8" align="center" width="90%">
  <tr>
    <td nowrap>网络:<input id="wordEditer_IMG_SRC" name="wordEditer_IMG_SRC" value="http://" size="30"></td>
  </tr>
  <tr>
    <td nowrap >上传:<iframe id=d_file name="d_file" frameborder=0 src="Upload.jsp?type=image"   height="22" scrolling=no></iframe></td>
  </tr>
  <tr>
    <td align="center"><input type=submit onClick="return _submit();" value=确定 >&nbsp;&nbsp;<input type=button onClick="_cancel();" value=取消 ></td>
  </tr>
</table>

      <input type=file name=uploadfile onchange="originalfile.value=this.value">
      <input type=hidden name=originalfile value="">

      </form>

      </body>
</html>

