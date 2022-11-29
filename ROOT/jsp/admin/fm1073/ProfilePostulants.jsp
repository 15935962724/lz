<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.*"%><%@ page import="tea.ui.TeaSession"%><%@ page import="tea.resource.Resource"%><%@ page import = "tea.entity.member.*"%><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession = new TeaSession(request);
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
  return;
}

Resource r=new Resource("/tea/resource/ProfilePostulant");

StringBuffer sql=new StringBuffer();
StringBuffer param=new StringBuffer("?");
String _strId=request.getParameter("id");
param.append("community=").append(teasession._strCommunity).append("&id=").append(_strId);

String _strMember=request.getParameter("member");
if(_strMember!=null&&(_strMember=_strMember.trim()).length()>0)
{
  sql.append(" AND member LIKE ").append(DbAdapter.cite("%"+_strMember+"%"));
  param.append("&member=").append(java.net.URLEncoder.encode(_strMember,"UTF-8"));
}
String _strLastname=request.getParameter("lastname");
if(_strLastname!=null&&(_strLastname=_strLastname.trim()).length()>0)
{
  sql.append(" AND member IN (SELECT member FROM ProfileLayer WHERE firstname LIKE ").append(DbAdapter.cite("%"+_strLastname+"%")).append(" OR lastname=").append(DbAdapter.cite("%"+_strLastname+"%")).append(" )");
  param.append("&lastname=").append(java.net.URLEncoder.encode(_strLastname,"UTF-8"));
}

String _strStype=request.getParameter("stype");
if(_strStype!=null&&(_strStype).length()>0)
{
  sql.append(" AND stype=").append(_strStype);
  param.append("&stype=").append(_strStype);
}

String _strAuditing=request.getParameter("auditing");
if(_strAuditing!=null&&(_strAuditing).length()>0)
{
  sql.append(" AND auditing=").append(_strAuditing);
  param.append("&auditing=").append(_strAuditing);
}
param.append("&pos=");

int pos=0;
String _strPos=request.getParameter("pos");
if(_strPos!=null)
pos=Integer.parseInt(_strPos);

int count=ProfilePostulant.count(teasession._strCommunity,sql.toString());

%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script type="">
function f_load()
{
  form2.nexturl.value=document.location;

}
function f_action(a)
{
  if(window.Event)
  {
    form2.action=a;
  }else
  {
    form2.attributes[83].value=a;
  }
}
</script>
</head>
<body onload="f_load();">
<h1><%=r.getString(teasession._nLanguage, "志愿者管理")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<h2>查询</h2>
<form name="form1" action="?">
<input type=hidden name="community" value="<%=teasession._strCommunity%>">
<input type=hidden name="id" value="<%=_strId%>">

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr><td>会员ID:<input type="text" name="member" value="<%if(_strMember!=null)out.print(_strMember);%>"/></td>
  <td>姓名:<input type="text" name="lastname" value="<%if(_strLastname!=null)out.print(_strLastname);%>"/></td>
  <td>报名方式:<select name="stype" >
  <option value="">------------</option>
    <%
   for(int i=0;i< ProfilePostulant.SIGNUP_TYPE.length;i++)
   {
     out.print("<option value="+i);
     if(String.valueOf(i).equals(_strStype))
     out.print(" SELECTED ");
     out.print(" >"+r.getString(teasession._nLanguage,ProfilePostulant.SIGNUP_TYPE[i]));
   }
    %>  </select>
  </td>
  <td>状态:<select name="auditing" >
    <option value="">------------</option>
    <option value="1" <%if("1".equals(_strAuditing))out.print(" SELECTED ");%>>已审核</option>
    <option value="0" <%if("0".equals(_strAuditing))out.print(" SELECTED ");%>>未审核</option>
  </select>
  </td>
  <td><input type="submit" value="GO"/></td>
</tr>
</table>
</form>
<br>
<h2>列表(<%=count%>)</h2>
<form name="form2" action="?">
<input type="hidden" name="nexturl" value=""/>
<input type="hidden" name="member" value=""/>
<input type=hidden name="sql" value="<%=sql.toString()%>">
<input type=hidden name="act" value="">
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr ID=tableonetr>
<td width="1">&nbsp;</td>
<td>会员编号</td>
<td>会员ID</td>
<td>姓名</td>
<td>性别</td>
<td>E-Mail</td>
<td>电话/手机</td>
<td>报名方式</td>
<td>状态</td>
<td>报名时间</td>
<td></td>
</tr>
<%
java.util.Enumeration e=ProfilePostulant.find(teasession._strCommunity,sql.toString(),pos,25);
for(int index=1;e.hasMoreElements();index++)
{
  String member=(String)e.nextElement();
  Profile p=Profile.find(member);
  ProfilePostulant pp=ProfilePostulant.find(member,teasession._strCommunity);
%>
  <tr onMouseOver="javascript:this.bgColor='#BCD1E9';" onMouseOut="javascript:this.bgColor='';" >
  <td width="1"><%=index%></td>
  <td><%=pp.getCode()%>&nbsp;</td>
  <td><%=member%></td>
  <td><%=p.getLastName(teasession._nLanguage)+p.getFirstName(teasession._nLanguage)%></td>
  <td><%=p.isSex()?"男":"女"%></td>
  <td><%=p.getEmail()%></td>
  <td><%=p.getTelephone(teasession._nLanguage)+" "+p.getMobile()%></td>
  <td><%=r.getString(teasession._nLanguage,ProfilePostulant.SIGNUP_TYPE[pp.getStype()])%></td>
  <td><%=pp.isAuditing()?"已审核":"未审核"%></td>
  <td><%=p.getTime()%></td>
  <td>
  <input type="button" value="<%=r.getString(teasession._nLanguage,"CBEdit")%>" onclick="form2.act.value='bgedit';form2.member.value='<%=member%>';f_action('/jsp/admin/fm1073/EditProfilePostulant.jsp');form2.submit();">
  <input type="button" value="<%=r.getString(teasession._nLanguage,"CBDelete")%>" onclick="if(confirm('<%=r.getString(teasession._nLanguage,"ConfirmDelete")%>')){form2.act.value='delete';form2.member.value='<%=member%>';f_action('/servlet/EditProfilePostulant');form2.submit();}">
  <input type="button" value="<%=r.getString(teasession._nLanguage,"积分/审核/编号")%>" onclick="form2.member.value='<%=member%>';f_action('/jsp/admin/fm1073/EditProfilePostulant2.jsp');form2.submit();">
  </td>
<%
}
%>
<tr><td colspan="20" align="center"><%=new tea.htmlx.FPNL(teasession._nLanguage,param.toString(),pos,count)%></td></tr>
</table>

<input type="button" value="<%=r.getString(teasession._nLanguage,"CBExport")%>" onclick="form2.act.value='export';f_action('/servlet/EditProfilePostulant');form2.submit();">
<input type="button" value="<%=r.getString(teasession._nLanguage,"CBNew")%>" onclick="form2.act.value='bgreg';f_action('/jsp/admin/fm1073/EditProfilePostulant.jsp');form2.submit();">
</form>

<SCRIPT>document.form1.member.focus();</SCRIPT>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</html>



