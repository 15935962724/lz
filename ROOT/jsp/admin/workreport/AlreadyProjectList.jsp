<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.*"  %><%@ page  import="tea.entity.admin.*" %><%@ page  import="tea.htmlx.*" %><%@ page import="tea.ui.TeaSession" %><%@ page import="tea.entity.member.*" %><%@page import="java.util.*" %>
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
System.out.println(workproject);
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

StringBuffer sql = new StringBuffer();
StringBuffer param = new StringBuffer();
param.append("?id=").append(request.getParameter("id"));

boolean f=false;

String time_c = teasession.getParameter("time_c");
if(time_c!=null && time_c.length()>0)
{
  sql.append(" AND timemoney >=").append(DbAdapter.cite(time_c));
  param.append("&time_c=").append(time_c);
   f = true;
}
String time_d = teasession.getParameter("time_d");
if(time_d!=null && time_d.length()>0)
{
  sql.append(" AND timemoney <=").append(DbAdapter.cite(time_d));
  param.append("&time_d=").append(time_d);
   f = true;
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
     f = true;
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
     f = true;
  }
}




int pos = 0, pageSize = 10, count = 0;
if (request.getParameter("pos") != null) {
  pos = Integer.parseInt(request.getParameter("pos"));
}

//默认的是当前时间的一年
if(!f)
{
  java.util.Date times = new java.util.Date();
  GregorianCalendar gc = new GregorianCalendar();
  gc.setTime(times);
  gc.add(1, -1);
  gc.set(gc.get(Calendar.YEAR),gc.get(Calendar.MONTH),gc.get(Calendar.DATE));
  gc.getTime();
  sql.append(" AND timemoney >=").append(DbAdapter.cite(gc.getTime()));
}

count = Already.count(teasession._strCommunity,sql.toString());
sql.append(" ORDER BY timemoney DESC");
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
    <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
      <META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<%@include file="/jsp/include/Canlendar4.jsp" %>
<body  <%if(flowitem>0)out.print("onload='f_w("+flowitem+");'");%>>
<script type="">
function f_c(igd)
{
  var y ='edge:raised;scroll:0;status:0;help:0;resizable:0;dialogWidth:557px;dialogHeight:385px;';
  var url = '/jsp/admin/workreport/AlreadyShow.jsp?alid='+igd;
  window.showModalDialog(url,self,y);
}
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

<h1>项目收款记录</h1>
<div id="head6"><img height="6" src="about:blank"></div>
  <h2>查询</h2>
  <form name=form1 method="POST" action="?">
    <input type="hidden" name="id" value="<%=request.getParameter("id")%>"/>
    <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
      <tr>
        <td>收款日期：</td>
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
    <h2>列表(项目收款记录共&nbsp;<%=count %>&nbsp;条)</h2>
    <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
      <tr id="tableonetr">
        <td nowrap>客户项目</td>
        <td nowrap>收款日期</td>
        <td nowrap>收款项目</td>
        <td nowrap>收款方式</td>
        <td nowrap>甲方经办人</td>
        <td nowrap>乙方经办人</td>
        <td nowrap>收款金额</td>
        <td nowrap>&nbsp;</td>
      </tr>
      <%
      java.util.Enumeration e = Already.find(teasession._strCommunity,sql.toString(),pos,pageSize);
      if(!e.hasMoreElements())
      {
        out.print("<tr><td colspan=10 align=center>暂无记录</td></tr>");
      }
      while(e.hasMoreElements())
      {
        int alid = ((Integer)e.nextElement()).intValue();
        Already  alobj = Already.find(alid);
        Profile pobja = Profile.find(alobj.getMembera());
        Profile pobjb = Profile.find(alobj.getMemberb());
        Flowitem fobj = Flowitem.find(alobj.getFlowitem());
        %>
        <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
           <td><a href="/jsp/admin/workreport/FlowitemShow.jsp?flowitem=<%=alobj.getFlowitem()%>"><%=fobj.getName(teasession._nLanguage)%></a></td>
          <td align="center"><%=alobj.getTimemoneyToString()%></td>
          <td><%=alobj.getProject()%></td>
          <td align="center"><%=Already.WAY_TYPE[alobj.getWay()]%></td>
          <td><%=pobja.getLastName(teasession._nLanguage)+pobja.getFirstName(teasession._nLanguage) %></td>
          <td><%=pobjb.getLastName(teasession._nLanguage)+pobjb.getFirstName(teasession._nLanguage)%></td>
          <td><%=alobj.getAmount()%></td>
          <td align="center"> <a href="#" onclick="f_c('<%=alid%>');"><img alt="" src="/tea/image/public/eye.gif" title="查看详情"></a></td>
        </tr>
        <%} %>

        <tr>
          <td colspan="5">&nbsp;</td>
          <td align="right"><b>维护费用合计：</b></td>
          <td>&nbsp;<%=Already.getTotalamount(teasession._strCommunity,sql.toString()) %>&nbsp;元</td>
          <td >&nbsp;</td>
        </tr>

        <%if (count > pageSize) { %>
        <tr> <td colspan="10" id="tdpage"><%=new tea.htmlx.FPNL(teasession._nLanguage,request.getRequestURI()+param.toString()+"&pos=",pos,count,pageSize)%>    </td> </tr>
        <%
      }
      %>

    </table>


</form>


</body>
</html>



