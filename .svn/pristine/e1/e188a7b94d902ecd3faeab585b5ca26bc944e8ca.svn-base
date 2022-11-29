<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.entity.subscribe.*"%><%@page import="tea.ui.*"%><%@page import="tea.entity.node.*"%><%@page import="tea.html.*"%><%@page import="tea.db.*"%><%@page import="tea.entity.site.*"%><%@page import="tea.resource.*"%><%@page import="java.util.*"%><%@page import="java.io.*"%>
<%@page import="java.net.URLEncoder"%>

<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");
TeaSession teasession=new TeaSession(request);

if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

Resource r=new Resource();
r.add("/tea/ui/node/general/EditNode");


String nexturl = request.getRequestURL() + "?node="+teasession._nNode + request.getContextPath();




StringBuffer sql = new StringBuffer(" and node = "+teasession._nNode);
StringBuffer param = new StringBuffer();
param.append("?id=").append(request.getParameter("id"));
param.append("&community=").append(teasession._strCommunity);
param.append("&node=").append(teasession._nNode);


String tacname = teasession.getParameter("tacname");//策略名称
if(tacname!=null && tacname.length()>0)
{
	tacname = tacname.trim();
	sql.append(" AND tacname like ").append(DbAdapter.cite("%"+tacname+"%"));
	param.append("&tacname=").append(URLEncoder.encode(tacname,"UTF-8"));
}
//公布
int publish = -1;
if(teasession.getParameter("publish")!=null && teasession.getParameter("publish").length()>0)
{
	publish = Integer.parseInt(teasession.getParameter("publish"));
}
if(publish>=0)
{
	sql.append(" AND publish = ").append(publish);
	param.append("&publish=").append(publish);
}


int pos = 0, pageSize = 10, count = 0;
if (request.getParameter("pos") != null) {
  pos = Integer.parseInt(request.getParameter("pos"));
}
count = Tactics.count(teasession._strCommunity,sql.toString());

sql.append(" order by createtime desc ");




 
%>

<html>
<head>
<title>策略管理</title>
<script src="/tea/tea.js" type="text/javascript"></script>
<link href="/tea/tea.css" rel="stylesheet" type="text/css"/>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

</head>
<body >
<script>

function f_edit(igd)
{
 form1.tid.value=igd;
  form1.action="/jsp/general/subscribe/EditTactics.jsp";
  form1.submit();
} 

function f_sub(igd,strigd)
{

	try{
		if((form1.checkbox_subid.length+"")=="undefined")    
		{
	 	 		if(!form1.checkbox_subid.checked)
	 	 		{
	 	 			alert(strigd);
					return false;
	 	 	 	}
	 	 		
	 	 }else
	 	 {
			    var f = false;
			    for (var i=0; i< form1.checkbox_subid.length; i++)
			    {
			      if (form1.checkbox_subid[i].checked)
			      {
				      f = true;
				  }
			    }
			    if(!f)
			    {
					alert(strigd);
					return false;
			    }
	 	 }
	}catch(e)
	{
		alert(strigd);
		return false;
	}

	if(igd=='delete')
	{
	   if(confirm('您确认执行【删除】操作?'))
	    {
	      form1.act.value="f_sub";
	      form1.onclick_act.value='delete';
	      form1.action = '/servlet/EditTactics';
	      form1.submit();
	    }
	}
	if(igd=='publish')
	{
		 if(confirm('您确认执行【公布】操作?'))
		    {
		      form1.act.value="f_sub";
		      form1.onclick_act.value='publish';
		      form1.action = '/servlet/EditTactics';
		      form1.submit();
		    }
	}
	if(igd=='nopublish')
	{
		if(confirm('您确认执行【取消公布】操作?'))
	    {
	      form1.act.value="f_sub";
	      form1.onclick_act.value='nopublish';
	      form1.action = '/servlet/EditTactics';
	      form1.submit();
	    }
	}
}

function CheckAll()
{
	var checkname=document.getElementsByName("checkall");   
	var fname=document.getElementsByName("checkbox_subid");
	var lname=""; 
	if(checkname[0].checked){
	    for(var i=0; i<fname.length; i++){ 
	      fname[i].checked=true; 
	}   
	}else{
	   for(var i=0; i<fname.length; i++){ 
	      fname[i].checked=false; 
	   } 
	}
}

