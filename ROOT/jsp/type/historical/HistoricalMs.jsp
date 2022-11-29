<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%><%@page import="tea.ui.*"%>
<%@page import="tea.entity.node.*"%><%@page import="tea.entity.weibo.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}

StringBuffer sql=new StringBuffer(),par=new StringBuffer();

int menuid=h.getInt("id");
par.append("?community="+h.community+"&id="+menuid);
sql.append(" AND microid>0");

Date ot0=h.getDate("ot0");
if(ot0!=null)
{
  sql.append(" AND otime>="+DbAdapter.cite(ot0));
  par.append("&ot0="+MT.f(ot0));
}
Date ot1=h.getDate("ot1");
if(ot1!=null)
{
  sql.append(" AND otime<"+DbAdapter.cite(ot1));
  par.append("&ot1="+MT.f(ot1));
}


Date ct0=h.getDate("ct0");
if(ct0!=null)
{
  sql.append(" AND time>="+DbAdapter.cite(ct0));
  par.append("&ct0="+MT.f(ct0));
}
Date ct1=h.getDate("ct1");
if(ct1!=null)
{
  sql.append(" AND time<"+DbAdapter.cite(ct1));
  par.append("&ct1="+MT.f(ct1));
}
String cmember=h.get("cmember","");
if(cmember.length()>0)
{
  sql.append(" AND node IN(SELECT node FROM Node WHERE rcreator LIKE "+DbAdapter.cite("%"+cmember+"%")+")");
  par.append("&cmember="+h.enc(cmember));
}


Date st0=h.getDate("st0");
if(st0!=null)
{
  sql.append(" AND time>="+DbAdapter.cite(st0));
  par.append("&st0="+MT.f(st0));
}
Date st1=h.getDate("st1");
if(st1!=null)
{
  sql.append(" AND time<"+DbAdapter.cite(st1));
  par.append("&st1="+MT.f(st1));
}
String smember=h.get("smember","");
if(smember.length()>0)
{
  sql.append(" AND smember LIKE "+DbAdapter.cite("%"+smember+"%"));
  par.append("&smember="+h.enc(smember));
}


String q=h.get("q","");
if(q.length()>0)
{
  String str=DbAdapter.cite("%"+q+"%");
  sql.append(" AND(source LIKE "+str+" OR sourcedesc LIKE "+str);
  sql.append(" OR node IN(SELECT node FROM NodeLayer WHERE subject LIKE "+str+" OR content LIKE "+str+"))");
  par.append("&q="+h.enc(q));
}


int sum=Historical.count(sql.toString());

String[] ORDER_TYPE={"stime","reposts","comments","reposts+comments"};
int order=h.getInt("order");
sql.append(" ORDER BY "+ORDER_TYPE[order]+" DESC");
par.append("&order="+order);


int pos=h.getInt("pos");
par.append("&pos=");

String acts=h.get("acts","");
//System.out.println(sql.toString());

%>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<style>
#O<%=order%>{background:url(/tea/mt/order0.gif) no-repeat right;padding-right:8px}
</style>
</head>
<body>
<h1>历史事件——微博</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<h2>查询</h2>
<form name="form1" action="?">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="id" value="<%=menuid%>"/>
<input type="hidden" name="order" value="<%=order%>"/>

<table id="tablecenter" cellspacing="0">
<tr>
  <td>关键词：<input name="q" value="<%=q%>"/></td>
  <td>发生时间：<input name="ot0" value="<%=MT.f(ot0)%>" class="date" onclick="mt.date(this)"/>--<input name="ot1" value="<%=MT.f(ot1)%>" class="date" onclick="mt.date(this)"/></td>
</tr>
<%--
<tr>
  <td>上传人：<input name="cmember" value="<%=cmember%>"/></td>
  <td>上传时间：<input name="ct0" value="<%=MT.f(ct0)%>" class="date" onclick="mt.date(this)"/>--<input name="ct1" value="<%=MT.f(ct1)%>" class="date" onclick="mt.date(this)"/></td>
</tr>
--%>
<tr>
  <td>分享人：<input name="smember" value="<%=smember%>"/></td>
  <td>分享时间：<input name="st0" value="<%=MT.f(st0)%>" class="date" onclick="mt.date(this)"/>--<input name="st1" value="<%=MT.f(st1)%>" class="date" onclick="mt.date(this)"/>　　<input type="submit" value="查询"/></td>
</tr>
</table>
</form>

