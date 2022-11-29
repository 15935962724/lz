<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%><%@page import="tea.entity.admin.*"%>
<%@page import="tea.entity.weixin.*"%><%

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

int type=h.getInt("type");
if(type>0)
{
  sql.append(" AND type="+type);
  par.append("&type="+type);
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

String fusername=h.get("fusername","");
if(fusername.length()>0)
{
  sql.append(" AND wu.wxuser>0 AND (fu.nickname LIKE "+DbAdapter.cite("%"+fusername+"%")+" OR fu.remarkname LIKE "+DbAdapter.cite("%"+fusername+"%")+")");
  par.append("&fusername="+h.enc(fusername));
}

String tusername=h.get("tusername","");
if(tusername.length()>0)
{
  sql.append(" AND tusername LIKE "+DbAdapter.cite("%"+tusername+"%"));
  par.append("&tusername="+h.enc(tusername));
}

String  content=h.get("content","");
if(content.length()>0)
{
  sql.append(" AND content LIKE "+DbAdapter.cite("%"+content+"%"));
  par.append("&content="+h.enc(content));
}

int pos=h.getInt("pos");
par.append("&pos=");

int sum=WxMessenger.count(sql.toString());

StringBuilder htm=new StringBuilder();
htm.append("<table id='tablecenter' cellspacing='0'>");
htm.append("<tr id='tableonetr'><td>序号</td><td>类型</td><td>发送方</td><td>内容</td><td>时间</td><td>操作</td></tr>");
if(sum<1)
{
  htm.append("<tr><td colspan='10' align='center'>暂无记录!</td></tr>");
}else
{
  sql.append(" ORDER BY wm.time DESC");
  Iterator it=WxMessenger.find(sql.toString(),pos,20).iterator();
  for(int i=1+pos;it.hasNext();i++)
  {
    WxMessenger t=(WxMessenger)it.next();
    WxUser wu=WxUser.find(t.community,t.fuser);
    htm.append("<tr><td>"+i);
    htm.append("<td>"+WxMessenger.TYPE_NAME[t.type]);
    htm.append("<td>"+wu.getAnchor());
    htm.append("<td>"+t.getContent());
    htm.append("<td>"+MT.f(t.time,1));
    htm.append("<td><a href=javascript:mt.act('view','"+t.wxmessenger+"')>查看</a> ");
    htm.append("<a href=javascript:mt.act('star','"+t.wxmessenger+"') style="+(t.star==null?"":"background-color:#FFFF00")+">星标</a> ");
    if(t.url!=null)
    htm.append("<a href='/Utils.do?act=down&url="+Http.enc(t.url)+"&name="+Http.enc(wu.nickname+" - "+MT.f(t.time))+".mp3'>下载</a> ");
  }
  if(sum>20)htm.append("<tr><td colspan='10' align='right'>"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,20));
}
htm.append("</table>");

String act=h.get("act");
if("html".equals(act))
{
  out.print(htm.toString());
  return;
}

%>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<link href="/tea/image/weixin/emoji.css" rel="stylesheet" type="text/css"/>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1><%=AdminFunction.find(menuid).getName(h.language)%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<h2>查询</h2>
<form name="form1" action="?">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="id" value="<%=menuid%>"/>
<table id="tablecenter" cellspacing="0">
<tr>
  <td class="th">类型:</td><td><select name="type"><%=h.options(WxMessenger.TYPE_NAME,type)%></select></td>
  <td class="th">发送方:</td><td><input name="fusername" value="<%=fusername%>"/></td>
</tr>
<tr>
  <td class="th">内容:</td><td><input name="content" value="<%=content%>"/></td>
  <td class="th">时间:</td><td><input name="stime" value="<%=MT.f(stime)%>" onclick="mt.date(this)" class="date"/> - <input name="etime" value="<%=MT.f(etime)%>" onclick="mt.date(this)" class="date"/>　<input type="submit" value="查询"/></td>
</tr>
</table>
</form>

<h2>列表<div style="float:right"><input type="checkbox" checked="checked" id="ref"/><label for="ref">自动刷新</label></div></h2>
<form name="form2" action="/WxMessengers.do" method="post" target="_ajax">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="wxmessenger"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>

<div id="wx">加载中...</div>
</form>

<script>
form2.nexturl.value=location.pathname+location.search;
mt.act=function(a,id,b)
{
  form2.act.value=a;
  form2.wxmessenger.value=id;
  if(a=='del')
  {
    mt.show('你确定要删除吗？',2,'form2.submit()');
  }else
  {
    if(a=='view')
    {
      form2.action='/jsp/weixin/WxMessengerView.jsp';
      form2.target=form2.method='';
    }
    form2.submit();
  }
};
var old;
function f_ref()
{
  if(!$$('ref').checked)return;
  mt.send(form2.nexturl.value+'&act=html',function(d){if(old==d)return;$$('wx').innerHTML=old=d});
}
f_ref();
setInterval(f_ref,3000);
</script>
</body>
</html>
