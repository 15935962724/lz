<%@page contentType="text/html;charset=UTF-8" %><%@ page import="java.net.*"%><%@ page import="java.util.*"%><%@ page import="java.text.*"%><%@ page import="java.security.*"%><%@ page import="com.capinfo.crypt.*"%><%@ page import="tea.entity.member.*"%>
<%@ page import="tea.ui.*"%><%@ page import="java.math.*"%><%@ page import="tea.entity.csvclub.alipay.*"%><%@ page import="tea.entity.csvclub.encrypt.*" %><%@ page import="tea.entity.admin.mov.*" %><%@ page import="tea.entity.admin.*" %>
<%@ page import="tea.entity.league.*" %><%@ page import="tea.db.*" %>
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
int lsid = 0;
if(teasession.getParameter("ids")!=null && teasession.getParameter("ids").length()>0)
{
  lsid=Integer.parseInt(teasession.getParameter("ids"));
}

LeagueShop lsobj = LeagueShop.find(lsid);

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
<script type="">
function sub_finds()
{
  if(form1.yfmoney.value=="")
  {
    document.form1.yfmoney.focus();
    alert("转账金额不能为空！！");
    return false;
  }
  if(form1.zzdate.value=="")
  {
    document.form1.zzdate.focus();
    alert("转账时间不能为空！");
    return false;
  }

  if(form1.payment.value=="" ||form1.payment.value=="0"  )
  {
    document.form1.payment.focus();
    alert("支付方式不能为空！");
    return false;
  }

  if(form1.type.value=="1" &&((parseInt(document.form1.yfmoney.value))>(parseInt(document.form1.bb.value))))
  {
    alert("退款金额不能超过账户余额！");
    return false;
  }
  return true;
}
</script>
<title>修改分店状态</title>
</head>
<body>
<h1>修改分店状态</h1>
<form name="form1" action="/servlet/EditLeagueShop" method="POST" enctype="multipart/form-data">
<input type="hidden" value="<%=lsid%>"   name="ids"/>
<input type="hidden" value="EditLeagueShopStatic"   name="act"/>
<TABLE border="0" CELLPADDING="0" CELLSPACING="0" id="tablecenter">
<tr><td nowrap="nowrap" align="right">分店名称：</td><td nowrap="nowrap"><%=lsobj.getLsname()%></td>
</tr>
<tr><td nowrap="nowrap" align="right">分店状态：</td>
  <td nowrap="nowrap">
    <select name="lsstatic2">
    <%
    for(int i=0;i<LeagueShop.LSSTATIC2.length;i++)
    {
      out.print("<option value="+i);
      if(lsobj.getLsstatic2()==i)
      {
        out.print(" selected ");
      }
      out.print(">"+LeagueShop.LSSTATIC2[i]+"</option>");
    }
    %>
    </select>
  </td>
</tr>
  <tr><td nowrap colspan="3" align="center"><input type="submit" value="提交" onclick="return sub_finds();" />　<input type=button value="返回" onClick="javascript:history.back()"/></td></tr>
</table>
</form>
</body>
</html>