<h2>列表 <%=sum%></h2>
<form name="form2" action="/Historicals.do" method="post" target="_ajax">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="node"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<table id="tablecenter" cellspacing="0">
<tr id="tableonetr">
  <td></td>
  <td>姓名</td>
  <td>内容</td>
  <td><a href="javascript:mt.order(1)" id="O1">转发数</a></td>
  <td><a href="javascript:mt.order(2)" id="O2">评论数</a></td>
  <td><a href="javascript:mt.order(3)" id="O3">关注度</a></td>
  <td><a href="javascript:mt.order(0)" id="O0">时间</a></td>
  <td>操作</td>
</tr>
<%
if(sum<1)
{
  out.print("<tr><td colspan='10' align='center'>暂无记录!</td></tr>");
}else
{
  Iterator it=Historical.find(sql.toString(),pos,20).iterator();
  for(int i=1+pos;it.hasNext();i++)
  {
    Historical t=(Historical)it.next();
    Node n=Node.find(t.node);
    WMicro wm=WMicro.find(t.microid);
    WUser wu=WUser.find(wm.userid);
    String url = "http://weibo.com/" + wm.userid + "/" + OAuth.mid(t.microid);
  %>
  <tr onMouseOver="bgColor='#FFFFCA'" onMouseOut="bgColor=''">
    <td><input type="checkbox" name="nodes" value="<%=t.node%>"/></td>
    <td><%=wu.getName()%></td>
    <td><%=OAuth.a(OAuth.face(MT.f(wm.content, 50)),url)%></td>
    <td><%=t.reposts%><!--<%//=WMicro.count(" AND quoteid="+t.microid+" AND deleted!=2")%>--></td>
    <td><%=t.comments%><!--<%//=WComment.count(" AND microid="+t.microid)%>--></td>
    <td><%=t.reposts+t.comments%></td>
    <td><%=MT.f(t.stime,1)%></td>
    <td>
    <%
    out.println("<a href=javascript:mt.act('view',"+t.node+") >查看</a>");
    if(acts.contains("share"))
    {
      if(t.microid<1)
        out.println("<a href=javascript:mt.act('share',"+t.node+") >分享</a>");
      else
        out.println("<a href=javascript:mt.act('cancel',"+t.node+") >取消分享</a>");
    }
    if(acts.contains("edit"))out.println("<a href=javascript:mt.act('edit',"+t.node+") >编辑</a>");
    if(acts.contains("del"))out.println("<a href=javascript:mt.act('del',"+t.node+") >删除</a>");
    if(acts.contains("flow"))out.println("<a href=javascript:mt.act('flow',"+t.node+") >流程图</a>");
    %>
    </td>
  </tr>
  <%
  }
}%>
<tr>
  <td colspan="3"><input type="checkbox" onclick="mt.select(form2.nodes,checked)" id="sel"/><label for="sel">全选</label>
    <input type="button" name="multi" value="删除" onclick="mt.act('del',0)"/>
    <input type="button" value="导出" onclick="mt.act('exp_key',0,'微博列表.xls')"/>
  </td>
  <td colspan='10' align='right'><%=new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,20)%>
</table>
</form>


<form name="form3" action="/Historicals.do" method="post" target="_ajax">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="key" value="<%=MT.enc(sql.toString())%>"/>
</form>


<script>
mt.disabled(form2.nodes);
form2.nexturl.value=location.pathname+location.search;
mt.act=function(a,id,b)
{
  form2.act.value=a;
  form2.node.value=id;
  if(a=='del')
  {
    mt.show('你确定要删除吗？',2,'form2.submit()');
  }else if(a=='exp_key')
  {
    form3.action='/Historicals.do/'+encodeURIComponent(b)+'?act='+a;
    form3.submit();
  }else if(a=='flow')
  {
    mt.show('/jsp/type/NodeFlowView.jsp?node='+id,1,'查看流程图',500,400);
  }else
  {
    if(a=='share')
    {
      mt.show(null,0);
    }else if(a=='cancel')
    {
    }else
    {
      if(a=='view')
        form2.action='/jsp/type/historical/HistoricalView.jsp';
      else if(a=='edit')
        form2.action='/jsp/type/historical/EditHistorical.jsp';
      form2.target=form2.method='';
    }
    form2.submit();
  }
};
mt.order=function(a)
{
  form1.order.value=a;
  form1.submit();
};
mt.receive=function()
{
  mt.show('授权成功！');
};
</script>
</body>
</html>
