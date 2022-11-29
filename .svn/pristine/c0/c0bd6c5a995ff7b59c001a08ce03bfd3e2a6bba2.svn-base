<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.ui.*"%>
<%@page import="tea.entity.node.*"%><%@page import="tea.entity.weibo.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}


Node n=Node.find(h.node);
Historical t;

String subject=null,content=null,keywords=null,picture=null,video=null;
if(n.getType()==1)
{
  t=new Historical(0,h.language);
}else
{
  subject=n.getSubject(h.language);
  content=n.getText(h.language);
  picture=n.getPicture(h.language);
  video=n.getVoice(h.language);

  t=Historical.find(h.node,h.language);
}


%>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>查看——历史事件</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" action="/Historicals.do?repository=historical" method="post" enctype="multipart/form-data" target="_ajax" onsubmit="return mt.check(this)&&mt.submit(this)">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="node" value="<%=h.node%>"/>
<input type="hidden" name="act" value="edit"/>
<input type="hidden" name="nexturl" value="<%=h.get("nexturl","")%>"/>

<table id="tablecenter" cellspacing="0">
  <tr>
    <td align="right">标题：</td>
    <td><%=MT.f(subject)%></td>
  </tr>
  <tr>
    <td align="right">内容：</td>
    <td><%=MT.f(content)%></td>
  </tr>
  <tr>
    <td align="right">照片：</td>
    <td><%=MT.f(picture).length()>0?"<img src='"+picture+"'>":"无"%></td>
  </tr>
  <tr>
    <td align="right">视频：</td>
    <td>
      <%--<script>mt.embed('"+video+"',460,380)</script>--%>
      <%=video == null ? "无" : "<embed src='/tea/image/flv/FLVPlayer_Progressive.swf' width='460' height='380' type='application/x-shockwave-flash' flashvars='&MM_ComponentVersion=1&skinName=/tea/image/flv/Clear_Skin_3&streamName=" + Http.enc(video) + "&autoPlay=false&autoRewind=false'></embed>"%>
    </td>
  </tr>
  <tr>
    <td align="right">发生时间：</td>
    <td><%=MT.f(t.otime)%></td>
  </tr>
  <tr>
    <td align="right">来源出处：</td>
    <td><%=MT.f(t.source)%></td>
  </tr>
  <tr>
    <td align="right">来源出处说明：</td>
    <td><%=MT.f(t.sourcedesc)%></td>
  </tr>
</table>


<%
if(t.microid>0)
{
  out.print("<!--"+t.microid+"-->");
%>
<div class="switch">
<a href="###" onclick="mt.tab(this)" name="a_tab" class="current">转发(<%=t.reposts%>)</a>
<a href="###" onclick="mt.tab(this)" name="a_tab">评论(<%=t.comments%>)</a>
</div>
<table name="tab" id="tablecenter" cellspacing="0">
<%
Iterator it=WMicro.find(" AND quoteid="+t.microid+" AND deleted=0 ORDER BY microid DESC",0,20).iterator();
if(!it.hasNext())
out.print("<tr><td>暂无记录！");
else
while(it.hasNext())
{
  WMicro m=(WMicro)it.next();
  WUser u=WUser.find(m.userid);
  out.print("<tr><td><img src='"+u.avatar+"'/><td>"+u.getName()+"："+m.getContent());
}
%>
</table>
<table name="tab" id="tablecenter" cellspacing="0" style="display:none">
<%
it=WComment.find(" AND microid="+t.microid+" AND deleted=0 ORDER BY commentid DESC",0,20).iterator();
if(!it.hasNext())
out.print("<tr><td>暂无记录！");
else
while(it.hasNext())
{
  WComment c=(WComment)it.next();
  WUser u=WUser.find(c.userid);
  out.print("<tr><td><img src='"+u.avatar+"'/><td>"+u.getName()+"："+c.getContent());
}
%>
</table>
<%
}
%>

<br/>
<input type="button" value="返回" onclick="history.back();"/>
</form>

<script>

</script>
</body>
</html>
