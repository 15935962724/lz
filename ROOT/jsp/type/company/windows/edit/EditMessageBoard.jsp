<%@page contentType="text/html;charset=UTF-8" %>
<%

String subject="",text="";
if(n.getType()!=73)
{
  node=father73;
}else
{
  subject=n.getSubject(lang);
  text=n.getText(lang);
}

%>
<form name="form1" action="/servlet/EditMessageBoard" method="post" onsubmit="return submitText(this.subject,'<%=r.getString(teasession._nLanguage, "InvalidSubject")%>')">
<input type="hidden" name="node" value="<%=node%>">
<input type="hidden" name="nexturl" value="<%=nu%>">


  <div id="edit_page2">
    <div id="edit_page2_wai_left">
      <div id="edit_page2_left">

<table>
  <tr>
    <td><span><a href="javascript:f_open('?url=MessageBoards')"><%=r.getString(lang,"fj14p1xs")%></a></span> </td>
  </tr>
  <tr>
    <td id="li_te"><span><%=r.getString(lang,"fj14p1xt")%></span> </td>
  </tr>
</table>

      </div>
    </div>
    <div id="edit_page2_wai_right">
      <div id="edit_page2_right"><span><%=r.getString(lang,"fj14p1xt")%></span>
    </div>
    <div id="page2_w_r_e_p_style"></div>

<table cellspacing="0" cellpadding="0" id="page2_w_r_e_Notice">
<!--标题-->
  <tr>
    <td width="36"><%=r.getString(lang,"fj12hq46")%></td>
    <td><input name="subject" type="text" id="input001" value="<%=subject%>"></td>
  </tr>
  <!--正文-->
  <tr>
    <td width="36"><%=r.getString(lang,"fj12hq4d")%></td>
    <td>
      <textarea style="display:none" name="content" cols="" rows=""><%=text.replaceAll("</","&lt;/")%></textarea>
      <iframe id="editor" src="/jsp/include/FCKeditor/editor/fckeditor.html?InstanceName=content&Toolbar=Home" width="435" height="300" frameborder="no" scrolling="no"></iframe>
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
<script>
form1.subject.focus();
</script>
