<%@page contentType="text/html;charset=UTF-8"  %><%@page import="java.util.*" %><%@page import="tea.entity.site.*" %><%@page import="tea.ui.*" %><%@page import="tea.resource.*" %><%@page import="tea.entity.member.*" %><%@page import="tea.entity.node.*" %><%request.setCharacterEncoding("UTF-8");

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

Communityjob communityjob=Communityjob.find(community);

tea.resource.Resource r=new tea.resource.Resource("/tea/resource/Job");
%>
<HTML>
<HEAD>
<link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
</HEAD>
<body >


<h1><%=r.getString(teasession._nLanguage,"ResumeCenter")%></h1>
  <div id="head6"><img height="6" src="about:blank"></div>

<h2><%=r.getString(teasession._nLanguage,"MyResume")%></h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr ID=tableonetr>
  <td><%=r.getString(teasession._nLanguage,"Name")%></td>
  <td><%=r.getString(teasession._nLanguage,"Preview/Print")%></td>
  <td><%=r.getString(teasession._nLanguage,"Update")%></td>
  <td><%=r.getString(teasession._nLanguage,"Delete")%></td>
  <td><%=r.getString(teasession._nLanguage,"Status")%></td>
  <td><%=r.getString(teasession._nLanguage,"UpdateTime")%></td>
</tr>
<%
Resume summary;
java.util.Enumeration enumeration=Resume.getNode(teasession._rv.toString(),1);
int nodecode=0;
while(enumeration.hasMoreElements())
{
    nodecode=((Integer)enumeration.nextElement()).intValue();
    summary=Resume.find(nodecode,teasession._nLanguage);
    Node obj=Node.find(nodecode);
%>
<tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
<td><%=obj.getSubject(teasession._nLanguage)%></td>
<td align="center"><a href='/jsp/type/resume/Preview.jsp?resumes=<%=nodecode%>' target="_blank"><img src="/tea/image/public/print.gif" width="18" height="17" border="0" /></a></td>
<td align="center"><a href='/jsp/type/resume/EditResume.jsp?EditNode=ON&node=<%=nodecode%>&nexturl=/jsp/type/resume/Resume.jsp%3F'><img src="/tea/image/public/update.gif" width="16" height="17" border="0"  /></a></td>
<td align="center"><A href="###" onclick="if(confirm('<%=r.getString(teasession._nLanguage,"ConfirmDelete")%>'))window.open('/servlet/DeleteResume?node=<%=nodecode%>&Language=<%=teasession._nLanguage%>','_self');" ><img SRC="/tea/image/public/delete.gif" border="0" /></a></td>
<td align="center">
<%
             boolean boolEmployment=Employment.find(nodecode,teasession._nLanguage).hasMoreElements();
             boolean boolEducate=Educate.find(nodecode,teasession._nLanguage).hasMoreElements();
             boolean boolAward=Award.findByNode(nodecode,teasession._nLanguage).hasMoreElements();
             boolean boolProfessional=Professional.find(nodecode,teasession._nLanguage).hasMoreElements();
             boolean boolLang=Lang.find(nodecode,teasession._nLanguage).hasMoreElements();
             boolean boolFamily=Family.find(nodecode,teasession._nLanguage).hasMoreElements();

              if((summary.getExperience()==0||boolEmployment)&&boolEducate &&boolProfessional)
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
//                if(!boolAward)
//                {
//                  strtitle=strtitle+"\\r\\n"+r.getString(teasession._nLanguage,"Note.Job.Deformity.2");
//                }
                if(!boolProfessional)
                {
                  strtitle=strtitle+"\\r\\n"+r.getString(teasession._nLanguage,"Note.Job.Deformity.3");
                }
//                if(!boolLang)
//                {
//                  strtitle=strtitle+"\\r\\n"+r.getString(teasession._nLanguage,"Note.Job.Deformity.4");
//                }
//                if(!boolFamily)
//                {
//                  strtitle=strtitle+"\\r\\n"+r.getString(teasession._nLanguage,"Note.Job.Deformity.5");
//                }
                out.println("<A style=\"a:link{color: #FF0000;}\" href=\"javascript:alert('"+strtitle+"');\"><font color=\"#FF0000\" title=\""+strtitle.replace("\\r\\n","&#13;")+"\">"+r.getString(teasession._nLanguage,"Job.Deformity")+"</font></A>");
              }
              %>
              <!--<a href='/jsp/type/resume/SendResume.jsp?node=<%=nodecode%>' target="_blank"> <img SRC="/images/sign_08.gif" width="24" height="17" border="0" alt="发送简历" /></a>-->
          </td>
          <td align="center"><%=obj.getUpdatetimeToString()%></td>
