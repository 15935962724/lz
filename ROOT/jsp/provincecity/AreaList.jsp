<%@page import="tea.entity.city.CityList"%>
<%@page import="tea.entity.provincecity.*"%>
<%@page import="tea.entity.provincecity.Elongcity"%>
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

String cityName_CN =h.get("cityNameCN","");
if(cityName_CN.length()>0)
{
	sql.append(" and cityName_CN LIKE ").append(DbAdapter.cite("%"+cityName_CN+"%"));
	par.append("&cityName_CN=").append(URLEncoder.encode(cityName_CN,"UTF-8"));
}
int fatherId = h.getInt("fatherId",0);
par.append("?fatherId="+fatherId);
par.append("&cityid="+cityid);
int tab=h.getInt("tab");
par.append("&tab="+tab);
String[] TAB={"县或市区","商圈","地标"};
String[] SQL={" AND areaType=0"," AND areaType=1"," AND areaType=2"};
sql.append(" and fatherId="+fatherId);
int pos=h.getInt("pos");
int size = 20;
sql.append(" and Len(cityid)>=6");
par.append("&pos=");


%>

<html>
<head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
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
	var areaobj=document.getElementsByName("areaType");
	var areaType=0;
	for(var i=0;i<areaobj.length;i++){
        if(areaobj[i].checked){
        	areaType=areaobj[i].value;
        }
	}
	 
	  sendx("/jsp/admin/edn_ajax_city.jsp?act=EditCity&fatherId="+form1.fatherId.value+"&type="+form1.type.value+"&cityid="+form1.cityid.value+"&cityName_CN="+encodeURIComponent(form1.cityName_CN.value)+"&cityName_EN="+encodeURIComponent(form1.cityName_EN.value)+"&areaType="+areaType,
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
	mt.show('/jsp/provincecity/CityList.jsp?fatherId='+cityid,2,'市区设置',600,560);
	//ymPrompt.win({message:'/jsp/provincecity/CityList.jsp?provinceid='+igd,width:600,height:560,title:'市区设置',handler:function(){},maxBtn:false,minBtn:false,iframe:true});
}
</script>
</head> 
<body>

<%-- <h2>列表&nbsp;(&nbsp;目前共有&nbsp;<font color="#000000" size="3"><%=count%></font>&nbsp;条记录&nbsp;)&nbsp;&nbsp;

</h2> --%>
<h1>城市管理</h1>
<form name="form1" action="?" method="post">
<input type="hidden" name="type" value="3">
 <input type="hidden" name="cityid" value="<%=cityid%>">
 <input type="hidden" name="fatherId" value="<%=fatherId %>">
<input type="hidden" name="id" value="<%=request.getParameter("id")%>">
<input type="hidden" name="tab" value="<%=tab%>"/>

<table cellpadding="0" cellspacing="0" id="tablecenter">
<tr>
	<td colspan="4">
	中文名搜索:<input type="text" name="cityNameCN" value="<%=MT.f(cityName_CN) %>"><input type="submit" value="查询" >
	</td>
</tr> 
</table>

<table cellpadding="0" cellspacing="0" id="tablecenter">
<tr>
	<td colspan="4">

	中文名称：<input type="text" name="cityName_CN" value="<%=MT.f(c.cityName_CN)%>" size="10">&nbsp;
	英文名称：<input type="text" name="cityName_EN" value="<%=MT.f(c.cityName_EN)%>" size="10">&nbsp;
	</td>
	<tr>
	<td>
	类别：
	<%                                                                                                                                                                                                                                                                                                                                                
	for(int i=0;i<CityList.AREATYPE.length;i++){
		out.print("<input type='radio' name='areaType' value="+i+" "+(i==c.areaType?"checked":"")+">"+CityList.AREATYPE[i]);
	}
	%>
	
	<%if(cityid>0){ %>
	<input type="button" value="修改"  onclick="f_submt();">
	<input type=button value="返回" onClick="window.open('/jsp/provincecity/ElonglocationList.jsp?cityid='+form1.cityid.value+'&t='+Math.floor(Math.random()*10000000000+1),'_self');">
	<%}else{ %>
	<input type="button" value="添加"  onclick="f_submt();"> 
	<input type=button value="返回" onClick="f_setup();",'_self');">
	<%} %>
	</td>
</tr>
</table>
<%
out.print("<div class='switch'>");
for(int i=0;i<TAB.length;i++)
{ 
  out.print("<a href='javascript:mt.tab("+i+")' class='"+(i==tab?"current":"")+"'>"+TAB[i]+"（"+CityList.count(sql.toString()+SQL[i])+"）</a>");
}
out.print("</div>");
%>
<table cellpadding="0" cellspacing="0" id="tablecenter">

<tr id="tableonetr">
<td>中文名称</td>
<td>英文名称</td>
<td>类型</td>


<td>操作</td>
</tr>
<%
sql.append(SQL[tab]);
int count=CityList.count(sql.toString());
ArrayList list = CityList.find(sql.toString(), pos, size);
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
     <td><%=CityList.AREATYPE[cl.areaType]%></td>

    <td>
		
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

<input type="button" value="返回" onClick="location.href='/jsp/provincecity/CityList.jsp?fatherId=<%=String.valueOf(fatherId).substring(0,2)%>'">
</form>


</body>
</html>