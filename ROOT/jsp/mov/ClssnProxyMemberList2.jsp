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

String nexturl = request.getRequestURI()+"?"+request.getQueryString();

Resource r=new Resource("/tea/resource/Photography");



if("POST".equals(request.getMethod()))
{
	String memberorder = teasession.getParameter("memberorder2");
	
	int playmoneytype = Integer.parseInt(teasession.getParameter("playmoneytype"));
	 MemberOrder moobj  = MemberOrder.find(memberorder);
	 moobj.setPlaymoneytype(playmoneytype);
	 out.println("<script>alert('功能修改成功');window.location.href='"+nexturl+"';</script>");
	
}





StringBuffer param=new StringBuffer("?community="+teasession._strCommunity);

StringBuffer sql=new StringBuffer(" and proxymembertype=1 and proxymember ="+DbAdapter.cite(teasession._rv.toString())+" AND  p.member !="+DbAdapter.cite("webmaster"));

//用户ID
String member = teasession.getParameter("member");
if(member!=null && member.length()>0){
	member = member.trim();
	sql.append(" and p.member like ").append(DbAdapter.cite("%"+member+"%"));
	param.append("&member=").append(URLEncoder.encode(member,"UTF-8"));
}




//申请时间
String time_c = teasession.getParameter("time_c");
if(time_c!=null && time_c.length()>0)
{
  sql.append(" AND m.times >=").append(DbAdapter.cite(time_c+" 00:00"));
  param.append("&time_c=").append(time_c);
}
String time_d = teasession.getParameter("time_d"); 
if(time_d!=null && time_d.length()>0)
{
  sql.append(" AND m.times <=").append(DbAdapter.cite(time_d+" 23:59"));
  param.append("&time_d=").append(time_d);
}

//性别
int sex= -1;
if(teasession.getParameter("sex")!=null && teasession.getParameter("sex").length()>0){
	sex = Integer.parseInt(teasession.getParameter("sex"));
}
if(sex>=0){
	sql.append(" and p.sex= ").append(sex);
	param.append("&sex=").append(sex);
}


//省份

String city = teasession.getParameter("city");
if(city==null || city.length()==0)
 city = teasession.getParameter("state");
if(city!=null && city.length()>0)
{
	sql.append(" and exists (select pl.member from ProfileLayer pl where p.member = pl.member and pl.city like "+DbAdapter.cite(city+"%")+") ");
	param.append("&city=").append(city);
}

//会员类型
int membertype = 0;
if(teasession.getParameter("membertype")!=null && teasession.getParameter("membertype").length()>0)
{
	membertype = Integer.parseInt(teasession.getParameter("membertype"));
}
if(membertype>0)
{
	if(membertype==100){
		sql.append(" and m.period > 0");
	}else
	{
		sql.append("  and m.period =0 and m.membertype = ").append(membertype);
	}
	param.append("&membertype=").append(membertype);
}

// 汇款状态
int remtype  = -1;
if(teasession.getParameter("remtype")!=null && teasession.getParameter("remtype").length()>0){
	remtype = Integer.parseInt(teasession.getParameter("remtype"));
}
if(remtype>=0){
	sql.append(" and m.remtype = ").append(remtype);
	param.append("&remtype=").append(remtype);
}



//阅读有效期

String becometime_c = teasession.getParameter("becometime_c");
if(becometime_c!=null && becometime_c.length()>0)
{
sql.append(" AND m.becometime >=").append(DbAdapter.cite(becometime_c+" 00:00"));
param.append("&becometime_c=").append(becometime_c);
}
String becometime_d = teasession.getParameter("becometime_d"); 
if(becometime_d!=null && becometime_d.length()>0)
{
sql.append(" AND m.becometime <=").append(DbAdapter.cite(becometime_d+" 23:59"));
param.append("&becometime_d=").append(becometime_d);
} 
//汇款金额
String remittance2 = teasession.getParameter("remittance2");
int rt = 0;
if(remittance2!=null && remittance2.length()>0){
	rt = Integer.parseInt(teasession.getParameter("remittance2"));
	
} 
if(rt>0)
{
	sql.append(" and m.remittance = ").append(rt);
	param.append("&remittance2=").append(remittance2);
}
int pos=0,pageSize=10;
String tmp=request.getParameter("pos");
if(tmp!=null)
{
  pos=Integer.parseInt(tmp);
}

