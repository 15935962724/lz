<%@page contentType="text/html;charset=UTF-8" %>
<%
String culturetitle=c.getCultureTitle(lang);
String culturepicture=c.getCulturePicture(lang);
String culturecontent=c.getCultureContent(lang);

%>
<!--&&submitText(this.culturecontent,'<%=r.getString(teasession._nLanguage, "无效-正文")%>')-->
<form name="form1" action="/servlet/EditCompanyWindows" method="post" enctype="multipart/form-data" onsubmit="return submitText(this.culturetitle,'<%=r.getString(teasession._nLanguage, "fj12hq4w")+"-"+r.getString(teasession._nLanguage, "culturetitle")%>')">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>">
<input type="hidden" name="nexturl" value="<%=nu%>">
<input type="hidden" name="act" value="3">


  <div id="edit_page2">
    <div id="edit_page2_wai_left">
      <div id="edit_page2_left">
        <table>
          <tr><td><span><a href="javascript:f_open('?url=EditCompany0')"><%=r.getString(lang,"fj12hq4s")%></a></span></td></tr>
          <tr><td><span><a href="javascript:f_open('?url=EditCompany1')"><%=r.getString(lang,"fj12hq4t")%></a></span></td></tr>
          <tr><td><span><a href="javascript:f_open('?url=EditCompany2')"><%=r.getString(lang,"fj12hq4u")%></a></span></td></tr>
          <tr><td id="li_te"><span><%=r.getString(lang,"fj12hq4v")%></span></td></tr>
        </table>
      </div>
    </div>
    <div id="edit_page2_wai_right">
      <div id="edit_page2_right"><span><%=r.getString(lang,"fj12hq4v")%></span>
    </div>

    <div id="page2_w_r_e_p_style"></div>

<table cellspacing="0" cellpadding="0" id="page2_w_r_e_Culture">
  <tr>
    <td width="36"><%=r.getString(lang,"fj12hq46")%></td>
    <td><input name="culturetitle" type="text" id="text5" value="<%if(culturetitle!=null)out.print(culturetitle.replaceAll("\"","&quot;"));%>"></td>
  </tr>
  <!--图片-->
  <tr>
    <td width="36"><%=r.getString(lang,"fj12hq4c")%></td>
    <td>
      <input name="culturepicture" type="file" id="text5">
      <%
      if(culturepicture!=null)
      {
        File f=new File(application.getRealPath(culturepicture));
        int len=(int)f.length();
        if(len>0)
        {
          out.print("<a href="+culturepicture+" target=_blank>"+len+r.getString(lang,"Bytes")+"</a><input name=clear type=checkbox onclick=form1.culturepicture.disabled=checked>"+r.getString(lang,"Clear"));
        }
      }
      %>
    </td>
  </tr>
  <!--正文-->
  <tr>
    <td width="36" valign="top"><%=r.getString(lang,"fj12hq4d")%></td>
    <td>
      <textarea name="culturecontent" style="display:none" cols="" rows="" id="textarea"><%if(culturecontent!=null)out.print(culturecontent.replaceAll("</","&lt;/"));%></textarea>
      <iframe id="editor" src="/jsp/include/FCKeditor/editor/fckeditor.html?InstanceName=culturecontent&Toolbar=Home" width="400" height="300" frameborder="no" scrolling="no"></iframe>
    </td>
  </tr>
  <tr>
    <td width="36"></td>
    <td align="center"><input type="submit" id="submit_img" value="<%=r.getString(lang,"fj14p1y4")%>" /></td>
  </tr>
</table>


</div>
  </div>
  <div id="edit_page2_bottom"></div>

</form>
