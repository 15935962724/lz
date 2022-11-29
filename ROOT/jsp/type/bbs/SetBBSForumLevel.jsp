<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.db.DbAdapter" %><%@page import="tea.resource.Resource"  %><%@page import="java.util.*" %><%@page import="tea.entity.node.*" %><%@page import="tea.entity.*" %><%@page import="tea.entity.admin.*" %><%@page import="tea.entity.bbs.*" %><%@page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

Http h=new Http(request,response);

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+h.node);
  return;
}

int tab=h.getInt("tab");
String nexturl=h.get("nexturl");

if("POST".equals(request.getMethod()))
{
  boolean isAll=h.getBool("all");
  if(tab==0)
  {
    int view=h.getInt("view",-1),reply=h.getInt("reply",-1),topic=h.getInt("topic",-1),event=h.getInt("event",-1),poll=h.getInt("poll",-1),activity=h.getInt("activity",-1),rec=h.getInt("rec",-1),job=h.getInt("job",-1);
    String attach=h.get("attach");

    Iterator it=Category.find(h.community,57,0,Integer.MAX_VALUE).iterator();
    while(it.hasNext())
    {
      int nid=((Integer)it.next()).intValue();
      if(!isAll&&nid!=h.node)continue;
      BBSForum bf=BBSForum.find(nid);
      bf.lview=view;
      bf.lreply=reply;
      bf.ltopic=topic;
      bf.levent=event;
      bf.lpoll=poll;
      bf.lactivity=activity;
      bf.lrec=rec;
      bf.ljob=job;
      bf.lattach=attach;
      bf.set();
    }
  }else
  {
    String view=h.get("view","|"),reply=h.get("reply","|"),topic=h.get("topic","|"),event=h.get("event","|"),poll=h.get("poll","|"),activity=h.get("activity","|"),rec=h.get("rec","|"),job=h.get("job","|");
    String attach=h.get("attach");
    Iterator it=Category.find(h.community,57,0,Integer.MAX_VALUE).iterator();
    while(it.hasNext())
    {
      int nid=((Integer)it.next()).intValue();
      if(!isAll&&nid!=h.node)continue;
      BBSForum bf=BBSForum.find(nid);
      bf.rview=view;
      bf.rreply=reply;
      bf.rtopic=topic;
      bf.revent=event;
      bf.rpoll=poll;
      bf.ractivity=activity;
      bf.rrec=rec;
      bf.rjob=job;
      bf.rattach=attach;
      bf.set();
    }
  }
  out.print("<script>parent.mt.show('操作执行成功！',1,'"+nexturl+"');</script>");
  return;
}


Resource r=new Resource();

BBSForum f=BBSForum.find(h.node);


%><html>
<head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<script src="/tea/mt.js" type="text/javascript"></script>
<h1>会员级别对应权限和服务（<%=Node.find(h.node).getSubject(teasession._nLanguage)%>）</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br>

<a href="javascript:mt.tab(0)" name="tab">会员级别</a> <a href="javascript:mt.tab(1)" name="tab">后台角色</a>

