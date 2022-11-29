<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%><%@page import="java.text.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%>
<%@page import="tea.entity.stat.*"%><%

//#0066CC #CC3333 #CC9933 #009933 #993399
Http h=new Http(request,response);
String act=h.get("act");


int menuid=h.getInt("id");
StringBuffer sql=new StringBuffer();

int tab=h.getInt("tab");
int order=h.getInt("order");

sql.append(" AND etime IS NULL");

String name=h.get("name","");
if(name.length()>0)
{
  sql.append(" AND name LIKE "+DbAdapter.cite("%"+name+"%"));
}

int sum=TaskMgr.count(sql.toString());

if(tab==0)
{
  sql.append(" AND title IS NOT NULL");
}

String[] ORDER={"pid","name","username","sessionname","cpu","memusage"};
sql.append(" ORDER BY ").append(ORDER[order]);

ThreadGroup tg=Thread.currentThread().getThreadGroup();

//String[] STATE={"","NEW","RUNNABLE","BLOCKED","WAITING","TIMED_WAITING","TERMINATED"};
String state=h.get("state","");

%><html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/cssjs/admin.css" rel="stylesheet" type="text/css"/>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/mt.js" type="text/javascript"></script>
<style>
#O<%=order%>{background-image:url(/tea/mt/order0.gif) !important}
#O<%=order%>111{background:url(/tea/mt/order0.gif) no-repeat right;padding-right:8px}
</style>
</head>
<body>
<h1>任务管理器</h1>
<div id="head6"><img height="6" src="about:blank"></div>


<form name="form1" action="?">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="id" value="<%=menuid%>"/>
<input type="hidden" name="tab" value="<%=tab%>"/>
<input type="hidden" name="order" value="<%=order%>"/>

<table id="tablecenter" cellspacing="0">
<tr>
<%
if(tab<2)
{
%>
  <td>名称：</td><td><input name="name" value="<%=MT.f(name)%>" /></td>
<%
}else if(tab==3)
{
  out.print("<td>状态：</td><td><select name='state'><option value=''>--");
  Thread.State[] arr=Thread.State.values();
  for(int i=0;i<arr.length;i++)
  {
    out.print("<option value="+arr[i]+">"+arr[i]);
  }
  out.print("</select></td>");
  out.print("<script>form1.state.value='"+state+"';</script>");
}
%>
  <td><input type="submit" value="查询"/>
</table>
</form>

<div class="switch">
<a href='javascript:mt.tab(0)' id='a_tab0'>应用程序</a>
<a href='javascript:mt.tab(1)' id='a_tab1'>进程（<%=sum%>）</a>
<a href='javascript:mt.tab(2)' id='a_tab2'>性能</a>
<a href='javascript:mt.tab(3)' id='a_tab3'>线程（<%=tg.activeCount()%>）</a>
</div>
<script>$('a_tab<%=tab%>').className='current';</script>

