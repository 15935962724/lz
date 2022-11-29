<%@page import="java.util.regex.Matcher"%>
<%@page import="java.util.regex.Pattern"%>
<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.entity.photography.*"%><%@page import="tea.ui.*"%><%@page import="tea.entity.node.*"%><%@page import="tea.html.*"%>
<%@page import="tea.db.*"%><%@page import="tea.entity.member.*"%><%@page import="tea.resource.*"%><%@page import="java.util.*"%><%@page import="java.io.*"%>
<%@page import="java.net.URLEncoder"%><%@page import="tea.entity.Entity"%><%@page import="tea.entity.admin.mov.*"%>
<%@page import="tea.entity.*"%>

<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);

if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}



Resource r=new Resource("/tea/resource/Photography");


String nexturl = request.getRequestURI();

StringBuffer param=new StringBuffer("?community="+teasession._strCommunity);

StringBuffer sql=new StringBuffer(" and membertype=1 AND community="+DbAdapter.cite(teasession._strCommunity)+" AND member !="+DbAdapter.cite("webmaster"));
sql.append(" and not exists (select member from Eventregistration er where er.member = p.member  ) ");

String code = teasession.getParameter("code");
if(code!=null && code.length()>0)
{
	code = code.trim();
	sql.append(" and code like ").append(DbAdapter.cite("%"+code+"%"));
	param.append("&code=").append(code);
}

String memberid = teasession.getParameter("memberid");
if(memberid!=null && memberid.length()>0)
{
	memberid = memberid.trim();
	sql.append(" and member like ").append(DbAdapter.cite("%"+memberid+"%"));
	param.append("&memberid=").append(URLEncoder.encode(memberid,"UTF-8"));
}

String membername = teasession.getParameter("membername");
if(membername!=null && membername.length()>0)
{
	code = code.trim();
	sql.append(" and  exists (select member from ProfileLayer pl where p.member=pl.member and pl.firstname like "+DbAdapter.cite("%"+membername+"%")+")  ");
	param.append("&membername=").append(URLEncoder.encode(membername,"UTF-8"));
}

int sex = -1;
if(teasession.getParameter("sex")!=null && teasession.getParameter("sex").length()>0)
{
	sex = Integer.parseInt(teasession.getParameter("sex"));	
}
if(sex>=0)
{
	sql.append(" and sex = ").append(sex);
	param.append("&sex=").append(sex);
}
String city0 = teasession.getParameter("city0");
if(city0!=null && city0.length()>0)
{ 
		//province
	sql.append(" and exists (select member from ProfileLayer pl where pl.member=p.member AND pl.province like "+DbAdapter.cite("%"+city0+"%")+"  )");
	param.append("&city0=").append(city0);
		
}

String city1 = teasession.getParameter("city1");
if(city1!=null && city1.length()>0)
{ 
		//province
	sql.append(" and exists (select member from ProfileLayer pl where pl.member=p.member AND pl.province like "+DbAdapter.cite("%"+city1+"%")+"  )");
	param.append("&city1=").append(city1);
	city0 = city1;
		
}

String mobile = teasession.getParameter("mobile");
if(mobile!=null && mobile.length()>0)
{
	mobile = mobile.trim();
	sql.append(" and mobile like ").append(DbAdapter.cite("%"+mobile+"%"));
	param.append("&mobile=").append(mobile);
}



int pos=0,pageSize=10;
String tmp=request.getParameter("pos");
if(tmp!=null)
{
  pos=Integer.parseInt(tmp);
}




int count=Profile.count(sql.toString());
sql.append(" order by time desc "); 



%>

<html>
<head>
<base target="tar"/>
<title>创建活动报名会员查询</title>
<script src="/tea/tea.js" type="text/javascript"></script> 
<script src="/tea/mt.js" type="text/javascript"></script>
<link href="/tea/tea.css" rel="stylesheet" type="text/css"/>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/city.js" type="text/javascript"></script>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/card.js" type="text/javascript"></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

</head>
<body >
<script type="text/javascript">
window.name='tar';


