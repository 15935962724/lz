<%@page import="java.util.regex.Matcher"%>
<%@page import="java.util.regex.Pattern"%>
<%@page import="tea.entity.westrac.Eventregistration"%>
<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.entity.node.Event"%>
<%@page import="tea.entity.node.Node"%>
<%@page import="tea.entity.admin.AdminRole"%>
<%@page import="tea.entity.admin.AdminUnit"%>
<%@page import="tea.entity.admin.AdminUsrRole"%>
<%@page import="java.net.URLEncoder"%>
<%@ page import="tea.resource.Resource" %><%@ page import="tea.db.DbAdapter" %><%@ page import="tea.ui.TeaSession" %>
<%@page import="tea.entity.*"%><%@page import="tea.entity.volunteer.*" %><%@page import="tea.entity.member.*" %><%@page import="tea.resource.*" %><%@page import="java.io.*" %>
<%@page import="java.util.*"%>
<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
String community=teasession._strCommunity;



if(teasession._rv==null)
{
	out.println("您还没有登录，没有权限查看，请登录");
	return;
}



StringBuffer sql=new StringBuffer(" and node = "+teasession._nNode+"  and community = ").append(DbAdapter.cite(community));
StringBuffer param=new StringBuffer();

String nexturl =  request.getRequestURI()+"?node="+teasession._nNode;

param.append("?community="+teasession._strCommunity);
param.append("&id=").append(request.getParameter("id"));
param.append("&node=").append(teasession._nNode);



Node nobj  = Node.find(teasession._nNode);
 Event eventobj = Event.find(nobj._nNode,teasession._nLanguage);

sql.append(" and verifg = 1 and confirmtype=1 ");



String wename = teasession.getParameter("wename");
if(wename!=null && wename.length()>0) 
{
	wename = wename.trim();
	sql.append(" and exists (select member from ProfileLayer pl where pl.member=Eventregistration.member AND pl.firstname like "+DbAdapter.cite("%"+wename+"%")+"  )");
	param.append("&wename=").append(URLEncoder.encode(wename,"UTF-8"));
}

int sex= -1;
if(teasession.getParameter("sex")!=null && teasession.getParameter("sex").length()>0)
{
	sex = Integer.parseInt(teasession.getParameter("sex"));	
}
if(sex>=0)
{
	sql.append(" and exists (select member from Profile p where p.member=Eventregistration.member AND p.sex= "+sex+"  )");
	param.append("&sex=").append(sex);
} 

String city0 = teasession.getParameter("city0");
if(city0!=null && city0.length()>0)
{ 
		//province
	sql.append(" and exists (select member from ProfileLayer pl where pl.member=Eventregistration.member AND pl.province like "+DbAdapter.cite("%"+city0+"%")+"  )");
	param.append("&city0=").append(city0);
		
}

String city1 = teasession.getParameter("city1");
if(city1!=null && city1.length()>0)
{ 
		//province
	sql.append(" and exists (select member from ProfileLayer pl where pl.member=Eventregistration.member AND pl.province like "+DbAdapter.cite("%"+city1+"%")+"  )");
	param.append("&city1=").append(city1);
	city0 = city1;
		
}

int pos=0,size=10;
String tmp=request.getParameter("pos");
if(tmp!=null)
{
  pos=Integer.parseInt(tmp);
}

int count = Eventregistration.Count(teasession._strCommunity,sql.toString());

sql.append(" order by times desc ");








%>
<html>
<base target="tar"/>
<HEAD>
  <link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
  <link href="/tea/CssJs/Home.css" rel="stylesheet" type="text/css">
  <script src="/tea/tea.js" type="text/javascript"></script>
  <script src="/tea/mt.js" type="text/javascript"></script>
  <script src="/tea/city.js"></script>
</HEAD>

