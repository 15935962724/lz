<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="tea.entity.Http" %>
<%@ page import="tea.entity.pm.Transactions" %>
<%@ page import="java.util.Enumeration" %>
<%@ page import="tea.entity.member.Profile" %>
<%@ page import="tea.entity.Entity" %>
<%@ page import="tea.db.DbAdapter" %>
<%@ page import="tea.entity.MT" %>
<%@ page import="tea.entity.pm.PoFamousComment" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="tea.entity.util.Lucene" %>
<%
	Http h=new Http(request);
	String act=h.get("act");
	if("top_right01".equals(act)){
		Enumeration e=Transactions.find(" AND hidden=0 AND community="+DbAdapter.cite(h.community)+"  ORDER BY ctime desc", 0, 6);
		while(e.hasMoreElements()){
			int tid=(Integer)e.nextElement();
			Transactions t=Transactions.find(tid);
			Profile p=Profile.find(t.getMember());
			
			%>
				
				<div class="right01">
					<div class="cont01"><a href="/html/folder/14091315-1.htm?tmember=<%=MT.enc(p.getProfile())%>"><%=p.getName(h.language) %></a></div>
					<div class="cont02"><%=Entity.sdf2.format(t.getTtime()) %></div>
					<div class="cont03">操作方向<br><%=MT.f(t.getDirection()) %></div>
					<div class="cont04"><a href="/html/folder/14091315-1.htm?tmember=<%=MT.enc(p.getProfile())%>">关注</a></div>
				</div>
			
		<%}
	}else if("pingl_list01".equals(act)){
		Enumeration e=Transactions.find(" AND hidden=0 AND community="+DbAdapter.cite(h.community)+"  ORDER BY ctime desc", 0, 4);
		out.print("<ul>");
		while(e.hasMoreElements()){
			int tid=(Integer)e.nextElement();
			Transactions t=Transactions.find(tid);
			Profile p=Profile.find(t.getMember());
			String picture="";
			if(p.getPhotopath(h.language)!=null&&p.getPhotopath(h.language).length()>0){
				picture=p.getPhotopath(h.language);
			}
			%>
			
			<li>
				<span id="span1"><img src="<%=picture%>"></span>
				<span id="span2"><em><a href="/html/folder/14091315-1.htm?tmember=<%=MT.enc(p.getProfile())%>"><%=MT.f(p.getName(h.language)) %></a></em><%=MT.f(p.getJob(h.language)) %>（<%=MT.f(p.getTitle(h.language)) %>）</span>
				<span id="span3"><%=MT.f(t.getContent(),80) %></span>
				<span id="span4">交易品种：<%=MT.f(t.getVarieties()) %></span>
				<span id="span5">交易方向：<%=MT.f(t.getDirection()) %></span>
			</li>
			
		<%}
		out.print("</ul>");	
	}else if("top_new01".equals(act)){
		Enumeration e=Transactions.find(" AND hidden=0 AND community="+DbAdapter.cite(h.community)+"  ORDER BY ctime desc", 0, 1);
		out.print("<ul>");
		while(e.hasMoreElements()){
			int tid=(Integer)e.nextElement();
			Transactions t=Transactions.find(tid);
			Profile p=Profile.find(t.getMember());
			String picture="";
			if(p.getPhotopath(h.language)!=null&&p.getPhotopath(h.language).length()>0){
				picture=p.getPhotopath(h.language);
			}
			%>
				<div class="cont01"><img src="<%=picture%>"></div>
				<div class="cont02"><em><a href="/html/folder/14091315-1.htm?tmember=<%=MT.enc(p.getProfile())%>"><%=MT.f(p.getName(h.language)) %></a></em><%=MT.f(p.getJob(h.language)) %></div>
				<div class="cont02" style="top:34px;">交易品种：<%=MT.f(t.getVarieties()) %></div>
				<div class="cont02" style="top:54px;">交易方向：<%=MT.f(t.getDirection()) %></div>
				<div class="cont03"><%=MT.f(t.getContent(),70) %></div>
			
		<%}
		out.print("</ul>");	
	}else if("mobiletop_right01".equals(act)){
		Enumeration e=Transactions.find(" AND hidden=0 AND community="+DbAdapter.cite(h.community)+"  ORDER BY ctime desc", 0, 2);
		while(e.hasMoreElements()){
			int tid=(Integer)e.nextElement();
			Transactions t=Transactions.find(tid);
			Profile p=Profile.find(t.getMember());%>
				
				<div class="right01">
					<div class="cont01"><a href="#"><%=p.getName(h.language) %></a></div>
					<div class="cont02"><%=Entity.sdf2.format(t.getTtime()) %></div>
					<div class="cont03">操作方向<br><%=MT.f(t.getDirection()) %></div>
					<div class="cont04"><a href="#">关注</a></div>
				</div>
			
		<%}
	}else if("leftl_list01".equals(act)){
		Enumeration e=Transactions.find(" AND hidden=0 AND community="+DbAdapter.cite(h.community)+"  ORDER BY ctime desc", 0, 2);
		out.print("<ul>");
		while(e.hasMoreElements()){
			int tid=(Integer)e.nextElement();
			Transactions t=Transactions.find(tid);
			Profile p=Profile.find(t.getMember());
			String picture="";
			if(p.getPhotopath(h.language)!=null&&p.getPhotopath(h.language).length()>0){
				picture=p.getPhotopath(h.language);
			}
			%>
			
			<li>
				<span id="pic"><img src="<%=picture%>" /></span>
				<span id="name"><a href="/html/folder/14091315-1.htm?tmember=<%=MT.enc(p.getProfile())%>"><%=MT.f(p.getName(h.language)) %></a></span>
				<span id="zc"><%=MT.f(p.getJob(h.language)) %>（<%=MT.f(p.getTitle(h.language)) %>）</span>
				<span id="jj"><%=MT.f(t.getContent(),80) %></span>
			</li>
			
		<%}
		out.print("</ul>");	
	}else if("yptop_new01".equals(act)){
		ArrayList<PoFamousComment> al = PoFamousComment.find(" AND community="+DbAdapter.cite(h.community)+"  ORDER BY applyTime desc",0,5);
	    for(int i=0;i<al.size();i++){
		  PoFamousComment obj = al.get(i);
		  Profile p=Profile.find(obj.getMember());
		  String name1=MT.f(p.getName(h.language))+":";
		  int len=name1.length();
		  out.print("<li><a href=\"/html/folder/14101875-1.htm?pfcid="+obj.getId()+"\" target=\"_blank\">"+name1+MT.f(obj.getTitle(),50-len)+"</a></li>");
		}
	}
%>

	