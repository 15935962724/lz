<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.Resource"  %><%@ page  import="java.util.*" %><%@ page  import="tea.entity.node.*" %><%@ page  import="tea.entity.bbs.*" %><%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

if("POST".equals(request.getMethod()))
{
  int topic=Integer.parseInt(request.getParameter("topic"));
  int reply=Integer.parseInt(request.getParameter("reply"));
  int del=Integer.parseInt(request.getParameter("del"));
  int move=Integer.parseInt(request.getParameter("move"));
  int qui=Integer.parseInt(request.getParameter("qui"));
  int hot=Integer.parseInt(request.getParameter("hot"));
  int attach=Integer.parseInt(request.getParameter("attach"));
  int down=Integer.parseInt(request.getParameter("down"));
  boolean isAll=request.getParameter("all")!=null;
  if(isAll)
  {
    Enumeration e=BBSForum.findByCommunity(teasession._strCommunity);
    while(e.hasMoreElements())
    {
      int nid=((Integer)e.nextElement()).intValue();
      BBSForum.setPoint(nid,topic,reply,del,move,qui,hot,attach,down);
    }
  }else
  {
    BBSForum.setPoint(teasession._nNode,topic,reply,del,move,qui,hot,attach,down);
  }
  return;
}

Resource r=new Resource();

BBSForum f=BBSForum.find(teasession._nNode);


%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<script>
function f_sel(re)
{
  var isSel=re=='';
  if(isSel)re=window.showModalDialog('/jsp/type/bbs/SelBBSLevelPic.jsp',self,'dialogWidth:280px;dialogHeight:400px;');
  if(re)
  {
    $('view').src=re;
    form1.picture.value=re;
    form1.picture.disabled=!isSel;
  }
}
</script>
</head>
<body onLoad="form1.topic.focus();">

<h1>添加/编辑 论坛等级</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br>

<form name="form1" method="post" action="?" enctype="multipart/form-data" >
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>


<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td>发帖加分:</td>
    <td><input name="topic" value="<%=f.getTopic()%>" mask="int"></td>
      <td>回复加分:</td>
      <td><input name="reply" value="<%=f.getReply()%>" mask="int"></td>
  </tr>
  <tr>
    <td>版主删贴扣分:</td>
    <td><input name="del" value="<%=f.getDel()%>" mask="int"></td>
    <td>版主移贴扣分:</td>
    <td><input name="move" value="<%=f.getMove()%>" mask="int"></td>
  </tr>
  <tr>
    <td>精华加分:</td>
    <td><input name="qui" value="<%=f.getQui()%>" mask="int"></td>
    <td>热帖加分:</td>
    <td><input name="hot" value="<%=f.getHot()%>" mask="int"></td>
  </tr>
  <tr>
    <td>附件加分:</td>
    <td><input name="attach" value="<%=f.getAttach()%>" mask="int"></td>
    <td>下载附件扣分:</td>
    <td><input name="down" value="<%=f.getDown()%>" mask="int"></td>
  </tr>
</table>

<input type="submit" value="<%=r.getString(teasession._nLanguage,"CBSubmit")%>">
<input type="submit" value="<%=r.getString(teasession._nLanguage,"同时更新到其它论坛")%>" name="all">
<input type="button" value="<%=r.getString(teasession._nLanguage,"CBBack")%>" onClick="history.back();">
</form>

<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
