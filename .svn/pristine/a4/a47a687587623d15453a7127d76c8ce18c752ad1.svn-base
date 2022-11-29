<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter"%>
<%@page import="tea.resource.Resource"%>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.member.*" %>
<%@page import="tea.entity.site.*" %>
<%@page import="tea.entity.node.*" %>
<%@page import="java.util.*" %>
<%@page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}


Resource r=new Resource();
String member=teasession._rv.toString();

StringBuffer sql=new StringBuffer();
sql.append(" AND step>0 AND fb.flowbusiness IN( SELECT flowbusiness FROM Flowview WHERE ");
//{member}可以办理的事务//
sql.append(" (state<2 AND(transactor="+DbAdapter.cite(member)+" OR consign="+DbAdapter.cite(member)+") AND flowprocess IN (SELECT flowprocess FROM Flowview WHERE flowview IN ( SELECT MAX(flowview) FROM Flowview WHERE flowprocess!=0 GROUP BY flowbusiness )))");
//可控流程///控制流程转向///
sql.append(" OR (flowview IN(SELECT MIN(flowview) FROM Flowview GROUP BY flowbusiness) AND transactor="+DbAdapter.cite(member)+")");//发起人
sql.append(" OR (flowview IN(SELECT MAX(fv.flowview) FROM Flowview fv INNER JOIN Flow f ON fv.flowprocess=f.mainprocess WHERE f.type=2 GROUP BY fv.flowbusiness) AND (transactor="+DbAdapter.cite(member)+" OR consign="+DbAdapter.cite(member)+") )");//主控人员
//倒数第二步是{member}办理&&倒数第二步是一个人//最后一步无人办理
sql.append(" OR (flowview IN(SELECT fv.flowview FROM Flowview fv INNER JOIN (SELECT flowbusiness,MAX(step)-1 step FROM Flowview GROUP BY flowbusiness) ff ON fv.flowbusiness=ff.flowbusiness AND fv.step=ff.step-1 WHERE "+DbAdapter.cite(member)+" IN (transactor,consign) AND (SELECT COUNT(*) FROM Flowview WHERE flowbusiness=ff.flowbusiness AND step=ff.step)=1 ))");//fv.flowbusiness NOT IN (SELECT flowbusiness FROM Flowview WHERE state!=0 AND step=ff.step)
sql.append(")");

String tmp;

//flow:菜单中传递此参数////////////
int flow=0;
String p_flow=request.getParameter("flow");



String s1=" AND (type=1 OR flow IN (SELECT flow FROM Flowprocess WHERE member LIKE "+DbAdapter.cite("%/"+teasession._rv._strV+"/%")+"))";
if(p_flow!=null)
{
  s1=" AND flow IN("+p_flow+")"+s1;
}

%>
<!--
参数说明:
flow: 流程的ID,可支持多个,用逗号分隔.
-->
<%
boolean none=true;
Enumeration ef=Flow.find(teasession._strCommunity,s1);
for(int i=1;ef.hasMoreElements();i++)
{
  flow=((Integer)ef.nextElement()).intValue();
  Flow f=Flow.find(flow);
  //列表////
  Enumeration efb=Flowbusiness.findByCommunity(teasession._strCommunity," AND flow="+flow+sql.toString());
  if(efb.hasMoreElements())
  {
    none=false;
    out.print("<h2>"+f.getName(teasession._nLanguage));
    out.print("<a href='/jsp/admin/flow/Flowbusiness3.jsp?community="+teasession._strCommunity+"&flow="+flow+"'>详情...</a>");
    out.print("</h2>");
    out.print("<table border='0' cellpadding='0' cellspacing='0' id='tablecenter'>");
    out.print("<tr id='tableonetr'>");
    out.print("<td nowrap>序号</td>");
    out.print("<td nowrap>事务名称</td>");
    out.print("<td nowrap>发起人</td>");
    out.print("<td nowrap>步骤</td>");
    out.print("<td nowrap>状态</td>");
    Dynamic d=Dynamic.find(f.getDynamic());
    int dtst=d.getDtst();
    if(dtst>0)out.print("<td nowrap>期限</td>");
    out.print("</tr>");
    for(int j=1;efb.hasMoreElements();j++)
    {
      int flowbusiness=((Integer)efb.nextElement()).intValue();
      Flowbusiness fb=Flowbusiness.find(flowbusiness);
      int step=fb.getStep();
      Flowprocess fp=Flowprocess.find(fb.getFlow(),step);
      int flowprocess=fp.getFlowprocess();
      Flowview fv=Flowview.find(flowbusiness,flowprocess,member);
      int state=fv.getState();

      boolean manage=f.getType()==2 &&(member.equals(fb.getMainTransactor()) || member.equals(fb.getMainConsign()));
      boolean creator=member.equals(fb.getCreator());

      out.print("<tr onMouseOver=bgColor='#BCD1E9' onMouseOut=bgColor=''>");
      out.print("<td width=20 align=center>"+j);
      out.print("<td nowrap>"+fb.getName(teasession._nLanguage));
      out.print("<td nowrap>"+fb.getCreator());
      out.print("<td nowrap>第"+step+"步");
      if(f.getType()!=1)//如果不是自由流程才显示，步骤名
      {
        out.print(":"+fp.getName(teasession._nLanguage));
      }
      out.print("<td align=center nowrap>");
      if(manage||creator)
      {
        Enumeration e=Flowview.find(flowbusiness,flowprocess);
        while(e.hasMoreElements())
        {
          int flowview=((Integer)e.nextElement()).intValue();
          Flowview fv2=Flowview.find(flowview);
          out.print(fv2.getTransactor()+": "+Flowbusiness.STATE_TYPE[fv2.getState()]+"<br>");
        }
      }else
      {
        out.print(Flowbusiness.STATE_TYPE[state]);
      }
      if(dtst>0)//期限
      {
        out.print("<td nowrap>&nbsp;");
        String dv_value=DynamicValue.find(-flowbusiness,teasession._nLanguage,dtst).getValue();
        if(dv_value!=null)out.print(dv_value);
      }
    }
    out.print("</table>");
  }
}
if(none)//如果没有待办工作
{
  out.print("<table border='0' cellpadding='0' cellspacing='0' id='tablecenter'>");
  out.print("<tr><td height=100 colspan=10 align=center>您暂无待办工作</td></tr>");
  out.print("</table>");
}
%>
