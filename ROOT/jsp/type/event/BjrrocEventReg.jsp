<%@page import="tea.entity.node.Event"%>
<%@page import="tea.entity.admin.AdminRole"%>
<%@page import="tea.entity.admin.AdminUnit"%>
<%@page import="tea.entity.admin.AdminUsrRole"%>
<%@page import="java.net.URLEncoder"%>
<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.resource.Resource" %><%@ page import="tea.db.DbAdapter" %><%@ page import="tea.ui.TeaSession" %>
<%@page import="tea.entity.*"%><%@page import="tea.entity.volunteer.*" %><%@page import="tea.entity.member.*" %><%@page import="tea.resource.*" %><%@page import="java.io.*" %>
<%@page import="java.util.*"%>
<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
String community=teasession._strCommunity;
java.util.Date date = new java.util.Date();


if(teasession._rv==null)
{
	out.println("您还没有登录，没有权限查看，请登录");
	return;
}
  String nexturl =  request.getRequestURI()+"?"+request.getQueryString();

StringBuffer sql=new StringBuffer(" and community = ").append(DbAdapter.cite(community));
StringBuffer param=new StringBuffer();

Event eobj = Event.find(teasession._nNode,teasession._nLanguage);
param.append("?community="+teasession._strCommunity).append("&node=").append(teasession._nNode);
param.append("&id=").append(request.getParameter("id"));

	sql.append(" and exists (select member from Volunteer v where v.member = p.member  ) ");
	
//姓名
String firstname=teasession.getParameter("firstname");
if(firstname!=null && firstname.length()>0)
{
  firstname=firstname.trim();
  
  sql.append(" and  exists (select member from ProfileLayer pl where p.member=pl.member and pl.firstname like "+DbAdapter.cite("%"+firstname+"%")+" ) ");
  param.append("&firstname=").append(URLEncoder.encode(firstname,"UTF-8")); 
}
 

String act = teasession.getParameter("act");
if(act!=null && act.length()>0 && "bot".equals(act)&&eobj.getRegmember()!=null && eobj.getRegmember().length()>0){
	
	int cc = 0;
	for(int i=1;i<eobj.getRegmember().split("/").length;i++)
	{
		cc++;
		if(cc==1)
		{
			sql.append(" and ( member =  ").append(DbAdapter.cite(eobj.getRegmember().split("/")[i]));
		}else
		{
			sql.append(" or member= ").append(DbAdapter.cite(eobj.getRegmember().split("/")[i]));
		}
	}
	
	if(cc>=1)
	{
		sql.append(")"); 
	}
	 
	
	 param.append("&act=").append(act); 
}



int pos=0,size = 10;
if(request.getParameter("pos")!=null)
{
  pos=Integer.parseInt(request.getParameter("pos"));
}
param.append("&pos=").append(pos);

int count = Profile.count(sql.toString());






%>
<html>
<HEAD>
  <link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
  <link href="/tea/CssJs/Home.css" rel="stylesheet" type="text/css">
  <script src="/tea/tea.js" type="text/javascript"></script>
