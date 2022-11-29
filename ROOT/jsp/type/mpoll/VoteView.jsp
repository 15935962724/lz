<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.entity.node.type.mpoll.*"%><%

Http h=new Http(request,response);


Vote v=Vote.find(h.getInt("vote"));
if(!h.getBool("inc"))
{
  out.println("<html><head>");
  out.println("<link href='/res/"+h.community+"/cssjs/community.css' rel='stylesheet' type='text/css' />");
  out.println("<script src='/tea/mt.js' type='text/javascript'></script>");
  out.println("<style>#template{display:none}</style>");
  out.println("<style>");
  out.println("body{text-align:left;padding-left:50px} .question{padding-top:20px;}");
  out.println(".ok{background:url(/tea/image/public/check_right.gif) no-repeat right;padding-right:20px}");
  out.println(".err{background:url(/tea/image/public/check_error.gif) no-repeat right;padding-right:20px}");
  out.println("</style>");
  out.println("</head><body><h1>问卷答案</h1><div id='head6'><img height='6' src='about:blank'></div>");
}
out.print(v.toString(1));
%>


