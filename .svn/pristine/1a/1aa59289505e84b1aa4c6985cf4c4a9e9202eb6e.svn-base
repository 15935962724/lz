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


int count=BBSReply.countByMember(teasession._strCommunity,member);

%>
<!DOCTYPE html><html><head>
<script>
document.write(parent.document.getElementsByTagName('HEAD')[0].innerHTML);
var arr=parent.document.getElementsByTagName('LINK');
for(var i=0;i<arr.length;i++)document.write('<link href='+arr[i].href+' rel='+arr[i].rel+' type=text/css>');
</script></head><body class=ifrmemberview>

<div class="title">回复的贴子</div>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter2">
<tr id="tableonetr"><td>所属位置</td><td>标题</td><td>发布时间</td>
<%
Enumeration e=BBSReply.findByMember(teasession._strCommunity,member,pos,25);
while(e.hasMoreElements())
{
  int nid=((Integer)e.nextElement()).intValue();
  Node n=Node.find(nid);
  if(n.getFinished()!=2){
  out.print("<tr><td>【"+Node.find(n.getFather()).getAnchor(teasession._nLanguage)+"】");
  out.print("<td><a href='/html/bbs/"+nid+"-"+teasession._nLanguage+".htm' target='_blank'>"+n.getSubject(teasession._nLanguage)+"</a>");
  out.print("<td>"+MT.f(n.getTime(),1));
  }
}
%>
<tr><td colspan="5" class="tdpage"><%=new tea.htmlx.FPNL(teasession._nLanguage,request.getRequestURI()+"?community="+teasession._strCommunity+"&member="+java.net.URLEncoder.encode(member,"utf-8")+"&pos=",pos,count)%></td></tr>
</table>
<script>
mt.fit();
</script>

