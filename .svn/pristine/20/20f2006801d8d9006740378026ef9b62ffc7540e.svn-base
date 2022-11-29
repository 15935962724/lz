<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter" %>
<%@ page  import="tea.resource.Resource"  %>
<%@ page  import="tea.entity.csvclub.*" %>
<%@ page import="tea.entity.member.*" %>
<%@ page import="tea.ui.TeaSession" %>
<%@ page import="tea.entity.integral.*" %>

<jsp:directive.page import="tea.resource.Common"/><%
request.setCharacterEncoding("UTF-8");

response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
  return;
}

String member = teasession._rv._strV;

Resource r=new Resource();
String memberid =request.getParameter("memberid");


StringBuffer param=new StringBuffer("?community="+teasession._strCommunity);
StringBuffer sql=new StringBuffer();//and (linetype=-1 or linetype =1)

String menu_id=(request.getParameter("id"));
if(menu_id!=null&&menu_id.length()>0)
{
  param.append("&id=").append(menu_id);
}




int id_int = 0;
if(teasession.getParameter("ids")!=null && teasession.getParameter("ids").length()>0)
{
  id_int = Integer.parseInt(teasession.getParameter("ids"));
  IntegralUpdate.updatestatic(id_int,2,teasession._strCommunity,member);
}







int pos=0;
if(request.getParameter("pos")!=null)
{
  pos=Integer.parseInt(request.getParameter("pos"));
}
param.append("&pos=").append(pos);


int count=IntegralUpdate.findsum(teasession._strCommunity,sql.toString());



String order=request.getParameter("order");
if(order==null)
order="updatetimes";
param.append("&order="+order);

String desc=request.getParameter("desc");
if(desc==null)
desc="asc";
param.append("&desc="+desc);

sql.append(" ORDER BY "+order+" "+desc);


%>
<html>
  <head>
    <link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
    <SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js"></SCRIPT>
    <SCRIPT LANGUAGE=JAVASCRIPT SRC="/jsp/csvclub/js.js"></SCRIPT>
    <SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/load.js"></SCRIPT>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
        <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
          <META HTTP-EQUIV="Expires" CONTENT="0">
  </head>
  <body>
  <script>
  function sub(s)
  {

    currentPos = "show";
    send_request("/jsp/csvclub/Csv_ajax.jsp?no=no&s="+s);

  }
  </script>
  <h1>会员积分管理</h1>
  <br>
  <div id="head6"><img height="6"></div>
    <h2>查询</h2>
    <FORM name=form1 METHOD=get action="<%=request.getRequestURI()%>" onSubmit="">
      <input type=hidden name="community" value="<%=teasession._strCommunity%>"/>
      <input type=hidden name="Node" value="<%=teasession._nNode%>"/>
      <input type=hidden name="order" value="<%=order%>"/>
      <input type=hidden name="desc" value="<%=desc%>"/>

      <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
        <tr>
          <td>管理员ID：<input name="members" value="">
          </td>
          <td>会员ID：<input name="membernumber" value="">
          </td>
          <td><input type="submit" value="查询"/><!--<input type="submit" value="高级查询"/> -->
</td>
        </tr>
      </table>
</form>
<form method="POST" action="" name="form2">
<input type=hidden name="community" value="<%=teasession._strCommunity%>"/>
<input type=hidden name="Node" value="<%=teasession._nNode%>"/>
<input type=hidden name="csvservice" value="0"/>
<input type=hidden name="action" value="Csvmembers_2">
<input type=hidden name="nexturl" value="<%=request.getRequestURI()+"?"+request.getQueryString()%>"/>

<h2>列表(<%=count%>)</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr id="tableonetr">
    <td nowrap width="1" ></td>
    <td nowrap>管理员ID</td>
    <td>添加积分</td>
    <td>删除积分</td>
    <TD nowrap>时间</TD>
    <TD nowrap>对应会员ID</TD>
    <td nowrap="nowrap">审批的管理员ID</td>
    <td>原因</td>
    <td>状态</td>
    <td></td>
  </tr>
  <%
  java.util.Enumeration prme = IntegralUpdate.findByIntegral(teasession._strCommunity,sql.toString(),pos,10);
  if(!prme.hasMoreElements())
  {
    out.print("<tr><td colspan=10 >暂无记录</td></tr>");
  }
  for(int index=1;prme.hasMoreElements();index++)
  {
     int ids =  Integer.parseInt(prme.nextElement().toString());

    IntegralUpdate integerobj = IntegralUpdate.find(ids);

    %>
    <tr onMouseOver="javascript:this.bgColor='#FFFDE4'" onMouseOut="javascript:this.bgColor=''">
      <td width="1"><%=index%></td>
      <td nowrap><%=integerobj.getMember()%></td>
      <td nowrap><%=integerobj.getAdd_int()%></td>
      <td nowrap><%=integerobj.getMinus_int()%></td>
      <td nowrap><%=IntegralUpdate.sdf.format(integerobj.getUpdatetimes()) %></td>
      <td nowrap><%=integerobj.getUsers()%></td>
      <td nowrap><%=integerobj.getMemberps()%></td>
      <td nowrap="nowrap" ><%if(integerobj.getRemarks()!=null && integerobj.getRemarks().length()>0){out.print(integerobj.getRemarks());}%></td>
      <td nowrap="nowrap"><%=IntegralUpdate.STATIC[integerobj.getStatics()]%></td>
      <td nowrap="nowrap"><input type="button"  onclick="window.open('/jsp/integral/IntegralManageNode.jsp?ids=<%=ids%>','_self')"  value="通过审核"/></td>
    </tr>
    <%
    }
    %>
    <tr><td colspan="10" align="center"><%=new tea.htmlx.FPNL(teasession._nLanguage,"?"+param.toString().replaceFirst("&pos=","&")+"&pos=",pos,count,10)%></td></tr>
</table>
</form>
<br>
<div id="head6"><img height="6"></div>
  </body>
</html>



