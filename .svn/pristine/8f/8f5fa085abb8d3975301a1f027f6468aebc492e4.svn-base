<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="java.io.*"%>
<%@page import="java.util.*"%>
<%@page import="tea.db.DbAdapter"%>
<%@page import="tea.entity.*"%>
<%@page import="tea.entity.admin.*"%>
<%@page import="tea.resource.*"%>
<%@page import="tea.ui.*"%>
<%@page import="tea.htmlx.*"%>
<%@page import="tea.entity.node.*"%>
<%
request.setCharacterEncoding("UTF-8");
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?Node="+teasession._nNode);
  return;
}

String nexturl=request.getParameter("nexturl");
String act=request.getParameter("act");

Resource r=new Resource("/tea/resource/Goods");
String community = teasession._strCommunity;

if("POST".equals(request.getMethod()))
{
  Date start=null,stop=null;
  if(request.getParameter("o")==null)
  {
    String starttime=request.getParameter("starttimeYear")+"-"+request.getParameter("starttimeMonth")+"-"+request.getParameter("starttimeDay");
    String stoptime=request.getParameter("stoptimeYear")+"-"+request.getParameter("stoptimeMonth")+"-"+request.getParameter("stoptimeDay");
    start=Entity.sdf.parse(starttime);
    stop=Entity.sdf.parse(stoptime);
  }
  if("bat".equals(act))
  {
    int brand=Integer.parseInt(request.getParameter("brand"));
    Enumeration e=Node.find(" AND community="+DbAdapter.cite(teasession._strCommunity)+" AND type=34 AND node IN ( SELECT node FROM Goods WHERE brand="+brand+" )",0,Integer.MAX_VALUE);
    while(e.hasMoreElements())
    {
      int id=((Integer)e.nextElement()).intValue();
      Node obj=Node.find(id);
      obj.set(start,stop);
    }
  }else
  {
	Node obj=Node.find(teasession._nNode);
    obj.set(start,stop);
  }
  response.sendRedirect("/jsp/info/Succeed.jsp?community="+teasession._strCommunity+"&nexturl="+java.net.URLEncoder.encode(nexturl,"UTF-8"));
  return;
}

r.add("/tea/ui/member/community/EditCommunity");

%>
<html>
<head>
<link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="/tea/tea.js" type="text/javascript"></script>
<script>
function f_submit(form1)
{
  if(form1.brand)
  return submitText(form1.brand,"无效-品牌");
}
function f_o()
{
  var obj=form1.o;
  var sel=form1.elements;
  for(var i=0;i<sel.length;i++)
  {
    if(sel[i].name.indexOf("time")!=-1)
    {
      sel[i].disabled=obj.checked;
    }
  }
}
</script>
</HEAD>
<body>
<h1><%=r.getString(teasession._nLanguage, "上下架时间限制")%></h1>
<div id="head6"><img height="6" alt=""></div>

<form name="form1" method="post" action="?" onsubmit="return f_submit(this);">
<INPUT type="hidden" name="Node" value="<%=teasession._nNode%>">
<INPUT type="hidden" name="community" value="<%=teasession._strCommunity%>">
<input type="hidden" name="nexturl" value="<%=nexturl%>"/>
<input type="hidden" name="act" value="<%=act%>"/>

<TABLE border="0" cellPadding="0" cellSpacing="0"  id="tablecenter">
    <%
    Date start=null,stop=null;
    if("bat".equals(act))
    {
      out.print("<TR>");
      out.print("  <TD>"+r.getString(teasession._nLanguage, "条件")+":</TD>");
      out.print("  <TD><select name=brand><option value=''>-----------");
      Enumeration e=Brand.findByCommunity(teasession._strCommunity);
      while(e.hasMoreElements())
      {
        int id=((Integer)e.nextElement()).intValue();
        Brand b=Brand.find(id);
        out.print("<option value="+id);
        out.print(">"+b.getName(teasession._nLanguage));
      }
      out.print("</select>");
      out.print("</TR>");

	  Calendar c=Calendar.getInstance();
	  c.set(c.YEAR,c.get(c.YEAR)+1);
	  stop=c.getTime();
    }else
    {
      Node obj=Node.find(teasession._nNode);

      out.print("<TR>");
      out.print("  <TD>"+r.getString(teasession._nLanguage, "当前商品")+":</TD>");
      out.print("  <TD>"+obj.getSubject(teasession._nLanguage)+"</TD>");
      out.print("</TR>");

      start=obj.getStartTime();
      stop=obj.getStopTime();
      if(stop==null)
      {
      	out.print("<script>document.body.onload=f_o;</script>");
      }
    }
    %>
    <TR>
      <TD>上架时间</TD>
      <TD><%=new TimeSelection("starttime", start)%></TD>
    </TR>
    <TR>
      <TD>下架时间</TD>
      <TD><%=new TimeSelection("stoptime", stop)%></TD>
    </TR>
    <TR>
      <TD></TD>
      <TD><input type="checkbox" name="o" <%if(stop==null)out.print("CHECKED");%> onclick="f_o();" >无限制</TD>
    </TR>
  </TABLE>
        <INPUT type="submit" value="<%=r.getString(teasession._nLanguage, "提交")%>">
        <INPUT type="reset" value="<%=r.getString(teasession._nLanguage, "重置")%>">
        <INPUT type="button" value="<%=r.getString(teasession._nLanguage, "返回")%>" onclick="history.back();">

</form>
<br>
<div id="head6"><img height="6" src="about:blank"></div>
  <div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</HTML>
