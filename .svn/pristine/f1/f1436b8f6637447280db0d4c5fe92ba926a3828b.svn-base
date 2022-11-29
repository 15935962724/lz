<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter"%> <%@ page import="tea.resource.Resource"%><%@ page import="tea.entity.admin.*" %><%@ page import="tea.entity.member.*" %><%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String community=teasession._strCommunity;//request.getParameter("community");
String menuid=request.getParameter("id");

Resource r=new Resource();

StringBuffer sql=new StringBuffer(" AND type = 0");
StringBuffer par=new StringBuffer();
par.append("?community=").append(teasession._strCommunity);
par.append("&id=").append(menuid);

//只有项目创建者和项目经理可见
sql.append(" AND ( creator="+DbAdapter.cite(teasession._rv._strV)+" OR manager LIKE "+DbAdapter.cite("%/"+teasession._rv._strV+"/%")+" )");


String name=request.getParameter("name");
if(name!=null&&name.length()>0)
{
  sql.append(" AND flowitem IN (SELECT flowitem FROM FlowitemLayer WHERE name LIKE "+DbAdapter.cite("%"+name+"%")+")");
  par.append("&name=").append(java.net.URLEncoder.encode(name,"UTF-8"));
}

String creator=(request.getParameter("creator"));
if(creator!=null&&creator.length()>0)
{
  sql.append(" AND creator LIKE "+DbAdapter.cite("%"+creator+"%"));
  par.append("&creator=").append(java.net.URLEncoder.encode(creator,"UTF-8"));
}
par.append("&pos=");
String tmp=request.getParameter("pos");
int pos=tmp==null?0:Integer.parseInt(tmp);
int count=Flowitem.count(community,sql.toString());
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

<h1>项目管理</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br>

<h2>查询</h2>
   <form name=foEdit METHOD=get action="<%=request.getRequestURI()%>" onSubmit="">
   <input type=hidden name="community" value="<%=community%>"/>
     <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr>
       <td>名称<input name="name" value="<%if(name!=null)out.print(name);%>"></td>
       <td>创建者<input name="creator" value="<%if(creator!=null)out.print(creator);%>"></td>
       <td><input type="submit" value="查询"/></td></tr>
</table>
</form>
<h2>列表 <%=count%></h2>
   <form name=form1 METHOD=get  action="/jsp/admin/workreport/EditFlowitem.jsp">
   <input type=hidden name="community" value="<%=community%>"/>
   <input type=hidden name="flowitem" value="0"/>
   <input type="hidden" name="nexturl" value="<%=request.getRequestURI()+"?"+request.getQueryString()%>"/>
   <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr id="tableonetr">
       <td nowrap>序号</td>
       <td nowrap>项目名称</td>
       <td nowrap>项目经理</td>
       <td nowrap>项目创建者</td>
       <td nowrap>创建时间</td>
       <td nowrap>预计完成时间</td>
       <td>操作</td>
     </tr>
<%
java.util.Enumeration enumer=Flowitem.find(community,sql.toString(),pos,15);
for(int index=pos+1;enumer.hasMoreElements();index++)
{
  int flowitem=((Integer)enumer.nextElement()).intValue();
  Flowitem obj=Flowitem.find(flowitem);

  %>
  <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    <td align="center"><%=index%></td>
    <td nowrap><%=obj.getName(teasession._nLanguage)%></td>
    <td align="center" nowrap><%
         String str[]=obj.getManager().split("/");
         for(int i=1;i<str.length;i++)
         {
        	 Profile p=Profile.find(str[i]);
        	// out.print(str[i]+" ( "+p.getLastName(teasession._nLanguage)+p.getFirstName(teasession._nLanguage)+" )<br>");
              	out.print(p.getLastName(teasession._nLanguage)+p.getFirstName(teasession._nLanguage)+"<br>");
         }
         %></td>
    <td align="center" nowrap>
    <%
    Profile p=Profile.find(obj.getCreator());
	//out.print(obj.getCreator()+" ( "+p.getLastName(teasession._nLanguage)+p.getFirstName(teasession._nLanguage)+" )");
    out.print(p.getName(teasession._nLanguage));
    %></td>
    <td align="center" nowrap><%=obj.getCtimeToString()%></td>
    <td align="center" nowrap><%=obj.getFtimeToString()%></td>
    <td nowrap>
      <input type="submit" value="编辑" onClick="form1.flowitem.value=<%=flowitem%>;"/>
      <input type="submit" value="编辑事务" onClick="form1.flowitem.value=<%=flowitem%>;form1.action='/jsp/admin/flow/Flowbusiness.jsp?flowitem=<%=flowitem%>';"/>
      <input type="submit" name="delete" value="删除" onClick="if(confirm('确定删除?')){form1.flowitem.value=<%=flowitem%>;form1.METHOD='POST';}else return false;"/>
    </td>
 </tr>
<%
}
if(count>15)out.print("<tr><td colspan='30' align='right'>"+new tea.htmlx.FPNL(teasession._nLanguage,par.toString(),pos,count,15));
%>
</table>
<input type="submit" name="new" value="<%=r.getString(teasession._nLanguage,"CBNew")%>" onClick="form1.flowitem.value=0;">
</form>
<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</HTML>
