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
TeaSession teasession=new TeaSession(request);
Http h=new Http(request);


if(teasession._rv==null)
{
	out.println("您没有权限查看");
	return;
}

String cityid = teasession.getParameter("cityid");

String provinceid =teasession.getParameter("provinceid");


String elid = Entity.getNULL(teasession.getParameter("elid"));
Elonglocation eobj = Elonglocation.find(elid,cityid);

StringBuffer sql=new StringBuffer(),par=new StringBuffer();

sql.append(" and cityid = ").append(DbAdapter.cite(cityid));

 
par.append("?community=").append(h.community);

par.append("&cityid=").append(cityid);

String elongnamecn =teasession.getParameter("elongnamecn");
if(elongnamecn!=null && elongnamecn.length()>0)
{
	elongnamecn = elongnamecn.trim();
	sql.append(" and Name_CN LIKE ").append(DbAdapter.cite("%"+elongnamecn+"%"));
	par.append("&elongnamecn=").append(URLEncoder.encode(elongnamecn,"UTF-8"));
}

String tmp=request.getParameter("pos");
int pos=tmp!=null?Integer.parseInt(tmp):0;
int size = 10;

int count=Elonglocation.count(sql.toString());

par.append("&pos=");


%>

<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/ym/ymPrompt.js" type=""></SCRIPT>
<link href="/tea/ym/skin/dmm-green/ymPrompt.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript">

function f_submt()
{
	
	if(form1.Name_CN.value=='')
	{
		alert("中文名称不能为空");
		
		form1.Name_CN.focus();
		return false;
	}
	if(form1.Name_EN.value=='')
	{
		alert("英文名称不能为空");
		form1.Name_EN.focus();
		return false;
	}
	
	var lty = "";
	
	for(var   i=0;i<form1.locationtype.length;i++)   
    {   
           if(form1.locationtype[i].checked)
           { 
             lty=form1.locationtype[i].value;   //这里得到单选按钮值
             }
           
     }
	if(lty=="")
		{
		alert("请选择类型");
		return false;
		
		}
	 
	  sendx("/jsp/admin/edn_ajax.jsp?act=addElongLocationlist&locationtype="+lty+"&cityid="+form1.cityid.value+"&Name_CN="+encodeURIComponent(form1.Name_CN.value)+"&Name_EN="+encodeURIComponent(form1.Name_EN.value)+"&elid="+form1.elid.value,
				 function(data)
				 {
				   if(data!=''&&data.length>1)//如果有这个用户  则写入Cookie .trim()
				   { 
						alert(data.trim());
						window.open('/jsp/provincecity/ElonglocationList.jsp?provinceid='+form1.provinceid.value+'&cityid='+form1.cityid.value+"&t="+Math.floor(Math.random()*10000000000+1),'_self');
				   } 
				 }
				 );	
}
function f_edit(igd)
{
	
		form1.elid.value=igd;
		
		form1.submit();
}
function f_delete(igd)
{
	
	  if(confirm('确认删除'))
		  {
	 sendx("/jsp/admin/edn_ajax.jsp?act=deleteElongLocationlist&cityid="+form1.cityid.value+"&elid="+igd,
			 function(data)
			 {
			   if(data!=''&&data.length>1)//如果有这个用户  则写入Cookie .trim()
			   { 
				   alert(data.trim());
					window.open('/jsp/provincecity/ElonglocationList.jsp?provinceid='+form1.provinceid.value+'&cityid='+form1.cityid.value+"&t="+Math.floor(Math.random()*10000000000+1),'_self');
			   }
			 }
			 );	
		  }
}
function f_setup()
{
	
	parent.ymPrompt.close();
	parent.ymPrompt.win({message:'/jsp/provincecity/CityList.jsp?provinceid='+form1.provinceid.value,width:600,height:560,title:'市区设置',handler:function(){},maxBtn:false,minBtn:false,iframe:true});
}

</script>
</head> 
<body>

<h2>列表&nbsp;(&nbsp;目前共有&nbsp;<font color="#000000" size="3"><%=count%></font>&nbsp;条记录&nbsp;)&nbsp;&nbsp;

</h2>

<form name="form1" action="?" method="GET">


