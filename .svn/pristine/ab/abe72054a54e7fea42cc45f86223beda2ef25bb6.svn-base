<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@page import="tea.entity.*" %>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.resource.Resource" %>
<%@page import="java.util.Enumeration" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.entity.member.*" %>
<%@page import="tea.ui.*" %>
<%
	TeaSession teasession=new TeaSession(request);
	AccessMember am =AccessMember.find(teasession._nNode, teasession._rv);
	if(am.getPurview()==0 || am.getPurview()==4)
	{
		TeaServlet.outLogin(request,response,teasession);
		return;
	}
	Resource r=new Resource();
	Node n=Node.find(teasession._nNode);
	String subject=n.getSubject(teasession._nLanguage);
	WeatherIndex windex=WeatherIndex.find(teasession._nNode);
	String nurl="";
	if(teasession.getParameter("nexturl")!=null){
		nurl=teasession.getParameter("nexturl");
	}
%>

<html>
	<head>
	<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
	
	</head>
	<body>
	<form action="/WeatherIndexs" name="mform">
		<input type="hidden" name="act" value="edit">
		<input type="hidden" name="nexturl" value="<%=nurl%>">
		<input type="hidden" name="node" value="<%=teasession._nNode%>">
		<table id="tablecenter">
			<tr>
				<td>指数名称：</td>
				<td><input type="text" value="<%=subject %>" name="subject"/></td>
			</tr>
			<%
				for(int i=0;i<WeatherIndex.WI.length;i++){
					String wii=WeatherIndex.WI[i];
					out.print("<tr>	<td>"+r.getString(teasession._nLanguage,wii)+"</td>");
					if(WindexValue.countIndex(wii)==0){
						String  indexName="";
						String content="";
						if(windex.getValue(wii)!=null){
							WindexValue 	wv=new WindexValue(wii, Integer.parseInt(windex.getValue(wii)));
							if(wv.isExist()){
							indexName=wv.getIndexName();
							content=wv.getContent();
							}
						}
						
						out.print("<td>等级：<input type='hidden' value='"+windex.getValue(wii)+"/"+windex.isExist()+"'><input type='text' value='"+indexName+"' name='"+wii+"_indexName'/>详细：<input type='text' value='"+content+"' name='"+wii+"_content'/></td>");
					}else{
						out.print("<td><select name='"+wii+"' >");
						Enumeration e=WindexValue.findWindexValue(" and nindex="+DbAdapter.cite(wii)+" order by `index`",0,Integer.MAX_VALUE);
						String tom=windex.getValue(wii);
						while(e.hasMoreElements()){
							String mt=(String)e.nextElement();
							String[] mts=mt.split("_");
							WindexValue wv=WindexValue.find(mts[0], Integer.parseInt(mts[1]));
							out.print("<option value='"+wv.getIndex()+"'");
							if(windex.isExist()&&tom!=null&&tom.equals(wv.getIndex()+"")){
								out.print(" selected ");
							}
							out.print(">"+wv.getIndexName()+"</option>");
						}
						out.print("</select></td>");
					}
					out.print("</tr>");
				}
			%>
			<tr>
			<td colspan="2"><input type="submit" value="提交"/></td>
			</tr>
		</table>
	</form>
		
	</body>
</html>