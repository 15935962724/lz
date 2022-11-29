<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.db.DbAdapter" %><%@page import="tea.entity.*"%><%@page import="tea.entity.node.*"%><%@page import="tea.entity.site.*"%><%@page import="tea.ui.*"%><%@page import="java.util.*"%><%@page import="java.text.SimpleDateFormat"%><%@page import="tea.htmlx.*"%><%@page import="tea.html.HtmlElement"%><%

Http h=new Http(request,response);

TeaSession teasession = new TeaSession(request);
if(teasession._rv == null)
{
  out.print("<script>location.replace('/servlet/StartLogin?node="+h.node+"&nexturl="+Http.enc(request.getRequestURI()+"?"+request.getQueryString())+"')</script>");
  return;
}

int menuid=h.getInt("id");


String path=Node.find(h.node).getPath();

StringBuilder sql=new StringBuilder(),par=new StringBuilder();
par.append("?node="+h.node+"&id="+menuid);

sql.append(" AND type=3");

int father=h.getInt("father");
if(father>0)
{
  sql.append(" AND father="+father);
  par.append("&father="+father);
}else
  sql.append(" AND path LIKE "+DbAdapter.cite(path+"%"));

String subject=h.get("subject","");
if(subject.length()>0)
{
  sql.append(" AND EXISTS(SELECT node FROM NodeLayer nl WHERE n.node=nl.node AND subject LIKE "+DbAdapter.cite("%"+subject+"%")+")");
  par.append("&subject="+Http.enc(subject));
}

int sum=Node.count(sql.toString());
int pos=h.getInt("pos");
par.append("&pos=");

%><html>
<head>
<link href="/res/<%=h.community%>/cssjs/community.css" type="text/css" rel="stylesheet">
<script src="/tea/mt.js" type="text/javascript" ></script>
</head>
<body>

<h1>投票管理</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<h2>查询</h2>
<form name="form1" action="?">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="id" value="<%=menuid%>"/>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr><td>类别:<select name="father"><option value="0">----------</option>
<%

Enumeration ef=Node.find(" AND type=1 AND path LIKE "+DbAdapter.cite(path+"%")+" AND EXISTS(SELECT node FROM Category c WHERE n.node=c.node AND c.category=3)",0,200);
while(ef.hasMoreElements())
{
  int nid=((Integer)ef.nextElement()).intValue();
  out.print("<option value="+nid);
  if(father==nid)out.print(" selected");
  out.print(">"+Node.find(nid).getSubject(h.language));
}
%></select></td>
<td>主题:<input name="subject" value="<%=MT.f(subject)%>"/>
<td><input type="submit" value="查询"/>
</tr>
</table>
</form>


<h2>列表(<%=sum%>)</h2>
<form name="form2" action="/servlet/EditPoll" target="_ajax">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="node"/>
<input type="hidden" name="act"/>
<input type="hidden" name="nexturl"/>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr id="tableonetr">
  <td></td>
  <td>主题</td>
  <td>投票人数</td>
  <td>截止日期</td>
  <td>操作</td>
</tr>
<%
if(sum<1)
out.print("<tr><td colspan='10' align='center'>暂无记录！");
else
{
  Enumeration e=Node.find(sql.toString(),pos,20);
  for(int i=1;e.hasMoreElements();i++)
  {
    int node=((Integer)e.nextElement()).intValue();
    Node n=Node.find(node);

    out.print("<tr><td>"+i);
    out.print("<td>"+n.getAnchor(h.language));
    out.print("<td><a href='/jsp/type/poll/PollVotes.jsp?node="+node+"'>"+PollVote.count(" AND node="+node)+"</a>");
    out.print("<td>"+n.getStopTimeToString());
    out.print("<td><input type='button' value='查看结果' onclick=mt.act('view',"+node+") />");
    out.print(" <input type='button' value='"+(n.isHidden()?"发布":"暂停发布")+"' onclick=mt.act('hidden',"+node+") />");
    out.print(" <input type='button' value='清空结果' onclick=mt.act('clear',"+node+") />");
    out.print(" <input type='button' value='导出结果' onclick=mt.act('exp',"+node+") />");
    out.print(" <input type='button' value='编辑' onclick=mt.act('edit',"+node+") />");
    out.print(" <input type='button' value='删除' onclick=mt.act('del',"+node+") />");
  }
}
%>
</table>
<%=new tea.htmlx.FPNL(teasession._nLanguage,par.toString(),pos,20)%>
<input type="button" value="创建" onclick="mt.act('add')"/>
</form>

<script>
form2.nexturl.value=location.pathname+location.search;
mt.act=function(a,i,n)
{
  form2.act.value=a;
  form2.node.value=i;
  if(a=='view')
    window.open("/jsp/type/poll/PollResultView.jsp?node="+i,"","width=500,height=600");
  else if(a=='del')
    mt.show("确认删除吗？",2,"form2.submit()");
  else if(a=='clear')
    mt.show("确认清空结果吗？",2,"form2.submit()");
  else if(a=='exp')
  {
    form2.action="/PollVotes.do";
    form2.submit();
  }else if(a=='add')
  {
    var h='',t=form1.father.options;
    for(var i=1;i<t.length;i++)
    {
      h+="<input name='_node' type='radio' value="+t[i].value+" id='_n"+i+"' "+(i==1?" checked":"")+" /><label for='_n"+i+"'>"+t[i].text+"</label><br/>";
    }
    mt.show(h,2,"请选择类型：");
    mt.ok=function()
    {
      location="/jsp/type/poll/EditPoll.jsp?NewNode=ON&node="+mt.value($name('_node'))+"&nexturl="+encodeURIComponent(form2.nexturl.value);
    }
  }else
  {
    if(a=='edit')
    {
      form2.target="_self";
      form2.action="/jsp/type/poll/EditPoll.jsp";
    }
    form2.submit();
  }
}
</script>

<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</html>
