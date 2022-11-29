<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter"%> <%@ page import="tea.resource.Resource"%><%@ page import="tea.entity.*" %><%@ page import="tea.entity.site.*" %><%@ page import="tea.entity.admin.*" %><%@ page import="tea.ui.TeaSession" %><%request.setCharacterEncoding("UTF-8"); response.setHeader("Cache-Control", "no-cache");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

Http h=new Http(request);

Resource r=new Resource();

StringBuffer sql=new StringBuffer();

String type=(request.getParameter("type"));
if(type!=null&&type.length()>0)
{
  sql.append(" AND type="+type);
}


String name=request.getParameter("name");
if(name!=null&&name.length()>0)
{
  sql.append(" AND(flow IN(SELECT flow FROM FlowLayer WHERE name LIKE "+DbAdapter.cite("%"+name+"%")+")");
  sql.append(" OR flow IN(SELECT flow FROM Flowprocess f INNER JOIN FlowprocessLayer fl ON f.flowprocess=fl.flowprocess WHERE name LIKE "+DbAdapter.cite("%"+name+"%")+"))");
}


String menuid=request.getParameter("id");

h.debug="127.0.0.1".equals(request.getRemoteAddr());

%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<script type="">
function f_act(act,flow)
{
  if(act=="edit")
  {
  }else if(act=="proc")
  form1.action="/jsp/admin/flow/Flowprocess.jsp";
  else
  {
    if(act=="del"&&!confirm('确定删除?'))return;
    form1.method="post";
    form1.act.value=act;
    form1.target="_ajax";
  }
  form1.flow.value=flow;
  form1.submit();
}
</script>
</head>
<body>

<h1>管理流程</h1>
<br>
<div id="head6"><img height="6" src="about:blank"></div>
<h2>查询</h2>
<form action="?">
<input type=hidden name="community" value="<%=teasession._strCommunity%>">
<input type=hidden name="id" value="<%=menuid%>">

  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td>名称<input name="name" value="<%if(name!=null)out.print(name);%>"></td>
        <td>类别
          <select name="type">
            <option value="">---------
            <%
            for(int i=0;i<Flow.FLOW_TYPE.length;i++)
            {
              out.print("<option value="+i);
              if(String.valueOf(i).equals(type))
              out.println(" SELECTED ");
              out.println(" >"+Flow.FLOW_TYPE[i]);
            }
            %></select>
        </td>
        <td><input type="submit" value="查询"/></td>
    </tr>
  </table>
</form>

<h2>列表</h2>
<form name=form1 action="/jsp/admin/flow/EditFlow.jsp">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="flow" value="0"/>
<input type="hidden" name="act" />
<input type="hidden" name="nexturl" value="<%=request.getRequestURI()+"?"+request.getQueryString()%>"/>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr id="tableonetr">
    <td nowrap>序号</td>
    <td nowrap>流程名称</td>
    <td nowrap>流程类别</td>
    <td nowrap>表单</td>
    <td>操作</td>
  </tr>
<%

java.util.Enumeration enumer=Flow.find(teasession._strCommunity,sql.toString());
for(int i=1;enumer.hasMoreElements();i++)
{
  int flow=((Integer)enumer.nextElement()).intValue();
  Flow obj=Flow.find(flow);
  int did=obj.getDynamic();
  %>
  <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    <td align="center"><%=i%></td>
    <td nowrap><%=(h.debug?flow+"、":"")+obj.getName(teasession._nLanguage)%></td>
    <td align="center" nowrap><%=Flow.FLOW_TYPE[obj.getType()]%></td>
    <td align="center"><%=(h.debug?did+"、":"")+Dynamic.find(did).getName(teasession._nLanguage)%></td>
    <td align="center" nowrap>
    <%
    if(!obj.isRun())
    {
      out.print("<input type=button value='编辑属性' onClick=f_act('edit',"+flow+");> ");
      out.print("<input type=button value='删除' onClick=f_act('del',"+flow+")> ");
    }
    out.print("<input type=button id=CBCloneid value='"+r.getString(teasession._nLanguage, "CBClone")+"' onclick=f_act('clone',"+flow+")> ");
    if(obj.getType()!=1)
    {
      out.print("<input type=button value='编辑流程' onclick=f_act('proc',"+flow+");>");
    }
    %>
    </td>
  </tr>
<%
}
%>
</table>
<input type="submit" name="new" value="<%=r.getString(teasession._nLanguage,"CBNew")%>" onClick="form1.flow.value=0;">
</form>


<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</HTML>
