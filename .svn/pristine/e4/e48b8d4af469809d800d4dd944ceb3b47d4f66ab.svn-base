<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter" %>
<%@ page  import="tea.resource.*"  %>
<%@ page  import="tea.entity.admin.*" %>
<%@ page  import="tea.htmlx.*" %>
<%@ page  import="tea.entity.admin.sales.*" %>
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

Resource r=new Resource("/tea/resource/Workreport");

int workproject =0;//项目的ID号
if(request.getParameter("workproject")!=null && request.getParameter("workproject").length()>0)
	 workproject = Integer.parseInt(request.getParameter("workproject"));


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
<body onLoad="">
<form name=form1 METHOD=post action="/servlet/EditWorkreport" onSubmit="return submitText(this.name,'<%=r.getString(teasession._nLanguage,"InvalidSubject")%>')">


  <h2>项目核算-工作人员</h2>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
  	<td>工作人员</td>
  	<td>开发成本</td>
  	<td>开发耗时</td>

  </tr>
  <%

  		java.util.Enumeration wome = Worklog.find_member(teasession._strCommunity," and workproject="+workproject,0,Integer.MAX_VALUE);
  		if(!wome.hasMoreElements())
  		{
  			out.print("<tr><td>暂无记录</td></tr>");

  		}
  		int chengben =0;
  		float haoshi=0;
  		while(wome.hasMoreElements())
  		{
  			String member = ((String)wome.nextElement());
  			//Worklog woobj =Worklog.find(member);
  			chengben = Worklog.count_member(teasession._strCommunity," and workproject ="+workproject+"  and member="+DbAdapter.cite(member));//开发成本
  			haoshi = Worklog.count_Hm(teasession._strCommunity," and workproject ="+workproject+"  and member="+DbAdapter.cite(member));
  			Profile probj = Profile.find(member);

   %>
   <tr>

   		<td><a href="/jsp/admin/workreport/Worklogs_5.jsp?workproject=<%=workproject%>&member=<%=member%>"><%=probj.getLastName(teasession._nLanguage)+probj.getFirstName(teasession._nLanguage)%></a></td>
   		<td><%=chengben %>元</td>
   		<td><%=Worklog.dff.format(haoshi) %>小时</td>

   </tr>
   <%
   		}
    %>
  </table>
<h2>项目核算-工作类型</h2>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
  	<td>工作类型</td>
  	<td>开发成本</td>
  	<td>开发耗时</td>

  </tr>
  <%
  		int type_chengben =0;
  		float type_haoshi =0;
  		java.util.Enumeration me = Worklog.find_worktype(teasession._strCommunity," and workproject="+workproject,0,Integer.MAX_VALUE);
  			if(!me.hasMoreElements())
  		{
  			out.print("<tr><td>暂无记录</td></tr>");

  		}
  		while(me.hasMoreElements())
  		{
  			int worktype =((Integer)me.nextElement()).intValue();
  			//Worklog wobj = Worklog.find_worktype(worktype);
  			Worktype obj=Worktype.find(worktype);
  			type_chengben = Worklog.count_member(teasession._strCommunity," and workproject ="+workproject+"  and worktype="+worktype);//开发成本
  			type_haoshi = Worklog.count_Hm(teasession._strCommunity," and workproject ="+workproject+"  and worktype="+worktype);
  			if(obj.getName(teasession._nLanguage)!=null){
   %>
      <tr>
   		<td><%=obj.getName(teasession._nLanguage)%></td>
   		<td><%=type_chengben %>/元</td>
   		<td><%=Worklog.dff.format(type_haoshi) %>/小时</td>
    </tr>

   <%
			}
   		}
    %>
  </table>
</form>
<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>



