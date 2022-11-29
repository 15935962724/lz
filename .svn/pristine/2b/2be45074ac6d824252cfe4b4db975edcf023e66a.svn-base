<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.Resource"  %><%@ page  import="java.util.*" %><%@page import="tea.entity.*" %><%@ page  import="tea.entity.node.*" %><%@ page  import="tea.entity.bbs.*" %><%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}
Http h=new Http(request,response);
String nexturl=h.get("nexturl",request.getRequestURI()+"?"+request.getQueryString());

if("POST".equals(request.getMethod()))
{
  int topic=h.getInt("topic");
  int reply=h.getInt("reply");
  int del=h.getInt("del");
  int move=h.getInt("move");
  int parktop=h.getInt("parktop");
  int qui=h.getInt("qui");
  int hot=h.getInt("hot");
  int attach=h.getInt("attach");
  int down=h.getInt("down");
  int activity=h.getInt("activity");
  int ajoin=h.getInt("ajoin");
  boolean isAll=request.getParameter("all")!=null;

  Iterator it=Category.find(h.community,57,0,Integer.MAX_VALUE).iterator();
  while(it.hasNext())
  {
    int nid=((Integer)it.next()).intValue();
    if(!isAll&&nid!=h.node)continue;
    BBSForum bf=BBSForum.find(nid);
    bf.topic=topic;
    bf.reply=reply;
    bf.del=del;
    bf.move=move;
    bf.parktop=parktop;
    bf.qui=qui;
    bf.hot=hot;
    bf.attach=attach;
    bf.down=down;
    bf.activity=activity;
    bf.ajoin=ajoin;
    bf.set();
  }
  out.print("<script>parent.mt.show('操作执行成功！',1,'"+nexturl+"');</script>");
  return;
}

Resource r=new Resource();

BBSForum f=BBSForum.find(teasession._nNode);



%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body onLoad="form1.topic.focus();">

<h1>论坛积分规则设置</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br>

<form name="form1" method="post" action="?" target="_ajax" >
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="node" value="<%=teasession._nNode%>"/>
<input type="hidden" name="nexturl" value="<%=nexturl%>"/>
<input type="hidden" name="id" value="<%=request.getParameter("id")%>"/>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td>发帖加分:</td>
    <td><input name="topic" value="<%=f.topic%>" mask="int"></td>
    <td>回复加分:</td>
    <td><input name="reply" value="<%=f.reply%>" mask="int"></td>
  </tr>
  <tr>
    <td>版主删贴扣分:</td>
    <td><input name="del" value="<%=f.del%>" mask="int"></td>
    <td>版主移贴扣分:</td>
    <td><input name="move" value="<%=f.move%>" mask="int"></td>
  </tr>
  <tr>
    <td>置顶加分:</td>
    <td><input name="parktop" value="<%=f.parktop%>" mask="int"></td>
  </tr>
  <tr>
    <td>精华加分:</td>
    <td><input name="qui" value="<%=f.qui%>" mask="int"></td>
    <td>热帖加分:</td>
    <td><input name="hot" value="<%=f.hot%>" mask="int"></td>
  </tr>
  <tr>
    <td>附件加分:</td>
    <td><input name="attach" value="<%=f.attach%>" mask="int"></td>
    <td>下载附件扣分:</td>
    <td><input name="down" value="<%=f.down%>" mask="int"></td>
  </tr>
  <tr>
    <td>发起活动:</td>
    <td><input name="activity" value="<%=f.activity%>" mask="int"></td>
    <td>参加活动:</td>
    <td><input name="ajoin" value="<%=f.ajoin%>" mask="int"></td>
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
