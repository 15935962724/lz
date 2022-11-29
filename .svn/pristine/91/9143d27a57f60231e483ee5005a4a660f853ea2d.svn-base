<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.resource.*"%>
<%@page import="java.util.*"%>
<%@page import="tea.ui.*"%>
<%@page import="tea.db.*"%>
<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession = new TeaSession(request);
if(teasession._rv==null)
{
	response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
    return;
}

int brand=Integer.parseInt(request.getParameter("brand"));

Brand b=Brand.find(brand);

String nexturl=request.getParameter("nexturl");

if(request.getMethod().equals("POST"))
{
  float discounts=Float.parseFloat(request.getParameter("discounts"));
  Date vtime=BrandDiscounts.sdf.parse(request.getParameter("vtimeYear")+"-"+request.getParameter("vtimeMonth")+"-"+request.getParameter("vtimeDay"));
  if(request.getParameter("stop")!=null)
  {
    vtime=new Date();
    discounts=0F;
  }
  b.set(discounts,vtime);
  response.sendRedirect("/jsp/info/Succeed.jsp?nexturl="+java.net.URLEncoder.encode(nexturl,"UTF-8"));
  return;
}


Resource r = new Resource();
r.add("/tea/ui/node/type/buy/EditBuyPrice");

String _strId=request.getParameter("id");

Date vtime=b.getVTime();
if(vtime==null)
{
  Calendar c=Calendar.getInstance();
  c.set(c.MONTH,c.get(c.MONTH)+3);
  vtime=c.getTime();
}

%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>
<body onload="form1.discounts.focus();">
<h1><%=r.getString(teasession._nLanguage, "CBEditBuy")+" ( "+b.getName(teasession._nLanguage)+" )"%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br>

<form name="form1" method="POST" action="?" onSubmit="return(submitFloat(this.discounts,'<%=r.getString(teasession._nLanguage, "无效-折扣")%>'));">
<input type='hidden' name="commodity" value="<%=teasession._strCommunity%>">
<input type='hidden' name="id" value="<%=_strId%>">
<input type='hidden' name="brand" value="<%=brand%>">
<input type='hidden' name="nexturl" value="<%=nexturl%>">

<table cellspacing="0" cellpadding="0" border="0" id="tablecenter">
      <tr>
        <td><%=r.getString(teasession._nLanguage, "截止日期")%>:</td>
        <td><%=new tea.htmlx.TimeSelection("vtime", vtime)%></td>
      </tr>
      <tr>
        <td><%=r.getString(teasession._nLanguage, "OurPrice")%>:</td>
        <td><input type="TEXT" name=discounts size=6 value="<%=b.getDiscounts()%>" onkeypress="inputFloat();">折</td>
      </tr>
    </table>
    <input type="submit" value="<%=r.getString(teasession._nLanguage, "Submit")%>">
    <input name="stop" type="submit" value="<%=r.getString(teasession._nLanguage, "终止")%>">
    <input type="reset" value="重置">
    <input type="button" value="返回" onclick="window.open('<%=nexturl%>','_self');">
  </form>
<br>

<h2>打折记录</h2>
<TABLE  cellSpacing="0" cellPadding="0" id="tablecenter">
<tr id="tableonetr"><td width=1>&nbsp;</td><td>折扣</td><td>开始日期</td><td>截止日期</td></tr>
<%
Enumeration e=BrandDiscounts.findByBrand(brand,"",0,Integer.MAX_VALUE);
for(int i=1;e.hasMoreElements();i++)
{
 int id=((Integer)e.nextElement()).intValue();
 BrandDiscounts obj=BrandDiscounts.find(id);
 out.print("<tr onMouseOver=bgColor='#BCD1E9' onMouseOut=bgColor=''>");
 out.print("<td width=1>"+i);
 out.print("<td>"+obj.getDiscounts());
 out.print("<td>"+obj.getStartTimeToString());
 out.print("<td>"+obj.getStopTimeToString());
}
%>
</table>

  <div id="head6"><img height="6" src="about:blank"></div>
  <div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</html>

