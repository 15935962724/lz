<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%><%@page import="tea.entity.weixin.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}

StringBuffer sql=new StringBuffer(),par=new StringBuffer();

int menuid=h.getInt("id");
par.append("?id="+menuid);

sql.append(" AND community="+DbAdapter.cite(h.community));
par.append("&community="+h.community);

WeiXin wx=WeiXin.find(h.community);

int tab=h.getInt("tab");
while(tab<WeiXin.USER_TYPE.length&&wx.userid[tab]==null)tab++;
sql.append(" AND userid="+DbAdapter.cite(wx.userid[tab]));
par.append("&tab="+tab);

int gender=h.getInt("gender");
if(gender>0)
{
  sql.append(" AND gender="+gender);
  par.append("&gender="+gender);
}

int wxgroup=h.getInt("wxgroup",-1);
if(wxgroup!=-1)
{
  sql.append(" AND wxgroup"+(wxgroup==0?"!=80":"="+wxgroup));
  par.append("&wxgroup="+wxgroup);
}

int score1=h.getInt("score1");
if(score1!=-1)
{
  sql.append(" AND score>="+score1);
  par.append("&score1="+score1);
}

String nickname=h.get("nickname","");
if(nickname.length()>0)
{
  sql.append(" AND(nickname LIKE "+DbAdapter.cite("%"+nickname+"%")+" OR remarkname LIKE "+DbAdapter.cite("%"+nickname+"%")+")");
  par.append("&nickname="+h.enc(nickname));
}

String location=h.get("location","");
if(location.length()>0)
{
  sql.append(" AND location LIKE "+DbAdapter.cite("%"+location+"%"));
  par.append("&location="+h.enc(location));
}

String signature=h.get("signature","");
if(signature.length()>0)
{
  sql.append(" AND signature LIKE "+DbAdapter.cite("%"+signature+"%"));
  par.append("&signature="+h.enc(signature));
}

Date stime=h.getDate("stime");
if(stime!=null)
{
  sql.append(" AND time>"+DbAdapter.cite(stime));
  par.append("&stime="+MT.f(stime));
}

Date etime=h.getDate("etime");
if(etime!=null)
{
  sql.append(" AND time<"+DbAdapter.cite(etime));
  par.append("&etime="+MT.f(etime));
}

int order=h.getInt("order",6);
par.append("&order="+order);

boolean desc=!"false".equals(h.get("desc"));
par.append("&desc="+desc);

int pos=h.getInt("pos");
par.append("&pos=");

int sum=WxUser.count(sql.toString());
String wgs=WxGroup.options(" AND community="+DbAdapter.cite(h.community),wxgroup);

if(h.debug)out.print("<!-- "+sql.toString()+" -->");

%>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<link href="/tea/image/weixin/emoji.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<style>
#O<%=order%>{background:url(/tea/mt/order<%=desc?0:1%>.gif) no-repeat right;padding-right:8px}
</style>
</head>
<body>
<h1>用户管理</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<h2>查询</h2>
<form name="form1" action="?">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="id" value="<%=menuid%>"/>
<input type="hidden" name="tab" value="<%=tab%>"/>
<input type="hidden" name="order" value="<%=order%>"/>
<input type="hidden" name="desc" value="<%=desc%>"/>
<table id="tablecenter" cellspacing="0">
<tr>
  <td class="th">名称:</td><td><input name="nickname" value="<%=nickname%>"/></td>
  <td class="th">性别:</td><td><select name="gender"><%=h.options(WxUser.GENDER_TYPE,gender)%></select></td>
  <td class="th">分组:</td><td><select name="wxgroup"><option value="-1">--</option><option value="0">已关注<%=wgs%></select></td>
</tr>
<tr>
  <td class="th">地区:</td><td><input name="location" value="<%=location%>"/></td>
  <td class="th">签名:</td><td><input name="signature" value="<%=signature%>"/></td>
  <td class="th">时间:</td><td><input name="stime" value="<%=MT.f(stime)%>" onclick="mt.date(this)" class="date"/> - <input name="etime" value="<%=MT.f(etime)%>" onclick="mt.date(this)" class="date"/>　<input type="submit" value="查询"/></td>
</tr>
</table>
</form>

