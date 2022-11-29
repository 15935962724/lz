<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.htmlx.Languages"%>
<%@ page import="tea.ui.TeaSession"%>
<%@ page import = "tea.resource.Resource" %>
<%request.setCharacterEncoding("UTF-8");
TeaSession teasession = new TeaSession(request);
tea.entity.node.Node node=tea.entity.node.Node.find(teasession._nNode);
Resource r = new Resource("/tea/ui/node/type/sms/EditUser");
if(request.getMethod().equals("POST"))
{
  String vertify=(String)session.getAttribute("sms.vertify");
  String vertify1 = teasession.getParameter("vertify").trim();
  String ConfirmPassword = teasession.getParameter("ConfirmPassword").trim();
  String EnterPassword = teasession.getParameter("EnterPassword").trim();

  if (!vertify1.equals(vertify)&&!vertify1.equals("vertify"))
  {
    response.sendRedirect( "/jsp/info/Alert.jsp?community="+teasession._strCommunity+"&info="+ java.net.URLEncoder.encode(r.getString(teasession._nLanguage, "ConfirmCodeError"),"UTF-8"));
    return;
  }
  tea.entity.member.Profile obj;
  if(teasession._rv==null)
  {
    String s1 = teasession.getParameter("MemberId");//.toLowerCase();
    for(int index=0;index<s1.length();index++)
    if(s1.charAt(index)>='A'&&s1.charAt(index)<='Z')
    s1=s1.substring(0,index)+(char)(s1.charAt(index)+32)+ s1.substring(index+1);
    if(tea.entity.member.Profile.isExisted(s1))
    {
      response.sendRedirect( "/jsp/info/Alert.jsp?community="+teasession._strCommunity+"&info="+ java.net.URLEncoder.encode(tea.http.RequestHelper.format(r.getString(teasession._nLanguage, "RepetitionRegisters"), s1),"UTF-8"));
      return;
    }
    obj=tea.entity.member.Profile.create(s1,teasession._strCommunity,ConfirmPassword);
    response.sendRedirect("/jsp/user/regsuccess.jsp?node="+teasession._nNode);
  }else
  {
    obj=tea.entity.member.Profile.find(teasession._rv._strR);
    obj.setPassword(ConfirmPassword);
    response.sendRedirect("/jsp/user/BBSRegister.jsp?node="+teasession._nNode);
  }
  obj.setFirstName(teasession.getParameter("FirstName").trim(),teasession._nLanguage);
  obj.setEmail( teasession.getParameter("Email"));
  /*
  byte by[]=teasession.getBytesParameter("photo");
  if(by!=null)
  obj.setPhoto(by,teasession._nLanguage);
  */
  obj.setMobile( teasession.getParameter("PhoneNumber"));
  obj.setOrganization(teasession.getParameter("Organization"),teasession._nLanguage);
  obj.setAddress(teasession.getParameter("Address"),teasession._nLanguage);
  obj.setState(teasession.getParameter("State"),teasession._nLanguage);
  obj.setCity(teasession.getParameter("City"),teasession._nLanguage);
  obj.setZip(teasession.getParameter("Zip"),teasession._nLanguage);
  obj.setCountry(teasession.getParameter("Country"),teasession._nLanguage);
  obj.setTelephone(teasession.getParameter("Telephone"),teasession._nLanguage);
  obj.setFax(teasession.getParameter("Fax"),teasession._nLanguage);
  //obj.setAge(Integer.parseInt(teasession.getParameter("Age")));
  obj.setWebPage(teasession.getParameter("WebPage"),teasession._nLanguage);

  return ;
}

r.add("/tea/ui/util/SignUp1");


