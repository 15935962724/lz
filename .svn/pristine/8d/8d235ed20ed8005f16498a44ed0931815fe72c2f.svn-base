<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter" %>
<%@ page  import="tea.resource.Resource"  %>
<%@ page  import="tea.entity.admin.*" %>
<%@ page import="tea.ui.TeaSession" %>
<%


request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String community=teasession._strCommunity;
String nexturl = request.getRequestURI()+"?"+request.getContextPath();

Resource r=new Resource("/tea/resource/Workreport");

StringBuffer param=new StringBuffer("&community="+community);
StringBuffer sql=new StringBuffer(" AND vindicate!=0");

String menu_id=(request.getParameter("id"));
if(menu_id!=null&&menu_id.length()>0)
{
  param.append("&id=").append(menu_id);
}

String pname = teasession.getParameter("pname");
if(pname!=null && pname.length()>0)
{
  pname = pname.trim();
  sql.append(" AND flowitem in (SELECT flowitem FROM FlowitemLayer WHERE name  like "+DbAdapter.cite("%"+pname+"%")+" ) ");
  param.append("&pname=").append(java.net.URLEncoder.encode(pname,"UTF-8"));
}

String wname = teasession.getParameter("wname");
if(wname!=null && wname.length()>0)
{
  wname = wname.trim();
  sql.append(" AND workproject in (SELECT workproject FROM Workproject WHERE name like "+DbAdapter.cite("%"+wname+"%")+")");
  param.append("&wname=").append(java.net.URLEncoder.encode(wname,"UTF-8"));
}

String time_k = teasession.getParameter("time_k");
if(time_k!=null && time_k.length()>0)
{
  sql.append(" AND nextcosttime >=").append(DbAdapter.cite(time_k));
  param.append("&time_k=").append(time_k);
}

String time_j = teasession.getParameter("time_j");
if(time_j!=null && time_j.length()>0)
{
  sql.append(" AND nextcosttime <=").append(DbAdapter.cite(time_j));
  param.append("&time_j=").append(time_j);
}

int pos=0,size=20;
if(request.getParameter("pos")!=null)
{
  pos=Integer.parseInt(request.getParameter("pos"));
}

int count=Flowitem.count(community,sql.toString());

param.append("&pos=").append(pos);


sql.append(" order by nextcosttime asc ");
Flowitem.setPeriod(teasession._strCommunity,teasession._nLanguage);
//System.out.println(Flowitem.dispersionMonth2("2009-05-12","2010-01-12"));
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
<!--项目查阅-->
<h1><%=r.getString(teasession._nLanguage,"项目查阅")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
  <br>
  <h2>项目信息查询</h2>
  <form action="?" method="POST" name="form1">
<input type="hidden" value="<%=menu_id%>" name="id"/>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td>项目名称：<input type="text" name="pname" value="<%if(pname!=null)out.print(pname);%>"/></td>
      <td>所属客户：<input type="text" name="wname" value="<%if(wname!=null)out.print(wname);%>"/></td>
      <td>下次交费日期： <input name="time_k" size="7"  value="<%if(time_k!=null)out.print(time_k);%>"><A href="###"><img onclick="showCalendar('form1.time_k');" src="/tea/image/public/Calendar2.gif" align="top"/></a>&nbsp;至&nbsp;
      <input name="time_j" size="7"  value="<%if(time_j!=null)out.print(time_j);%>"><A href="###"><img onclick="showCalendar('form1.time_j');" src="/tea/image/public/Calendar2.gif" align="top"/></a>

      </td>
      <td><input type="submit" value="查询"/></td>

    </tr>
  </table>
</form>
  <h2>项目列表</h2>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr id="tableonetr">
      <td nowrap width="1"></td>
      <td nowrap>项目名称</td>
      <td nowrap>所属客户</td>
      <td nowrap>维护费用</td>
      <td nowrap>交费日期</td>
      <td>操作</td>
    </tr>
    <%

    java.util.Enumeration enumer=Flowitem.find(community,sql.toString(),pos,size);
    if(!enumer.hasMoreElements())
    {
      out.print("<tr><td colspan=10 align=center>暂无记录</td></tr>");
    }

    for(int index=1;enumer.hasMoreElements();index++)
    {
      int flowitem=((Integer)enumer.nextElement()).intValue();
      Flowitem obj=Flowitem.find(flowitem);
      Workproject workobj = Workproject.find(obj.getWorkproject());

      %>
      <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
        <td><%=index%></td>
        <td><%=obj.getName(teasession._nLanguage)%></td>
        <td><%=workobj.getName(teasession._nLanguage)%></td>
        <td><%=obj.getVindicate()%></td>
        <td><%=obj.getNextcosttimeToString() %></td>
        <td>
        <%

           if(obj.getType()>0){
           flowitem = obj.getType();

           }

        %>
         &nbsp;&nbsp; <a  href="/jsp/admin/workreport/EditFlowitem.jsp?act=edit&community=<%=community%>&flowitem=<%=flowitem%>&nexturl=<%=nexturl%>&workproject=<%=obj.getWorkproject()%>" target="_self"   >
           <img alt="" src="/tea/image/public/icon_edit.gif" title="编辑"></a>
          &nbsp;&nbsp;<a  href="/jsp/admin/workreport/EditFlowitem.jsp?delete=delete&act=edit&community=<%=community%>&flowitem=<%=flowitem%>&nexturl=<%=nexturl%>&workproject=<%=obj.getWorkproject()%>" target="_self"  >
            <img alt="" src="/tea/image/public/del.gif"  title="删除"></a>
        </td>
      </tr>

      <%
      }

      %>
       <tr>
      <td colspan="2">&nbsp;</td>
       <td align="right"><b>维护费用合计：</b></td>
       <td>&nbsp;<%=Flowitem.getCost(teasession._strCommunity,sql.toString()) %>&nbsp;元</td>
        <td >&nbsp;</td>
        <td >&nbsp;</td>
      </tr>
      <%if(count>size){ %>
      <tr><td colspan="6" align="center"><%=new tea.htmlx.FPNL(teasession._nLanguage,"?"+param.toString().replaceFirst("&pos=","&")+"&pos=",pos,count,size)%></td></tr>
      <%}%>
  </table>
  <div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>


