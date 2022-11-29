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

StringBuffer sql=new StringBuffer(" and proxymembertype2 = 1 AND  p.member !="+DbAdapter.cite("webmaster"));

//用户ID
String member = teasession.getParameter("member");
if(member!=null && member.length()>0){
	member = member.trim();
	sql.append(" and p.member like ").append(DbAdapter.cite("%"+member+"%"));
	param.append("&member=").append(URLEncoder.encode(member,"UTF-8"));
}




int pos=0,pageSize=8;
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
<title>代理会员选择</title>
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
//回车
function enterIn(evt)
{
	var evt = evt?evt:(window.event?window.event:null);
	if(evt.keyCode==13)
	{
		var obj;
		f_submit();
	}
}

function f_submit()
{
		form1.submit();
}
function f_on(igd)
{
	window.returnValue=igd;
	window.close();	
}

</script>




<form name="form1" action ="?" method="post" target="tar">
<input type="hidden" name="node" value="<%=teasession._nNode %>"/>
<input type="hidden" name="community" value="<%=teasession._strCommunity %>"/>  

 
<input type="hidden" name="id" value="<%=request.getParameter("id") %>">

<h2>查询</h2>

 <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
	<tr>
		<td nowrap align="right">会员ID：</td>
		<td><input type="text" name="member" value="<%=Entity.getNULL(member) %>" title="输入完成会员以后可以点击回车或查询按钮"  onkeydown = "enterIn(event);" ></td>
		
	    <td colspan="10" align="center"><input type="submit" value="查询"/></td>
	    </tr>
	</tr> 
 </table>



<input type="hidden" name="id" value="<%=request.getParameter("id") %>">



<h2>会员列表&nbsp;(&nbsp;目前共有&nbsp;<font color="#000000" size="3"><%=count%></font>&nbsp;位会员&nbsp;)&nbsp;</h2>

  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
	   <tr id=tableonetr>
  			
  			 
  			  <td nowrap>会员ID</td>

  			  <td nowrap>性别</td>
  			  <td nowrap>申请时间</td>
  			 
	    </tr>
	    
    <%
 

	    java.util.Enumeration e = MemberOrder.findMP(teasession._strCommunity,sql.toString(),pos,pageSize);
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
    %>
    <tr onmouseover=bgColor='#BCD1E9'; onmouseout=bgColor='';  style="cursor:pointer" onclick="f_on('<%=moobj.getMember() %>');" title="点击会员，就可以选中">
      
    
      <td><%=moobj.getMember() %></td>
      <td><%if(pobj.isSex()){out.print("女");}else {out.print("男");} %></td>
      <td nowrap><%if(pobj.getTime()!=null)out.print(Entity.sdf2.format(pobj.getTime()));%></td>	   
    </tr>
<%} %>
     <%if (count > pageSize) {  %>
      <tr> <td colspan="20"><%=new tea.htmlx.FPNL(teasession._nLanguage,request.getRequestURI()+param.toString()+"&pos=",pos,count,pageSize)%>    </td> </tr>
      <%}  %>
  </table>
</form>
</body>
</html>
