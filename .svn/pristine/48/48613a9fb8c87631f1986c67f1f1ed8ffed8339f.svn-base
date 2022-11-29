<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter" %>
<%@ page  import="tea.resource.*"  %>
<%@ page  import="tea.entity.admin.*" %>
<%@ page  import="tea.htmlx.*" %>
<%@ page import="tea.ui.TeaSession" %>
<%@ page import="tea.entity.member.*" %>
<%@page import="java.text.*" %>
<%@page import="java.util.*" %>
<%@page import="java.util.Date" %>

<%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}
 //当前时间减去一年
GregorianCalendar gc = new GregorianCalendar();
Date d = new Date();
gc.setTime(d);
gc.add(1, -1);
gc.set(gc.get(Calendar.YEAR),gc.get(Calendar.MONTH),gc.get(Calendar.DATE));
d = gc.getTime();

 ///
String community=teasession._strCommunity;
String nexturl = request.getRequestURI()+"?"+request.getQueryString();
//修改项目是否为盈利
//Flowitem.setEatype(community," AND type = 0 ");

int eatype = 0;//默认为盈利项目  1 为非盈利项目
if(teasession.getParameter("eatype")!=null && teasession.getParameter("eatype").length()>0)
{
  eatype =Integer.parseInt(teasession.getParameter("eatype"));
}
StringBuffer sql=new StringBuffer(" AND type = 0 AND eatype =  "+eatype);
StringBuffer param=new StringBuffer();
param.append("?community=").append(community);
param.append("&id=").append(request.getParameter("id"));
param.append("&eatype=").append(eatype);
String time_c = teasession.getParameter("time_c");
if(time_c!=null && time_c.length()>0)
{
  sql.append(" AND ctime >=").append(DbAdapter.cite(time_c));
  param.append("&time_c=").append(time_c);
}
String time_d = teasession.getParameter("time_d");
if(time_d!=null && time_d.length()>0)
{
  sql.append(" AND ctime <=").append(DbAdapter.cite(time_d));
  param.append("&time_d=").append(time_d);
}
String fname =teasession.getParameter("fname");
if(fname!=null && fname.length()>0)
{
   sql.append(" AND flowitem IN (SELECT flowitem FROM FlowitemLayer WHERE name LIKE "+DbAdapter.cite("%"+fname+"%")+")");
   param.append("&fname=").append(java.net.URLEncoder.encode(fname,"UTF-8"));
}

int overallmoney =0;
if(teasession.getParameter("overallmoney")!=null && teasession.getParameter("overallmoney").length()>0)
{
  overallmoney =Integer.parseInt(teasession.getParameter("overallmoney"));
  param.append("&overallmoney=").append(overallmoney);
  sql.append("  and overallmoney=").append(overallmoney);
}


//默认日期显示
if((time_c!=null && time_c.length()>0) || (time_d!=null && time_d.length()>0 )||( fname!=null &&  fname.length()>0))
{} else
{
  sql.append(" AND ctime >=").append(DbAdapter.cite(d)).append(" AND ctime <=").append(DbAdapter.cite(new Date()));
}

int pos = 0, pageSize = 10, count = 0;
if (request.getParameter("pos") != null) {
  pos = Integer.parseInt(request.getParameter("pos"));
}
count = Flowitem.count(community,sql.toString());
StringBuffer sql2= new StringBuffer();
String o=request.getParameter("o");
if(o==null)
{
  o="ctime";
}
boolean aq=Boolean.parseBoolean(request.getParameter("aq"));
sql2.append(" ORDER BY ").append(o).append(" ").append(aq?"ASC":"DESC");
param.append("&o=").append(o).append("&aq=").append(aq);
%>
<html>
<head>
<title><%if(eatype==0){out.print("盈利项目统计");}else if(eatype==1){out.print("非盈利项目统计");}%></title>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<body>
<script>
function f_order(v)
{
  var aq=form1.aq.value=="true";
  if(form1.o.value==v)
  {
    form1.aq.value=!aq;
  }else
  {
    form1.o.value=v;
  }
  form1.action="?";
  form1.submit();
}




