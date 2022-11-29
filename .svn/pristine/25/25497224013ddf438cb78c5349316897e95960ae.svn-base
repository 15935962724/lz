<%@page contentType="text/html;charset=utf-8" %>
<%@ page import="tea.htmlx.Languages"%>
<%@ page import="tea.ui.TeaSession"%>
<%@ page import = "tea.entity.member.Profile" import = "tea.entity.member.Profile" %>
<jsp:useBean id="sms" scope="page" class="tea.entity.node.Sms" /><%
///webapps/ROOT/tea/image/section/bj-sea/photo
request.setCharacterEncoding("UTF-8");
TeaSession teasession = new TeaSession(request);
tea.resource.Resource r = new tea.resource.Resource("/tea/ui/util/SignUp1");


tea.entity.member.Profile profile=null;

if(request.getMethod().equals("POST"))
{



}

String vertify=sms.password();
session.setAttribute("sms.vertify" ,vertify);

tea.entity.node.Node node=tea.entity.node.Node.find(teasession._nNode);
String community=node.getCommunity();

String nexturl=request.getParameter("nexturl");

%>
<html>
<head>
<link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script type="text/javascript">
function submitCard(obj,text)
{
  var len=obj.value.length;
  if(len!=15&&len!=18)
  {
    alert(text);
    obj.focus();
    return false;
  }
  return true;
}

</script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
</head>
<%//=r.getString(teasession._nLanguage, "InfSignUp")%>
<body>
<h1><%=r.getString(teasession._nLanguage, "SeaRegister")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<FORM name=foSignUp METHOD=POST ACTION="/servlet/EditProfileBBS?node=<%=teasession._nNode%>" onSubmit="return(submitMemberid(this.MemberId,'<%=r.getString(teasession._nLanguage, "InvalidMemberId")%>')&&submitIdentifier(this.EnterPassword,'<%=r.getString(teasession._nLanguage, "InvalidPassword")%>')&&submitEqual(this.EnterPassword,this.ConfirmPassword,'<%=r.getString(teasession._nLanguage, "InvalidConfirmPassword")%>')&&submitEmail(this.Email,'<%=r.getString(teasession._nLanguage, "InvalidEmailAddress")%>')&&submitIdentifier(this.vertify,'<%=r.getString(teasession._nLanguage, "Validate")%>')&&submitLength(2,20,this.firstname,'<%=r.getString(teasession._nLanguage, "InvalidFirstName")%>-最少2位,全部是中文汉字.')&&submitCard(this.card,'<%=r.getString(teasession._nLanguage, "无效身份证号-长度应是15位或18位.")%>')&&submitLength(8,20,this.telephone,'<%=r.getString(teasession._nLanguage, "InvalidTelephone")%>-最少8位,全部是数字.'));">
<input type="hidden" name="community" value="<%=community%>"/>
<%
if(nexturl!=null)
{
  out.print("<input type='hidden' name='nexturl' value='"+nexturl+"' />");
}
%>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr onmouseover="javascript:this.bgColor='#BCD1E9';" onMouseOut="javascript:this.bgColor='';" >
      <TD>* <%=r.getString(teasession._nLanguage, "MemberId")%>:</TD>
      <td><input type="TEXT"  name=MemberId  size=20 maxlength=40></td><td>3-20位</td>
    </tr>
    <tr onmouseover="javascript:this.bgColor='#BCD1E9';" onMouseOut="javascript:this.bgColor='';" >
      <TD>* <%=r.getString(teasession._nLanguage, "EnterPassword")%>:</TD>
      <td><input type="password"  name=EnterPassword value="" size=20 maxlength=16></td><td>3-20位</td>
    </tr>
    <tr onmouseover="javascript:this.bgColor='#BCD1E9';" onMouseOut="javascript:this.bgColor='';" >
      <TD>* <%=r.getString(teasession._nLanguage, "ConfirmPassword")%>:</TD>
      <td><input type="password"  name=ConfirmPassword value="" size=20 maxlength=16></td>
           <TD>&nbsp;</TD>
    </tr>
    <tr onmouseover="javascript:this.bgColor='#BCD1E9';" onMouseOut="javascript:this.bgColor='';" >
      <TD>* <%=r.getString(teasession._nLanguage, "EmailAddress")%>:</TD>
      <td><input type="TEXT"  name=Email  size=40 maxlength=40></td>
            <TD>&nbsp;</TD>
    </tr>
    <tr onmouseover="javascript:this.bgColor='#BCD1E9';" onMouseOut="javascript:this.bgColor='';" >
      <TD><%=r.getString(teasession._nLanguage, "Gender")%>:</TD>
      <td><input id="gender_0" type="radio" name="sex" value="1" checked="checked"/>
        <label for="gender_0"><%=r.getString(teasession._nLanguage, "Man")%></label>
        <input id="gender_1" type="radio" name="sex" value="0" />
        <label for="gender_1"><%=r.getString(teasession._nLanguage, "Woman")%></label></td>
              <TD>&nbsp;</TD>
    </tr>
    <tr onmouseover="javascript:this.bgColor='#BCD1E9';" onMouseOut="javascript:this.bgColor='';" >
      <TD>* <%=r.getString(teasession._nLanguage, "Validate")%>:</TD>
      <td><input type="TEXT"  name=vertify value="" size=20 maxlength=20><%=r.getString(teasession._nLanguage, "VerificationCode")%>:<img src="validate.jsp" alt="Validate"></td>
      <TD>&nbsp;</TD>
    </tr>
    <tr onmouseover="javascript:this.bgColor='#BCD1E9';" onMouseOut="javascript:this.bgColor='';" >
      <TD>* 真实姓名</TD>
      <td><input  name=firstname type="TEXT" onblur="this.value=this.value.replace(/[^\u4E00-\u9FA5]/g,'');" onKeyPress="if(event.keyCode>0&&event.keyCode<255)event.returnValue=false;" size=20 maxlength=40></td>
      <TD>最少2位,全部是中文汉字.</TD>
    </tr>
    <tr onmouseover="javascript:this.bgColor='#BCD1E9';" onMouseOut="javascript:this.bgColor='';" >
      <TD>* 身份证号</TD>
      <td><input  name=card type="TEXT" onblur="this.value=this.value.replace(/[^0-9xX]/g,'');" onKeyPress="if((event.keyCode<48||event.keyCode>57)&&event.keyCode!=120&&event.keyCode!=88)event.returnValue=false;"  size=30 maxlength=18></td>
      <td>15或18位.</td>
    </tr>
    <tr onmouseover="javascript:this.bgColor='#BCD1E9';" onMouseOut="javascript:this.bgColor='';" >
      <TD>* <%=r.getString(teasession._nLanguage, "Telephone")%></TD>
      <td><input  name=telephone type="TEXT" onblur="this.value=this.value.replace(/\D/g,'');" onKeyPress="if(event.keyCode<48||event.keyCode>57)event.returnValue=false;"  size=30></td>
      <td>最少8位,全部是数字.</td>
    </tr>
  </table>
  <input type="submit" class="edit_button" id="edit_submit"  value="<%=r.getString(teasession._nLanguage, "Submit")%>">
</FORM>
<SCRIPT>document.foSignUp.MemberId.focus();</SCRIPT>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</html>

