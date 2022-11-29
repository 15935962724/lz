<%@page contentType="text/html;charset=UTF-8" %><%@ page import="java.net.*"%><%@ page import="java.util.*"%><%@ page import="java.text.*"%><%@ page import="java.security.*"%><%@ page import="com.capinfo.crypt.*"%><%@ page import="tea.entity.member.*"%>
<%@ page import="tea.ui.*"%><%@ page import="java.math.*"%><%@ page import="tea.entity.csvclub.alipay.*"%><%@ page import="tea.entity.csvclub.encrypt.*" %><%@ page import="tea.entity.admin.mov.*" %><%@ page import="tea.entity.admin.*" %>
<%@ page import="tea.entity.league.*" %>
<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");


TeaSession teasession = new TeaSession(request);
StringBuffer param=new StringBuffer();
StringBuffer sql=new StringBuffer();
String menu_id=(request.getParameter("id"));
if(menu_id!=null&&menu_id.length()>0)
{
  param.append("&id=").append(menu_id);
}

int deleteid =0;
if(teasession.getParameter("deleteid")!=null && teasession.getParameter("deleteid").length()>0)
{
  deleteid =Integer.parseInt(teasession.getParameter("deleteid"));

  int deletenum2 = LeagueShop.pdServer(deleteid);
  if(deletenum2!=0)
  {
   LeagueShopServer.delete(deleteid);
  }


}



int pos = 0, pageSize = 10, count = 0;
if (request.getParameter("pos") != null) {
  pos = Integer.parseInt(request.getParameter("pos"));
}
count =LeagueShopServer.count(teasession._strCommunity,sql.toString());
String o=request.getParameter("o");
if(o==null)
{
  o="lstypeid";
}
boolean aq=Boolean.parseBoolean(request.getParameter("aq"));
sql.append(" ORDER BY ").append(o).append(" ").append(aq?"DESC":"ASC");
param.append("&o=").append(o).append("&aq=").append(aq);

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script>if(parent.lantk) {document.getElementsByTagName("LINK")[0].href="/res/csvclub/cssjs/community_02.css"; }</script>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type="" ></SCRIPT>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/jsp/csvclub/js.js" type=""></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache"/>
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache"/>
<META HTTP-EQUIV="Expires" CONTENT="0"/>
<title>分店级别管理</title>
<script type="text/javascript">

function find_add(a,b,c,d,e,f)
{
  form1.lssid.value=a;
  form1.lstypeid.selected=b;
  form1.lssname.value=c;
  form1.lssarea.value=d;
  form1.lssmoney.value=e;
}

function f_order(v)
{
  var aq=form3.aq.value=="true";
  if(form3.o.value==v)
  {
    form3.aq.value=!aq;
  }else
  {
    form3.o.value=v;
  }
  form3.action="?";
  form3.submit();
}
function f_sub()
{
  if(document.form1.lssname.value==""){
    document.form1.lssname.focus();
    alert("分店级别不能为空！");
    return false;
  }
  if(document.form1.lssarea.value==""){
    document.form1.lssarea.focus();
    alert("分店面积不能为空！");
    return false;
  }
   if(document.form1.lssmoney.value==""){
    document.form1.lssmoney.focus();
    alert("分店金额不能为空！");
    return false;
  }

  return true;


}
</script>
</head>
<body>
<h1>分店级别管理</h1>
<h2>分店级别管理</h2>
<form name="form1" action="/servlet/EditLeagueShop" method="POST" enctype="multipart/form-data">
<input  type="hidden" name="act" value="EditLeagueShopClass" />
<input  type="hidden" name="lssid" value="0" />
<TABLE border="0" CELLPADDING="0" CELLSPACING="0" id="tablecenter">
  <tr><td nowrap align="right">分店类型：</td><td nowrap><select name="lstypeid">
  <%
  Enumeration  eu = LeagueShopType.findByCommunity(teasession._strCommunity,"",0,10);
  for(int i=0;eu.hasMoreElements();i++)
  {
    int idtype = Integer.parseInt(String.valueOf(eu.nextElement()));
    LeagueShopType objtype= LeagueShopType.find(idtype);

    out.print("<option value="+idtype+">"+objtype.getLstypename());
    out.print("</option>");
  }
  %></select>
  </td></tr>
  <tr><td nowrap align="right">分店级别：</td><td nowrap><input  name="lssname" type="text"/></td></tr>
  <tr><td nowrap align="right">面积：</td><td nowrap><input name="lssarea" type="text" value="" /></td></tr>
  <tr><td nowrap align="right">金额：</td><td nowrap><input name="lssmoney" type="text" value="" /></td></tr>
  <tr><td nowrap colspan="3" align="center"><input type="submit" value="添加分店级别" onclick="return f_sub()" /></td></tr>
</table>
<h2>分店级别列表</h2>

</form>

<form action="" name="form3">

<input type="hidden" name="o" VALUE="<%=o%>">
<input type="hidden" name="aq" VALUE="<%=aq%>">
<input type="hidden" name="id" value="<%=request.getParameter("id")%>" >
<input type="hidden" name="act"  value="" >

<TABLE border="0" CELLPADDING="0" CELLSPACING="0" id="tablecenter">
  <tr id="tableonetr"><td nowrap><a href="javascript:f_order('lstypeid');">分店类型</a>
  <%
  if(o.equals("lstypeid"))
  {
    if(aq)
    out.print("↓");
    else
    out.print("↑");
  }
  %></td></td><td nowrap>分店级别</td><td>金额</td><td>状态</td><td></td></tr>
  <%
  Enumeration  eu2 = LeagueShopServer.findByCommunity("",sql.toString(),0,30);
  for(int i=0;eu2.hasMoreElements();i++)
  {
    int id2 = Integer.parseInt(String.valueOf(eu2.nextElement()));
    LeagueShopServer objlss= LeagueShopServer.find(id2);
    LeagueShopType objtype3= LeagueShopType.find(objlss.getLstypeid());
    int id3=id2;
    int deletenum = LeagueShop.pdServer(id2);
    String showinfo ="";

    if(deletenum==0)
    {
      showinfo="此级别尚有分店关联，如需删除，请先解除关联的分店！";
      id2=0;
    }
    else
    {
      showinfo="确认删除";
    }
    %>
    <tr>
      <td><%=objtype3.getLstypename()%></td>
      <td><%=objlss.getLssname()%></td>
      <td><%=objlss.getLssmoney()%></td>
       <td><%if(deletenum==0){out.print("已有分店使用");}else{out.print("尚未被使用");}%></td>
      <td>
        <input  name="" value="编辑" type="button" onclick="find_add('<%=id3%>','<%=objlss.getLstypeid()%>','<%=objlss.getLssname()%>','<%=objlss.getLssarea()%>','<%=objlss.getLssmoney()%>')"/>
        <input name="按钮" type="button" value="删除" onClick="if(confirm('<%=showinfo%>')){window.open('/jsp/leagueshop/EditLeagueShopClass.jsp?deleteid=<%=id2%>', '_self');this.disabled=true;};" >
      </td>
    </tr>
    <%
    }
    %>
    <tr><td nowrap colspan="3" align="center"><input type="button" value="创建分店类型" onclick="window.open('/jsp/leagueshop/EditleagueShopClassType.jsp','_self')" />  　</td></tr>
</table>
</form>
</body>
</html>

