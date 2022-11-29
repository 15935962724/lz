<%@page contentType="text/html;charset=UTF-8" %>
<%@page import=" tea.entity.site.*" %>
<%@page import="rath.msnm.msg.*" %>
<%@page import="rath.msnm.*" %>
<%
request.setCharacterEncoding("UTF-8");

String name=request.getParameter("name");
String service=request.getParameter("service");
String community=request.getParameter("community");

if("POST".equals(request.getMethod()))
{
  String content=request.getParameter("content");

  Msntemp obj=Msntemp.find(name);
  boolean bool=obj.send(service,content);
  if(!bool)
  {
    out.print("<script>alert('发送消息失败.');</script>");
  }
}
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<LINK href="/tea/CssJs/<%//=node.getCommunity()%>.css" REL="stylesheet" TYPE="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type=""></SCRIPT>

<script type="">
function MailMsg()
{
  var sAgent = window.navigator.userAgent;
  sAgent  = sAgent.toUpperCase();
  var iIndex = sAgent.indexOf("MSIE");
  if ((iIndex > -1) && (sAgent.indexOf("OPERA") == -1))
  {
    iIndex = sAgent.indexOf("MSIE 6");
    var sChatInformation = parent.msnhistory.document.all('history').innerHTML;
    if (iIndex > -1)
    {
      ifrSave.document.write(sChatInformation);
      ifrSave.document.execCommand('SaveAs','','网站访客即时会话系统.htm');
      return;
    }else
    {
      iIndex = sAgent.indexOf("TENCENT");
      if (iIndex == -1)
      {
        var objSave = window.open("about:blank","","width=200,height=200,top=200,left=300");
        objSave.document.write(sChatInformation);
        objSave.document.execCommand('SaveAs','','网站访客即时会话系统.htm');
        objSave.close();
        return;
      }
    }
  }
}
</script>
</head>

<body onload="form1.content.focus();">
<form name="form1" method="post" action="?">
<input type="hidden" name="name" value="<%=name%>"/>
<input type="hidden" name="service" value="<%=service%>"/>
<input type="hidden" name="community" value="<%=community%>"/>
<textarea name="content" cols="40" rows="5"></textarea>
<input type="submit" name="send" value="发送(ALT+S)" style="width:100px; height:80px;" accesskey="S">
<input type="button" value="保存" style="width:100px; height:80px;" onclick="MailMsg()">
</form>

<%--
<form name="fm_newtopic" target="ifm_form" method="post" action="?">
<div class="menu" onmousedown=bar_event(event) onmouseover="bar_event(event)" onmouseup="bar_event(event)" onmouseout="bar_event(event)">
  <img src="/tea/image/bbs_edit/undo.gif" alt="撤销">
  <img src="/tea/image/bbs_edit/redo.gif" alt="重做">
  <img src="/tea/image/bbs_edit/Cut.gif" alt="裁切">
  <img src="/tea/image/bbs_edit/Copy.gif" alt="复制">
  <img src="/tea/image/bbs_edit/Paste.gif" alt="粘贴">
  <img src="/tea/image/bbs_edit/gd.gif">
  <img src="/tea/image/bbs_edit/face.gif" alt="表情">
  <img src="/tea/image/bbs_edit/gd.gif">
  <img src="/tea/image/bbs_edit/font.gif" alt="字体">
  <img src="/tea/image/bbs_edit/size.gif" alt="字体大小">
  <img src="/tea/image/bbs_edit/color.gif" alt="字体色彩">
</div>
<iframe id=wEdit name=wEdit src="/jsp/include/bbs_edit/wEdit.htm" frameborder=0 style="width:99%; BORDER-RIGHT: #ccc 1px solid;  BORDER-TOP: #ccc 1px solid; BORDER-LEFT: #ccc 1px solid; BORDER-BOTTOM: #ccc 1px solid" class="forum_input2" onmouseover="$('wEditorMenu').style.display='none'"></iframe>

</form>
<iframe id="wEditorMenu" name="wEditorMenu" src="/jsp/include/bbs_edit/edit_menu.htm" onmouseout="this.style.display='none'" frameborder=0 style="BORDER-RIGHT: #7691ac 1px solid; BORDER-TOP: #7691ac 1px solid; DISPLAY: none; Z-INDEX: 101; LEFT: 300px; BORDER-LEFT: #7691ac 1px solid; WIDTH: 100px; BORDER-BOTTOM: #7691ac 1px solid; POSITION: absolute; TOP: 200px; HEIGHT: 200px"></iframe>

<script language="javascript" type="text/javascript" src="/jsp/include/bbs_edit/ubb.v1189736939.js"></script>
<script language="javascript" type="text/javascript" src="/jsp/include/bbs_edit/msgbox.v1189736933.js"></script>
--%>
<iframe id="ifrSave" name="ifrSave" width="0" height="0" border="0"></iframe>
</body>
</html>
