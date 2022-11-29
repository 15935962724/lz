<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%><%@page import="tea.entity.member.*"%><%@page import="net.mietian.convert.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.entity.tobacco.*"%><%@page import="tea.db.*"%><%@page import="tea.entity.tobacco.*"%><%

Http h=new Http(request,response);

int type=h.getInt("type");
int pos=h.getInt("pos");
StringBuilder sb=new StringBuilder(),par=new StringBuilder();
par.append("?pos=");

int sum=Smoke.count(" AND state=2 AND type="+type);
if(type==1)//文字
{
%>

<div class="textbox">
<table id="tablecenter" cellspacing="0">
<%
if(sum<1)
{
  out.print("<tr><td colspan='10' align='center'>暂无记录!</td></tr>");
}else
{
  Iterator it=Smoke.find(" AND state=2 AND type="+type+" ORDER BY code DESC",pos,9).iterator();
  for(int i=0;it.hasNext();i++)
  {
    Smoke t=(Smoke)it.next();
    sb.append(",{tag:'"+t.smoke+"',bdText:"+Attch.cite(t.content)+",bdUrl:'http://"+request.getServerName()+"/html/tobacco/folder/14050066-1.htm?smoke="+t.smoke+"'}");
  %>
  <tbody>
  <tr>
    <td colspan="2"><%=t.content.length()<100?t.content:"<a href='/html/tobacco/folder/14050066-1.htm?smoke="+t.smoke+"'>"+t.content.substring(0,100)+"...</a>"%></td>
  </tr>
  <tr>
    <td class="number">编号:<%=t.code%>　　作者:<%=MT.f(t.name)%>　　类型:<%=Smoke.MATTER_TYPE[t.type][t.matter]%></td>
    <td class="share"><a href="###" onclick="mt.act(this,<%=t.smoke%>,1)" id="positive"><%=t.positive%></a><a href="###" onclick="mt.act(this,<%=t.smoke%>,1)" id="derogatory"><%=t.derogatory%></a><span class="bdsharebuttonbox" data-tag="<%=t.smoke%>"><a class="bds_more" data-cmd="more">分享</a></span></td>
  </tr>
  </tbody>
  <%
  }
  if(sum>9)out.print("<tr><td colspan='10' align='right'>共"+sum+"条！"+new tea.htmlx.FPNL(h.language,par.toString(),pos,sum,9));
}
%>
</table>
</div>

<%
}else if(type==2)//图片
{%>
<div class="imgbox">
<table id="tablecenter" cellspacing="0">
<%
if(sum<1)
{
  out.print("<tr><td colspan='10' align='center'>暂无记录!</td></tr>");
}else
{
  Iterator it=Smoke.find(" AND state=2 AND type="+type+" ORDER BY code DESC",pos,9).iterator();
  for(int i=0;it.hasNext();i++)
  {
    Smoke t=(Smoke)it.next();
    Attch a=Attch.find(t.attch);
    sb.append(",{tag:'"+t.smoke+"',bdText:"+Attch.cite(t.content)+",bdUrl:'http://"+request.getServerName()+"/html/tobacco/folder/14050066-1.htm?smoke="+t.smoke+"',bdPic:'http://"+request.getServerName()+a.path4+"'}");
    if(i%3==0)out.print("<tr>");
  %>
    <td><span class="imgboxs block"><a href="/html/tobacco/folder/14050066-1.htm?smoke=<%=t.smoke%>"><img src="<%=a.path4%>" width="200"/></a></span>
    <span class="block">编号:<%=t.code%>　　作者:<%=MT.f(t.name)%></span><span class="block"><a href="###" onclick="mt.act(this,<%=t.smoke%>,1)" id="positive"><%=t.positive%></a><a href="###" onclick="mt.act(this,<%=t.smoke%>,1)" id="derogatory"><%=t.derogatory%></a><span class="bdsharebuttonbox" data-tag="<%=t.smoke%>"><a class="bds_more" data-cmd="more">分享</a></span></span></td>
  <%
  }
  if(sum>9)out.print("<tr><td colspan='10' align='right'>共"+sum+"条！"+new tea.htmlx.FPNL(h.language,par.toString(),pos,sum,9));
}
%>
</table>
</div>
<%
}else if(type==3)//视频
{
%>
<div class="videobox">
<table id="tablecenter" cellspacing="0">
<%
if(sum<1)
{
  out.print("<tr><td colspan='10' align='center'>暂无记录!</td></tr>");
}else
{
  Iterator it=Smoke.find(" AND state=2 AND type="+type+" ORDER BY code DESC",pos,9).iterator();
  for(int i=0;it.hasNext();i++)
  {
    Smoke t=(Smoke)it.next();
    Attch a=Attch.find(t.attch);
    sb.append(",{tag:'"+t.smoke+"',bdText:"+Attch.cite(t.content)+",bdUrl:'http://"+request.getServerName()+"/html/tobacco/folder/14050066-1.htm?smoke="+t.smoke+"',bdPic:'http://"+request.getServerName()+a.path4+"'}");
    if(i%3==0)out.print("<tr>");
  %>
    <td><span class="imgboxs block"><a href="/html/tobacco/folder/14050066-1.htm?smoke=<%=t.smoke%>"><img src="<%=a.path4%>" width="200"/></a></span>
    <span class="block">编号:<%=t.code%>　　作者:<%=MT.f(t.name)%></span><span class="block"><a href="###" onclick="mt.act(this,<%=t.smoke%>,1)" id="positive"><%=t.positive%></a><a href="###" onclick="mt.act(this,<%=t.smoke%>,1)" id="derogatory"><%=t.derogatory%></a><span class="bdsharebuttonbox" data-tag="<%=t.smoke%>"><a class="bds_more" data-cmd="more">分享</a></span></span></td>
  <%
  }
  if(sum>9)out.print("<tr><td colspan='10' align='right'>共"+sum+"条！"+new tea.htmlx.FPNL(h.language,par.toString(),pos,sum,9));
}
%>
</table>
</div>
<%
}
%>

<script>
window._bd_share_config={share:[<%=sb.substring(1)%>]};
with(document)0[(getElementsByTagName('head')[0]||body).appendChild(createElement('script')).src='http://bdimg.share.baidu.com/static/api/js/share.js?cdnversion='+~(-new Date()/36e5)];

mt.act=function(a,i,b)
{
  //顶,踩
  var ids=cook.get(a.id,'|');
  var val=ids.indexOf('|'+i+'|')==-1?1:-1;
  ids=val==1?ids+i+'|':ids.replace('|'+i+'|','|');
  mt.send("/Smokes.do?act="+a.id+"&smoke="+i+"&value="+val,function(d){a.innerHTML=d;cook.set(a.id,ids);});
  mt.up(a,val,function(){});
};
</script>

