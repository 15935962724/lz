<%@page contentType="text/html;charset=UTF-8"  %>
<%@page import="java.util.*" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.db.*" %>
<%@page import="tea.entity.site.*" %>
<%@page import="tea.ui.*" %>
<%@page import="tea.resource.*" %>
<%@page import="tea.entity.member.*" %>
<%@page import="tea.entity.node.*" %>
<%!
public String getString(javax.servlet.http.HttpServletResponse response,String value[])
{
  StringBuffer sb=new StringBuffer();
  try
    {
      if(value!=null)
      {
        String webname="http://127.0.0.1";//tea.entity.site.Community.find(teasession._nNode).getWebName();
        for(int index=0;index<value.length;index++)
        {
          sb.append(tea.applet.Http.getString(new java.net.URL(webname+"/jsp/type/resume/Preview.jsp?resumes="+value[index]+"&jsessionid=1DEF7C184B2B52104A08A4555B7C2126")));//)));
        }
      }
    }catch(Exception _ex)
    {}
    System.out.print(sb.toString()+"\r\n======================================\r\n");
    return sb.toString();
}
public String getString2(javax.servlet.http.HttpServletRequest request,javax.servlet.http.HttpServletResponse response,String value[])
{
  StringBuffer sb=new StringBuffer();
  try
  {
    if(value!=null)
    {
      String webname="http://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath();//tea.entity.site.Community.find(teasession._nNode).getWebName();
      for(int index=0;index<value.length;index++)
      {
        java.net.URLConnection conn = new java.net.URL(webname+"/jsp/type/resume/Preview.jsp?resumes="+value[index]+"&jsessionid=1DEF7C184B2B52104A08A4555B7C2126").openConnection();
        java.io.InputStream is = conn.getInputStream();
        int len = conn.getContentLength();
        System.out.print(len);
        if (len == -1) {
          StringBuffer sbc = new StringBuffer();
          int r = is.read();
          while (r != -1) {
            sbc.append((char)r);
            r = is.read();
          }
          sb.append(sbc.toString());
        }        else {
          byte by[] = new byte[len];
          is.read(by);
          is.close();
          sb.append(new String(by,"ISO-8859-1"));
        }
        sb.append("<hr size=1>");
      }
    }
  }catch(Exception e)
  {
    e.printStackTrace();
  }
//System.out.println(sb.toString());
return(sb.toString());
}
%>
<%
request.setCharacterEncoding("UTF-8");
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession = new TeaSession(request);
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
  return;
}

Resource r=new Resource("/tea/resource/Job");

if(request.getParameter("send")!=null)
{
    Community community=Community.find(teasession._strCommunity);
    String webn=community.getName(teasession._nLanguage);
    String act=request.getParameter("act");
    String values[]=request.getParameterValues("resumes");
    String subject=request.getParameter("subject");
    String text=request.getParameter("text");
    String to=request.getParameter("addressee");
    int k=0;
    if(act.equals("hr"))
    {
      String html=this.getString2(request,response,values);
      text+="<HR>"+html;
       k = Message.create(teasession._strCommunity,community.getEmail(),to, teasession._nLanguage,subject,text);
      try
      {
        tea.service.Robot.activateRoboty(teasession._nNode,k);
      } catch (Exception _ex)
      {}
    }else
    if(act.equals("export"))
    {
      tea.ui.node.type.resume.ExportResume er=new tea.ui.node.type.resume.ExportResume();
      k=Message.create(teasession._strCommunity,community.getEmail(),to, teasession._nLanguage,subject,text);
      Message m=Message.find(k);
      m.createAttachment(1,"exp.xls",er.getByte(values,teasession._nLanguage));
    }else
    {
       k = Message.create(teasession._strCommunity,community.getEmail(),to, teasession._nLanguage,subject,text);
    }
    try
    {
      tea.service.Robot.activateRoboty(teasession._nNode,k);
    } catch (Exception _ex)
    {}
    String nexturl=request.getParameter("nexturl");
    out.print("<script>window.alert('"+r.getString(teasession._nLanguage,"1167458969578")+"');");//发送完毕
    if(nexturl==null||nexturl.length()==0)
    {
      out.print("window.close();");
    }else
    {
      out.print("window.open('"+nexturl+"','_self');");
    }
    out.print("</script>");
    return;
}

String act=request.getParameter("act");

StringBuffer email=new StringBuffer();
StringBuffer sb=new StringBuffer();
String rs[]=request.getParameterValues("resumes");
for(int i=0;i<rs.length;i++)
{
  int nodeid=Integer.parseInt(rs[i]);

  String str=Profile.find(Node.find(nodeid).getCreator()._strV).getEmail();
  //if(vector.indexOf(str)==-1)
  {
    sb.append(new tea.html.HiddenField("resumes",nodeid));
    email.append(str).append(",");
  }
}

%>
<HTML>
<HEAD>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>

</HEAD>
<body onload="form1.addressee.focus();">
<h1><%=r.getString(teasession._nLanguage, "1167458288546")%><!--0发信到选中项--></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" action="?" method="post" onSubmit="return(submitText(this.addressee,'<%=r.getString(teasession._nLanguage,"InvalidEmailAddress")%>')&&submitText(this.subject,'<%=r.getString(teasession._nLanguage,"InvalidSubject")%>')&&submitText(this.text, '<%=r.getString(teasession._nLanguage,"InvalidText")%>'));">
<input type="hidden" name="act" value="<%=act%>">
<input type="hidden" name="send" value="on">
<%
String nexturl= request.getParameter("nexturl");
if(nexturl!=null&&nexturl.length()>0)
out.print(new tea.html.HiddenField("nexturl",nexturl));

String addressee="";
if(act.endsWith("hr"))//推荐应聘简历
{
}else
if(act.endsWith("export"))//导出简历
{
}else
{
  addressee=email.toString();
}
out.print(sb.toString());
%>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td><%=r.getString(teasession._nLanguage,"1167459072609")%><!--收件人-->:</td>
    <td ><input name="addressee" value="<%=addressee%>" type="text"  class="edit_input"  size="95"></td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage,"Subject")%><!--主题-->:</td>
    <td><input name="subject" type="text"  class="edit_input"  size="95"></td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage,"Text")%><!--内容-->:</td>
    <td><textarea name="text" cols="80"   class="edit_input" rows="15"></textarea></td>
  </tr>
</table>
<input type="submit" value="<%=r.getString(teasession._nLanguage,"CBSubmit")%>">
</form>


<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</HTML>
