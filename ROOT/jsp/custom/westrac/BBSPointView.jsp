<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%><%@page import="tea.entity.node.*"%><%@page import="tea.entity.*"%><%@page import="tea.db.*"%><%@page import="tea.ui.*"%><%@page import="tea.entity.bbs.*"%><%@page import="tea.entity.member.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  out.print("<script>location.replace('/servlet/StartLogin?node="+h.node+"&nexturl="+Http.enc(request.getRequestURI()+"?"+request.getQueryString())+"')</script>");
  return;
}


StringBuffer sql=new StringBuffer(),par=new StringBuffer("?");
sql.append(" AND member="+DbAdapter.cite(h.username));
par.append("&community="+h.community);



int sum=BBSPoint.count(sql.toString());

int pos=h.getInt("pos");
par.append("&pos=");

Profile p=Profile.find(h.member);

%>
<div class="title">您当前积分总计：<%=p.getIntegral()%>分</div>
<table id="tablecenter" cellspacing="0">
<tr id="tableonetr">
  <td>积分日期</td>
  <td>类型</td>
  <td>内容</td>
  <td>所获积分</td>
  <td>扣分分值</td>
  <td>说明</td>
</tr>
<%
if(sum<1)
{
  out.print("<tr><td colspan='10' align='center'>"+Res.get(h.language,"暂无记录！")+"</td></tr>");
}else
{
  sql.append(" ORDER BY bbspoint DESC");
  Iterator it=BBSPoint.find(sql.toString(),pos,20).iterator();
  for(int i=1+pos;it.hasNext();i++)
  {
    BBSPoint t=(BBSPoint)it.next();
    String str=t.content;
    if(t.node>0)
    {
      Node n=Node.find(t.node);
      if(n.getTime()!=null)str=n.getAnchor(h.language).toString();
    }
  %>
  <tr onMouseOver="bgColor='#FFFFCA'" onMouseOut="bgColor=''">
    <td><%=MT.f(t.time,1)%></td>
    <td><%=BBSPoint.TYPE_NAME[t.type]%></td>
    <td><%=Entity.getNULL(str)%></td>
    <td><%if(t.point>0)out.print(t.point);%></td>
    <td><%if(t.point<0)out.print(t.point);%></td>
    <td><%=t.node==0||t.type==16?MT.f(t.content):""%></td>
  </tr>
  <%}
  if(sum>20)out.print("<tr><td colspan='10' align='right'>"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,20));
}%>
</table>
