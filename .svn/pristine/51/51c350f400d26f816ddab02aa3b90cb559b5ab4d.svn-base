<%@page import="tea.entity.pm.PoFamousComment"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="tea.entity.Http" %>
<%@ page import="tea.resource.Resource" %>
<%@ page import="tea.entity.MT" %>
<%@ page import="tea.entity.member.Profile" %>
<%@page import="tea.entity.pm.PoFamousComment"%>
<%@page import="java.util.ArrayList"%>
<%@page import="tea.entity.Attch"%>
<%
	Http h=new Http(request); 
	if(h.member<1)
	{
	  response.sendRedirect("/servlet/StartLogin?community="+h.community);
	  return;
	}
	/*
	if(h.isIllegal())
	{
	  response.sendError(404,request.getRequestURI());
	  return;
	}
	*/
	String nexturl = h.get("nexturl");
	
	int pfcid = h.getInt("pfcid");
	PoFamousComment pfc = PoFamousComment.find(pfcid);
	Profile p=Profile.find(pfc.getMember());
	
	//Resource res=new Resource().add("/tea/resource/Consultant");

%>

<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/tea/ckeditor/ckeditor.js"></script>

<style>
#tablecenter td table td{border:0}
</style>


<div id="head6"><img height="6" src="about:blank"></div><!-- onSubmit="if(mt.check(this)){mt.show(null,0);mt.usubmit(this);}return false;" -->
<form name="form1" method="post" action="/EditFamousComment.do" target="_ajax" onSubmit="return mt.check(this);">

<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="pfcid" value="<%=pfcid %>"/>
<input type="hidden" name="act" value="edit"/>
<input type="hidden" name="member">
<input type="hidden" name="nexturl" value="<%=nexturl%>">
<table cellSpacing="0" cellPadding="0" border="0" id="tablecenter">

	<tr >
		<td align="center"><%out.print(MT.f(p.getName(h.language))!=null&&MT.f(p.getName(h.language)).length()>0?MT.f(p.getName(h.language)+"："):""); %><%=MT.f(pfc.getTitle()) %></td>
	</tr>
	<tr >
		<td align="left"><span><%out.print(MT.f(p.getName(h.language))!=null&&MT.f(p.getName(h.language)).length()>0?"名家"+"："+MT.f(p.getName(h.language)):""); %></span>&nbsp;&nbsp;<span>发布时间：<%=MT.f(pfc.getApplyTime()) %></span></td>
	</tr>
	<tr>
	    <td align="center"><%=pfc.getContent().replaceAll("\r\n","")%></td>
	</tr>
	<tr>
	    <td align="center"><input type="button" value="返回" onClick="window.history.back();"/></td>
	</tr>
</table>
</form>


<script type="text/javascript">
//form1.nexturl.value=location.pathname+location.search;
mt.act=function(a,t,b){
  	form1.act.value = a;
  	form1.pfcid.value = t;
  	if(a=='edit'){
  		form1.action="?";
    	form1.target=form1.method='';
    	form1.submit();
  	}else if(a == 'del'){
  		mt.show("确认删除？资料也会被删除。",2,"form1.submit()");
	}
};
</script>
</body>
</html>