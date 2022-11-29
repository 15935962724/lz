<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>
<%
if (!node.isCreator(teasession._rv) && !AccessMember.find(node._nNode, teasession._rv._strV).isProvider(28)&&((node.getOptions1()& 1) == 0))
{
    response.sendError(403);
    return;
}
r.add("/tea/resource/Expert");
Expert classified =  Expert.find(teasession._nNode,teasession._nLanguage);
String text =HtmlElement.htmlToText(node.getText(teasession._nLanguage));
%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
  <script src="/tea/Calendar.js" type="text/javascript"></script>
<script>
function ShowCalendar(fieldname)
{
  myleft=document.body.scrollLeft+event.clientX-event.offsetX-80;
  mytop=document.body.scrollTop+event.clientY-event.offsetY+140;
// window.open('/jsp/type/hostel/Calendar.jsp');
  window.showModalDialog("/jsp/include/Calendar.jsp?FIELDNAME="+fieldname,self,"edge:raised;scroll:0;status:0;help:0;resizable:1;dialogWidth:280px;dialogHeight:205px;dialogTop:"+mytop+"px;dialogLeft:"+myleft+"px");
}</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "Expert")%><%=r.getString(teasession._nLanguage, "Edit")%></h1>
  <div id="head6"><img height="6" src="about:blank"></div>

  <div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div>
  <FORM  action="/servlet/EditExpert" METHOD=POST enctype="multipart/form-data" name=form1 onSubmit="return submitText(this.Name, '<%=r.getString(teasession._nLanguage, "InvalidSubject")%>')&&submitInteger(this.graduate, '<%=r.getString(teasession._nLanguage, "Graduate")%>')">
  <%
  String subject=null;
  if(request.getParameter("NewNode")!=null)
  {
    subject="";
    out.println("<INPUT TYPE=hidden NAME=NewNode VALUE=ON>");
  }else
      subject=HtmlElement.htmlToText(node.getSubject(teasession._nLanguage));
  %>
    <input type='hidden' name=Node VALUE="<%=teasession._nNode%>">
   <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
      <tr id="jsp_type_expert_EditExpert_Name">
        <td><%=r.getString(teasession._nLanguage, "Name")%>:</td>
        <td><input type="TEXT" class="edit_input"  name="Name" size="40" MAXLENGTH="255" VALUE="<%=subject%>"></td>
      </tr>
      <tr>
        <td><%=r.getString(teasession._nLanguage, "Birthday")%>:</td>
        <td>
  
        <input id="birthday" name="birthday" size="7"  value="<%if(classified.getBirthday()!=null)out.print(tea.entity.Entity.sdf.format(classified.getBirthday()));%>"  style="cursor:pointer" readonly="readonly" onclick="new Calendar().show('form1.birthday');"> 
        <img style="margin-bottom:-8px;" style="cursor:pointer"  src="/tea/image/bbs_edit/table.gif"  style="cursor:pointer" onclick="new Calendar().show('form1.birthday');" />

          
          </td>
      </tr>
      <tr>
        <td><%=r.getString(teasession._nLanguage, "Sex")%>:</td>
        <td><input name="sex"  id="radio" type="radio" value="1" checked  >男
          <input name="sex"  id="radio" type="radio" value="0" <%if(!classified.isSex())out.print("checked");%>   >女</td>
      </tr>

      <tr id="jsp_type_expert_EditExpert_Intro">

    <td nowrap> </TD>
    <td nowrap><input  id="radio" type="radio" name=TextOrHtml value=0 checked="checked">
      <%=r.getString(teasession._nLanguage, "TEXT")%>
      <input  id="radio" type="radio" name=TextOrHtml value=1 <%if((node.getOptions() & 0x40) != 0)out.print(" CHECKED ");%> >HTML
      <input type="button" name="Pictureview" id="Pictureview" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "Pictureview")%>" onClick="window.open('/servlet/InsertPicture?node=<%=teasession._nNode%>', '_blank');">
      <input  id="CHECKBOX" type="checkbox" name="nonuse" value="checkbox" onclick="f_editor(this)"><label for="nonuse"><%=r.getString(teasession._nLanguage, "NonuseEditor")%></label>
        <input type="checkbox" name="srccopy"/>源网站的图片贴入本地
    </td>
  </tr>

  <tr id="Venues_text">
    <td nowrap><%=r.getString(teasession._nLanguage, "简介")%>:</TD>
    <td nowrap>
      <textarea style="display:none" name="content" rows="12" cols="90" class="edit_input"><%if(text!=null)out.print(text);%></textarea>
      <iframe id="editor" src="/jsp/include/FCKeditor/editor/fckeditor.html?InstanceName=content&Toolbar=<%=teasession._strCommunity%>" width="740" height="300" frameborder="no" scrolling="no"></iframe>
    </td>
  </tr>
      </tr>


      <tr id="jsp_type_expert_EditExpert_Contact">
        <td><%=r.getString(teasession._nLanguage, "Contact")%>:</td>
        <td><input type="TEXT" class="edit_input"  name=Contact VALUE="<%=getNull(classified.getContact())%>"></td>
      </tr>
      <tr>
        <td><%=r.getString(teasession._nLanguage, "EmailAddress")%>:</td>
        <td><input type="TEXT" class="edit_input"  name=Email VALUE="<%=getNull(classified.getEmail())%>"></td>
      </tr>
      <tr>
        <td><%=r.getString(teasession._nLanguage, "Organization")%>:</td>
        <td><input type="TEXT" class="edit_input"  name=Organization VALUE="<%=getNull(classified.getOrganization())%>" SIZE=40 ></td>
      </tr>
      <tr>
        <td><%=r.getString(teasession._nLanguage, "Address")%>:</td>
        <td><TEXTAREA name=Address  class="edit_input" ROWS=2 COLS=60><%=HtmlElement.htmlToText(getNull(classified.getAddress()))%></TEXTAREA></td>
      </tr>
      <tr id="jsp_type_expert_EditExpert_City">
        <td ><%=r.getString(teasession._nLanguage, "City")%>:</td>
        <td><input type="TEXT" class="edit_input"  name=City VALUE="<%=getNull(classified.getCity())%>" SIZE=20 MAXLENGTH=20></td>
      </tr>
      <tr id="jsp_type_expert_EditExpert_State">
        <td><%=r.getString(teasession._nLanguage, "State")%>:</td>
        <td><input type="TEXT" class="edit_input"  name=State VALUE="<%=getNull(classified.getState())%>" SIZE=20 MAXLENGTH=20></td>
      </tr>
      <tr>
        <td><%=r.getString(teasession._nLanguage, "Zip")%>:</td>
        <td><input type="TEXT" class="edit_input"  name=Zip VALUE="<%=getNull(classified.getZip())%>" SIZE=20 MAXLENGTH=20></td>
      </tr>
      <tr id="jsp_type_expert_EditExpert_Country">
        <td><%=r.getString(teasession._nLanguage, "Country")%>:</td>
        <td><input type="TEXT" class="edit_input"  name=Country VALUE="<%=getNull(classified.getCountry())%>" SIZE=20 MAXLENGTH=20></td>
      </tr>
      <tr>
        <td><%=r.getString(teasession._nLanguage, "office")+r.getString(teasession._nLanguage, "Telephone")%>:</td>
        <td><input type="TEXT" class="edit_input"  name=Telephone VALUE="<%=getNull(classified.getTelephone())%>" SIZE=30 MAXLENGTH=50></td>
      </tr>
      <tr>
        <td><%=r.getString(teasession._nLanguage, "Fax")%>:</td>
        <td><input type="TEXT" class="edit_input"  name=Fax VALUE="<%=getNull(classified.getFax())%>" SIZE=30 MAXLENGTH=50></td>
      </tr>
      <tr id="jsp_type_expert_EditExpert_WebPage">
        <td><%=r.getString(teasession._nLanguage, "WebPage")%>:</td>
        <td><input type="TEXT" class="edit_input"  name=WebPage VALUE="<%=getNull(classified.getWebPage())%>" SIZE=60 MAXLENGTH=255></td>
      </tr>
      <tr id="jsp_type_expert_EditExpert_Stature">
        <td><%=r.getString(teasession._nLanguage, "Stature")%>:</td>
        <td><input  class="edit_input" name=WebLanguage value="<%=classified.getWebLanguage()%>">
        </td>
      </tr>
            <tr id="jsp_type_expert_EditExpert_Place">
        <td><%=r.getString(teasession._nLanguage, "Place")%>:</td>
        <td><input  class="edit_input" name="place"  value="<%=getNull(classified.getPlace())%>">
        </td>
      </tr>
      <tr id="jsp_type_expert_EditExpert_LanguageClass">
        <td><%=r.getString(teasession._nLanguage, "LanguageClass")%>:</td>
        <td><input  class="edit_input" name="languageclass"  value="<%=getNull(classified.getLanguageClass())%>">
        </td>
      </tr>
      <tr id="jsp_type_expert_EditExpert_Photo">
        <td><%=r.getString(teasession._nLanguage, "Photo")%></td>
        <td><input type="file"  class="edit_input"  onDblClick="window.open('<%=getNull(classified.getPhoto())%>');" name="photo">
          <%