</script>

<h1>策略管理</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form action="?" name="form1" method="POST" >
<input type="hidden" name="node" value="<%=teasession._nNode %>"/>
<input type="hidden" name="community" value="<%=teasession._strCommunity %>"/>  
<input type="hidden" name="nexturl" value="<%=nexturl %>"/>  
<input type="hidden" name="act">
<input type="hidden" name="onclick_act">
<input type="hidden" name="tid"/>
<h2>查询</h2>

 <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
	<tr>
		<td>策略名称：</td>
		<td><input type=text name="tacname" value="<%if(tacname!=null)out.print(tacname); %>"></td>
		<td>公布状态:</td>
		<td>
			<select name="publish">
				<option value="-1">--全部--</option>
				<%
					for(int i = 0;i<Tactics.PUBLISH_TYPE.length;i++)
					{
						out.print("<option value="+i);
						if(publish==i)
						{
							out.print(" selected ");
						}
						out.print(">"+Tactics.PUBLISH_TYPE[i]);
						out.print("</option>");
					}
				%>

		   </select>
      </td>
      <td><input type="submit" value="查询"/></td>
	</tr> 
 </table>


<h2>策略列表</h2>

<h2>
<input type="button" value="　增加　" onclick="window.open('/jsp/general/subscribe/EditTactics.jsp?node=<%=teasession._nNode %>&nexturl=<%=nexturl %>','_self');">&nbsp;
<input type="button" value="　删除　" onclick="f_sub('delete','请选择你要删除的策略!');">&nbsp;
<input type="button" value="　公布　" onclick="f_sub('publish','请选择你要公布的策略!');">&nbsp;
<input type="button" value="　取消公布　" onclick="f_sub('nopublish','请选择你要取消公布的策略!');">&nbsp; 

 </h2>
 
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr id=tableonetr>
	    <td width=1><input type="checkbox" name="checkall" onclick="CheckAll()" /></td>
	      <td nowrap>策略名称</td>
	      <td nowrap>公布状态</td>
	       <td nowrap>生效条件</td>
	       <td nowrap>公布操作人</td>
	       <td nowrap>公布操作时间</td>
	       <td nowrap>操作</td>
    </tr>
    <%
    
  // out.println(sql.toString());
	Enumeration e = Tactics.find(teasession._strCommunity,sql.toString(),pos,pageSize);
    if(!e.hasMoreElements())
    {
        out.print("<tr><td colspan=10 align=center>暂无策略记录</td></tr>");
    }
      for(int i = 1;e.hasMoreElements();i++)
      {
       
			int tid = ((Integer)e.nextElement()).intValue();
			Tactics tobj = Tactics.find(tid);
			
    %>
    <tr onmouseover=bgColor='#BCD1E9'; onmouseout=bgColor=''; >
    <td width=1><input type="checkbox" name="checkbox_subid" value="<%=tid %>"/></td>
    <td><%=tobj.getTacname() %></td>
    
        <td><%if(tobj.getPublish()==1){out.print(Tactics.PUBLISH_TYPE[tobj.getPublish()]);}else if(tobj.getPublish()==0){out.print("<font color=Red>"+Tactics.PUBLISH_TYPE[tobj.getPublish()]+"</font>");}%></td>
         <td><%=Tactics.CONDITION_TYPE[tobj.getCondition()]%></td>
        <td><%if(tobj.getPublish()==1){out.print(tobj.getPublishmember());} %></td>
        <td><%if(tobj.getPublish()==1){out.print(tobj.getPublishtimeToString());} %></td>  
        <td><a href="/jsp/general/subscribe/TacticsShow.jsp?tid=<%=tid %>&node=<%=teasession._nNode %>&community=<%=teasession._strCommunity %>"  >查看</a>&nbsp;
        <%
       if(tobj.getPublish()==0)//未公布
        {
        	out.print("<a href=\"#\" onclick=\"f_edit('"+tid+"');\">修改</a>");
        }
        %>
       
        </td>
    </tr>
    <%} %>
     <%if (count > pageSize) {  %>
      <tr> <td colspan="10"><%=new tea.htmlx.FPNL(teasession._nLanguage,request.getRequestURI()+param.toString()+"&pos=",pos,count,pageSize)%>    </td> </tr>
      <%}  %>
  </table>
</form>
</body>
</html>
