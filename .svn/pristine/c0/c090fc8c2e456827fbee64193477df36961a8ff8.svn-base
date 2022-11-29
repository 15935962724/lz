<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter"%> <%@ page import="tea.resource.Resource"%><%@ page import="tea.entity.admin.*" %><%@ page import="tea.entity.member.*" %><%@ page import="tea.ui.TeaSession" %>
<jsp:directive.page import="java.net.URLEncoder"/><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String community=teasession._strCommunity;


Resource r=new Resource();


%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<body>

<h1>工作查询</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<h2>列表</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<%
StringBuffer sql=new StringBuffer();

String name=request.getParameter("name");
String states=request.getParameter("states");
String manager=request.getParameter("manager");
String member=request.getParameter("member");

String act=request.getParameter("act");

if(act==null||"queryflowitem".equals(act))
{
	//只有项目创建者和项目经理可见
	sql.append(" AND ( creator="+DbAdapter.cite(teasession._rv._strV)+" OR manager LIKE "+DbAdapter.cite("%/"+teasession._rv._strV+"/%")+" )");
	
	//项目名称
	if(name!=null&&(name=name.trim()).length()>0)
	{
	  sql.append(" AND flowitem IN (SELECT flowitem FROM FlowitemLayer WHERE name LIKE "+DbAdapter.cite("%"+name+"%")+")");
	}
	//项目状态
	if(states!=null&&states.length()>0)
	{
	  int i=Integer.parseInt(states);
	  switch(i)
	  {
		  case 0:
		  sql.append(" AND NOT EXISTS ( SELECT fb.flowitem FROM Flowbusiness fb WHERE fb.flowitem=Flowitem.flowitem )");
		  break;
		  case 1:
		  sql.append(" AND EXISTS ( SELECT fb.flowitem FROM Flowbusiness fb WHERE fb.step>0 AND fb.flowitem=Flowitem.flowitem )");
		  break;
		  case 2://有此项目的事务 并 事务都已结束
		  sql.append(" AND EXISTS ( SELECT fb.flowitem FROM Flowbusiness fb WHERE fb.flowitem=Flowitem.flowitem ) AND NOT EXISTS ( SELECT fb.flowitem FROM Flowbusiness fb WHERE fb.step>0 AND fb.flowitem=Flowitem.flowitem )");
		  break;
	  }
	}
	//项目经理
	if(manager!=null&&manager.length()>0)
	{
	  String str[]=manager.split("/");
	  for(int i=0;i<str.length;i++)
	  sql.append(" AND manager LIKE "+DbAdapter.cite("%/"+str[i]+"/%"));
	}	
	//项目参与者
	if(member!=null&&member.length()>0)
	{
	  String str[]=member.split("/");
	  for(int i=0;i<str.length;i++)
	  sql.append(" AND member LIKE "+DbAdapter.cite("%/"+str[i]+"/%"));
	}
%>
     <tr id="tableonetr">
       <td nowrap>序号</td>
       <td nowrap>流程名称</td>
       <td nowrap>项目经理</td>
       <td nowrap>项目创建者</td>
       <td nowrap>创建时间</td>
       <td nowrap>预计完成时间</td>
       <td nowrap>当前所处阶段</td>
     </tr>
     <%
	java.util.Enumeration enumer=Flowitem.find(community,sql.toString());
	for(int index=1;enumer.hasMoreElements();index++)
	{
	  int flowitem=((Integer)enumer.nextElement()).intValue();
	  Flowitem obj=Flowitem.find(flowitem);
	
	  %>
	  <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
	    <td><%=index%></td>
	    <td nowrap><%=obj.getName(teasession._nLanguage)%></td>
	    <td nowrap><%
	         String str[]=obj.getManager().split("/");
	         for(int i=1;i<str.length;i++)
	         {
	        	 Profile p=Profile.find(str[i]);
	        	 out.print(str[i]+" ( "+p.getLastName(teasession._nLanguage)+p.getFirstName(teasession._nLanguage)+" )<br>");
	         }
	         %></td>
	    <td nowrap>
	    <%
	    Profile p=Profile.find(obj.getCreator());
		out.print(obj.getCreator()+" ( "+p.getLastName(teasession._nLanguage)+p.getFirstName(teasession._nLanguage)+" )");
	    %></td>
	    <td nowrap><%=obj.getCtimeToString()%></td>
	    <td nowrap><%=obj.getFtimeToString()%></td>
	    <td nowrap><%=r.getString(teasession._nLanguage,Flowitem.STATES_TYPE[obj.getStates()])%></td>
	 </tr>
	  <%
	}

}else if("queryflowbusiness".equals(act))
{
	//事务名称
	if(name!=null&&(name=name.trim()).length()>0)
	{
	  sql.append(" AND flowbusiness IN (SELECT flowbusiness FROM FlowbusinessLayer WHERE name LIKE "+DbAdapter.cite("%"+name+"%")+")");
	}
%>
	<tr id="tableonetr">
     <td nowrap>序号</td>
     <td nowrap>事务名称</td>
              <td nowrap>项目名称</td>
         <td nowrap>流程名称</td>
         <td nowrap>流程类别</td>
       </tr>
     <%
	java.util.Enumeration enumer=Flowview.findByMember(teasession._strCommunity,teasession._rv._strV,sql.toString(),0,Integer.MAX_VALUE);
	for(int index=1;enumer.hasMoreElements();index++)
	{
	  int flowbusiness=((Integer)enumer.nextElement()).intValue();
	  Flowbusiness obj=Flowbusiness.find(flowbusiness);
      Flowitem fl_obj=Flowitem.find(obj.getFlowitem());
	  Flow flow_obj=Flow.find(obj.getFlow());
	  %>
	  <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
	    <td><%=index%></td>
	    <td nowrap><a href="/jsp/admin/flow/QueryFlowprocess.jsp?community=<%=teasession._strCommunity%>&flow=<%=obj.getFlow()%>&flowbusiness=<%=flowbusiness%>" target=_blank ><%=obj.getName(teasession._nLanguage)%></a></td>
   	    <td nowrap><%=fl_obj.getName(teasession._nLanguage)%></td>
	    <td><%=flow_obj.getName(teasession._nLanguage)%></td>
	    <td nowrap><%=Flow.FLOW_TYPE[flow_obj.getType()]%></td>
	 </tr>
	  <%
	}
}else if("queryflow".equals(act))
{
	String flow=request.getParameter("flow");
	if(flow!=null&&flow.length()>0)
	{
	  sql.append(" AND flowbusiness IN (SELECT flowbusiness FROM FlowbusinessLayer WHERE name LIKE "+DbAdapter.cite("%"+name+"%")+")");
	}
%>
	<tr id="tableonetr">
     <td nowrap>序号</td>
     <td nowrap>事务名称</td>
     <td nowrap>项目名称</td>
     <td nowrap>流程名称</td>
     <td nowrap>流程类别</td>
    </tr>
     <%
	java.util.Enumeration enumer=Flowview.findByMember(teasession._strCommunity,teasession._rv._strV,sql.toString(),0,Integer.MAX_VALUE);
	for(int index=1;enumer.hasMoreElements();index++)
	{
	  int flowbusiness=((Integer)enumer.nextElement()).intValue();
	  Flowbusiness obj=Flowbusiness.find(flowbusiness);
      Flowitem fl_obj=Flowitem.find(obj.getFlowitem());
	  Flow flow_obj=Flow.find(obj.getFlow());
	  %>
	  <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
	    <td><%=index%></td>
	    <td nowrap><a href="/jsp/admin/flow/QueryFlowprocess.jsp?community=<%=teasession._strCommunity%>&flow=<%=obj.getFlow()%>&flowbusiness=<%=flowbusiness%>" target=_blank ><%=obj.getName(teasession._nLanguage)%></a></td>
   	    <td nowrap><%=fl_obj.getName(teasession._nLanguage)%></td>
	    <td><%=flow_obj.getName(teasession._nLanguage)%></td>
	    <td nowrap><%=Flow.FLOW_TYPE[flow_obj.getType()]%></td>
	 </tr>
	  <%
	}
}

 %>
</table>

<h1>高级查询</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<input type="button" value="<%=r.getString(teasession._nLanguage,"流程查询")%>" onClick="window.open('/jsp/admin/flow/QueryFlow.jsp?community=<%=community%>','','width=600,height=400,top=200,left=200,scrollbars=0,resizable=0,status=0');">
<input type="button" value="<%=r.getString(teasession._nLanguage,"项目查询")%>" onClick="window.open('/jsp/admin/flow/QueryFlowitem.jsp?community=<%=community%>','','width=600,height=400,top=200,left=200,scrollbars=0,resizable=0,status=0');">
<input type="button" value="<%=r.getString(teasession._nLanguage,"工作查询")%>" onClick="window.open('/jsp/admin/flow/QueryFlowbusiness.jsp?community=<%=community%>','','width=600,height=400,top=200,left=200,scrollbars=0,resizable=0,status=0');">

<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</HTML>


