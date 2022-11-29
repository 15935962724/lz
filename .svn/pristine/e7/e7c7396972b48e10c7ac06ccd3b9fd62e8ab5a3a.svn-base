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

StringBuffer sql=new StringBuffer(" AND m.proxymembertype2=1 AND  p.member !="+DbAdapter.cite("webmaster"));

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
<title>代理人管理</title>
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
 



function f_excel()
		{
			if(confirm("您确定要导出数据吗?"))
		    {
				form1.action='/servlet/EditExcel';
				form1.act.value='ClssnMember';
				form1.submit();
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
function f_Upgrade(igd)
{
	 var y ='edge:raised;scroll:0;status:no;help:0;resizable:0;dialogWidth:557px;dialogHeight:450px;';
	 var url = '/jsp/mov/UpgradeMember.jsp?memberorder='+igd+'&t='+new Date().getTime();
	 var rs = window.showModalDialog(url,self,y);
	 if(rs==1)
	 {
		 window.location.reload();
	 }
}

function  f_cpml3(igd1,igd2)
{
	 var y ='edge:raised;scroll:0;status:no;help:0;resizable:0;dialogWidth:857px;dialogHeight:650px;';
	 var url = '/jsp/mov/ClssnProxyMemberList3.jsp?type='+igd1+'&t='+new Date().getTime()+"&member_3="+encodeURIComponent(igd2);
	 var rs = window.showModalDialog(url,self,y);
	 if(rs==1)
	 {
		 window.location.reload();
	 }	 
}



function f_email()
{
	var fname=document.getElementsByName("memberorder");
	var lname="/"; 

	    for(var i=0; i<fname.length; i++)
	    { 
	    	if( fname[i].checked==true){
	       	   lname = lname + fname[i].value+"/"; 
	       }
	     }

	var y ='edge:raised;scroll:0;status:no;help:0;resizable:0;dialogWidth:830px;dialogHeight:710px;';
	 var url = '/jsp/mov/ClssnEmail.jsp?t='+new Date().getTime()+"&member="+encodeURIComponent(lname)+"&sql="+encodeURIComponent(form1.sql.value);
	 var rs = window.showModalDialog(url,self,y);
	 if(rs==1)
	 {
		 window.location.reload();
	 }
}
function f_mailbox()
{
		var fname=document.getElementsByName("memberorder");
	var lname="/"; 

	    for(var i=0; i<fname.length; i++)
	    { 
	    	if( fname[i].checked==true){
	       	   lname = lname + fname[i].value+"/"; 
	       }
	     }

	
	var y ='edge:raised;scroll:0;status:no;help:0;resizable:0;dialogWidth:830px;dialogHeight:710px;';
	 var url = '/jsp/mov/ClssnMailbox.jsp?t='+new Date().getTime()+"&member="+encodeURIComponent(lname)+"&sql="+encodeURIComponent(form1.sql.value);
	 var rs = window.showModalDialog(url,self,y);
	 if(rs==1)
	 {
		 window.location.reload();
	 }
}

</script>

<h1>代理人管理</h1>

 
<form action="?" name="form2">
<input type="hidden" name="node" value="<%=teasession._nNode %>"/>
<input type="hidden" name="community" value="<%=teasession._strCommunity %>"/>  

 
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

<form name="form1" action ="?" method="post">
<input type="hidden" name="nexturl">  
<input type="hidden" name="membertype"/>
<input type="hidden" name="divid"/> 

<input type="hidden" name="id" value="<%=request.getParameter("id") %>">

<input type="hidden" name="act">
<input type="hidden" name="memberlist_act" value="MemberList">
<input type="hidden" name="files" value="会员列表"/>
<input type="hidden" name="sql" value="<%=MT.enc(sql.toString())%>">
<!-- sql.toString() -->

<h2>会员列表&nbsp;(&nbsp;目前共有&nbsp;<font color="#000000" size="3"><%=count%></font>&nbsp;位会员&nbsp;)&nbsp;</h2>
<h2 class="cnclass">

<div class="cnlistLeft">

<input type="button" value="导出EXCEL" onClick=f_excel();>&nbsp;
<input type="button" value="发送Email" onClick=f_email();>&nbsp;
<input type="button" value="短消息" onClick="f_mailbox();">&nbsp;</div>

 </h2>
 
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
	   <tr id=tableonetr>
  			  <td width="1"><input type='checkbox' name="checkall" onclick='CheckAll()' title="全选" style="cursor:pointer"></td>
  			 
  			  <td nowrap>代理人会员ID</td>
  			  <td nowrap>会员类型</td>
  			 
  			  <td nowrap>省份</td>
  			  <td nowrap>性别</td>
  			  <td nowrap>申请时间</td>
  			  <td nowrap>代理人数</td>
  			  <td nowrap>汇款汇总</td>
  			  <td nowrap>已缴费</td>
  			  <td nowrap>未缴费</td>
  			
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
    
      <td><%=moobj.getMember() %></td>
      <td><%
      if(membertype==100){out.print("金牌会员");}else{
      	if(moobj.getPeriod()>0){  
      		out.print("金牌会员");
      	}else{
      		out.print(moobj.getNULL(mtobj.getMembername()));
      	}
      }
      	%></td>
     
      <td nowrap><%=cname %></td>
      <td><%if(pobj.isSex()){out.print("女");}else {out.print("男");} %></td>
      <td nowrap><%if(moobj.getTimes()!=null)out.print(Entity.sdf2.format(moobj.getTimes()));%></td>
      <td><%=MemberOrder.countMP(teasession._strCommunity,"AND m.proxymembertype=1 AND  p.member !="+DbAdapter.cite("webmaster")+" and proxymember ="+DbAdapter.cite(moobj.getMember())) %>&nbsp;位</td>
     <td>
     	<%=MemberOrder.countRemittance(teasession._strCommunity," AND m.proxymembertype=1 AND  p.member !="+DbAdapter.cite("webmaster")+" and proxymember ="+DbAdapter.cite(moobj.getMember())) %>
     </td>
     <td>
     	<%=MemberOrder.countRemittance(teasession._strCommunity," AND m.proxymembertype=1 AND  p.member !="+DbAdapter.cite("webmaster")+" and proxymember ="+DbAdapter.cite(moobj.getMember())+" and (playmoneytype = 1 or playmoneytype = 2 )") %>
     </td>
     <td>
     	<%=MemberOrder.countRemittance(teasession._strCommunity," AND m.proxymembertype=1 AND  p.member !="+DbAdapter.cite("webmaster")+" and proxymember ="+DbAdapter.cite(moobj.getMember())+"  and ( playmoneytype = 0 or playmoneytype is null )") %>
     </td>
		<td>
			<a href="###" onclick="f_cpml3('3','<%=moobj.getMember()%>');">全部代理会员</a>&nbsp;
			<a href="###" onclick="f_cpml3('1','<%=moobj.getMember()%>');">已缴费会员</a>&nbsp;
			<a href="###" onclick="f_cpml3('0','<%=moobj.getMember()%>');">未缴费会员</a>
		</td>
    </tr>
    
<%} %>
<%
 	if(count>0){
	   %>
	   	<tr>
	   		<td colspan="5"></td>
	   		<td align="right">汇总金额：</td>
	   		<td><%=MemberOrder.count(teasession._strCommunity,sql.toString(),"AND m.proxymembertype=1 AND  p.member !="+DbAdapter.cite("webmaster")) %>&nbsp;位</td>
	   		<td><%=MemberOrder.countRemittance(teasession._strCommunity,sql.toString(),"  AND m.proxymembertype=1 AND  p.member !="+DbAdapter.cite("webmaster")) %></td>
	   		<td><%=MemberOrder.countRemittance(teasession._strCommunity,sql.toString(),"  AND m.proxymembertype=1 AND  p.member !="+DbAdapter.cite("webmaster")+"  and (playmoneytype = 1 or playmoneytype = 2 )") %></td>
	   		<td><%=MemberOrder.countRemittance(teasession._strCommunity,sql.toString(),"  AND m.proxymembertype=1 AND  p.member !="+DbAdapter.cite("webmaster")+"  and ( playmoneytype = 0 or playmoneytype is null )") %></td>
	   		
	   	</tr>
	   
	   <%} %> 
	   
	   
     <%if (count > pageSize) {  %>
      <tr> <td colspan="20"><%=new tea.htmlx.FPNL(teasession._nLanguage,request.getRequestURI()+param.toString()+"&pos=",pos,count,pageSize)%>    </td> </tr>
      <%}  %>
  </table>
</form>
</body>
</html>
