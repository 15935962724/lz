<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%><%@page import="tea.entity.weixin.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}

String tmp=h.get("wxuser");
WxUser wu=WxUser.find(h.community,Long.parseLong(tmp));


StringBuffer sql=new StringBuffer(),par=new StringBuffer();
sql.append(" AND "+wu.wxuser+" IN(wm.fuser,wm.tuser)");

par.append("?wxuser="+wu.wxuser);

String nexturl=h.get("nexturl");
par.append("&nexturl="+Http.enc(nexturl));

int pos=h.getInt("pos");
par.append("&pos=");

int sum=WxMessenger.count(sql.toString());


%>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<link href="/tea/image/weixin/emoji.css" rel="stylesheet" type="text/css"/>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>微信消息管理</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<h2>与 <%=wu.nickname%> 的聊天</h2>
<form name="form1" action="/WxUsers.do" method="post" enctype="multipart/form-data" target="_ajax" onsubmit="return mt.check(this)">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="wxuser" value="<%=wu.wxuser%>"/>
<input type="hidden" name="act" value="send"/>
<input type="hidden" name="type" value="text"/>
<input type="hidden" name="nexturl" value="location.reload()"/>
<table id="tablecenter" cellspacing="0">
<tr>
  <td>
    <textarea name="content" alt="内容" cols="50" rows="5"></textarea>
    <input type="file" name="file" >
  </td>
</tr>
</table>
<input type="submit" value="发送"/>
<input type="button" value="返回" onclick="history.back()"/>
</form>

<h2>最近聊天记录 <%=sum%></h2>
<form name="form2" action="/MMessengerEdit.jsp">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="wxmessenger"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<table id="tablecenter" cellspacing="0">
<%
if(sum<1)
{
  out.print("<tr><td colspan='10' align='center'>暂无记录!</td></tr>");
}else
{
  sql.append(" ORDER BY wm.time DESC");
  Iterator it=WxMessenger.find(sql.toString(),pos,10).iterator();
  for(int i=1+pos;it.hasNext();i++)
  {
    WxMessenger t=(WxMessenger)it.next();
    wu=WxUser.find(t.community,t.fuser);
  %>
  <tr>
    <td rowspan='2'><img src="<%=MT.f(wu.avatar,"/tea/image/avatar.gif")%>" width="50"/></td>
    <td><%=MT.f(wu.nickname)%></td>
    <td><%=MT.f(t.time,1)%></td>
  </tr>
  <tr><td colspan="2" style="color:#7B7B7B"><%=t.getContent()%></td></tr>
  <%
  }
  if(sum>10)out.print("<tr><td colspan='10' align='right'>共"+sum+"条！"+new tea.htmlx.FPNL(h.language,par.toString(),pos,sum,10));
}%>
</table>

</form>

<script>
form2.nexturl.value=location.pathname+location.search;
mt.act=function(a,id,b)
{
  form2.act.value=a;
  form2.wxmessenger.value=id;
  if(a=='del')
  {
    mt.show('你确定要删除吗？',2,'form2.submit()');
  }else if(a=='view')
  {
    form2.action='/jsp/weixin/WxMessengerView.jsp';
    form2.target=form2.method='';
    form2.submit();
  }
};
</script>
</body>
</html>