<form name="form1" method="post" action="?" target="_ajax" onSubmit="f_submit()">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="node" value="<%=h.node%>"/>
<input type="hidden" name="nexturl" value="<%=nexturl%>"/>
<input type="hidden" name="tab" value="<%=tab%>"/>
<input type="hidden" name="attach"/>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr id="tableonetr">
<td></td>
<%
StringBuffer tx=new StringBuffer();
if(tab==0)//用户等级
{
  Enumeration e=BBSLevel.find(" AND community="+DbAdapter.cite(h.community),0,Integer.MAX_VALUE);
  if(!e.hasMoreElements())
  {
    out.print("<script>alert('抱歉，您还没有设置“会员级别”呢！');history.back()</script>");
    return;
  }
  out.print("<td nowrap>游客");
  tx.append("<td nowrap><input id='atts' level='0' size='2' value='"+f.getLAttach(0)+"' mask='int'>");
  while(e.hasMoreElements())
  {
    BBSLevel l=(BBSLevel)e.nextElement();
    int id=l.getBbslevel();
    out.print("<td nowrap>"+l.getName());
    tx.append("<td nowrap><input id='atts' level='"+id+"' size='2' value='"+f.getLAttach(id)+"' mask='int'>");
  }
}else//后台角色
{
  Enumeration e=AdminRole.find(" AND community="+DbAdapter.cite(h.community),0,Integer.MAX_VALUE);
  while(e.hasMoreElements())
  {
    int id=((Integer)e.nextElement()).intValue();
    AdminRole ar=AdminRole.find(id);
    out.print("<td nowrap>"+ar.getName());
    tx.append("<td nowrap><input id='atts' level='"+id+"' size='2' value='"+f.getLAttach(id)+"' mask='int'>");
  }
}
%>
<tr id="trview"     def0="<%=f.lview%>"     def1="<%=f.rview%>"    ><td nowrap>浏览主题</tr>
<tr id="trreply"    def0="<%=f.lreply%>"    def1="<%=f.rreply%>"   ><td>回复主题</tr>
<tr id="trtopic"    def0="<%=f.ltopic%>"    def1="<%=f.rtopic%>"   ><td>发表主题</tr>
<%--<tr id="trevent" def="<%=f.getLEvent()%>"><td>发起活动</tr>--%>
<tr id="trpoll"     def0="<%=f.lpoll%>"     def1="<%=f.rpoll%>"    ><td>发表投票</tr>
<tr id="tractivity" def0="<%=f.lactivity%>" def1="<%=f.ractivity%>"><td>发表活动</tr>
<tr id="trrec"      def0="<%=f.lrec%>"      def1="<%=f.rrec%>"     ><td>发表招聘</tr>
<tr id="trjob"      def0="<%=f.ljob%>"      def1="<%=f.rjob%>"     ><td>发表求职</tr>
<tr><td nowrap>每天上传<br>附件数<%=tx.toString()%></tr>
</table>

<script>
$name("tab")[<%=tab%>].className="current";
function f_click(obj)
{
  var flag=false;
  var ns=document.all(obj.name);
  for(var i=0;i<ns.length;i++)
  {
    if(ns[i]==obj){flag=true;continue;}
    ns[i].checked=flag;
  }
}

var atts=document.all('atts');
var rows=$('tablecenter').rows;
for(var i=1;i<rows.length-1;i++)
{
  var n=rows[i].id.substring(2),def=rows[i].getAttribute('def<%=tab%>');
  for(var j=0;j<atts.length;j++)
  {
    var td=document.createElement("TD");
    rows[i].appendChild(td);
    if(<%=tab%>==0)
    {
      td.innerHTML="<input type='checkbox' name='"+n+"' value='"+atts[j].getAttribute('level')+"' seq='"+j+"' onclick='f_click(this)'>";
      if(atts[j].getAttribute('level')==def)def=j;
    }else
      td.innerHTML="<input type='checkbox' name='"+n+"' value='"+atts[j].getAttribute('level')+"' seq='"+j+"' "+(def.indexOf("|"+atts[j].getAttribute('level')+"|")!=-1?" checked":"")+">";
  }
  if(<%=tab%>!=0)continue;

  var tds=document.all(n)[def];
  if(!tds)continue;
  tds.checked=true;
  f_click(tds);
}
rows[rows.length-1].style.display="<%=tab==0?"":"none"%>";
//rows[1].style.display="<%=tab==0?"":"none"%>";

function f_submit()
{
  var att="/";
  for(var i=0;i<atts.length;i++)
  {
    att+=atts[i].getAttribute('level')+":"+atts[i].value+"/";
  }
  form1.attach.value=att;
}

mt.tab=function(v)
{
  form1.method="get";
  form1.tab.value=v;
  form1.target="_self";
  form1.submit();
}
</script>

<input type="submit" value="<%=r.getString(teasession._nLanguage,"CBSubmit")%>">
<input type="submit" value="<%=r.getString(teasession._nLanguage,"同时更新到其它论坛")%>" name="all">
<input type="button" value="<%=r.getString(teasession._nLanguage,"CBBack")%>" onClick="history.back();">
</form>

<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
