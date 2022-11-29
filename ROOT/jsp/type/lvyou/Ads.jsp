<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="tea.ui.TeaSession"%>
<%@page import="tea.entity.site.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.entity.lvyou.*"%>
<%@page import="tea.resource.*"%>
<%@page import="java.util.*"%>
<%@page import="java.io.*"%>
<%@page import="tea.entity.member.*"%>
<%
     request.setCharacterEncoding("UTF-8");
     TeaSession teasession = new TeaSession(request);
     int  id = 0;
     if(teasession._rv == null)
     {
       response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
       return;
     }   
     
   
     
     java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyyMMddHHmmss");
     String dir = sdf.format(new Date());
if("POST".equals(request.getMethod()))
{
String ref=teasession.getParameter("href");
Properties p1 = new Properties();
p1.setProperty("href", ref);

p1.setProperty("updatetime", dir);
p1.setProperty("src", "/jsp/type/lvyou/advertisement.png");


FileOutputStream o = new FileOutputStream(request.getRealPath("/jsp/type/lvyou/ads.properties"));  
p1.save(o, "comments");  
o.close();
byte by[] = teasession.getBytesParameter("picture");
if(by!=null&&by.length>0){
FileOutputStream fos = new FileOutputStream(request.getRealPath("/jsp/type/lvyou/advertisement.png"));   //写入值的时候要调用
fos.write(by);
fos.close();
}
response.sendRedirect("/jsp/type/lvyou/Ads.jsp?time="+dir);
}
Properties p = new Properties();
FileInputStream in = new FileInputStream(request.getRealPath("/jsp/type/lvyou/ads.properties"));  
p.load(in);  
in.close();

%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache"> 
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache"> 
<META HTTP-EQUIV="Expires" CONTENT="0">
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" language="javascript" src="/tea/tea.js"></script>
<script src="/tea/Calendar.js" type="text/javascript"></script>
<title>广告管理</title>
</head>
<script>
  

  
  
</script>
<body id="bodynone">
 <h1>广告管理</h1>
 
  <form action="/jsp/type/lvyou/Ads.jsp" name="form1" method="POST" enctype="multipart/form-data">
    <input type="hidden" name="id" value="<%=id%>">
    <input type="hidden" name="act">
    <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
    <td>当前广告</td>
    <td><img src="<%=p.getProperty("src") %>?temp=<%=dir %>" /></td>
  </tr>
    <tr>
    <td>链接</td>
    <td><input name="href" value="<%=p.getProperty("href") %>" size="90"/></td>
  </tr>
  <tr>
    <td>选图</td>
    <td><input type="file" name="picture"  size="90"></td>
  </tr>
<tr>
    <td>&nbsp;</td>
    <td><input type="submit" name="submit" value="提交"></td>
  </tr>
 </table>
  </form>

</body>
</html>