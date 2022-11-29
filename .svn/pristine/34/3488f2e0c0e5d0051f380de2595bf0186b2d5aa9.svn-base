<%@page contentType="text/html;charset=UTF-8"%>
<%@page import="tea.db.DbAdapter"%>
<%@page import="tea.resource.Resource"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.ui.*"%>
<%@page import="tea.html.*"%>
<%
TeaSession teasession = new TeaSession(request);
String destine=teasession.getParameter("destine");
String hotel=teasession.getParameter("hotel");
String kipdate=teasession.getParameter("kipdate");
String leavedate=teasession.getParameter("leavedate");
String roomtype=null;
float money=0;
  money=Float.parseFloat(teasession.getParameter("money"));
  DbAdapter db=new DbAdapter();
  String sql = "select node from Destine where destine = " + destine;
  Destine obj=null;
   Node no=null;

    try{
      db.executeQuery(sql);
     obj = Destine.find( Integer.parseInt(destine));
      no = Node.find(obj.getNode());
    if (db.next()) {
      int node = db.getInt(1);
      System.out.println(node);
      db.executeQuery("select roomtype from RoomPriceLayer where RoomPrice in(select roomprice from roomprice where node=" + node + ")");
      while (db.next()) {
        roomtype = db.getString(1);
      }
    }
  }catch(Exception e){
    e.printStackTrace();
  }finally{
    db.close();
  }


//System.out.print(hotel);
int roomcount=Integer.parseInt(teasession.getParameter("roomcount"));


%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body bgcolor="#ffffff">


<form action="/servlet/EditExp" method="POST">

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr>
<td  align="center">订单号</td><td align="left"><%=destine%>
     <input type="hidden" name="opt" value="audit"/>
     <input type="hidden" name="destine" value="<%=destine%>"/>

</td>
</tr>
<tr>
<td align="center">酒店</td><td  align="left"><%=no.getSubject(teasession._nLanguage) %></td>
</tr>
<tr>
<td align="center">订房间数</td><td  align="left"><%=roomcount%></td>
</tr>
<tr>
<td align="center">入住时间</td><td  align="left"><%=kipdate%></td>
</tr>
<tr>
<td align="center">离开时间</td><td  align="left"><%=leavedate%></td>
</tr>
<tr>
<td align="center">房间类型</td><td  align="left"><%=roomtype%></td>
</tr>
<tr>
<td align="center">金额</td><td  align="left"><%=money%></td>
</tr>
<tr>
<td align="center">审核意见</td>
<td  align="left">
<input id="gender_0" type="radio" name="yn" value="1" checked="checked"/>
<label for="gender_0">通过审核</label>
<input id="gender_1" type="radio" name="yn" value="2"/>
<label for="gender_1">不通过</label>
</td>
</tr>
<tr><td></td><td><input  type="submit" value="提交"/><input type="button" value="返回" onclick="back()"/></td>
</tr>
</table>
</form>
</body>
</html>
<script type="text/javascript">
function back(){
  window.location.href="/jsp/type/expenserecord/audit.jsp";
}
</script>
