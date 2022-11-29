<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter"  %><%@ page import="tea.entity.admin.*"  %><%@ page import="java.util.*"  %><%@ page import="tea.entity.site.*"  %><%@ page import="tea.resource.Resource" %><%@ page import="tea.entity.member.*" %><%@ page import="tea.entity.node.*" %><%@ page import="tea.ui.TeaSession" %><%!
int sum_sum;
java.math.BigDecimal sum_total,sum_agent;

public void agentmember(java.io.Writer out,String community,int language,String member,int agent,int k,String sql)throws Exception
{
  DbAdapter db=new DbAdapter(1);
  try
  {
    db.executeQuery("SELECT member FROM Profile WHERE community="+db.cite(community)+" AND referer="+db.cite(member));
    for(int i=1;db.next();i++)
    {
      member=db.getString(1);
      Profile p=Profile.find(member);
      out.write("<tr onmouseover=\"javascript:this.bgColor='#BCD1E9';\" onMouseOut=\"javascript:this.bgColor='';\" ><td>");
      for(int j=0;j<k;j++)
      out.write("<img src=/tea/image/tree/tree_blank.gif >");
      //      out.write("<td width=1 >"+i);
      out.write(member);
      out.write("<td>"+p.getFirstName(language)+p.getLastName(language));
      out.write("<td><A href=mailto:"+p.getEmail()+" >"+p.getEmail()+"</A>");
      java.math.BigDecimal total=null,agent1=null,agent2=null,agent3=null;
      int count=0;
      DbAdapter db2=new DbAdapter();
      try
      {
        //        System.out.println("SELECT COUNT(t.trade) FROM Trade t WHERE t.community="+db.cite(community)+" AND t.vcustomer="+db.cite(member)+" AND t.status="+Trade.TRADES_FINISHED+sql);
        count=db2.getInt("SELECT COUNT(t.trade) FROM TradeItem ti INNER JOIN Trade t ON ti.trade=t.trade WHERE t.community="+db.cite(community)+" AND t.vcustomer="+db.cite(member)+" AND t.status="+Trade.TRADES_FINISHED+sql);
        db2.executeQuery("SELECT SUM(ti.price*ti.squantity),SUM(ti.agent1*ti.squantity),SUM(ti.agent2*ti.squantity),SUM(ti.agent3*ti.squantity) FROM TradeItem ti INNER JOIN Trade t ON ti.trade=t.trade WHERE t.community="+db.cite(community)+" AND t.vcustomer="+db.cite(member)+" AND t.status="+Trade.TRADES_FINISHED+sql);
        if(db2.next())
        {
          total=db2.getBigDecimal(1,2);
          agent1=db2.getBigDecimal(2,2);
          agent2=db2.getBigDecimal(3,2);
          agent3=db2.getBigDecimal(4,2);
        }
      }finally
      {
        db2.close();
      }
      sum_sum+=count;
      if(total==null)
      total=java.math.BigDecimal.ZERO;
      else
      {
        sum_total=sum_total.add(total);
      }
      if(agent1==null)
      agent1=java.math.BigDecimal.ZERO;
      if(agent2==null)
      agent2=java.math.BigDecimal.ZERO;
      if(agent3==null)
      agent3=java.math.BigDecimal.ZERO;
      out.write("<td>"+total);
      out.write("<td>"+count+"<td>");
      switch(agent)
      {
        case 1:
        out.write(agent1.toString());sum_agent=sum_agent.add(agent1);break;
        case 2:
        out.write(agent2.toString());sum_agent=sum_agent.add(agent2);break;
        case 3:
        out.write(agent3.toString());sum_agent=sum_agent.add(agent3);break;
      }
      out.write("<td><input type=submit value=编辑 onclick=\" form1.member.value='"+member+"'; \">");
      if(agent<3)
      agentmember(out,community,language,member,agent+1,k+1,sql);
    }
  }finally
  {
    db.close();
  }
}


%><% request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String community=request.getParameter("community");

String nexturl = request.getRequestURI()+"?"+request.getQueryString();

/*
//如果是超级管理员
if(teasession._rv._strV.equals(License.getInstance().getWebMaster()))
{
  response.sendRedirect("/jsp/admin/agent/AgentManageMembers.jsp?community="+community);
  return;
}
*/

