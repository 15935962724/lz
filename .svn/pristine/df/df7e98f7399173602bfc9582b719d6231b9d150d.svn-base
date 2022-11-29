<%@page contentType="text/html;charset=UTF-8" %><%@page import="java.util.*" %><%@ page import="tea.db.DbAdapter"%><%@ page import="tea.resource.Resource"%><%@ page import="tea.entity.admin.*" %><%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String community=request.getParameter("community");
int flowitem=Integer.parseInt(request.getParameter("flowitem"));

Resource r=new Resource();

String member=teasession._rv.toString();

StringBuffer sql=new StringBuffer();
sql.append(" AND step>0 AND (");
sql.append(" fb.flowbusiness IN( SELECT fbm.flowbusiness FROM FlowbusinessMember fbm WHERE fbm.transactor="+DbAdapter.cite(member)+" OR fbm.consign="+DbAdapter.cite(member)+" )");
//可控流程///控制流程转向///
sql.append(" OR ( ( fb.creator="+DbAdapter.cite(member)+" OR fb.maintransactor="+DbAdapter.cite(member)+" OR fb.mainconsign="+DbAdapter.cite(member)+") AND EXISTS ( SELECT f.flow FROM Flow f WHERE f.type=2 AND f.flow=fb.flow ) )");
sql.append(")");

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

//System.out.println(sql.toString());

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

<h1>工作事务</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br>

<h2>查询</h2>
   <form name=foEdit action="<%=request.getRequestURI()%>" onSubmit="">
   <input type=hidden name="community" value="<%=community%>"/>
      <input type=hidden name="flowitem" value="<%=flowitem%>"/>
     <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr>
       <td>名称
       <input name="name" value="<%if(name!=null)out.print(name);%>"></td>
       <td>流程
         <select name="flow">
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

<h2>列表</h2>
<form name="form1" action="/jsp/admin/flow/EditFlowbusiness.jsp">
  <input type="hidden" name="community" value="<%=community%>"/>
  <input type="hidden" name="flowitem" value="<%=flowitem%>"/>
  <input type="hidden" name="flowbusiness" value="0"/>
  <input type="hidden" name="dynamic" value="0"/>
  <input type="hidden" name="flow" value="0"/>
  <input type="hidden" name="nexturl" value="<%=request.getRequestURI()+"?"+request.getQueryString()%>"/>

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

Enumeration enumer=Flowbusiness.find(flowitem,sql.toString());
for(int index=1;enumer.hasMoreElements();index++)
{
  int flowbusiness=((Integer)enumer.nextElement()).intValue();
  Flowbusiness fb=Flowbusiness.find(flowbusiness);
  Flow f=Flow.find(fb.getFlow());

  Flowprocess fp=Flowprocess.find(fb.getFlow(),fb.getStep());

  Flowview fv=Flowview.find(flowbusiness,fb.getStep(),member);
  %>
  <script>
  function fevaluate_<%=index%>()
  {
    form1.dynamic.value=<%=f.getDynamic()%>;
    form1.flowbusiness.value=<%=flowbusiness%>;
    form1.flow.value=<%=fb.getFlow()%>;
  }
  </script>
  <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    <td width="1"><%=index%></td>
    <td nowrap>
    <%
    if(fv.isExists())
    {
      out.print("已接收");
    }else
    {
      out.print("未接收");
    }
    %></td>
    <td nowrap><%=fb.getName(teasession._nLanguage)%></td>
    <td><%=f.getName(teasession._nLanguage)%></td>
    <td nowrap><%=Flow.FLOW_TYPE[f.getType()]%></td>
    <td>第<%=fb.getStep()%>步
      <%
      //如果不是自由流程才显示，步骤名
      if(f.getType()!=1)
      {
        out.print(":"+fp.getName(teasession._nLanguage));
      }
      %></td>
      <td nowrap>
      <input type="submit" value="办理" onclick="fevaluate_<%=index%>();form1.action='/jsp/admin/flow/EditFlowdynamicvalue.jsp';"/>
      <%
      if(fb.isMemberExists(member))
      {
        String consign=fb.getConsign(member);
        if(consign!=null&&consign.length()>0)
        {
          out.print("<input type=submit name=recovery value=收回 onclick=\"if(confirm('确认收回委托?')){ fevaluate_"+index+"(); form1.method='post'; form1.action='/jsp/admin/flow/EditFlowbusinessConsign.jsp'; }else{ return false; }\">");
        }else
        {
          out.print("<input type=submit value=委托 onclick=\"fevaluate_"+index+"();form1.action='/jsp/admin/flow/EditFlowbusinessConsign.jsp';\">");
        }
      }
      %>
      <input type="button" value="流程图" onclick="flow_view(<%=fb.getFlow()%>,<%=flowbusiness%>);"/>
      <%
      //当前不是第一步&&待办者不是多选
      if(fb.getStep()>1&&!fp.isCheckbox())
      {
        out.print("<input type=submit name=back value=回上一步 onclick=\"if(window.confirm('确认要回传该工作至上一步骤么？')){fevaluate_"+index+"(); form1.method='post'; form1.action='/jsp/admin/flow/EditFlowbusinessStep.jsp';}else return false;\" />");
      }

      //可控流程 && 发起人 && 是否已走过主控 || 主控待办人 || 主控委托人
      String maintransactor=fb.getMainTransactor();
      if(f.getType()==2 && maintransactor!=null && maintransactor.length()>0&&( member.equals(fb.getCreator()) || member.equals(maintransactor) || member.equals(fb.getMainConsign()) ))
      {
        out.print(" <input type=submit value=管理"+f.getName(teasession._nLanguage)+" onclick=\"fevaluate_"+index+"();form1.action='/jsp/admin/flow/EditFlowbusinessStep.jsp';\" />");
      }else
      if(fv.isExists())//未接收，不可传下一步
      {
        out.print("<input type=submit value=传下一步 onclick=\"fevaluate_"+index+"(); form1.action='/jsp/admin/flow/EditFlowbusinessStep.jsp';\" />");
      }


      %>
      <!--input type="submit" name="delete" value="删除" onclick="if(confirm('确定删除?')){form1.flowbusiness.value=<%=flowbusiness%>;form1.METHOD='POST';}else return false;"/-->
    </td>
 </tr>
<%
}
%>
</table>

</form>
<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</HTML>
