<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter"%> <%@ page import="tea.resource.Resource"%><%@ page import="tea.entity.admin.*" %><%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String community=teasession._strCommunity;

int flowitem=Integer.parseInt(request.getParameter("flowitem"));

Resource r=new Resource();

StringBuffer sql=new StringBuffer();

String name=request.getParameter("name");
if(name!=null&&name.length()>0)
{
  sql.append(" AND flow IN (SELECT flowbusiness FROM FlowbusinessLayer WHERE name LIKE "+DbAdapter.cite("%"+name+"%")+")");
}

String flow=request.getParameter("flow");
if(flow!=null&&flow.length()>0)
{
  sql.append(" AND flow="+flow);
}

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

<h1>工作事务</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br>

<h2>查询</h2>
<form name=foEdit METHOD=get action="<%=request.getRequestURI()%>" onSubmit="">
  <input type=hidden name="community" value="<%=community%>"/>
  <input type=hidden name="flowitem" value="<%=flowitem%>"/>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr>
       <td>名称<input name="name" value="<%if(name!=null)out.print(name);%>"></td>
       <td>流程<select name="flow">
	   <option value="">---------
       <%
           java.util.Enumeration enumer_flow=Flow.find(community,"");
           while(enumer_flow.hasMoreElements())
           {
             int flow_id=((Integer)enumer_flow.nextElement()).intValue();
             out.print("<option value="+flow_id);
             if(flow!=null&&flow.length()>0&&Integer.parseInt(flow)==flow_id)
             out.println(" SELECTED ");
             out.println(" >"+Flow.find(flow_id).getName(teasession._nLanguage));
           }
           %></select></td>
         <td><input type="submit" value="查询"/></td></tr>
</table>
</form>
<br>



<h2>列表</h2>
<form name=form1 METHOD=get  action="/jsp/admin/flow/EditFlowbusiness.jsp">
  <input type=hidden name="community" value="<%=community%>"/>
  <input type=hidden name="flowitem" value="<%=flowitem%>"/>
  <input type=hidden name="flowbusiness" value="0"/>
  <input type="hidden" name="nexturl" value="<%=request.getRequestURI()+"?"+request.getQueryString()%>"/>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr id="tableonetr">
      <td nowrap>序号</td>
      <td nowrap>事务名称</td>
      <td nowrap>流程名称</td>
      <td nowrap>流程类别</td>
      <td></td>
    </tr>
<%
java.util.Enumeration enumer=Flowbusiness.find(flowitem,sql.toString());
for(int index=1;enumer.hasMoreElements();index++)
{
  int flowbusiness=((Integer)enumer.nextElement()).intValue();
  Flowbusiness obj=Flowbusiness.find(flowbusiness);
  Flow flow_obj=Flow.find(obj.getFlow());
  %>
  <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    <td><%=index%></td>
    <td nowrap>ddd</td>
    <td><%=flow_obj.getName(teasession._nLanguage)%></td>
    <td nowrap><%=Flow.FLOW_TYPE[flow_obj.getType()]%></td>
    <td nowrap>
      <input type="submit" value="编辑" onclick="form1.flowbusiness.value=<%=flowbusiness%>; form1.flowitem.value=<%=flowitem%>;"/>
      <input type="submit" name="delete" value="删除" onclick="if(confirm('确定删除?')){form1.flowbusiness.value=<%=flowbusiness%>;form1.METHOD='POST';}else return false;"/>
    </td>
 </tr>
<%
}
%>
</table>

<br>
<h2>创建</h2>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<%
//如果是自由流程 OR 只有在第一步中出现的经办人可以了创建(固定流程)
enumer=Flow.find(teasession._strCommunity," and itemtype=1 AND ( type=1 OR flow IN ( SELECT flow FROM Flowprocess WHERE step=1 AND member LIKE "+DbAdapter.cite("%/"+teasession._rv._strV+"/%")+" ) )");
if(!enumer.hasMoreElements())
{
  out.print("<tr><td>暂无记录</td></tr>");
}
for(int index=1;enumer.hasMoreElements();index++)
{
  int id=((Integer)enumer.nextElement()).intValue();
  Flow obj=Flow.find(id);
  out.print("<tr><td>");
  Flowprocess fp=Flowprocess.find(id,1);
  if(fp.isExists())
  {
    out.println("<input type=button value=\""+fp.getName(teasession._nLanguage)+"\" onclick=\"window.open('/jsp/admin/flow/EditFlowdynamicvalue_2.jsp?flowitem="+flowitem+"&community="+teasession._strCommunity+"&flow="+id+"&dynamic="+obj.getDynamic()+"&flowbusiness=0&nexturl='+encodeURIComponent(document.location),'_self');\" >");
  }else//没有第一步
  {
    out.println("<input type=button disabled value=\""+obj.getName(teasession._nLanguage)+"\" >");
  }
}
%>
</table>
</form>

<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
