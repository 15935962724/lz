<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter"%> <%@ page import="tea.resource.Resource"%><%@ page import="tea.entity.admin.*" %><%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String community=request.getParameter("community");
int flow=Integer.parseInt(request.getParameter("flow"));
int flowbusiness=Integer.parseInt(request.getParameter("flowbusiness"));

Flow flow_obj=Flow.find(flow);
  
Resource r=new Resource();

StringBuffer sql=new StringBuffer();

sql.append(" ORDER BY sequence");

%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<script type="">
function flow_view(flow,flowbusiness)
{
  myleft=(screen.availWidth-500)/2;
  window.open("/jsp/admin/flow/Flowviews.jsp?community=<%=community%>&flow="+flow+"&flowbusiness="+flowbusiness,"flow_view","status=0,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable=yes,width=500,height=350,left="+myleft+",top=100");
}
</script>
</head>
<body>

<h1>此工作事务下存在以下步骤</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br>

<h2>列表</h2>

   <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr id="tableonetr">
     <td ></td>
     <td nowrap>状态</td>
     <td nowrap>事务名称</td>
     <td nowrap>流程名称</td>
     <td nowrap>流程类别</td>
     <td nowrap>步骤</td>
     <td></td>
     </tr>
     <%

java.util.Enumeration enumer=Flowprocess.find(flow,sql.toString());
for(int index=1;enumer.hasMoreElements();index++)
{
  int flowprocess=((Integer)enumer.nextElement()).intValue();
  Flowprocess obj=Flowprocess.find(flowprocess);

  %>
  <script>
  function fevaluate_<%=index%>()
  {
    form1.dynamic.value=<%=flow_obj.getDynamic()%>;
    form1.flowbusiness.value=<%=flowbusiness%>;
    form1.flow.value=<%=obj.getFlow()%>;
  }
  </script>
  <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    <td width="1"><%=index%></td>
    <td nowrap>
    <%
    Flowview fv_obj=Flowview.find(flowbusiness,obj.getSequence());
    if(fv_obj.isExists())
    {
      out.print("已接收");
    }else
    {
      out.print("未接收");
    }
    %></td>
    <td nowrap><%=obj.getName(teasession._nLanguage)%></td>
    <td><%=flow_obj.getName(teasession._nLanguage)%></td>
    <td nowrap><%=Flow.FLOW_TYPE[flow_obj.getType()]%></td>
    <td>第<%=obj.getSequence()%>步
      <%//固定流程才显示，步骤名
      if(flow_obj.getType()==0)
      out.print(":"+obj.getName(teasession._nLanguage));
      %></td>
    <td nowrap>
      <input type="button" value="流程图" onclick="flow_view(<%=flow%>,<%=flowbusiness%>);"/>
    </td>
 </tr>
<%
}
%>
</table>

<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</HTML>



