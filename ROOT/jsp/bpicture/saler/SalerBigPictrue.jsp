<%@page contentType="text/html;charset=UTF-8"  %>
<%@ page import="tea.ui.TeaSession" %>
<%@ page import="tea.entity.bpicture.*" %>
<%@ page import="tea.entity.node.*" %>
<%@page import="java.awt.image.*" %>
<%@page import="javax.imageio.*" %>
<%@page import="java.math.BigDecimal" %>
<%
TeaSession teasession = new TeaSession(request);
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");


int nodes = 0;
if(teasession.getParameter("nodes")!=null && teasession.getParameter("nodes").length()>0)
{
  nodes = Integer.parseInt(teasession.getParameter("nodes"));
}
Node node = Node.find(nodes);

Baudit.addZoom(nodes);//放大



boolean _bNew =request.getParameter("NewNode")!=null;

String picture="";

BigDecimal price = new BigDecimal(1);


if(!_bNew)
{
  Picture p=Picture.find(nodes);
//  width=p.getWidth(teasession._nLanguage);
//  height=p.getHeight(teasession._nLanguage);
  picture="/res/"+node.getCommunity()+"/picture/"+nodes+".jpg";
}

%>
<html>
<HEAD>
  <link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">

  <title>图片信息</title>
</head>
<body bgcolor="#ffffff">
<img alt="" src="<%=picture%>" />
</body>
</html>
