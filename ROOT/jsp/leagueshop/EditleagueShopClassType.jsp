<%@page contentType="text/html;charset=UTF-8" %><%@ page import="java.net.*"%><%@ page import="java.util.*"%><%@ page import="java.text.*"%><%@ page import="java.security.*"%><%@ page import="com.capinfo.crypt.*"%><%@ page import="tea.entity.member.*"%>
<%@ page import="tea.ui.*"%><%@ page import="java.math.*"%><%@ page import="tea.entity.csvclub.alipay.*"%><%@ page import="tea.entity.csvclub.encrypt.*" %><%@ page import="tea.entity.admin.mov.*" %><%@ page import="tea.entity.admin.*" %>
<%@ page import="tea.entity.league.*" %><%@ page import="tea.entity.node.*" %>
<%

response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");


TeaSession teasession = new TeaSession(request);
StringBuffer param=new StringBuffer();
String menu_id=(request.getParameter("id"));
if(menu_id!=null&&menu_id.length()>0)
{
  param.append("&id=").append(menu_id);
}


int  deleteid =0;
if(teasession.getParameter("deleteid")!=null && teasession.getParameter("deleteid").length()>0)
{
  deleteid = Integer.parseInt(teasession.getParameter("deleteid"));
  if(deleteid!=0)
  {
    LeagueShopType.delete(deleteid);
  }
}
int j=0;
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type="" ></SCRIPT>
<title>分店类型管理</title>
<script type="">
function find_add(a,b,c,j)
{

  form1.lstypename.value=a;
  form1.idtype.value=b;
  for(var i=0;i<=j;i++)
  {
    if(c.indexOf("/"+document.getElementById('brands'+i).value+"/")!=-1)
    {
      document.getElementById('brands'+i).checked=true;
    }
    else
    {
      document.getElementById('brands'+i).checked=false;
    }
  }
}
function find_sub()
{
  if(document.form1.lstypename.value==""){
    document.form1.lstypename.focus();
    alert("分店类型不能为空！");
    return false;
  }
  return true;
}


</script>
</head>
<body>
<h1>分店类型管理</h1>
<form   name="form1" action="/servlet/EditLeagueShop" method="POST" enctype="multipart/form-data">
<input  type="hidden" name="act" value="EditleagueShopClassType" />
<input  type="hidden" name="idtype" value="0" />
<TABLE border="0" CELLPADDING="0" CELLSPACING="0" id="tablecenter">
  <tr><td nowrap align="left">分店类型：<input type="text" name="lstypename" value=""></td>
    <td>品牌类型</td>
<td>
<%
java.util.Enumeration enumer=Brand.findByCommunity(teasession._strCommunity,"",0,Integer.MAX_VALUE);
if(!enumer.hasMoreElements())
{
  out.print("暂无品牌信息");

}
for(int i=0;enumer.hasMoreElements();i++)
{
  int bid=Integer.parseInt(String.valueOf(enumer.nextElement()));
  Brand bobj = Brand.find(bid);
  j = Brand.countByCommunity(teasession._strCommunity,"");
  if(j>0)
  {
    j =j-1;
  }
  out.print("<input type=checkbox name=brands"+i+" value="+bid+" /> "+bobj.getName(teasession._nLanguage)+"　");
}

%></td>
</tr>
    <tr><td nowrap align="left"><input type="submit" value="添加" onclick="return find_sub()"/></td></tr>
</table>
</form>

<form   name="form2" action="/servlet/EditLeagueShop" method="POST" enctype="multipart/form-data">
<input  type="hidden" name="act" value="EditleagueShopClassType" />
<TABLE border="0" CELLPADDING="0" CELLSPACING="0" id="tablecenter">
  <tr id="tableonetr"><td>序号</td><td>名称</td><td nowrap="nowrap">状态</td><td nowrap="nowrap">操作</td></tr>
  <%
  Enumeration  eu = LeagueShopType.findByCommunity(teasession._strCommunity,"",0,10);

  for(int i=0;eu.hasMoreElements();i++)
  {
    int idtype = Integer.parseInt(String.valueOf(eu.nextElement()));
    LeagueShopType objtype= LeagueShopType.find(idtype);

    int deletenum = LeagueShopServer.pdDeletetype(idtype);
    String showinfo ="";
    if(deletenum==0)
    {
      showinfo="此类型尚有级别关联，如需删除，请先解除关联的级别！";
      deletenum=0;
    }
    else
    {
      showinfo="确认删除";
      deletenum=idtype;
    }
    %>
    <tr>
      <td><%=i+1%></td>
      <td><%=objtype.getLstypename()%></td>
      <td><%if(deletenum==0){out.print("已关联分店级别");}else{out.print("无分店级别");}%></td>
      <td><input  name="" value="编辑" type="button" onclick="find_add('<%=objtype.getLstypename()%>','<%=idtype%>','<%=objtype.getBrands()%>','<%=j%>')"/>
        <input value="样式" type="button" onclick="window.open('/jsp/leagueshop/SetLeagueShopTypeStyle.jsp?community=<%=teasession._strCommunity%>&leagueshoptype=<%=idtype%>','_self');"/>
        <input name="按钮" type="button" value="删除" onClick="if(confirm('<%=showinfo%>')){window.open('/jsp/leagueshop/EditleagueShopClassType.jsp?deleteid=<%=deletenum%>', '_self');this.disabled=true;};" >
</td>
    </tr>
    <%
    }
    %><tr><td align="center" colspan="3" ><input type=button value="返回" onClick="javascript:history.back()"/></td></tr>
    </table>
</form>
</body>
</html>

