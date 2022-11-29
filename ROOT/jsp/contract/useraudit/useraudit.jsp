<%@page contentType="text/html;charset=UTF-8" %><%@ page import="java.util.*" %>
<%@ page import="tea.entity.member.*" %>
<%@page import="tea.entity.admin.*" %>
<%@ page import="tea.db.DbAdapter" %>
<%@ page  import="tea.resource.Resource" %>
<%@ page import="tea.entity.node.*" %>
<%@ page import="tea.ui.TeaSession" %>
<%
request.setCharacterEncoding("UTF-8");
TeaSession teasession=new TeaSession(request);
int role=0;
int group=0;
int role2=0;
int group2=0;
String temp=null;
String member = request.getParameter("member");

temp= request.getParameter("role");
if(temp!=null&&temp.length()>0){
  role=Integer.parseInt(temp);
}
temp=request.getParameter("group");
if(temp!=null&&temp.length()>0){
group=Integer.parseInt(temp);
}
temp= request.getParameter("role2");
if(temp!=null&&temp.length()>0){
  role2=Integer.parseInt(temp);
}

temp=request.getParameter("group2");
if(temp!=null&&temp.length()>0){
group2=Integer.parseInt(temp);
}
//out.print(role+"role");
//out.print(group+"group");
//out.print(request.getRequestURI());
String nexturl =null;
String id =teasession.getParameter("id");
if("shenhe".equals(request.getParameter("act")))
{
  //System.err.print("****"+role+"##"+group);
  if(role!=0&&group!=0){

    AdminUsrRole.create(teasession._strCommunity,member,"/"+role,"/",0,"/"+group,"/");
    if(request.getParameter("flag")!=null){
      role=role2;
      group=group2;
    }
    nexturl=request.getRequestURI()+"?role="+role+"&group="+group+"&"+request.getContextPath();
    response.sendRedirect("/jsp/info/Succeed.jsp?info=" + java.net.URLEncoder.encode("审核成功!", "UTF-8")+"&nexturl="+java.net.URLEncoder.encode(nexturl,"UTF-8"));
    return;
  }else{
    response.sendRedirect("/jsp/contract/useraudit/audit1.jsp?group="+group+"&role="+role);
    return;
  }
}

StringBuffer param = new StringBuffer("?community=" + teasession._strCommunity);
StringBuffer sql=new StringBuffer();
sql.append(" and community=").append(DbAdapter.cite( teasession._strCommunity));
sql.append(" and member not in(select member from adminusrrole where community=");
sql.append(DbAdapter.cite(teasession._strCommunity)).append(")");
//out.print(sql.toString());
int pos=0;
String tmp=request.getParameter("pos");
if(tmp!=null)
{
  pos=Integer.parseInt(tmp);
}
param.append("&id=").append(id);
param.append("&pos=");
int count=Profile.count(sql.toString());

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>
<body>
<script type="">
function f_shenhe(igd,ign)
{
  var role=form1.role.value;
 var group=form1.group.value;

  if(role!=0&&group!=0){
    if(confirm("是否把"+ign+"审核为<%if(role!=0){out.print(AdminRole.find(role).getName());}%>")){
      form1.member.value = igd;
      form1.act.value ='shenhe';
      form1.action ="?";
      form1.submit();
    }
  }else{
    //alert(ign);
    window.location.href="/jsp/contract/useraudit/audit1.jsp?group="+group+"&role="+role+"&name="+encodeURIComponent(ign)+"&member="+encodeURIComponent(igd);
  }

}
</script>
<form action="?" name="form1" method="POST">
<input type="hidden" name="member"  />
<input type="hidden" name="act"  />
<input type="hidden" name="id"  value="<%=id%>" />
<input type="hidden" name="nexturl" value="<%=nexturl%>"/>
<input type="hidden" name="role" value="<%=role%>"  />
<input type="hidden" name="group" value="<%=group%>"/>
<h1>
用户审核
</h1>
<table  border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr>
<td>用户名</td><td>用户姓名</td><td>审核用户</td>
</tr>
<%

Profile profile=null;
java.util.Vector p=(Vector)Profile.find1(sql.toString(),pos,10);
for(int i=0;i<p.size();i++){
  profile=(Profile)p.get(i);


%>
<tr>
<td><%= profile.get_strMember()%></td><td><%=profile.getUserName(profile.get_strMember())%></td><td><a href="javascript:f_shenhe('<%= profile.get_strMember()%>','<%=profile.getUserName(profile.get_strMember())%>');">审核</a></td>
</tr>
<%

}
%>
<tr><td align="center" colspan="4"><%=new tea.htmlx.FPNL(teasession._nLanguage,param.toString(),pos,count,10)%></td></tr>
</table>
</body>
</form>
</html>
