<%@page contentType="text/html;charset=UTF-8" %>
<%

String qualification[] = c.getQualification();
%>
<form name="form1" action="/servlet/EditCompanyWindows" method="post" enctype="multipart/form-data">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>">
<input type="hidden" name="nexturl" value="<%=nu%>">
<input type="hidden" name="act" value="2">


  <div id="edit_page2">
    <div id="edit_page2_wai_left">
      <div id="edit_page2_left">
        <table>
          <tr><td><span><a href="javascript:f_open('?url=EditCompany0')"><%=r.getString(lang,"fj12hq4s")%></a></span></td></tr>
          <tr><td><span><a href="javascript:f_open('?url=EditCompany1')"><%=r.getString(lang,"fj12hq4t")%></a></span></td></tr>
          <tr><td id="li_te"><span><%=r.getString(lang,"fj12hq4u")%></span></td></tr>
          <tr><td><span><a href="javascript:f_open('?url=EditCompany3')"><%=r.getString(lang,"fj12hq4v")%></a></span></td></tr>
        </table>
      </div>
    </div>
    <div id="edit_page2_wai_right">
      <div id="edit_page2_right"><span><%=r.getString(lang,"fj12hq4u")%></span>
    </div>

    <div id="page2_w_r_e_p_style"></div>

    <table cellspacing="0" cellpadding="0" id="page2_w_r_e_Overview">
    <%
    for(int i=0;i<qualification.length;i++)
    {
      out.print("<tr><td align=center><input name=qualification"+i+" type=file id=text2>");
      if(qualification[i]!=null)
      {
        File f=new File(application.getRealPath(qualification[i]));
        int len=(int)f.length();
        if(len>0)
        {
          out.print("<a href="+qualification[i]+" target=_blank>"+len+r.getString(lang,"Bytes")+"</a><input name=clear"+i+" type=checkbox onclick=form1.qualification"+i+".disabled=checked>"+r.getString(lang,"Clear"));
        }
      }
    }
    %>
      <tr>
        <td align="center"><input type="submit" id="submit_img" value="<%=r.getString(lang,"fj14p1y4")%>" /></td>
      </tr>
    </table>

</div>
  </div>
  <div id="edit_page2_bottom"></div>

</form>
