<%@page contentType="text/html;charset=UTF-8"%>
<%@page import="tea.db.DbAdapter"%>
<%@page import="tea.resource.Resource"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.ui.*"%>
<%@page import="tea.html.*"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%
TeaSession teasession = new TeaSession(request);
int state=3;
String [] audit={"未审核","审核通过","审核未通过"};
String kipDateFlag = request.getParameter("kipDateFlag");
String leaveDateFlag = request.getParameter("leaveDateFlag");
StringBuffer sql=new StringBuffer();
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
}

String member=teasession._rv._strV;



if(kipDateFlag==null){
  kipDateFlag="";
}
if(leaveDateFlag==null){
  leaveDateFlag="";
}
StringBuffer param = new StringBuffer("?community=" + teasession._strCommunity);
int count = Expenserecord.count(sql.toString());/*求总记录数*/
int size = 10;/*设置每页显示记录数*/
int pos = 0;
if(teasession.getParameter("pos")!=null && teasession.getParameter("pos").length()>0)
{
   pos = Integer.parseInt(teasession.getParameter("pos"));
}
if(request.getParameter("state")!=null){
  state = Integer.parseInt(request.getParameter("state"));
}
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body id="bodynone">
<h1>我的消费情况</h1>
<form action="/jsp/type/expenserecord/explist.jsp" name="form1" METHOD="POST">
<h2>查询</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">

<tr>

  <td>入住时间：从：
    <input name="kipDateFlag" size="7"  value="<%=kipDateFlag%>"><A href="###"><img onclick="showCalendar('form1.kipDateFlag');" src="/tea/image/public/Calendar2.gif" align="top" alt=""/></a>
    &nbsp;&nbsp; 到：
     <input name="leaveDateFlag" size="7" value="<%=leaveDateFlag%>" ><A href="###"><img onclick="showCalendar('form1.leaveDateFlag');" src="/tea/image/public/Calendar2.gif" align="top" alt=""/></a>
      &nbsp;&nbsp;
      审核状态：
      <select name="state">
      <option value="3" selected="selected">全部</option>
      <%
       if(request.getParameter("state")!=null){
        state = Integer.parseInt(request.getParameter("state"));
       }
         for(int i=0;i<audit.length;i++){

           out.print("<option value="+i);
          if(request.getParameter("state")!=null&&state==i)
           out.print(" selected ");
           out.print(">"+audit[i]+"</option>");

         }

      %>
      </select>
</td>
<td>
 <input type="submit" value="go"/>
</td>
</tr>
</table>
</form>
<h2>消费情况</h2>
 <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
 <tr id="tableonetr">
<td align="left">订单号</td>
<td align="left">酒店</td>
<td align="left">订房间数</td>
<td align="left">入住时间</td>
<td align="left">离开时间</td>
<td align="left">房间类型</td>
<td align="left">金额</td>
<td align="left">审核情况</td>

</tr>

<%
 sql.append("select * from expenserecord where  destine in(select destine from Destine where member ='").append(member).append("')");
 if(!kipDateFlag.equals("")){
   sql.append(" and kipdate >='").append(kipDateFlag).append("'");
   param.append("&kipDateFlag=").append(kipDateFlag);/*param用来保存过滤条件*/
 }
 if(!leaveDateFlag.equals("")){
   sql.append(" and kipdate <= '").append(leaveDateFlag).append("'");
   param.append("&leaveDateFlag=").append(leaveDateFlag);
 }
 if(state!=3){
   sql.append(" and audit =").append(state);
   param.append("&state=").append(state);
 }

 DbAdapter db = new DbAdapter();
Expenserecord exp=null;

ArrayList list=(ArrayList)Expenserecord.select(sql.toString(),pos,size);
java.util.Date kipdate=null;
java.util.Date leavedate=null;
Destine obj=null;
if(list!=null){
  String roomtype=null;
  Node no=null;
 try {
  for(int i=0;i<list.size();i++){
    exp=(Expenserecord)list.get(i);


      obj = Destine.find(exp.getDestine());
      no = Node.find(obj.getNode());

          String sql2 = "select node from Destine where destine = " + exp.getDestine();
          db.executeQuery(sql2);

          if (db.next()) {
            int node = db.getInt(1);

            db.executeQuery("select roomtype from RoomPriceLayer where RoomPrice in(select roomprice from roomprice where node=" + node + ")");
            while (db.next()) {
              roomtype = db.getString(1);
            }
        }



    %>
<tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
<td align="left"> <%=exp.getDestine() %></td>
<td align="left"> <%=no.getSubject(teasession._nLanguage) %></td>
<td align="left"> <%=exp.getRoomcount()+"间" %></td>
<td align="left"> <%=exp.getKipdate().substring(0,10)%></td>
<td align="left"> <%=exp.getLeavedate().substring(0,10)%></td>
<td align="left"> <%=roomtype %></td>
<td align="left"> <%=exp.getMoney() %></td>
<td align="left"> <%=audit[exp.getAudit()]%>
<%if(exp.getAudit()!=1){

%>
<a href="/jsp/type/expenserecord/expenserecord.jsp?destine=<%=exp.getDestine()%>&flag=2">修改</a>
<%
} %>
</td>
</tr>

    <%
    }
  }catch(Exception e){
           e.printStackTrace();
          }
          finally{
          db.close();
          }
}
%>
<tr>
<td colspan="5" align="center"><%=new tea.htmlx.FPNL(teasession._nLanguage,request.getRequestURI()+param.toString()+"&pos=",pos,count,size)%>
<%--用来分页的方法
  --%>   </td>
</tr>
</table>
</body>
</html>
