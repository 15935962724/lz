<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="tea.htmlx.*"%>
<%@page import="tea.ui.TeaSession"%>
<%@page import="tea.resource.*,tea.entity.node.*"%>
<%@page import="tea.entity.site.*,tea.db.*"%>
<%@page import="tea.entity.member.Profile"%>
<%@page import="java.text.*"%>

<%

  request.setCharacterEncoding("UTF-8");

  TeaSession teasession = new TeaSession(request);
  if (teasession._rv == null) {
    response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
    return;
  }
  String member = teasession._rv._strV;
  StringBuffer sql = new StringBuffer(" AND member="+DbAdapter.cite(member));

  StringBuffer param = new StringBuffer("?community=").append(teasession._strCommunity);
  String strid = request.getParameter("id");
  param.append("&id=").append(strid);
  String kipDateFlag = request.getParameter("kipDateFlag");
  String leaveDateFlag = request.getParameter("leaveDateFlag");
  int state = 4;
  String tate[]={"未受理","已受理","入住正常","LESSSHOW","延住","NOSHOW"};
  int pos=0,count=0,pageSize=10;
  if(request.getParameter("pos")!=null)
  {
    pos=Integer.parseInt(request.getParameter("pos"));
  }
  if(kipDateFlag!=null&&kipDateFlag.length()>0)
  {
    sql.append(" AND destinedate>="+DbAdapter.cite(kipDateFlag));
    param.append("&kipdate="+kipDateFlag);
  }
   if(leaveDateFlag!=null&&leaveDateFlag.length()>0)
  {
    sql.append(" AND destinedate<="+DbAdapter.cite(leaveDateFlag));
    param.append("&leavedate="+leaveDateFlag);
  }

    if(request.getParameter("state")!=null)
    {
    state = Integer.parseInt(request.getParameter("state"));
    if(state!=-1)
    {
    sql.append(" AND state="+state);
    param.append("&state="+state);
    }
  }
    java.util.Enumeration e = Destine.find(teasession._strCommunity,sql.toString(),pos,pageSize);
    count = Destine.count(teasession._strCommunity,sql.toString());
 %>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>

<script type="text/javascript">
function yn()
{
  if(confirm("确认是否撤销？"))
  {
    return true;
  }
  else
  {
    return false;
  }
}

</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body id="bodynone">
<h1>我的订单</h1>
<FORM name="form1" METHOD="POST" action="?">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="node" value="<%=teasession._nNode%>"/>
<input type="hidden" name="id" value="<%=strid%>"/>
<h2>查询</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td>订单时间：从
    <input name="kipDateFlag" size="7"  value="<%if(kipDateFlag!=null)out.print(kipDateFlag);%>"><A href="###"><img onclick="showCalendar('form1.kipDateFlag');" src="/tea/image/public/Calendar2.gif" align="top"/></a>
     　　
      &nbsp;&nbsp; 至
          <input name="leaveDateFlag" size="7"  value="<%if(leaveDateFlag!=null)out.print(leaveDateFlag);%>"><A href="###"><img onclick="showCalendar('form1.leaveDateFlag');" src="/tea/image/public/Calendar2.gif" align="top"/></a>

      &nbsp;&nbsp;
      订单状态：
      <select name="state">
        <option value="-1">全部</option>
        <%for(int j=0;j<tate.length;j++)
        {
        out.println("<option value="+j);
        if(request.getParameter("state")!=null&&state==j)
        out.println(" selected");
        out.println(">"+tate[j]+"</option>");
       }
        %>
      </select>
    </td>
    <td>
      <input type="submit" value=" GO "/>
    </td>
  </tr>
</table>
</form>
<h2>我的订单(<%=count%>)</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td>订单号</td>
    <td>酒店</td>
    <td>订单时间</td>
    <td>订单状态</td>

  </tr>
  <%
  if(!e.hasMoreElements())
  {
    out.println("<tr><td colspan='4'> 暂无记录 </td></tr>");
  }
    while (e.hasMoreElements()) {
    int destine = ((Integer)(e.nextElement())).intValue();
    Destine obj = Destine.find(destine);
    Node no = Node.find(obj.getNode());
    int stat = obj.getState();
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    String date = sdf.format(obj.getDestinedate());
    %>
  <tr>
    <td >
      <a href="/jsp/registration/DestineView.jsp?node=<%=obj.getNode()%>&destine=<%=obj.getDestine()%>&roomprice=<%= obj.getRoomprice()%>"><%=obj.getDestine()%></a>
    </td>
    <td><a href="/jsp/registration/HostelView.jsp?node=<%=obj.getNode()%>"><%=no.getSubject(teasession._nLanguage)%></a></td>
    <td><%=date%></td>
    <td><%=tate[stat]%> <%if (stat == 0) { %>
      <a href="/jsp/registration/editorder.jsp?destine=<%=obj.getDestine()%>&language=<%=teasession._nLanguage%>&nexturl=<%=request.getRequestURI()%>?<%=request.getQueryString()%>">修改订单</a>
      &nbsp;
      <a href="/jsp/registration/deletedestine.jsp?destine=<%=obj.getDestine()%>&nexturl=<%=request.getRequestURI()%>?<%=request.getQueryString()%>" onClick="return yn();">撤销订单</a>
    <%}
      if(stat==1){
        DbAdapter db=new DbAdapter();
        try{
          db.executeQuery("select destine from expenserecord where destine="+obj.getDestine());
          if(!db.next()){
            %>
            <a href="/jsp/type/expenserecord/expenserecord.jsp?destine=<%=obj.getDestine()%>">消费情况</a>
            <%
            }
          }
          finally{
          db.close();
          }

      }
    %>
    </td>
  </tr>
<%}%>
<tr>
  <td colspan="5" align="center">
  <%=new tea.htmlx.FPNL(1,param.toString()+"&pos=",pos,count,pageSize)%>
  </td>
</tr>
</table>
</body>
</html>
</html>
