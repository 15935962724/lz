<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%><%@page import="tea.ui.*"%>
<%@page import="tea.entity.node.*"%><%@page import="tea.entity.member.*"%><%

Http h=new Http(request,response);


StringBuffer sql=new StringBuffer();


sql.append(" AND node="+h.getInt("node"));



String[] TAB={"全部","好评","中评","差评"};
String[] SQL={""," AND score IN(4,5)"," AND score IN(3)"," AND score IN(1,2)"};




int tab=0;

%>
<%
StringBuilder sb=new StringBuilder();
out.print("<div class='switch'>");
for(int i=0;i<TAB.length;i++)
{
  int sum=NReview.count(sql.toString()+SQL[i]);
  out.print("<a href='###' onclick='mt.tab(this)' name='a_review'>"+TAB[i]+"（"+sum+"）</a>");

  sb.append("<table name='review' class='review' cellspacing='0' style='display:none'>");
  if(sum<1)
  {
    sb.append("<tr><td colspan='10' align='center'>暂无记录!</td></tr>");
  }else
  {
    int pos=h.getInt("pos"+i);
    if(pos>0)tab=i;
    Iterator it=NReview.find(sql.toString()+SQL[i],pos,20).iterator();
    while(it.hasNext())
    {
      NReview t=(NReview)it.next();
      sb.append("  <tr><th colspan='2'><div class='member'>"+Profile.find(t.member).getMember()+"</div><div class='star' style='background-position:"+(t.score*13-65)+"px;'></div><div class='time'>"+MT.f(t.time,1)+"</div></th></tr>");
      /* sb.append("  <tr><td class='td01'>优点：</td><td>"+MT.f(t.advantages)+"</td></tr>");
      sb.append("  <tr><td class='td01'>缺点：</td><td>"+MT.f(t.shortcomings)+"</td></tr>"); */
      sb.append("  <tr><td class='td01'>评价：</td><td>"+MT.f(t.content)+"</td></tr>");
    }
    if(sum>20)sb.append("<tr><td colspan='10' align='right'>"+new tea.htmlx.FPNL(h.language,"?pos"+i+"=",pos,sum,20));
  }
  sb.append("</table>");
}
out.print("</div>");
out.print(sb.toString());
out.print("<script>mt.tab(document.getElementsByName('a_review')["+tab+"]);</script>");
%>




