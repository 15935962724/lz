<%@page contentType="text/html;charset=UTF-8"  %>
<%String ip=request.getRemoteAddr();
java.io.File file=new java.io.File(application.getRealPath("/REFERER.log"));
java.io.FileWriter fw=new java.io.FileWriter(file,true);
fw.write(new java.text.SimpleDateFormat("yyyy-MM-dd hh:mm").format(new java.util.Date())+"\t"+ip+"\t"+request.getHeader("referer")+"\r\n");
fw.close();




















if(!"61.51.204.222".equals(ip)&&!"219.237.26.144".equals(ip))
{%>
<jsp:forward page="/servlet/Node">
  <jsp:param name="Node" value="25281"/>
</jsp:forward>
<%}else
response.sendError(404,request.getRequestURI());
%>

