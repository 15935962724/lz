<%@page contentType="text/html;charset=UTF-8"  %><%@page import="java.util.*" %><%@page import="tea.ui.*" %><%@page import="tea.htmlx.*" %><%@page import="tea.resource.*" %><%@page import="tea.entity.member.*" %><%@page import="tea.entity.node.*" %><% request.setCharacterEncoding("UTF-8");

response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession = new TeaSession(request);
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
  return;
}
String community=teasession._strCommunity;


Resource r=new Resource("/tea/resource/Job");

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
<HEAD>
<link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"></HEAD>
<body>
<h1><%=r.getString(teasession._nLanguage,"1167467602203")%><!--我的职位夹--></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br>
<%
Enumeration e=Resume.getNode(teasession._rv.toString(),teasession._nLanguage);
while(e.hasMoreElements())
{
  int resumeid=((Integer)e.nextElement()).intValue();

%>
<h2><a href="/jsp/type/resume/EditResume.jsp?node=<%=resumeid%>"><%=Node.find(resumeid).getSubject(teasession._nLanguage)%></a>(<%=JobApply.countByResume(resumeid)%>)</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr ID=tableonetr>
    <td><%=r.getString(teasession._nLanguage,"1167457856062")%><!--申请日期--></td>
    <td><%=r.getString(teasession._nLanguage,"1167466871093")%><!--公司名称--></td>
    <td><%=r.getString(teasession._nLanguage,"1167454389921")%><!--职位--></td>
    <td><%=r.getString(teasession._nLanguage,"简历附件")%><!--申请表--></td>
  </tr>
  <%
  Enumeration e2=JobApply.findByResume(resumeid);
  if(!e2.hasMoreElements())
  {
    out.print("<tr><td colspan=10 align=center>暂无记录</td></tr>");
  }

  while(e2.hasMoreElements())
  {
    int jobid=((Integer)e2.nextElement()).intValue();
    JobApply apply=JobApply.find(resumeid,jobid);
    Job job=Job.find(jobid,teasession._nLanguage);
    Node node=Node.find(job.getOrgId());
    String subject=node.getSubject(teasession._nLanguage);

    %>
  <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    <td><%=apply.getTimeToString()%></td>
    <td><%if(subject==null)out.println("<font color=#FF0000>"+r.getString(teasession._nLanguage,"1167467806578")+"<!--该公司已经不存在--></font>");else out.println(subject);%></td>
    <td><a href='/servlet/Job?node=<%=jobid%>' target="_blank" id="PositionName"><%=Node.find(job.getNode()).getSubject(teasession._nLanguage)%></a></td>
    <td><%
    if(apply.getApplyTable()!=0)
    {
      ApplyTable at=ApplyTable.find(apply.getApplyTable());
      out.print("<a href='/servlet/EditApplyTable?act=down&applytable="+apply.getApplyTable()+"&name="+at.getName()+"'>");
      out.print(at.getName());
      out.print("</a>");
      }else
      {
        out.print("暂无附件");
      }

      %></td>
  </tr>
  <%}%>
</table>
<br>

<%}%>　


<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
