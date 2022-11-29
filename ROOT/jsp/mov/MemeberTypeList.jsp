<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="java.util.*" %>
<%@page import="tea.db.DbAdapter"%>
<%@page import="tea.resource.Resource" %>
<%@page import="tea.ui.TeaSession" %>
<%@page import="tea.entity.admin.mov.*"%>
<%@page import="tea.entity.admin.*" %>
<%
request.setCharacterEncoding("UTF-8");
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String nexturl = request.getRequestURI()+"?"+request.getContextPath();

%>
<html> 
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

</head>
<body bgcolor="#ffffff">
<script type="text/javascript">
 function f_edit(igd)
 {
    form1.membertype.value=igd;
    form1.action="/jsp/mov/EditMemeberType.jsp";
    form1.submit();
 }
 function f_delete(igd)
 {
   if(confirm('确实要删除吗？')){
     form1.membertype.value=igd;
     form1.act.value='delete';
     form1.action="/servlet/EditMemberType";
     form1.submit();
   }
 }
 function f_regall(igd)
 {
   form1.membertype.value=igd;
   form1.action="/jsp/mov/RegisterInstall.jsp";
   form1.submit();
 }
 function f_type(igd,type)
 {
   form1.membertype.value=igd;
   form1.act.value='type';
   form1.type.value=type;
   form1.action="/servlet/EditMemberType";
   form1.submit();
 }

</script>
<h1>会员类型设置列表</h1>
<form action="?" name="form1" >
<input type="hidden" name="membertype"/>
<input type="hidden" name="act"/>
<input type="hidden" name="nexturl" value="<%=nexturl%>"/>
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="type"/>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
 <tr id="tableonetr">
   <td>会员类型</td>
   <td>对应角色</td>
   <td>操作</td>
  </tr>
  <%
    java.util.Enumeration e = MemberType.find(teasession._strCommunity,"",0,Integer.MAX_VALUE);
      if(!e.hasMoreElements())
   {
       out.print("<tr><td colspan=10 align=center>暂无记录</td></tr>");
   }

    while(e.hasMoreElements())
    {
      int membertype = ((Integer)e.nextElement()).intValue();
      MemberType  myobj = MemberType.find(membertype);
      int role = 0;
      if(myobj.getRole()!=null && myobj.getRole().length()>0)
      {
       role=  Integer.parseInt(myobj.getRole());
      }
      AdminRole arobj = AdminRole.find(role);
  %>


   <td><%=myobj.getMembername() %></td>
   <td><%if(arobj.getName()!=null)out.print(arobj.getName());else{out.print("暂没有对应角色");} %></td>
   <td>
       <input type="button" value="编辑" onclick="f_edit('<%=membertype%>');"   <%if(myobj.getType()==1)out.print(" disabled=\"disabled\"  style=background:#666666 ");%>     />&nbsp;
     <input type="button" value="注册设置" onclick="f_regall('<%=membertype%>');"   <%if(myobj.getType()==1)out.print(" disabled=\"disabled\"  style=background:#666666 ");%>/>
     <input type="button" value="删除" onclick="f_delete('<%=membertype%>');" />&nbsp;

      <%
        if(myobj.getType()==0){ 
     %>
     <input type="button" value="暂停服务" onclick="f_type('<%=membertype%>',1);"/>
     <%
        }
        if(myobj.getType()==1){
     %>
      <input type="button" value="启动服务" onclick="f_type('<%=membertype%>','0');"/>
     <%}%>
   </td>
 </tr>

<%} %>
</table>

</form>
<br>
<input type="button" value="创建会员类型" onclick="window.open('/jsp/mov/EditMemeberType.jsp?community=<%=teasession._strCommunity%>&nexturl=<%=nexturl%>','_self');" />
</body>
</html>