</script>
<h1><%if(eatype==0){out.print("盈利项目统计");}else if(eatype==1){out.print("非盈利项目统计");}%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
  <br>

  <h2>查询</h2>
  <form name="form1" METHOD=get action=?" >
   <input type="hidden" name="o" VALUE="<%=o%>">
  <input type="hidden" name="aq" VALUE="<%=aq%>">
  <input type="hidden" name="id" value="<%=request.getParameter("id")%>">
    <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">

      <tr>
        <td>项目名称:</td>
        <td><input name="fname" value="<%if(fname!=null)out.print(fname);%>"></td>
          <td>立项时间:</td>
          <td>&nbsp;
            从&nbsp;<input name="time_c" size="7"  value="<%if(time_c!=null)out.print(time_c);%>"><A href="###"><img onclick="showCalendar('form1.time_c');" src="/tea/image/public/Calendar2.gif" align="top"/></a>&nbsp;
              到&nbsp;<input name="time_d" size="7"  value="<%if(time_d!=null)out.print(time_d);%>"><A href="###"><img onclick="showCalendar('form1.time_d');" src="/tea/image/public/Calendar2.gif" align="top"/></a>&nbsp;
          </td>
          <td><input type="submit" value="查询"/></td>
      </tr>
    </table>

    <h2>
    <%

    //默认日期显示
    if((time_c!=null && time_c.length()>0) || (time_d!=null && time_d.length()>0 )||( fname!=null &&  fname.length()>0))
    {} else
    {
      //sql.append(" AND ctime >=").append(DbAdapter.cite(d)).append(" AND ctime <=").append(DbAdapter.cite(new Date()));
      out.print("&nbsp;从&nbsp;"+Flowitem.sdf.format(d)+"&nbsp;开始&nbsp;到&nbsp;"+Flowitem.sdf.format(new Date())+"&nbsp;结束");
    }
    if(fname!=null && fname.length()>0)
    {
      out.print("项目名称：&nbsp;");
      out.print(fname+"&nbsp;&nbsp;");
    }
    if((time_c!=null && time_c.length()>0 ))
    {
      out.print("立项时间：&nbsp;从&nbsp;");
      out.print(time_c+"&nbsp;开始&nbsp;");
    }

    if(time_d!=null && time_d.length()>0)
    {
      out.print("&nbsp;到&nbsp;");
      out.print(time_c+"&nbsp;结束&nbsp;");
    }
    %>
    <%if(eatype==0){out.print("盈利项目统计");}else if(eatype==1){out.print("非盈利项目统计");}%>一览表 (&nbsp;共统计项目<%=count%>个&nbsp;):
    </h2>
    <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
      <tr id="tableonetr">
        <td nowrap width="1">&nbsp;</td>
        <td nowrap>项目名称</td>
        <td nowrap>总体收入</td>
        <td nowrap>实际收入</td>
        <td nowrap>市场费用</td>
        <td nowrap>人员成本</td>
        <td nowrap>其它成本</td>
        <td nowrap> <%if(eatype==0){ out.print("公司利润");}else if(eatype==1){out.print("公司投入");}//（自动计算：实际收入-市场费用-人员成本-其它成本，然后去负号）}%></td>
       <%if(eatype==0){ %> <td nowrap>人员奖金</td><%} %>
       <td nowrap><a href="javascript:f_order('ctime');">立项时间</a>
       <%
       if(o.equals("ctime"))
       {
         if(aq)
         out.print("↓");
         else
         out.print("↑");
       }
       %></td>
      </tr>
      <%
      java.util.Enumeration e = Flowitem.find(community,sql.toString()+sql2.toString(),pos,pageSize);
      if(!e.hasMoreElements())
      {
        out.print("<tr><td colspan=10 align=center>暂无记录</td></tr>");
      }
      int i =1;
       //实际收入汇总
      while(e.hasMoreElements())
      {
        int  fid = ((Integer)e.nextElement()).intValue();
        Flowitem fobj = Flowitem.find(fid);
        //人员奖金=实际收入-市场费用-人员成本-其它成本-公司利润）
        java.math.BigDecimal bonus = new java.math.BigDecimal("0");
        //公司投入
        java.math.BigDecimal profits = new java.math.BigDecimal("0");
        java.math.BigDecimal gs = new java.math.BigDecimal("0");

        if(eatype==0){//盈利项目时候

      //  profits=fobj.getProfits(); //公司利润

        //自动计算：实际收入-市场费用-人员成本-其它成本
        gs =  Already.getAmountTotalSum(fid," and atype=0").subtract(Already.getAmountTotalSum(fid," and atype=1")).subtract(new java.math.BigDecimal(Worklog.getMembercost(teasession._strCommunity,fid))).subtract(Already.getAmountTotalSum(fid," and atype=2"));
        //如果 gs> 预计利润 则 公司利润显示 是 预计利润 人员奖金 显示为 余数
        if(gs.compareTo(fobj.getProfits())==1)
        {
          profits =fobj.getProfits();
          bonus = Already.getAmountTotalSum(fid," and atype=0").subtract(Already.getAmountTotalSum(fid," and atype=1")).subtract(new java.math.BigDecimal(Worklog.getMembercost(teasession._strCommunity,fid))).subtract(Already.getAmountTotalSum(fid," and atype=2")).subtract(fobj.getProfits());
        }else if(gs.compareTo(fobj.getProfits())==0)
        {
           profits =fobj.getProfits();
        }else if (gs.compareTo(fobj.getProfits())==-1)
        {
          profits =gs;
        }
      }else if(eatype==1)//非盈利项目
      {
        //公司投入（自动计算：实际收入-市场费用-人员成本-其它成本，然后去负号）
        profits = Already.getAmountTotalSum(fid," and atype=0 ").subtract(Already.getAmountTotalSum(fid," and atype=1 ")).subtract(new java.math.BigDecimal(Worklog.getMembercost(teasession._strCommunity,fid))).subtract(Already.getAmountTotalSum(fid," and atype=2 "));
        profits=new java.math.BigDecimal("0").subtract(profits);
      }
      %>
       <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
       <td width="1"><%=i%></td>
       <td><a href="/jsp/admin/workreport/EditFlowitem.jsp?flowitem=<%=fid%>&nexturl=<%=request.getRequestURI()+"?"+request.getQueryString()%>"><%=fobj.getName(teasession._nLanguage)%></a></td>
       <td ><%=fobj.getOverallmoney()%></td>
       <td ><%=Already.getAmountTotalSum(fid," and atype=0 ") %></td>
       <td  title="<%=Already.getAmountTotalSum(fid," and atype=1 ").toString() %>"><%=Already.getAmountTotalSum(fid," and atype=1 ") %></td>
       <td ><%=Worklog.getMembercost(teasession._strCommunity,fid)%></td>
       <td  title="<%=Already.getAmountTotalSum(fid," and atype=2 ").toString()%>"><%=Already.getAmountTotalSum(fid," and atype=2 ")%></td>
       <td ><%=profits%></td>
     <%  if(eatype==0){%>  <td ><%=bonus%></td><%} %>
        <td ><%=fobj.getCtimeToString()%></td>
       </tr>
      <% i++;} %>
      <%if(count>0){%>
      <tr>
        <td>&nbsp;</td>
        <td  align="right"><b>合计：</b></td>
        <td><%=Flowitem.getCollect(teasession._strCommunity,"overallmoney",sql.toString()) %></td><!-- 总体收入-->
        <td><%=Flowitem.getAmountTotal(teasession._strCommunity,sql.toString()) %></td><!--实际收入 -->
        <td><%=Flowitem.getCollect(teasession._strCommunity,"1",sql.toString()) %></td><!-- 市场费用-->
        <td><%=Flowitem.getMembercost(teasession._strCommunity,sql.toString()) %></td><!-- 人员成本-->
        <td><%=Flowitem.getCollect(teasession._strCommunity,"2",sql.toString()) %></td><!--其它成本 -->
        <td><%
        if(eatype==0){//公司利润
        out.print( Flowitem.getCompanyProfits(teasession._strCommunity,sql.toString())[0] );
        }else if(eatype==1)//公司投入
        {
          out.print(Flowitem.getNoCollect(teasession._strCommunity,sql.toString()));
        }

        %></td><!--公司利润 -->
       <%if(eatype==0){ %> <td><%out.print( Flowitem.getCompanyProfits(teasession._strCommunity,sql.toString())[1] ); %></td><%} %><!--人员奖金 -->
       <td>&nbsp;</td>
      </tr>
      <%} %>
        <%if (count > pageSize) {  %>
      <tr> <td colspan="10"><%=new tea.htmlx.FPNL(teasession._nLanguage,request.getRequestURI()+param.toString()+"&pos=",pos,count,pageSize)%>    </td> </tr>
      <%}  %>
    </table>


</form>
<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
