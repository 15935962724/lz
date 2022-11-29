<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.db.DbAdapter" %><%@page import="tea.resource.*" %><%@page import="tea.entity.*"%><%@page import="tea.entity.admin.*"%><%@page import="tea.entity.node.*"%><%@page import="tea.entity.bbs.*"%><%@page import="tea.entity.site.*"%><%@page import="tea.ui.*"%><%@page import="java.util.*"%><%@page import="tea.entity.member.*"%><%@page import="tea.htmlx.*"%><%@page import="tea.html.HtmlElement"%><%

Http h=new Http(request,response);

TeaSession teasession = new TeaSession(request);
if(teasession._rv == null)
{
  out.print("<script>location.replace('/servlet/StartLogin?node="+h.node+"&nexturl="+Http.enc(request.getRequestURI()+"?"+request.getQueryString())+"')</script>");
  return;
}

StringBuffer sql=new StringBuffer(),par=new StringBuffer();
par.append("?node="+h.node);

String nexturl=h.get("nexturl","/jsp/type/bbs/BBSManage.jsp");
par.append("&nexturl="+Http.enc(nexturl));

Resource r=new Resource();

int pos=h.getInt("pos");
par.append("&pos=");

Node n=Node.find(h.node);
if(n.getTime()==null)
{
  out.print("<script>alert('该贴子不存在');history.back();</script>");
  return;
}

String member=n.getCreator()._strR;
BBS bbs=BBS.find(h.node,h.language);
Profile p = Profile.find(member);
ProfileBBS pb = ProfileBBS.find(h.community,member);
BBSLevel bl = BBSLevel.find(p.getBbslevel());

boolean isM=teasession._rv._strR.equals(Communitybbs.find(teasession._strCommunity).getSuperhost()) //超级版主
      || AdminUsrRole.find(teasession._strCommunity,teasession._rv._strR).getBbsHost().indexOf("/" + n.getFather() + "/") != -1;

//查阅
bbs.setSearch(1);
bbs.setSearch(teasession._rv._strR,new Date());

%><html><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/mt.js" type="text/javascript"></script>
<body>

<h1>帖子查阅</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" action="">
<input type="hidden" name="node" value="<%=h.node%>">
<input type="hidden" name="nexturl" value="<%=nexturl%>">
</form>



<table cellspacing="0" cellpadding="0" id="tablecenter">
  <tr>
    <td colspan="3"><%=n.getSubject(h.language)%></td>
  </tr>
  <tr>
    <td rowspan="2" valign="top" width="160px">
     <%=pb.getTitle(h.language)%><br/>
     <img src="<%=pb.getPortrait(h.language)%>" /><br/>
      等级：<%if(bl.isExists())out.print( bl.getName()+"<img src='" + bl.getPicture() + "'/>");%><br />
      ＩＤ：<%=member%><br />
      发贴：<%=bbs.getCount(member)%><br />
      ＩＰ：<%=bbs.getIp()%></td>
    <td>发表于：<%=n.getTimeToString()%></td>
    <td align="right">
      <%
      if(isM||teasession._rv.equals(member))
      {
        out.print("<input class='edit' type='button' value=" + r.getString(h.language,"CBEdit") + " onclick=mt.act('edit')>"
        + " <input class='del' type='button' value=" + r.getString(h.language,"CBDelete") + " onclick=mt.act('del',0) >");
      }
      %></td>
  </tr>
  <tr>
    <td colspan="2" valign="top"><%=bbs.getHtml(h)%></td>
  </tr>
</table>
<%
int sum = BBSReply.count(h.node,h.username,h.language);
Enumeration e=BBSReply.find(h.node,h.username,h.language,pos,20);
for(int i=1+pos;e.hasMoreElements();i++)
{
  int brid = ((Integer) e.nextElement()).intValue();
  BBSReply br = BBSReply.find(brid);
  member=br.getMember();
  p = Profile.find(member);
  pb = ProfileBBS.find(h.community,member);
  bl = BBSLevel.find(p.getBbslevel());
%>
<table cellspacing="0" cellpadding="0" id="tablecenter">
  <tr>
    <td colspan="3"><%=br.getSubject(h.language)%><span style="float:right"><%=i%>楼</span></td>
  </tr>
  <tr>
    <td rowspan="2" valign="top" width="160px">
     <%=pb.getTitle(h.language)%><br/>
     <img src="<%=pb.getPortrait(h.language)%>" /><br/>
      等级：<%if(bl.isExists())out.print( bl.getName()+"<img src='" + bl.getPicture() + "'/>");%><br />
      ＩＤ：<%=member%><br />
      发贴：<%=bbs.getCount(member)%><br />
      ＩＰ：<%=bbs.getIp()%></td>
    <td>发表于：<%=br.getTimeToString()%></td>
    <td align="right">
    <%
    if(isM && bbs.getBest() == 0)
    {
      out.print("<input class='best' type='button' value='" + r.getString(h.language,"最佳答案") + "' onclick=\"location='/servlet/EditBBSReply?replay=" + brid + "&node=" + h.node + "&best=ON&nexturl='+encodeURIComponent(location); \">");
    }
    if(isM||teasession._rv._strR.equals(br.getMember()))
    {
      out.print(" <input class='edit' type='button' value=" + r.getString(h.language,"CBEdit") + " onclick=mt.act('redit'," + brid + ")>" +
      " <input class='del' type='button' value=" + r.getString(h.language,"CBDelete") + " onclick=\"mt.show('" + r.getString(h.language,"ConfirmDelete") + "',2);mt.ok=function(){mt.post('/servlet/EditBBSReply?act=del&node=" + h.node + "&bbsreply=" + brid + "')}\" >");
    }
    %>
    </td>
  </tr>
  <tr>
    <td colspan="2" valign="top"><%=br.getHtml(h.language)%></td>
  </tr>
</table>
<%
}
%>
<%=new tea.htmlx.FPNL(teasession._nLanguage,par.toString(),pos,sum,20)%>

<form name="form2" action="/servlet/EditBBS" target="_ajax">
<input type="hidden" name="node" value="<%=h.node%>">
<input type="hidden" name="nexturl">
<input type="hidden" name="bbsreply">
<input type="hidden" name="act">

<input type="button" value="<%=bbs.isQuintessence()?"取消":""%>精华" onclick="mt.act('quintessence')"/>
<input type="button" value="<%=bbs.isParktop()?"取消":""%>置顶" onclick="mt.act('parktop')"/>
<input type="button" value="返回" onclick="history.back()"/>
</form>
<script>
form2.nexturl.value=location.pathname+location.search;
mt.act=function(a,i)
{
  form2.act.value=a;
  if(a=='del')
  {
    mt.show('<%=r.getString(h.language,"ConfirmDelete")%>',2);
    mt.ok=function(){form2.nexturl.value=form1.nexturl.value;form2.submit();}
    return;
  }else if(a=='edit')
  {
    form2.action='/jsp/type/bbs/EditBBS.jsp';
    form2.target="_self";
  }else if(a=='redit')
  {
    form2.action='/jsp/type/bbs/EditBBSReply.jsp';
    form2.target="_self";
  }
  form2.bbsreply.value=i;
  form2.submit();
}
</script>
