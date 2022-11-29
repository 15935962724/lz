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
<form name="form1" action="/servlet/EditCompanyWindows" method="post" enctype="multipart/form-data" onsubmit="return submitText(this.name,'<%=r.getString(teasession._nLanguage, "fj12hq4w")+"-"+r.getString(teasession._nLanguage, "fj14p1xv")%>')&&submitText(this.address,'<%=r.getString(teasession._nLanguage, "fj12hq4w")+"-"+r.getString(teasession._nLanguage, "fj14p1xw")%>')">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>">
<input type="hidden" name="nexturl" value="<%=nu%>">
<input type="hidden" name="companydetail" value="<%=companydetail%>">
<input type="hidden" name="act" value="4">


  <div id="edit_page2">
    <div id="edit_page2_wai_left">
      <div id="edit_page2_left">
        <table>
<%
if(companydetail==-1)
{
  out.print("<tr><td id=li_te><span>");
}else
{
  out.print("<tr><td><span><a href=javascript:f_open('?url=EditCompany4&companydetail=-1')>");
}
out.print(h.getSubject(lang)+"</a></span></td></tr>");
//
Enumeration e21=CompanyDetail.findByNode(root);
while(e21.hasMoreElements())
{
  int cdid=((Integer)e21.nextElement()).intValue();
  CompanyDetail cd=CompanyDetail.find(cdid);
  if(companydetail==cdid)
  {
    out.print("<tr><td id=li_te><span>");
  }else
  {
    out.print("<tr><td><span><a href=javascript:f_open('?url=EditCompany4&companydetail="+cdid+"')>");
  }
  out.print(cd.getName(lang)+"</a> <a href=\"javascript:f_open('/servlet/EditCompanyWindows?act=delcd&companydetail="+cdid+"','"+r.getString(lang,"ConfirmDelete")+"');\"><img src=/tea/image/eyp/images/page215.gif></a></span></td></tr>");
}
//
if(companydetail==0)
{
  out.print("<tr><td id=li_te><span>"+r.getString(lang,"fj14p1y3"));
}else
{
  out.print("<tr><td><span><a href=javascript:f_open('?url=EditCompany4&companydetail=0')>"+r.getString(lang,"fj14p1y3")+"</a></span></td></tr>");
}
%>
        </table>
      </div>
    </div>
    <div id="edit_page2_wai_right">
      <div id="edit_page2_right"><span><%=r.getString(lang,"fj0vgqwa")%></span>
    </div>

   <div id="page2_w_r_e_p_style"></div>

<table cellspacing="0" cellpadding="0" id="page2_w_r_e_Contact">
<!--公司名称-->
  <tr>
    <td width="74"><%=r.getString(lang,"fj14p1xv")%></td>
    <td><input name="name" type="text" id="text4" value="<%=name%>"></td>
  </tr>
  <!--地　址-->
  <tr>
    <td width="74"><%=r.getString(lang,"fj14p1xw")%></td>
    <td><input name="address" type="text" id="text4" value="<%if(address!=null)out.print(address);%>"></td>
  </tr>
  <!--邮　编-->
  <tr>
    <td width="74"><%=r.getString(lang,"fj14p1xx")%></td>
    <td><input name="zip" type="text" id="text4" value="<%if(zip!=null)out.print(zip);%>"></td>
  </tr>
  <!--电　话-->
  <tr>
    <td width="74"><%=r.getString(lang,"fj14p1xy")%></td>
    <td><input name="telephone" type="text" id="text4" value="<%if(telephone!=null)out.print(telephone);%>"></td>
  </tr>
  <!--传　真-->
  <tr>
    <td width="74"><%=r.getString(lang,"fj14p1xz")%></td>
    <td><input name="fax" type="text" id="text4" value="<%if(fax!=null)out.print(fax);%>"></td>
  </tr>
  <!--联系人-->
  <tr>
    <td width="74"><%=r.getString(lang,"fj14p1y0")%></td>
    <td><input name="contact" type="text" id="text4" value="<%if(contact!=null)out.print(contact);%>"></td>
  </tr>
  <!--网　址-->
  <tr>
    <td width="74"><%=r.getString(lang,"fj14p1y1")%></td>
    <td><input name="webpage" type="text" id="text4" value="<%if(webpage!=null)out.print(webpage);%>"></td>
  </tr>
  <tr>
    <td width="74">E-mail</td>
    <td><input name="email" type="text" id="text4" value="<%if(email!=null)out.print(email);%>"></td>
  </tr>
  <!--上传路线图-->
  <tr>
    <td width="74"><%=r.getString(lang,"fj14p1y2")%></td>
    <td>
      <input name="map" type="file" id="text4" value="<%=map%>">
      <%
      if(map!=null)
      {
        int len=(int)new File(application.getRealPath(map)).length();
        if(len>0)
        {
          out.print("<a href="+map+" target=_blank>"+len + r.getString(teasession._nLanguage, "Bytes")+"</a>");
          out.print("<input name=clear type=checkbox onClick=form1.map.disabled=checked;>"+r.getString(teasession._nLanguage, "Clear"));
        }
      }
      %>
    </td>
  </tr>
  <tr>
    <td width="74"></td>
    <td id="align_center"><input type="submit" id="submit_img" value="<%=r.getString(lang,"fj14p1y4")%>" /></td>
  </tr>
</table>



</div>
  </div>
  <div id="edit_page2_bottom"></div>

</form>

<script>form1.name.focus();</script>
