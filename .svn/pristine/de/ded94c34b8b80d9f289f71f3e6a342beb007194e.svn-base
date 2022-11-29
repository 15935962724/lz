<%@page contentType="text/html;charset=UTF-8"%>
<%@page import="tea.db.DbAdapter"%>
<%@page import="tea.resource.Resource"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.ui.*"%>
<%@page import="tea.html.*"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@page import="tea.entity.site.*"%>
<%@page import="tea.entity.admin.*"%>

<%


TeaSession teasession = new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
}
int id = 0;
if(request.getParameter("id")!=null && request.getParameter("id").length()>0)
   id = Integer.parseInt(request.getParameter("id"));
int state=3;
String [] audit={"未审核","审核通过","审核未通过"};
 StringBuffer param = new StringBuffer("?community=" + teasession._strCommunity);//

StringBuffer sql=new StringBuffer();
sql.append("select * from expenserecord where 1=1" );
/*select e.*,n.subject from nodelayer n,expenserecord e ,destine d where n.node=d.node and e.destine=d.destine
  and(1 in(select h.city from hostel h,destine d where h.node=d.node and d.destine in (select destine from expenserecord)))*/
/*destine in (select destine from destine where member="+DbAdapter.cite(teasession._rv.toString())+")*/


java.util.Enumeration ae = AdminUsrRole.find(teasession._strCommunity," and member ="+DbAdapter.cite(teasession._rv.toString())+" and role like "+DbAdapter.cite("%/"+5+"/%"),0,Integer.MAX_VALUE);
if(ae.hasMoreElements()){
  Citypopedom cobj = Citypopedom.find(teasession._rv.toString());
  if(cobj.getCityid()==null )
  {
    response.sendError(403);
    return;
  }
  String cm[] =  cobj.getCityid().split("/");
  sql.append("  and (");
  for(int i=1;i<cm.length;i++)
  {
    if(cobj.getCityid()!=null){
      sql.append("  h.city =").append(Integer.parseInt(cm[i]));
    }
    if(cm.length-1>i){
      sql.append("  or ");
    }
  }
  sql.append(")");

}
//Citypopedom cobj = Citypopedom.find(teasession._rv.toString());/*返回一个区域授权对像*/
//String cm[] =  cobj.getCityid().split("/");/*从区域授权对像中提取授权区域信息*/
//if(cobj.getCityid()==null )
//  {
//    response.sendError(403);
//    return;
//  }
//  for(int i=1;i<cm.length;i++){
//    if(cobj.getCityid()!=null){
//      /*查看hostel在不在授权的区域中*/
//     sql.append(cm[i]).append(" in(select h.city from hostel h,destine d where h.node=d.node and d.destine in (select destine from expenserecord))");
//     if(i<cm.length-1){
//       sql.append("or ");
//     }
//    }
//  }
//  sql.append(")");
String mem = request.getParameter("mem");
if(mem!=null && mem.length()>0){
  sql.append(" and destine in(select destine from destine where member like '%"+mem+"%')");
  param.append("&mem=").append(mem);
}

String kipDateFlag = request.getParameter("kipDateFlag");
if(kipDateFlag!=null && kipDateFlag.length()>0){
  sql.append(" and kipdate >='").append(kipDateFlag).append("'");/*过滤入住时间*/
  param.append("&kipDateFlag=").append(kipDateFlag);/*param用来保存过滤条件*/
}

String leaveDateFlag = request.getParameter("leaveDateFlag");
if(leaveDateFlag!=null && leaveDateFlag.length()>0){
  sql.append(" and kipdate <= '").append(leaveDateFlag).append("'");
  param.append("&leaveDateFlag=").append(leaveDateFlag);
}

if(request.getParameter("state")!=null){
  state = Integer.parseInt(request.getParameter("state"));
}
if(state!=3){
  sql.append(" and audit =").append(state);/*过滤审核状态*/
  param.append("&state=").append(state);
}

//int count = Expenserecord.count(sql.toString());/*求总记录数*/
int size = 5;/*设置每页显示记录数*/
int pos = 0;
if(teasession.getParameter("pos")!=null && teasession.getParameter("pos").length()>0)
{
   pos = Integer.parseInt(teasession.getParameter("pos"));
}
String o=request.getParameter("o");
if(o==null)
{
  o="destine";/*o用来记录对哪一列进行排序*/
}
boolean a=Boolean.parseBoolean(request.getParameter("a"));/*a用来判断升序还是降序*/
sql.append(" ORDER BY ").append(o).append(" ").append(a?"DESC":"ASC");
param.append("&o=").append(o).append("&a=").append(a);
%>

<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>

<body bgcolor="#ffffff">
<h1>审核用户消费</h1>
<h2>查询</h2>
<form action="?" name="form1" METHOD="POST">
<input type="hidden" name="o" VALUE="<%=o%>">
<input type="hidden" name="a" VALUE="<%=a%>">
<input type="hidden" name="id" value="<%=id%>">

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">

