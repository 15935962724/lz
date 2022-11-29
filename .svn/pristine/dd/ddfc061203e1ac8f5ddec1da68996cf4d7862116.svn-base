<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter" %>
<%@ page  import="tea.resource.*"  %>
<%@ page  import="tea.entity.admin.*" %>
<%@ page  import="tea.htmlx.*" %>
<%@ page import="tea.ui.TeaSession" %>
<%@ page import="tea.entity.member.*" %>
<%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String community=teasession._strCommunity;
String nexturl = request.getRequestURI()+"?"+request.getQueryString();
int workproject = 0;
if(request.getParameter("workproject")!= null && request.getParameter("workproject").length()>0)
  workproject = Integer.parseInt(request.getParameter("workproject"));


Resource r=new Resource("/tea/resource/Workreport");



StringBuffer sql=new StringBuffer();

//只有项目创建者和项目经理可见
//sql.append(" and workproject = "+workproject+"  AND ( creator="+DbAdapter.cite(teasession._rv._strV)+" OR manager LIKE "+DbAdapter.cite("%/"+teasession._rv._strV+"/%")+" )");

sql.append(" and type = 0 and workproject = "+workproject);


String name=request.getParameter("name");
if(name!=null&&name.length()>0)
{
  sql.append(" AND flowitem IN (SELECT flowitem FROM FlowitemLayer WHERE name LIKE "+DbAdapter.cite("%"+name+"%")+")");
}

String creator=(request.getParameter("creator"));
if(creator!=null&&creator.length()>0)
{
  sql.append(" AND creator LIKE "+DbAdapter.cite("%"+creator+"%"));
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
<script type="">
function f_delete(igd)
{
  if(confirm('确认删除？')){

    form1.flowitem.value=igd;
    form1.action='/servlet/EditFlowitem';
    form1.submit();
  }
}
</script>

<h1>项目管理</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br>

<h2>查询</h2>
   <form name=foEdit METHOD=get action="<%=request.getRequestURI()%>" onSubmit="">
   <input type=hidden name="community" value="<%=community%>"/>
   <input type=hidden name="workproject" value="<%=workproject %>">
     <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">

     <tr>
       <td>名称<input name="name" value="<%if(name!=null)out.print(name);%>"></td>
       <td>创建者<input name="creator" value="<%if(creator!=null)out.print(creator);%>"></td>
       <td><input type="submit" value="查询"/></td></tr>
</table>
</form>
<h2>列表</h2>
   <form name=form1 METHOD=get action="/jsp/admin/workreport/EditFlowitem.jsp">
   <input type=hidden name="community" value="<%=community%>"/>
   <input type=hidden name="flowitem" value="0"/>
   <input type="hidden" name="nexturl" value="<%=nexturl%>"/>
   <input type="hidden" name="workproject" value="<%=workproject %>">
   <input type="hidden" name="act2" value="delete"/>
   <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr id="tableonetr">
       <td nowrap>序号</td>
       <td nowrap>项目名称</td>
       <td nowrap>项目经理</td>
       <td nowrap>项目创建者</td>
       <td nowrap>创建时间</td>
       <td nowrap>预计完成时间</td>
       <td></td>
     </tr>
     <%
boolean falg = false;
java.util.Enumeration enumer=Flowitem.find(community,sql.toString());
  if(!enumer.hasMoreElements())
   {
       out.print("<tr><td colspan=10 align=center>暂无记录</td></tr>");
   }
for(int index=1;enumer.hasMoreElements();index++)
{
  int flowitem=((Integer)enumer.nextElement()).intValue();
  Flowitem obj=Flowitem.find(flowitem);

  Workproject workobj = Workproject.find(obj.getWorkproject());


  %>
  <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    <td><%=index%></td>
    <td nowrap><%=obj.getName(teasession._nLanguage)%></td>
    <td nowrap><%
         String str[]=obj.getManager().split("/");
         for(int i=1;i<str.length;i++)
         {
           Profile p=Profile.find(str[i]);
           out.print(str[i]+"("+p.getLastName(teasession._nLanguage)+p.getFirstName(teasession._nLanguage)+")<br>");
         }
         %></td>
    <td nowrap>
    <%
    Profile p=Profile.find(obj.getCreator());
	out.print(obj.getCreator()+"("+p.getLastName(teasession._nLanguage)+p.getFirstName(teasession._nLanguage)+")");
    %></td>
    <td nowrap><%=obj.getCtimeToString()%></td>
    <td nowrap><%=obj.getFtimeToString()%></td>
    <td nowrap>
      <input type="submit" value="编辑" onclick="form1.flowitem.value=<%=flowitem%>;"/>&nbsp;

<input type="button" name="delete" value="删除" onclick="f_delete('<%=flowitem%>');"/>


         <!--input type="submit" name="delete" value="删除" onclick="<%if(falg){out.print("alert('请勿删除！');");}else{out.print("if(confirm('确认删除？')){form1.workproject.value="+workproject+";form1.flowitem.value="+flowitem+";form1.METHOD='POST';}else return false;");}%>"/-->

  </td>
 </tr>
  <%
}
     %>
</table>
<br>
<input type="button" value="<%=r.getString(teasession._nLanguage,"创建项目")%>" onClick="window.open('/jsp/admin/workreport/EditFlowitem.jsp?community=<%=teasession._strCommunity  %>&workproject=<%=workproject %>&nexturl=<%=nexturl%>','_self');" >

&nbsp;<input type="button" value="<%=r.getString(teasession._nLanguage,"项目所属客户信息")%>" onClick="window.open('/jsp/admin/workreport/EditWorkproject.jsp?community=<%=teasession._strCommunity  %>&workproject=<%=workproject %>&nexturl=<%=nexturl%>','_self');" >
&nbsp;<input type=button value="返回" onClick="javascript:history.back()">
</form>
<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>



