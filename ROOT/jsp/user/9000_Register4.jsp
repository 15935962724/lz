<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.htmlx.*"%>
<%@page import="tea.ui.TeaSession"%>
<%@page import="tea.resource.*" %>
<%@page import="tea.entity.site.*" %>
<%@page import="tea.entity.member.*" %>
<%@page import="java.util.*"%>
<%@page import="java.net.*"%><%

TeaSession teasession = new TeaSession(request);
Resource r = new Resource("/tea/ui/util/SignUp1").add("/tea/htmlx/HtmlX");

String code=request.getParameter("code");
String password=request.getParameter("password");

/*
StoredValue sv_obj=StoredValue.find(code);
if(!sv_obj.isExists()||!sv_obj.getPassword().equals(password))
{
	response.sendRedirect("/jsp/info/Alert.jsp?info="+URLEncoder.encode("卡号或密码错误.","UTF-8"));
	return;
}
*/

Community community=Community.find(teasession._strCommunity);

%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/card.js" type="text/javascript"></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script>
function submitCheck(form1)
{
	return(
	submitEmail(form1.MemberId,'<%=r.getString(teasession._nLanguage, "InvalidMemberId")%>')
	&&submitIdentifier(form1.EnterPassword,'<%=r.getString(teasession._nLanguage, "InvalidPassword")%>')
	&&submitEqual(form1.EnterPassword,form1.ConfirmPassword,'<%=r.getString(teasession._nLanguage, "InvalidConfirmPassword")%>')
	&&submitEmail(form1.Email,'<%=r.getString(teasession._nLanguage, "InvalidEmailAddress")%>')
	&&submitText(form1.FirstName,'<%=r.getString(teasession._nLanguage, "InvalidFirstName")%>')
	//&&submitText(form1.LastName,'<%=r.getString(teasession._nLanguage, "InvalidLastName")%>')
	&&submitText(form1.City,'<%=r.getString(teasession._nLanguage, "InvalidParameter")%>')
	&&submitText(form1.Address,'<%=r.getString(teasession._nLanguage, "InvalidParameter")%>')
	//&&submitText(form1.Zip,'<%=r.getString(teasession._nLanguage, "InvalidParameter")%>')
	&&submitText(form1.Telephone,'<%=r.getString(teasession._nLanguage, "InvalidParameter")%>')
	&&submitText(form1.vertify,'<%=r.getString(teasession._nLanguage, "InvalidParameter")%>')
	);
}
</script>
</head>
<body id="bodynone" >

<div id="jspbefore" style="display:none">
<%=community.getJspBefore(teasession._nLanguage)%>
</div>


<div id="tablebgnone" class="register">
<h1><%=r.getString(teasession._nLanguage, "LogSignUp")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>


