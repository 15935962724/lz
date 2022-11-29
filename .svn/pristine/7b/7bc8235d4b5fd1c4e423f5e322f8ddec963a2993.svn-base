<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter"%>
<%@ page import="tea.resource.Resource"%>
<%@ page import="tea.entity.admin.*" %>
<%@ page import="tea.entity.member.*"%>
<%@ page import="tea.ui.TeaSession" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%
request.setCharacterEncoding("UTF-8");

response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String menuid=request.getParameter("id");

StringBuffer param=new StringBuffer();
param.append("?community=").append(teasession._strCommunity);
param.append("&id=").append(menuid);

StringBuffer sql=new StringBuffer(" and labname=").append(DbAdapter.cite(teasession._rv.toString()));

//String labname=request.getParameter("labname");
//if(labname!=null&&(labname=labname.trim()).length()>0)
//{
//  sql.append(" AND labname in (select member from Profilelayer where lastname like "+DbAdapter.cite("%"+labname+"%")+" or firstname like "+DbAdapter.cite("%"+labname+"%")+")");
//  param.append("&labname="+java.net.URLEncoder.encode(labname,"UTF-8"));
//}
//
//String card=request.getParameter("card");
//if(card!=null&&(card=card.trim()).length()>0)
//{
//  sql.append(" AND card in (select card from Profile where card like "+DbAdapter.cite("%"+card+"%")+")");
//  param.append("&card="+java.net.URLEncoder.encode(card,"UTF-8"));
//}

String time_s=request.getParameter("time_s");
if(time_s!=null&&(time_s=time_s.trim()).length()>0)
{
  sql.append(" AND changetime <=").append(DbAdapter.cite(time_s));
  param.append("&time_s="+java.net.URLEncoder.encode(time_s,"UTF-8"));
}

String time_j=request.getParameter("time_j");
if(time_j!=null&&(time_j=time_j.trim()).length()>0)
{
  sql.append(" AND changetime >=").append(DbAdapter.cite(time_j));
  param.append("&time_j="+java.net.URLEncoder.encode(time_j,"UTF-8"));
}

int count=Laborage.count(teasession._strCommunity,sql.toString());
int size=10;
int pos=0;
if(request.getParameter("pos")!=null)
{
  pos=Integer.parseInt(request.getParameter("pos"));
}
param.append("&pos=").append(pos);


sql.append(" ORDER BY times desc  ");

%>
<html>
  <head>
    <link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
    <SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type="text/javascript"></SCRIPT>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
        <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
          <META HTTP-EQUIV="Expires" CONTENT="0">
  </head>


  <body>

  <h1>员工工资管理</h1>
  <br>
  <div id="head6"><img height="6" src="about:blank"></div>
    <h2>查询</h2>
    <form name=form1 METHOD=post  action="?">
      <input type=hidden name="act" />
      <input type="hidden" name="nexturl" value="<%=request.getRequestURL()%>">
      <input type="hidden" name="laborage" />
      <input type=hidden name="files" value="importkind">
      <input type="hidden" name="id" value="<%=menuid%>" />

      <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
        <tr>
          <td>日期
            <input name="time_s" size="10"  value="<%if(time_s!=null)out.print(time_s);%>"><A href="###"><img onClick="showCalendar('form1.time_s');" src="/tea/image/public/Calendar2.gif" align="top"/></a>
              -<input name="time_j" size="10"  value="<%if(time_j!=null)out.print(time_j);%>"><A href="###"><img onClick="showCalendar('form1.time_j');" src="/tea/image/public/Calendar2.gif" align="top"/></a>

          </td>
          <td><input type="submit" value="查询"/></td>
        </tr>
      </table>

      <h2>列表</h2>
      <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
        <tr id="tableonetr">
          <td nowrap>序号</td>
          <td nowrap>转账时间</td>
          <td nowrap>出勤天数</td>
          <td nowrap>基本工资</td>
          <td nowrap>应发工资</td>
          <td nowrap>实发工资</td>
        </tr>
        <%
        java.util.Enumeration e = Laborage.find(teasession._strCommunity,sql.toString(),pos,size);
        for(int i=1;e.hasMoreElements();i++){

          int laborage = ((Integer)e.nextElement()).intValue();
          Laborage obj = Laborage.find(laborage);
          AdminUnit auobj = AdminUnit.find(obj.getBranch());
          AdminRole roobj = AdminRole.find(obj.getRole());
          Profile p = Profile.find(obj.getLabname());

          %>
          <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
            <td align="center" ><%=i%> </td>
            <td align="center" ><a href="/jsp/admin/laborage/showlaborage.jsp?laborage=<%=laborage%>" target="_blank"><%=obj.getChangetimeToString()%></a> </td>
            <td align="center" ><%=obj.getDays()%></td>
            <td align="center" ><%=obj.getBasiclab()%></td>
            <td align="center" ><%=obj.getShouldlab()%></td>
            <td align="center" ><%=obj.getFactlab()%></td>
          </tr>
          <%

          }if(count>size){
          %>
          <tr>
            <td colspan="5" align="center"><%=new tea.htmlx.FPNL(teasession._nLanguage,param.toString().replaceFirst("&pos=","&")+"&pos=",pos,count,size)%></td>
          </tr><%
          } %>
      </table>

      <br>

</form>


  <div id="head6"><img height="6" src="about:blank"></div>

  </body>
</HTML>