</tr>
<tr>
<td>
<a href="/" target="_top">返回首页</a>
</td>
</tr>
        <%}
        if(nodecode==0)
        {
          out.print("<tr><td colspan=6><input  type=button value="+r.getString(teasession._nLanguage,"Job.NewResume")+" onClick='javascript:window.location=\"/jsp/type/resume/EditResume.jsp?NewNode=ON&Type=52&TypeAlias=0&node="+communityjob.getResume()+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8")+"\";'></td></tr>");
        }
        %>
</table>

<br>
<h2><%=r.getString(teasession._nLanguage,"我的简历文件")%></h2>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">

<tr >
  <td><%=r.getString(teasession._nLanguage,"简历文件上传")%></td>
  <td colspan="5">
          <%


String at1=communityjob.getApplytable();
String atn1=communityjob.getApplytablename();

int apply_count =0;

if(at1!=null&&at1.length()>0)
{
  apply_count++;
 // out.println("<a href=/jsp/include/DownFile.jsp?uri="+java.net.URLEncoder.encode(at1,"UTF-8")+"&name="+java.net.URLEncoder.encode(atn1,"UTF-8")+">"+atn1+"</a>");
}
String at2=communityjob.getApplytable2();
String atn2=communityjob.getApplytablename2();
if(at2!=null&&at2.length()>0)
{
  apply_count++;
 // out.println("<a href=/jsp/include/DownFile.jsp?uri="+java.net.URLEncoder.encode(at2,"UTF-8")+"&name="+java.net.URLEncoder.encode(atn2,"UTF-8")+">"+atn2+"</a>");
}
String at3=communityjob.getApplytable3();
String atn3=communityjob.getApplytablename3();
if(at3!=null&&at3.length()>0)
{
  apply_count++;
 // out.println("<a href=/jsp/include/DownFile.jsp?uri="+java.net.URLEncoder.encode(at3,"UTF-8")+"&name="+java.net.URLEncoder.encode(atn3,"UTF-8")+">"+atn3+"</a>");
}
String at4=communityjob.getApplytable4();
String atn4=communityjob.getApplytablename4();
if(at4!=null&&at4.length()>0)
{
  apply_count++;
  //out.print("<a href=/jsp/include/DownFile.jsp?uri="+java.net.URLEncoder.encode(at4,"UTF-8")+"&name="+java.net.URLEncoder.encode(atn4,"UTF-8")+">"+atn4+"</a>");
}

          %>
          </td>
        </tr>


        <tr ID=tableonetr>
          <td><%=r.getString(teasession._nLanguage,"简历文件")%></td>
          <td><%=r.getString(teasession._nLanguage,"Download")%></td>
          <td><%=r.getString(teasession._nLanguage,"Update")%></td>
          <td><%=r.getString(teasession._nLanguage,"Delete")%></td>
          <td><%=r.getString(teasession._nLanguage,"Size")%></td>
          <td><%=r.getString(teasession._nLanguage,"UpdateTime")%></td>
        </tr>
    <%
ApplyTable at;
enumeration=ApplyTable.findByMember(teasession._rv._strR,community);
//if(!enumeration.hasMoreElements()){
%>

<%//}
boolean show_hid = false;
while(enumeration.hasMoreElements())
{
  show_hid = true;
  apply_count--;
  nodecode=((Integer)enumeration.nextElement()).intValue();
  at=ApplyTable.find(nodecode);
%>
<tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
  <td><%=at.getName()%></td>
  <td align="center"><a href='/servlet/EditApplyTable?act=down&applytable=<%=nodecode%>&name=<%=at.getName()%>'><img SRC="/tea/image/public/download.gif" width="18" height="17" border="0" /></a></td>
  <td align="center"><a href='EditApplyTable.jsp?applytable=<%=nodecode%>'><img SRC="/tea/image/public/update.gif" width="16" height="17" border="0" /></a></td>
  <td align="center"><A href="###" onclick="if(confirm('<%=r.getString(teasession._nLanguage,"ConfirmDelete")%>'))window.open('/servlet/EditApplyTable?act=delete&applytable=<%=nodecode%>','_self');" ><img SRC="/tea/image/public/delete.gif" border="0" /></a></td>
  <td align="center"><%=(new java.io.File(application.getRealPath(at.getFile())).length())%>B</td>
  <td align="center"><%=at.getTimeToString()%></td>
</tr>
        <%
      }
if(!show_hid){
  //      if(apply_count>0)
  //      {

    out.print("<tr><td colspan=6><input type=button value="+r.getString(teasession._nLanguage,"创建简历文件")+" onClick='javascript:window.location=\"/jsp/type/resume/EditApplyTable.jsp?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8")+"\";'></td></tr>");
    //      }
  }
      %>
      </table>
<br>
<div id="head6"><img height="6" src="about:blank"></div>
<%--
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr><td>注:</td></tr>
<tr><td>1.不完整的简历,不能用来申请职位.</td></tr>
<tr><td>2.您可以下载并上传固定格式的职位申请表，此申请表将做为简历的附件，在申请职位时使用</td></tr>
</table>
--%>
</body>
</HTML>

