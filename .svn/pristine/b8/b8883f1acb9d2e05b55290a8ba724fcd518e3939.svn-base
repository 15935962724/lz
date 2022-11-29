<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%>
<%@page import="tea.entity.node.*"%><%

Http h=new Http(request);


Node n=Node.find(h.getInt("node"));


%>
<html>
<style>
div{border:1px solid #CCCCCC;width:140px; float:left}
.ReplayThem{width:95%;border-bottom:1px solid #ccc;margin:0 auto;}
.ReplayThem{padding:6px;}
.ReplayThem td{text-align:left;font-size:14px;}
.ReplayThem .left{width:106px;padding:20px 20px 20px 0px;}
.ReplayThem .left img{width:86px;}
.ThemList{margin:0 auto;margin-top:10px;width:96%}
.ThemList td{font-size:12px;border:1px solid #ccc;padding:5px;}
.ThemList td img{width:122px;height:92px;margin-bottom:5px;}
</style>
<body style="text-align:center;">
<script>
var pl=parent.location;
function f_view()
{
  parent.location=pl.pathname+pl.search;
}
</script>
<table cellpadding="0" cellspacing="0" class="ReplayThem">
<tr>
  <td rowspan="2" class="left"><img src="<%=n.getPicture(h.language)%>"/></td>
  <td><%=n.getSubject(h.language)%></td>
</tr>
<tr>
  <td><a href="javascript:f_view()">重新播放</a></td>
</tr>
</table>

<table cellpadding="0" cellspacing="4" class="ThemList">
<tr><td style="border:0px;">大家都在看</td></tr>
<tr>
<%
Enumeration e=Node.find(" AND father="+n.getFather()+" AND node!="+n._nNode+" AND hidden=0 ORDER BY click DESC",0,3);
while(e.hasMoreElements())
{
  int nid=((Integer)e.nextElement()).intValue();
  n=Node.find(nid);
  out.print("<td style=text-align:center;><a href='/html/album/"+nid+"-"+h.language+".htm' target='_parent'><img style=border:0px; src='"+n.getPicture(h.language)+"' /><br/>"+n.getSubject(h.language)+"</a></td>");
}
%>
</tr></table>
</body>
</html>
