<%@page contentType="text/html;charset=UTF-8" %>
<%

String subject="";
String alurl="http://",allogo=null;
if(n.getType()!=78)
{
  node=father78;
}else
{
  subject=n.getSubject(lang);

  AmityLink al=AmityLink.find(node,lang);
  alurl=al.getUrl();
  allogo=al.getLogo();
}

%>
<form name="form1" action="/servlet/EditCompanyWindows" method="post" enctype="multipart/form-data" onsubmit="return submitText(this.subject,'<%=r.getString(teasession._nLanguage, "InvalidSubject")%>')">
<input type="hidden" name="node" value="<%=node%>">
<input type="hidden" name="nexturl" value="<%=nu%>">
<input type="hidden" name="act" value="node">


  <div id="edit_page2">
    <div id="edit_page2_wai_left">
      <div id="edit_page2_left">

<table>
  <tr>
    <td><span><a href="javascript:f_open('?url=AmityLinks')">合作伙伴列表</a></span> </td>
  </tr>
  <tr>
    <td id="li_te"><span>添加合作伙伴</span> </td>
  </tr>
</table>

	  </div>
  </div>
		<div id="edit_page2_wai_right">
		  <div id="edit_page2_right"><span>添加合作伙伴</span>
		  </div>


<div id="page2_w_r_e_p_style"></div>
<table cellspacing="0" cellpadding="0" id="page2_w_r_e_Cooperation">
  <tr>
    <td width="27">名称</td>
    <td><input name="subject" type="text" id="text3" value="<%=subject%>"></td>
  </tr>
  <tr>
    <td width="27">网址</td>
    <td><input name="url" type="text" id="text3" value="<%if(alurl!=null)out.print(alurl);%>"></td>
  </tr>
  <tr>
    <td width="27">图片</td>
    <td><input name="logo" type="file" id="text3" value="<%if(allogo!=null)out.print(allogo);%>"> 100x40px</td>
  </tr>
  <tr>
    <td colspan="2" align="center"><input type="submit" id="submit_img" value="<%=r.getString(lang,"fj14p1y4")%>" /></td>
  </tr>
</table>
<div id="page2_w_r_e_P_t_page"></div>

  </div>
  <div id="edit_page2_bottom"></div>

</form>
<script>
form1.subject.focus();
</script>
