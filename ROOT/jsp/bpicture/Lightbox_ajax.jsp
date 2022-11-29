<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="tea.htmlx.*"%>
<%@ page import="tea.ui.TeaSession"%>
<%@ page import="tea.resource.*" %>
<%@ page import="tea.entity.bpicture.*" %>
<%@page import="tea.entity.node.*" %>
<%@ page import="java.util.*" %>
<%
request.setCharacterEncoding("UTF-8");
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
TeaSession teasession = new TeaSession(request);
String nexturl = request.getParameter("nexturl");
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/Node?node=2198284&language=1");
  return;
}
String member = teasession._rv._strR;

String picid = request.getParameter("pic");
String act = request.getParameter("act");

if(act.equals("lit")){
  String lightbox = request.getParameter("lightbox");
  if(lightbox==null){
    lightbox = Bperson.fingCL(member);
  }
  if(!BLightbox.isExisted(member,lightbox,picid))
  {
    int ipic = Integer.parseInt(picid);
    Picture p = Picture.find(ipic);
    Node n = Node.find(ipic);

    BLightbox.setPic(lightbox,member,picid);
    if(!BLightbox.isExtCaption(member,ipic,lightbox))
    {
      BLightbox.createCaption(n.getSubject(1),ipic,member,lightbox);
    }
  }

  String info = "";
  if(request.getParameter("imginfo")!=null)
  {
    info = "&nbsp;添加至收藏夹";
  }
  out.print("<a href=# onclick=c_seat(lit_"+picid+",light,"+picid+");><img width=17 height=17 border=0 src=/tea/image/bpicture/right.gif alt=已收藏>"+info+"</a>");

}else if(act.equals("ordering")){
  String psize = request.getParameter("psize");
  int ipsize = Integer.parseInt(psize);
  String pri = request.getParameter("pri");
  int ipri = Integer.parseInt(pri);
  int pid = Integer.parseInt(picid);

    Bimage.createOrder(pid,6,new java.math.BigDecimal(pri),member,teasession._strCommunity,ipsize,1);

  out.print("<table><tr><td><b>提示：</b></td></tr><tr><td>　　订购成功！</br>　　请等待管理员对您所订购的图片进行审核...</td></tr><tr><td align=center><input type=button value=确定 onclick=document.getElementById('othero').style.display='none'; /></td></tr></table>");
}else if(act.equals("meminfo")){
	
  String mem= request.getParameter("member");
  tea.entity.member.Profile p = tea.entity.member.Profile.find(mem);
  Bperson b = Bperson.findmember(mem);
  String comname = b.getComName()==null?"":b.getComName();
  String phone = b.getPhone()==null?"":b.getPhone();
  String county = b.getChequeCounty()==null?"":b.getChequeCounty();
  String addr = b.getAddr()==null?"":b.getAddr();
  String zip = b.getZip()==null?"":b.getZip();

  out.print("<table><tr><td>会员ID：</td><td>"+mem+"</td></tr><tr><td>姓名：</td><td>"+p.getFirstName(1)+"</td></tr>"+
  "<tr><td>公司：</td><td>"+comname+"</td></tr><tr><td>联系电话：</td><td>"+phone+"</td></tr>"+
  "<tr><td>所属地区：</td><td>"+Common.CSVCITYS[Integer.parseInt(b.getState())][1]+"　　城市："+county+"</td></tr>"+
  "<tr><td>地址：</td><td>"+addr+"</td></tr><tr><td>邮编：</td><td>"+zip+"</td></tr></table>");
}else{
  int pid = Integer.parseInt(picid);
  if(Bimage.falgSale(pid,member))
  {
    Bimage.create(pid,0,new java.math.BigDecimal(0),member,teasession._strCommunity);
  }
  out.print("<img width=17 height=17 border=0 src=/tea/image/bpicture/right.gif alt=已添加>");
}


%>