String memberId,email,password,mobile,firstName,organization,address,zip,country,telephone,fax,webPage,state,city;
int age=20;
if(teasession._rv!=null)
{
  tea.entity.member.Profile obj=tea.entity.member.Profile.find(teasession._rv._strR);
  memberId=obj.getMember()+" disabled ";
  email=obj.getEmail();
  password=obj.getPassword();
  mobile=obj.getMobile();
  firstName=obj.getFirstName(teasession._nLanguage);
  organization=obj.getOrganization(teasession._nLanguage);
  address=obj.getAddress(teasession._nLanguage);
  zip=obj.getZip(teasession._nLanguage);
  country=obj.getCountry(teasession._nLanguage);
  telephone=obj.getTelephone(teasession._nLanguage);
  fax=obj.getFax(teasession._nLanguage);
  age=obj.getAge();
  webPage=obj.getWebPage(teasession._nLanguage);
  state=obj.getState(teasession._nLanguage);
  city=obj.getCity(teasession._nLanguage);
}else
memberId=email=password=mobile=firstName=organization=address=zip=country=telephone=fax=webPage=state=city="";
%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT SRC="/tea/tea.js" type="text/javascript"></SCRIPT>
<script language="javascript" src="/tea/CssJs/CnoocAreaCityDataCN.js"></script>
<script language="javascript" src="/tea/CssJs/AreaCityScipt.js"></script>
<script language="javascript" src="/tea/CssJs/SummaryDataCN.js"></script>
<script language="javascript" src="/tea/CssJs/SummaryScript.js"></script>
<script>
function isMmeberId(s) {
  s=s.replace(' ','').replace('	','');
	if (s.length < 1)
		return false;
	for (var i = 0; i < s.length; i++) {
		var c = s.charAt(i);
		if (('/' == c)||('<' == c)||('>' == c)||('\\' == c)||('|' == c))
		{
                  return false;
              }
	}
	return true;
}
function submitMemberId(text, alerttext) {
	if(!isMmeberId(text.value)) {
		alert(alerttext);
		text.focus();
		return false;
	}

	return true;
}
function submitSelect(obj,alerttext)
{
  if(obj.selectedIndex==0)
  {
    alert(alerttext);
    obj.focus();
    return false;
  }
  return true;
}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "LogSignUp")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
  <FORM ACTION="" METHOD=POST enctype="multipart/form-data" name=foSignUp onSubmit="return(submitMemberid(this.MemberId,'<%=r.getString(teasession._nLanguage, "InvalidMemberId")%>')&&submitText(this.EnterPassword,'<%=r.getString(teasession._nLanguage, "InvalidPassword")%>')&&submitEqual(this.EnterPassword,this.ConfirmPassword,'InvalidConfirm')&&submitText(this.FirstName,'<%=r.getString(teasession._nLanguage, "InvalidFirstName")%>')&&submitEmail(this.Email,'<%=r.getString(teasession._nLanguage, "InvalidEmailAddress")%>')&&submitEqual(this.EnterPassword,this.ConfirmPassword,'<%=r.getString(teasession._nLanguage, "InvalidConfirmPassword")%>')&&submitSelect(this.State,'请选择省'));">
    <input type='hidden' name=Node VALUE="<%=teasession._nNode%>">
    <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
      <tr>
        <TD>* <%=r.getString(teasession._nLanguage, "MemberId")%>:</TD>
        <td><input type="TEXT" class="edit_input"  name=MemberId VALUE=<%=memberId%> SIZE=20 MAXLENGTH=40></td>
        <TD>*<%=r.getString(teasession._nLanguage, "EmailAddress")%>:</TD>
        <td><input type="TEXT" class="edit_input"  name=Email VALUE="<%=email%>" SIZE=40 MAXLENGTH=40></td>
      </tr>
      <tr>
        <TD>* <%=r.getString(teasession._nLanguage, "EnterPassword")%>:</TD>
        <td><input type="password" class="edit_input"  name=EnterPassword VALUE="<%=password%>" SIZE=20 MAXLENGTH=16></td>
      </tr>
      <tr>
        <TD>* <%=r.getString(teasession._nLanguage, "ConfirmPassword")%>:</TD>
        <td><input type="password" class="edit_input"  name=ConfirmPassword VALUE="<%=password%>" SIZE=20 MAXLENGTH=16></td>
      </tr>
      <tr>
        <TD>头像:</TD>
        <td><input type="file" class="edit_input" onDblClick="window.open('/servlet/PhotoPicture');"  name=photo VALUE=""  ></td>
      </tr>
      <tr>
        <TD><%=r.getString(teasession._nLanguage, "mobile1")%>:</TD>
        <td><input type="TEXT" class="edit_input"  name=PhoneNumber VALUE="<%=mobile%>" SIZE=20 MAXLENGTH=20></td>
      </tr>
      <tr>
        <TD>* <%=r.getString(teasession._nLanguage, "Validate")%>:</TD>
        <td><input type="TEXT" class="edit_input"  name=vertify VALUE="" SIZE=20 MAXLENGTH=20></td>
        <TD><%=r.getString(teasession._nLanguage, "VerificationCode")%>:</TD>
        <td><img src="validate.jsp" alt="Validate">
          <%//=vertify%></td>
      </tr>
      <tr>
        <TD>* <%=r.getString(teasession._nLanguage, "Name")%>:</TD>
        <td><input type="TEXT" class="edit_input"  name=FirstName VALUE="<%=firstName%>" SIZE=20 MAXLENGTH=20></td>
        <!--TD><font color="#FF0000">*</font><%=r.getString(teasession._nLanguage, "LastName")%>:</TD>
        <td><input type="TEXT" class="edit_input"  name=LastName VALUE="" SIZE=20 MAXLENGTH=20></td-->
      </tr>
      <tr>
        <TD><%=r.getString(teasession._nLanguage, "Organization")%>:</TD>
        <td COLSPAN=3><input type="TEXT" class="edit_input"  name=Organization VALUE="<%=organization%>" SIZE=40 MAXLENGTH=40></td>
      </tr>
      <tr>
        <TD><%=r.getString(teasession._nLanguage, "Address")%>:</TD>
        <td COLSPAN=3><TEXTAREA name=Address class="edit_input"  ROWS=2 COLS=60><%=address%></TEXTAREA></td>
      </tr>
      <tr>
        <TD>* <%=r.getString(teasession._nLanguage, "State")%>:</TD>
        <td><!--input type="TEXT" class="edit_input"  name=State VALUE="" SIZE=20 MAXLENGTH=20-->
          <select id="State" name="State">
          </select>
        </td>
        <TD>* <%=r.getString(teasession._nLanguage, "City")%>:</TD>
        <td><!--input type="TEXT" class="edit_input"  name=City VALUE="" SIZE=20 MAXLENGTH=20-->
          <select class="edit_input" id="City" style="WIDTH: 160px"   name="City">
          </select>
        </td>
        <script language="javascript" type="">