String divid = "cnlistid_cmid";//默认最新投稿
if(teasession.getParameter("divid")!=null && teasession.getParameter("divid").length()>0)
{
	divid = teasession.getParameter("divid");
	param.append("&divid=").append(divid);
}


int count=MemberOrder.countMP(teasession._strCommunity,sql.toString());
 



%>

<html>
<head>
<title>会员审核管理</title>
<script src="/tea/tea.js" type="text/javascript"></script>
<link href="/tea/tea.css" rel="stylesheet" type="text/css"/>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/Calendar.js" type="text/javascript"></script>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/card.js" type="text/javascript"></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

</head>
<body >
<script type="text/javascript">

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
}
 
function f_qr(igd,igd2)
{
		form1.playmoneytype.value=igd;
		form1.memberorder2.value=igd2;
		
		form1.submit();
}


</script>

<h1>自己代理的会员</h1>
<form name="form1" action ="?" method="POST">

<input type="hidden" name="node" value="<%=teasession._nNode %>"/>
<input type="hidden" name="community" value="<%=teasession._strCommunity %>"/>
<input type="hidden" name="playmoneytype"/>
<input type="hidden" name="memberorder2"/>       

 
<input type="hidden" name="id" value="<%=request.getParameter("id") %>">

<h2>查询</h2>

 <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
	<tr>
		<td nowrap align="right">会员ID：</td>
		<td><input type="text" name="member" value="<%=Entity.getNULL(member) %>"/></td>
		
		<td align="right">申请时间：</td>
		<td>
		 从&nbsp;
	        <input id="time_c" name="time_c" size="7"  value="<%if(time_c!=null)out.print(time_c);%>"  style="cursor:pointer" readonly="readonly" onClick="new Calendar().show('form2.time_c');"> 
	        <img style="margin-bottom:-8px;" style="cursor:pointer"  src="/tea/image/bbs_edit/table.gif"  style="cursor:pointer" onclick="new Calendar().show('form2.time_c');" />
	        &nbsp;到&nbsp;
	        <input id="time_d" name="time_d" size="7"  value="<%if(time_d!=null)out.print(time_d);%>"  style="cursor:pointer" readonly="readonly" onClick="new Calendar().show('form2.time_d');" >
	        <img style="margin-bottom:-8px;" style="cursor:pointer"  src="/tea/image/bbs_edit/table.gif"   style="cursor:pointer" onclick="new Calendar().show('form2.time_d');" />
		
		</td>
	
		
		</tr>
		<tr>
	    
		
		<td align="right">阅读有效期：</td>
		<td>
		 从&nbsp;
	        <input id="becometime_c" name="becometime_c" size="7"  value="<%if(becometime_c!=null)out.print(becometime_c);%>"  style="cursor:pointer" readonly="readonly" onClick="new Calendar().show('form2.becometime_c');"> 
	        <img style="margin-bottom:-8px;" style="cursor:pointer"  src="/tea/image/bbs_edit/table.gif"  style="cursor:pointer" onclick="new Calendar().show('form2.becometime_c');" />
	        &nbsp;到&nbsp;
	        <input id="becometime_d" name="becometime_d" size="7"  value="<%if(becometime_d!=null)out.print(becometime_d);%>"  style="cursor:pointer" readonly="readonly" onClick="new Calendar().show('form2.becometime_d');" >
	        <img style="margin-bottom:-8px;" style="cursor:pointer"  src="/tea/image/bbs_edit/table.gif"   style="cursor:pointer" onclick="new Calendar().show('form2.becometime_d');" />
		
		</td>
	
		<td align="right">省份：</td>
		<td><script>selectcard('state','city',null,'<%=city%>');</script></td>
		
		</tr>
		<tr> 
	
		
		<td align="right">汇款方式：</td>
		<td>
			<select name="remtype">
			<option value="-1" <%if(remtype==-1)out.print(" selected "); %>>-汇款方式-</option>
				<%
				for(int i=0;i<MemberOrder.REM_TYPE.length;i++)
				{
					out.print("<option value="+i);
					if(remtype==i){
						out.print(" selected ");
					}
					out.print(">"+MemberOrder.REM_TYPE[i]);
					out.print("</option>"); 
				}
				%>
			</select> 
		</td>
		<td nowrap align="right">汇款金额：</td>
		<td><input type="text" name="remittance2" value="<%=Entity.getNULL(remittance2) %>"/></td>
		</tr>
		<tr>
		
	    <td colspan="10" align="center"><input type="submit" value="查询"/></td>
	    </tr>
	</tr> 
 </table>



