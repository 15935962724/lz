<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter" %>
<%@ page  import="tea.resource.Resource"  %>
<%@ page  import="tea.entity.csvclub.*" %>
<%@ page import="tea.entity.member.*" %>
<%@ page import="tea.ui.TeaSession" %>
<%@ page import="tea.entity.integral.*"%>
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


Resource r=new Resource();
String memberid =request.getParameter("memberid");

StringBuffer param=new StringBuffer("?community="+teasession._strCommunity);
StringBuffer sql=new StringBuffer();//and (linetype=-1 or linetype =1)

String menu_id=(request.getParameter("id"));
if(menu_id!=null&&menu_id.length()>0)
{
  param.append("&id=").append(menu_id);
}
String members = request.getParameter("member");

if(members!=null && members.length()>0)
{

  sql.append(" and users like '%"+members+"%'");
  param.append("&member="+java.net.URLEncoder.encode(members,"UTF-8"));
}
int pos=0;
if(request.getParameter("pos")!=null)
{
  pos=Integer.parseInt(request.getParameter("pos"));
}
param.append("&pos=").append(pos);
int count=IntegralUpdate.findsum(teasession._strCommunity,sql.toString());



String order=request.getParameter("order");
//if(order==null)
//order="time";
//param.append("&order="+order);

String desc=request.getParameter("desc");
//if(desc==null)
//desc="asc";
//param.append("&desc="+desc);
//
//sql.append(" ORDER BY "+order+" "+desc);
int id = 0;
if(teasession.getParameter("id")!=null && teasession.getParameter("id").length()>0)
{
  /// out.print("@@@@@@@@@@@@@@@@@");
  id = Integer.parseInt(teasession.getParameter("id"));
  IntegralUpdate.updatestatic(id,2,teasession._strCommunity,teasession._rv.toString());
  IntegralUpdate objs = IntegralUpdate.find(id);
  objs.getUsers();
 // out.print(objs.getUsers());
  Profile pros = Profile.find(objs.getUsers());
  float sum=0;
  sum=pros.getIntegral()+(float)(objs.getAdd_int())-(float)(objs.getMinus_int());
  pros.setIntegral(sum);
}
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
  <h1>积分添加信息详细</h1>
  <br>
  <div id="head6"><img height="6" alt="" src=""></div>

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
        <td nowrap>会员ID</td>
        <td nowrap="nowrap">现有积分</td>
        <TD nowrap>添加积分</TD>
        <TD nowrap>扣除积分</TD>
        <td>管理员ID</td>
        <td>修改时间</td>
        <td>备注</td>
        <td>状态</td>
        <td></td>
      </tr>
      <%
      java.util.Enumeration enumer = IntegralUpdate.findByIntegral(teasession._strCommunity,sql.toString(),pos,10);
      if(!enumer.hasMoreElements())
      {
        out.print("<tr><td colspan=9 align=center>暂无记录</td></tr>");
      }
      for(int index=1;enumer.hasMoreElements();index++)
      {
        int ids =  Integer.parseInt(enumer.nextElement().toString());
        IntegralUpdate obj = IntegralUpdate.find(ids);
        String member = obj.getUsers();
        Profile probj = Profile.find(obj.getUsers());
        %>
        <tr onMouseOver="javascript:this.bgColor='#FFFDE4'" onMouseOut="javascript:this.bgColor=''">
          <td width="1"><%=index%></td>
          <td nowrap><a href="/jsp/csvclub/csvmember/Memberdetail.jsp?member=<%=member%>"><%=member%></a></td>
          <td nowrap="nowrap"><%=probj.getIntegral()%></td>
          <td nowrap><%=obj.getAdd_int()%></td>
          <td nowrap><%=obj.getMinus_int()%></td>
          <td nowrap><%=obj.getMember()%></td>
          <td nowrap="nowrap"><%=Profile.sdf.format(obj.getUpdatetimes()) %></td>
          <td  nowrap="nowrap"><%=obj.getRemarks()%></td>
          <td nowrap="nowrap"><%=IntegralUpdate.STATIC[obj.getStatics()]%></td>
          <td>

          <%
          if(obj.getStatics()!=2)
          {
          %>
            <a href="/jsp/csvclub/integral/IntegralhandworkAdd.jsp?member=<%=member%>&ids=<%=index%>">编辑</a>
            <input type="button" onclick="location='/jsp/integral/IntegralhandUser.jsp?id=<%=ids%>'" value="审核"/>
          <%
          }
          %>
          </td>
        </tr>
        <%
        }
        %>
        <tr><td colspan="10" align="center"><%=new tea.htmlx.FPNL(teasession._nLanguage,"?"+param.toString().replaceFirst("&pos=","&")+"&pos=",pos,count,10)%></td></tr>
        <tr><td colspan="10" align="center"><input type="button" name="Submit2" value="返回" onClick="window.history.back();"></td></tr>
    </table>
    <p>
      <input type="hidden" name="sql" value="<%=sql %>">
      <input type="hidden" name="pos" value="<%=pos %>">
    </p>
    </form>
    <br>
    <div id="head6"><img height="6" alt="" src=""></div>
  </body>
</html>



