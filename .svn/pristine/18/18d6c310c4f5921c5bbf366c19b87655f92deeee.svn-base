<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter"%><%@ page import="tea.resource.Resource"%><%@ page import="tea.entity.admin.*" %><%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String community=request.getParameter("community");

Resource r=new Resource();

StringBuffer sql=new StringBuffer();

String member=teasession._rv.toString();

//必须存在工作事务
sql.append(" AND flowitem IN( SELECT fb.flowitem FROM Flowbusiness fb INNER JOIN FlowbusinessMember fbm ON fb.flowbusiness=fbm.flowbusiness WHERE fbm.transactor="+DbAdapter.cite(member)+" OR fbm.consign="+DbAdapter.cite(member));
//可控流程///控制流程转向///
sql.append(" OR ( ( fb.creator="+DbAdapter.cite(member)+" OR fb.maintransactor="+DbAdapter.cite(member)+" OR fb.mainconsign="+DbAdapter.cite(member)+") AND EXISTS ( SELECT f.flow FROM Flow f WHERE f.type=2 AND f.flow=fb.flow ) )");
sql.append(")");

String name=request.getParameter("name");
if(name!=null&&name.length()>0)
{
  sql.append(" AND flow IN (SELECT flow FROM FlowLayer WHERE name LIKE "+DbAdapter.cite("%"+name+"%")+")");
}

String creator=request.getParameter("creator");
if(creator!=null&&creator.length()>0)
{
  sql.append(" AND creator LIKE "+DbAdapter.cite("%"+creator+"%"));
}

//System.out.println(sql.toString());

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

<h1>待办工作</h1>
<br>
<div id="head6"><img height="6" src="about:blank"></div>
<h2>查询</h2>
<form name=foEdit METHOD=get action="<%=request.getRequestURI()%>" onSubmit="">
  <input type=hidden name="community" value="<%=community%>"/>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td>名称<input name="name" value="<%if(name!=null)out.print(name);%>"></td>
        <td>创建者<input name="creator" value="<%if(creator!=null)out.print(creator);%>"></td>
          <td><input type="submit" value="查询"/></td>
    </tr>
</table>
</form>

<h2>列表</h2>
   <form name=form1 METHOD=get action="/jsp/admin/flow/Flowbusiness2.jsp">
   <input type=hidden name="community" value="<%=community%>"/>
   <input type=hidden name="flowitem" value="0"/>
   <!--input type="hidden" name="nexturl" value="<%=request.getRequestURI()+"?"+request.getQueryString()%>"/-->
   <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr id="tableonetr">
       <td nowrap>序号</td>
       <td nowrap>项目名称</td>
       <td nowrap>项目经理</td>
       <td nowrap>项目创建者</td>
       <td nowrap>创建时间</td>
       <td nowrap>预计完成时间</td>
     </tr>
<%

java.util.Enumeration enumer=Flowitem.find(community,sql.toString());
for(int index=1;enumer.hasMoreElements();index++)
{
  int flowitem=((Integer)enumer.nextElement()).intValue();
  Flowitem obj=Flowitem.find(flowitem);
  %>
  <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    <td align="center"><%=index%></td>
    <td nowrap><A href="javascript:form1.flowitem.value=<%=flowitem%>;form1.submit();" ><%=obj.getName(teasession._nLanguage)%></A></td>
    <td align="center" nowrap><%=obj.getManagerToHtml(teasession._nLanguage)%></td>
    <td align="center" nowrap><%=obj.getCreatorToHtml(teasession._nLanguage)%></td>
    <td align="center" nowrap><%=obj.getCtimeToString()%></td>
    <td align="center" nowrap><%=obj.getFtimeToString()%></td>
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
