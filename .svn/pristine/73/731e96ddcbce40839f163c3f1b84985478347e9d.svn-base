<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="tea.entity.node.*" %>
<%@ page import="tea.ui.TeaSession"%>
<%
request.setCharacterEncoding("UTF-8");
TeaSession teasession= new TeaSession(request);
String memberid = request.getParameter("memberid");
String node = request.getParameter("nodeid");
System.out.print("memberid is : "+memberid+"  "+"nodeid is : "+ node);
int nodeid=0;
if(node!=null&&node.length()>=0)
{
   nodeid = Integer.parseInt(node);
}
Hotel_application hoste = new Hotel_application();
java.util.Enumeration e1 = Hotel_application.findByIdName(memberid);
%>
<html>
<head>
<link  href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" language="javascript" src="/tea/tea.js"></script>
<script language="javascript" src="/tea/CssJs/AreaCityData_zh_CN.js" type=""></script>
</head>
<body id="bodynone">
<div id="head6"><img height="6" src="about:blank" alt=""></div>
<form action="" name="form1" method="POST">
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr>
<td colspan="4">详细信息查询</td>
</tr>
<tr>
<td>用户名</td><td>酒店名字</td><td>申请说明</td><td>是否被审批(0未被审批)</td>
</tr>
<%
while(e1.hasMoreElements())
{
Hotel_application  obj =  (Hotel_application)e1.nextElement();
Hostel obj1 = (Hostel)e1.nextElement();
int node1 = obj1.getNode();
Node no = Node.find(node1);
%>
<tr>
  <td><%=obj.getMember()%></td>
  <td><%=no.getSubject(teasession._nLanguage)%></td>
  <td><%=obj.getFilepath()%></td>
  <td><%=obj.getAudit()%></td>
</tr>
<%}%>
</table>
</form>
</body>
</html>
