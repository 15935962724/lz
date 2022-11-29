<%@page contentType="text/html;charset=UTF-8" %>
<%
String name=request.getParameter("index");
if(name==null)
name="form1.number";


int type=0;
String _strType=request.getParameter("type");
if(_strType!=null)
type=Integer.parseInt(_strType);

String field=request.getParameter("field");
if(field==null)
field="";

String gl=null,ul=null;
if(type==0)
{
  gl="/jsp/sms/psmanagement/GroupList.jsp?index="+name+"&field="+field;
  ul="/jsp/sms/psmanagement/UserList.jsp?index="+name+"&field="+field;
}else
if(type==1)
{
  gl="/jsp/sms/psmanagement/GroupList2.jsp?index="+name+"&field="+field;
  ul="/jsp/sms/psmanagement/UserList2.jsp?index="+name+"&field="+field;
}else
if(type==3)
{
  gl="/jsp/sms/psmanagement/GroupList3.jsp?index="+name+"&field="+field;
  ul="/jsp/sms/psmanagement/UserList3.jsp?index="+name+"&field="+field;
}
else
if(type==2)      //获取的是用户名 和真实姓名 工资管理中用到
{
  gl="/jsp/sms/psmanagement/GroupList4.jsp?index="+name+"&field="+field;
  ul="/jsp/sms/psmanagement/UserList4.jsp?index="+name+"&field="+field;
}
else
if(type==4)//发邮件中用到 显示用户的真实名字 和全选
{
  gl="/jsp/sms/psmanagement/GroupList5.jsp?index="+name+"&field="+field;
  ul="/jsp/sms/psmanagement/UserList5.jsp?index="+name+"&field="+field;
}
else
if(type==5)//发送邮件时用到的 通讯录 显示用户的真实名字 和 全选
{
    gl="/jsp/sms/psmanagement/GroupList6.jsp?index="+name+"&field="+field;
  ul="/jsp/sms/psmanagement/UserList6.jsp?index="+name+"&field="+field;
}
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
</head>

<frameset cols="200,*"  border="1" framespacing="1">
  <frame src="<%=gl%>" name="leftFrame" scrolling="yes" >
  <frame src="<%=ul%>"  name="framegu_mainframe" scrolling="yes">
</frameset>
</html>
<!--
参数说明:
type
0:通迅录人员
1:内部人员(可以进后台的)

field:
没有:手机号
email:邮箱
member:会员ID
-->