<h2>列表 <%=sum%></h2>
<form name="form2" action="/WxUsers.do" method="post" target="_ajax">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="wxuser"/>
<input type="hidden" name="wxgroup"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<input type="hidden" name="name"/>
<input type="hidden" name="remark"/>
<input type="hidden" name="price"/>
<input type="hidden" name="ftype" value="<%=tab%>"/>
<%
out.print("<div class='switch'>");
for(int i=0;i<WeiXin.USER_TYPE.length;i++)
{
  if(wx.userid[i]==null)continue;
  out.print("<a href='javascript:mt.tab("+i+")' class='"+(tab==i?"current":"")+"'>"+WeiXin.USER_TYPE[i]+"</a>");
}
out.print("</div>");
%>
<table id="tablecenter" cellspacing="0">
<tr id="tableonetr">
  <td>序号</td>
  <td><a href="javascript:mt.order('O1')" id="O1">名称</a></td>
  <td><a href="javascript:mt.order('O2')" id="O2">分组</td>
  <td><a href="javascript:mt.order('O3')" id="O3">地区</td>
  <td>签名</td>
  <td class="score"><a href="javascript:mt.order('O5')" id="O5">得分</td>
  <td><a href="javascript:mt.order('O6')" id="O6">时间</td>
  <td>操作</td>
</tr>
<%
if(sum<1)
{
  out.print("<tr><td colspan='10' align='center'>暂无记录!</td></tr>");
}else
{
  String[] ORDER_TYPE={"wxuser","nickname","wxgroup","location","","score","time"};
  sql.append(" ORDER BY "+ORDER_TYPE[order]+(desc?" DESC":" ASC")+",wxuser"+(desc?" DESC":" ASC"));
  Iterator it=WxUser.find(sql.toString(),pos,20).iterator();
  for(int i=1+pos;it.hasNext();i++)
  {
    WxUser t=(WxUser)it.next();
  %>
  <tr>
    <td><%=i%></td>
    <td><%=t.getAnchor()%></td>
    <td><%=t.wxgroup<1?"":WxGroup.find(h.community,t.wxgroup).name%></td>
    <td><%=MT.f(t.location)%></td>
    <td><%=MT.f(t.signature)%></td>
    <td class="score"><%=MT.f(t.score)%></td>
    <td><%=MT.f(t.time,1)%></td>
    <td>
      <a href="javascript:mt.act('View',<%=t.wxuser%>)">查看</a>
      <a href="javascript:mt.act('Send',<%=t.wxuser%>)">发送</a>
      <a href="javascript:mt.act('red',<%=t.wxuser%>)">红包</a>
      <a href="javascript:mt.act('group',<%=t.wxuser%>,<%=t.wxgroup%>)">分组</a>
      <!--
      <a href="javascript:f_act('edit',<%=t.wxuser%>)">编辑</a>
      <a href="javascript:f_act('del',<%=t.wxuser%>)">删除</a>
      -->
    </td>
  </tr>
  <%
  }
  if(sum>20)out.print("<tr><td colspan='10' align='right'>"+new tea.htmlx.FPNL(h.language,par.toString(),pos,sum,20));
}%>
</table>
<input type="button" value="同步" onclick="mt.act('sync',0)"/>
</form>

<script>
var wg=form1.wxgroup;wg.value="<%=wxgroup%>";
wg=wg.options;
for(var i=2;i<wg.length;i++)wg[i].text="　"+wg[i].text;

form2.nexturl.value=location.pathname+location.search;
mt.act=function(a,id,b)
{
  form2.act.value=a;
  form2.wxuser.value=id;
  if(a=='del')
  {
    mt.show('你确定要删除吗？',2,'form2.submit()');
  }else if(a=='sync')
  {
    mt.show(null,0);
    form2.submit();
  }else if(a=='group')
  {
    mt.show("移动到：<select id='_group'><option value='0'>--<%=wgs%></select>",2,"form2.wxgroup.value=$$('_group').value;form2.submit()");
    $$('_group').value=b;
  }else if(a=='red')
  {
    mt.show("名称：<input id=_name value=新年快乐！><br>备注：<textarea id=_remark>祝你新年快乐！</textarea><br>金额：<input id=_price value=1 size=5 title=1-200元>元",2,"arr=['name','remark','price'];for(i=0;i<arr.length;i++)form2[arr[i]].value=$$('_'+arr[i]).value;form2.submit()");
  }else
  {
    form2.action='/jsp/weixin/WxUser'+a+'.jsp';
    form2.target=form2.method='';
    form2.submit();
  }
};
</script>
</body>
</html>
