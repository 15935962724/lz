<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%><%@page import="tea.entity.*"%><%@page import="tea.ui.*"%><%@page import="tea.entity.sup.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?node="+h.node);
  return;
}

int qualification=h.getInt("qualification");

SupQualification root=SupQualification.getRoot();
//if(qualification==0)qualification=root.qualification;

SupQualification t=SupQualification.find(qualification);
if(t.qualification<1)
{
  t.father=h.getInt("father");
}


%><html>
<head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>图书分类</h1>

<form name="form1" action="/SupQualifications.do" method="post" enctype="multipart/form-data" target="_ajax" onSubmit="return mt.check(this)">
<input type="hidden" name="qualification" value="<%=qualification%>"/>
<input type="hidden" name="nexturl" value="<%=h.get("nexturl","/jsp/sup/SupQualificationList.jsp?qualification="+t.father)%>"/>
<input type="hidden" name="act" value="edit"/>

<table id="tablecenter">
  <tr>
    <td width="200px" align="right">父类：</td>
    <td><select name="father" alt="父类"><option value="0">---<%=SupQualification.options(root.qualification,t.father)%></select></td>
  </tr>
  <tr>
    <td align="right">名称：</td>
    <td><input name="name" value="<%=MT.f(t.name)%>" size="31" alt="名称"/></td>
  </tr>
  <tr>
    <td align="right">编码：</td>
    <td><input name="code" value="<%=MT.f(t.code)%>" mask="int"size="31"/></td>
  </tr>
  <tr>
    <td align="right">规格：</td>
    <td><input name="spec" value="<%=MT.f(t.spec)%>" size="31"/></td>
  </tr>
  <tr>
    <td align="right">单位：</td>
    <td><input name="unit" value="<%=MT.f(t.unit)%>" size="31"/></td>
  </tr>
</table>

<input type="submit" value="提交"/>
<input type="button" value="返回" onClick="history.back()"/>
</form>


<script>
</script>
</body>
</html>
