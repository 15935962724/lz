<%@page contentType="text/html;charset=UTF-8"  %>
<%@ page import="tea.ui.TeaSession" %>
<%@ page import="tea.entity.bpicture.*" %>
<%@ page import="tea.entity.node.*" %>
<%@ page import="tea.db.*" %>
<%@page import="java.awt.image.*" %>
<%@page import="javax.imageio.*" %>
<%@page import="java.math.BigDecimal" %>
<%
TeaSession teasession = new TeaSession(request);
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");

int cwid=0;
if(teasession.getParameter("cwid")!=null && teasession.getParameter("cwid").length()>0)
{
  cwid = Integer.parseInt(teasession.getParameter("cwid"));
  Bimage.enterPrice(cwid,teasession._rv.toString());
}
StringBuffer sql = new StringBuffer("and picprice !=0");
StringBuffer param=new StringBuffer("?community=").append(teasession._strCommunity);

String menu_id=(request.getParameter("id"));
if(menu_id!=null&&menu_id.length()>0)
{
  param.append("&id=").append(menu_id);
}

String picid= request.getParameter("picid");
if(picid!=null&&picid.length()>0)
{
  sql.append(" and node like ").append("'%"+picid+"%'");
  param.append("&picid=").append(picid);
}

String member= request.getParameter("member");
if(member!=null&&member.length()>0)
{
  sql.append(" and  member like ").append(DbAdapter.cite("%"+member+"%"));
  param.append("&member=").append(DbAdapter.cite(member));
}

String saletype= "";
if(request.getParameter("saletype")!=null&&request.getParameter("saletype").length()>0&&!request.getParameter("saletype").equals("2"))
{
  saletype = request.getParameter("saletype");
  sql.append(" and picsalestype="+saletype);
  param.append("&saletype=").append(saletype);
}

int count = 0;
int pos = 0;
if (request.getParameter("pos") != null) {
  pos = Integer.parseInt(request.getParameter("pos"));
}


count=Bimage.countAll(teasession._strCommunity,sql.toString());
%>
<html>
<HEAD>
  <link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
  <script> if(parent.lantk) { document.getElementsByTagName("LINK")[0].href="/res/csvclub/cssjs/community_02.css"; } </script>
  <SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type="" ></SCRIPT>
  <SCRIPT LANGUAGE=JAVASCRIPT SRC="/jsp/csvclub/js.js" type=""></SCRIPT>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <META HTTP-EQUIV="Pragma" CONTENT="no-cache"/>
  <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache"/>
  <META HTTP-EQUIV="Expires" CONTENT="0"/>
  <title>财务审核</title>
	<style>
	#table005{width:95%;margin-top:15px;}
    #table005 td{background:#eee;padding:5px 10px;}
	.lzj_001{height:23px;border:1px solid #7F9DB9;background:#fff;line-height:20px;*line-height:14px;padding-bottom:5px;*paddding-bottom:0;}
	</style>
  </HEAD>
<body style="margin:0;">
<div id="wai">
<h1>
财务审核
</h1>
<form action="?" method="POST">
<input type="hidden" name="id" value="<%=request.getParameter("id")%>"/>
<table border="0" cellpadding="0" cellspacing="2" id="table005">
  <tr>
    <td>图片名称</td>
    <td><input type="text" name="picid" value="<%if(picid!=null)out.print(picid);%>"/></td>
    <td>买家</td>
    <td><input type="text" name="member" value="<%if(member!=null)out.print(member);%>"/></td>
    <td>状态</td>
    <td>
      <select name="saletype">
        <option value="2">全部</option>
        <option value="0" <%if(saletype.equals("0"))out.print("selected");%>>未确认</option>
        <option value="1" <%if(saletype.equals("1"))out.print("selected");%>>确认</option>
      </select>

    </td>
    <td><input type="submit" value="查询"/></td>
  </tr>
</table>
</form>

<h2>信息列表（<%=count%>）</h2>
<table border="0" cellpadding="0" cellspacing="2" id="table005">
  <tr>
    <td>订单号</td><td>图片名称</td><td>卖家</td><td>买家</td><td>价格</td><td>状态</td><td>操作</td>
  </tr>
  <%
  java.util.Enumeration eu = Bimage.findByCommunity(teasession._strCommunity,sql.toString(),pos,10);
  if(!eu.hasMoreElements())
  {
    out.print("<tr><td colspan=7 align=center>暂无记录</td></tr>");
  }
  while(eu.hasMoreElements())
  {
    int ids = Integer.parseInt(String.valueOf(eu.nextElement()));
    Bimage bi = Bimage.find(ids);
    Picture p = Picture.find(bi.getNode());
    Node n = Node.find(bi.getNode());
    %>
    <tr>
      <td><%=ids%></td>
      <td>&nbsp;<%=bi.getNode()%></td>
      <td><%out.print(n.getCreator()._strV.toString());%></td>
      <td><%=bi.getMember()%></td>
      <td><%=bi.getPicprice()%></td>
      <td><%if(bi.getPicsalestype()==0){out.print("财务未确认");}else{out.print("财务确认");}%></td>
      <td><input name="按钮" type="button" <%if(bi.getPicsalestype()==1){out.print("disabled");}%> class="lzj_001" onClick="if(confirm('确认到账')){window.open('/jsp/bpicture/financeAudit.jsp?cwid=<%=ids%>', '_self');this.disabled=true;};" value="确认到账" ></td>
    </tr>
    <%
    }
    %>
     <tr>
      <td colspan="7" align="center"><%=new tea.htmlx.FPNL(teasession._nLanguage,param.toString().replaceFirst("&pos=","&")+"&pos=",pos,count,10)%>
      </td>
    </tr>
    </table>
</div>
</body>
</html>
