<%@page contentType="text/html;charset=UTF-8"%>
<%@page import="tea.db.DbAdapter"%>
<%@page import="tea.resource.Resource"%>
<%@page import="tea.entity.admin.*"%>
<%@page import="tea.ui.TeaSession"%>
<%@page import="tea.entity.admin.sales.*"%>
<%@page import="java.util.*"%>
<%
	request.setCharacterEncoding("UTF-8");
	response.setHeader("Expires", "0");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Pragma", "no-cache");
	TeaSession teasession = new TeaSession(request);

	if (teasession._rv == null) 
	{
		response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
		return;
	}
	String community = teasession._strCommunity;

	int taid = Integer.parseInt(request.getParameter("taid"));

	Task taobj = Task.find(taid);
	
	String nexturl=request.getParameter("nexturl");

	int wearhours=0,wearminutes=0;
	int worklog=taobj.getWorklog();
	if(worklog>0)
	{
		Worklog wl = Worklog.find(taobj.getWorklog());
		wearhours=wl.getWearHours();
		wearminutes=wl.getWearMinutes();
	}

	Resource r = new Resource();

%>
<html>
	<head>
		<link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
		<script src="/tea/tea.js" type="text/javascript"></script>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
		<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
		<META HTTP-EQUIV="Expires" CONTENT="0">

	</head>
	<body onload="form1.ztcontent.focus();">
		<h1>
			任务状态编辑
		</h1>
		<div id="head6">
			<img height="6" src="about:blank">
		</div>
		<br>
		<form name=form1 METHOD=post action="/servlet/EditTask" >
				<input type="hidden" name="community" value="<%=community%>">
				<input type="hidden" name="taid" value="<%=taid%>">
				<input type="hidden" name="act" value="zhuangtai">
				<input type="hidden" name="nexturl" value="<%=nexturl%>">

			<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
				<tr>
					<td>
						任务状态：
					</td>
					<td>
						<select name="fettle">
							<%
									for (int i = 0; i < Task.FETTLE.length; i++)
									{
									out.print("<option value=" + i);
									if (taobj.getFettle() == i)
										out.print(" selected");
									out.print(">" + Task.FETTLE[i]);
								}
							%>
						</select>
					</td>
				</tr>
				<tr>
					<td>
						完成情况：
					</td>
					<td>
						<textarea name="ztcontent" cols="50" rows="5"><%if(taobj.getZtcontent() != null)out.print(taobj.getZtcontent());%></textarea>
					</td>
				</tr>
				<tr>
					<td nowrap>
						<%=r.getString(teasession._nLanguage, "耗时")%>
					</td>
					<td>
						<select name="wearhours">
							<%
									for (int i = 0; i <24; i++)
									{
									out.print("<option value=" + i);
									if (wearhours == i)
										out.print(" selected");
									out.print(">" + i);
									}
							%>
						</select>
						<%=r.getString(teasession._nLanguage, "小时")%>
						&nbsp;
						<select name="wearminutes">
							<%
									for (int i = 0; i <60; i++) 
									{
										out.print("<option vlaue=" + i);
										if (wearminutes == i)
											out.print(" selected");
										out.print(">" + i);
									}
							%>
						</select>
						<%=r.getString(teasession._nLanguage, "分钟")%>
					</td>
				</tr>
			</table>
			<input type="submit" value="提交" >
			<input type="button" value="返回" onclick="window.history.back();">
		</FORM>
	</body>
</html>