<body topmargin="0" leftmargin="0" marginheight="0" marginwidth="0" scroll="yes">
<script type="text/javascript">
window.name='tar';
function CheckAll()
{
	var checkname=document.getElementsByName("checkall");   
	var fname=document.getElementsByName("checkeid");
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
	var fname=document.getElementsByName("checkeid");
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


//详细
//

function f_Wershow(igd)
{
	 var y ='edge:raised;scroll:0;status:no;help:0;resizable:0;dialogWidth:930px;dialogHeight:610px;';
	 var url = '/jsp/type/event/WestracEventRegistrationShow.jsp?t='+new Date().getTime()+"&node="+form1.node.value+"&eid="+igd+"&community="+form1.community.value;
	 var rs = window.showModalDialog(url,self,y);

}


//导出
function f_excel()
		{
			if(confirm("您确定要导出数据吗?"))
		    {
				form1.action='/servlet/EditWestracExcel';
				form1.act.value='WestracEventMemberList';
				form1.submit();
			}
	   } 
	  

</script>

<h1>活动名称：<%=nobj.getSubject(teasession._nLanguage) %>&nbsp;&nbsp;参会人员列表</h1>
<form name="form1" action="?" method="POST" target="tar" >
<input type="hidden" name="id" value="<%=request.getParameter("id") %>">
<input type="hidden" name="node" value="<%=teasession._nNode %>">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>">

<input type="hidden" name="nexturl" value="<%=nexturl %>">
<input type="hidden" name="act" >
<input type="hidden" name="files" value="会员报名表"/>
<input type="hidden" name="sql" value="<%=MT.enc(sql.toString())%>">


<table border="0" CELLPADDING="0" CELLSPACING="0" id="tablecenter"> 
	<tr>
	<td align="right">姓名：<input type="text" name="wename" value="<%=Entity.getNULL(wename) %>"></td>
	<td align="right">性别：
		<select name="sex">
			<option value="">性别</option>
			<option value="0" <%if(sex==0)out.println(" selected "); %>>男</option>
			<option value="1" <%if(sex==1)out.println(" selected "); %>>女</option>
			
		</select>
	</td>
	<td align="right">工作地点：<script>mt.city("city0","city1",null,"<%=city0%>");</script></td>
		
		
      <td colspan="10" align="left"><input type="submit" value="查询" /></td></tr>

</table>

<h2>列表&nbsp;(&nbsp;目前共有&nbsp;<font color="#000000" size="2"><%=count%></font>&nbsp;俱乐部会员&nbsp;)&nbsp;&nbsp;</h2>






<table border="0" CELLPADDING="0" CELLSPACING="0" id="tablecenter">
 <tr id="tableonetr">
  <td width="1"><input type='checkbox' id="checkall" name="checkall" onclick='CheckAll()' title="全选" style="cursor:pointer"></td>
      <td nowrap>会员编号</td>
      <td nowrap>用户名</td>
      <td nowrap>姓名</td>
      <td nowrap>性别 </td>
      <td nowrap>工作地点</td>
      <td nowrap>手机</td>
      <td nowrap>注册时间</td>
      <td nowrap>积分</td>
      <td nowrap>活跃度</td>
   
      <td>操作</td>
     

</tr> 
<%


 
java.util.Enumeration eu = Eventregistration.find(teasession._strCommunity,sql.toString(),pos,size);
if(!eu.hasMoreElements())
{
	out.print("<tr><td colspan=20 align=center>暂无记录</td></tr>");
}
for(int i=0;eu.hasMoreElements();i++)
{
	
 	int eid = ((Integer)eu.nextElement()).intValue();
 	Eventregistration eobj = Eventregistration.find(eid);
 	Profile p = Profile.find(eobj.getMember());

 	
	tea.entity.util.Card cobj = tea.entity.util.Card.find(p.getProvince(teasession._nLanguage));
	
	String cname = cobj.toString2();

  %> 
 <tr onMouseOver=bgColor="#BCD1E9" onMouseOut=bgColor="">  
 <td width=1><input type=checkbox name=checkeid value="<%=eid%>" style="cursor:pointer"></td>
    <td nowrap="nowrap"><%=p.getCode()%></td>
    <td nowrap="nowrap"><%=eobj.getMember() %></td>
    <td nowrap="nowrap"><%=p.getFirstName(teasession._nLanguage) %></td>
    <td nowrap="nowrap"><%if(!p.isSex()){out.print("男");}else{out.print("女");} %></td>
    <td nowrap="nowrap"><%=cname%></td>
    <td nowrap="nowrap"><%=p.getMobile()%></td>
   
     <td><%=Entity.sdf.format(p.getTime())%></td>
 	<td><%=p.getIntegral() %></td>
 	<td><%=p.ACTIVES_TYPE[p.getActives()] %></td>
 	  
    <td> <a href="###"  onclick="f_Wershow('<%=eid%>');">详细</a>&nbsp; </td> 
  </tr> 
  
 	 <tr id="trid<%=eid %>" style="display:none">
  	<td align="right" colspan="20">
  		
  		<a href="###"  onclick="f_Wershow('<%=eid%>');">详细</a>&nbsp;
  		<a href="###" onclick="f_Wer('<%=eid%>');">报名表</a>
  		<a href="###" onclick="f_confirmtype('<%=eid%>');">确认到会</a>
  		<a href="###" onclick="f_jf('<%=eobj.getMember()%>');">积分</a>
  	
  		  <a href="###" onclick="f_Delete('<%=eid%>');">删除</a>
  		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  	</td>
  </tr>
 
 
  <%
  }
  %>
  
      <tr>
       <td colspan="2"><input type='checkbox' name="checkall2" id="checkall2" onclick='CheckAll2()' title="全选" style="cursor:pointer">&nbsp;全选/反选</td>
       <td colspan="7">
    
         <input type=button value="导出报名表" onclick="f_excel();">
        

       
       
       </td>
        <td colspan="3" align="right">
      <%=new tea.htmlx.FPNL(teasession._nLanguage,request.getRequestURI()+param.toString()+"&pos=",pos,count,size)%>    
      </td> </tr>
  </table>
</form>
</body>
</html>
