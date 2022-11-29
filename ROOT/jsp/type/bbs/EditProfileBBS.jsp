<%@page contentType="text/html;charset=utf-8" %>
<%@include file="/jsp/Header.jsp"%>
<%
ProfileBBS pb =ProfileBBS.find(teasession._strCommunity ,teasession._rv._strV);
r.add("/tea/resource/BBS");
String title=pb.getTitle(teasession._nLanguage);
tea.entity.site.Community community = tea.entity.site.Community.find(teasession._strCommunity);
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type="text/javascript">
</SCRIPT>
<script type="text/javascript">
function change(obj)
{
  foSignUp.preview.src=''+this.options[this.selectedIndex].value
}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
</head>
<body>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="<%=community.getJspBeforePath(teasession._nLanguage)%>" type="text/javascript"></SCRIPT>
<h1><%=r.getString(teasession._nLanguage, "用户资料")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<FORM action="/servlet/EditProfileBBS?node=<%=teasession._nNode%>" METHOD=POST enctype="multipart/form-data" name=foSignUp>
  <table cellspacing="0" cellpadding="0" border="0" id="tablecenter">
    <tr>
      <td><%=r.getString(teasession._nLanguage,"Title")%></td>
      <td><input type="text" class="edit_input" name="title" value="<%if(title!=null)out.print(title);%>" maxlength="10"></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage,"Portrait")%></td>
      <td> <select name="portraitpath" onChange="foSignUp.preview.src=this.options[this.selectedIndex].value">
          <%
                String def=pb.getPortrait(teasession._nLanguage);
                if(def!=null&&def.length()>0)
                {
                  out.println("<option value="+def+" selected>"+r.getString(teasession._nLanguage,"CurrentlyPortrait")+"</option>");
                }

java.io.File files[]=new java.io.File(application.getRealPath("/res/"+node.getCommunity()+"/bbsphoto/")).listFiles();
if(files!=null)
for(int index=0;index<files.length;index++)
{
  if(!files[index].isHidden())
  {
    %>
    <option value="<%="/res/"+node.getCommunity()+"/bbsphoto/"+files[index].getName()%>" ><%=files[index].getName()%></option>
    <%
    }
}
%>
        </select> </td>
      <td rowspan="2"> <img src="<%//if(MemberId!=null)out.print("/servlet/PhotoPicture?member="+MemberId);else out.print(def);%>" name="preview" alt="" > </td>
    </tr>
    <tr>
      <td></td>
      <td><input type="file" class="edit_input" name="portrait" value="<%=pb.getTitle(teasession._nLanguage)%>" onchange="foSignUp.preview.src=foSignUp.portrait.value;" ></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage,"Signature")%> </td>
      <td colspan="2"> <textarea name="signature"  rows="4" cols="70" class="edit_input"><%=HtmlElement.htmlToText(pb.getSignature(teasession._nLanguage))%></textarea> </td>
    </tr>
  </table>
  <input type="submit" value="<%=r.getString(teasession._nLanguage,"Submit")%>"/>
</form>
<script type="text/javascript">
foSignUp.title.focus();
foSignUp.preview.src=foSignUp.portraitpath.options[foSignUp.portraitpath.selectedIndex].value
</script>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
 <SCRIPT LANGUAGE=JAVASCRIPT SRC="<%=community.getJspAfterPath(teasession._nLanguage)%>" type="text/javascript"></SCRIPT>
</body>
</html>

