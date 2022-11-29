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
boolean fas = false;

int remembertype=0;


if(teasession.getParameter("remembertype")!=null && teasession.getParameter("remembertype").length()>0)
{
	remembertype = Integer.parseInt(teasession.getParameter("remembertype"));
	sql.append(" and remembertype = ").append(remembertype);
	param.append("&remembertype=").append(remembertype);
}

//会员编号
String code = teasession.getParameter("code");
if(code!=null && code.length()>0)
{
	code = code.trim();
	sql.append(" and code like ").append(DbAdapter.cite("%"+code+"%"));
	param.append("&code=").append(code);
	fas = true;
}
//用户名
String memberid = teasession.getParameter("memberid");
if(memberid!=null && memberid.length()>0) 
{
	memberid = memberid.trim();
	sql.append(" and member like "+DbAdapter.cite("%"+memberid+"%")+"  ");
	param.append("&memberid=").append(URLEncoder.encode(memberid,"UTF-8"));
	fas = true;
}
//注册时间
String time_c = teasession.getParameter("time_c");
if(time_c!=null && time_c.length()>0)
{
  sql.append(" AND time >=").append(DbAdapter.cite(time_c+" 00:00"));
  param.append("&time_c=").append(time_c);
  fas = true;
}

String time_d = teasession.getParameter("time_d");
if(time_d!=null && time_d.length()>0)
{
  sql.append(" AND time <=").append(DbAdapter.cite(time_d+" 23:59"));
  param.append("&time_d=").append(time_d);
  fas = true;
}

//姓名
String membername = teasession.getParameter("membername");
if(membername!=null && membername.length()>0) 
{
	membername = membername.trim();
	sql.append(" and exists (select member from ProfileLayer pl where pl.member=p.member AND pl.firstname like "+DbAdapter.cite("%"+membername+"%")+"  )");
	param.append("&membername=").append(URLEncoder.encode(membername,"UTF-8"));
	fas = true;
}

//性别

int sex= -1;
if(teasession.getParameter("sex")!=null && teasession.getParameter("sex").length()>0)
{
	sex = Integer.parseInt(teasession.getParameter("sex"));	
}
if(sex>=0)
{
	sql.append(" and p.sex= "+sex+"  ");
	param.append("&sex=").append(sex);
	fas = true;
} 


//活跃度
int actives = -1;
if(teasession.getParameter("actives")!=null && teasession.getParameter("actives").length()>0)
{
	actives = Integer.parseInt(teasession.getParameter("actives"));	
}
if(actives>0)
{
	sql.append(" and p.actives= "+actives+"  ");
	param.append("&actives=").append(actives);
	fas = true;
} 




//工作地点城市
String city0 = teasession.getParameter("city0");
if(city0!=null && city0.length()>0)
{ 
		//province
	sql.append(" and exists (select member from ProfileLayer pl where pl.member=p.member AND pl.province like "+DbAdapter.cite("%"+city0+"%")+"  )");
	param.append("&city0=").append(city0);
	fas = true;
		
}

