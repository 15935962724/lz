<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.resource.Resource" %>
<%@page import="tea.entity.admin.erp.*" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.ui.TeaSession" %>
<%@page import="tea.entity.admin.erp.*" %>
<%@page import="tea.entity.league.*" %>
<%@page import="tea.entity.util.*" %>

<%
  request.setCharacterEncoding("UTF-8");

  TeaSession teasession = new TeaSession(request);
  if (teasession._rv == null) {
    response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
    return;
  }
  String nexturl = request.getRequestURI()+"?"+request.getContextPath();



StringBuffer sql = new StringBuffer(" and ic.type=0");
StringBuffer param = new StringBuffer();
StringBuffer sql2=new StringBuffer(" and ic.type=0");
param.append("?id=").append(request.getParameter("id"));

int s1=0,s2=0,csarea=0;
if(teasession.getParameter("s1")!=null && teasession.getParameter("s1").length()>0)
{
  s1=Integer.parseInt(teasession.getParameter("s1"));
  sql.append("  and  province=").append(s1);
  sql2.append("  and  province=").append(s1);
  param.append("&s1=").append(s1);
}
if(teasession.getParameter("s2")!=null && teasession.getParameter("s2").length()>0)
{
  s2=Integer.parseInt(teasession.getParameter("s2"));
  sql.append("  and  city=").append(s2);
  sql2.append("  and  city=").append(s2);
  param.append("&s2=").append(s2);
}
if(teasession.getParameter("csarea")!=null && teasession.getParameter("csarea").length()>0)
{
  csarea=Integer.parseInt(teasession.getParameter("csarea"));
  if(csarea==0)
  {

  }
  else
  {
    sql.append("  and  csarea=").append(csarea);
    sql2.append("  and  csarea=").append(csarea);
    param.append("&csarea=").append(csarea);
  }
}

//分店类型
int lstype =0;
if(teasession.getParameter("lstype")!=null && teasession.getParameter("lstype").length()>0)
{
  lstype = Integer.parseInt(teasession.getParameter("lstype"));
  if(lstype>0)
  {
    sql.append(" AND lstype = ").append(lstype);
    param.append("&lstype=").append(lstype);
  }
}

//分店级别

int lsstype =0;
if(teasession.getParameter("lsstype")!=null && teasession.getParameter("lsstype").length()>0)
{
  lsstype = Integer.parseInt(teasession.getParameter("lsstype"));
  if(lsstype>0)
  {
    sql.append(" AND lsstype = ").append(lsstype);
    param.append("&lsstype=").append(lsstype);
  }
}

//分店名称
 String lsname=teasession.getParameter("lsname");
if(lsname!=null&& lsname.length()>0)
{
  sql.append(" AND lsname LIKE  "+DbAdapter.cite("%"+lsname+"%"));
  param.append("&lsname=").append(java.net.URLEncoder.encode(lsname,"UTF-8"));
}
//消费卡号
String icname = teasession.getParameter("icname");
if(icname!=null&& icname.length()>0)
{
  sql.append(" AND ics.icard LIKE  "+DbAdapter.cite("%"+icname+"%"));
  param.append("&icname=").append(java.net.URLEncoder.encode(icname,"UTF-8"));
}
//会员名称
String flname=teasession.getParameter("flname");
if(flname!=null && flname.length()>0)
{
  flname = flname.trim();
  sql.append(" AND ics.icard in (select member from ProfileLayer where firstname like "+DbAdapter.cite("%"+flname+"%")+" or lastname like "+DbAdapter.cite("%"+flname+"%")+"  )");
  param.append("&flname=").append(java.net.URLEncoder.encode(flname,"UTF-8"));
}


int pos = 0, pageSize = 10, count = 0;
if (request.getParameter("pos") != null) {
  pos = Integer.parseInt(request.getParameter("pos"));
}
count = ICSales.count2(sql.toString());
sql.append("  group   by  ic.icsales,ic.time order by ic.time desc   ");

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" language="javascript" src="/tea/tea.js"></script>
<title>分店销售情况监测</title>
</head>
<body id="bodynone">
<script type="">
   function f_excel()
    {
      form1.action='/servlet/ExportExcel';
      form1.submit();
    }
