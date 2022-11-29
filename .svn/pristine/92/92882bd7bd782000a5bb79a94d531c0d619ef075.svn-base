<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%><%@page import="tea.ui.*"%>
<%@page import="tea.entity.member.*"%><%

Http h=new Http(request,response);
TeaSession teasession = new TeaSession(request);
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}
h.member=h.get("member");
if(h.member==null)//h.member=teasession._rv.toString();

int menuid=h.getInt("id");
StringBuffer sql=new StringBuffer(),par=new StringBuffer();
par.append("?community="+h.community+"&id="+menuid);

sql.append(" AND member="+DbAdapter.cite(h.member));


String friend=h.get("friend","");
if(friend.length()>0)
{
  sql.append(" AND friend LIKE "+DbAdapter.cite("%"+friend+"%"));
  par.append("&friend="+h.enc(friend));
}

int type=h.getInt("type");
if(type>0)
{
  sql.append(" AND type LIKE "+DbAdapter.cite("%"+type+"%"));
  par.append("&type="+type);
}

int groups=h.getInt("groups");
if(groups>0)
{
  sql.append(" AND groups LIKE "+DbAdapter.cite("%"+groups+"%"));
  par.append("&groups="+groups);
}

String remark=h.get("remark","");
if(remark.length()>0)
{
  sql.append(" AND remark LIKE "+DbAdapter.cite("%"+remark+"%"));
  par.append("&remark="+h.enc(remark));
}




int pos=h.getInt("pos");
int sum=FriendList.count(sql.toString());
par.append("&pos=");

%>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>我的好友</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<%--
<h2>查询</h2>
<form name="form1" action="?">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="id" value="<%=menuid%>"/>
<table id="tablecenter" cellspacing="0">
<tr>
  <td>好友:<input name="friend" value="<%=friend%>"/></td>
  <td>朋友分类:<input name="type" value="<%=type%>"/></td>
  <td>好友分组:<input name="groups" value="<%=groups%>"/></td>
  <td>备注:<input name="remark" value="<%=remark%>"/></td>
  <td><input type="submit" value="查询"/></td>
</tr>
</table>
</form>
--%>

<h2>列表 <%=sum%></h2>
<form name="form2" action="/FriendLists.do" method="post" target="_ajax">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="member"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<input type="hidden" name="remark"/>
<table id="tablecenter" cellspacing="0">
<%
if(sum<1)
{
  out.print("<tr><td colspan='10' align='center'>暂无记录!</td></tr>");
}else
{
  Iterator it=FriendList.find(sql.toString(),pos,20).iterator();
  for(int i=0;it.hasNext();i++)
  {
    FriendList t=(FriendList)it.next();
    ProfileBBS pb = ProfileBBS.find(h.community,t.friend);
    if(i%5==0)out.print("<tr>");
  %>
    <td onMouseOver="bgColor='#FFFFCA'" onMouseOut="bgColor=''"><a href="javascript:f_act('home','<%=t.friend%>')"><img style='float:left' src="<%=pb.getPortrait(h.language)%>" width="50" height="50"/><%=t.friend%></a><br/><%=MT.f(t.remark)%>[<a href="###" onclick="f_act('remark','<%=t.friend%>','<%=MT.f(t.remark)%>')">+编辑备注</a>]<br/><a href="###" onclick="f_act('msg','<%=t.friend%>')">发短消息</a> | <a href="javascript:f_act('home','<%=t.friend%>')">个人资料</a> | <a href="###" onclick="f_act('del','<%=t.friend%>')">删除</a></td>
  <%}
  if(sum>20)out.print("<tr><td colspan='10' align='right'>"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,20));
}%>
</table>
<br/>
<input type="button" value="添加" onclick="f_act('add','')"/>
</form>

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
    mt.show("添加登录名：<input id='_member' >",2,"添加好友");
    mt.ok=function()
    {
      form2.member.value=$('_member').value;
      form2.submit();
      return false;
    }
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
</body>
</html>