<FORM name=form1 METHOD=POST ACTION="EditUser.jsp" onSubmit="return submitCheck(this);">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="Node" value="<%=teasession._nNode%>"/>
<input type="hidden" name="code" value="<%=code%>"/>
<input type="hidden" name="act" value="9000key"/>

        <div id="biankuang">
        <div id="toptu"><img src="/res/9000gw/u/0708/070810572.jpg"> </div>
        <div id="toptitle"><img src="/res/9000gw/u/0707/070710526.jpg" align="absmiddle"></span><span id="center">注 册 信 息</span><img src="/res/9000gw/u/0707/070710527.jpg" align="absmiddle">
          <div id="beijing">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td class="biaoge" style="padding-top:48px"><img src="/tea/image/public/Asterisk.jpg">请输入您的用户名：</td>
                <td class="biaoge2" style="padding-top:50px"><input name="MemberId" type="text" id="MemberId"></td>
              </tr>
              <tr>
                <td class="biaoge"><img src="/tea/image/public/Asterisk.jpg">请输入您的密码：</td>
                <td class="biaoge2"><input name="EnterPassword" type="text" id="EnterPassword"></td>
              </tr>
              <tr>
                <td class="biaoge"><img src="/tea/image/public/Asterisk.jpg">确认密码：</td>
                <td class="biaoge2"><input name="ConfirmPassword" type="text" id="ConfirmPassword"></td>
              </tr>
              <tr>
                <td class="biaoge"><img src="/tea/image/public/Asterisk.jpg">请填写您的E-mail地址：</td>
                <td class="biaoge2"><input name="Email" type="text" id="Email"></td>
              </tr>
              <tr>
                <td class="biaoge" style="padding-top:40px"><img src="/tea/image/public/Asterisk.jpg">您的真实姓名：</td>
                <td class="biaoge2" style="padding-top:40px"><input name="FirstName" type="text" id="FirstName"></td>
              </tr>
              <tr>
                <td class="biaoge"><img src="/tea/image/public/Asterisk.jpg">性别：</td>
                <td class="biaoge2">
                  <input type="radio" name="sex" value="1" checked>男
                  <input type="radio" name="sex" value="0">女</td>
              </tr>
              <tr>
                <td class="biaoge"><img src="/tea/image/public/Asterisk.jpg">出生日期：</td>
                <td class="biaoge2"><SELECT NAME="BirthYear" ><OPTION VALUE="1952">1952</OPTION><OPTION VALUE="1953">1953</OPTION><OPTION VALUE="1954">1954</OPTION><OPTION VALUE="1955">1955</OPTION><OPTION VALUE="1956">1956</OPTION><OPTION VALUE="1957">1957</OPTION><OPTION VALUE="1958">1958</OPTION><OPTION VALUE="1959">1959</OPTION><OPTION VALUE="1960">1960</OPTION><OPTION VALUE="1961">1961</OPTION><OPTION VALUE="1962">1962</OPTION><OPTION VALUE="1963">1963</OPTION><OPTION VALUE="1964">1964</OPTION><OPTION VALUE="1965">1965</OPTION><OPTION VALUE="1966">1966</OPTION><OPTION VALUE="1967">1967</OPTION><OPTION VALUE="1968">1968</OPTION><OPTION VALUE="1969">1969</OPTION><OPTION VALUE="1970">1970</OPTION><OPTION VALUE="1971">1971</OPTION><OPTION VALUE="1972">1972</OPTION><OPTION VALUE="1973">1973</OPTION><OPTION VALUE="1974">1974</OPTION><OPTION VALUE="1975">1975</OPTION><OPTION VALUE="1976">1976</OPTION><OPTION SELECTED VALUE="1977">1977</OPTION><OPTION VALUE="1978">1978</OPTION><OPTION VALUE="1979">1979</OPTION><OPTION VALUE="1980">1980</OPTION><OPTION VALUE="1981">1981</OPTION><OPTION VALUE="1982">1982</OPTION><OPTION VALUE="1983">1983</OPTION><OPTION VALUE="1984">1984</OPTION><OPTION VALUE="1985">1985</OPTION><OPTION VALUE="1986">1986</OPTION><OPTION VALUE="1987">1987</OPTION><OPTION VALUE="1988">1988</OPTION><OPTION VALUE="1989">1989</OPTION><OPTION VALUE="1990">1990</OPTION><OPTION VALUE="1991">1991</OPTION><OPTION VALUE="1992">1992</OPTION></SELECT><SELECT NAME="BirthMonth" ><OPTION VALUE="1">1</OPTION><OPTION VALUE="2">2</OPTION><OPTION VALUE="3">3</OPTION><OPTION VALUE="4">4</OPTION><OPTION VALUE="5">5</OPTION><OPTION VALUE="6">6</OPTION><OPTION VALUE="7">7</OPTION><OPTION SELECTED VALUE="8">8</OPTION><OPTION VALUE="9">9</OPTION><OPTION VALUE="10">10</OPTION><OPTION VALUE="11">11</OPTION><OPTION VALUE="12">12</OPTION></SELECT><SELECT NAME="BirthDay" ><OPTION VALUE="1">1</OPTION><OPTION VALUE="2">2</OPTION><OPTION SELECTED VALUE="3">3</OPTION><OPTION VALUE="4">4</OPTION><OPTION VALUE="5">5</OPTION><OPTION VALUE="6">6</OPTION><OPTION VALUE="7">7</OPTION><OPTION VALUE="8">8</OPTION><OPTION VALUE="9">9</OPTION><OPTION VALUE="10">10</OPTION><OPTION VALUE="11">11</OPTION><OPTION VALUE="12">12</OPTION><OPTION VALUE="13">13</OPTION><OPTION VALUE="14">14</OPTION><OPTION VALUE="15">15</OPTION><OPTION VALUE="16">16</OPTION><OPTION VALUE="17">17</OPTION><OPTION VALUE="18">18</OPTION><OPTION VALUE="19">19</OPTION><OPTION VALUE="20">20</OPTION><OPTION VALUE="21">21</OPTION><OPTION VALUE="22">22</OPTION><OPTION VALUE="23">23</OPTION><OPTION VALUE="24">24</OPTION><OPTION VALUE="25">25</OPTION><OPTION VALUE="26">26</OPTION><OPTION VALUE="27">27</OPTION><OPTION VALUE="28">28</OPTION><OPTION VALUE="29">29</OPTION><OPTION VALUE="30">30</OPTION><OPTION VALUE="31">31</OPTION></SELECT></td>
              </tr>
              <tr>
                <td class="biaoge"><img src="/tea/image/public/Asterisk.jpg">所在省市：</td>
                <td class="biaoge2"><script>selectcard('State','City0','City','');</script></td>
              </tr>
              <tr>
                <td class="biaoge"><img src="/tea/image/public/Asterisk.jpg">地址：</td>
                <td class="biaoge2"><input name="Address" type="text" id="Address"></td>
              </tr>
              <tr>
                <td class="biaoge">邮编：</td>
                <td class="biaoge2"><input name="Zip" type="text" id="Zip"></td>
              </tr>
              <tr>
                <td class="biaoge"><img src="/tea/image/public/Asterisk.jpg">联系电话：</td>
                <td class="biaoge2"><input name="Telephone" type="text" id="Telephone"></td>
              </tr>
              <tr>
                <td class="biaoge"><img src="/tea/image/public/Asterisk.jpg">为了安全性，请输入验证码：</td>
                <td class="biaoge2"><input name="vertify" type="text" id="vertify"><img src="/jsp/user/validate.jsp" ></td>
              </tr>
              <tr>
                <td colspan="2" style="padding-top:20px;padding-right:200px"><div align="center"><input type="image" src="/res/9000gw/u/0708/070810547.jpg" ></div></td>
              </tr>
            </table>
          </div>
        </div>
      </div>

  </FORM>
<SCRIPT>document.form1.MemberId.focus();</SCRIPT>

<div id="head6"><img height="6" src="about:blank"></div></div>

<div id="jspafter" style="display:none">
<%=community.getJspAfter(teasession._nLanguage)%>
</div>
<script>
if(top.location==self.location)
{
  jspbefore.style.display='';
  jspafter.style.display='';
}
</script>

</body>
</html>