long len=new java.io.File(application.getRealPath( getNull(classified.getPhoto()))).length();
if(len>0)
out.print(len);
              %>
          <input  id="CHECKBOX" type="CHECKBOX" name="clear" value="checkbox">
          <%=r.getString(teasession._nLanguage, "Clear")%></td>
      </tr>
      <tr id="jsp_type_expert_EditExpert_BigPhoto">
        <td><%=r.getString(teasession._nLanguage, "Photo")%>(<%=r.getString(teasession._nLanguage, "Big")%>)</td>
        <td><input type="file"  class="edit_input"  onDblClick="window.open('<%=getNull(classified.getPhotoBig())%>');"  name="photobig">
          <%
 len=new java.io.File(application.getRealPath( getNull(classified.getPhotoBig()))).length();
if(len>0)
out.print(len);
              %>
          <input  id="CHECKBOX" type="CHECKBOX" name="clearphotobig" value="checkbox">
          <%=r.getString(teasession._nLanguage, "Clear")%></td>
      </tr>
      <tr id="jsp_type_expert_EditExpert_Alias">
        <td><%=r.getString(teasession._nLanguage, "Alias")%></td>
        <td><input type="text"  class="edit_input" name="alias" value="<%=getNull(classified.getAlias())%>"></td>
      </tr>
      <tr id="jsp_type_expert_EditExpert_Matriculation">
        <td><%=r.getString(teasession._nLanguage, "Matriculation")%></td>
        <td>
          
            <input id="matriculation" name="matriculation" size="7"  value="<%if(classified.getMatriculation("yyyy-MM-dd")!=null)out.print(classified.getMatriculation("yyyy-MM-dd"));%>"  style="cursor:pointer" readonly="readonly" onclick="new Calendar().show('form1.matriculation');"> 
        <img style="margin-bottom:-8px;" style="cursor:pointer"  src="/tea/image/bbs_edit/table.gif"  style="cursor:pointer" onclick="new Calendar().show('form1.matriculation');" />
          
          </td>
      </tr>
      <tr id="jsp_type_expert_EditExpert_Folk"> 
        <td><%=r.getString(teasession._nLanguage, "Folk")%></td>
        <td><input type="text"  class="edit_input" name="folk" value="<%=getNull(classified.getFolk())%>"></td>
      </tr>
      <tr id="jsp_type_expert_EditExpert_Class">
        <td><%=r.getString(teasession._nLanguage, "Class")%></td>
        <td><input type="text"  class="edit_input" name="class" value="<%=getNull(classified.getClasses())%>"></td>
      </tr>
      <tr id="jsp_type_expert_EditExpert_Graduate">
        <td><%=r.getString(teasession._nLanguage, "Graduate")%></td>
        <td><input type="text"  class="edit_input" name="graduate" value="<%=classified.getGraduate()%>">
          届 </td>
      </tr>
      <tr id="jsp_type_expert_EditExpert_Aim">
        <td><%=r.getString(teasession._nLanguage, "Aim")%> </td>
        <td><input type="text"  class="edit_input" name="aim"  value="<%=getNull(classified.getAim())%>"></td>
      </tr>
      <tr>
        <td><%=r.getString(teasession._nLanguage, "Duty")%></td>
        <td><input type="text"  class="edit_input" name="duty" value="<%=getNull(classified.getDuty())%>"></td>
      </tr>
      <tr>
        <td><%=r.getString(teasession._nLanguage, "Technical")%></td>
        <td><input type="text"  class="edit_input" name="technical"  value="<%=getNull(classified.getTechnical())%>"></td>
      </tr>
      <tr>
        <td><%=r.getString(teasession._nLanguage, "HomePhone")%></td>
        <td><input type="text"  class="edit_input" name="homephone" value="<%=getNull(classified.getHomePhone())%>"></td>
      </tr>
      <tr>
        <td><%=r.getString(teasession._nLanguage, "Handset")%></td>
        <td><input type="text"  class="edit_input" name="handset" value="<%=getNull(classified.getHandset())%>"></td>
      </tr>
      <tr>
        <td>MSN</td>
        <td><input type="text"  class="edit_input" name="msn" value="<%=getNull(classified.getMSN())%>"></td>
      </tr>
      <tr>
        <td>QQ</td>
        <td><input type="text"  class="edit_input" name="qq" value="<%=getNull(classified.getQQ())%>"></td>
      </tr>
      <tr id="jsp_type_expert_EditExpert_LeaveWord">
        <td><%=r.getString(teasession._nLanguage, "LeaveWord")%></td>
        <td><textarea name="leaveword" rows="8" cols="70" class="edit_input"><%=getNull(classified.getLeaveWord())%></textarea></td>
      </tr>
      <tr id="jsp_type_expert_EditExpert_Rfield">
        <td><%=r.getString(teasession._nLanguage, "rfield")%></td>
        <td><textarea name="rfield" rows="8" cols="70" class="edit_input"><%=getNull(classified.getRfield())%></textarea></td>
      </tr>
      <tr id="jsp_type_expert_EditExpert_MRR">
        <td><%=r.getString(teasession._nLanguage, "mrr")%></td>
        <td><textarea name="mrr" rows="8" cols="70" class="edit_input"><%=getNull(classified.getMrr())%></textarea></td>
      </tr>
      <tr id="jsp_type_expert_EditExpert_MRRS">
        <td><%=r.getString(teasession._nLanguage, "mrrs")%></td>
        <td><textarea name="mrrs" rows="8" cols="70" class="edit_input"><%=getNull(classified.getMrrs())%></textarea></td>
      </tr>
      <tr id="jsp_type_expert_EditExpert_OCI">
        <td><%=r.getString(teasession._nLanguage, "oci")%></td>
        <td><textarea name="oci" rows="8" cols="70" class="edit_input"><%=getNull(classified.getOci())%></textarea></td>
      </tr>
    </table>
    <P ALIGN=CENTER>

      <input type=SUBMIT name="GoFinish" ID="edit_GoFinish" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "Finish")%>">&nbsp;
        <input type=SUBMIT name="GoBackSuper" id="edit_GoSuper" class="edit_button" value="<%=r.getString(teasession._nLanguage, "Super")%>">
    </P>
  </form>
  <div id="head6"><img height="6" src="about:blank"></div>
  <div id="language"><%=new Languages(teasession._nLanguage,request)%></div>

</body>
</html>

