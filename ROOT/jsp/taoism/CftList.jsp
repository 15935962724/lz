<%@page import="tea.entity.taoism.Cft"%>
<%@page import="net.sourceforge.jtds.jdbc.cache.SQLCacheKey"%>
<%@page import="tea.entity.city.CityList"%>
<%@page import="java.net.URLEncoder"%>
<%@page contentType="text/html;charset=UTF-8"  %>
<%@page import="java.util.*" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.*" %>
<%@page import="tea.ui.*" %>
<%@page import="tea.db.*" %>
<%@page import="tea.entity.*" %>
<%@page import="tea.entity.node.*" %>

<%
request.setCharacterEncoding("UTF-8");
Http h=new Http(request);


if(h.member<1)
{
	out.println("您没有权限查看");
	return;
}

StringBuffer sql=new StringBuffer(),par=new StringBuffer();
int pos=h.getInt("pos");
int tid = h.getInt("CftId");
sql.append(" and CftId="+tid);
int size = 10;

par.append("&pos=");
if("POST".equals(request.getMethod())){
	String act =h.get("act");
	if("edit_s".equals(act)){
		int id=h.getInt("sid",0);
		Cft stn=null;
		if(id==0){
			id=Seq.get();
		}
		stn=new Cft(id);
		String pic=h.get("pic");
		stn.pic=pic;
		stn.CftId=tid;
		stn.Cftname=h.get("Cftname");
		stn.set();
	}else if("del_s".equals(act)){
		int id=h.getInt("sid",0);
		if(id>0)
			Cft.find(id).delete();
	}

}
int sid = h.getInt("sid");
Cft s=Cft.find(sid);
int count=Cft.count(sql.toString());
sql.append(" order by ctime desc");

%>

<html>
<head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

</head>
<body>
<h1>证书管理</h1>



<h2>列表&nbsp;(&nbsp;目前共有&nbsp;<font color="#000000" size="3"><%=count%></font>&nbsp;条记录&nbsp;)&nbsp;&nbsp;

</h2>

<form name="form1" action="?" method="post" enctype="multipart/form-data">
<input type="hidden" name="CftId" value="<%=tid%>"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<input type="hidden" name="sid" value="<%=sid%>">
<script>form1.nexturl.value=location.pathname+location.search;</script>
<table cellpadding="0" cellspacing="0" id="tablecenter">
<%-- <tr>
	<td align="right">
	皈依证颁发时间：

	</td>
	<td colspan="2">
	<input type="text" name="ctime" value="<%=MT.f(s.ctime)%>" onClick="mt.date(this)" readonly class="date">&nbsp;

	</td>
</tr> --%>
<tr>
	<td colspan="3">
	证书名称：

	<input type="text" size="60" name="Cftname" value="<%=MT.f(s.Cftname)%>">&nbsp;

	</td>

</tr>
<tr>
<td colspan="3">

	证书图片：
	<input type="file" size="60" name="pic" value="<%=MT.f(s.pic)%>">&nbsp;
	<%if(sid>0){ %>
	<input type="button" value="修改" onClick="mt.act('edit_s',<%=sid%>)">
	<input type=button value="返回" onClick="location.href='/jsp/taoism/CftList.jsp?CftId=<%=tid%>'">
	<%}else{ %>
	<input type="button" value="添加" onClick="mt.act('edit_s',0)">
	<%} %>

	</td>
</tr>

<tr id="tableonetr">
<!-- <td width="15%">皈依证颁发时间</td> -->
<td width="40%">证书名称</td>
<td width="30%">证书图片</td>
<td width="30%">操作</td>
</tr>
<%

ArrayList list = Cft.find(sql.toString(), pos, size);
System.out.print("-------------"+sql.toString());
if(count==0)
{
	out.print("<tr><td colspan='6' align='center'>暂无任何记录!</td></tr>");
}else{

  for(int i=0;i<list.size();i++)
  {

	  Cft st=(Cft)list.get(i);

 %>

    <tr onMouseOver=bgColor='#BCD1E9' onMouseOut=bgColor=''>


     <td><%=st.Cftname%></td>
     <td><a href="<%=MT.f(st.pic) %>" target="_blank"><img height="50px" src="<%=MT.f(st.pic) %>"></a></td>

    <td>
	    <input type='button' value='编辑'  onclick="mt.act('edit','<%=st.id%>');">&nbsp;
	    <input type='button' value='删除'  onclick="mt.act('del_s','<%=st.id%>');">&nbsp;
    </td>




   <%
  }
  if(count>size)out.print("<tr><td colspan='3' >"+new tea.htmlx.FPNL(h.language, request.getRequestURI()+par.toString(), pos, count,size));
}
%>
</table>
<br/>


</form>
<script>
mt.act=function(a,id){
	form1.act.value=a;
	form1.sid.value=id;
	if(a=="edit"){
		form1.target="";
	}
	form1.submit();
}
</script>

</body>
</html>
