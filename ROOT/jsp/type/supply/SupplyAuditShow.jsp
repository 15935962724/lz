<%@page contentType="text/html;charset=UTF-8" import="java.util.*" %>
<%@page import="tea.html.*" %>
<%@ page import="tea.htmlx.Languages"%>
<%@ page import="tea.ui.TeaSession"%>
<%@ page import="tea.entity.site.*" %>
<%@page import="tea.entity.node.*" %>
<%@ page import="tea.http.RequestHelper"%>
<%@ page import = "tea.resource.Resource" %>
<%@ page import = "tea.entity.node.Sms" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.member.*" %>
<%@page import="java.io.*" %>
<%@page import="tea.db.*"%>
<%@page import="tea.entity.util.*"%>
<%
TeaSession teasession = new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

Resource r = new Resource();

String nexturl = request.getParameter("nexturl");


int sid = 0;
if(teasession.getParameter("sid")!=null && teasession.getParameter("sid").length()>0)
sid = Integer.parseInt(teasession.getParameter("sid"));
Supply sobj = Supply.find(sid);
String subject =null,website=null,content=null;
int newstype =0,industrytype1=0,industrytype2=0,city=0,term=0,maplen=0;
if(sid>0)
{
  subject = sobj.getSubject();
  newstype = sobj.getNewstype();
  industrytype1 = sobj.getIndustrytype1();
  industrytype2= sobj.getIndustrytype2();
  city = sobj.getCity();
  term = sobj.getTerm();
  website = sobj.getWebsite();
  content = sobj.getContent();
if(sobj.getPicpath()!=null)
   maplen=(int)new java.io.File(application.getRealPath(sobj.getPicpath())).length();
}

if("shenhe".equals(teasession.getParameter("act")))
{
  Node n = Node.find(sobj.getNode());

  int t = Integer.parseInt(teasession.getParameter("ty"));
  if(t==1){//同意
    n.setHidden(false);
    sobj.setAuditTime();
    //response.sendRedirect("");
    out.println("<script>alert('您已经审核通过了供应信息!');</script>");
    out.println("<script>self.location='"+nexturl+"'</script>");
  }else
  {
     n.setHidden(true);
    //response.sendRedirect("");
    out.println("<script>alert('您没有通过供应信息审核!');</script>");
    out.println("<script>self.location='"+nexturl+"'</script>");
  }
}


%><html>
<head>
  <link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
  <script src="/tea/tea.js" type="text/javascript"></script>
  <SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/card.js" type="text/javascript"></SCRIPT>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body >

  <h1>供应信息详细</h1>
  <div id="head6"><img height="6" src="about:blank"></div>
  <div id="gqxx">
  <form action="?" method="POST" name="form1">
  <input type="hidden" name="sid" value="<%=sid%>"/>
  <input type="hidden" name="nexturl" value="<%=nexturl%>" />
  <input type="hidden" name="act" value="shenhe"/>

      <table border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td>标题</td>
          <td><%if(subject!=null)out.print(subject);%> </td>
        </tr>
        <tr>
          <td>信息类别</td>
          <td> <%=Supply.NEWS_TYPE[sobj.getNewstype()]  %></td>
        </tr>
        <tr>
          <td>所属行业：</td>
          <td>

            <%
            Node n1 = Node.find(sobj.getIndustrytype1());
            //Node n2 = Node.find(sobj.getIndustrytype2());
            out.print(n1.getSubject(teasession._nLanguage));
            //out.print(n2.getSubject(teasession._nLanguage));
            %>
          </td>
        </tr>
        <tr>
          <td>所属地区：</td>
          <td> <%=Card.find(city)%> </td>
        </tr>
        <tr>
          <td>有效期：</td>
          <td> <%=Supply.TERM[sobj.getTerm()]%></td>
        </tr>

        <tr>
          <td>图片上传：</td>
          <td>
          <%if(maplen>0){%>
          <a href="<%=sobj.getPicpath()%>" target="_blank"><%=sobj.getPicname()%></a>

            <%}else{out.print("暂无图片");} %>
          </td>
        </tr>
        <tr>
          <td>连接网站：</td>
           <td><a href="<%=website%>" target="_blank"><%if(website!=null)out.print(website);%></a></td>
        </tr>
        <tr>
          <td>内容：</td>
          <td><%if(content!=null)out.print(content); %><td>
        </tr>
        <tr>
        <td>
        <input type="radio" name="ty" value="1" checked="checked">同意
        <input type="radio" name="ty" value="-1">不同意
        </td>
        </tr>
      </table>
</div>
   <input type="submit" value=" 审 核 " >
      <input type=button value=" 返 回 " onClick="javascript:history.back()">
        </form>
    <div id="head6"><img height="6" src="about:blank"></div>
      <div id="language"><%=new Languages(teasession._nLanguage,request)%></div>

</body>
</html>