<form name="form2" action="/TaskMgrs.do" method="post" target="_ajax">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="taskmgr"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<table id="tablecenter" cellspacing="0">
<%
if(tab==0)
{
  out.print("<tr id='tableonetr'><td></td><td>任务</td><td>状态</td><td>操作</td></tr>");
  Iterator it=TaskMgr.find(sql.toString(),0,200).iterator();
  if(!it.hasNext())
  {
    out.print("<tr><td colspan='10' align='center'>暂无记录!</td></tr>");
  }else
  {
    for(int i=1;it.hasNext();i++)
    {
      TaskMgr t=(TaskMgr)it.next();
      out.print("<tr onMouseOver=bgColor='#FFFFCA' onMouseOut=bgColor=''>");
      out.print("<td><input type='checkbox' name='taskmgrs' value='"+t.taskmgr+"'/>");
      out.print("<td>"+MT.f(t.title));
      out.print("<td>"+TaskMgr.STATUS_TYPE[t.status]);
      out.print("<td><input type='button' value='结束' onclick=mt.act('kill',"+t.taskmgr+") /></td>");
    }
  }
}else if(tab==1)
{
  out.print("<tr id='tableonetr'><td></td><td onclick='mt.order(this)' id='O1'>名称</td><td onclick='mt.order(this)' id='O0'>PID</td><td onclick='mt.order(this)' id='O2'>用户名</td><td onclick='mt.order(this)' id='O3'>会话</td><td onclick='mt.order(this)' id='O4'>CPU</td><td onclick='mt.order(this)' id='O5'>内存使用</td><td>操作</td></tr>");
  Iterator it=TaskMgr.find(sql.toString(),0,200).iterator();
  for(int i=1;it.hasNext();i++)
  {
    TaskMgr t=(TaskMgr)it.next();
    out.print("<tr onMouseOver=bgColor='#FFFFCA' onMouseOut=bgColor=''>");
    out.print("<td><input type='checkbox' name='taskmgrs' value='"+t.taskmgr+"'/>");
    out.print("<td><a href=javascript:mt.act('view',"+t.taskmgr+")>"+t.name+"</a>");
    out.print("<td>"+t.pid);
    out.print("<td>"+t.username);
    out.print("<td>"+t.sessionname);
    out.print("<td>"+t.cpu);
    out.print("<td>"+t.memusage+" K");
    out.print("<td><input type='button' value='结束' onclick=mt.act('kill',"+t.taskmgr+") /></td>");
  }
  out.print("<tr><td colspan='10'><input type='checkbox' id='sel' onclick='mt.select(form2.taskmgrs,checked)' ><label for='sel'>全选</label>　<input name='multi' type='button' value='结束' onclick=mt.act('kill','0') />");
}else if(tab==2)
{
  out.print("<tr><td><script>mt.embed('/tea/mt/chart.swf','100%',200,'data-file=/TaskMgrs.do?act=chart_cpu&loading=%E6%AD%A3%E5%9C%A8%E5%88%86%E6%9E%90...');</script>");
  out.print("<tr><td><script>mt.embed('/tea/mt/chart.swf','100%',200,'data-file=/TaskMgrs.do?act=chart_mem&loading=%E6%AD%A3%E5%9C%A8%E5%88%86%E6%9E%90...');</script>");
  out.print("<tr><td><script>mt.embed('/tea/mt/chart.swf','100%',200,'data-file=/TaskMgrs.do?act=chart_net&loading=%E6%AD%A3%E5%9C%A8%E5%88%86%E6%9E%90...');</script>");
}else if(tab==3)
{
  //Thread[] ts=new Thread[tg.activeCount()];//和Thread.getAllStackTraces()比,却少：Signal Dispatcher/Finalizer/Reference Handler 这三个线程
  //tg.enumerate(ts);

  out.print("<tr id='tableonetr'><td></td><td>ID</td><td>名称</td><td>状态</td><td></td><td>操作</td></tr>");
  Map hm=Thread.getAllStackTraces();
  Iterator it=hm.keySet().iterator();
  while(it.hasNext())
  {
    Thread th=(Thread)it.next();
    if(state.length()>0&&!Thread.State.valueOf(state).equals(th.getState()))continue;

    long id=th.getId();
    out.print("<tr onMouseOver=bgColor='#FFFFCA' onMouseOut=bgColor=''>");
    out.print("<td><input type='checkbox' name='taskmgrs' value='"+id+"'/>");
    out.println("<td>"+id+"<td>"+th.getName()+"<td>"+th.getState()+"<td>");
    StackTraceElement[] ste=(StackTraceElement[])hm.get(th);
    for(int j=0;j<ste.length;j++)
    {
      String str=ste[j].toString();
      if(str.startsWith("org.apache.jsp.")||str.startsWith("tea."))str="<b>"+str+"</b>";
      out.print(str+"<br/>");
    }
    out.print("<td><input type='button' value='结束' onclick=mt.act('stop',"+id+") /></td>");
  }
  out.print("<tr><td colspan='10'><input type='checkbox' id='sel' onclick='mt.select(form2.taskmgrs,checked)' ><label for='sel'>全选</label>　<input name='multi' type='button' value='结束' onclick=mt.act('stop','0') />");
}
%>
</table>

</form>

<script>
mt.disabled(form2.taskmgrs);
form2.nexturl.value=location.pathname+location.search;
mt.act=function(a,id,b)
{
  form2.act.value=a;
  form2.taskmgr.value=id;
  if(a=='del')
  {
    mt.show('你确定要删除吗？',2,'form2.submit()');
  }else
  {
    if(a=='view')
    {
      form2.action='/jsp/stat/TaskMgrView.jsp';
      form2.target=form2.method='';
    }
    form2.submit();
  }
}
mt.tab=function(i)
{
  form1.tab.value=i;
  form1.submit();
};
mt.order=function(a)
{
  form1.order.value=a.id.substring(1);
  form1.submit();
};
</script>
</body>
</html>
