<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.*"  %><%@ page  import="tea.entity.admin.*" %><%@ page  import="tea.htmlx.*" %><%@ page import="tea.ui.TeaSession" %><%@ page import="tea.entity.member.*" %><%@ page import="tea.entity.admin.*" %>
<%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}
if("workproject".equals(teasession.getParameter("act")))
{
  int workproject = 0;
  if(teasession.getParameter("workproject")!=null && teasession.getParameter("workproject").length()>0)
  {
   workproject= Integer.parseInt(teasession.getParameter("workproject"));
  }
  int flowitem = 0;
  if(teasession.getParameter("flowitem")!=null && teasession.getParameter("flowitem").length()>0)
  {
    flowitem= Integer.parseInt(teasession.getParameter("flowitem"));
  }

  java.util.Enumeration e = Flowitem.find(teasession._strCommunity," AND type = 0 AND workproject="+workproject,0,Integer.MAX_VALUE);
  out.print("<select name=flowitem>");
  out.print(" <option value=0>请选择项目</option>");
  while(e.hasMoreElements())
  {
    int fid=((Integer)e.nextElement()).intValue();
    Flowitem fobj = Flowitem.find(fid);
    out.print("<option value="+fid);
    if(flowitem==fid)
    {
      out.print(" SELECTED ");
    }
    out.print(">"+fobj.getName(teasession._nLanguage));
    out.print("</option>");
  }
  out.print("</select>");
  return;
}

String nexturl = request.getRequestURI()+"?"+request.getContextPath();
StringBuffer sql = new StringBuffer(" AND type = 0  AND pact !=''");//AND type=0
StringBuffer param = new StringBuffer();
param.append("?id=").append(request.getParameter("id"));
int outtype=0;
if(teasession.getParameter("outtype")!=null && teasession.getParameter("outtype").length()>0)
{
  outtype = Integer.parseInt(teasession.getParameter("outtype"));
}

param.append("&outtype=").append(outtype);
if(outtype==0){
  sql.append(" AND pacttime >=").append(DbAdapter.cite(new java.util.Date()));
}else
{
  sql.append(" AND pacttime<=").append(DbAdapter.cite(new java.util.Date()));
}
String time_c = teasession.getParameter("time_c");
if(time_c!=null && time_c.length()>0)
{
  sql.append(" AND nextcosttime >=").append(DbAdapter.cite(time_c));
  param.append("&time_c=").append(time_c);
}
String time_d = teasession.getParameter("time_d");
if(time_d!=null && time_d.length()>0)
{
  sql.append(" AND nextcosttime <=").append(DbAdapter.cite(time_d));
  param.append("&time_d=").append(time_d);
}

//客户
int workproject =0;
if(teasession.getParameter("workproject")!=null && teasession.getParameter("workproject").length()>0)
{
  workproject = Integer.parseInt(teasession.getParameter("workproject"));
  if(workproject>0)
  {
    sql.append(" AND workproject = ").append(workproject);
    param.append("&workproject=").append(workproject);

  }
}
//项目
int flowitem =0;
if(teasession.getParameter("flowitem")!=null && teasession.getParameter("flowitem").length()>0)
{
  flowitem = Integer.parseInt(teasession.getParameter("flowitem"));
  if(flowitem>0)
  {
    sql.append(" AND flowitem = ").append(flowitem);
    param.append("&flowitem=").append(flowitem);

  }
}


int pos = 0, pageSize = 10, count = 0;
if (request.getParameter("pos") != null) {
  pos = Integer.parseInt(request.getParameter("pos"));
}

count = Flowitem.count(teasession._strCommunity,sql.toString());

sql.append(" ORDER BY nextcosttime DESC");
%>
<%@include file="/jsp/include/Canlendar4.jsp" %>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
    <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
      <META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<body <%out.print("onload='f_w("+flowitem+");'");%>>
<script type="">
function f_w(igd)
{
  sendx("?act=workproject&workproject="+form1.workproject.value+"&id="+form1.id.value+"&flowitem="+igd,
  function(data)
  {
    document.getElementById('show').innerHTML=data;
  }
  );
}


</script>

<h1>合同管理</h1>
<div id="head6"><img height="6" src="about:blank"></div>
  <h2>查询</h2>
  <form name=form1 method="POST" action="?">
