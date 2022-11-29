<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="tea.entity.Http" %>
<%@ page import="tea.resource.Resource" %>
<%@page import="tea.db.DbAdapter"%>
<%@ page import="tea.entity.MT" %>
<%@page import="tea.entity.util.Lucene"%>
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
	StringBuffer sql=new StringBuffer(),par=new StringBuffer();

	int menuid=h.getInt("id");
	par.append("?id="+menuid);
	
	String name=h.get("name","");
	if(name.length()>0)
	{
	  sql.append(" AND pfl.firstname LIKE "+DbAdapter.cite("%"+name+"%"));
	  par.append("&name="+h.enc(name));
	}
	
	String title=h.get("title","");
	if(title.length()>0)
	{
	  sql.append(" AND fc.title LIKE "+DbAdapter.cite("%"+title+"%"));
	  par.append("&title="+h.enc(title));
	}
	
	String content=h.get("content","");
	if(content.length()>0)
	{
	  sql.append(" AND fc.content LIKE "+DbAdapter.cite("%"+content+"%"));
	  par.append("&content="+h.enc(content));
	}
	
	int pos=h.getInt("pos");
	par.append("&pos=");
	
	int sum=PoFamousComment.count(sql.toString());
	
%>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/tea/ckeditor/ckeditor.js"></script>

<style>
#tablecenter td table td{border:0}
</style>
</head>
<body>
<h1>名家银评</h1>
<div id="head6"><img height="6" src="about:blank"></div><!-- onSubmit="if(mt.check(this)){mt.show(null,0);mt.usubmit(this);}return false;" -->
<h2>查询</h2>
<form name="form1" action="?" >

<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="id" value="<%=menuid%>"/>
<input type="hidden" name="act"/>
<input type="hidden" name="pfcid"/>
<table cellSpacing="0" cellPadding="0" border="0" id="tablecenter">

    <tr >
		<td class="th">姓名:</td>
		<td><input type="text" name="name" value="<%=name%>"></td>
		<td class="th">标题:</td>
		<td><input type="text" name="title" value="<%=MT.f(title)%>"></td>
		<td class="th">内容:</td>
		<td><input type="text" name="content" value="<%=MT.f(content)%>">　<input type="submit" value="查询"/></td>
	</tr>
	
</table>
</form>

<h2>银评记录</h2>
<form name="form2" action="/EditFamousComment.do" target="_ajax" method="post">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<input type="hidden" name="pfcid"/>
<div class="sqjl_list">
<table border=0 cellpadding="0" cellspacing="0" id="tablecenter">
  <tr id="tableonetr">
  	<td>名家</td>
    <td>标题</td>
    <td>内容</td>
    <td>发布时间</td>
    <td>操作</td>
  </tr>
<%
if(sum<1){
  out.print("<tr><td colspan='10' align='center'>暂无记录！</td></tr>");
}else{
  sql.append(" order by applyTime desc");
  ArrayList<PoFamousComment> al = PoFamousComment.find(sql.toString(),pos,20);
  for(int i=0;i<al.size();i++){
	  PoFamousComment obj = al.get(i);
	  Profile p=Profile.find(obj.getMember());
    %>
    <tr>
      <td><%=MT.f(p.getName(h.language))%></td>
      <td><%=MT.f(obj.getTitle())%></td>
      <td><%=MT.f(Lucene.t(obj.getContent()),100)%></td>
      <td><%=MT.f(obj.getApplyTime(),1)%></td>
      <td>
      	 <a href="javascript:mt.act('view',<%=obj.getId()%>)">查看</a>
      	 <a href="javascript:mt.act('del',<%=obj.getId()%>)">删除</a>
      </td>
    </tr>
    <%
  }
  if(sum>20)out.print("<tr><td colspan='10' class='tdpage'>共"+sum+"条！"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,20));
}
%>
</table>
</div>
</form>

<script type="text/javascript">
//form1.nexturl.value=location.pathname+location.search;
mt.act=function(a,t,b){
  	form2.act.value = a;
  	form2.pfcid.value = t;
  	if(a=='view'){
  		form2.action='/jsp/type/Consultant/ViewFamousComment.jsp';
    	form2.target=form2.method='';
    	form2.submit();
  	}else if(a == 'del'){
  		form2.target="_ajax";
  		form2.method="post";
  		mt.show("确认删除？",2,"form2.submit()");
	}
};
</script>
</body>
</html>