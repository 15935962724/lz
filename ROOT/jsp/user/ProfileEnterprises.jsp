<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>
<%
String community=teasession._strCommunity;

String strId=request.getParameter("id");
StringBuffer sql=new StringBuffer();
StringBuffer param=new StringBuffer();
param.append("?id=").append(strId);
param.append("&community=").append(community);

String member=request.getParameter("member");
String valid=request.getParameter("valid");
String name=request.getParameter("name");
String linkman=request.getParameter("linkman");


if(member!=null&&member.length()>0)
{
	sql.append(" AND pe.member LIKE ").append(DbAdapter.cite("%"+member+"%"));
	param.append("&member=").append(java.net.URLEncoder.encode(member,"UTF-8"));
}
if(valid!=null&&valid.length()>0)
{
	switch(Integer.parseInt(valid))
	{
		case 1:
		sql.append(" AND pe.valid IS NULL");
		break;
		case 2:
		sql.append(" AND pe.valid>GETDATE()");
		break;
		case 3:
		sql.append(" AND pe.valid<GETDATE()");
		break;
	}
	param.append("&valid=").append(valid);
}
if(name!=null&&name.length()>0)
{
	sql.append(" AND pe.name LIKE ").append(DbAdapter.cite("%"+name+"%"));
	param.append("&name=").append(java.net.URLEncoder.encode(name,"UTF-8"));
}
if(linkman!=null&&linkman.length()>0)
{
	sql.append(" AND pe.linkman LIKE ").append(DbAdapter.cite("%"+linkman+"%"));
	param.append("&linkman=").append(java.net.URLEncoder.encode(linkman,"UTF-8"));
}
param.append("&pos=");

int count=ProfileEnterprise.count(community,sql.toString());

int pos=0,pagesize=20;
String tmp=request.getParameter("pos");
if(tmp!=null)
{
  pos=Integer.parseInt(tmp);
}


%><html>
<head>
<link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT SRC="/tea/tea.js" type="text/javascript"></SCRIPT>
<script>
function fsubmit()
{
  for(var i=0;i<form2.members.length;i++)
  {
    if(form2.members[i].checked)
    return true;
  }
  window.alert('请选中要操作的会员');
  return false;
}
function fallstarturl(allstarturl)
{
  for(var counter=0;counter<form2.elements.length;counter++)
  if(form2.elements[counter].type=='text')
  form2.elements[counter].value=allstarturl.value;
}
</script>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "Auditing")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<h2>查询</h2>
<form name="form1" method="POST" action="?">
<input type="hidden" name="community" value="<%=community%>">
<input type="hidden" name="id" value="<%=strId%>">

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr><td>会员ID:<input type="text" name="member" value="<%if(member!=null)out.print(member);%>"></td>
    <td>状态:<select name="valid">
      <option value="">----------------
      <option value="1">未审核
      <option value="2">已审核
      <option value="3">已过期
</select></td>
<td>公司名称:<input type="text" name="name" value="<%if(name!=null)out.print(name);%>"></td>
<td>联系人:<input type="text" name="linkman" value="<%if(linkman!=null)out.print(linkman);%>"></td>
<td><input type="submit" value="GO"></td>
</tr>
</table>
</form>


<h2>列表-<%=count%></h2>
<form name="form2" method="POST" onSubmit="return fsubmit();">
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr id="tableonetr">
    <td ></td>
    <td >会员ID</td>
    <td><input type="text" onKeyUp="this.onchange();" onChange="fallstarturl(this);" value="<%=r.getString(teasession._nLanguage, "StartUrl")%>"/></td>
    <td>状态</td>
    <td>有效期</td>
    <td>公司名称</td>
    <td>联系人</td>
    <td>注册时间</td>
  </tr>
<%
Enumeration e = ProfileEnterprise.find(community,sql.toString(),pos,pagesize);
for(int show=0; e.hasMoreElements();show++)
{
  member=(String)e.nextElement();
  Profile profile=Profile.find(member);
  ProfileEnterprise pe = ProfileEnterprise.find(member,community);
  %>
  <tr onmouseover="javascript:this.bgColor='#BCD1E9'" onmouseout="javascript:this.bgColor=''" >
    <td width="1"><input id="CHECKBOX" type="CHECKBOX" name="members" value="<%=member%>"></td>
      <td ><a href="/jsp/user/EnterpriseView.jsp?member=<%=java.net.URLEncoder.encode(member,"UTF-8")%>"><%=member%></a></td>
      <td><input type="text" class="edit_input" name="starturl" value="<%=getNull(profile.getStartUrl(teasession._nLanguage))%>"/></td>
      <td><%
      if(pe.getValid()==null)
      {
        out.print("未审核");
      }else if(pe.getValid().getTime()<System.currentTimeMillis())
      {
        out.print("已过期");
      }else
      {
        out.print("已审核");
      }
      %></td>
      <td><%=pe.getValidToString()%></td>
      <td><%=pe.getName()%></td>
      <td><%=pe.getLinkman()%></td>
      <td><%=pe.sdf2.format(profile.getTime())%></td>
  </tr>
<% }%>
<tr><td colspan="2"><input  id="CHECKBOX" type="CHECKBOX" onClick="selectAll(form2.members,this.checked);">全选</td>
<td colspan="5" align="center"><%=new FPNL(teasession._nLanguage, param.toString(), pos, count,pagesize)%></td>
</tr>
</table>

<input type="submit" onClick="form2.action='/jsp/user/EditProfileEnterpriseValid.jsp';"  class="edit_button" name="auditing" value="<%=r.getString(teasession._nLanguage, "Auditing")%>"/>
<input type="submit" onClick="form2.action='/jsp/user/SendEmailToEnterprise.jsp';" name="delete" class="edit_button" value="<%=r.getString(teasession._nLanguage, "CBDeny")%>"/>
</form>

<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</html>
