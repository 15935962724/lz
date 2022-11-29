<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.entity.admin.*"%><%@ page import="tea.entity.member.*"%><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.Resource"  %><%@page  import="tea.entity.node.*" %><%@ page import="java.util.*" %><%@ page import="tea.ui.*" %><%@ page import="tea.html.*" %><%@page import="tea.entity.admin.mov.*"%>
<%
request.setCharacterEncoding("UTF-8");

response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
  return;
} 

Resource r=new Resource();
r.add("/tea/resource/Classes");



StringBuffer param=new StringBuffer("?community="+teasession._strCommunity);
StringBuffer sql=new StringBuffer(" AND  p.member !="+DbAdapter.cite("webmaster"));



//用户ID
String member = teasession.getParameter("member");
if(member!=null && member.length()>0){
	member = member.trim();
	sql.append(" and p.member like ").append(DbAdapter.cite("%"+member+"%"));
	param.append("&member=").append(java.net.URLEncoder.encode(member,"UTF-8"));
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

String divid = "cnlistid_cmid";//默认最新投稿
if(teasession.getParameter("divid")!=null && teasession.getParameter("divid").length()>0)
{
	divid = teasession.getParameter("divid");
	param.append("&divid=").append(divid);
}


int pos=0,pageSize=10;
String tmp=request.getParameter("pos");
if(tmp!=null)
{
  pos=Integer.parseInt(tmp);
}


int count=MemberOrder.countMP(teasession._strCommunity,sql.toString());
sql.append(" order by times desc "); 


%>
<html>
<head>
<title>发生会员邮件</title>
<base target="dialog"/>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script type="text/javascript">
window.name='dialog';
function f_click(id)
{
  window.returnValue=id;
  window.close();
}
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
 
function f_s(igd,igd2)
{
	form1.membertype.value=igd;
	form1.divid.value=igd2;
	form1.action="?";
	form1.submit();
}
</script>
</head>
<body>
<h1>发生会员邮件</h1>
<form name="form1" action="?" target="dialog">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="membertype"/>
<input type="hidden" name="divid"/>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td>用户名:<input name="member" value="<%if(member!=null)out.print(member);%>" type="text"><input type="submit" value="GO"></td>
  </tr>
</table>

<br> 

<h2>列表 ( <%=count %> )<%
out.print("<span id=cnlistRight>");

out.print("<a href=### onclick=f_s('0','cnlistid_cmid'); class=cnlistclass2");
if("cnlistid_cmid".equals(divid))
{
	out.print(" id ="+divid);
}
out.print(">全部会员</a>");

out.print("<a href=### onclick=f_s('1','cnlistid_cmid2'); class=cnlistclass2");
if("cnlistid_cmid2".equals(divid))
{
	out.print(" id ="+divid);
}
out.print(">普通会员</a>");
	out.print("<a href=### onclick=f_s('100','cnlistid_cmid3'); class=cnlistclass3");
	if("cnlistid_cmid3".equals(divid))
	{
		out.print(" id ="+divid);
	}
	out.print(">金牌会员</a>");
	
	out.print("<a href=### onclick=f_s('2','cnlistid_cmid4'); class=cnlistclass4");
	if("cnlistid_cmid4".equals(divid))
	{
		out.print(" id ="+divid);
	}
	out.print(">数字报会员</a>");
	
	
	
	out.print("</span>");
	
 %></h2>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr id="tableonetr">
    <td width="1"><input type='checkbox' name="checkall" onclick='CheckAll()' title="全选" style="cursor:pointer"></td>
  <td nowrap>会员ID</td>
  <td nowrap>会员类型</td>
   
  </tr>
<%
 java.util.Enumeration e = MemberOrder.findMP(teasession._strCommunity,sql.toString(),pos,pageSize);
if(!e.hasMoreElements())
{
    out.print("<tr><td colspan=10 align=center>暂无记录</td></tr>");
}

for(int i=0;e.hasMoreElements();i++)
{
	String memberorder =((String)e.nextElement());
    MemberOrder  moobj = MemberOrder.find(memberorder);
    Profile pobj = Profile.find(moobj.getMember());
    MemberType mtobj = MemberType.find(moobj.getMembertype());



%> 
 <tr onmouseover=bgColor='#BCD1E9'; onmouseout=bgColor=''; >
      <td width=1><input type=checkbox name=memberorder value="<%=memberorder%>" style="cursor:pointer"></td>
    
      <td><%=moobj.getMember() %></td>
      <td><%
      if(membertype==100){out.print("金牌会员");}else{
      	if(moobj.getPeriod()>0){  
      		out.print("金牌会员");
      	}else{
      		out.print(mtobj.getMembername());
      	}
      }
      	%></td>
</tr>

<%} %>
 <%if (count > pageSize) {  %>
      <tr> <td colspan="20"><%=new tea.htmlx.FPNL(teasession._nLanguage,request.getRequestURI()+param.toString()+"&pos=",pos,count,pageSize)%>    </td> </tr>
      <%}  %>
</table>
</form>
</body>
</html>