</script>

  <h1>分店销售情况监测</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<h2>查询</h2>
  <form action="?" name="form1" method="POST">
  <input type="hidden" name="id" value="<%=request.getParameter("id") %>"/>
  <input type="hidden" name="sql" value="<%=sql.toString()%>">
  <input type="hidden" name="files" value="分店销售情况监测表">
  <input type="hidden" name="act" value="SalesMonitor">
   <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr>
       <td>所属区域:</td>
       <td>
         <script src="/tea/card.js" type=""></script>
         <script type="">
         var delcct=new Array();
         function f_area(objcct)
         {
           var rscct=area[parseInt(objcct.value)][1];
           var op=form1.s1.options;
           for(var i=0;i<delcct.length;i++)
           {
             op[op.length]=new Option(delcct[i][0],delcct[i][1]);
           }
           delcct=new Array();
           for(var i=0;i<op.length;i++)
           {
             if(rscct.indexOf(op[i].value)==-1)
             {
               delcct[delcct.length]=new Array(op[i].text,op[i].value);
               op[i--]=null;
             }
           }
         }
         document.write("<select name='csarea' onchange=f_area(this)>");
         for(var i=0;i<area.length;i++)
         {
           document.write("<option value="+i+">"+area[i][0]+"</option>");
         }

         document.write("</select>　");
         selectcard("s1","s2",null,"<%=s2%>");
         if(<%=s1%>>0)
         {
           form1.s1.value='<%=s1%>';
         }
         form1.csarea.value="<%=csarea%>";
         form1.csarea.onchange();
         </script>
         </td>
         <td>分店类型:</td>
         <td><select  name="lstype" >
           <option  value="0">请选择分店类别</option>
           <%
           java.util.Enumeration eu = LeagueShopType.findByCommunity(teasession._strCommunity,"",0,Integer.MAX_VALUE);
           for(int i=0;eu.hasMoreElements();i++)
           {
             int idtt= Integer.parseInt(String.valueOf(eu.nextElement()));
             LeagueShopType objty = LeagueShopType.find(idtt);
             out.print("<option value="+idtt);
             if(lstype==idtt)
             {
               out.print(" selected ");
             }
             out.print(">"+objty.getLstypename()+"</option>");
           }
           %>
           </select>　
         </td>
     </tr>
     <tr>
       <td>分店级别:</td>
       <td>
         <select name="lsstype">
           <option  value="0">请选择分店级别</option>
           <%
           java.util.Enumeration   eu2 = LeagueShopServer.findByCommunity("","",0,Integer.MAX_VALUE);
           for(int i = 0;eu2.hasMoreElements();i++)
           {
             int id2 = Integer.parseInt(String.valueOf(eu2.nextElement()));
             LeagueShopServer obj2 = LeagueShopServer.find(id2);
             out.print("<option value="+id2);
             if(lsstype==id2)
             {    System.out.println(lsstype+"=="+id2);
             out.print(" selected ");
           }
           out.print(">"+obj2.getLssname()+"</option>");
         }
         %>
         </select>

         <td>分店名称:</td>
         <td><input type="text" name="lsname" value="<%if(lsname!=null)out.print(lsname);%>"/></td>
     </tr>
     <tr>
       <td>消费卡号:</td>
       <td><input type="text" name="icname" value="<%if(icname!=null)out.print(icname);%>"/></td>
       <td>会员名称:</td>
       <td><input type="text" name="flname" value="<%if(flname!=null)out.print(flname);%>"/></td>
       <td><input type="submit" value="查询"/></td>
     </tr>

   </table>

<h2><%
Card card11 = Card.find(s1);
Card card22 = Card.find(s2);
if(csarea>0)
{
  out.print("所在区域：&nbsp;");
  out.print(LeagueShop.CSAREA[csarea]+"&nbsp;");
}
if(s1>0)
{
  out.print(card11.getAddress()+"&nbsp;");
}
if(s2>0)
{
  out.print(card22.getAddress()+"&nbsp;&nbsp;");
}

if(lstype>0)
{
  out.print("分店类型：&nbsp;");
  LeagueShopType objty = LeagueShopType.find(lstype);
  if(objty.getLstypename()!=null)
  {
    out.print(objty.getLstypename()+"&nbsp;&nbsp;");
  }
}
if(lsstype>0)
{
  out.print("分店级别：&nbsp;");
  LeagueShopServer obj3 = LeagueShopServer.find(lsstype);
  if(obj3.getLssname()!=null)
  {
    out.print(obj3.getLssname()+"&nbsp;&nbsp;");
  }
}

if(lsname!=null && lsname.length()>0)
{
  out.print("分店名称：&nbsp;");
  out.print(lsname+"&nbsp;&nbsp;");
}
if(icname!=null && icname.length()>0)
{
   out.print("消费卡号：&nbsp;");
  out.print(icname+"&nbsp;&nbsp;");
}
if(flname!=null && flname.length()>0)
{
  out.print("会员名称：&nbsp;");
  out.print(flname+"&nbsp;&nbsp;");
}
  %>
（列表数量为：&nbsp;<%=count%>&nbsp; ）显示列表如下：</h2>


  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr id="tableonetr">
     <td nowrap>消费单号</td>
      <td nowrap>会员名称</td>
      <td nowrap>消费卡号</td>
      <td nowrap>消费商品数量</td>
      <td nowrap>消费总金额</td>
      <td nowrap>消费时间</td>
      <td nowrap>操作</td>
    </tr>
    <%

    java.util.Enumeration e = ICSales.findIcsales(sql.toString(),pos,pageSize);
    if(!e.hasMoreElements())
    {
      out.print("<tr><td colspan=10 align=center>暂无记录</td></tr>");
    }

   while(e.hasMoreElements()){
     String icid = ((String)e.nextElement());
     ICSales icobj = ICSales.find(icid);
    tea.entity.member.Profile pobj = tea.entity.member.Profile.find(ICSales.getIcMember(icid));
    %>
    <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
     <td><%=icid%></td>
      <td><%=pobj.getName(teasession._nLanguage)%></td>
       <td><%=ICSales.getIcMember(icid)%></td>
        <td ><%=icobj.getQuantity()%></td>
      <td ><%=icobj.getPrice()%>&nbsp;元</td>
      <td ><%=icobj.getTimeToString() %></td>
      <td align="center"><input type="button" value="查看详细" onclick="window.open('/jsp/leagueshop/SalesMonitorShow.jsp?icid=<%=icid%>&nexturl=<%=nexturl%>','_self');"/></td>
    </tr>
  <%} %>
  <%if(count>0){ %>
  <tr>
  <td colspan="2">&nbsp;</td>
  <td align="right"> <b>合计数量和金额:</b></td>
  <td align="center"><%=ICSales.getShuLiang(sql.toString())%></td>
   <td align="center"><%=ICSales.getJinE(sql.toString())%>&nbsp;</td>
  </tr>
  <%}
  if (count > pageSize) {  %>
      <tr> <td colspan="10"><%=new tea.htmlx.FPNL(teasession._nLanguage,request.getRequestURI()+param.toString()+"&pos=",pos,count,pageSize)%>    </td> </tr>
      <%}  %>

  </table>
  <br>
<input type="button" value="导出Excel表" onclick="f_excel();"/>
  </form>
  <div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
