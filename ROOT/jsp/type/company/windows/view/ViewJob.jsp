<%@page contentType="text/html;charset=UTF-8" %>
<%

String subject="",picture="",content="",validity="";
String requirements=null,locid=null,name=null,tel=null,email=null;
int headcount=0;
if(n.getType()!=50)
{
  node=father50;
}else
{
  subject=n.getSubject(lang);
  content=n.getText(lang);

  Job job=Job.find(node,lang);
  headcount=job.getHeadCount();
  requirements=job.getRequirements();
  locid=job.getLocId();
  name=job.getName();
  tel=job.getTel();
  email=job.getEmail();
  validity=job.getValidityDateToString();
}

int count=Node.count(" AND father="+father50+" AND type=50");
%>
<div id="page2">
  <div id="page2_wai_left">
    <div id="page2_left">

<div id="page2_left_top"><%=wbs[9].getName(lang)%></div>
<ul>
<%
Enumeration e50=Node.find(" AND father="+father50+" AND type=50 ORDER BY node DESC",pos,10);
if(!e50.hasMoreElements())
{
  out.print("<script>alert('"+r.getString(lang,"fj0vgqxa")+"');history.back();</script>");
  return;
}
for(int i=0;e50.hasMoreElements();i++)
{
  int n50=((Integer)e50.nextElement()).intValue();
  if(i==0&&n.getType()!=50)
  {
    out.print("<script>window.location.replace('?community="+como+"&url=ViewJob&node="+n50+"');</script>");
    return;
  }
  Node o50=Node.find(n50);
  out.print("<li><a href=?community="+como+"&url=ViewJob&node="+n50);
  if(n50==node)
  {
    out.print(" style=color:#0C419A");
  }
  out.print(">"+o50.getSubject(lang)+"</a></li>");
}
%>
</ul>
<%=new tea.htmlx.FPNL(lang,"?community="+como+"&url="+url+"&node="+node+"&pos=",pos,count,10)%>
</div>
</div>

<div id="page2_wai_right">
  <div id="page2_right">
    <div id="page2_right_top"><font><a href="?community=<%=como%>"><%=r.getString(lang,"fj0vgqw1")%></a> > <%=wbs[9].getName(lang)%> > <%=subject%></font></div>
  </div>
  <div id="page2_right_bottom">
    <div id="page2_r_b_title"><font><%=subject%></font><br><%=n.getTimeToString()%></div>
  </div>




<table cellspacing="0" cellpadding="0" id="page2_w_r_e_Posts">
  <tr>
    <td width="62" valign="top">职位描述</td>
    <td id="tdleft"><%=content%></td>
  </tr>
  <tr>
    <td width="62" valign="top">岗位要求</td>
    <td id="tdleft"><%if(requirements!=null)out.print(requirements);%></td>
  </tr>
  <tr>
    <td width="62">招聘人数</td>
    <td id="tdleft"><%if(headcount>0)out.print(headcount);%></td>
  </tr>
  <tr>
    <td width="62">工作所在地</td>
    <td id="tdleft"><%if(locid!=null)out.print(locid);%></td>
  </tr>
  <tr>
    <td width="62">有效期</td>
    <td id="tdleft"><%=n.getTimeToString()%> 至 <%=validity%>
    </td>
  </tr>
  <tr>
    <td width="62">联系人</td>
    <td id="tdleft"><%if(name!=null)out.print(name);%></td>
  </tr>
  <tr>
    <td width="62">联系电话</td>
    <td id="tdleft"><%if(tel!=null)out.print(tel);%></td>
  </tr>
  <tr>
    <td width="62">E-mail</td>
    <td id="tdleft"><a href="mailto:<%=email%>"><%if(email!=null)out.print(email);%></a></td>
  </tr>
</table>


</div>
  </div>
  <div id="page2_bottom"></div>

