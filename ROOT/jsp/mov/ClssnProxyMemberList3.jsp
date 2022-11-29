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
if("POST".equals(request.getMethod()))
{
	String memberorder = teasession.getParameter("memberorder2");
	
	int playmoneytype = Integer.parseInt(teasession.getParameter("playmoneytype"));
	 MemberOrder moobj  = MemberOrder.find(memberorder);
	 moobj.setPlaymoneytype(playmoneytype);
	 out.println("<script>alert('确认成功');window.returnValue=1;window.close();</script>");
	 return;
	 
}




String member_3 = teasession.getParameter("member_3");
int type = Integer.parseInt(teasession.getParameter("type"));

StringBuffer param=new StringBuffer("?community="+teasession._strCommunity);

StringBuffer sql=new StringBuffer(" AND m.proxymembertype=1 AND  p.member !="+DbAdapter.cite("webmaster"));
sql.append(" and proxymember = ").append(DbAdapter.cite(member_3));

param.append("&member_3=").append(URLEncoder.encode(member_3,"UTF-8"));
param.append("&type=").append(type);



if(type == 0)//没有打款的
{
	sql.append(" and ( playmoneytype = 0 or playmoneytype is null )");
}else if(type == 1)
{
	sql.append(" and (playmoneytype = 1 or playmoneytype = 2 )");
}


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


int pos=0,pageSize=10;
String tmp=request.getParameter("pos");
if(tmp!=null)
{
  pos=Integer.parseInt(tmp);
}



int count=MemberOrder.countMP(teasession._strCommunity,sql.toString());


%>

<html>
<head>
<title>代理会员的代理用户</title>
<base target="tar"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<link href="/tea/tea.css" rel="stylesheet" type="text/css"/>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/Calendar.js" type="text/javascript"></script>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/card.js" type="text/javascript"></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

</head>
<body >
<script type="text/javascript">
window.name='tar';
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
 




		

function f_order(v)
  {
    var aq=form1.aq.value=="true";
    if(form1.o.value==v)
    {
      form1.aq.value=!aq;
    }else
    {
      form1.o.value=v;
    }
    form1.action="?";
    form1.submit();
  } 


function  f_cpml3(igd1,igd2)
{
	 var y ='edge:raised;scroll:0;status:no;help:0;resizable:0;dialogWidth:857px;dialogHeight:650px;';
	 var url = '/jsp/mov/ClssnProxyMemberList3.jsp?type='+igd1+'&t='+new Date().getTime()+"&member="+encodeURIComponent(igd2);
	 var rs = window.showModalDialog(url,self,y);
	 
}


function f_qr(igd,igd2)
{
		form1.playmoneytype.value=igd;
		form1.memberorder2.value=igd2;
		
		form1.submit();
}
function f_cpm(igd1,igd2,igd3)
{
	 var y ='edge:raised;scroll:0;status:no;help:0;resizable:0;dialogWidth:757px;dialogHeight:650px;'; 
	 var url = '/jsp/mov/ClssnProxyEditMember.jsp?member='+igd1+'&memberorder='+igd2+'&membertype='+igd3+'&t='+new Date().getTime();
	 var rs = window.showModalDialog(url,self,y);
	 
} 


</script>



 
<form name="form1" action ="?" method="get" target="tar">
<input type="hidden" name="node" value="<%=teasession._nNode %>"/>
<input type="hidden" name="community" value="<%=teasession._strCommunity %>"/>  
<input type="hidden" name="playmoneytype"/>
<input type="hidden" name="memberorder2"/>   
<input type="hidden" name="member_3" value="<%=member_3 %>">
<input type="hidden" name="type" value="<%=type %>"> 
<input type="hidden" name="id" value="<%=request.getParameter("id") %>">
<input type="hidden" name="nexturl">  
<input type="hidden" name="membertype"/>


