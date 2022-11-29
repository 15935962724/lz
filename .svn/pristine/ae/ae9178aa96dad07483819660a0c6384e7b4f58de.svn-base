<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page import="java.util.*" %><%@ page  import="tea.resource.Resource" %><%@ page import="tea.entity.bbs.*" %><%@ page import="tea.entity.node.*" %><%@ page import="tea.entity.member.*" %><%@ page import="tea.entity.*" %><%@ page import="tea.entity.admin.*" %><%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");


Http h=new Http(request);

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String member=h.get("member");
if(member==null)member=teasession._rv._strR;

Profile p=Profile.find(member);

BBSLevel bl=BBSLevel.find(p.getBbslevel());

ProfileBBS pb=ProfileBBS.find(h.community,member);

String pic=pb.isExists()?pb.getPortrait(h.language):p.getPhotopath(h.language);
tea.entity.site.Community community = tea.entity.site.Community.find(h.community);

StringBuilder sql=new StringBuilder();
sql.append(" AND member="+DbAdapter.cite(member));
int fsum=FriendList.count(sql.toString());

%><html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="<%=community.getJspBeforePath(teasession._nLanguage)%>" type="text/javascript"></SCRIPT>
<h1>个人中心</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<table cellpadding="0" cellspacing="5" class="PersonalCenter">
<tr><td valign="top">
<div class="title">好友最新动态：</div>
<div class="con">
<table cellspacing="0">
<%
ArrayList al=new ArrayList();
DbAdapter db = new DbAdapter();
try
{
  db.executeQuery("SELECT node FROM Node WHERE type=57 AND community=" + DbAdapter.cite(h.community) + " AND vcreator IN(SELECT friend FROM FriendList WHERE member=" + DbAdapter.cite(member) + ") ORDER BY node DESC",0,10);
  while(db.next())al.add(new Integer(db.getInt(1)));
} finally
{
  db.close();
}
Iterator it=al.iterator();
while(it.hasNext())
{
  int nid=((Integer)it.next()).intValue();
  Node n=Node.find(nid);
  String tmp=n.getCreator()._strR;
  out.print("<tr><td><a href='###' onclick=\"f_act('home','"+tmp+"')\">"+tmp+"</a>发表了<a href='/html/bbs/"+nid+"-"+h.language+".htm' target='_blank'>"+n.getSubject(h.language)+"</a>");
}
%>
</table>
</div>
</td></tr>
<tr>
<td valign="top">
<div class="title"><table cellspacing="0" cellpadding="0"><tr><td align=left>我发起的讨论</td><td align="right"><a href="/jsp/type/bbs/MyBBS.jsp?community=<%=h.community%>&member=<%=java.net.URLEncoder.encode(member,"utf-8")%>">更多</a>　　</td></tr></table></div>
<div class="con">
<table border="0" cellpadding="0" cellspacing="0" >
<%
Enumeration eb=BBS.findByMember(h.community,member,0,10);
while(eb.hasMoreElements())
{
  int nid=((Integer)eb.nextElement()).intValue();
  Node n=Node.find(nid);
  out.print("<tr><td><a href='/html/bbs/"+nid+"-"+h.language+".htm' target='_blank'>"+n.getSubject(h.language)+"</a>");
  out.print("<td>"+n.getTimeToString());
}
%>
</table>
</div>
<div class="title"><table cellspacing="0" cellpadding="0"><tr><td align=left>我参与的讨论</td><td align="right"><a href="/jsp/type/bbs/MyBBSReply.jsp?community=<%=h.community%>&member=<%=java.net.URLEncoder.encode(member,"utf-8")%>">更多</a>　　</td></tr></table></div>
<div class="con">
<table border="0" cellpadding="0" cellspacing="0">
<%
Enumeration er=BBSReply.findByMember(h.community,member,0,10);
while(er.hasMoreElements())
{
  int nid=((Integer)er.nextElement()).intValue();
  Node n=Node.find(nid);
  out.print("<tr><td><a href='/html/bbs/"+nid+"-"+h.language+".htm' target='_blank'>"+n.getSubject(h.language)+"</a>");
  out.print("<td>"+n.getTimeToString());
}
%>
</table>
</div>
</td>
<td valign="top">
<div class="PersonalInfo">
<table border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td valign="top"><img src="<%=pic%>"/></td>
  <td valign="top">
    用户名：<%=member%><br/>
    积　分：<%=p.getIntegral()%><br/>
    性　别：<%=p.isSex()?"男":"女"%><br/>
    等　级：<%=MT.f(bl.getName())%><br/>
    图　示：<img src="<%=bl.getPicture()%>"/><br/>
    我的发贴数：<%=BBS.countByMember(h.community,member)%><br/>
    我的回复数：<%=BBSReply.countByMember(h.community,member)%>
   </td>
  </tr>
