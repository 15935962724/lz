<%@ page contentType="text/html;charset=UTF-8" %><%@ page import="tea.entity.node.*" %>
<%@ page import="java.lang.*,java.util.*,tea.ui.*,java.text.SimpleDateFormat,java.text.DateFormat" %>
<%
TeaSession teasession=new TeaSession(request);

String strPos=request.getParameter("pos");
int pos=0;
if(strPos!=null)
pos=Integer.parseInt(strPos);

String community=request.getParameter("community");
String domain=request.getParameter("domain");

java.text.DecimalFormat df=new java.text.DecimalFormat("#,##0");

int count=NodeAccessReferer.countByDomain(community,domain);

%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type=""></SCRIPT>
</head>
<body>

<h2>访问来源统计图表 ( <%=domain+" / "+count%> )</h2></td>
<div id="head6"><img height="6" src="about:blank"></div>
<br>

<table border="0" cellspacing="0" cellpadding="0" id="tablecenter">
        <tr>
          <td align=center><table align=center>
            <tr><td></td>
          <td align=center>今天统计</td>
          <td align=center>总统计</td>
        </tr>
              <%
java.util.Enumeration enumer=NodeAccessReferer.findByDomain(community,domain,pos,25);
while(enumer.hasMoreElements())
{
  NodeAccessReferer nar=(NodeAccessReferer)enumer.nextElement();
  String referer=nar.getReferer();

%>
<tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    <td ><A  TARGET="_blank" href="<%=referer%>">
  <%
  if(referer.length()==0)
  out.print("直接输入网址进入的");
  else
  if(referer.length()>70)
  out.print(referer.substring(0,57)+"..."+referer.substring(referer.length()-10));
  else
  out.print(referer);
  %></A></td>
    <td align="right"><%=df.format(nar.getCount())%></td>
    <td align="right"><%=df.format(nar.getSum())%></td>
  </tr>
<%
}
%>
</table></td>
        </tr>
        <tr><td align="center">
          <%=new tea.htmlx.FPNL(teasession._nLanguage, "/jsp/count/referer1.jsp?community="+community+"&domain="+domain+"&pos=", pos,count )%>
</table>


<br>
<div id="head6"><img height="6" src="about:blank"></div>

