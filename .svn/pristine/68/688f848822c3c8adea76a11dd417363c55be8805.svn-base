<%@page contentType="text/html;charset=UTF-8"  %><%@page import="tea.entity.site.*" %><%@page import="java.util.*" %><%@page import="tea.ui.*" %><%@page import="tea.resource.*" %><%@page import="tea.entity.member.*" %><%@page import="tea.entity.node.*" %><%

response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession = new TeaSession(request);
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
  return;
}

tea.resource.Resource r=new tea.resource.Resource("/tea/resource/Job");

Communityjob communityjob=Communityjob.find(teasession._strCommunity);

java.util.Enumeration enumeration=Resume.getNode(teasession._rv.toString(),teasession._nLanguage);
if(!enumeration.hasMoreElements())
{
  response.sendRedirect("/jsp/type/resume/EditResume.jsp?NewNode=ON&Type=52&TypeAlias=0&node="+communityjob.getResume()+"&nexturl="+java.net.URLEncoder.encode("/jsp/type/job/EditApply2.jsp?","UTF-8"));
  //  response.sendRedirect("/jsp/info/Alert.jsp?info="+java.net.URLEncoder.encode(r.getString(teasession._nLanguage,"1167545232593"),"UTF-8"));
  return;
}





Node node=Node.find(teasession._nNode);
Job job=Job.find(teasession._nNode,teasession._nLanguage);
//String email=getNull(Classified.find(job.getSltOrgId()).getEmail(teasession._nLanguage));



%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<script type="">
function fselect()
{
  if(form1.applytable)
  form1.submit.disabled=false;
}
fselect();
</script>

</head>
<BODY>
<h1><%=r.getString(teasession._nLanguage, "1167545440578")%><!--申请职位--></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<h2><%=r.getString(teasession._nLanguage, "1167545474640")%><!--你要申请的职位如下--></h2>
<table  border="0"  id="tablecenter" cellpadding="0" cellspacing="0">
  <TR>
    <TD><%=r.getString(teasession._nLanguage, "1167466871093")%><!--公司名称-->：</TD>
    <TD><%=tea.entity.node.Node.find(job.getSltOrgId()).getSubject(teasession._nLanguage)%></TD>
  </TR>
  <TR>
    <TD><%=r.getString(teasession._nLanguage, "1167454389921")%><!--职位名称-->：</TD>
    <TD> <%=node.getSubject(teasession._nLanguage)%> </TD>
  </TR>
  <TR>
    <TD><%=r.getString(teasession._nLanguage, "1167446047937")%><!--职业类别-->：</TD>
    <TD> <%=job.getSltOccId("&nbsp")%> </TD>
  </TR>
  <%--
          <TR bgcolor="#FFFFFF">
            <TD width="98" align="right"> <span id="Emaillabel">E-mail：</TD>
            <TD> <span id="lblJobEmail"><a href='mailto:<%out.println(email);//job.getEmail()%>'>
              <%out.println(email);//job.getEmail()%>
            </a></TD>
          </TR>--%>
</TABLE>

<h2><%=r.getString(teasession._nLanguage,"MyResume")%></h2>
<form action="/servlet/EditApply" name="form1">
<table  border="0"  id="tablecenter" cellpadding="0" cellspacing="0">
  <tr id="tableonetr">
  <td><%=r.getString(teasession._nLanguage,"Name")%></td>
  <td><%=r.getString(teasession._nLanguage,"Preview/Print")%></td>
<%--<td><%=r.getString(teasession._nLanguage,"Update")%></td>
  <td><%=r.getString(teasession._nLanguage,"Delete")%></td>--%>
  <td><%=r.getString(teasession._nLanguage,"Status")%></td>
  <td><%=r.getString(teasession._nLanguage,"UpdateTime")%></td>
  </tr>
  <%
