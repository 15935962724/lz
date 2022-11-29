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

StringBuffer sql=new StringBuffer(),par = new StringBuffer();

int node = Integer.parseInt(teasession.getParameter("node"));
Meeting ym = Meeting.find(teasession._nNode,teasession._nLanguage);

sql.append(" AND ymi.node="+node);
par.append("?node="+node);
int state = 1;
if(teasession.getParameter("state")!=null && teasession.getParameter("state").length()>0)
{
	state = Integer.parseInt(teasession.getParameter("state"));
}
sql.append(" AND ymi.state="+state);
par.append("&state="+state);

String nexturl =  request.getRequestURI()+"?node="+teasession._nNode+"&state="+state;

int pos=0;
String tmp=request.getParameter("pos");
if(tmp!=null)pos=Integer.parseInt(tmp);

String unitname = request.getParameter("unitname");
if(unitname!=null&&unitname.length()>0){
  par.append("&unitname=").append(unitname);
  sql.append(" AND au.name like '%"+unitname+"%'");
}
par.append("&pos=");

int sum=MeetingInvite.count(sql.toString());
%><html>
<head>
<title>部门确认</title>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type=""></SCRIPT>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/mt.js" type=""></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript">

function CheckAll()
{
	var checkname=document.getElementsByName("checkall");   
	var fname=document.getElementsByName("checkmid");
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
	var fname=document.getElementsByName("checkmid");
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

//点击已确认和未确认按钮
function f_v(igd)
{
	form1.state.value=igd;
	form1.action='?';
	form1.submit();
}

//点击操作显示
function f_cz(igd,state)
{
	var trid = document.getElementById('trid_'+igd+'_'+state);
	if(trid.style.display=='')
	{
		trid.style.display='none';
	}
	else if(trid.style.display=='none')
	{
		trid.style.display='';
		
	}
}

//确认会员
function f_Verifg(igd)
{	
	var s = "您确定要操作确认吗";
	if(form1.state.value==2){
		s = "您确定要取消确认吗";
	}
	if(confirm(s)){
		form1.id.value=igd;
		form1.action="/servlet/EditMeetingInvite";
		form1.target="_ajax";
	    form1.act.value="WestracMeetingMemberListVerifg";
	    form1.submit();
		/* sendx("/jsp/admin/edn_ajax.jsp?act=WestracMeetingMemberListVerifg&id="+igd,
				 function(data)
				 {
			        data = data.trim();
			 		if(data=='true')
			 		{
			 			 alert("会议报名确认通过");
			 		}else if(data=='false')
				   {
			 			alert("会议报名取消确认");
				   }
				    form1.submit();
				 }
			 ); */
	}
}

//详细
function f_Wershow(adminunitid)
{
	 var y ='edge:raised;scroll:1;status:no;help:0;resizable:0;dialogWidth:930px;dialogHeight:610px;';
	 var url = '/jsp/type/meeting/WestracMeetingApplicantsInfo.jsp?adminunitid='+adminunitid;
	 var rs = window.showModalDialog(url,self,y);

}
//删除
function f_Delete(igd)
{
	if(confirm("您确定要删除这条记录吗？删除以后，不能恢复！")){
		form1.id.value=igd;
		form1.action="/servlet/EditMeetingInvite";
		form1.target="_ajax";
	    form1.act.value="WestracMeetingInviteListDelete";
	    form1.submit();
		/* sendx("/jsp/admin/edn_ajax.jsp?act=WestracMeetingInviteListDelete&id="+igd,
				 function(data)
				 {
			        data = data.trim(); 
			 		if(data=='true')
			 		{
			 			 alert("报名部门删除成功");
			 		}else
				   {
			 			alert("报名部门删除失败");
				   }
				    form1.submit();
				 }
				 );	 */
	}
}

//批量删除和确认
function f_sub(igd,strigd)
{
  if(submitCheckbox(form1.checkmid,strigd))
  {
		//删除
		if(igd=='delete')//
		{
			if(confirm('您确定要删除吗\n删除以后数据不能恢复？'))
			{
				form1.action='/servlet/EditMeetingInvite';
				form1.act.value='WestracInviteMemberListDeleteALL';
				form1.target="_ajax";
	    		form1.submit();
			}
		}else if(igd=='verifg')
		{
			//
			if(confirm('您确定要操作吗？'))
			{
				form1.action='/servlet/EditMeetingInvite';
				form1.act.value='WestracMeetingMemberListVerifgALL';
				form1.target="_ajax";
	    		form1.submit();
			}
			
		}
     }
}
function exportReportExcel(){
	form1.action='/servlet/EditMeetingInvite';
	form1.act.value="exportReportExcel";
	form1.submit();
}

mt.refresh=function(url){
	window.location.href=url;
};
</SCRIPT>
</head>
<BODY id="bodynone">
<div id="wai">
<!-- <h1>部门确认</h1> -->
<div id="head6"><img height="6" alt=""></div>

<form name="form1" action="?" method="POST">
<input type=hidden name="node" value="<%=node%>"/>
<input type=hidden name="id"/><!-- 会议邀请部门信息id -->
<input type=hidden name="community" value="<%=teasession._strCommunity%>"/>
<input type=hidden name="state"/>
<input type=hidden name="act"/>
<input type=hidden name="nexturl" value="<%=nexturl%>"/>
<h2>查询</h2>
<table cellSpacing="0" cellPadding="0" width="100%" border="0" id="tablecenter">
<tr>
  <td colspan="2" align="left"><%=r.getString(teasession._nLanguage, "Name")%><input id="unitname" name="unitname" value="<%if(unitname!=null)out.print(unitname);%>"/>
  <td><input type="submit" value="查询"/></td>
</tr>
</table>

<h2>列表&nbsp;(&nbsp;目前共有&nbsp;<font color="#000000" size="2"><%=sum%></font>&nbsp;报名单位&nbsp;)&nbsp;&nbsp;</h2>
<h2>
<a href ="###" onclick="f_v('1')">未确认</a>
<a href ="###" onclick="f_v('2')">已确认</a>
</h2>
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
  ArrayList ymiList = MeetingInvite.find(sql.toString()+" ORDER BY ymi.time",pos,15);
  for(int i=0;i<ymiList.size();i++)
  {
	MeetingInvite ymi = (MeetingInvite)ymiList.get(i);
    AdminUnit obj=AdminUnit.find(ymi.getAdminunitid());
    String tel = "";
    if(obj.getTel()!=null){
      tel = obj.getTel();
    }
    
    out.write("<tr onMouseOver=bgColor='#BCD1E9' onMouseOut=bgColor=''>");
    out.write("<td width=1><input type=checkbox name=checkmid id='checkmid' value='"+ymi.getId()+"' style='cursor:pointer'></td>");
    out.write("<td>"+obj.getPrefix()+obj.getName());
    out.write("<td align=center>&nbsp;"+tel);
    out.write("<td align=center>&nbsp;"+obj.getFax());
    out.write("<td nowrap>");
    out.write(" <a href='###' onClick=f_cz("+ymi.getId()+","+state+"); >操作</a>");

    out.write("<tr id='trid_"+ymi.getId()+"_1' style='display:none'><td colspan='5' align='right'>");
    out.write(" <a href='###'  onclick=f_Wershow("+obj.getId()+");>详细</a>");
    if(ym.getTimeHoldStop().getTime()>=new Date().getTime()){
	    out.write(" <a href='###' onClick=f_Verifg('"+ymi.getId()+"'); >确认</a>");
	    out.write(" <a href='###' onclick='f_Delete("+ymi.getId()+");'>删除</a>");
    }
    out.write("<tr id='trid_"+ymi.getId()+"_2' style='display:none'><td colspan='5' align='right'>");
    out.write(" <a href='###'  onclick=f_Wershow("+obj.getId()+");>详细</a>");
    if(ym.getTimeHoldStop().getTime()>=new Date().getTime()){
	    out.write(" <a href='###' onClick=f_Verifg('"+ymi.getId()+"'); >取消确认</a>");
	    out.write(" <a href='###' onclick='f_Delete("+ymi.getId()+");'>删除</a>");
    }
    out.write("");
    out.write("");
    out.write("");
  }
  out.write("<tr onMouseOver=bgColor='#BCD1E9' onMouseOut=bgColor=''>");
  out.write("<td colspan='2'><input type='checkbox' name='checkall2' id='checkall2' onclick='CheckAll2()' title='全选' style='cursor:pointer'>&nbsp;全选/反选</td>");
  out.write("<td colspan='3'>");
  if(state==1){
	  out.write("<input type=button value='确认' onclick=f_sub('verifg','请选中要确认的部门');>");
  }else if(state==2){
	  out.write("<input type=button value='导出报表' onclick=exportReportExcel();>");
	  out.write("<input type=button value='取消确认' onclick=f_sub('verifg','请选中要确认的部门');>");
  }
  out.write("<input type=button value='删除' onclick=f_sub('delete','请选择您要删除的部门');>");
  out.write("</td></tr>");
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