</table>
</div>
<div class="PersonalInfoBottom"><a href="###" onClick="f_act('msg','<%=member%>')">发短消息</a>
<a href="###" onClick="f_act('add','<%=member%>')">加为好友</a></div>

<div class="title"><table cellspacing="0" cellpadding="0"><tr><td align=left>好友列表：</td><td align="right"><a href="/jsp/user/FriendLists.jsp?community=<%=h.community%>">更多>></a>　　</td></tr></table></div>
<form name="form2" action="/FriendLists.do" method="post" target="_ajax">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="member"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<input type="hidden" name="remark"/>
<div class="con">
<table  cellspacing="0">
<%
if(fsum<1)
{
  out.print("<tr><td colspan='10' align='center'>暂无记录!</td></tr>");
}else
{
  it=FriendList.find(sql.toString(),0,10).iterator();
  for(int i=0;it.hasNext();i++)
  {
    FriendList t=(FriendList)it.next();
    pb = ProfileBBS.find(h.community,t.friend);
    if(i%2==0)out.print("<tr>");
  %>
    <td onMouseOver="bgColor='#FFFFCA'" onMouseOut="bgColor=''"><a href="###" onClick="f_act('home','<%=t.friend%>')"><img style='float:left' src="<%=pb.getPortrait(h.language)%>" width="50" height="50"/><%=t.friend%></a><br/><%=MT.f(t.remark)%><br/><a href="###" onClick="f_act('msg','<%=t.friend%>')">发短消息</a> | <a href="###" onClick="f_act('del','<%=t.friend%>')">删除</a></td>
  <%
  }
}%>
</table></div>
</form>
</td></tr></table>

<script>
form2.nexturl.value=location.pathname+location.search;
function f_act(a,id,b)
{
  form2.act.value=a;
  form2.member.value=id;
  if(a=='del')
  {
    mt.show('你确定要删除吗？',2,'form2.submit()');
  }else if(a=='add')
  {
    form2.nexturl.value='';
    form2.submit();
  }else if(a=='remark')
  {
    mt.show("编辑备注：<input id='_remark' value='"+b+"' >",2,"编辑备注");
    mt.ok=function()
    {
      form2.remark.value=encodeURIComponent($('_remark').value);
      form2.submit();
      return false;
    }
  }else if(a=='msg')
    location='/jsp/message/EditMemberMailbox.jsp?nexturl=/jsp/message/MemberMailbox.jsp%3Ffolder=0&to='+encodeURIComponent(id);
  else if(a=='home')
    location='/jsp/type/bbs/ViewBBSProfile.jsp?community='+form2.community.value+'&member='+encodeURIComponent(id);
}
</script>

<br>
<div id="head6"><img height="6" src="about:blank"></div>
 <SCRIPT LANGUAGE=JAVASCRIPT SRC="<%=community.getJspAfterPath(teasession._nLanguage)%>" type="text/javascript"></SCRIPT>
</body>
</html>
