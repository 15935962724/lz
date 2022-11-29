<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>

<%/*
if(!tea.entity.util.Safety.find(teasession._rv.toString(),5).isExists()&&!teasession._rv.toString().equalsIgnoreCase("admin")&&!License.getInstance().getWebMaster().equals(teasession._rv.toString()))
{
    response.sendError(403);
    return;
}*/

String community = request.getParameter("community");

String nexturl=request.getParameter("nexturl");
if(nexturl!=null)
nexturl="&nexturl="+nexturl;
else
nexturl="";

if("POST".equals(request.getMethod()))
{
    String member=request.getParameter("member").trim().toLowerCase();
    String password=request.getParameter("txtComfirmPwd");
    boolean _bNew=request.getParameter("new")!=null;
    if(_bNew)
    {
      if(Profile.isExisted(member))
      {
        response.sendRedirect("/jsp/info/Alert.jsp?info="+java.net.URLEncoder.encode(member+r.getString(teasession._nLanguage, "MemberExist"),"UTF-8"));
        return;
      }
      Profile.create(member,community,password);
    }
    String firstname=request.getParameter("firstname");
    String lastname=request.getParameter("lastname");
    String email=request.getParameter("email");
    String telephone=request.getParameter("telephone");
    String job=request.getParameter("job");

    Profile p=Profile.find(member);
    p.setFirstName(firstname,teasession._nLanguage);
    p.setLastName(lastname,teasession._nLanguage);
    p.setEmail(email);
    p.setTelephone(telephone,teasession._nLanguage);
    p.setJob(job,teasession._nLanguage);

    for(int index=0;index<9;index++)
    {
      Safety safety=Safety.find(member,community,index+1);
      if(request.getParameter("chkRight"+(index+1))!=null||"admin".equals(member))
      {
        if(!safety.isExists())
        {
          Safety.create(member,community,index+1);
        }
      }else
      {
        safety.delete();
      }
    }

    response.sendRedirect("/jsp/netdisk/NetDiskSubscribers.jsp?community="+community);
    return;
}
String member=request.getParameter("member");
boolean _bNew=member==null;

String firstname=null,lastname=null,email=null,telephone=null,job=null,password=null;
boolean bool[]=new boolean[9];
if(!_bNew)
{
  for(int index=0;index<bool.length;index++)
  {
    bool[index]=Safety.find(member,community,index+1).isExists();
  }
  Profile p=Profile.find(member);
  firstname=p.getFirstName(teasession._nLanguage);
  lastname=p.getLastName(teasession._nLanguage);
  email=p.getEmail();
  telephone=p.getTelephone(teasession._nLanguage);
  job=p.getJob(teasession._nLanguage);
  password=p.getPassword();
}else
{
  for(int index=0;index<bool.length;index++)
  {
    bool[index]=false;
  }
}


r.add("/tea/resource/NetDisk");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  <link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>
<BODY>
<h1><%=r.getString(teasession._nLanguage, "NewUser")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>


        <FORM NAME="frmInsertUser" METHOD="post" onSubmit="return(submitMemberid(this.member,'<%=r.getString(teasession._nLanguage, "InvalidMemberId")%>')&&
          submitIdentifier(this.txtPassWord,'<%=r.getString(teasession._nLanguage, "InvalidPassword")%>')&&
          submitEqual(this.txtPassWord,this.txtComfirmPwd,'<%=r.getString(teasession._nLanguage, "InvalidConfirmPassword")%>')&&
          submitText(this.firstname,'<%=r.getString(teasession._nLanguage, "InvalidName")%>')&&
          submitEmail(this.email,'<%=r.getString(teasession._nLanguage, "InvalidEmailAddress")%>'));">
          <input type="hidden" name="community" value="<%=community%>"/>
        <%
        if(_bNew)
        {
            out.print("<input type=hidden name=new value=on />");
        }
        %>
      <TABLE border="0" cellpadding="0" cellspacing="0" id="tablecenter">
          <TR>
            <TD align="right"><SPAN >*</SPAN> <%=r.getString(teasession._nLanguage, "FirstName")%></TD>
            <TD> <INPUT TYPE="text" NAME="firstname" MAXLENGTH="50" VALUE="<%if(firstname!=null)out.print(firstname);%>"></TD>
              <td ALIGN="RIGHT"><%=r.getString(teasession._nLanguage, "LastName")%></td>
              <td><INPUT TYPE="text"  NAME="lastname" MAXLENGTH="50" VALUE="<%if(lastname!=null)out.print(lastname);%>">
              </td>
         <%--   <TD ALIGN="RIGHT"><SPAN >* </SPAN>所在机构&nbsp;</TD>
            <TD> <SELECT NAME="selOrg" STYLE="width:172px">
