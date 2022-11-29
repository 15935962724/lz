<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="tea.entity.node.*" %>
<%
System.out.print("到这里了");
int node = Integer.parseInt(request.getParameter("Node"));
int language = Integer.parseInt(request.getParameter("Language"));
String subject = request.getParameter("subject");
String city = request.getParameter("city");
String address = request.getParameter("address");
String logo = request.getParameter("logo");
String picture = request.getParameter("pic");
String contact = request.getParameter("contact");
String phone = request.getParameter("telephone");
String fax = request.getParameter("fax");
String postcode = request.getParameter("postcode");
String intro = request.getParameter("intro");
String content = request.getParameter("content");
int starclass = Integer.parseInt(request.getParameter("starclass"));
String price = request.getParameter("price");
int paytype = Integer.parseInt(request.getParameter("paytype"));
String introduce1 = request.getParameter("introduce1");
 String introduce2 = request.getParameter("introduce2");
 String introduce3 = request.getParameter("introduce3");
 String introduce4 = request.getParameter("introduce4");
 String introduce5 = request.getParameter("introduce5");
 Hostel hostel = new Hostel(node,language);
 hostel.create(node,language,subject,city,address,contact,phone,fax,postcode,intro,starclass,picture,logo,price,paytype,introduce1,introduce2,introduce3,introduce4,introduce5,content);;
 response.sendRedirect("jsp/info/Succeed.jsp?info="+"success!");
 }
 %>
