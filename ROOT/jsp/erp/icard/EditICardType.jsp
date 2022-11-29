<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.resource.Resource" %>
<%@page import="tea.entity.admin.erp.*" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.ui.TeaSession" %>
<%@page import="tea.entity.admin.erp.icard.*" %>
<%@page import="tea.entity.league.*" %>
<%
request.setCharacterEncoding("UTF-8");
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");


TeaSession teasession = new TeaSession(request);
if (teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
  return;
}
String nexturl = request.getRequestURI()+"?"+request.getContextPath();

int icardtype=Integer.parseInt(request.getParameter("icardtype"));
String name="";
int mode=0,discount=100,lstypeid=0;
float integral=1.00F;
if(icardtype>0)
{
  ICardType ct=ICardType.find(icardtype);
  name=ct.getName();
  mode=ct.getMode();
  discount=ct.getDiscount();
  integral=ct.getIntegral();
  lstypeid=ct.getLstypeid();
}

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" language="javascript" src="/tea/tea.js"></script>
<title>添加/编辑卡类型</title>
</head>
<body id="bodynone" onload="form1.name.focus();">
<h1>添加/编辑卡类型</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" action="/servlet/EditICardType" onsubmit="return submitText(this.name,'无效-名称')&&submitText(this.mode,'无效-运行模式');">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="icardtype" value="<%=icardtype%>"/>
<input type="hidden" name="nexturl" value="/jsp/erp/icard/ICardTypes.jsp"/>
<input type="hidden" name="act" value="edit"/>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
	<tr>
      <td align="right">名称:</td>
      <td><input name="name" type="text" value="<%=name%>"></td>
    </tr>
    <tr>
    	 <td align="right">分店类型:</td>
      <td><select name="lstypeid">
  <%
  java.util.Enumeration  eu = LeagueShopType.findByCommunity(teasession._strCommunity,"",0,20);
  for(int i=0;eu.hasMoreElements();i++)
  {
    int idtype = Integer.parseInt(String.valueOf(eu.nextElement()));
    LeagueShopType objtype= LeagueShopType.find(idtype);

    out.print("<option value="+idtype);
    if(lstypeid==idtype)
    {
    	out.print(" selected ");
    }
    out.print(">"+objtype.getLstypename());
    out.print("</option>");
  }
  %></select></td>
    </tr>
    <tr>
      <td align="right">运行模式:</td>
      <td><select name="mode">
        <option value="">-----------
        <%
        for(int i=1;i<ICardType.MODE_TYPE.length;i++)
        {
          out.print("<option value="+i);
          if(i==mode)out.print(" selected='true'");
          out.print(">"+ICardType.MODE_TYPE[i]);
        }
        %>
        </select>
      </td>
    </tr>
	<tr>
      <td align="right">多少钱积一分:</td>
      <td><input name="integral" type="text" value="<%=integral%>" mask="float"></td>
    </tr>
	<tr>
      <td align="right">折扣:</td>
      <td><input name="discount" type="text" value="<%=discount%>" mask="int">折扣输入100为不打折扣,95为九五折.</td>
    </tr>
    <tr>
      <td>&nbsp;</td>
      <td><input type="submit" value="保存卡类型">
      <input type="button" value="返回" onclick='history.back();'></td>
    </tr>
</table>
</form>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
