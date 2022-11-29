<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%><%@page import="tea.ui.*"%><%@page import="tea.entity.member.*"%><%@page import="tea.entity.admin.*"%><%@page import="tea.entity.*"%><%@page import="tea.db.*"%><%@page import="tea.entity.node.*"%><%@page import="tea.entity.bbs.*"%><%

TeaSession teasession=new TeaSession(request);
Node n=Node.find(teasession._nNode);

teasession._nNode=n.getType()==1?teasession._nNode:n.getFather();


BBSForum bf=BBSForum.find(teasession._nNode);
String url="/jsp/type/bbs/EditBBS.jsp?NewNode=ON&node="+teasession._nNode+"&special=";

int special=-1;

String member=teasession._rv!=null?teasession._rv._strR:null;


StringBuilder sb=new StringBuilder();


if(bf.isAuth(teasession._strCommunity,member,bf.ltopic,bf.rtopic))
{
  if(special==-1)special=0;
  sb.append("<tr><td><a href='"+url+"0'><img src='/tea/image/bbslevel/s0.gif'>发新话题</a>");
}

if(bf.isAuth(teasession._strCommunity,member,bf.lpoll,bf.rpoll))
{
  if(special==-1)special=1;
  sb.append("<tr><td><a href='"+url+"1'><img src='/tea/image/bbslevel/s1.gif'>发布投票</a>");
}

if(bf.isAuth(teasession._strCommunity,member,bf.lactivity,bf.ractivity))
{
  if(special==-1)special=2;
  sb.append("<tr><td><a href='"+url+"2'><img src='/tea/image/bbslevel/s2.gif'>发布活动</a>");
}

if(bf.isAuth(teasession._strCommunity,member,bf.lrec,bf.rrec))
{
  if(special==-1)special=3;
  sb.append("<tr><td><a href='"+url+"3'><img src='/tea/image/bbslevel/s3.gif'>发布招聘</a>");
}

if(bf.isAuth(teasession._strCommunity,member,bf.ljob,bf.rjob))
{
  if(special==-1)special=4;
  sb.append("<tr><td><a href='"+url+"4'><img src='/tea/image/bbslevel/s4.gif'>发布求职</a>");
}

if(special==-1)
{
  if(member!=null)return;
  url="/servlet/StartLogin?node="+n._nNode+"&";
}

out.print("<table onmouseover='bps()' onmouseout='bph()' cellspacing=10 style='position:absolute;background:#FFFFFF;border:1px solid #DDDDDD;display:none'>"+sb.toString()+"</table>");
out.print("<a href='"+url+special+"' class='bbspost' onmouseover='bps(this)' onmouseout='bph()'></a>");

%>
<script>
var bpinter,bbspost;
function bps(a){clearTimeout(bpinter);if(a){bbspost=a.previousSibling;if(!bbspost)return;bbspost=bbspost.style;bbspost.marginTop=a.offsetHeight+'px';}bbspost.display='';}
function bph(){if(!bbspost)return;bpinter=setTimeout(function(){bbspost.display='none'},200);}
</script>