String city1 = teasession.getParameter("city1");
if(city1!=null && city1.length()>0)
{ 
		//province
	sql.append(" and exists (select member from ProfileLayer pl where pl.member=p.member AND pl.province like "+DbAdapter.cite("%"+city1+"%")+"  )");
	param.append("&city1=").append(city1);
	city0 = city1;
	fas = true;
	
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
<base target="dialog"/>
<title>履友管理</title>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/tea/city.js" type="text/javascript"></script>
<link href="/tea/tea.css" rel="stylesheet" type="text/css"/>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/Calendar.js" type="text/javascript"></script>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/card.js" type="text/javascript"></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<style type="text/css">
#xlsize{color:#000000;padding-top:5px;}
h3{color:#CE0829;font-size:12px;margin:5px 0px 5px 0px;display: block;height:20px;padding-left:10px;line-height:20px;text-align:left;width:95%;background-color: #F2F2F2;

clear: both;}
</style>
</head>
<body >
<script type="text/javascript">
window.name="dialog";


function CheckAll()
{
	var checkname=document.getElementsByName("checkall");   
	var fname=document.getElementsByName("memberorder");
	var lname=""; 
	if(checkname[0].checked){
	    for(var i=0; i<fname.length; i++){ 
	      fname[i].checked=true; 
	  }   
	}else{
	   for(var i=0; i<fname.length; i++){ 
	      fname[i].checked=false; 
	   } 
	}


	if(checkname[0].checked)
	{
		
		document.getElementById("checkall2").checked=true;
	}
	else
	{
		document.getElementById("checkall2").checked=false;
	} 
	
	
}
function CheckAll2()
{
	var checkname=document.getElementsByName("checkall2");   
	var fname=document.getElementsByName("memberorder");
	var lname=""; 
	if(checkname[0].checked){
	    for(var i=0; i<fname.length; i++){ 
	      fname[i].checked=true; 
	}   
	}else{
	   for(var i=0; i<fname.length; i++){ 
	      fname[i].checked=false; 
	   } 
	}
	if(checkname[0].checked)
	{
		
		document.getElementById("checkall").checked=true;
	}
	else
	{
		document.getElementById("checkall").checked=false;
	} 
}
 

 //会员提供的线索 
 function f_invite(igd)
 {

	 var y ='edge:raised;scroll:0;status:no;help:0;resizable:0;dialogWidth:630px;dialogHeight:280px;';
	 var url = '/jsp/type/event/WestracEventInvite2.jsp?t='+new Date().getTime()+"&node="+form1.node.value+"&member="+encodeURIComponent("/"+igd+"/");
	 var rs = window.showModalDialog(url,self,y);	
		
 } 
 function f_inviteall()
 {
	 if(submitCheckbox(form1.memberorder,"请选择要邀请的会员"))
	  {

	 		var fname=document.getElementsByName("memberorder");
	 	var lname="";  
	
	 	    for(var i=0; i<fname.length; i++)
	 	    { 
	 	    	if( fname[i].checked==true){
	 	       	   lname = lname + fname[i].value+"/"; 
	 	       }
	 	     }
	
	 	
	 	   var y ='edge:raised;scroll:0;status:no;help:0;resizable:0;dialogWidth:630px;dialogHeight:280px;';
	 	var url = '/jsp/type/event/WestracEventInvite2.jsp?t='+new Date().getTime()+"&node="+form1.node.value+"&member="+encodeURIComponent('/'+lname);
	 	 var rs = window.showModalDialog(url,self,y);
	 	
	 }
 }

 function f_inviteall2()
 {
	
	 	 
	 	   var y ='edge:raised;scroll:0;status:no;help:0;resizable:0;dialogWidth:630px;dialogHeight:280px;';
	 	var url = '/jsp/type/event/WestracEventInvite2.jsp?t='+new Date().getTime()+"&node="+form1.node.value+"&member=all";
	 	 var rs = window.showModalDialog(url,self,y);
	 	
 
 }

</script>

<h1>履友邀请</h1>

 
<form name="form1" action ="?" method="post" target="dialog">
<input type="hidden" name="node" value="<%=teasession._nNode %>"/>
<input type="hidden" name="community" value="<%=teasession._strCommunity %>"/>  

<input type="hidden" name="nexturl">  
<input type="hidden" name="membertype"/>
<input type="hidden" name="divid"/> 

<input type="hidden" name="id" value="<%=request.getParameter("id") %>">

<input type="hidden" name="act">
<input type="hidden" name="memberlist_act" value="MemberList">
<input type="hidden" name="files" value="履友列表"/>
<input type="hidden" name="sql" value="<%=MT.enc(sql.toString())%>">
<input type="hidden" name="remembertype" >



 
<input type="hidden" name="id" value="<%=request.getParameter("id") %>">

<h2>查询</h2>

 <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
	<tr>
		<td align="right">会员编号：<input type="text" name="code" value="<%=Entity.getNULL(code) %>"></td>
		
		<td align="right">姓名：<input type="text" name="membername" value="<%=Entity.getNULL(membername) %>"></td>
		<td align="right">注册时间：从&nbsp;
        <input id="time_c" name="time_c" size="7"  value="<%if(time_c!=null){out.println(time_c);} %>"  style="cursor:pointer" readonly="readonly" onClick="new Calendar().show('form1.time_c');"> 
        <img style="margin-bottom:-8px;" style="cursor:pointer"  src="/tea/image/bbs_edit/table.gif"  style="cursor:pointer" onclick="new Calendar().show('form1.time_c');" />
        &nbsp;到&nbsp;
        <input id="time_d" name="time_d" size="7"  value="<%if(time_d!=null){out.println(time_d);} %>"  style="cursor:pointer" readonly="readonly" onClick="new Calendar().show('form1.time_d');" >
        <img style="margin-bottom:-8px;" style="cursor:pointer"  src="/tea/image/bbs_edit/table.gif"   style="cursor:pointer" onclick="new Calendar().show('form1.time_d');" />
     </td>
		</tr>
		
		<tr>
		<td align="right">性别：
			<select name="sex">
			<option value="">性别</option>
			<option value="0" <%if(sex==0)out.println(" selected "); %>>男</option>
			<option value="1" <%if(sex==1)out.println(" selected "); %>>女</option>
			
		</select>
		</td>
		
		<td align="right">活跃度：
				<select name="actives">
				<option value="-1">活跃度</option>
				<%
					for(int i =1;i<Profile.ACTIVES_TYPE.length;i++)
					{
						out.print("<option value="+i);
						if(actives==i)
						{
							out.print(" selected ");
						}
						out.print(">"+Profile.ACTIVES_TYPE[i]);
						out.print("</option>");
					}
				%>
				
			</select>
		</td>
		<td align="right">工作地点：<script>mt.city("city0","city1",null,"<%=city0%>");</script></td>
		</tr>
		
		
		
		<tr>
	    <td colspan="10" align="center"><input type="submit" value="查询"/></td>
	    </tr>
	</tr> 
 </table>



<h2>会员列表&nbsp;(&nbsp;目前共有&nbsp;<font color="#000000" size="3"><%=count%></font>&nbsp;位会员&nbsp;)&nbsp;

<%if(remembertype==1){ %>
<a href="###" onClick="f_tj('');">返回</a>
<%} %>
</h2>
<%

if(fas)
{//有搜索

   out.print("<h2>您搜索的范围是：");
	//会员编号
	if(code!=null && code.length()>0)
	{
	  out.print("会员编号&nbsp;");
	  out.print("<span id = xlsize>"+code+"</span>&nbsp;");
	}
	//用户名
	if(memberid!=null && memberid.length()>0)
	{
	  
	  out.print("用户名&nbsp;");
	  out.print("<span id = xlsize>"+memberid+"</span>&nbsp;");
	}
	
	//开始时间注册
	if(time_c!=null && time_c.length()>0)
	{
	  out.print("注册时间-开始&nbsp;");
	  out.print("<span id= xlsize>"+time_c+"</span>");
	}
	//开始时间注册
	if(time_d!=null && time_d.length()>0)
	{
	  out.print("注册时间-结束&nbsp;");
	  out.print("<span id= xlsize>"+time_d+"</span>");
	}
	
	//姓名
	if(membername!=null && membername.length()>0)
	{
	  out.print("姓名&nbsp;");
	  out.print("<span id = xlsize>"+membername+"</span>&nbsp;");
	}
	//性别
	if(sex>=0)
	{
	  out.print("性别&nbsp;");
	  if(sex==0)
	  {
		  out.print("<span id = xlsize>男</span>&nbsp;");
	  }else
	  {
		  out.print("<span id = xlsize>女</span>&nbsp;");
	  }
	  
	}
	//活跃度
	if(actives>0)
	{
		  out.print("活跃度&nbsp;");
		 
			  out.print("<span id = xlsize>"+Profile.ACTIVES_TYPE[actives]+"</span>&nbsp;");
		 
		  
	}
	
	//工作地点城市省
	
	if(city0!=null && city0.length()>0)
	{  
		
		tea.entity.util.Card cobj = tea.entity.util.Card.find(Integer.parseInt(city0));
    	
    	String cname = cobj.toStringCity1();
		 out.print("工作地点省&nbsp;");
		  out.print("<span id= xlsize>"+cname+"</span>&nbsp;");
			
	}
    //工作地点城市省
	if(city1!=null && city1.length()>0)
	{  
		
		tea.entity.util.Card cobj = tea.entity.util.Card.find(Integer.parseInt(city1));
    	
    	String cname = cobj.toStringCity2();
		 out.print("工作地点市&nbsp;");
		  out.print("<span id= xlsize>"+cname+"</span>&nbsp;");	
	}


	out.print("<input type=button value=返回   onclick=\"window.open('/jsp/type/event/WestracEventInvite.jsp?node="+teasession._nNode+"','dialog');\" >");
out.print("</h2>");
}
%> 



   <span id="rorderid" ></span>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
	   <tr id=tableonetr>
  			  <td width="1"><input type='checkbox' id="checkall" name="checkall" onclick='CheckAll()' title="全选" style="cursor:pointer"></td>
  			
  			  <td nowrap>会员编号</td>
  			  <td nowrap>用户名</td>
  		       <td nowrap>姓名</td>
  		       <td nowrap>性别</td>
  			  <td nowrap>工作地点</td>
  			  <td nowrap>手机号</td>
  			  <td nowrap>注册时间</td>
  			    <td nowrap>积分</td>
  			 <td nowrap>活跃度</td>

  			  <td nowrap>操作</td>
	    </tr>
	    
    <%
 

	    java.util.Enumeration e = Profile.find(sql.toString(),pos,pageSize);
		 if(!e.hasMoreElements())
		 {
		     out.print("<tr><td colspan=100 align=center>暂无记录</td></tr>");
		 }
    	for(int i=1;e.hasMoreElements();i++)
    	{
    		String member =((String)e.nextElement());
    	 
    	    Profile pobj = Profile.find(member);
    	 
  
    	
    	 
    	    	tea.entity.util.Card cobj = tea.entity.util.Card.find(pobj.getProvince(teasession._nLanguage));
    	    	
    	    	String cname = cobj.toString2();
    	
    	     
	 
    		  
    %>
 
    <tr onmouseover=bgColor='#BCD1E9'; onmouseout=bgColor=''; >
      <td width=1><input type=checkbox name=memberorder id="memberorder" value="<%=member%>" style="cursor:pointer"></td>
   
    <td><%=pobj.getCode()%>
 
  
    </td>
      <td nowrap><%=member%></td>
       <td nowrap><%=pobj.getFirstName(teasession._nLanguage)%></td>
        <td nowrap><%if(pobj.isSex()){out.print("女");}else {out.print("男");} %></td>
     
      <td ><%=cname %></td>
      <td nowrap><%=pobj.getMobile() %></td>
    
      <td nowrap><%if(pobj.getTime()!=null)out.print(Entity.sdf2.format(pobj.getTime()));%></td>
      <td nowrap><%=pobj.getMyintegral() %></td>
     <td nowrap><%=Profile.ACTIVES_TYPE[pobj.getActives()] %></td>
     
      
     
	    <td nowrap> <a href="###" onClick="f_invite('<%=member%>');" >邀请</a></td>
	   
    </tr>
     
   
<%} %>

      <tr>
      <td></td>
       <td colspan="4"><input type='checkbox' name="checkall2" id="checkall2" onclick='CheckAll2()' title="全选" style="cursor:pointer">&nbsp;全选/反选&nbsp;&nbsp;
       <input type="button" value="邀请选中会员" onClick="f_inviteall();">&nbsp;
        <input type="button" value="邀请所有会员" onClick="f_inviteall2();">&nbsp;
       </td>
       
        <td colspan="20" align="right">
      <%=new tea.htmlx.FPNL(teasession._nLanguage,request.getRequestURI()+param.toString()+"&pos=",pos,count,pageSize)%>    
      </td> </tr>

    
  </table>
</form>
</body>
</html>