<%
java.util.Enumeration enumeration=tea.entity.node.Node.findByType(21,community);
int nodeCode;
while(enumeration.hasMoreElements())
{
   nodeCode =((Integer)enumeration.nextElement()).intValue();
   String strTempSubject=tea.entity.node.Node.find(nodeCode).getSubject(1);
%>
<OPTION VALUE="<%=nodeCode%>"<%=getSelect(strTempSubject.equals(profile.getOrganization(1)))%>><%=strTempSubject%></OPTION>
<%}%>
</SELECT>
        </TD>
          </TR>--%>
          <TR>
            <TD ALIGN="RIGHT"><SPAN >*</SPAN> E-mail&nbsp;</TD>
            <TD><INPUT TYPE="text"  NAME="email" MAXLENGTH="120" VALUE="<%if(email!=null)out.print(email);%>"></TD>
            <TD ALIGN="RIGHT"><%=r.getString(teasession._nLanguage, "Telephone")%>&nbsp;</TD>
            <TD><INPUT TYPE="text" NAME="telephone" MAXLENGTH="40" VALUE="<%if(telephone!=null)out.print(telephone);%>"></TD>
          </TR>
          <TR>
            <TD ALIGN="RIGHT"><%=r.getString(teasession._nLanguage, "Job")%>&nbsp;</TD>
            <TD> <INPUT TYPE="text" NAME="job" MAXLENGTH="60" VALUE="<%if(job!=null)out.print(job);%>"></TD>
            <TD ALIGN="RIGHT">&nbsp;</TD>
            <TD>&nbsp;</TD>
          </TR>
          <TR>
            <TD COLSPAN="4"> <HR SIZE="1"> </TD>
          </TR>
          <TR>
            <TD ALIGN="RIGHT"><%=r.getString(teasession._nLanguage, "Purview")%></TD>
            <TD COLSPAN="3">
              <INPUT  id="CHECKBOX" type="CHECKBOX" NAME="chkRight1" VALUE="1" <%=getCheck(bool[1-1])%>><%=r.getString(teasession._nLanguage, "Download")%>
                <INPUT  id="CHECKBOX" type="CHECKBOX" NAME="chkRight2" VALUE="2" <%=getCheck(bool[2-1])%>><%=r.getString(teasession._nLanguage, "New")%>
                  <INPUT  id="CHECKBOX" type="CHECKBOX" NAME="chkRight3" VALUE="3" <%=getCheck(bool[3-1])%>><%=r.getString(teasession._nLanguage, "Delete")%>
<%--                    <INPUT  id="CHECKBOX" type="CHECKBOX" NAME="chkRight4" VALUE="4" <%=getCheck(bool[4-1])%>>报名表审核
                      <INPUT  id="CHECKBOX" type="CHECKBOX" NAME="chkRight5" VALUE="5" <%=getCheck(bool[5-1])%>>用户管理
                        <INPUT  id="CHECKBOX" type="CHECKBOX" NAME="chkRight6" VALUE="6" <%=getCheck(bool[6-1])%>>报名表管理
                          <INPUT  id="CHECKBOX" type="CHECKBOX" NAME="chkRight7" VALUE="7" <%=getCheck(bool[7-1])%>>议题管理
                            <INPUT  id="CHECKBOX" type="CHECKBOX" NAME="chkRight8" VALUE="8" <%=getCheck(bool[8-1])%>>上传文件管理
                              <INPUT  id="CHECKBOX" type="CHECKBOX" NAME="chkRight9" VALUE="9" <%=getCheck(bool[9-1])%>>对外文件管理--%>
            </TD>
          </TR>
          <TR>
            <TD COLSPAN="4"> <HR SIZE="1"> </TD>
          </TR>
          <TR>
            <TD ALIGN="RIGHT"><SPAN >*</SPAN> <%=r.getString(teasession._nLanguage, "MemberId")%>&nbsp;</TD>
            <TD COLSPAN="3">
               <%
               if(member!=null&&member.length()>1)
               {
                 out.print("<input type=hidden name=member value=\""+member+"\"><input disabled value=\""+member+"\">");
               }else
               {
                 out.print("<input type=text name=member MAXLENGTH=20 >");
               }%>
              <SPAN CLASS="note"><%=r.getString(teasession._nLanguage, "MemberIdNote")%></SPAN> </TD>
          </TR>
          <TR>
            <TD ALIGN="RIGHT"><SPAN >*</SPAN> <%=r.getString(teasession._nLanguage, "Password")%>&nbsp;</TD>
            <TD COLSPAN="3"> <INPUT  TYPE="password" NAME="txtPassWord" MAXLENGTH="12" value="<%if(password!=null)out.print(password);%>" >
              <SPAN CLASS="note"><%=r.getString(teasession._nLanguage, "PasswordNote")%></SPAN> </TD>
          </TR>
          <TR>
            <TD ALIGN="RIGHT"><SPAN >*</SPAN> <%=r.getString(teasession._nLanguage, "ConfirmPassword")%>&nbsp;</TD>
            <TD> <INPUT  TYPE="password" NAME="txtComfirmPwd" MAXLENGTH="12" value="<%if(password!=null)out.print(password);%>"> </TD>
            <TD ALIGN="RIGHT">&nbsp;</TD>
            <TD>&nbsp;</TD>
          </TR>
          <TR>
            <TD COLSPAN="4" ALIGN="CENTER">
              <input type="submit" value="<%=r.getString(teasession._nLanguage, "Submit")%>">
              <input type="reset" value="<%=r.getString(teasession._nLanguage, "Reset")%>">
              <input onClick="window.history.back();" type="button" value="<%=r.getString(teasession._nLanguage, "CBBack")%>">
            </TD>
          </TR>
</TABLE>
</FORM>

<script>
document.all['firstname'].focus();
<%
if("admin".equals(member))
out.print("for(var counter=0;counter<frmInsertUser.elements.length;counter++)        if(frmInsertUser.elements[counter].type==\"checkbox\"){  frmInsertUser.elements[counter].checked=true;       frmInsertUser.elements[counter].disabled=true;     }");%>
</script>

<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</BODY>
</html>

