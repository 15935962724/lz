<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.resource.Resource" %>
<%@page import="tea.entity.eon.*" %>
<%@page import="tea.entity.*" %>
<%@page import="tea.entity.member.*" %>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.ui.TeaSession" %>
<%@page import="java.text.*" %>
<%@page import="java.util.*" %>
<%@page import="tea.entity.admin.erp.*" %>
<%@page import="tea.entity.league.*" %>
<%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}
String nexturl = request.getRequestURI()+"?"+request.getContextPath();


StringBuffer sql=new StringBuffer();
StringBuffer param=new StringBuffer("?community="+teasession._strCommunity);
param.append("?id=").append(request.getParameter("id"));

//加盟店
String joinname = teasession.getParameter("joinname");
if(joinname!=null && joinname.length()>0)
{//LeagueShop lsobj = LeagueShop.find(joinhidden);
  sql.append("  and joinname in(select id from LeagueShop where lsname like "+DbAdapter.cite("%"+joinname+"%")+") ");
  param.append("&joinname=").append(java.net.URLEncoder.encode(joinname,"UTF-8"));
}
//条形码或编号
String goodsnumber = teasession.getParameter("goodsnumber");
if(goodsnumber!=null && goodsnumber.length()>0)
{
  sql.append(" and node in (select node from Node where goodsnumber like "+DbAdapter.cite("%"+goodsnumber+"%")+"  )");
  param.append("&goodsnumber=").append(goodsnumber);
}
//商品名称
//条形码或编号
String subject = teasession.getParameter("subject");
if(subject!=null && subject.length()>0)
{
  sql.append(" and node in (select node from NodeLayer where subject like "+DbAdapter.cite("%"+subject+"%")+"  )");
  param.append("&subject=").append(java.net.URLEncoder.encode(subject,"UTF-8"));
}

int pos = 0, pageSize = 10, count = 0;
if (request.getParameter("pos") != null) {
  pos = Integer.parseInt(request.getParameter("pos"));
}

count = BatchPrice.count(teasession._strCommunity,sql.toString());
sql.append(" ORDER BY times DESC ");

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>批量处理加盟店销售价</title>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<body bgcolor="#ffffff" >
<script type="">
  function f_edit(igd)
  {
    form1.bpid.value = igd;
    form1.action="/jsp/erp/EditBatchPrice.jsp";
    form1.submit();
  }
  function f_delete(igd)
  {
    if(confirm('您确定要删除此内容吗？'))
    {
      form1.bpid.value= igd;
      form1.act.value= 'delete';
      form1.action = "/servlet/EditBatchPrice";
      form1.submit();
    }
  }
  //自动搜索ajax
  function f_jo()
  {
    sendx("/jsp/erp/Goods_ajax.jsp?act=BatchPrice&joinname="+encodeURIComponent(form1.joinname.value),
    function(data)
    {
      document.getElementById("joinid2").innerHTML=data;
    }
    );
  }
  function f_trdw(igd)
  {
    form1.joinname.value=igd;
    document.getElementById("joinid2").style.display='none';//隐藏div
  }
</script>
<h1>批量处理加盟店销售价</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<form action="?" name="form1" method="POST">
<input type="hidden" name="bpid">
<input type="hidden" name="act"/>
<input type="hidden" name="nexturl" value="<%=nexturl%>">
  <input type="hidden" name="id" value="<%=request.getParameter("id")%>" >
  <h2>查询</h2>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td>加盟店名称:</td>
      <td id="joinid0">
        <span id="joinid"> <input type="text" name="joinname" value="<%if(joinname!=null)out.print(joinname);%>" onKeyUp="f_jo();"></span>
        <span id="joinid2">&nbsp;</span>
      </td>
      <td>条形码或编号:</td>
      <td><input type="text" name="goodsnumber" value="<%if(goodsnumber!=null)out.print(goodsnumber);%>"/> </td>
    </tr>
      <tr>
      <td>商品名称:</td>
      <td><input type="text" name="subject" value="<%if(subject!=null)out.print(subject);%>"/> </td>
      <td colspan="2"><input type="submit" value="查询"/></td>
    </tr>
  </table>
<h2>查询列表&nbsp;&nbsp;共查询出&nbsp;<font color="#000000" size="3"><%=count%></font>&nbsp;条记录</h2>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr id="tableonetr">
    <td align="center" nowrap>加盟店名称</td>
    <td align="center" nowrap>条形码或编号</td>
    <td align="center" nowrap>商品名称</td>
    <td align="center" nowrap>修改点数</td>
    <td align="center" nowrap>修改价格</td>
    <td align="center" nowrap>操作</td>
  </tr>
  <%
  java.util.Enumeration e = BatchPrice.find(teasession._strCommunity,sql.toString(),pos,pageSize);
  if(!e.hasMoreElements())
  {
    out.print("<tr><td colspan=10 align=center>请选择上面的搜索条件</td></tr>");
  }
  while(e.hasMoreElements())
  {
    int bpid =((Integer)e.nextElement()).intValue();
    BatchPrice bpobj = BatchPrice.find(bpid);
    Node nobj = Node.find(bpobj.getNode());
    Goods gobj = Goods.find(bpobj.getNode());
    LeagueShop lsobj = LeagueShop.find(bpobj.getJoinname());

  %>

  <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    <td><%=lsobj.getLsname()%></td>
    <td><%=nobj.getNumber()%></td>
    <td><%=nobj.getSubject(teasession._nLanguage)%></td>
    <td><%=bpobj.getDiscount()  %></td>
    <td><%=bpobj.getPrice()%></td>
    <td><a href="#" onClick="f_edit('<%=bpid%>');">编辑</a>&nbsp;<a href="#" onClick="f_delete('<%=bpid%>')">删除</a> </td>
  </tr>
  <% }%>
    <%if (count > pageSize) {  %>
  <tr> <td colspan="10"><%=new tea.htmlx.FPNL(teasession._nLanguage,request.getRequestURI()+param.toString()+"&pos=",pos,count,pageSize)%>    </td> </tr>
  <%}  %>
</table>
<br />
</form>
  <input type="button" value="批处理销售价格" onClick="window.open('/jsp/erp/EditBatchPrice.jsp?nexturl=<%=nexturl%>','_self');"/>

<div id="head6"><img height="6" src="about:blank"></div>

</body>
</html>
