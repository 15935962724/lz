<%@ page contentType="text/html; charset=UTF-8" %>
<%@page import="tea.ui.*" %>
<%@page import="tea.entity.member.*" %>
<%@page import="java.util.*" %>
<%@page import="org.dom4j.*" %>
<%
request.setCharacterEncoding("UTF-8");
TeaSession  teasession = new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}
String member = teasession._rv._strV;
String newpassword = request.getParameter("newpassword");
if(request.getParameter("newpassword")!=null)
{
  Profile p = Profile.find(member);
  SynRegMethod srm = new SynRegMethod();
  try{
//    String sendXML = srm.writeXML("1", member, "-1", newpassword, "-1", "-1", "-1", "-1", "-1", "-1");
//    HttpRequester hreq = new HttpRequester(); //
//    Map param = new HashMap();
//    sendXML = java.net.URLEncoder.encode(sendXML, "gb2312");
//    param.put("request", sendXML);
//    HttpRespons hr = hreq.sendGet("http://222.35.63.147/golden%5Ftest/GoldenPort.asp", param, null);
//
//    String getXML = hr.getContent();
//    System.out.println("接收XML："+ getXML);
//    Document document = DocumentHelper.parseText(getXML);
//    Element root = document.getRootElement();
//    String result = root.element("Result").getText();
//
//    if ("0".equals(result))
//    {
  p.setPassword(newpassword);
response.sendRedirect("/jsp/registration/uppsuc.jsp");
//        out.println("<script>alert('恭喜您修改成功!');</script>");

//      else
//      {
//        out.println("<script>alert('很抱歉,您没能修改密码!')</script>");
//      }
//    }

  }catch (java.io.IOException ex)
        {
            ex.printStackTrace();
//        }catch (org.dom4j.DocumentException ex)
//        {
//            ex.printStackTrace();
        }
}
%>
