<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.htmlx.*"%>
<%@ page import="tea.ui.TeaSession"%>
<%@ page import="tea.resource.*" %>
<%@ page import="tea.db.*" %>
<%@ page import="tea.entity.member.*" %>
<%@ page import="tea.entity.node.*" %>
<%@ page import="java.util.Enumeration"%>
<%
TeaSession teasession =new TeaSession(request);
tea.entity.site.Community community=tea.entity.site.Community.find(teasession._strCommunity);

Resource r = new Resource("/tea/ui/util/SignUp1").add("/tea/htmlx/HtmlX");
int regstyle = 0;
if(request.getParameter("regstyle")!=null)
{
  regstyle = Integer.parseInt(request.getParameter("regstyle"));
}

%>
<html>
<head>

<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
</head>
<body id="bdone">
<div id="Content2">
<div class="lujing"><li>当前位置：<a href="/servlet/Folder?node=2">首页</a><span><span id="PathID1"> ><a href="/servlet/Folder?node=2&amp;language=1">中韩友好协会</a></span><span id="PathID2"> ><a href="/servlet/Folder?node=46&amp;language=1">协会组成</a></span><span id="PathID3"> ><a href="/jsp/user/ProfileZhList.jsp"><%=ProfileZh.regTos[regstyle]%><%if(regstyle==1||regstyle==2){out.print("委员会");}%>名单</a></span></span></li></div>

<div class="xijie">
<ul><li><div class="xijie_bt"><span id="CurrentlyNode"><%=ProfileZh.regTos[regstyle]%>名单</span></div><div class="xijie_neirong"><span>
<table cellspacing="0" cellpadding="5" style="font-size:12px;">
<%
Enumeration e = ProfileZh.findByCommunity(teasession._strCommunity," and member in (select member from accessmember) and member in (select member from profilezh where regstyle="+regstyle+") order by time desc",0,1000);

while(e.hasMoreElements())
{
  String member = (String)e.nextElement();
  Profile p = Profile.find(member);
  ProfileZh pz = ProfileZh.find(member);
  String sex = p.isSex()?"男":"女";
  String ace = pz.getComname()+pz.getJob();
  String name = pz.getName();
  if(name.length()==2){
    name = name.substring(0,1)+"　"+name.substring(1,2);
  }
    out.print("<tr><td width=80 align=center vAlign=middle noWrap>");
    if(pz.getIsopen()==1){
      out.print("<a href='/jsp/user/ProZhInfoOpen.jsp?member="+p.getMember()+"'>");
    }
    out.print(name);
    out.print("<td width=80 align=center vAlign=middle noWrap>"+sex);
    out.print("<td noWrap width=357>"+ace);
}

%>
</table>
</span></div></li></ul><img src="/res/china-corea/u/0810/081020106.jpg"></div>

</body>
</html>