<h2>查询</h2>

 <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
	<tr>
		<td nowrap align="right">会员ID：</td>
		<td><input type="text" name="member" value="<%=Entity.getNULL(member) %>"/></td>
		
		<td align="right">申请时间：</td>
		<td>
		 从&nbsp;
	        <input id="time_c" name="time_c" size="7"  value="<%if(time_c!=null)out.print(time_c);%>"  style="cursor:pointer" readonly="readonly" onClick="new Calendar().show('form1.time_c');"> 
	        <img style="margin-bottom:-8px;" style="cursor:pointer"  src="/tea/image/bbs_edit/table.gif"  style="cursor:pointer" onclick="new Calendar().show('form1.time_c');" />
	        &nbsp;到&nbsp;
	        <input id="time_d" name="time_d" size="7"  value="<%if(time_d!=null)out.print(time_d);%>"  style="cursor:pointer" readonly="readonly" onClick="new Calendar().show('form1.time_d');" >
	        <img style="margin-bottom:-8px;" style="cursor:pointer"  src="/tea/image/bbs_edit/table.gif"   style="cursor:pointer" onclick="new Calendar().show('form1.time_d');" />
		
		</td>
	
		
		</tr>
		<tr>
	    
		
		
	
		<td align="right">省份：</td>
		<td><script>selectcard('state','city',null,'<%=city%>');</script></td>
		<td align="right">性别：</td>
		<td>
			<select name="sex">
				<option value="-1">-性别-</option>
				<option value="0" <%if(sex==0)out.print(" selected "); %>>男</option>
				<option value="1" <%if(sex==1)out.print(" selected "); %>>女</option>
			</select>
		</td>
		</tr>
		<tr> 
	
	    <td colspan="10" align="center"><input type="submit" value="查询"/></td>
	    </tr>
	</tr> 
 </table>
</form> 





<h2>会员列表&nbsp;(&nbsp;目前共有&nbsp;<font color="#000000" size="3"><%=count%></font>&nbsp;位会员&nbsp;)&nbsp;</h2>

 
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
	   <tr id=tableonetr>
  			  <td width="1"><input type='checkbox' name="checkall" onclick='CheckAll()' title="全选" style="cursor:pointer"></td>
  			 
  			  <td nowrap>代理人会员ID</td>
  			  <td nowrap>代理人姓名</td>
  			  <td nowrap>会员类型</td>
  			 
  			  <td nowrap>省份</td>
  			  <td nowrap>性别</td>
  			    <td nowrap>手机号码</td>
  			  <td nowrap>工作单位</td>
  			  <td nowrap>申请时间</td>
  			  <td nowrap>汇款金额</td>
  			
  			  <td nowrap>操作</td>
	    </tr>
	    
    <%
  

	    java.util.Enumeration e = MemberOrder.findMP(teasession._strCommunity,sql.toString()+" order by times desc ",pos,pageSize);
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
    
      <td>
      <a href="###" onclick="f_cpm('<%=URLEncoder.encode(moobj.getMember(),"UTF-8") %>','<%=memberorder %>','<%=moobj.getMembertype() %>');">
       

      <%=moobj.getMember() %></td>
       <td><%=pobj.getFirstName(teasession._nLanguage) %></td>
      <td><%
      if(membertype==100){out.print("金牌会员");}else{
      	if(moobj.getPeriod()>0){  
      		out.print("金牌会员");
      	}else{
      		out.print(moobj.getNULL(mtobj.getMembername()));
      	}
      }
      	%></a>&nbsp;</td>
     
      <td nowrap><%=cname %></td>
      <td><%if(pobj.isSex()){out.print("女");}else {out.print("男");} %></td>
       <td><%=pobj.getMobile()%></td>
      <td><%=pobj.getOrganization(teasession._nLanguage) %></td>
      
      <td nowrap><%if(moobj.getTimes()!=null)out.print(Entity.sdf2.format(moobj.getTimes()));%></td>
      <td nowrap><%=moobj.getRemittance()%></td>
      
	  <td>
	  	  <%
	    if(moobj.getPlaymoneytype()==1)
	   	{
	   		out.println("<a href='###' onclick=f_qr('2','"+memberorder+"');>确认代理会员打款</a> ");
	   	}else if(moobj.getPlaymoneytype()==2)
	   	{
	   		out.println("<a href='###' onclick=f_qr('1','"+memberorder+"'); >取消代理会员打款确认</a> ");
	   	}else if(moobj.getPlaymoneytype()==0)
	   	{
	   		out.println("代理会员还没打款");
	   	}
	   %> 
	  </td>
	   
	  
<%} %>
 <%
	   	if(count>0){
	   %>
	   	<tr>
	   		<td colspan="8"></td>
	   		<td nowrap="nowrap" >汇总金额：</td>
	   		<td><%=MemberOrder.countRemittance(teasession._strCommunity,sql.toString()) %></td>
	   		
	   	</tr>
	   
	   <%} %>
	   
    </tr>
     <%if (count > pageSize) {  %>
      <tr> <td colspan="20"><%=new tea.htmlx.FPNL(teasession._nLanguage,request.getRequestURI()+param.toString()+"&pos=",pos,count,pageSize)%>    </td> </tr>
      <%}  %>
  </table>
</form>
</body>
</html>
