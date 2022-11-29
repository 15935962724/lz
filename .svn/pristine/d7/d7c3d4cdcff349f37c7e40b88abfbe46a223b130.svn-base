<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.db.DbAdapter" %><%@page import="tea.entity.*"%><%@page import="tea.entity.node.*"%><%@page import="tea.entity.site.*"%><%@page import="tea.ui.*"%><%@page import="java.util.*"%><%@page import="java.text.SimpleDateFormat"%><%@page import="tea.htmlx.*"%><%@page import="tea.html.HtmlElement"%><%

Http h=new Http(request,response);

TeaSession teasession = new TeaSession(request);
if(teasession._rv == null)
{
  out.print("<script>location.replace('/servlet/StartLogin?node="+h.node+"&nexturl="+Http.enc(request.getRequestURI()+"?"+request.getQueryString())+"')</script>");
  return;
}


String member=h.get("member");
if(member==null)member=teasession._rv._strR;

int pos=h.getInt("pos");


int count=BBS.countByMember(teasession._strCommunity,member);

%>
<div class="title">发过的贴子</div>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter2">
<tr id="tableonetr"><td>所属位置</td><td>标题</td><td>发布时间</td><td>回复数</td><td>最后回复人 / 回复时间</td>
<%
Enumeration e=BBS.findByMember(teasession._strCommunity,member,pos,25);
for(int i=1;e.hasMoreElements();i++)
{
  int node=((Integer)e.nextElement()).intValue();
  Node n=Node.find(node);
  if(n.getFinished()!=2){
  BBS b=BBS.find(node, teasession._nLanguage);
  out.print("<tr onmouseover=\"javascript:this.bgColor='#BCD1E9';\" onMouseOut=\"javascript:this.bgColor='';\">");
  out.print("<tr><td>【"+Node.find(n.getFather()).getAnchor(teasession._nLanguage)+"】");
  out.print("<td><a href='/html/bbs/"+node+"-"+teasession._nLanguage+".htm' target='_blank'>"+n.getSubject(teasession._nLanguage)+"</a>");
  out.print("<td>"+MT.f(n.getTime(),1));
  out.print("<td>"+b.getReplyCount());
  out.print("<td>");
  if(b.getReplyCount()>0)
  out.print(b.getReplyMember()+"&nbsp;/&nbsp;"+b.getReplyTimeToString());
  }
}
%>
<tr><td colspan="5" class="tdpage"><%=new tea.htmlx.FPNL(teasession._nLanguage,request.getRequestURI()+"?community="+teasession._strCommunity+"&member="+java.net.URLEncoder.encode(member,"utf-8")+"&pos=",pos,count)%></td></tr>
</table>

