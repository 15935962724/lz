<%@page import="java.net.URLEncoder"%>
<%@page import="tea.entity.util.Lucene"%>
<%@page import="tea.entity.pm.PoFamousComment"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="tea.entity.Http" %>
<%@ page import="tea.resource.Resource" %>
<%@page import="tea.db.DbAdapter"%>
<%@ page import="tea.entity.MT" %>
<%@ page import="tea.entity.member.Profile" %>
<%@page import="tea.entity.pm.PoFamousComment"%>
<%@page import="java.util.ArrayList"%>
<%@page import="tea.entity.Attch"%>
<%
	Http h=new Http(request); 
	/* if(h.member<1)
	{
	  response.sendRedirect("/servlet/StartLogin?community="+h.community);
	  return;
	} */
	/*
	if(h.isIllegal())
	{
	  response.sendError(404,request.getRequestURI());
	  return;
	}
	*/
	StringBuffer sql=new StringBuffer(),par=new StringBuffer();
	
	sql.append(" AND community="+DbAdapter.cite(h.community));
	par.append("?community="+h.community);
	
	int pos=h.getInt("pos");
	par.append("&pos=");
	
	int sum=PoFamousComment.count(sql.toString());
	
%>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/tea/ckeditor/ckeditor.js"></script>
<script>
var ls=parent.document.getElementsByTagName("HEAD")[0];
document.write(ls.innerHTML);
var arr=parent.document.getElementsByTagName("LINK");
for(var i=0;i<arr.length;i++)
{
  document.write("<link href='"+arr[i].href+"' rel='"+arr[i].rel+"' type='text/css'>");
}
</script>
<script>mt.fit();</script>
<style>
#tablecenter td table td{border:0}
</style>
</head>
<body style="border:none;">

<div id="head6"><img height="6" src="about:blank"></div>

<div class="sqjl"></div>
<form name="form2" action="?">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<input type="hidden" name="pfcid"/>
<div class="sqjl_list">
<table border=0 cellpadding="0" cellspacing="0" id="tablecenter">
<%
if(sum<1){
  out.print("<tr><td colspan='10' align='center'>暂无记录！</td></tr>");
}else{
  sql.append(" order by applyTime desc");
  ArrayList<PoFamousComment> al = PoFamousComment.find(sql.toString(),pos,10);
  for(int i=0;i<al.size();i++){
	  PoFamousComment obj = al.get(i);
	  Profile p=Profile.find(obj.getMember());
	  String picture="";
	  if(p.getPhotopath(h.language)!=null&&p.getPhotopath(h.language).length()>0){
		  picture=p.getPhotopath(h.language);
	  }
	  String name = (MT.f(p.getName(h.language))!=null&&MT.f(p.getName(h.language)).length()>0?MT.f(p.getName(h.language)+"："):"");
	  String titlex = MT.f(obj.getTitle());
    %>
    <tr>
    	<td colspan="5" style="height:14px;"></td>
    </tr>
    <tr>
		<td rowspan="3" class="pic"><img src="<%=picture %>" /></td><%-- mt.act('view',<%=obj.getId() %>) --%><%-- parent.window.location.href='/html/folder/14101875-1.htm?pfcid=<%=obj.getId()%>&nodex=<%=obj.getId()%>&titlex=<%=URLEncoder.encode(URLEncoder.encode(titlex))%>'; --%>
		<td class="name"><a href="###" onClick="parent.window.location.href='/html/folder/14101875-1.htm?pfcid=<%=obj.getId()%>';" style="color:#3F8CD6;"><%out.print(name+titlex); %></a></td>
	</tr>
	<tr>
		<td colspan="2" class="jj" valign="top" style="padding-top:8px !important;padding-bottom: 5px !important;">
			<%=MT.f(Lucene.t(obj.getContent()),280)%>
		</td>
	</tr>
    <tr>
      <td colspan="4" class="time" style="text-align:left;color:#919191;">发布时间：<%=MT.f(obj.getApplyTime(),1)%></td>
    </tr>
    <tr>
    	<td colspan="5" style="border-bottom:1px #ddd solid;height:13px;"></td>
    </tr>
    <%
  }
  if(sum>10)out.print("<tr><td colspan='10' class='tdpage'>共"+sum+"条！"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,10));
}
%>
</table>
</div>
</form>

<script type="text/javascript">
form2.nexturl.value=location.pathname+location.search;
mt.act=function(a,t,b){
  	form2.act.value = a;
  	form2.pfcid.value = t;
    if(a=='view'){
         form2.action='/jsp/type/Consultant/ViewFamousCommentWeb.jsp?pfcid='+t+'&nexturl='+form2.nexturl.value;
         form2.target=form2.method='';
         form2.submit();
    }  	
};
</script>
</body>
</html>