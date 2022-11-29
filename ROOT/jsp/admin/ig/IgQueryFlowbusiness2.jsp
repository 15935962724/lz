<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.resource.Resource" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.entity.site.*" %>
<%@page import="java.util.*" %>
<%@page import="tea.ui.TeaSession" %>
<% request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}


Resource r=new Resource();


String s1="";

//flow:菜单中传递此参数////////////
String tmp=request.getParameter("flow");
if(tmp!=null)
{
  s1=" AND flow IN ("+tmp+")";
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
  int flow=((Integer)ef.nextElement()).intValue();
  Flow f=Flow.find(flow);
  Dynamic d=Dynamic.find(f.getDynamic());
  int dtst=d.getDtst();
  int pos=0;
  tmp=request.getParameter("pos"+i);
  if(tmp!=null)
  {
    pos=Integer.parseInt(tmp);
  }
  Enumeration e3=Flowbusiness.findByCommunity(teasession._strCommunity," AND flow="+flow+" AND step>0 ORDER BY flowbusiness DESC",pos,10);
  if(e3.hasMoreElements())
  {
    none=false;
    //int count=Flowbusiness.countByCommunity(teasession._strCommunity," AND flow="+flow+" AND step>0");
    out.print("<h2>"+f.getName(teasession._nLanguage)+"</h2><!--"+flow+"-->");
    out.print("<table border='0' cellpadding='0' cellspacing='0' id='tablecenter'>");
    out.print("<tr id='tableonetr'>");
    out.print("<td nowrap>序号</td>");
    out.print("<td nowrap>事务名称</td>");
    out.print("<td nowrap>发起人</td>");
    out.print("<td nowrap>状态</td>");
    if(dtst>0)out.print("<td nowrap>期限</td>");
    out.print("<td nowrap>经办人</td>");
    out.print("</tr>");
    for(int j=1;e3.hasMoreElements();j++)
    {
      int flowbusiness=((Integer)e3.nextElement()).intValue();
      Flowbusiness fb=Flowbusiness.find(flowbusiness);
      int step=fb.getStep();
      Flowprocess fp=Flowprocess.find(fb.getFlow(),step);
      //Flowitem fi=Flowitem.find(fb.getFlowitem());
      out.print("<tr onMouseOver=bgColor='#BCD1E9' onMouseOut=bgColor=''>");
      out.print("<td align=center>"+j);
      out.print("<td nowrap><a href='/jsp/admin/flow/FlowbusinessView.jsp?community="+teasession._strCommunity+"&dynamic="+f.getDynamic()+"&flowbusiness="+flowbusiness+"' target='_blank' >"+fb.getName(teasession._nLanguage)+"</a></td>");
      //out.print("<td align="center" nowrap><%if(fi.getName(teasession._nLanguage)!=null && fi.getName(teasession._nLanguage).length()>0){out.print(fi.getName(teasession._nLanguage));}else{out.print("暂无项目");}% ></td>");
      out.print("<td align=center>"+fb.getCreator());
      out.print("<td align=center>"+fb.getStepToString(teasession._nLanguage));
      if(dtst>0)//期限
      {
        out.print("<td align=center>&nbsp;");
        String dv_value=DynamicValue.find(-flowbusiness,teasession._nLanguage,dtst).getValue();
        if(dv_value!=null)out.print(dv_value);
      }
      out.print("<td align=center>&nbsp;");
      Enumeration e=Flowview.find(flowbusiness,fp.getFlowprocess());
      while(e.hasMoreElements())
      {
        int flowview=((Integer)e.nextElement()).intValue();
        Flowview fv2=Flowview.find(flowview);
        out.print(fv2.getTransactor()+": "+Flowbusiness.STATE_TYPE[fv2.getState()]+"<br>");
      }
    }
    out.print("</table>");
    //out.print(new tea.htmlx.FPNL(teasession._nLanguage,param.toString(),pos,count,10));
  }
}
if(none)
{
  out.print("<table border='0' cellpadding='0' cellspacing='0' id='tablecenter'>");
  out.print("<tr><td align='center'>"+"暂无记录"+"</td></tr>");
  out.print("</table>");
}
%>
