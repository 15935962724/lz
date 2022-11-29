<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.ui.*"%><%@page import="tea.db.*"%>
<%@page import="tea.entity.node.*"%><%@page import="tea.entity.weibo.*"%><%

Http h=new Http(request,response);

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+h.node);
  return;
}
h.member=teasession._rv.toString();

int menuid=h.getInt("id");
Date t0=h.getDate("t0");
Date t1=h.getDate("t1");


StringBuilder sql=new StringBuilder();
sql.append("SELECT * FROM (");

//转发
sql.append(" SELECT userid,microid,0,content,time FROM WMicro WHERE");
sql.append(" deleted=0");//未删除 有可能转发后，又删除了
sql.append(" AND quoteid>0");//必须是转发的微博
sql.append(" AND at>2");//并@3位好友
if(t0!=null)sql.append(" AND time>"+DbAdapter.cite(t0));//开始时间
if(t1!=null)sql.append(" AND time<"+DbAdapter.cite(t1));//结束时间

sql.append(" UNION ALL");//转发、评论 合并

//评论
sql.append(" SELECT userid,0,commentid,content,time FROM WComment WHERE");
sql.append(" deleted=0");//未删除 有可能评论后，又删除了
sql.append(" AND at>2");//并@3位好友
if(t0!=null)sql.append(" AND time>"+DbAdapter.cite(t0));//开始时间
if(t1!=null)sql.append(" AND time<"+DbAdapter.cite(t1));//结束时间

//随机排序
sql.append(") ORDER BY dbms_random.value");


%><html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>抽奖——历史事件</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<h2>查询</h2>
<form name="form1" action="?">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="id" value="<%=menuid%>"/>

<table id="tablecenter" cellspacing="0">
<tr>
  <td>时间：<input name="t0" value="<%=MT.f(t0)%>" class="date" onclick="mt.date(this)"/>--<input name="t1" value="<%=MT.f(t1)%>" class="date" onclick="mt.date(this)"/>　　<input type="submit" value="抽奖"/></td>
</tr>
</table>
</form>




<%
if(t0==null&&t1==null)return;

out.print("<!-- "+sql.toString()+" -->");
for(int j = 0;j < 20;j++)out.write("<!-- 显示进度条  -->");
out.print("<script>mt.show('数据筛选中...',0)</script>");
out.flush();
%>

<h2>列表</h2>
<form name="form2" action="/Historicals.do" method="post" target="_ajax">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="act"/>

<table id="tablecenter" cellspacing="0">
<tr id="tableonetr">
  <td>序号</td>
  <td>用户ID</td>
  <td>用户昵称</td>
  <td>转发ID</td>
  <td>评论ID</td>
  <td>内容</td>
  <td>时间</td>
</tr>
<%
StringBuilder sb=new StringBuilder("|");
ArrayList al=new ArrayList();
DbAdapter db=new DbAdapter();
try
{
  java.sql.ResultSet rs=db.executeQuery(sql.toString(),0,Integer.MAX_VALUE);
  while(rs.next()&&al.size()<25)
  {
    String userid=rs.getString(1);
    if(al.contains(userid))continue;
    al.add(userid);
    long microid=rs.getLong(2);
    long commentid=rs.getLong(3);
    String content=rs.getString(4);
    Date time=db.getDate(5);
    //
    sb.append(microid+","+commentid+"|");
    WUser u=WUser.find(userid);
    out.print("<tr onMouseOver=bgColor='#FFFFCA' onMouseOut=bgColor=''>");
    out.print("<td>"+al.size()+"<td>"+userid+"<td>"+u.nick+"<td>"+microid+"<td>"+commentid+"<td>"+content+"<td>"+MT.f(time,1));
  }
}finally
{
  db.close();
}
%>
</table>

<input type="hidden" name="ids" value="<%=sb.toString()%>"/>
<input type="button" value="导出" onclick="mt.act('exp_ran',0,'抽奖.xls')">
</form>


<script>
mt.close();
mt.act=function(a,id,b)
{
  form2.act.value=a;
  if(a=='exp_ran')
  {
    form2.action='/Historicals.do/'+encodeURIComponent(b);
  }
  form2.submit();
};
</script>
</body>
</html>
