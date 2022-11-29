<%@page contentType="text/html;charset=UTF-8" %>
<%

String content=h.getText(lang);

%>
<!-- return submitText(this.content,'<%=r.getString(teasession._nLanguage, "无效-公司简介")%>')-->
<form name="form1" action="/servlet/EditCompanyWindows" method="post" enctype="multipart/form-data" onsubmit="">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>">
<input type="hidden" name="nexturl" value="<%=nu%>">
<input type="hidden" name="act" value="1">


  <div id="edit_page2">
    <div id="edit_page2_wai_left">
      <div id="edit_page2_left">
        <table>
          <tr><td><span><a href="javascript:f_open('?url=EditCompany0')"><%=r.getString(lang,"fj12hq4s")%></a></span></td></tr>
          <tr><td id="li_te"><span><%=r.getString(lang,"fj12hq4t")%></span></td></tr>
          <tr><td><span><a href="javascript:f_open('?url=EditCompany2')"><%=r.getString(lang,"fj12hq4u")%></a></span></td></tr>
          <tr><td><span><a href="javascript:f_open('?url=EditCompany3')"><%=r.getString(lang,"fj12hq4v")%></a></span></td></tr>
        </table>
      </div>
    </div>
    <div id="edit_page2_wai_right">
      <div id="edit_page2_right"><span><%=r.getString(lang,"fj12hq4t")%></span>
    </div>

    <div id="page2_w_r_e_p_style"></div>

<table cellspacing="0" cellpadding="0" id="page2_w_r_e_Overview">
  <tr>
    <td width="55" valign="top"><%=r.getString(lang,"fj12hq4t")%></td>
    <td>
      <textarea style="display:none" name="content" class="edit_input"><%=content%></textarea>
      <iframe id="editor" src="/jsp/include/FCKeditor/editor/fckeditor.html?InstanceName=content&Toolbar=Home" width="400" height="300" frameborder="no" scrolling="no"></iframe>
    </td>
  </tr>
  <!--公司图片-->
  <tr>
    <td width="55"><%=r.getString(lang,"fj12hq4x")%></td>
    <td><input name="picture" type="file" id="text"></td>
  </tr>
  <tr>
    <td width="55"></td>
    <td><%=r.getString(lang,"fj12hq4y")%></td>
  </tr>
  <tr>
    <td width="55"></td>
    <td align="center"><input type="submit" id="submit_img" value="<%=r.getString(lang,"fj14p1y4")%>" /></td>
  </tr>
</table>


</div>
</div>
<div id="edit_page2_bottom"></div>

</form>
