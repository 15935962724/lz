<%@page contentType="text/html;charset=UTF-8"%>
<%@include file="/jsp/Header.jsp"%>
<%

  /*if (!tea.entity.util.Safety.find(teasession._rv.toString(),5).isExists()&&!teasession._rv.toString().equalsIgnoreCase("admin") && !License.getInstance().getWebMaster().equals(teasession._rv.toString()))
  {
    response.sendError(403);
    return;
  }*/

StringBuffer sql=new StringBuffer();
StringBuffer param=new StringBuffer();

String _strId=request.getParameter("id");
param.append("?community=").append(teasession._strCommunity);
param.append("&id=").append(_strId);

String q=request.getParameter("q");
if(q!=null&&(q=q.trim()).length()>0)
{
  sql.append(" AND vmember LIKE ").append(DbAdapter.cite("%"+q+"%"));
  param.append("&q=").append(java.net.URLEncoder.encode(q,"UTF-8"));
}

String name=request.getParameter("name");
if(name!=null&&(name=name.trim()).length()>0)
{
  sql.append(" AND vmember IN ( SELECT member FROM ProfileLayer WHERE lastname LIKE "+DbAdapter.cite("%"+name+"%")+" OR firstname LIKE "+DbAdapter.cite("%"+name+"%")+")");
  param.append("&name=").append(java.net.URLEncoder.encode(name,"UTF-8"));
}

String email=request.getParameter("email");
if(email!=null&&(email=email.trim()).length()>0)
{
  sql.append(" AND vmember IN ( SELECT member FROM Profile WHERE email LIKE "+DbAdapter.cite("%"+email+"%")+")");
  param.append("&email=").append(email);
}
param.append("&pos=");

String act=request.getParameter("act");
if("delete".equals(act))
{
  //Subscriber s = Subscriber.find(teasession._strCommunity, new RV(member));
  //s.delete();
  //删除权限
  String member=request.getParameter("member");
  for(int i=1;i<10;i++)
  {
    Safety safety=Safety.find(member,teasession._strCommunity,i);
    safety.delete();
  }
}

//" AND s.vmember NOT IN(SELECT member FROM AdminUsrRole WHERE role!='/' AND teasession._strCommunity="+DbAdapter.cite(teasession._strCommunity)+")"



//只列出有权限的会员
sql.append(" AND vmember IN ( SELECT member FROM Safety WHERE community="+DbAdapter.cite(teasession._strCommunity)+")");

r.add("/tea/ui/member/community/Subscribers");
r.add("/tea/ui/member/community/Communities");
r.add("/tea/resource/NetDisk");

String s1 = request.getParameter("pos");
int pos = s1 == null ? 0 : Integer.parseInt(s1);

int count=Subscriber.count(teasession._strCommunity,sql.toString());

%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script>
function f_edit(v)
{
  form2.action="/jsp/netdisk/NetDiskNewUser2.jsp";
  if(v)
  {
    form2.member.value=v;
  }else
  {
    form2.member.disabled=true;
  }
  form2.nexturl.value=location;
  form2.submit();
}
function f_delete(v)
{
  if(confirm('<%=r.getString(teasession._nLanguage, "ConfirmDelete")%>'))
  {
   form2.action="?"
   form2.act.value="delete";
   form2.member.value=v;
   form2.submit();
  }
}
</script>
</head>
<body>
 <h1><%=r.getString(teasession._nLanguage, "Subscriber")%></h1>
  <div id="head6"><img height="6" src="about:blank"></div>
<br>

<h2>查询</h2>
<form name="form1" action="?" method="get">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="id" value="<%=_strId%>"/>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr><td><%=r.getString(teasession._nLanguage, "MemberId")%>:<input name="q" value="<%if(q!=null)out.print(q);%>" ></td>
<td><%=r.getString(teasession._nLanguage, "Name")%>:<input name="name" value="<%if(name!=null)out.print(name);%>" ></td>
<td>E-Mail:<input name="email" value="<%if(email!=null)out.print(email);%>" ></td>
<td><input type="submit" value="GO"/></td>
</tr>
</table>
</form>

<h2><%="列表 ( "+count+" )"%></h2>
<form name="form2" action="?" method="get">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="id" value="<%=_strId%>"/>
<input type="hidden" name="member" />
<input type="hidden" name="act"/>
<input type="hidden" name="nexturl"/>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<TR id="tableonetr">
    <td nowrap><%=r.getString(teasession._nLanguage, "MemberId")%></td>
    <td nowrap><%=r.getString(teasession._nLanguage, "Name")%></td>
    <td nowrap>E-Mail</td>
    <td nowrap><%=r.getString(teasession._nLanguage, "Telephone")%></td>
    <td nowrap><%=r.getString(teasession._nLanguage, "operation")%></td>
  </tr>
 <%
 Enumeration e=Subscriber.find(teasession._strCommunity,sql.toString(),pos,25);
 while(e.hasMoreElements())
 {
   RV rv = (RV)e.nextElement();
   String s2=rv._strV;
   Profile profile = Profile.find(s2);
   email=profile.getEmail();
   %>
  <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    <td nowrap><%=s2%></td>
    <td nowrap><%=profile.getLastName(teasession._nLanguage)+profile.getFirstName(teasession._nLanguage)%></td>
    <td nowrap><A HREF="mailto:<%=email%>"><%=getNull(email)%></A></td>
    <td nowrap><%=getNull(profile.getTelephone(teasession._nLanguage))%></td>
    <td nowrap><input type="button" onclick="f_edit('<%=s2%>');" value="<%=r.getString(teasession._nLanguage, "CBEdit")%>">
      <input type="button" onclick="f_delete('<%=s2%>');" value="<%=r.getString(teasession._nLanguage, "CBDelete")%>">
    </td>
  </tr>
<%
}
%>
<tr><td colspan="6" align="center"><%=new FPNL(teasession._nLanguage, param.toString(), pos,count)%></td></tr>

</table>

<input type="button" value="<%=r.getString(teasession._nLanguage, "NewUser")%>" onClick="f_edit();">
<input type="button" value="<%=r.getString(teasession._nLanguage, "添加已存在用户")%>" onClick="window.open('/jsp/netdisk/NetDiskOldUser.jsp?community=<%=teasession._strCommunity%>','','height=170px,width=400px,left=250,top=150,resizable=no,scrollbars=no,toolbar=no,location=no,directories=no,status=no,menubar=no');">
</form>

<br>
<div id="head6"><img height="6" src="about:blank"></div>
  <div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</html>