<h2>会员列表&nbsp;(&nbsp;目前共有&nbsp;<font color="#000000" size="3"><%=count%></font>&nbsp;位会员&nbsp;)&nbsp;</h2>

 
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
	   <tr id=tableonetr>
  			  <td width="1"><input type='checkbox' name="checkall" onclick='CheckAll()' title="全选" style="cursor:pointer"></td>
  			 
  			  <td nowrap>会员ID</td>
  			
  			  <td nowrap>省份</td>
  			  
  			  <td nowrap>申请时间</td>
  			  <td nowrap>阅读有效期</td>
  			  <td nowrap>邮箱验证</td>
  			  <td nowrap>汇款金额</td>
  			
  			  <td nowrap>操作</td>
	    </tr>
	    
    <%
 

	    java.util.Enumeration e = MemberOrder.findMP(teasession._strCommunity,sql.toString()+" order by times desc",pos,pageSize);
		 if(!e.hasMoreElements())
		 {
		     out.print("<tr><td colspan=10 align=center>暂无记录</td></tr>");
		 }
    	for(int i=1;e.hasMoreElements();i++)
    	{
    		String memberorder =((String)e.nextElement());
    	    MemberOrder  moobj = MemberOrder.find(memberorder);
    	    Profile pobj = Profile.find(moobj.getMember());
    	    MemberType mtobj = MemberType.find(moobj.getMembertype());
    	    int cid=0;
    	    String cname="";
    	    
    	    Pattern pattern = Pattern.compile("[0-9]*");
    		Matcher isNum = pattern.matcher(pobj.getCity(teasession._nLanguage));
    	
    	     
    	    if(isNum.matches()&&pobj.getCity(teasession._nLanguage)!=null && pobj.getCity(teasession._nLanguage).length()>0 && !"--------------".equals(pobj.getCity(teasession._nLanguage)))
    	    {
    	    	tea.entity.util.Card cobj = tea.entity.util.Card.find(Integer.parseInt(pobj.getCity(teasession._nLanguage)));
    	    	cname = cobj.toString();
    	    }
    	    
	 
    		  
    %>
    <tr onmouseover=bgColor='#BCD1E9'; onmouseout=bgColor=''; >
      <td width=1><input type=checkbox name=memberorder value="<%=memberorder%>" style="cursor:pointer"></td>
    
      <td><%=moobj.getMember() %></td>
      
     
      <td nowrap><%=cname %></td>
    
      <td nowrap><%if(pobj.getTime()!=null)out.print(Entity.sdf2.format(pobj.getTime()));%></td>
      <td nowrap><%if(moobj.getBecometime()!=null)out.print(Entity.sdf.format(moobj.getBecometime())); %></td>
      <td>
      	<%
      		if(Profile.findValid(moobj.getMember())==1)
      		{
      			out.print("<font color=#00ab00>已通过</font>");
      		}else
      		{
      			out.print("<font color=red>未通过</font>");
      		}
      	%>
      </td>
      
     <td><%=moobj.getRemittance() %></td> 

	  
	   <td nowrap>
	   <%
	   	if(moobj.getPlaymoneytype()==0){
	   		
	   		out.println("<a href=### onclick=f_qr('1','"+memberorder+"'); >确认已经打款</a> ");
	   	}else if(moobj.getPlaymoneytype()==1)
	   	{
	   		out.println("<a href=### onclick=f_qr('0','"+memberorder+"'); >等待管理员确认,可以取消打款</a> ");
	   	}else  if(moobj.getPlaymoneytype()==2)
	   	{
	   		out.println("管理员已经确认，不能修改");
	   	}
	   %>
	 
	   
	   
    </tr>
<%} %>
<%
	   	if(count>0){
	   %>
	   	<tr>
	   		<td colspan="5"></td>
	   		<td align="right">汇总金额：</td>
	   		<td><%=MemberOrder.countRemittance(teasession._strCommunity,sql.toString()) %></td>
	   		
	   	</tr>
	   
	   <%} %>



     <%if (count > pageSize) {  %>
      <tr> <td colspan="20"><%=new tea.htmlx.FPNL(teasession._nLanguage,request.getRequestURI()+param.toString()+"&pos=",pos,count,pageSize)%>    </td> </tr>
      <%}  %>
  </table>
</form>
</body>
</html>