<input type="hidden" name="outtype" value="<%=outtype%>"/>
     <input type="hidden" name="id" value="<%=request.getParameter("id")%>"/>
    <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
      <tr>
        <td>交费日期：</td>
        <td>
        从&nbsp;
        <input name="time_c" size="7"  value="<%if(time_c!=null)out.print(time_c);%>">
        <img style="margin-bottom:-8px;" src="/tea/image/bbs_edit/table.gif" onclick="new Calendar('<%=tea.entity.site.Community.getYear(10,"-")%>', '<%=tea.entity.site.Community.getYear(10,"+")%>', 0,'yyyy-MM-dd').show(time_c);" alt="" />
        &nbsp;到&nbsp;
        <input name="time_d" size="7"  value="<%if(time_d!=null)out.print(time_d);%>">
        <img style="margin-bottom:-8px;" src="/tea/image/bbs_edit/table.gif" onclick="new Calendar('<%=tea.entity.site.Community.getYear(10,"-")%>', '<%=tea.entity.site.Community.getYear(10,"+")%>', 0,'yyyy-MM-dd').show(time_d);" alt="" />
        </td>
           <td>客户项目：</td>
        <td>
        <select name="workproject" onchange="f_w('<%=flowitem%>');">
        <option value="0">请选择客户</option>
        <%
           java.util.Enumeration we =   Workproject.find(teasession._strCommunity,"",0,Integer.MAX_VALUE);
           while(we.hasMoreElements())
           {
             int wid = ((Integer)we.nextElement()).intValue();
             Workproject wobj =   Workproject.find(wid);
             out.print("<option value="+wid);
             if(workproject==wid)
             {
               out.print(" SELECTED ");
             }
             out.print(">"+wobj.getName(teasession._nLanguage));
             out.print("</option>");
           }
        %>
        </select>
        <span id="show">
          <select name="flowitem">
            <option value="0">请选择项目</option>
          </select>
        </span>
        </td>
        <td><input type="submit" value="查询"/></td>
      </tr>
    </table>
    <h2><%if(outtype==0){out.print("运营中的项目合同");}else{out.print("终止合同");}%>列表(共有合同&nbsp;<%=count %>&nbsp;份)</h2>
    <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
      <tr id="tableonetr">
        <td nowrap>合同编号</td>
        <td nowrap>客户</td>
        <td nowrap>客户项目</td>
        <td nowrap>总金额</td>
        <td nowrap>维护费</td>
         <td nowrap>交费周期</td>
        <td nowrap>交费日期</td>
        <td nowrap>&nbsp;</td>
      </tr>
      <%

      java.util.Enumeration e = Flowitem.find(teasession._strCommunity,sql.toString(),pos,pageSize);
      if(!e.hasMoreElements())
      {
        out.print("<tr><td colspan=10 align=center>暂无记录</td></tr>");
      }
      while(e.hasMoreElements())
      {
        int flid = ((Integer)e.nextElement()).intValue();
        Flowitem flobj =Flowitem.find(flid);
        Workproject wobj = Workproject.find(flobj.getWorkproject());

        %>
        <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
          <td><%=flobj.getPact()%></td>
          <td><%=wobj.getName(teasession._nLanguage)%></td>
          <td><%=flobj.getName(teasession._nLanguage)%></td>
          <td><%=flobj.getOverallmoney() %></td>
          <td><%=flobj.getVindicate()%></td>
          <td align="center"><%if(flobj.getPeriod()==0){out.print("年");}else if(flobj.getPeriod()==1){out.print("月");}else{out.print("一次性");}%></td>
          <td align="center"><%=flobj.getNextcosttimeToString()%></td>
          <td><a href="/jsp/admin/workreport/FlowitemShow.jsp?flowitem=<%=flid%>"><img alt="" src="/tea/image/public/eye.gif" title="查看详情"></a></td>
        </tr>
        <%} %>
         <%if (count > pageSize) { %>
   <tr> <td colspan="10" id="tdpage"><%=new tea.htmlx.FPNL(teasession._nLanguage,request.getRequestURI()+param.toString()+"&pos=",pos,count,pageSize)%>    </td> </tr>
       <%} %>
    </table>
    <br>
<input type="button" value="添加合同" onclick="window.open('/jsp/admin/workreport/Contract2.jsp?nexturl=<%=nexturl%>','_self');" >&nbsp;
<%if(outtype==0){ %>
<input type="button" value="切换到终止的合同" onclick="window.open('/jsp/admin/workreport/Contract.jsp?outtype=1','_self');" >&nbsp;
<%}else{ %>
<input type="button" value="切换到运营中的合同" onclick="window.open('/jsp/admin/workreport/Contract.jsp','_self');" >&nbsp;
<%} %>


</form>
<br>
<div id="head6"><img height="6" src="about:blank"></div>

</body>
</html>