</HEAD>
<base target="dialog"/>
<body>
<script type="text/javascript">
window.name='dialog';
function CheckAll()
{
	var checkname=document.getElementsByName("checkall");   
	var fname=document.getElementsByName("membercheckbox");
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

function f_name()
{
	 sendx("/jsp/type/event/ajax.jsp?act=BjrrocEventRegName&firstname="+encodeURIComponent(form1.firstname.value)+"&node="+form1.node.value,
			 function(data)
			 {
		 document.getElementById('show').innerHTML=data;
			 	
			 }
			 );
	
}

function f_checkbox(igd)
{
	sendx("/jsp/type/event/ajax.jsp?act=BjrrocEventRegCheckbox&member="+encodeURIComponent(igd)+"&node="+form1.node.value,
			 function(data)
			 {
		 			document.getElementById('show2').innerHTML=data;
			 }
			 );
}
 

function f_r()
{
 

			var y ='edge:raised;scroll:0;status:no;help:0;resizable:0;dialogWidth:430px;dialogHeight:210px;';
			 var url = '/jsp/type/event/VolunteerFast.jsp?t='+new Date().getTime()+"&firstname="+encodeURIComponent(form1.firstname.value)+"&node="+form1.node.value;
			 var rs = window.showModalDialog(url,self,y);
		
			 if(rs>0)
			 {
			
				 window.open('/jsp/type/event/BjrrocEventReg.jsp?t='+new Date().getTime()+'&node='+rs,'dialog'); 
			 }
 

}
function f_bot()
{
		form1.act.value="bot";
		form1.action="?";
		form1.submit();
}
</script>
<h1>志愿者报名列表</h1>
<form name="form1" action="?" method="POST" target="dialog" >
<input type="hidden" name="id" value="<%=request.getParameter("id") %>">
<input type="hidden" name="node" value="<%=teasession._nNode %>">
<input type="hidden" name="act" >
<table border="0" CELLPADDING="0" CELLSPACING="0" id="tablecenter"> 
  <tr>
  <td align="right" nowrap>姓名：</td><td><input type="text" size="20" name="firstname" value="<%=Entity.getNULL(firstname) %>" onkeyup="f_name();"></td>

     <td colspan="10" align="center"><input type="submit" value="查询" /></td></tr>

</table>

<span id="show2"></span>
<span id ="show">
<h2>列表&nbsp;(&nbsp;目前共有&nbsp;<font color="#000000" size="2"><%=count%></font>&nbsp;位注册志愿者&nbsp;)&nbsp;&nbsp;
<input type=button value="查看已经报名志愿者" onclick="f_bot();">
</h2>



<table border="0" CELLPADDING="0" CELLSPACING="0" id="tablecenter">
 <tr id="tableonetr">
 <td width="1"></td>
      <td nowrap>会员ID
      </td><td nowrap>姓名</td>
      <td nowrap>性别</td>
   
      
      <td nowrap>手机号</td>
  
  
      <TD NOWRAP>所在区县</TD>
       <TD NOWRAP>用户状态</TD> 
     
     

</tr>
<%
java.util.Enumeration eu = Profile.find(sql.toString(),pos,size);
 if ("bot".equals(act) && eobj.getRegmember()==null)
{
	 out.print("<tr><td colspan=20 align=center>暂没有报名的会员</td></tr>");
}else
{
	if(!eu.hasMoreElements())
	{
		out.print("<tr><td colspan=20 align=center><input type=button value=快速注册  onclick=f_r();></td></tr>");
	}
}
for(int i=0;eu.hasMoreElements();i++)
{
	
  String member = String.valueOf(eu.nextElement());
  Profile pobj = Profile.find(member);
  Volunteer vt  =  Volunteer.find(member);
  Profile pro = Profile.find(member);
  String sexy = pro.isSex()?"男":"女";
  String cstring = null;
  if(pobj.getCity(teasession._nLanguage).matches("\\d+"))     //正则表达式 详细见java.util.regex 类 Pattern
  {
	  cstring = Volunteer.CITYS[Integer.parseInt(pobj.getCity(teasession._nLanguage))];
  }else
  {
	  cstring =pobj.getCity(teasession._nLanguage);
  }

 

  
  %>
 <tr onMouseOver=bgColor="#BCD1E9" onMouseOut=bgColor="" style="cursor:pointer" title="点击前面的选择框，就可以报名" >
   <td width=1><input type=checkbox name=membercheckbox value="<%=member%>"  <%if(eobj.getRegmember()!=null && eobj.getRegmember().length()>0 && eobj.getRegmember().indexOf("/"+member+"/")!=-1){out.print(" checked ");} %> style="cursor:pointer" onclick="f_checkbox('<%=member%>');"></td>
      <td nowrap="nowrap"><%=member%></td>
    <td nowrap="nowrap"><%=pro.getName(teasession._nLanguage)%></td>
    <td nowrap="nowrap"><%=sexy%></td>
  
    <td nowrap><%=pro.getMobile()%></td>

 
     <td><%=cstring %></td>
     <td><%
     	if(vt.getMembertype()==0)
     	{
     		out.println("新注册用户");
     	}else if(vt.getMembertype()==1)
     	{
     		out.println("老用户登记");
     	}else if(vt.getMembertype()==2)
     	{
     		out.println("老用户未登记");
     	}else if(vt.getMembertype()==3)
     	{
     		out.println("网站导入");
     	}
     %></td>

  </tr>
  <%
  }
  %>
  <% 
  	if(count>size){
  %>
  <tr><td colspan="20"  align="center" style="padding-right:5px;"><%=new tea.htmlx.FPNL(teasession._nLanguage,"?"+param.toString().replaceFirst("&pos=","&")+"&pos=",pos,count,size)%></td></tr>
<%} %>
  </table>
  </span>
  
</form>
</body>
</html>
