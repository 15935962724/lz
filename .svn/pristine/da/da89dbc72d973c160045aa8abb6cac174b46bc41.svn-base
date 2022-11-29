<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="java.text.*"%>

<%@ page import="tea.html.*"%>
<%@ page import="tea.htmlx.*"%>
<%@ page import="tea.entity.admin.*" %>
<%@ page import="tea.db.*" %>
<%@ page import="tea.entity.site.*" %>
<%@ page import="tea.ui.*" %>
<%@ page import="tea.resource.*" %>
<%@ page import="tea.entity.member.*" %>
<%@ page import="tea.entity.node.*" %>
<%@ page import="tea.ui.TeaServlet"%>
<%@ page import="tea.ui.TeaSession"%>
<%@ page import="org.apache.commons.fileupload.FileItem"%>
<%@ page import="org.apache.commons.fileupload.FileUploadException"%>
<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@ page import="jxl.write.WriteException" %>
<%
  response.setHeader("Expires", "0");
  response.setHeader("Cache-Control", "no-cache");
  response.setHeader("Pragma", "no-cache");
  request.setCharacterEncoding("UTF-8");
  TeaSession teasession= new TeaSession(request);
  String community = teasession._strCommunity;
  if(teasession._rv == null)
  {
    response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
    return;
  }


  String act = teasession.getParameter("act");//request.getParameter("act");

  if("del2".equals(act)){//多项删除
    String[] id = request.getParameterValues("lid");
    for(int i = 0;i < id.length;i++){
      int nid = Integer.parseInt(id[i]);
      Node node = Node.find(nid);
      node.delete(nid);
      Logo obj = Logo.find(nid);
      obj.delete();
    }
    response.sendRedirect("/jsp/type/logo/LogoManage.jsp");
  }
  if("del".equals(act)){//单项删除
    int nid = Integer.parseInt(teasession.getParameter("logoid"));
    Node node = Node.find(nid);
    Node nobj = Node.find(nid);
    nobj.delete(teasession._nLanguage);
    Logo lobj = Logo.find(nid);
    lobj.delete();

    response.sendRedirect("/jsp/type/logo/LogoManage.jsp");
  }

//  if("EditLogo".equals(act)){//单项删除
//    int language = teasession._nLanguage;
//    int nid = Integer.parseInt(teasession.getParameter("logoid"));
//    Node node = Node.find(nid);
//    Logo logo = Logo.find(nid);
//    String logotype = teasession.getParameter("logotype");
//    String logoname = teasession.getParameter("logoname");
//    String logoimage = teasession.getParameter("logoimage");
//    if(logoimage == null){
//      logoimage = logo.getLogoimage();
//    }
//    String logouse = teasession.getParameter("logouse");
//    String regnum = teasession.getParameter("regnum");
//    String content = teasession.getParameter("content");
//    String regdate = teasession.getParameter("regdate");
//    SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
//    Date date = null;
//    if(regdate != null && !regdate.equals("")){
//      try {
//        date = format.parse(regdate);
//      } catch (ParseException e) {
//        e.printStackTrace();
//      }
//    }
//    node.set(teasession._nLanguage,logoname,content);//入NODE表
//    logo.set(logotype,logoimage,logouse,regnum,date);
//    //logo.set(community,language,logotype,logoname,logoimage,logouse,regnum,content,date);
//    response.sendRedirect("LogoManage.jsp");
//  }
//  //添加商标
//  if("add".equals(act)){
//    int language = teasession._nLanguage;
//    String logotype = teasession.getParameter("logotype");
//    String logoname = teasession.getParameter("logoname");
//    String logoimage = teasession.getParameter("logoimage");
//    String logouse = teasession.getParameter("logouse");
//    String regnum = teasession.getParameter("regnum");
//    String content = teasession.getParameter("content");
//    String regdate = teasession.getParameter("regdate");
//    SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
//    Date date = null;
//    if(regdate != null && !regdate.equals("")){
//      try {
//        date = format.parse(regdate);
//      } catch (ParseException e) {
//        e.printStackTrace();
//      }
//    }
//
//
//    Logo.create(teasession._nNode,logotype,logoimage,logouse,regnum,date,teasession._strCommunity);
//    response.sendRedirect("LogoManage.jsp");
//  }
%>
