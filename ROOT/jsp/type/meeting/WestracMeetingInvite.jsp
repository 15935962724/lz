<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="java.io.*" %>
<%@page import="java.util.*" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.resource.Resource" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.ui.TeaSession" %>
<%@page import="tea.entity.node.MeetingInvite"%>
<%@page import="tea.entity.node.Meeting"%>
<% request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}


Resource r=new Resource("/tea/resource/unitlist");

int root=AdminUnit.getRootId(teasession._strCommunity);

int pos=0;
String tmp=request.getParameter("pos");
if(tmp!=null)pos=Integer.parseInt(tmp);

StringBuffer par=new StringBuffer();
StringBuffer sql = new StringBuffer();
par.append("?community=").append(teasession._strCommunity);
String unitname = request.getParameter("unitname");
if(unitname!=null&&unitname.length()>0){
  par.append("&unitname=").append(unitname);
  sql.append(" AND name like '%"+unitname+"%'");
}
par.append("&pos=");

int sum=Meeting.countByCommunity(teasession._strCommunity,sql.toString());
%><html>
<head>
<title>部门邀请</title>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type=""></SCRIPT>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/mt.js" type=""></SCRIPT>
<script>var pmt=parent.mt;</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript">
function f_edit(obj,id)
{
  form2.action="/jsp/admin/popedom/EditAdminUnit.jsp";
  form2.method="get";
  form2.adminunit.value=id;
  form2.nexturl.value=location;
  obj.disabled=true;
  obj.value="Load...";
  form2.submit();
}