Profile c_p=Profile.find(teasession._rv._strV);
if(c_p.getAgent()>3)
{
  response.sendRedirect("/jsp/info/Alert.jsp?info="+java.net.URLDecoder.decode("你最后一级代理,你不能创建下级代理了.","UTF-8"));
  return;
}

StringBuffer sql=new StringBuffer();

java.util.Calendar c=java.util.Calendar.getInstance();

String fy=request.getParameter("fromYear");
Date from=null;
if(fy!=null)
{
  from=Node.sdf.parse(fy+"-"+request.getParameter("fromMonth")+"-"+request.getParameter("fromDay"));
  sql.append(" AND t.time>="+DbAdapter.cite(from));
}else
{
  //  c.set(c.MONTH,c.get(c.MONTH)-1);
  //  from=c.getTime();
}

String ey=request.getParameter("endYear");
Date end=null;
if(ey!=null)
{
  end=Node.sdf.parse(ey+"-"+request.getParameter("endMonth")+"-"+request.getParameter("endDay"));
  sql.append(" AND t.time<"+DbAdapter.cite(end));
}else
{
  //  end=new java.util.Date();
}

int root_dt=GoodsType.getRootId(community);
String type=request.getParameter("type");
String brand=request.getParameter("brand");
if(type!=null&&type.length()>0 || brand!=null&&brand.length()>0 )
{
  sql.append(" AND ti.subject IN (SELECT g.node FROM Goods g WHERE 1=1 ");
  if(type!=null&&type.length()>0 )
  {
    sql.append(" AND g.goodstype LIKE "+DbAdapter.cite("/"+root_dt+"/"+type+"/%") );
  }
  if(brand!=null&&brand.length()>0)
  {
    sql.append(" AND g.brand = "+DbAdapter.cite(brand));
  }
  sql.append(" )");
}


%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT SRC="/tea/tea.js" type="text/javascript"></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="">
function fload()
{
  form1.nexturl.value=document.location.href;
}
</script>
</head>

<body onLoad="fload();" id="bodynone">

<h1>我的下级代理</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" action="/jsp/admin/agent/EditAgentMember.jsp" method="get">
<input type="hidden" name="community" value="<%=community%>"/>
<input type="hidden" name="member" value=""/>
<input type="hidden" name="nexturl" value=""/>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr><td>时间:<%=new tea.htmlx.TimeSelection("from", from)%>--<%=new tea.htmlx.TimeSelection("end", end)%></td>
  <td>类型:<select name="type">
  <option value="">---------------</option>
  <%
  java.util.Enumeration enumeration=GoodsType.findByFather(root_dt);
  while(enumeration.hasMoreElements())
  {
    GoodsType gt_obj=((GoodsType)enumeration.nextElement());
    int id=gt_obj.getGoodstype();

    out.print("<option value="+id);
    if(String.valueOf(id).equals(type))
    out.print(" SELECTED ");
    out.print(" >"+gt_obj.getName(teasession._nLanguage));
  }
  %>
</select></td>
  <td>品牌:<select name="brand">
  <option value="">---------------</option>
  <%
  java.util.Enumeration enumeration2=Brand.findByCommunity(community);
  while(enumeration2.hasMoreElements())
  {
    int id=((Integer)enumeration2.nextElement()).intValue();
    Brand b_obj=Brand.find(id);
    out.print("<option value="+id);
    if(String.valueOf(id).equals(brand))
    out.print(" SELECTED ");
    out.print(" >"+b_obj.getName(teasession._nLanguage));
  }
  %>
</select></td>
  <td><input type=submit onClick="form1.action='<%=request.getRequestURI()%>';form1.nexturl.value='';return true;" value="查询" ></td></tr>
</table>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr ID=tableonetr >
    <td>会员</td>
    <td>姓名</td>
    <td>E-Mail</td>
    <td>消费</td>
    <td>笔数</td>
    <td>利润</td>
    <td></td>
  </tr>
<%
sum_sum=0;
sum_agent=sum_total=java.math.BigDecimal.ZERO;

agentmember(out,community,teasession._nLanguage,teasession._rv._strV,c_p.getAgent(),0,sql.toString());

%>
  <tr  >
    <td></td>
    <td></td>
    <td>总计:</td>
    <td><%=sum_total%></td>
    <td><%=sum_sum%></td>
    <td><%=sum_agent%></td>
    <td></td>
  </tr>
</table>
<input type="submit" value="创建" onClick="form1.member.disabled=true;" >

</form>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>



