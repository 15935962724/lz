<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%><%@page import="tea.ui.*"%>
<%@page import="tea.entity.member.*"%><%


TeaSession teasession = new TeaSession(request);
Http h=new Http(request,response);
if(teasession._rv == null)
{
  out.print("<script>location.replace('/servlet/StartLogin?node="+h.node+"&nexturl="+Http.enc(request.getRequestURI()+"?"+request.getQueryString())+"')</script>");
  return;
}

StringBuffer sql=new StringBuffer(),par=new StringBuffer();
par.append("?community="+h.community);
sql.append(" AND member="+DbAdapter.cite(h.username));


int sum=FriendList.count(sql.toString());

int pos=h.getInt("pos");
par.append("&pos=");

%>
<div class="title">好友动态</div>
<div class="con3">
<table cellspacing="0">
<%=FriendList.dynamic(h,h.username,15)%>
</table>
</div>
<form name="form2" action="/FriendLists.do" method="post" target="_ajax">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="member"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<input type="hidden" name="remark"/>
<div class="FriendsList">
<div class="title">好友列表</div>
<table cellspacing="0">
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
    <td onMouseOver="bgColor='#FFFFCA'" onMouseOut="bgColor=''"><a href="javascript:f_act('home','<%=t.friend%>')"><img src="<%=pb.getPortrait(h.language)%>" width="50" height="50"/><br/><%=t.friend%></a><br/><a href="###" onclick="f_act('msg','<%=t.friend%>')">发短消息</a><br/><a href="###" onclick="f_act('del','<%=t.friend%>')">删除</a></td>
  <%}
  if(sum>20)out.print("<tr><td colspan='10' align='right'>"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,20));
}%>
</table>
</div>
<!--<input type="button" value="添加" onclick="f_act('add','')"/>-->
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
    window.open('/jsp/message/EditMemberMailbox.jsp?nexturl=/jsp/message/MemberMailbox.jsp%3Ffolder=0&to='+encodeURIComponent(id));
  else if(a=='home')
    location='/html/folder/3-1.htm?member='+encodeURIComponent(id);
}
</script>
