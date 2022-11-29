<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter" %>
<%@ page import="tea.entity.node.*" %>
<%@ page import="tea.entity.site.*" %>
<%@ page import="tea.entity.confab.*" %>
<%@ page  import="tea.resource.Resource" %>
<%@ page import="java.util.*" %>
<%@ page import="java.net.*" %>
<%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

Resource r=new Resource();

Node node_obj=Node.find(teasession._nNode);

String img="";
StringBuffer sb=new StringBuffer();
StringBuffer sb2=new StringBuffer();
//sb.append(r.getString(teasession._nLanguage,"MemberId")).append(":").append(node_obj.getCreator()).append("\r\n");
Enumeration e=DynamicType.findByDynamic(node_obj.getType()," AND qrc=1",0,100);
while(e.hasMoreElements())
{
  int dt_id=((Integer)e.nextElement()).intValue();
  DynamicType dt=DynamicType.find(dt_id);
  DynamicValue dv=DynamicValue.find(teasession._nNode,teasession._nLanguage,dt_id);

  String v=dv.getValue();
  if("img".equals(dt.getType()))
  {
    img+="<IMG id=DTimg SRC="+v+">";
  }else
  {
    sb.append(dt.getName(teasession._nLanguage)).append(":").append(v).append("\r\n");
    sb2.append("<LI ID=DT").append(dt.getType()).append(">").append(dt.getName(teasession._nLanguage)).append(":").append(v).append("</LI>");
  }
}


/////////////////////胸卡///////////////////////////////////////////////////
%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script>
window.onBeforePrint=function()
{
  print.style.display="none";
}

window.onAfterPrint=function()
{
  print.style.display="";
}
</script>
</head>
<body>

<div id="head6"><img height="6" src="about:blank"></div>
<br>

<DIV id="ConfabQrc">
<img id="qrcode" src="/servlet/QRCodeImg?content=<%=URLEncoder.encode(sb.toString(),"UTF-8")%>&size=50">
<%=img%>
<ul><%=sb2.toString()%></ul>
</DIV>
<input type="button" id="print" value="打印" onclick="window.print();"/>

<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
