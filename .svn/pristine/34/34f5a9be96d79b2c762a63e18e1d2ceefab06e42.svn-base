<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.entity.node.*"%><%

Http h=new Http(request,response);

Node n=Node.find(h.node);

int[] nodes=new int[3];
Enumeration e=Node.find(" AND father="+h.node+" ORDER BY node",0,3);
for(int i=0;e.hasMoreElements();i++)
{
  nodes[i]=((Integer)e.nextElement()).intValue();
}
%>

<div class="basicSituation">
<div class="title"><b>基本情况</b><a href="/html/folder/<%=nodes[0]%>-1.htm"></a></div>
<div class="con"><%=MT.f(n.getText(h.language).replaceAll("<[^>]+>",""),180)%></div>
</div>
<div class="dynamicOrg">
<div class="title"><b>机构动态</b><a href="/html/category/<%=nodes[1]%>-1.htm"></a></div>
<div class="list">
<ul>
<%
e=Node.find(" AND father="+nodes[1]+" ORDER BY time DESC",0,4);
for(int i=0;e.hasMoreElements();i++)
{
  int node=((Integer)e.nextElement()).intValue();
  n=Node.find(node);
  Report r=Report.find(node);
  out.print("<li><span class='time'>"+r.getIssueTimeToString()+"</span><span class='subject'><a href='/html/report/"+node+"-1.htm' target='_blank'>"+n.getSubject(h.language)+"</a></span></li>");
}
%>
</ul>
</div>
</div>
<div class="TeachersTeam">
<div class="title"><b>团队师资</b><a href="/html/category/<%=nodes[2]%>-1.htm"></a></div>
<div class="list">
<div class="left"><a style="display:block;width:17px;height:33px;*height:66px;padding-top:30px;text-align:center;float:left;" onmouseup=ISL_StopDown_1() 
class=RightBotton onmousedown=ISL_GoDown_1() onmouseout=ISL_StopDown_1() 
href="javascript:void(0);" target=_self></a></div>
<div class="center">
<div id=ISL_Cont_1>
<div style="WIDTH:32766px;ZOOM:1">
<DIV id=List1_1>
<ul>
<%
e=Node.find(" AND father="+nodes[2]+" ORDER BY time DESC",0,200);
for(int i=0;e.hasMoreElements();i++)
{
  int node=((Integer)e.nextElement()).intValue();
  n=Node.find(node);
  People p=People.find(node,h.language);
  out.print("<li><a href='/html/report/"+node+"-1.htm' target='_blank'><img src='"+MT.f(n.getPicture(h.language),"/tea/mt/avatar.gif")+"'/></a> <b><a href='/html/report/"+node+"-1.htm' target='_blank'>"+n.getSubject(h.language)+"</a></b>"+MT.f(n.getText(h.language).replaceAll("<[^>]+>|&nbsp;",""),32)+"</li>");
}
%>
</ul></div>
<DIV id=List2_1></DIV>
</div></div>


</div>
<div class="right"><a onmouseup=ISL_StopUp_1() class=LeftBotton 
onmousedown=ISL_GoUp_1() onmouseout=ISL_StopUp_1() href="javascript:void(0);" 
target=_self></a></div>
</div>
</div></div>