<tr>

  <td>会员名称：<input type="text" name="mem" value="<%if(mem!=null)out.print(mem);%>"/>　　　

  入住时间：从
    <input name="kipDateFlag" size="7"  value="<%if(kipDateFlag!=null)out.print(kipDateFlag);%>"><A href="###"><img onclick="showCalendar('form1.kipDateFlag');" src="/tea/image/public/Calendar2.gif" align="top" alt=""/></a>
    &nbsp;&nbsp; 到
     <input name="leaveDateFlag" size="7" value="<%if(leaveDateFlag!=null)out.print(leaveDateFlag);%>" ><A href="###"><img onclick="showCalendar('form1.leaveDateFlag');" src="/tea/image/public/Calendar2.gif" align="top" alt=""/></a>
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
<h2>审核消费</h2>
 <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
 <tr id="tableonetr">
<td align="center"><a href="javascript:f_order('destine');">订单号</a>
<%
      if(o.equals("destine"))
      {
        if(a)
        out.print("↓");
        else
        out.print("↑");
      }
      %>

</td>
<td>会员</td>
<td align="center">酒店</td>
<td align="center"><a href="javascript:f_order('roomcount');">订房间数</a>
<%
      if(o.equals("roomcount"))
      {
        if(a)
        out.print("↓");
        else
        out.print("↑");
      }
      %>
</td>
<td align="center"><a href="javascript:f_order('kipdate');">入住时间</a>
    <%
      if(o.equals("kipdate"))
      {
        if(a)
        out.print("↓");
        else
        out.print("↑");
      }
    %>
      </td>
<td align="center"><a href="javascript:f_order('leavedate');">离开时间</a>
<%
      if(o.equals("leavedate"))
      {
        if(a)
        out.print("↓");
        else
        out.print("↑");
      }
      %>
      </td>
<td align="center"><a href="javascript:f_order('roomprice');">房间类型</a>
<%
      if(o.equals("roomprice"))
      {
        if(a)
        out.print("↓");
        else
        out.print("↑");
      }
      %>
      </td>
<td align="center"><a href="javascript:f_order('money');">金额</a>
<%
      if(o.equals("money"))
      {
        if(a)
        out.print("↓");
        else
        out.print("↑");
      }
      %>
      </td>
<td align="center"><a href="javascript:f_order('audit');">审核情况</a>
<%
      if(o.equals("audit"))
      {
        if(a)
        out.print("↓");
        else
        out.print("↑");
      }
      %>
</td>
</tr>

<%

 DbAdapter db = new DbAdapter();
Expenserecord exp=null;

ArrayList list=(ArrayList)Expenserecord.select(sql.toString(),pos,size);
//int record =5;
//int pagenum=Expenserecord.pageNum(record);
//java.util.Date kipdate=null;
//java.util.Date leavedate=null;
Destine obj=null;
Node no=null;
if(list!=null){
String roomtype=null;

  for(int i =0;i<list.size();i++){
    exp=(Expenserecord)list.get(i);

    try {
      obj = Destine.find(exp.getDestine());
      no = Node.find(obj.getNode());


            db.executeQuery("select roomtype from RoomPriceLayer where RoomPrice in(select roomprice from roomprice where node=(select node from Destine where destine =" + exp.getDestine() + "))");
            if(db.next()) {
              roomtype = db.getString(1);
            }

      }catch(Exception e){
           e.printStackTrace();
          }

    %>
 <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
<td align="left"> <%=exp.getDestine() %></td>
<td align="left"> <%=obj.getMember() %></td>
<td align="left"> <%=no.getSubject(teasession._nLanguage) %></td>
<td align="left"> <%=exp.getRoomcount() %></td>
<td align="left"> <%=exp.getKipdate().substring(0,10)%></td>
<td align="left"> <%=exp.getLeavedate().substring(0,10)%></td>
<td align="left"> <%=roomtype %></td>
<td align="left"> <%=exp.getMoney() %></td>
<td align="left"> <%=audit[exp.getAudit()]%>

<%if(exp.getAudit()==0){
%>
<a href="/jsp/type/expenserecord/audit1.jsp?destine=<%=exp.getDestine()%>&roomcount=<%=exp.getRoomcount()%>&kipdate=<%=exp.getKipdate()%>&leavedate=<%=exp.getLeavedate()%>&money=<%=exp.getMoney()%>">审核</a>
<%
} %>
</td>

</tr>
    <%
    }
}
%>


</table>
</body>
</html>
<script type="">

function f_order(v)
{
  var a=form1.a.value=="true";
  if(form1.o.value==v)
  {
    form1.a.value=!a;
  }else
  {
    form1.o.value=v;
  }
  form1.action="?";
  form1.submit();
}

</script>
