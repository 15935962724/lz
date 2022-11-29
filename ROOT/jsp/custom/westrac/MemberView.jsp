<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page import="tea.entity.util.*" %><%@ page import="java.util.*" %><%@ page  import="tea.resource.Resource" %><%@ page import="tea.entity.bbs.*" %><%@ page import="tea.entity.node.*" %><%@ page import="tea.entity.member.*" %><%@ page import="tea.entity.*" %><%@ page import="tea.entity.admin.*" %><%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");


Http h=new Http(request);

TeaSession teasession=new TeaSession(request);
if(teasession._rv == null)
{
  out.print("<script>location.replace('/servlet/StartLogin?node="+h.node+"&nexturl="+Http.enc(request.getRequestURI()+"?"+request.getQueryString())+"')</script>");
  return;
}

String member=h.get("member");
if(member==null)member=teasession._rv._strR;

//是否是查看自已的主页
boolean isA=member.equals(teasession._rv._strR);

Profile p=Profile.find(member);
int city=p.getProvince(h.language);

BBSLevel bl=BBSLevel.find(p.getBbslevel());

ProfileBBS pb=ProfileBBS.find(h.community,member);

String pic=pb.getPortrait(h.language);
tea.entity.site.Community community = tea.entity.site.Community.find(h.community);

StringBuilder sql=new StringBuilder();
sql.append(" AND member="+DbAdapter.cite(member));
int fsum=FriendList.count(sql.toString());



if(h.getBool("ifr"))
{
  out.print("<!DOCTYPE html><html><head>");
  out.print("<script>");
  out.print("document.write(parent.document.getElementsByTagName('HEAD')[0].innerHTML);");
  out.print("var arr=parent.document.getElementsByTagName('LINK');");
  out.print("for(var i=0;i<arr.length;i++)document.write('<link href='+arr[i].href+' rel='+arr[i].rel+' type=text/css>');");
  out.print("</script></head><body class=ifrmemberview>");
}
%>
<table cellpadding="0" cellspacing="0" class="PersonalCenter">
<tr>
<td valign="top" class="PersonalTd1">
<div class="title"><table cellspacing="0" cellpadding="0"><tr><td align=left>发过的贴子</td><td align="right"><a href="/html/folder/4-1.htm?member=<%=Http.enc(member)%>">更多</a></td></tr></table></div>
<div class="con">
<table border="0" cellpadding="0" cellspacing="0" >
<tr class="trtitle"><td>所属位置</td><td>标题</td><td>发布时间</td><td>回复</td>
<%
Enumeration eb=BBS.findByMember(h.community,member,0,10);
while(eb.hasMoreElements())
{
  int nid=((Integer)eb.nextElement()).intValue();
  Node n=Node.find(nid);
  if(n.getFinished()!=2){
  BBS b=BBS.find(nid,h.language);
  out.print("<tr><td class=td01 nowrap=nowrap>【"+Node.find(n.getFather()).getAnchor(h.language)+"】</td>");
  out.print("<td class=td02><a href='/html/bbs/"+nid+"-"+h.language+".htm' target='_blank'>"+n.getSubject(h.language)+"</a></td>");
  out.print("<td class=td03>"+MT.f(n.getTime(),1)+"</td>");
  out.print("<td class=td04>"+b.getReplyCount()+"</td>");
  }
}
%>
</table>
</div>
<div class="title"><table cellspacing="0" cellpadding="0"><tr><td align=left>回复的贴子</td><td align="right"><a href="/html/folder/5-1.htm?member=<%=java.net.URLEncoder.encode(member,"utf-8")%>">更多</a></td></tr></table></div>
<div class="con">
<table border="0" cellpadding="0" cellspacing="0">
<tr class="trtitle"><td>所属位置</td><td>标题</td><td>发布时间</td>
<%
Enumeration er=BBSReply.findByMember(h.community,member,0,10);
while(er.hasMoreElements())
{
  int nid=((Integer)er.nextElement()).intValue();
  Node n=Node.find(nid);
  if(n.getFinished()!=2){
  out.print("<tr><td class=td01 nowrap=nowrap>【"+Node.find(n.getFather()).getAnchor(h.language)+"】</td>");
  out.print("<td class=td02><a href='/html/bbs/"+nid+"-"+h.language+".htm' target='_blank'>"+n.getSubject(h.language)+"</a></td>");
  out.print("<td class=td03>"+MT.f(n.getTime(),1)+"</td></tr>");
  }
}
%>
</table>
</div>
<div class="title3">好友最新动态</div>
<div class="con3">
<table cellspacing="0">
<%=FriendList.dynamic(h,member,5)%>
</table>
</div>
</td>
<td class="PersonalTd2"></td>
<td valign="top" id="TabTD">
<div class="title4">个人档案</div>
<div class="PersonalInfo">
<table border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td valign="top"><img src="<%=pic%>"/><br/>
    <%=member%><br/>
    论坛工分：<%=p.getIntegral()%><br/>
    论坛等级：<%=MT.f(bl.getName())%><br/>
    <%if(p.getMembertype()==1){ %>
    俱乐部积分：<%=p.getMyintegral() %><br/>
    <%} %>
    来自：<%=city<1?"":Card.find(city).toString()%><br/>
    注册时间：<%=p.getTimeToString()%><br/>
    最后登陆：<%=MT.f(Logs.getLastLogin(member))%>
   </td>
  </tr>
</table>
</div>
<div class="PersonalInfoBottom">
<%
if(!isA)
{
  if(FriendList.find(teasession._rv._strR,member).time==null)
  out.print("<a href='###' onClick=\"f_act('add','"+member+"')\">加为好友</a>");
  else
  out.print("<a href='###' onClick=\"f_act('del','"+member+"')\">删除好友</a>");

  out.print("<a href='###' onClick=\"f_act('msg','"+member+"')\">发短消息</a>");
}
%>
</div>

<div class="title2"><table cellspacing="0" cellpadding="0"><tr><td align=left>好友列表：</td><td align="right"><a href="/html/folder/6-1.htm?member=<%=Http.enc(member)%>">更多>></a>　　</td></tr></table></div>
<form name="form2" action="/FriendLists.do" method="post" target="_ajax">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="member"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<input type="hidden" name="remark"/>
<div class="con2">
<table  cellspacing="0">
<%
if(fsum<1)
{
  out.print("<tr><td colspan='10' align='center'>暂无记录!</td></tr>");
}else
{
  Iterator it=FriendList.find(sql.toString(),0,4).iterator();
  for(int i=0;it.hasNext();i++)
  {
    FriendList t=(FriendList)it.next();
    pb = ProfileBBS.find(h.community,t.friend);
    if(i%2==0)out.print("<tr>");
  %>
    <td><a href="###" onClick="f_act('home','<%=t.friend%>')"><img src="<%=pb.getPortrait(h.language)%>" width="50" height="50"/><br/><span class="name"><%=t.friend%></span></a><br/><a href="###" onClick="f_act('msg','<%=t.friend%>')">发短消息</a>
  <%
    if(isA)out.print("<br/><a href='###' onClick=\"f_act('del','"+t.friend+"')\">删除</a>");
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
    window.open('/jsp/message/EditMemberMailbox.jsp?nexturl=/jsp/message/MemberMailbox.jsp%3Ffolder=0&to='+encodeURIComponent(id));
  else if(a=='home')
    location='/html/folder/3-1.htm?member='+encodeURIComponent(id);
}
<%if(h.getBool("ifr"))out.println("mt.fit();");%>
</script>