function f_cz(igd)
{
	 var y ='edge:raised;scroll:0;status:no;help:0;resizable:0;dialogWidth:930px;dialogHeight:610px;';
	 var url = '/jsp/type/event/WestracEventRegistration.jsp?t='+new Date().getTime()+"&node="+form1.node.value+"&member="+encodeURIComponent(igd)+"&community="+form1.community.value;
	 var rs = window.showModalDialog(url,self,y);
	 form1.submit();
	 
	
}


</script>

<h1>创建活动报名会员查询</h1>

 

<form name="form1" action ="?" method="post" target="tar">

<input type="hidden" name="node" value="<%=teasession._nNode %>"/>
<input type="hidden" name="community" value="<%=teasession._strCommunity %>"/>  

 
<input type="hidden" name="id" value="<%=request.getParameter("id") %>">

<h2>查询</h2>

 <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
	<tr>
		<td align="right">会员编号：<input type="text" name="code" value="<%=Entity.getNULL(code) %>"></td>
		<td align="right">用户名：<input type="text" name="memberid" value="<%=Entity.getNULL(memberid) %>"></td>
		<td align="right">姓名：<input type="text" name="membername" value="<%=Entity.getNULL(membername) %>"></td>
	</tr>
	<tr>
	<td align="right">性别：
		<select name="sex">
			<option value="">性别</option>
			<option value="0" <%if(sex==0)out.println(" selected "); %>>男</option>
			<option value="1" <%if(sex==1)out.println(" selected "); %>>女</option>
			
		</select>
	</td>
	<td align="right">工作地点：<script>mt.city("city0","city1",null,"<%=city0%>");</script></td>
	<td align="right">手机号：<input type="text" name="mobile" value="<%=Entity.getNULL(mobile) %>"></td>
		
		</tr>
		<tr>
	    <td colspan="10" align="center"><input type="submit" value="查询"/></td>
	    </tr>
	</tr> 
 </table>


<h2>会员列表&nbsp;(&nbsp;目前共有&nbsp;<font color="#000000" size="3"><%=count%></font>&nbsp;位会员&nbsp;)&nbsp;</h2>

 
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
	   <tr id=tableonetr>
  			
  			 
  			  <td nowrap>会员编号</td>
  			  <td nowrap>用户名</td>
  		       <td nowrap>姓名</td>
  		       <td nowrap>性别</td>
  			  <td nowrap>工作地点</td>
  			  <td nowrap>手机号</td>
  			  <td nowrap>注册时间</td>
  			    <td nowrap>积分</td>
  			
  			  <td nowrap>操作</td>
	    </tr>
	    
    <%
 

	    java.util.Enumeration e = Profile.find(sql.toString(),pos,pageSize);
		 if(!e.hasMoreElements())
		 {
		     out.print("<tr><td colspan=10 align=center>暂无记录</td></tr>");
		 }
    	for(int i=1;e.hasMoreElements();i++)
    	{
    		String member =((String)e.nextElement());
    	 
    	    Profile pobj = Profile.find(member);
    	 
  
    	
    	 
    	    	tea.entity.util.Card cobj = tea.entity.util.Card.find(pobj.getProvince(teasession._nLanguage));
    	    	
    	    	String cname = cobj.toString2();
    	
    	     
	 
    		  
    %>
    <tr onmouseover=bgColor='#BCD1E9'; onmouseout=bgColor=''; >
    
    <td><%=pobj.getCode()%></a></td> 
      <td><%=member%></a></td>
       <td><%=pobj.getFirstName(teasession._nLanguage)%></a></td>
        <td><%if(pobj.isSex()){out.print("女");}else {out.print("男");} %></td>
     
      <td nowrap><%=cname %></td>
      <td nowrap><%=pobj.getMobile() %></td>
    
      <td nowrap><%if(pobj.getTime()!=null)out.print(Entity.sdf2.format(pobj.getTime()));%></td>
      <td nowrap><%=pobj.getIntegral() %></td>

	    <td nowrap> <a href="###" onclick="f_cz('<%=member%>');" >创建报名表</a></td>
	   
    </tr>
    
   
<%} %>
     <%if(count>pageSize){ %>
      <tr>
       
        <td colspan="20" align="right">
      <%=new tea.htmlx.FPNL(teasession._nLanguage,request.getRequestURI()+param.toString()+"&pos=",pos,count,pageSize)%>    
      </td> </tr>
      <%} %>
    
  </table>
</form>
</body>
</html>

