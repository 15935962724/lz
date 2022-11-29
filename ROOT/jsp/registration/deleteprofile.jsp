<%@ page contentType="text/html; charset=UTF-8" %>
<%@page import="tea.ui.*" %>
<%@page import="tea.entity.member.*" %>
<%@page import="java.util.*" %>
<%@page import="org.dom4j.*" %>

<%
request.setCharacterEncoding("UTF-8");
TeaSession teasession = new  TeaSession(request);
String member = teasession.getParameter("member");
try{
//  SynRegMethod srm = new SynRegMethod();
//  String sendXML = srm.writeXML("2" , member, "-1", "-1", "-1", "-1", "-1", "-1", "-1", "-1");
//
//  HttpRequester hreq = new HttpRequester(); //
//  Map param = new HashMap();
//  sendXML = java.net.URLEncoder.encode(sendXML, "gb2312");
//  param.put("request", sendXML);
//  HttpRespons hr = hreq.sendGet("http://222.35.63.147/golden%5Ftest/GoldenPort.asp", param, null);
//
//  String getXML = hr.getContent();
//  System.out.println("接收XML："+ getXML);
//  Document document = DocumentHelper.parseText(getXML);
//  Element root = document.getRootElement();
//  String result = root.element("Result").getText();
//
//  if ("0".equals(result))
//  {

    Profile.delete(member,teasession._nLanguage,teasession._strCommunity);
    //Profile.delete(member,teasession._nLanguage,teasession._strCommunity);
    response.sendRedirect("/jsp/registration/callersmember.jsp");
//  }else{
//    //删除失败
//    System.out.println("删除失败");
//  }
  }catch (java.io.IOException ex)
        {
            ex.printStackTrace();
//        }catch (org.dom4j.DocumentException ex)
//        {
//            ex.printStackTrace();
        }
  %>
