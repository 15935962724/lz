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

int cityid = h.getInt("cityid");

CityList c=CityList.find(cityid);
StringBuffer sql=new StringBuffer(),par=new StringBuffer();
int fatherId = h.getInt("fatherId",0);
par.append("?fatherId="+fatherId);
String cityName_CN =h.get("cityNameCN","");
if(cityName_CN.length()>0)
{
	sql.append(" and cityName_CN LIKE ").append(DbAdapter.cite("%"+cityName_CN+"%"));
	par.append("&cityName_CN=").append(URLEncoder.encode(cityName_CN,"UTF-8"));
}
par.append("&cityid="+cityid);
sql.append(" and fatherId="+fatherId);
int pos=h.getInt("pos");
int size = 20;
sql.append(" and Len(cityid)=4");
int count=CityList.count(sql.toString());
par.append("&pos=");



%>

<html>
<head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript">
function f_submt()
{
	if(form1.cityName_CN.value=='')
	{
		alert("中文省份不能为空");
		form1.cityName_CN.focus();
		return false;
	}
	if(form1.cityName_EN.value=='')
	{
		alert("英文省份不能为空");
		form1.cityName_EN.focus();
		return false;
	}
	 var hotcity=0;
	 if(form1.hotcity.checked){
		hotcity=1;
	 }
	 var isOpen=0;
	 if(form1.isOpen.checked){
		 isOpen=1;
	 }
	  sendx("/jsp/admin/edn_ajax_city.jsp?act=EditCity&fatherId="+form1.fatherId.value+"&isOpen="+isOpen+"&type="+form1.type.value+"&cityid="+form1.cityid.value+"&cityName_CN="+encodeURIComponent(form1.cityName_CN.value)+"&cityName_EN="+encodeURIComponent(form1.cityName_EN.value)+"&hotcity="+hotcity,
				 function(data)
				 {
				   if(data!=''&&data.length>1)//如果有这个用户  则写入Cookie .trim()
				   {
						alert(data.trim());
						window.location.href=window.location.pathname+window.location.search;
				   }
				 }
				 );
}
function f_edit(igd)
{
		form1.cityid.value=igd;
		form1.submit();
}
function f_delete(cityid)
{

	  if(confirm('确认删除'))
		  {
	 sendx("/jsp/admin/edn_ajax_city.jsp?act=delCity&cityid="+cityid,
			 function(data)
			 {
			   if(data!=''&&data.length>1)//如果有这个用户  则写入Cookie .trim()
			   {
				   alert(data.trim());
					window.location.href=window.location.pathname+window.location.search;
			   }
			 }
			 );
		  }
}
function f_setup(cityid)
{
	mt.show('/jsp/provincecity/AreaList.jsp?fatherId='+cityid,2,'市区设置',600,560);
	//ymPrompt.win({message:'/jsp/provincecity/CityList.jsp?provinceid='+igd,width:600,height:560,title:'市区设置',handler:function(){},maxBtn:false,minBtn:false,iframe:true});
}


</script>
</head>
<body>
<h1>城市管理</h1>



<h2>列表&nbsp;(&nbsp;目前共有&nbsp;<font color="#000000" size="3"><%=count%></font>&nbsp;条记录&nbsp;)&nbsp;&nbsp;

</h2>

<form name="form1" action="?" method="GET">
<input type="hidden" name="type" value="2"/>
<input type="hidden" name="fatherId" value="<%=fatherId%>"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="cityid" value="<%=cityid%>">
<input type="hidden" name="id" value="<%=request.getParameter("id")%>">
<script>form1.nexturl.value=location.pathname+location.search;</script>
<table cellpadding="0" cellspacing="0" id="tablecenter">
<tr>
	<td colspan="4">
	中文名搜索:<input type="text" name="cityNameCN" value="<%=MT.f(cityName_CN) %>"><input type="submit" value="查询" >
	</td>
</tr>
</table>
<table cellpadding="0" cellspacing="0" id="tablecenter">
<tr>
	<td colspan="3">
	中文省份：<input type="text" name="cityName_CN" value="<%=MT.f(c.cityName_CN)%>">&nbsp;
	英文省份：<input type="text" name="cityName_EN" value="<%=MT.f(c.cityName_EN)%>">&nbsp;
	<input type="checkbox" name="hotcity" <%=c.hotcity==1?"checked":"" %> >列为热门城市&nbsp;
	<input type="checkbox" name="isOpen" <%=c.isOpen==1?"checked":"" %> >设为开放城市&nbsp;
	<%if(cityid>0){ %>
	<input type="button" value="修改"  onclick="f_submt();">
	<input type=button value="返回" onClick="location.href='/jsp/provincecity/ProvinceList.jsp'">
	<%}else{ %>
	<input type="button" value="添加"  onclick="f_submt();">
	<%} %>
	</td>
</tr>


<tr id="tableonetr">
<td>中文名称</td>
<td>英文名称</td>

<td>操作</td>
</tr>
<%

ArrayList list = CityList.find(sql.toString(), pos, size);
System.out.print("-------------"+sql.toString());
if(count==0)
{
	out.print("<tr><td colspan='6' align='center'>暂无任何记录!</td></tr>");
}else{

  for(int i=0;i<list.size();i++)
  {

	CityList cl=(CityList)list.get(i);

 %>

    <tr onMouseOver=bgColor='#BCD1E9' onMouseOut=bgColor=''>


     <td><%=cl.cityName_CN%></td>
     <td><%=cl.cityName_EN %></td>

    <td>
		<input type='button' value='设置三级类'  onclick="f_setup('<%=cl.cityid%>');">&nbsp;
	    <input type='button' value='编辑'  onclick="f_edit('<%=cl.cityid%>');">&nbsp;
	    <input type='button' value='删除'  onclick="f_delete('<%=cl.cityid%>');">&nbsp;
    </td>




   <%
  }
  if(count>size)out.print("<tr><td colspan='3' >"+new tea.htmlx.FPNL(h.language, request.getRequestURI()+par.toString(), pos, count,size));
}
%>
</table>
<br/>


</form>


</body>
</html>
