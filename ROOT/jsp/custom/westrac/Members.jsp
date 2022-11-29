<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%><%@page import="tea.entity.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%>
<%@page import="tea.ui.*"%><%@page import="tea.entity.member.*"%><%

Http h=new Http(request,response);

TeaSession teasession=new TeaSession(request);
if(teasession._rv == null)
{
  out.print("<script>alert('您还没有登录或登录已超时，请重新登录！');top.location.replace('/');</script>");
  return;
}

int menuid=h.getInt("id");
StringBuffer sql=new StringBuffer(),par=new StringBuffer("?");
par.append("&community="+h.community+"&id="+menuid);

sql.append(" AND member!='webmaster'");
String member=h.get("member","");
if(member.length()>0)
{
  sql.append(" AND member LIKE "+DbAdapter.cite("%"+member+"%"));
  par.append("&member="+Http.enc(member));
}

int sex=h.getInt("sex",-1);
if(sex!=-1)
{
  sql.append(" AND sex="+sex);
  par.append("&sex="+sex);
}


Date times=h.getDate("times");
if(times!=null)
{
  sql.append(" AND time>"+DbAdapter.cite(times));
  par.append("&times="+MT.f(times));
}

Date timee=h.getDate("timee");
if(timee!=null)
{
  sql.append(" AND time<"+DbAdapter.cite(timee));
  par.append("&timee="+MT.f(timee));
}
int city=h.getInt("city1",h.getInt("city0"));
if(city>0)
{
  sql.append(" AND EXISTS(SELECT member FROM ProfileLayer pl WHERE p.member=pl.member");
  sql.append(" AND pl.province LIKE '"+city+"%'");
  par.append("&city="+city);

  sql.append(")");
}

int pos=h.getInt("pos");
int sum=Profile.count(sql.toString());
par.append("&pos=");

sql.append(" ORDER BY time DESC");




%>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/tea/city.js" type="text/javascript"></script>
<script src="/tea/Calendar.js" type="text/javascript"></script>
</head>
<body>
<h1>会员管理</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<h2>查询</h2>
<form name="form1" action="?">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="id" value="<%=menuid%>"/>
<table id="tablecenter" cellspacing="0">
<tr>
  <td>用户名:<input name="member" value="<%=member%>"/></td>
  <td>工作地点:<script>mt.city('city0','city1',null,'<%=city%>')</script></td>
<tr>
  <td>注册时间:<input name="times" value="<%=MT.f(times)%>" size="12" onClick="new Calendar().show('form1.times')"/> 至 <input name="timee" value="<%=MT.f(timee)%>" size="12" onClick="new Calendar().show('form1.timee')"/></td>
  <td><input type="submit" value="查询"/></td>
</tr>
</table>
</form>

<h2>列表 <%=sum%></h2>
<form name="form2" action="/Members.do" method="post" target="_ajax">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="key" />
<input type="hidden" name="member"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>

<table id="tablecenter" cellspacing="0">
<tr id="tableonetr">
  <td>&nbsp;</td>
  <td nowrap>用户</td>
  <td nowrap>昵称</td>
  <td nowrap>工作地点</td>
  <td nowrap>注册时间</td>
  <td nowrap>工分</td>
  <td nowrap>操作</td>
</tr>
<%
if(sum<1)
{
  out.print("<tr><td colspan='10' align='center'>暂无记录!</td></tr>");
}else
{
  Enumeration e=Profile.find(sql.toString(),pos,20);
  while(e.hasMoreElements())
  {
    String mid=(String)e.nextElement();
    Profile p=Profile.find(mid);
    ProfileBBS pb=ProfileBBS.find(h.community,mid);

  %>
  <tr onMouseOver="bgColor='#FFFFCA'" onMouseOut="bgColor=''">
    <td><input type="checkbox" name="members" value="<%=mid%>"/></td>
    <td><%
    out.print(mid);
    if(p.isLocking())out.print(" <font color='#FF0000'>[锁定]</font>");
    Date gag=p.getGag();
    if(gag!=null&&gag.getTime()>System.currentTimeMillis())out.print(" <font color='#FF0000'>[禁言至"+MT.f(gag)+"]</font>");
    %></td>
    <td><%=MT.f(pb.getSignature(h.language))%></td>
    <td><%=Card.find(p.getProvince(h.language)).toString()%></td>
    <td><%=MT.f(p.getTime(),1)%></td>
    <td><%=p.getIntegral()%></td>
    <td>
       <input type="button" value="清空密码" onClick="f_act('clear','<%=mid%>')"/>
       <input type="button" value="勋章" onClick="f_act('medal','<%=mid%>')"/>
    </td>
  </tr>
  <%}
%>
<tr>
<td colspan="4"><input type="checkbox" onClick="mt.select(form2.members,checked)" id="select"/><label for="select">全选</label>
<input type="button" name="multi" value="批量删除" onClick="f_act('dels','')"/>
<input type="button" name="multi" value="发送E-Mail" onClick="f_act('email','',value)"/>
<input type="button" name="multi" value="发送站内信" onClick="f_act('msg','',value)"/>
<input type="button" value="导出Excel" onClick="f_act('exp','')"/>
<input type="button" name="multi" value="锁定会员" onClick="f_act('lock')"/>
<input type="button" name="multi" value="添加勋章" onClick="f_act('medals',mt.value(form2.members,','))"/>
<input type="button" name="multi" value="禁言" onClick="f_act('gag')"/>
</td>
<td colspan='9' align='right'>
<%
out.print(new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,20));
}%></td></tr>
</table>
<%--
<input type="button" value="添加" onclick="f_act('edit','')"/>
--%>
</form>

<script>
mt.disabled(form2.members);
form2.nexturl.value=location.pathname+location.search;
function f_act(a,id,b,c)
{
  form2.act.value=a;
  form2.member.value=id;
  if(a=='dels')
  {
    mt.show("确认要删除吗？",2,"form2.submit()");
  }else if(a=='edit')
  {
    form2.action="/jsp/doc/DocMember"+(id?"Edit":"Add")+".jsp";
    form2.method="get";
    form2.target="_self";
    form2.submit();
  }else if(a=='order')
  {
    form2.action="/jsp/doc/DocMemberOrders.jsp"; form2.method="get"; form2.target="_self"; form2.submit();
  }else if(a=='clear')
  {
    mt.show("确认要清空“"+id+"”密码吗？",2,"form2.submit()");
  }else if(a=='email'||a=='msg')
  {
    mt.show("/jsp/profile/MemberSend.jsp?community=<%=h.community%>&act="+a+"&member="+encodeURIComponent(mt.value(form2.members,",")),2,b,600,420);
  }else if(a=='exp')
  {
    form2.act.value='westracexp';
    form2.key.value="<%=MT.enc(sql.toString())%>";
    form2.submit();
  }else if(a=='medal'||a=='medals')
  {
    mt.show('/jsp/community/MedalsInc.jsp?community=<%=h.community%>&act='+a+'&member='+encodeURIComponent(id),2,'勋章',600,500);
  }else if(a=='gag')
  {
    mt.show("<input name=gag type=radio id='_gag0' checked><label for='_gag0'>取消禁言</label><br/><input name=gag type=radio id='_gag1'><label for='_gag1'>禁言</label><input name=day size=5>天",2);
    mt.ok=function()
    {
      var b=$('_gag1').checked,v=$('day').value;
      if(!b)v='0';
      if(v=='')
      {
        alert('“禁言天数”不能为空！');
        return false;
      }
      form2.action+='?gag='+b+'&day='+v;
      form2.submit();
    };
  }else
    form2.submit();
}
</script>
</body>
</html>
