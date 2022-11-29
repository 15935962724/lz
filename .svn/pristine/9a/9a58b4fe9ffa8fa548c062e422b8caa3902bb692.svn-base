<%@page contentType="text/html;charset=UTF-8" %>
<%
int companydetail=-1;
tmp=request.getParameter("companydetail");
if(tmp!=null)
{
  companydetail=Integer.parseInt(tmp);
}
String name="",address="",zip="",telephone="",fax="",contact="",webpage="",email="",map="";
if(companydetail==-1)
{
  name=h.getSubject(lang);
  address=c.getAddress(lang);
  zip=c.getZip(lang);
  telephone=c.getTelephone(lang);
  fax=c.getFax(lang);
  contact=c.getContact(lang);
  webpage=c.getWebPage(lang);
  email=c.getEmail(lang);
  map=c.getMap(lang);
}else if(companydetail>0)
{
  CompanyDetail cd=CompanyDetail.find(companydetail);
  name=cd.getName(lang);
  address=cd.getAddress(lang);
  zip=cd.getZip(lang);
  telephone=cd.getTelephone(lang);
  fax=cd.getFax(lang);
  contact=cd.getContact(lang);
  webpage=cd.getWebPage(lang);
  email=cd.getEmail(lang);
  map=cd.getMap(lang);
}
%>
<div id="page2">
  <div id="page2_wai_left">
    <div id="page2_left">

<div id="page2_left_top"><%=wbs[4].getName(lang)%></div>
<ul>
<%
out.print("<li><a href=?community="+como+"&url=ViewCompany4&companydetail=-1");
if(companydetail==-1)
{
  out.print(" style=color:#0C419A");
}
out.print(">"+h.getSubject(lang)+"</a>");
//
Enumeration e21=CompanyDetail.findByNode(root);
while(e21.hasMoreElements())
{
  int cdid=((Integer)e21.nextElement()).intValue();
  CompanyDetail cd=CompanyDetail.find(cdid);
  out.print("<li><a href=?community="+como+"&url=ViewCompany4&companydetail="+cdid);
  if(companydetail==cdid)
  {
    out.print(" style=color:#0C419A");
  }
  out.print(">"+cd.getName(lang)+"</a></li>");
}
%>
</ul>
</div>
</div>

<div id="page2_wai_right">
  <div id="page2_right">
    <div id="page2_right_top"><font><a href="?community=<%=como%>"><%=r.getString(lang,"fj0vgqw1")%></a> > <%=wbs[4].getName(lang)%> > <%=name%></font></div>
  </div>
  <div id="page2_right_bottom">
    <div id="page2_r_b_title"><font><%=name%></font></div>
  </div>



<table cellspacing="0" cellpadding="0" id="page2_w_r_e_Contact">
  <tr>
    <td width="74"><%=r.getString(lang,"fj14p1xv")%></td>
    <td id="tdleft"><%=name%></td>
  </tr>
  <tr>
    <td width="74"><%=r.getString(lang,"fj14p1xw")%></td>
    <td id="tdleft"><%if(address!=null)out.print(address);%></td>
  </tr>
  <tr>
    <td width="74"><%=r.getString(lang,"fj14p1xx")%></td>
    <td id="tdleft"><%if(zip!=null)out.print(zip);%></td>
  </tr>
  <tr>
    <td width="74"><%=r.getString(lang,"fj14p1xy")%></td>
    <td id="tdleft"><%if(telephone!=null)out.print(telephone);%></td>
  </tr>
  <tr>
    <td width="74"><%=r.getString(lang,"fj14p1xz")%></td>
    <td id="tdleft"><%if(fax!=null)out.print(fax);%></td>
  </tr>
  <tr>
    <td width="74"><%=r.getString(lang,"fj14p1y0")%></td>
    <td id="tdleft"><%if(contact!=null)out.print(contact);%></td>
  </tr>
  <tr>
    <td width="74"><%=r.getString(lang,"fj14p1y1")%></td>
    <td id="tdleft"><%if(webpage!=null)out.print("<a href="+webpage+" target=_blank>"+webpage+"</a>");%></td>
  </tr>
  <tr>
    <td width="74">E-mail</td>
    <td id="tdleft"><%if(email!=null)out.print("<a href=mailto:"+email+">"+email+"</a>");%></td>
  </tr>
  <tr>
    <td width="74"><%=r.getString(lang,"fj14p1y5")%></td>
    <td id="tdleft"><%if(map!=null&&map.length()>0)out.print("<img src="+map+">");%></td>
  </tr>
</table>



</div>
  </div>
  <div id="page2_bottom"></div>