<input type="hidden" name="elid" value="<%=elid %>">
 <input type="hidden" name="cityid" value="<%=cityid%>">
 <input type="hidden" name="provinceid" value="<%=provinceid %>">
<input type="hidden" name="id" value="<%=request.getParameter("id")%>">


<%if(elid!=null && elid.length()>0 ){}else{ %>
<table cellpadding="0" cellspacing="0" id="tablecenter">
<tr>
	<td colspan="4">
	中文名搜索:<input type="text" name="elongnamecn" value="<%=Entity.getNULL(elongnamecn) %>"><input type="submit" value="查询" >
	</td>
</tr> 
</table>
<%} %>
<table cellpadding="0" cellspacing="0" id="tablecenter">
<tr>
	<td colspan="4">

	中文名称：<input type="text" name="Name_CN" value="<%=Entity.getNULL(eobj.getName_CN())%>" size="10">&nbsp;
	英文名称：<input type="text" name="Name_EN" value="<%=Entity.getNULL(eobj.getName_EN())%>" size="10">&nbsp;
	</td>
	<tr>
	<td>
	类别：<input type="radio" name="locationtype" value="district"  <%if("district".equals(eobj.getLocationtype())){out.println(" checked ");} %>>&nbsp;县或市区&nbsp; 
	<input type="radio" name="locationtype" value="commercial" <%if("commercial".equals(eobj.getLocationtype())){out.println(" checked ");} %>>&nbsp;商圈&nbsp;
	<input type="radio" name="locationtype" value="Landmark"  <%if("Landmark".equals(eobj.getLocationtype())){out.println(" checked ");} %>>&nbsp;地标&nbsp;
	
	<%if(elid!=null && elid.length()>0){ %>
	<input type="button" value="修改"  onclick="f_submt();">
	<input type=button value="返回" onClick="window.open('/jsp/provincecity/ElonglocationList.jsp?cityid='+form1.cityid.value+'&t='+Math.floor(Math.random()*10000000000+1),'_self');">
	<%}else{ %>
	<input type="button" value="添加"  onclick="f_submt();"> 
	<input type=button value="返回" onClick="f_setup();",'_self');">
	<%} %>
	</td>
</tr>
</table>

<table cellpadding="0" cellspacing="0" id="tablecenter">

<tr id="tableonetr">
<td>ID号</td>
<td>中文名称</td>
<td>英文名称</td>
<td>类型</td>


<td>操作</td>
</tr>
<%

Enumeration e = Elonglocation.find(sql.toString(), pos, size);
if(!e.hasMoreElements())
{
	out.print("<tr><td colspan='6' align='center'>暂无任何记录!</td></tr>");	
}
  
  for(int i=pos+1;e.hasMoreElements();i++)
  { 
    String Elonglocation_id = ((String)e.nextElement());

    Elonglocation Elonglocation_obj=Elonglocation.find(Elonglocation_id,cityid);
    String lo = Elonglocation_obj.getLocationtype();

 %>
   
    <tr onMouseOver=bgColor='#BCD1E9' onMouseOut=bgColor=''>
	<TD><%=Elonglocation_id%></TD>
     <td><%=Elonglocation_obj.getName_CN()%></td>
     <td><%=Elonglocation_obj.getName_EN() %></td>
     <td><%if(lo.equals("district")){out.println(Elonglocation_obj.LOCATION_TYPE[0]);}
    	 else if (lo.equals("commercial"))
    		 {
    		 out.println(Elonglocation_obj.LOCATION_TYPE[1]);
    		 }else if(lo.equals("Landmark"))
    		 {
    			 out.println(Elonglocation_obj.LOCATION_TYPE[2]);
    		 }
    		 %></td>

    <td>
		
	    <input type='button' value='编辑'  onclick="f_edit('<%=Elonglocation_id%>');">&nbsp;
	    <input type='button' value='删除'  onclick="f_delete('<%=Elonglocation_id%>');">&nbsp;
    </td>

   
   <%
   
  }
  if(count>size)out.print("<tr><td colspan='3' >"+new tea.htmlx.FPNL(teasession._nLanguage, request.getRequestURI()+par.toString(), pos, count,size));

%>
</table>
<br/>


</form>


</body>
</html>