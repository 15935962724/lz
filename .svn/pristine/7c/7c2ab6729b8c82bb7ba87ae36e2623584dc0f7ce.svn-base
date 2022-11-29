<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="tea.entity.member.*" %>
<%@page import="tea.entity.admin.*" %>
<%@ page import="tea.db.DbAdapter" %>
<%@ page  import="tea.resource.Resource" %>
<%@ page import="tea.entity.node.*" %>
<%@ page import="tea.ui.TeaSession" %>
<%/**　　　　　　　　　　
                            用户审核
*/
request.setCharacterEncoding("UTF-8");
TeaSession teasession=new TeaSession(request);
//out.println(request.getParameter("role")+request.getParameter("group"));
String temp=null;

int role=0;
int group=0;
int role2=0;
int group2=0;
String name=request.getParameter("name");//取用户姓名
String member=request.getParameter("member");//取用户名
//out.print(member);
temp=request.getParameter("role");
if(temp!=null){
  role=Integer.parseInt(temp);
}
temp=request.getParameter("group");
if(temp!=null){
  group=Integer.parseInt(temp);
}
 Enumeration e = AdminRole.findByCommunity(teasession._strCommunity,0);
 Enumeration e1=AdminUnit.findByCommunity(teasession._strCommunity,"");
%>
<script >
function dosubmit()
{
  var role=form1.role1.value;
  var a =  role.split("/");
  form1.role.value=a[0];
  //alert(a[0]);
  //alert(form1.role.value);
  var ign=form1.name.value;

  if(confirm("是否把"+ign+"审核为"+a[1])){

  }else{
    return false;
  }
}
</script>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>
<body >
<h1>
将用记审核为
</h1>
<form action="/jsp/contract/useraudit/useraudit.jsp" method="POST" name="form1" onSubmit="return dosubmit();">
<table  border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<%if(role==0){
%>

<tr>
  <td>
  用户角色:
  </td>
  <td>
  <input type="hidden" name="name" value="<%=name%>"/>
  <input type="hidden" name="member" value="<%=member%>"/>
  <input  type="hidden" name="role2" value="<%=role%>"/>
  <input  type="hidden" name="group2" value="<%=group2%>"/>
  <input  type="hidden" name="flag" value="audit"/>

    <select name="role1">
    <%
     AdminUsrRole obj=AdminUsrRole.find(teasession._strCommunity,teasession._rv.toString());
  String a[]=obj.getRole().split("/");
  for(int i=1;i<a.length;i++){

//  }
//列出当前用户所有　角色　
//    while(e.hasMoreElements()){
//      int aid =((Integer)e.nextElement()).intValue();
      int uid=Integer.parseInt(a[i]);
      AdminRole aobj=AdminRole.find(uid);
      out.print("<option value=");
      out.print(aobj.getId()+"/"+aobj.getName());
      out.print(">"+aobj.getName());
      out.print("</option>");

    }
    %>
    </select>
    <input type="hidden" name="role" />
  </td>
</tr>
<%
} else{
  out.print("<input type=hidden name=role value="+role+"/>");
}
%>
<%if(group==0){
%>
<tr>
  <td>
  所属部门:
  </td>
  <td>
  <select name="group">
  <%
//列出所有部门供选择
   while(e1.hasMoreElements())
   {
     AdminUnit uobj=(AdminUnit)e1.nextElement();
     int uid=uobj.getId();
     out.print("<option value=");
     out.print(uobj.getId());
     out.print(">"+uobj.getName());
     out.print("</option>");
   }
  %>
  </select>
  <input type="hidden" name="act" value="shenhe"/>
  </td>
</tr>
<%
}else{
  out.print("<input type=hidden name=group value="+group+"/>");
}
%>


<tr><td><input type="submit" value="审核"/></td>
</tr>
</table>
</form>
</body>
</html>
