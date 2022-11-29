<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter"%> <%@ page import="tea.resource.Resource"%><%@ page import="tea.entity.admin.*" %><%@ page import="tea.entity.member.*" %><%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}
int language = teasession._nLanguage;
String community=teasession._strCommunity;//request.getParameter("community");

Resource r=new Resource();

StringBuffer sql=new StringBuffer();
StringBuffer param=new StringBuffer("?community=").append(teasession._strCommunity);
//只有项目创建者和项目经理可见
//sql.append(" AND ( creator="+DbAdapter.cite(teasession._rv._strV)+" OR manager LIKE "+DbAdapter.cite("%/"+teasession._rv._strV+"/%")+" )");
String timek = request.getParameter("timek");
if (timek != null && (timek = timek.trim()).length() > 0) {
  sql.append(" and nextcosttime>=").append(" ").append(DbAdapter.cite(timek));
  param.append("&timek=").append(timek);
}
String timej = request.getParameter("timej");
if (timej != null && (timej = timej.trim()).length() > 0) {
  sql.append(" and nextcosttime<").append(" ").append(DbAdapter.cite(timej));
  param.append("&timej=").append(timej);
}

String name=request.getParameter("name");
if(name!=null&&name.length()>0)
{
  sql.append(" AND flowitem IN (SELECT flowitem FROM FlowitemLayer WHERE name LIKE "+DbAdapter.cite("%"+name+"%")+")");
  param.append("&name=").append(java.net.URLEncoder.encode(name,"UTF-8"));
}
sql.append(" and vindicate <>0");
int pos = 0;
int pageSize = 10;
if (teasession.getParameter("Pos") != null) {
  pos = Integer.parseInt(teasession.getParameter("Pos"));
}
int count = Flowitem.count(community, sql.toString());

sql.append(" order by nextcosttime asc;");
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
<body>

<h1><%=r.getString(language,"PPM")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
  <br>

  <h2><%=r.getString(language,"Inquire")%></h2>
  <form name=foEdit METHOD=get action="<%=request.getRequestURI()%>" onSubmit="">
    <input type=hidden name="community" value="<%=community%>"/>
    <table border="1" cellpadding="0" cellspacing="0" id="tablecenter">
      <tr>
        <td align=center>
          <%=r.getString(language,"PaymentDate")%>：<%=r.getString(language,"From")%>&nbsp;<input name="timek" size="7" value="<%if(timek !=null)out.print(timek);%>">
            <A href="###">
              <img onClick="showCalendar('foEdit.timek');" src="/tea/image/public/Calendar2.gif" align="top"/></a>&nbsp;
              <%=r.getString(language,"To")%>：
              <input name="timej" size="7" value="<%if(timej!=null)out.print(timej);%>">
              <A href="###">
                <img onClick="showCalendar('foEdit.timej');" src="/tea/image/public/Calendar2.gif" align="top"/></a>
                　　　　<%=r.getString(language,"ProjectName")%>：<input name="name" value="<%if(name!=null)out.print(name);%>">
                  　　　　<input type="submit" value="<%=r.getString(language,"Search")%>"/></td></tr>
    </table>
</form>
<h2><%=r.getString(language,"List")%></h2>
<form name=form1 METHOD=get  action="/jsp/admin/flow/EditProDefend.jsp">
  <input type=hidden name="community" value="<%=community%>"/>
  <input type=hidden name="flowitem" value="0"/>
  <input type="hidden" name="nexturl" value="<%=request.getRequestURI()+"?"+request.getQueryString()%>"/>

  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr id="tableonetr">
      <td nowrap width="20%"><%=r.getString(language,"Nextcosttime")%></td>
      <td nowrap width="35%"><%=r.getString(language,"ProjectName")%></td>
      <td nowrap width="10%"><%=r.getString(language,"Vindicate")%></td>
      <td nowrap width="10%"><%=r.getString(language,"Pact")%></td>
      <td nowrap width="10%"><%=r.getString(language,"Overallmoney")%></td>
      <td width="20%"><%=r.getString(language,"operate")%></td>
    </tr>
    <%
    java.text.SimpleDateFormat sdf =new java.text.SimpleDateFormat("yyyy-MM-dd");
    java.util.Enumeration enumer=Flowitem.find1(community,sql.toString(),pos,pageSize);
    for(int index=1;enumer.hasMoreElements();index++)
    {
      int flowitem=((Integer)enumer.nextElement()).intValue();
      Flowitem obj=Flowitem.find(flowitem);

      %>
      <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
        <td align="center" nowrap><%=sdf.format(obj.getNextcosttime())%></td>
        <td nowrap><%=obj.getName(teasession._nLanguage)%></td>
        <td align="center" nowrap><%=obj.getVindicate()%>&nbsp;</td>
        <td align="center" nowrap><%=obj.getPact()%></td>
        <td align="center" nowrap><%=obj.getOverallmoney()%>&nbsp;</td>
        <td align="center" nowrap>
          <input type="submit" value="<%=r.getString(language,"EditPaymentDate")%>" onClick="form1.flowitem.value=<%=flowitem%>;"/>
        </td>
      </tr>
      <%
      }if(count > pageSize){
        %>
        <tr>
          <td colspan="6" align="center"><%=new tea.htmlx.FPNL(teasession._nLanguage, request.getRequestURI()+param.toString()+ "&Pos=", pos, count,pageSize)%>      </td>
        </tr>
        <%
        }
        %>
        </table>
</form>
<br>
<div id="head6"><img height="6" src="about:blank"></div>
  <script language="JavaScript">
  anole('',1,'','','','');
  /*tr_tableid, // table id
  num_header_offset,// 表头行数
  str_odd_color, // 奇数行的颜色
  str_even_color,// 偶数行的颜色
  str_mover_color, // 鼠标经过行的颜色
  str_onclick_color // 选中行的颜色
  */
  </script>
  </body>
</html>