Resume resume=null;
int nodecode=0;
while(enumeration.hasMoreElements())
{
    nodecode=((Integer)enumeration.nextElement()).intValue();
    Node obj=Node.find(nodecode);
    resume=Resume.find(nodecode,teasession._nLanguage);

    boolean boolEmployment=Employment.find(nodecode,teasession._nLanguage).hasMoreElements();
    boolean boolEducate=Educate.find(nodecode,teasession._nLanguage).hasMoreElements();
    boolean boolAward=Award.findByNode(nodecode,teasession._nLanguage).hasMoreElements();
    boolean boolProfessional=Professional.find(nodecode,teasession._nLanguage).hasMoreElements();
    boolean boolLang=Lang.find(nodecode,teasession._nLanguage).hasMoreElements();
    boolean boolFamily=Family.find(nodecode,teasession._nLanguage).hasMoreElements();
    boolean boolfull=((resume.getExperience()==0||boolEmployment)&&boolEducate&& boolAward &&boolProfessional && boolLang &&boolFamily);
%>
  <tr>
    <td>
      <input  id="radio3" type="radio" name="resumenode" onClick="fselect();" value="<%=nodecode%>"                      <%if(!boolfull)out.print(" disabled ");%>><%=obj.getSubject(teasession._nLanguage)%></td>
      <td align="center"><a href='/jsp/type/resume/Preview.jsp?node=<%=nodecode%>' target="_blank"><img src="/tea/image/public/print.gif" width="18" height="17" border="0" /></a></td>
<%--    <td align="center"><a href='/jsp/type/resume/EditResume.jsp?EditNode=ON&node=<%=nodecode%>&nexturl=/jsp/type/resume/Resume.jsp'><img src="/tea/image/public/update.gif" width="16" height="17" border="0"  /></a></td>
    <td align="center"><A href="###" onclick="if(confirm('<%=r.getString(teasession._nLanguage,"ConfirmDelete")%>'))window.open('/servlet/DeleteResume?node=<%=nodecode%>&Language=<%=teasession._nLanguage%>','_self');" ><img SRC="/tea/image/public/delete.gif" border="0" /></a></td>
--%>    <td>
    <%
    if(boolfull)
    {
      out.println(r.getString(teasession._nLanguage,"Intactness"));
    }else
    {
      String strtitle="";
      if(!boolEmployment)
      {
        strtitle=strtitle+r.getString(teasession._nLanguage,"Note.Job.Deformity.0");
      }
      if(!boolEducate)
      {
        strtitle=strtitle+"\\r\\n"+r.getString(teasession._nLanguage,"Note.Job.Deformity.1");
      }
      if(!boolAward)
      {
        strtitle=strtitle+"\\r\\n"+r.getString(teasession._nLanguage,"Note.Job.Deformity.2");
      }
      if(!boolProfessional)
      {
        strtitle=strtitle+"\\r\\n"+r.getString(teasession._nLanguage,"Note.Job.Deformity.3");
      }
      if(!boolLang)
      {
        strtitle=strtitle+"\\r\\n"+r.getString(teasession._nLanguage,"Note.Job.Deformity.4");
      }
      if(!boolFamily)
      {
        strtitle=strtitle+"\\r\\n"+r.getString(teasession._nLanguage,"Note.Job.Deformity.5");
      }
      out.println("<A style=\"a:link{color: #FF0000;}\" href=\"javascript:alert('"+strtitle+"');\"><font color=\"#FF0000\" title=\""+strtitle+"\">"+r.getString(teasession._nLanguage,"Job.Deformity")+"</font></A>");
    }
    %>

    </td>
    <td align="center"><%=obj.getUpdatetimeToString()%></td>
  </tr>
  <%}

  if(nodecode==0)
  {
    out.print("<tr><td colspan=6><input  type=button value="+r.getString(teasession._nLanguage,"Job.NewResume")+" onClick='javascript:window.location=\"/jsp/type/resume/EditResume.jsp?NewNode=ON&Type=52&TypeAlias=0&node="+communityjob.getResume()+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8")+"\";'></td></tr>");
  }
  %>
</table>
<br>
<h2><%=r.getString(teasession._nLanguage,"MyApplytable")%></h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr ID=tableonetr>
    <td><%=r.getString(teasession._nLanguage,"Applytable")%></td>
    <td><%=r.getString(teasession._nLanguage,"Download")%></td>
    <td><%=r.getString(teasession._nLanguage,"Size")%></td>
    <td><%=r.getString(teasession._nLanguage,"UpdateTime")%></td>
  </tr>
<%
if((communityjob.getOptions()&1)==0)
{
  out.print("<tr><td><input name=applytable  id=radio type=radio value=0 >"+r.getString(teasession._nLanguage,"1167543721250"));
}
enumeration=ApplyTable.findByMember(teasession._rv._strR,teasession._strCommunity);
boolean boolAT=false;
while(enumeration.hasMoreElements())
{
  nodecode=((Integer)enumeration.nextElement()).intValue();
  ApplyTable at=ApplyTable.find(nodecode);
  boolAT=true;
  out.print("<tr><td><input  id=radio type=radio name=applytable  checked value="+nodecode+" >"+at.getName());
  out.print("<td><a href='/servlet/EditApplyTable?act=down&applytable="+nodecode+"&name="+at.getName()+"'><img SRC=/tea/image/public/download.gif width=18 height=17 border=0 /></a></td>");
  out.print("<td>"+(new java.io.File(application.getRealPath(at.getFile())).length())+"B</td>");
  out.print("<td>"+at.getTimeToString()+"</td>");
}
/*
if(boolAT)
out.print("<br>请选择您已创建的竞聘申请表作为申请该职位的简历附件");
else
out.print("<br>您还没有创建用于申请职位的竞聘申请表,点击<A href=/jsp/type/resume/Resume.jsp>这里</A>下载并创建竞聘申请表");
*/
%>
</table>
<br>
<!--用选中的简历和申请表申请该职位-->
<input class="edit_button" name="submit" type=submit disabled="disabled" value="<%=r.getString(teasession._nLanguage,"1167546232890")%>">

</form>


<%--
<div align="center">
  <input type="button" value="关闭" onclick="javaScript:window.close(); " />
</div>
--%>

<br>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</BODY>
</html>

