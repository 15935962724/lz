<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%><%@page import="tea.entity.util.*"%>
<%@page import="tea.entity.weixin.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}

StringBuffer sql=new StringBuffer(),par=new StringBuffer();

int menuid=h.getInt("id");
par.append("?community="+h.community+"&id="+menuid);

Date time0=h.getDate("time0");
if(time0!=null)
{
  sql.append(" AND wrg.time>"+DbAdapter.cite(time0));
  par.append("&time0="+MT.f(time0));
}
Date time1=h.getDate("time1");
if(time1!=null)
{
  sql.append(" AND wrg.time<"+DbAdapter.cite(time1));
  par.append("&time1="+MT.f(time1));
}

int pos=h.getInt("pos");
par.append("&pos=");

String acts=h.get("acts","");


%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/tea/city.js" type="text/javascript"></script>
</head>
<body>
<h1>抢红包统计</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<h2>查询</h2>
<form name="form1" action="?">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="id" value="<%=menuid%>"/>
<table id="tablecenter" cellspacing="0">
<tr>
  <td>时间:<input name="time0" value="<%=MT.f(time0)%>" onclick="mt.date(this)" class="date"/> - <input name="time1" value="<%=MT.f(time1)%>" onclick="mt.date(this)" class="date"/></td>
  <td><input type="submit" value="查询"/></td>
</tr>
</table>
</form>

<h2>列表</h2>
<form name="form2" action="/WxRedGrabs.do" method="post" target="_ajax">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="wxredgrab"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>

<table id="tablecenter" cellspacing="0">
<tr id="tableonetr">
  <td>序号</td>
  <td>红包</td>
  <td>人数</td>
  <td>次数</td>
<%
for(int j=0;j<WxRed.PROBABILITY.length;j++)
{
  out.print("<td>"+(j<1?"未抢到":WxRed.PROBABILITY[j]+"元"));
}
%>
</tr>
<%
DbAdapter db=new DbAdapter(),d1=new DbAdapter();
try
{
  db.executeQuery("SELECT wxred,COUNT(*) FROM WxRedGrab wrg WHERE 1=1"+sql.toString()+" GROUP BY wxred");
  for(int i=1;db.next();i++)
  {
    WxRed wr=WxRed.find(db.getInt(1));
    d1.executeQuery("SELECT COUNT(*),SUM(hits) FROM (SELECT COUNT(*) hits FROM WxRedGrab wrg WHERE wxred="+wr.wxred+sql.toString()+" GROUP BY wxuser) tab");
    out.print("<tr><td>"+i+"<td>"+(wr.city<1?"全国":"<script>mt.city("+wr.city+")</script>")+"<td>"+(d1.next()?d1.getInt(1):0)+"<td>"+db.getInt(2));

    HashMap hm=new HashMap();
    d1.executeQuery("SELECT wrg.money 金额,COUNT(wrg.money) 数量 FROM WxRedGrab wrg WHERE wxred="+wr.wxred+sql.toString()+" GROUP BY wrg.money");
    while(d1.next())
    {
      hm.put(d1.getInt(1),d1.getInt(2));
    }
    for(int j=0;j<WxRed.PROBABILITY.length;j++)
    {
      Object obj=hm.get(WxRed.PROBABILITY[j]);
      out.print("<td>"+(obj==null?"--":obj));
    }
  }
}finally
{
  db.close();
  d1.close();
}
%>
</table>

<br/>
<%--
<input type="button" value="导出" onclick="mt.post('/Attchs.do?act=excel&name=%E7%BA%A2%E5%8C%85&key=<%=MT.enc(str)%>')"/>
--%>
</form>

<script>
form2.nexturl.value=location.pathname+location.search;
mt.act=function(a,id,b)
{
  form2.act.value=a;
  form2.wxredgrab.value=id;
  if(a=='del')
  {
    mt.show('你确定要删除吗？',2,'form2.submit()');
  }else
  {
    if(a=='view')
      form2.action='/WxRedGrabView.jsp';
    else if(a=='edit')
      form2.action='/WxRedGrabEdit.jsp';
    form2.target=form2.method='';
    form2.submit();
  }
};
</script>
</body>
</html>