function CheckAll()
{
	var checkname=document.getElementsByName("checkall");   
	var fname=document.getElementsByName("adminunitidorder");
	var lname=""; 
	if(checkname[0].checked){
	    for(var i=0; i<fname.length; i++){
	    	if(fname[i].disabled==false)
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
	var fname=document.getElementsByName("adminunitidorder");
	var lname=""; 
	if(checkname[0].checked){
	    for(var i=0; i<fname.length; i++){ 
	    	if(fname[i].disabled==false)
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
/* function f_invite(igd)
{

	 var y ='edge:raised;scroll:0;status:no;help:0;resizable:0;dialogWidth:630px;dialogHeight:280px;';
	 var url = '/jsp/type/meeting/WestracMeetingInvite2.jsp?t='+new Date().getTime()+"&node="+form2.node.value+"&adminunitid="+encodeURIComponent("/"+igd+"/");
	 var rs = window.showModalDialog(url,self,y);	
		
}  */
function f_invite(obj,igd)
{
	if(confirm('是否确定邀请？'))
	{
		obj.disabled=true;
		obj.value="Load...";
		obj.disabled
		form2.adminunits.value=igd+"/";
		form2.act.value="invite";
		form2.nexturl.value=location;
		form2.submit();
	}
		
}
function f_inviteDel(obj,igd)
{
	if(confirm('是否确定取消邀请？'))
	{
		obj.disabled=true;
		obj.value="Load...";
		obj.disabled
		form2.miid.value=igd;
		form2.act.value="inviteDel";
		form2.nexturl.value=location;
		form2.submit();
	}
		
}
function f_inviteall()
{
	if(submitCheckbox(form2.adminunitidorder,"请选择要邀请的部门"))
	{
		var fname=document.getElementsByName("adminunitidorder");
		var lname="";

		for(var i=0; i<fname.length; i++)
		{
			if( fname[i].checked==true){
				lname = lname + fname[i].value+"/"; 
			}
		}
		form2.adminunits.value=lname;
		form2.act.value="invite";
		form2.nexturl.value=location;
		form2.submit();
	}
}
mt.refresh=function(url){
	window.location.href=url;
};
</SCRIPT>
</head>
<BODY id="bodynone">
<div id="wai">
<!-- <h1>部门邀请</h1> -->
<div id="head6"><img height="6" alt=""></div>

<form name="form1" action="?">
<input type="hidden" name="node" value="<%=teasession._nNode %>"/>
<h2>查询</h2>
<table cellSpacing="0" cellPadding="0" width="100%" border="0" id="tablecenter">
<tr>
  <td colspan="2" align="left"><%=r.getString(teasession._nLanguage, "Name")%><input id="unitname" name="unitname" value="<%if(unitname!=null)out.print(unitname);%>"/>
  <td><input type="submit" value="查询"/></td>
</tr>
</table>
</form>


<form name="form2" method="post" action="/servlet/EditMeetingInvite" target="_ajax">
<input type="hidden" name="node" value="<%=teasession._nNode %>"/>
<input type=hidden name="community" value="<%=teasession._strCommunity%>"/>
<input type=hidden name="adminunits" value="0">
<input type=hidden name="miid" value="0">
<input type=hidden name="act" value="invite"/>
<input type=hidden name="nexturl"/>
<input type=hidden name="sequence" />
<h2>列表 <%=sum%></h2>
<table cellSpacing="0" cellPadding="0" width="100%" border="0" id="tablecenter">
  <tr id="tableonetr">
    <td width="1"><input type='checkbox' id="checkall" name="checkall" onclick='CheckAll()' title="全选" style="cursor:pointer"></td>
    <td><%=r.getString(teasession._nLanguage, "Name")%></td>
    <td><%=r.getString(teasession._nLanguage, "Telephone")%></td>
    <td><%=r.getString(teasession._nLanguage, "Fax")%></td>
    <td><%=r.getString(teasession._nLanguage, "operation")%></td>
  </tr>
<%
if(sum>0)
{
  int last=0;
  Enumeration e = Meeting.findByCommunity(teasession._strCommunity,sql.toString()+" ORDER BY seq",pos,15);
  for(int i=1;e.hasMoreElements();i++)
  {
    AdminUnit obj=(AdminUnit)e.nextElement();
    int id=obj.getId();
    String tel = "";
    if(obj.getTel()!=null){
      tel = obj.getTel();
    }
    MeetingInvite ymi = MeetingInvite.find(teasession._nNode,id);
    out.write("<tr onMouseOver=bgColor='#BCD1E9' onMouseOut=bgColor=''>");
    out.write("<td width=1><input type=checkbox name=adminunitidorder id='adminunitidorder' "+(ymi!=null&ymi.isExist()?"disabled='disabled'":"")+" value='"+id+"' style='cursor:pointer'></td>");
    out.write("<td>"+obj.getPrefix()+obj.getName());
    out.write("<td align=center>&nbsp;"+tel);
    out.write("<td align=center>&nbsp;"+obj.getFax());
    if(ymi!=null&ymi.isExist())
    	//out.write("<td nowrap>已邀请</td>");
    	out.write("<td nowrap> <a href='###' onClick=f_inviteDel(this,'"+ymi.getId()+"'); >取消邀请</a></td>");
    else
    	out.write("<td nowrap> <a href='###' onClick=f_invite(this,'"+id+"'); >邀请</a></td>");
  }
  out.print("<tr><td></td>");
  out.print("<td colspan='4'><input type='checkbox' name='checkall2' id='checkall2' onclick='CheckAll2()' title='全选' style='cursor:pointer'>&nbsp;全选/反选&nbsp;&nbsp;");
  out.print("<input type='button' value='邀请选中部门' onClick='f_inviteall();'>&nbsp;");
  out.print("</td>");
  out.print("</tr>");
    
  
  if(sum>15)out.print("<tr><td colspan='5' align='right'>"+new tea.htmlx.FPNL(teasession._nLanguage,par.toString(),pos,sum,15)+"</td></tr>");
}else
{
  out.print("<tr><td colspan='5' align='center'>暂无部门或部门中没有添加用户");
}

%>
</table>
</form>
<br>
<div id="head6"><img height="6" alt=""></div>
<%--<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>--%>
</div>
</body>
</html>