/*期望工作地区*/
var expectStateObj=document.all['State'];
var srcExpectCityObj=document.all['City'];
if(typeof(expectStateObj)=="object") expectStateObj.onchange=function()
{
    onChangeProvince(document.all['State'],document.all['City']);
}

// if(typeof(expectStateObj)=="object" && typeof(srcExpectCityObj)=="object" && typeof(expectCityObj)=="object")
{
    //initProvince(expectStateObj,srcExpectCityObj,"");
    initProvince(expectStateObj,srcExpectCityObj,"");
    //initCityNodes(expectCityObj,"");
}

for (index=0;index<expectStateObj.length;index++)
if('<%=state%>'==expectStateObj.options[index].value)
{
  expectStateObj.selectedIndex=index;
  expectStateObj.onchange();
  break;
}
for(index=0;index<srcExpectCityObj.length;index++)
{
  if('<%=city%>'==srcExpectCityObj.options[index].value)
  {
    srcExpectCityObj.selectedIndex=index;
    break;
  }
}
    </script>
      </tr>
      <tr>
        <TD><%=r.getString(teasession._nLanguage, "Zip")%>:</TD>
        <td><input type="TEXT" class="edit_input"  name=Zip VALUE="<%=zip%>" SIZE=20 MAXLENGTH=20></td>
        <TD><%=r.getString(teasession._nLanguage, "Country")%>:</TD>
        <td><input type="TEXT" class="edit_input"  name=Country VALUE="<%=country%>" SIZE=20 MAXLENGTH=20></td>
      </tr>
      <tr>
        <TD><%=r.getString(teasession._nLanguage, "Telephone")%>:</TD>
        <td><input type="TEXT" class="edit_input"  name=Telephone VALUE="<%=telephone%>"></td>
        <TD><%=r.getString(teasession._nLanguage, "Fax")%>:</TD>
        <td><input type="TEXT" class="edit_input"  name=Fax VALUE="<%=fax%>" SIZE=20 MAXLENGTH=20></td>
      </tr>
      <tr>
        <TD><%=r.getString(teasession._nLanguage, "Age")%>:</TD>
        <td><input type="TEXT" class="edit_input"  name=Age VALUE="<%=age%>" SIZE=20 MAXLENGTH=20></td>
        <TD><%=r.getString(teasession._nLanguage, "WebPage")%>:</TD>
        <td><input type="TEXT" class="edit_input"  name=WebPage VALUE="<%=webPage%>" size="40" MAXLENGTH="255"></td>
      </tr>
    </table>
    <input  id="CHECKBOX" type="CHECKBOX" name=AddressTPublic value=null>
    <%=r.getString(teasession._nLanguage, "AddressTPublic")%>
    <input type="submit" class="edit_button" id="edit_submit"  value="<%=r.getString(teasession._nLanguage, "Submit")%>">
  </FORM>
  注: <br>
  1.会员ID 格式:最短3个字符,且并只能是英文或数字<br>
  2.如果有头像,双击File控件,就可以查看头像
  <SCRIPT type="">document.foSignUp.MemberId.focus();</SCRIPT>
   <div id="head6"><img height="6" src="about:blank"></div>
  <div id="language"><%=new Languages(teasession._nLanguage,request)%></div>

</body>
</html>

