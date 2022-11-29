<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="tea.entity.Http" %>
<%@ page import="tea.resource.Resource" %>
<%@ page import="tea.entity.MT" %>
<%@page import="tea.db.DbAdapter"%>
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
	int menuid=h.getInt("id");
	
	String nexturl = request.getRequestURI()+"?community="+h.community+"&id="+menuid;
	
	int pfcid = h.getInt("pfcid");
	PoFamousComment pfc = PoFamousComment.find(pfcid);
	
	//Resource res=new Resource().add("/tea/resource/Consultant");

	StringBuffer sql=new StringBuffer(),par=new StringBuffer();

	par.append("?id="+menuid);
	
	sql.append(" AND member=" + h.member);
	par.append("&member=" + h.member);
	
	String title=h.get("title","");
	if(title.length()>0)
	{
	  sql.append(" AND title LIKE "+DbAdapter.cite("%"+title+"%"));
	  par.append("&title="+h.enc(title));
	}
	
	int pos=h.getInt("pos");
	par.append("&pos=");
	
	int sum=PoFamousComment.count(sql.toString());
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
<input type="hidden" name="id" value="<%=menuid%>"/>
<input type="hidden" name="pfcid" value="<%=pfcid %>"/>
<input type="hidden" name="act" value="edit"/>
<input type="hidden" name="member">
<input type="hidden" name="nexturl" value="<%=nexturl%>">
<table cellSpacing="0" cellPadding="0" border="0" id="tablecenter" style="width:100%">

	<tr >
		<td class="th">标题:</td>
		<td class="td01"><input name="title" type="text" value="<%=MT.f(pfc.getTitle()) %>" size="50" alt="标题"></td>
	</tr>
	<tr>
	    <td class="th">内容:</td>
	    <td align="left"><input  id="CHECKBOX" type="checkbox" name="nonuse" value="checkbox" onClick="f_editor(this)"><label for="nonuse" style="padding-left:5px;">不使用多媒体编辑器</label></td>
	</tr>
	<tr>
    	<td>&nbsp;</td>
	    <td align="left">
		    <%-- <textarea name="content" cols="50" rows="5" alt="内容"><%=MT.f(t.getContent())%></textarea><span id="info">还能输入</span><b id="count">500</b>字 --%>
		    <textarea name="content" rows="12" cols="90"><%=MT.f(pfc.getContent())%></textarea>
		    <script>if(mt.isIE6)document.write("<iframe id='editor' src='/jsp/include/FCKeditor/editor/fckeditor.html?InstanceName=content&Toolbar=<%=h.community%>' width='700' height='300' frameborder='no' scrolling='no'></iframe>");f_editor();</script>
	    </td>
	</tr>
	
</table>
<div align="center" style="width:100%;height:43px;margin-top:45px;padding-bottom:76px;border-bottom:1px #ddd dashed;"><input type="submit" value="<%out.print(pfc.getId()>0?"编辑":"提交"); %>" style="font-size:16px;height:43px;width:276px;color:#fff;font-weight:bold;background: url(/res/Home/structure/bg11.gif) center no-repeat;border:none;cursor:pointer;"/></div>
</form>

<div class="sqjl">银评记录</div>

<form name="formSearch" action="?" >
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="id" value="<%=menuid%>"/>
<input type="hidden" name="act"/>
<input type="hidden" name="pfcid"/>
<table cellSpacing="0" cellPadding="0" border="0" id="tablecenter" style="background:#eee;height:35px;width:100%;">
    <tr >
		<td class="th" style="font-size:12px !important;">标题:</td>
		<td><input type="text" name="title" value="<%=MT.f(title)%>" style="height:25px;width:296px;border-left: 1px #999 solid;border-top: 1px #999 solid;border-bottom: 1px #e5e5e5 solid;border-right: 1px #e5e5e5 solid;background: #f9f9f9;">　<input type="submit" value="搜索" style="background:#418ED6;height:25px;padding:0px 7px;border:none;color:#fff;cursor:pointer;"/></td>
	</tr>
</table>
</form>

<form name="form2" action="/EditFamousComment.do" target="_ajax" method="post">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<div class="sqjl_list">
<table border=0 cellpadding="0" cellspacing="0" id="tablecenter">
  <tr id="tableonetr">
    <td>标题</td>
<!--    <td>内容</td>
-->    <td>发布时间</td>
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
    %>
    <tr>
      <td><%=MT.f(obj.getTitle())%></td>
<!--      <td><%=MT.f(Lucene.t(obj.getContent()),100)%></td>
-->      <td><%=MT.f(obj.getApplyTime(),1)%></td>
      <td>
      	 <a href="javascript:mt.act('edit',<%=obj.getId()%>)">编辑</a>
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