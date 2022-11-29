<%@page contentType="text/html;charset=UTF-8" %>
<%

String subject="",picture="",content="";
Date time=null,validity=null;
String requirements=null,locid=null,name=null,tel=null,email=null;
int headcount=0;
if(n.getType()!=50)
{
  node=father50;
}else
{
  subject=n.getSubject(lang);
  content=n.getText(lang);
  time=n.getTime();

  Job job=Job.find(node,lang);
  headcount=job.getHeadCount();
  requirements=job.getRequirements();
  locid=job.getLocId();
  name=job.getName();
  tel=job.getTel();
  email=job.getEmail();
  validity=job.getValidityDate();
}

%>
<form name="form1" action="/servlet/EditJob" method="post" onsubmit="return submitText(this.subject,'<%=r.getString(teasession._nLanguage, "InvalidSubject")%>')">
<input type="hidden" name="node" value="<%=node%>">
<input type="hidden" name="nexturl" value="<%=nu%>">
<input type="hidden" name="company" value="<%=root%>">


  <div id="edit_page2">
    <div id="edit_page2_wai_left">
      <div id="edit_page2_left">

<table>
  <tr>
    <td><span><a href="javascript:f_open('?url=Jobs')"><%=r.getString(lang,"fj12hq4z")%></a></span> </td>
  </tr>
  <tr>
    <td id="li_te"><span><%=r.getString(lang,"fj12hq50")%></span> </td>
  </tr>
</table>

      </div>
    </div>
    <div id="edit_page2_wai_right">
      <div id="edit_page2_right"><span><%=r.getString(lang,"fj12hq50")%></span>
    </div>

    <div id="page2_w_r_e_p_style"></div>


<table cellspacing="0" cellpadding="0" id="page2_w_r_e_Posts">
<!--招聘职位-->
  <tr>
    <td width="62"><%=r.getString(lang,"fj12hq51")%></td>
    <td><input name="subject" type="text" id="text7" value="<%=subject%>"></td>
  </tr>
<!--职位描述-->
  <tr>
    <td width="62" valign="top"><%=r.getString(lang,"fj12hq52")%></td>
    <td>
      <textarea name="content" cols="" rows="" style="display:none"><%=content.replaceAll("</","&lt;/")%></textarea>
      <iframe id="editor" src="/jsp/include/FCKeditor/editor/fckeditor.html?InstanceName=content&Toolbar=Home" width="400" height="300" frameborder="no" scrolling="no"></iframe>
    </td>
  </tr>
  <!--岗位要求-->
  <tr>
    <td width="62" valign="top"><%=r.getString(lang,"fj12hq53")%></td>
    <td><textarea name="requirements" cols="" rows=""><%if(requirements!=null)out.print(requirements);%></textarea></td>
  </tr>
  <!--招聘人数-->
  <tr>
    <td width="62"><%=r.getString(lang,"fj12hq54")%></td>
    <td><input name="headcount" type="text" id="text7" value="<%if(headcount>0)out.print(headcount);%>"></td>
  </tr>
  <!--工作所在地-->
  <tr>
    <td width="62"><%=r.getString(lang,"fj12hq55")%></td>
    <td><input name="locid" type="text" id="text7" value="<%if(locid!=null)out.print(locid);%>"></td>
  </tr>
  <!--有效期-->
  <tr>
    <td width="62"><%=r.getString(lang,"fj12hq56")%></td>
    <td><%=new tea.htmlx.TimeSelection("time", time)%> 至 <%=new tea.htmlx.TimeSelection("validity", validity)%></td>
  </tr>
  <!--联系人-->
  <tr>
    <td width="62"><%=r.getString(lang,"fj12hq57")%></td>
    <td><input name="name" type="text" id="text7" value="<%if(name!=null)out.print(name);%>"></td>
  </tr>
  <!--联系电话-->
  <tr>
    <td width="62"><%=r.getString(lang,"fj14p1xr")%></td>
    <td><input name="tel" type="text" id="text7" value="<%if(tel!=null)out.print(tel);%>"></td>
  </tr>
  <tr>
    <td width="62">E-mail</td>
    <td><input name="email" type="text" id="text7" value="<%if(email!=null)out.print(email);%>"></td>
  </tr>
  <tr>
    <td width="62"></td>
    <td id="align_center"><input type="submit" id="submit_img" value="<%=r.getString(lang,"fj14p1y4")%>" /></td>
  </tr>
</table>


</div>
  </div>
  <div id="edit_page2_bottom"></div>

</form>
<script>
form1.subject.focus();
</script>
