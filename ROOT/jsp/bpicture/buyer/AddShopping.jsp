<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="tea.htmlx.*"%>
<%@ page import="tea.ui.TeaSession"%>
<%@ page import="tea.resource.*" %>
<%@ page import="tea.entity.bpicture.*" %>
<%@ page import="java.util.*" %>
<%
TeaSession teasession = new TeaSession(request);
String member = teasession._rv._strR;
String act = request.getParameter("act");
String node = request.getParameter("node");
int inode = Integer.parseInt(node);
String nexturl = request.getParameter("nexturl");
if(act.equals("add"))
{
  if(Bimage.falgSale(inode,member))
  {
    Bimage.create(inode,0,new java.math.BigDecimal(0),member,teasession._strCommunity);
  }
}else if(act.equals("del")){
  Bimage.delete(inode,member,teasession._strCommunity);
}else if(act.equals("remove")){
  String lightbox = request.getParameter("lightbox");
  int lbidold = BLightbox.findId(member,lightbox);
  BLightbox blb = BLightbox.find(lbidold);

  String picidold = blb.getpicid();
  String canPicid = picidold.replaceAll("," + node,"");
  BLightbox.canPic(lightbox,canPicid,member);
  BLightbox.delCaption(inode,member,lightbox);
}else{
  //加入收藏
}

response.sendRedirect(nexturl);
%>
