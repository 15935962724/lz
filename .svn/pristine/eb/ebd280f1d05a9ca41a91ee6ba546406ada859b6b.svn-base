<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.entity.photography.*"%><%@page import="tea.ui.*"%><%@page import="tea.entity.node.*"%><%@page import="tea.html.*"%>
<%@page import="tea.db.*"%><%@page import="tea.entity.member.*"%><%@page import="tea.resource.*"%><%@page import="java.util.*"%><%@page import="java.io.*"%>
<%@page import="java.net.URLEncoder"%><%@page import="tea.entity.Entity"%><%@page import="tea.entity.qcjs.*" %>

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





String nexturl = request.getRequestURL() + "?node="+teasession._nNode + request.getContextPath();

StringBuffer sql = new StringBuffer();
StringBuffer param = new StringBuffer();
param.append("?id=").append(request.getParameter("id"));


String name = teasession.getParameter("name");
if(name!=null && name.length()>0){
	name = name.trim();
	sql.append(" and name like ").append(DbAdapter.cite("%"+name+"%"));
	param.append("&name=").append(URLEncoder.encode(name,"UTF-8"));
}
String card = teasession.getParameter("card");
if(card!=null && card.length()>0){
	card = card.trim();
	sql.append(" and card like ").append(DbAdapter.cite("%"+card+"%"));
	param.append("&card=").append(card);
}



String time_c = teasession.getParameter("time_c");
if(time_c!=null && time_c.length()>0)
{
  sql.append(" AND registratime >=").append(DbAdapter.cite(time_c));
  param.append("&time_c=").append(time_c);
}
String time_d = teasession.getParameter("time_d");
if(time_d!=null && time_d.length()>0)
{
  sql.append(" AND registratime <=").append(DbAdapter.cite(time_d));
  param.append("&time_d=").append(time_d);
}
String archives = teasession.getParameter("archives");
if(archives!=null && archives.length()>0){
	archives = archives.trim();
	sql.append(" and archives like ").append(DbAdapter.cite("%"+archives+"%"));
	param.append("&archives=").append(archives);
}

int sex = -1;
if(teasession.getParameter("sex")!=null&&teasession.getParameter("sex").length()>0){

	sex = Integer.parseInt(teasession.getParameter("sex"));
	if(sex!=-1){

		sql.append(" and sex = ").append(sex);
		param.append("&sex=").append(sex);
	}
}
String drivers = teasession.getParameter("drivers");
if(drivers!=null && drivers.length()>0){
	drivers = drivers.trim();
	sql.append(" and drivers like ").append(DbAdapter.cite("%"+drivers+"%"));
	param.append("&drivers=").append(drivers);
}




int pos = 0, size = 15, count = 0;
if (request.getParameter("pos") != null) {
  pos = Integer.parseInt(request.getParameter("pos"));
}

count =QcMember.count(teasession._strCommunity,sql.toString());

 sql.append(" order by times desc ");

%>

<html>
<head>
<title>会员管理</title>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<link href="/tea/tea.css" rel="stylesheet" type="text/css"/>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/Calendar.js" type="text/javascript"></script>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

