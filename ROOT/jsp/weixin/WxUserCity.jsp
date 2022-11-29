<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%><%@page import="tea.entity.weixin.*"%><%@page import="tea.entity.util.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}

StringBuffer sql=new StringBuffer(),par=new StringBuffer();

int menuid=h.getInt("id");
par.append("?id="+menuid);

sql.append(" AND ip IS NOT NULL");

int score1=h.getInt("score1");
if(score1!=-1)
{
  sql.append(" AND(score>="+score1+" OR nodes!='|')");
  par.append("&score1="+score1);
}

int card=h.getInt("card");
if(card>0)
{
  sql.append(" AND card LIKE "+DbAdapter.cite(card+"_%"));
  par.append("&card="+card);
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

String act=h.get("act");
if("city".equals(act))
{
  out.print("[");
  DbAdapter db=new DbAdapter();
  try
  {
    db.executeQuery("SELECT card,COUNT(*) total FROM WxUser WHERE 1=1"+sql.toString()+" GROUP BY card ORDER BY total DESC");
    for(int i=0;db.next();i++)
    {
      card=db.getInt(1);
      out.print(i==0?"":",");
      out.print("{name:'"+(card<1?"其它":Card.find(card).name)+"',count:"+db.getInt(2)+"}");
    }
  }finally
  {
    db.close();
  }
  out.print("]");
  return;
}

int tab=h.getInt("tab");


String str="CASE WHEN card>99 THEN card/100 ELSE card END";
if(tab==1)
{
  str="card";
  sql.append(" AND(card>99 OR card IN(11,12,31,50))");
  par.append("&tab="+tab);
}
int total=WxUser.count(sql.toString());

str=" FROM (SELECT "+str+" card,COUNT(*) count FROM WxUser WHERE 1=1"+sql.toString()+" GROUP BY "+str+") tab";



int pos=h.getInt("pos");
par.append("&pos=");


%><!DOCTYPE html>
<html><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<link href="/tea/image/weixin/emoji.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<style>
.tree{width:11px;height:11px;display:inline-block;}
.plus{background:url(/tea/image/tree/plus.gif) no-repeat;}
.minus{background:url(/tea/image/tree/minus.gif) no-repeat;}
</style>
</head>
<body>
<h1>地区分布</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<h2>查询</h2>
<form name="form1" action="?">
<input type="hidden" name="id" value="<%=menuid%>"/>
<input type="hidden" name="tab" value="<%=tab%>"/>
<table id="tablecenter" cellspacing="0">
<tr>
  <td class="th">时间:</td><td><input name="stime" value="<%=MT.f(stime)%>" onclick="mt.date(this)" class="date"/> - <input name="etime" value="<%=MT.f(etime)%>" onclick="mt.date(this)" class="date"/>　<input type="submit" value="查询"/></td>
</tr>
</table>
</form>

<h2>列表</h2>
<form name="form2" action="/Attchs.do?name=地区分布" method="post" target="_ajax">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<%
String[] TAB={"省份","城市"};
out.print("<div class='switch'>");
for(int i=0;i<TAB.length;i++)
{
  out.print("<a href='javascript:mt.tab("+i+")' class='"+(tab==i?"current":"")+"'>"+TAB[i]+"</a>");
}
out.print("</div>");
%>
<table id="tablecenter" cellspacing="0">
<tr id="tableonetr">
  <td>地区</td>
  <td>人数</td>
  <td>占比</td>
</tr>
<%
DbAdapter db=new DbAdapter();
try
{
  db.executeQuery("SELECT COUNT(*)"+str);
  int sum=db.next()?db.getInt(1):0;

  db.executeQuery("SELECT *"+str+" ORDER BY count DESC",pos,20);
  while(db.next())
  {
    Card c=Card.find(db.getInt(1));
    int count=db.getInt(2);
    out.print("<tr id="+c.card+">");
    out.print("<td>");
    if(tab==0)out.print("<a href=javascript: onclick=mt.act(this) class='tree plus'></a>");
    out.print(c.card<1?"其它":c.address);
    out.print("<td>"+count);
    out.print("<td>"+MT.f(count*100F/total)+"%");
    out.print("<tbody></tbody>");
  }
  if(sum>20)out.print("<tr><td colspan='10' align='right'>"+new tea.htmlx.FPNL(h.language,par.toString(),pos,sum,20));
}finally
{
  db.close();
}
%>
</table>
<input type="hidden" name="key" value="<%=MT.enc("SELECT CASE WHEN c.address IS NULL THEN '其它' ELSE c.address END 地区,tab.count 人数"+str+" LEFT JOIN card c ON tab.card=c.card ORDER BY tab.count DESC")%>"/>
<input type="button" value="导出" onclick="form2.act.value='excel';form2.submit();"/>
</form>

<script>
form2.nexturl.value=location.pathname+location.search;
mt.act=function(a)
{
  var n=a.className,p=mt.ftr(a),tb=p.parentNode.nextSibling,b=n.indexOf('plus')!=-1;
  a.className=n.replace(/plus|minus/,b?'minus':'plus');
  if(!b)
  {
    while(tb.lastChild)tb.removeChild(tb.lastChild);
    return;
  }
  mt.send("<%=request.getRequestURI()+par%>&act=city&card="+p.id,function(d)
  {
    eval("d="+d);
    if(d.length<1)
    {
      var tr=document.createElement('TR');
      var td=document.createElement('TD');td.colSpan=3;td.innerHTML='无数据';tr.appendChild(td);
      tb.appendChild(tr);
    }
    for(var i=0;i<d.length;i++)
    {
      var tr=document.createElement('TR');
      var td=document.createElement('TD');td.innerHTML='　'+d[i].name;tr.appendChild(td);
      var td=document.createElement('TD');td.innerHTML=d[i].count;tr.appendChild(td);
      var td=document.createElement('TD');td.innerHTML=mt.f(d[i].count*100/<%=total%>,2)+'%';tr.appendChild(td);
      tb.appendChild(tr);
    }
  });
};
</script>
</body>
</html>
