<%@page import="tea.entity.westrac.EventaccoMember"%>
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

  
 

 

StringBuffer sql=new StringBuffer("  and node = "+teasession._nNode);
StringBuffer param=new StringBuffer();
sql.append(" and exists (select node from Eventregistration en where en.node =EventaccoMember.node and en.stay=0 )");
sql.append(" and exists (select node from Eventregistration en where en.node =EventaccoMember.node and en.verifg=1 )");

String nexturl =  request.getRequestURI()+"?"+request.getQueryString();

param.append("?community="+teasession._strCommunity);
param.append("&id=").append(request.getParameter("id"));
param.append("&node=").append(teasession._nNode);



Node nobj  = Node.find(teasession._nNode);

String emember = teasession.getParameter("emember");

if(emember!=null && emember.length()>0) 
{
	emember = emember.trim();
	sql.append("  and exists (select node from Eventregistration en where en.node =EventaccoMember.node and en.member like "+DbAdapter.cite("%"+emember+"%")+")  ");
	
	param.append("&emember=").append(URLEncoder.encode(emember,"UTF-8"));
}


String acconame = teasession.getParameter("acconame");
if(acconame!=null && acconame.length()>0) 
{
	acconame = acconame.trim();
	sql.append(" and acconame like "+DbAdapter.cite("%"+acconame+"%")+"  ");
	param.append("&acconame=").append(URLEncoder.encode(acconame,"UTF-8"));
}

int pos=0,size=10;
String tmp=request.getParameter("pos");
if(tmp!=null)
{
  pos=Integer.parseInt(tmp);
}

int count = EventaccoMember.Count(sql.toString());
 

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
//编辑随行人员信息
function f_editAccom(igd)
{
	 var y ='edge:raised;scroll:0;status:no;help:0;resizable:0;dialogWidth:470px;dialogHeight:310px;';
	 var url = '/jsp/type/event/WestracEventEditAccompMember.jsp?t='+new Date().getTime()+"&eid="+igd+"&node="+form1.node.value+"&eid="+igd+"&community="+form1.community.value;
	 var rs = window.showModalDialog(url,self,y);
	 form1.submit();
} 
//删除
function f_Delete(igd)
{
	if(confirm("您确定要删除这条记录吗？删除以后，不能恢复！")){
		sendx("/jsp/admin/edn_ajax.jsp?act=WestracEventAccompMemberDelete&eid="+igd,
				 function(data)
				 {
			        data = data.trim(); 
			 		if(data=='true')
			 		{
			 			 alert("随行人员信息删除成功");
			 		}
				    form1.submit();
				 }
				 );	
	}
}
//批量删除和审核
function f_sub(igd,strigd)
{

  if(submitCheckbox(form1.checkeid,strigd))
  {

		//删除
		
		if(igd=='delete')//
		{
			if(confirm('您确定要删除吗？删除以后数据不能恢复'))
			{
				form1.action='/servlet/EditEvent';
				form1.act.value='WestracEventAccompMemberDeleteALL';
				 
	    		form1.submit();
			}
		}
		 
		
		
		
     }
}
</script>

<h1>活动名称：<%=nobj.getSubject(teasession._nLanguage) %>&nbsp;&nbsp;俱乐部会员的随行人员</h1>
<form name="form1" action="?" method="POST" target="tar" >
<input type="hidden" name="id" value="<%=request.getParameter("id") %>">
<input type="hidden" name="node" value="<%=teasession._nNode %>">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>">

<input type="hidden" name="nexturl" value="<%=nexturl %>">
<input type="hidden" name="act" >

<table border="0" CELLPADDING="0" CELLSPACING="0" id="tablecenter"> 
	<tr>
	
	<td align="right">用户名：<input type="text" name="emember" value="<%=Entity.getNULL(emember) %>"></td>
	<td align="right">随行人员姓名：<input type="text" name="acconame" value="<%=Entity.getNULL(acconame) %>"></td>
	
		
		 
      <td colspan="10" align="left"><input type="submit" value="查询" /></td></tr>

</table>

<h2>列表&nbsp;(&nbsp;目前共有&nbsp;<font color="#000000" size="2"><%=count%></font>&nbsp;位随行人员&nbsp;)&nbsp;&nbsp;</h2>






<table border="0" CELLPADDING="0" CELLSPACING="0" id="tablecenter">
 <tr id="tableonetr">
  <td width="1"><input type='checkbox' id="checkall" name="checkall" onclick='CheckAll()' title="全选" style="cursor:pointer"></td>
     
      <td nowrap>用户名</td>
      <td nowrap>随行人员姓名</td>
      <td nowrap>随行人员性别 </td>
      <td nowrap>随行人员关系</td>
      <td nowrap>随行人员身份证号</td>
  
      
     
      <td>操作</td>
     

</tr>
<%


boolean a = true;

java.util.Enumeration eu = EventaccoMember.find(sql.toString(),pos,size);
if(!eu.hasMoreElements())
{
	out.print("<tr><td colspan=20 align=center>暂无记录</td></tr>");
	a = false;
}
for(int i=0;eu.hasMoreElements();i++)
{
	
 	int emid = ((Integer)eu.nextElement()).intValue();
 	EventaccoMember eobj = EventaccoMember.find(emid);
 	
 	Eventregistration erobj = Eventregistration.find(eobj.getEregid());
 	Profile p = Profile.find(erobj.getMember());
 	 
	tea.entity.util.Card cobj = tea.entity.util.Card.find(p.getProvince(teasession._nLanguage));
	
	String cname = cobj.toString2();

  %>
 <tr onMouseOver=bgColor="#BCD1E9" onMouseOut=bgColor="">  
 <td width=1><input type=checkbox name=checkeid value="<%=emid%>" style="cursor:pointer"></td>
    
    <td nowrap="nowrap"><%=erobj.getMember() %></td>
    <td nowrap="nowrap"><%=eobj.getAcconame() %></td>
    <td nowrap="nowrap"><%if(eobj.getSex()==0){out.print("男");}else{out.print("女");} %></td>
       <td nowrap="nowrap"><%=erobj.ACCOREL_TYPE[eobj.getAccorel()]%></td>
    <td nowrap="nowrap"><%=eobj.getCadr()%></td>
 
   
     
 <td>
    <a href="###" onclick="f_editAccom('<%=emid%>');">编辑</a>

    <a href="###" onclick="f_Delete('<%=emid%>');">删除</a>
 
    
    </td> 
  </tr> 
  <%
  }
  %>
  
  <%
  if(a)
  {
  
  %>
  
      <tr>
       <td colspan="2"><input type='checkbox' name="checkall2" id="checkall2" onclick='CheckAll2()' title="全选" style="cursor:pointer">&nbsp;全选/反选</td>
       <td colspan="4">
      
       
       &nbsp;<input type="button" value="删除" onClick="f_sub('delete','请选择您要删除的随行人员!');">
       
       
       
       </td>
        <td colspan="3" align="right">
      <%=new tea.htmlx.FPNL(teasession._nLanguage,request.getRequestURI()+param.toString()+"&pos=",pos,count,size)%>    
      </td> </tr>
      
      <%} %>
  </table>
</form>
</body>
</html>