</head>
<body >
<script type="text/javascript">
function CheckAll()
{
	var checkname=document.getElementsByName("checkall");
	var fname=document.getElementsByName("mid");
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

function f_delete()
{
  if(submitCheckbox(form1.mid,'请选择你要删除的数据!'))
  {
		  if(confirm('您确定要删除选中会员吗？'))
			{
				form1.action='/servlet/EditQcMember';
				form1.act.value='delete';
				form1.nexturl.value=location.pathname+location.search;
	    		form1.submit();
			}
  }
}
</script>
<h1>会员管理</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form action="?" name="form1" method="POST" >

<input type="hidden" name="nexturl" value="<%=nexturl %>"/>
<input type="hidden" name="id" value="<%=request.getParameter("id") %>"/>
<input type="hidden" name="act" >

<h2>查询</h2>

 <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
	<tr>
		<td align="right">姓名：</td>
		<td><input type="text" name="name" value="<%=Entity.getNULL(name) %>"/></td>
		<td align="right">驾驶证号：</td>
		<td><input type="text" name="card" value="<%=Entity.getNULL(card) %>"/></td>
	</tr>
	<tr>
		<td align="right">报名时间：</td>
		<td>
	        从&nbsp;
	        <input id="time_c" name="time_c" size="7" style="cursor:pointer"  onclick="new Calendar().show('form1.time_c');"  value="<%if(time_c!=null)out.print(time_c);%>" readonly="readonly">
	        <img style="margin-bottom:-8px;" style="cursor:pointer"  src="/tea/image/bbs_edit/table.gif" onclick="new Calendar().show('form1.time_c');" />
	        &nbsp;到&nbsp;
	        <input id="time_d" name="time_d" size="7" style="cursor:pointer" onclick="new Calendar().show('form1.time_d');"   value="<%if(time_d!=null)out.print(time_d);%>" readonly="readonly">
	        <img style="margin-bottom:-8px;" style="cursor:pointer"  src="/tea/image/bbs_edit/table.gif" onclick="new Calendar().show('form1.time_d');" />
	</td>
		<td align="right">档案编号：</td>
		<td><input type="text" name="archives" value="<%=Entity.getNULL(archives) %>"/></td>

	</tr>
	<tr>
	<td align="right">性别：</td>
		<td>
			<select name="sex">
				<option value="-1">-性别-</option>
				<option value="0" <%if(sex==0)out.print(" selected "); %>>-男-</option>
				<option value="1" <%if(sex==1)out.print(" selected "); %>>-女-</option>
			</select>
		</td>
		<td colspan="2"><input type="submit" value="查询"/></td>

	 </tr>

 </table>

<h2>会员列表&nbsp;(&nbsp;目前共有&nbsp;<font color="#000000" size="3"><%=count %></font>&nbsp;位会员&nbsp;)&nbsp;</h2>
<h2>

<input type="button" value="　增加　" onclick="window.open('/jsp/qcjs/EditMember.jsp?nexturl='+encodeURIComponent(location.href),'_self');">&nbsp;
<input type="button" value="　删除　" onclick="f_delete();">&nbsp;

 </h2>

  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr id=tableonetr>
      <td width="1"><input type='checkbox' name="checkall" onclick='CheckAll()' title="全选" style="cursor:pointer"></td>
	       <td nowrap>姓名</td>
	       <td nowrap>性别</td>
	       <td nowrap>驾驶证号</td>
	       <td nowrap>报名时间</td>
	       <td nowrap>档案编号</td>
	       <td nowrap>操作</td>
    </tr>

 <%
 	 Enumeration e = QcMember.find(teasession._strCommunity,sql.toString(),pos,size);
	 if(!e.hasMoreElements())
	 {
	     out.print("<tr><td colspan=10 align=center>暂无记录</td></tr>");
	 }
 	for(int i=1;e.hasMoreElements();i++){
 		int mid = ((Integer)e.nextElement()).intValue();
 		QcMember mobj = QcMember.find(mid);
 %>

    <tr onmouseover=bgColor='#BCD1E9'; onmouseout=bgColor=''; >
  	 <td width=1><input type=checkbox name=mid value="<%=mid%>" style="cursor:pointer"></td>
  	 <td><%=mobj.getName() %></td>
  	 <td><%if(mobj.getSex()==0){out.print("男");}else{out.print("女");} %></td>
  	 <td><%=mobj.getCard() %></td>
  	 <td><%if(mobj.getRegistratime()!=null)out.print(Entity.sdf.format(mobj.getRegistratime())); %></td>
  	 <td><%=mobj.getArchives() %></td>
  	 <td>
  	 <a href="/jsp/qcjs/MemberShow.jsp?mid=<%=mid %>&nexturl=<%=nexturl %>">详细</a>
  	 <a href="/jsp/qcjs/EditMember.jsp?mid=<%=mid %>&nexturl=<%=nexturl %>">编辑</a></td>
    </tr>

    <%} %>
<%if (count > size) {  %>
      <tr> <td colspan="20"><%=new tea.htmlx.FPNL(teasession._nLanguage,request.getRequestURI()+param.toString()+"&pos=",pos,count,size)%>    </td> </tr>
      <%}  %>
  </table>
</form>
</body>
</html>
