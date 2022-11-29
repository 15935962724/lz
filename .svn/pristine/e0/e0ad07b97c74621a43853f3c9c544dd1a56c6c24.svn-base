<%@page contentType="text/html;charset=UTF-8"  %><%@page import="tea.db.*" %><%@page import="tea.entity.site.*" %><%@page import="java.util.*" %><%@page import="tea.ui.*" %><%@page import="tea.resource.*" %><%@page import="tea.entity.member.*" %><%@page import="tea.entity.node.*" %><%

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

//Communityjob communityjob=Communityjob.find(teasession._strCommunity);



boolean boolEmployment=Employment.find(teasession._nNode,teasession._nLanguage).hasMoreElements();
boolean boolEducate=Educate.find(teasession._nNode,teasession._nLanguage).hasMoreElements();
boolean boolAward=Award.findByNode(teasession._nNode,teasession._nLanguage).hasMoreElements();
boolean boolProfessional=Professional.find(teasession._nNode,teasession._nLanguage).hasMoreElements();
boolean boolLang=Lang.find(teasession._nNode,teasession._nLanguage).hasMoreElements();
boolean boolFamily=Family.find(teasession._nNode,teasession._nLanguage).hasMoreElements();
Resume resume=Resume.find(teasession._nNode,teasession._nLanguage);
if((resume.getExperience()==0||boolEmployment)&&boolEducate&& boolAward &&boolProfessional && boolLang &&boolFamily)
{
  //out.println(r.getString(teasession._nLanguage,"Intactness"));
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
  out.println("<script>if(confirm('"+r.getString(teasession._nLanguage,"1168304098453")+"')){document.location.replace('/jsp/type/resume/Resume.jsp'); }else{ window.history.back(); }</script>");
  return;
}




int count=0;
int pagesize=25;
int pos= request.getParameter("pos")==null?0:Integer.parseInt(request.getParameter("pos"));

java.util.Vector vector=new java.util.Vector();
DbAdapter dbadapter = new DbAdapter();
try
{
  count=dbadapter.getInt("SELECT COUNT(n.node) FROM Node n INNER JOIN Job j ON n.node=j.node WHERE n.hidden=0 AND n.type=50 AND n.community="+dbadapter.cite(teasession._strCommunity));
  dbadapter.executeQuery("SELECT n.node FROM Node n INNER JOIN Job j ON n.node=j.node WHERE n.hidden=0 AND n.type=50 AND n.community="+dbadapter.cite(teasession._strCommunity)+" ORDER BY n.time DESC");
  for (int l = 0; l < pos + pagesize && dbadapter.next(); l++)
  {
    if (l >= pos)
    {
      vector.addElement(Integer.valueOf(dbadapter.getInt(1)));
    }
  }
} finally
{
  dbadapter.close();
}
java.util.Enumeration enumeration=vector.elements();

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
</head>
<BODY>
<h1><%=r.getString(teasession._nLanguage, "1167545440578")%><!--申请职位--></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br>

<form action="/servlet/EditApply">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="Node" value="<%=teasession._nNode%>"/>
<input type="hidden" name="action" value="editapply2"/>

<table  border="0"  id="tablecenter" cellpadding="0" cellspacing="0">
  <tr ID=tableonetr>
    <td></td>
    <TD><%=r.getString(teasession._nLanguage, "1167454389921")%><!--职位名称--></TD>
    <TD><%=r.getString(teasession._nLanguage, "1167466871093")%><!--公司名称--></TD>
    <TD><%=r.getString(teasession._nLanguage, "1167444505750")%><!--=发布时间--></TD>
  </TR>
  <%
  while(enumeration.hasMoreElements())
  {
    int id=((Integer)enumeration.nextElement()).intValue();
    Node node=Node.find(id);
    Job job=Job.find(id,teasession._nLanguage);
    out.print("<tr onmouseover=\"javascript:this.bgColor='#BCD1E9';\" onMouseOut=\"javascript:this.bgColor='';\" >");
    out.print("<td width=1><input name=jobs type=checkbox value="+id+" /></td>");
    out.print("<td><a target=_blank href=/servlet/Node?node="+id+" >"+node.getSubject(teasession._nLanguage)+"</a></td>");
    out.print("<td><a target=_blank href=/servlet/Node?node="+job.getSltOrgId()+" >"+Node.find(job.getSltOrgId()).getSubject(teasession._nLanguage)+"</a></td>");
    out.print("<td>"+node.getTimeToString()+"</td></tr>");
  }
  %>
  <tr><td colspan="3" align="center"><%=new tea.htmlx.FPNL(teasession._nLanguage,request.getRequestURI()+"?node="+teasession._nNode+"&pos=",pos,count)%></td></tr>
</TABLE>


<!--申请职位-->
<input class="edit_button" name="submit" type=submit value="<%=r.getString(teasession._nLanguage,"1167545440578")%>">

</form>



<br>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</BODY>
</html>

