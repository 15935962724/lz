<%@page import="tea.entity.zs.Ctf"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%><%@ page import="tea.entity.*" %><%@ page import="tea.db.*,java.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

</head>
<body>
<%
Http http=new Http(request);
String name=http.get("name");
String creNum=http.get("creNum");
String creNumber=http.get("creNumber");
StringBuffer sql=new StringBuffer();
if(name!=""){
	sql.append("and name="+DbAdapter.cite(name));
}
if(creNum!=""){
	sql.append("and cre_num="+DbAdapter.cite(creNum));
}
if(creNumber!=""){
	sql.append("and cre_number="+DbAdapter.cite(creNumber));
}
List list=Ctf.findCtf(sql.toString(), 0, 1);
Iterator it=list.iterator();
while(it.hasNext()){
	Ctf ctf=(Ctf)it.next();
%>
<table width="604" border="1">
  <tr>
    <td colspan="4">基本信息</td>
	<td width="66" rowspan="4"></td>
  </tr>
  <tr>
    <td width="104">姓名：</td>
    <td width="160"><%=ctf.getName() %></td>
    <td width="83">性别：</td>
    <td width="157"><%=ctf.getSex()==0?"男":"女" %></td>
  </tr>
  <tr>
    <td>证件号码：</td>
    <td><%=ctf.getCreNum() %></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td colspan="4">证书信息</td>
  </tr>
  <tr>
    <td>证书编号：</td>
    <td><%=ctf.getCreNumber() %></td>
    <td>证书级别：</td>
    <td><%=ctf.getCreLv() %></td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>证书名称</td>
    <td><%=ctf.getCreName() %></td>
    <td>评定成绩：</td>
    <td><%=ctf.getGra() %></td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td><%=ctf.getMarkName1() %></td>
    <td><%=ctf.getMark1() %></td>
    <td><%=ctf.getMarkName2() %></td>
    <td><%=ctf.getMark2() %></td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td><%=ctf.getMarkName3() %></td>
    <td><%=ctf.getMark3() %></td>
    <td><%=ctf.getMarkName4() %></td>
    <td><%=ctf.getMark4() %></td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td><%=ctf.getMarkName5() %></td>
    <td><%=ctf.getMark5() %></td>
    <td><%=ctf.getMarkName6() %></td>
    <td><%=ctf.getMark6() %></td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td><%=ctf.getOtherName() %></td>
    <td><%=ctf.getOther() %></td>
    <td><%=ctf.getName() %></td>
    <td><%=ctf.getName() %></td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td colspan="5">数据信息</td>
  </tr>
  <tr>
    <td>数据上报单位：</td>
    <td><%=ctf.getDanwei() %></td>
    <td>发证时间：</td>
    <td colspan="2"><%=ctf.getTime() %></td>
  </tr>
</table>
<%} %>
</body>
</html>