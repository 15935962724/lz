<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.lang.*,java.util.*,tea.ui.*,java.text.SimpleDateFormat,java.text.DateFormat" %>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.resource.*" %>
<%
TeaSession teasession=new TeaSession(request);

String strPos=request.getParameter("pos");
int pos=0;
if(strPos!=null)
pos=Integer.parseInt(strPos);

String community=teasession._strCommunity;
String where=request.getParameter("where");

java.text.DecimalFormat df=new java.text.DecimalFormat("#,##0");

int count=NodeAccessWhere.countByWhere(community,where);

Resource r=new Resource();
r.add("/tea/resource/fun");


%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type=""></SCRIPT>
</head>
<body>

<h2><%=r.getString(teasession._nLanguage, "1216103566724")%> ( <%=where+" / "+count%> )</h2>
<div id="head6"><img height="6" src="about:blank"></div>
<br>

<table border="0" cellspacing="0" cellpadding="0" id="tablecenter">
<tr><td align="center">
<table>
  <tr>
    <td></td>
    <td align=right><%=r.getString(teasession._nLanguage, "1216086803881")%></td>
    <td align=right><%=r.getString(teasession._nLanguage, "1216086874115")%></td>
  </tr>
<%
java.util.Enumeration enumer=NodeAccessWhere.findByWhere(community,where,pos,25);
while(enumer.hasMoreElements())
{
  NodeAccessWhere naw=(NodeAccessWhere)enumer.nextElement();
  String ip=naw.getIp();

  %>
<tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    <td ><%=ip%></td>
    <td align="right"><%=df.format(naw.getCount())%></td>
    <td align="right"><%=df.format(naw.getSum())%></td>
  </tr>
  <%
}
%></table></td>
        </tr>
        <tr><td align="center">
          <%=new tea.htmlx.FPNL(teasession._nLanguage, "/jsp/count/where1.jsp?community="+community+"&where="+java.net.URLEncoder.encode(where,"UTF-8")+"&pos=", pos,count )%>
</table>

<br>
<div id="head6"><img height="6" src="about:blank"></div>


