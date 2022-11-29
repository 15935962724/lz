<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%><%@page import="tea.entity.*"%><%@page import="tea.ui.*"%><%@page import="tea.entity.sup.*"%>
<%@page import="tea.entity.yl.shop.ShopHospital"%><%@page import="tea.entity.Attch"%>
<%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}
String nexturl = h.get("nexturl");
int id=h.getInt("id");

ShopHospital sh = ShopHospital.find(id);


%><html>
<head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src='/tea/jquery.js'></script>
</head>
<body onload="changeSelected();">
<h1>医院管理</h1>

<form name="form2" action="/ShopHospitals.do" enctype="multipart/form-data" method="post" target="_ajax" onSubmit="return mt.check(this)">
<input type="hidden" name="id" value="<%=id%>"/>
<input type="hidden" name="nexturl" value="<%=h.get("nexturl") %>"/>
<input type="hidden" name="act" value="editName"/>

<table id="tablecenter">
  <tr>
    <td align="right">医院名称：</td>
    <td><input name="name" value="<%=MT.f(sh.getName())%>"  size="31" alt="名称"/></td>
  </tr>
  <tr>
    <td align="right">医院名称变更附件：</td>
    
    <td>
    <%
    	if(sh.getNamefile()>0){
    		Attch attch=Attch.find(sh.getNamefile());
    		out.print("<img src='"+attch.path+"'/>");
    	}
    %>
    <input type="file" name="namefile"/></td>
  </tr>
</table>
    <button class="btn btn-primary" type="submit">提交</button>&nbsp;&nbsp;&nbsp;&nbsp;
    
    <button class="btn btn-default" type="button" onclick="location='<%=nexturl%>'">返回</button>
</form>



</body>
</html>
