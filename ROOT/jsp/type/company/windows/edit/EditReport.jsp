<%@page contentType="text/html;charset=UTF-8" %>
<%

String subject="",picture="",content="";
boolean mostly=request.getParameter("mostly")!=null;
if(n.getType()!=39)
{
  node=father39;
}else
{
  subject=n.getSubject(lang);
  content=n.getText(lang);
  mostly=n.isMostly();

  Report rep=Report.find(node);
  picture=rep.getPicture(lang);
}

%>
<form name="form1" action="/servlet/EditReport" method="post" enctype="multipart/form-data" onsubmit="return submitText(this.subject,'<%=r.getString(teasession._nLanguage, "InvalidSubject")%>')">
<input type="hidden" name="node" value="<%=node%>">
<input type="hidden" name="nexturl" value="<%=nu%>">


  <div id="edit_page2">
    <div id="edit_page2_wai_left">
      <div id="edit_page2_left">

        <table>
          <tr><td><span><a href="javascript:f_open('?url=Reports')"><%=r.getString(lang,"fj0vgqwj")%></a></span></td></tr>
          <tr><td id="li_te"><span><%=r.getString(lang,"fj12hq49")%></span></td></tr>
        </table>

		</div>
		</div>
		<div id="edit_page2_wai_right">
		  <div id="edit_page2_right"><span><%=r.getString(lang,"fj12hq49")%></span>
		  </div>

		  <div id="page2_w_r_e_p_style"></div>

<table cellspacing="0" cellpadding="0" id="page2_w_r_e_Culture">
<!--标题-->
  <tr>
    <td width="36"><%=r.getString(lang,"fj12hq46")%></td>
    <td><input name="subject" type="text" id="text5" value="<%if(subject!=null)out.print(subject.replaceAll("\"","&quot;"));%>"></td>
  </tr>
  <tr>
    <td width="36"><%=r.getString(lang,"fj12hq4c")%></td>
    <td>
      <input name="picture" type="file" id="text5">
      <%
      if(picture!=null)
      {
        File f=new File(application.getRealPath(picture));
        int len=(int)f.length();
        if(len>0)
        {
          out.print("<a href="+picture+" target=_blank>"+len+r.getString(lang,"Bytes")+"</a><input name=clearpicture type=checkbox onclick=form1.picture.disabled=checked>"+r.getString(lang,"Clear"));
        }
      }
      %>
    </td>
  </tr>
  <!--正文-->
  <tr>
    <td width="36" valign="top"><%=r.getString(lang,"fj12hq4d")%></td>
    <td>
      <textarea style="display:none" name="content" cols="" rows="" id="textarea"><%if(content!=null)out.print(content.replaceAll("</","&lt;/"));%></textarea>
      <iframe id="editor" src="/jsp/include/FCKeditor/editor/fckeditor.html?InstanceName=content&Toolbar=Home" width="430" height="300" frameborder="no" scrolling="no"></iframe>
    </td>
  </tr>
  <!--选项-->
  <tr>
    <td width="36" valign="top"><%=r.getString(lang,"Options")%></td>
    <td><input name="mostly" type="checkbox" <%if(mostly)out.print("checked");%> value=""><%=r.getString(lang,"fj0vgqwl")%></td>
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
