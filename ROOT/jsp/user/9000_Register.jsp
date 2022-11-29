<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.htmlx.*"%>
<%@page import="tea.ui.TeaSession"%>
<%@page import="tea.resource.*" %>
<%@page import="tea.entity.site.*" %>
<%@page import="tea.entity.member.Profile" %>
<jsp:useBean id="sms" scope="page" class="tea.entity.node.Sms" /><%
TeaSession teasession = new TeaSession(request);
Resource r = new Resource("/tea/ui/util/SignUp1").add("/tea/htmlx/HtmlX");

String vertify=sms.password();

Community community=Community.find(teasession._strCommunity);

%>
<HTML>
<HEAD>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/card.js" type="text/javascript"></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script>
function submitCheck(form1)
{
	return(
	submitLength(4,20,form1.MemberId,'<%=r.getString(teasession._nLanguage, "InvalidMemberId")%>')
    &&submitMemberid(form1.MemberId,'<%=r.getString(teasession._nLanguage, "InvalidMemberId")%>')

    &&submitLength(6,20,form1.EnterPassword,'<%=r.getString(teasession._nLanguage, "InvalidPassword")%>')
	&&submitIdentifier(form1.EnterPassword,'<%=r.getString(teasession._nLanguage, "InvalidPassword")%>')
	&&submitEqual(form1.EnterPassword,form1.ConfirmPassword,'<%=r.getString(teasession._nLanguage, "InvalidConfirmPassword")%>')

	//&&submitEmail(form1.Email,'<%=r.getString(teasession._nLanguage, "InvalidEmailAddress")%>')
	//&&submitText(form1.FirstName,'<%=r.getString(teasession._nLanguage, "InvalidFirstName")%>')
	//&&submitText(form1.LastName,'<%=r.getString(teasession._nLanguage, "InvalidLastName")%>')
	//&&submitText(form1.City,'<%=r.getString(teasession._nLanguage, "InvalidParameter")%>')
	//&&submitText(form1.Address,'<%=r.getString(teasession._nLanguage, "InvalidParameter")%>')
	//&&submitText(form1.Zip,'<%=r.getString(teasession._nLanguage, "InvalidParameter")%>')
	//&&submitText(form1.Telephone,'<%=r.getString(teasession._nLanguage, "InvalidParameter")%>')
	//&&submitText(form1.vertify,'<%=r.getString(teasession._nLanguage, "InvalidParameter")%>')
	);
}
function f_meberid_check(obj)
{
  var sc=document.getElementById('memberid_check');
  var len=obj.value.length+escape(obj.value).split("%u").length-1;
  if(len<4||len>20)
  {
      sc.innerHTML='<img src=/tea/image/public/check_error.gif> 无效用户名-长度不正确';
  }else
  if(isMemberid(obj.value))
  {
    sc.innerHTML='<img src=/tea/image/public/load.gif>检查中...';
    sendx('/servlet/Ajax?act=checkmember&member='+obj.value,function(bool)
    {
      sc.innerHTML=bool=='true'?'<img src=/tea/image/public/check_error.gif> 该用户已经存在了':'<img src=/tea/image/public/check_right.gif >';
    });
  }else
  {
    sc.innerHTML='<img src=/tea/image/public/check_error.gif> 无效用户名-特殊字符';
  }
}

function f_ep_check(obj)
{
  ep_check.innerHTML=(obj.value.length<6)?'<img src=/tea/image/public/check_error.gif> 无效密码':'<img src=/tea/image/public/check_right.gif >';
}
function f_cp_check(obj)
{
  cp_check.innerHTML=(form1.EnterPassword.value!=obj.value||obj.value.length<6)?'<img src=/tea/image/public/check_error.gif> 密码不相同':'<img src=/tea/image/public/check_right.gif >';
}

/*function f_email_check(obj)
{
  if(obj.value.length<7)
  {
   email_check.innerHTML = 'E-Mail格式不正确' ;
  }else
  {
    email_check.innerHTML=isEmail(obj.value)?'<img src=/tea/image/public/check_right.gif >':'<img src=/tea/image/public/check_error.gif> E-Mail格式不正确';
  }
}
function f_name_check(obj)
{
  name_check.innerHTML=(obj.value.length<1)?'<img src=/tea/image/public/check_error.gif> 姓名不能为空':'<img src=/tea/image/public/check_right.gif >';
}
function f_address_check(obj)
{
  address_check.innerHTML=(obj.value.length<1)?'<img src=/tea/image/public/check_error.gif> 地址不能为空':'<img src=/tea/image/public/check_right.gif >';
}
function f_telephone_check(obj)
{
  var tl = obj.value.length ;
  telephone_check.innerHTML = (tl<1)?'<img src=/tea/image/public/check_error.gif>联系电话不能为空':(tl<8)?'<img src=/tea/image/public/check_error.gif>电话号码长度不正确,至少输入8位':'<img src=/tea/image/public/check_right.gif > ';
}

function f_zip_check(obj)
{
  var info="";
  var i=obj.value.length;
  if(i>0&&i!=6)
  info="<img src=/tea/image/public/check_error.gif> 邮编长度不对";
  zip_check.innerHTML=info;
}*/
</script>
</HEAD>
<body id="bodynone" >

  <script>if(top.location==self.location)jspbefore.style.display='';</script>
  <%=community.getJspBefore(teasession._nLanguage)%>

<div id="tablebgnone" class="register">
  <div id="head6"><img height="6" src="about:blank"></div>
  <FORM name=form1 METHOD=POST ACTION="EditUser.jsp" onSubmit="return submitCheck(this);">
    <input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
    <input type="hidden" name="Node" value="<%=teasession._nNode%>"/>
    <div id="toptu"></div>
    <div id="denglu">
      <br>
      <span class="zhucebt" id="dl">　　登录信息</span><br>
      <div id="shurukuang">　　　 　　　<span class="ju">*</span> 用户名：
        <input name="MemberId" type="text" onKeyPress="if(event.keyCode==32)event.returnValue=false;" onChange="f_meberid_check(this);" id="yonghuming">
        <span id="memberid_check"></span> 　4-20字符，可以使用字母、中文字符<br>
        　　　 　　　<span class="ju">*</span> 密　　码：
        <input name="EnterPassword" type="Password" id="EnterPassword" onBlur="f_ep_check(this);">
        <span id="ep_check"></span> 　不能少于6个字符<br>
        　　　 　　　<span class="ju">*</span> 重复密码：
        <input name="ConfirmPassword" type="Password" id="ConfirmPassword" onBlur="f_cp_check(this);"> <span id="cp_check"></span> 　请再输入一次密码
        <br>
        　　　 　　　<span class="ju">*</span> 邮箱地址：
        <input name="Email" type="text" id="yonghuming" onBlur="f_email_check(this);">
        <span id="email_check"></span>
      　当您忘记密码时，可通过邮箱取回密码<br><br>
	   　　　 　　　 带“<span class="ju">*</span>”的为必填项<br>
      </div>
    </div>
<DIV id=denglu><SPAN class="zhucebt">　　用户详细资料</SPAN><BR><BR>
<DIV id=shurukuang>　　　 　　　真实姓名：
  <INPUT
onblur=f_name_check(this); name=FirstName id="yonghuming"> <SPAN
id=name_check></SPAN> 　填写您的真实姓名<BR>
   　　　 　　<%-- 　性　　别：
   <INPUT type=radio CHECKED value=1 name=sex> 男 <INPUT type=radio value=0 name=sex>
女   　　　　　　 　选择您的性别<BR><br>
　　　 　　　出生年月：
<SELECT name=BirthYear style="width:75px"> <OPTION
  value=1952>1952</OPTION> <OPTION value=1953> 1953　</OPTION> <OPTION
  value=1954>1954</OPTION> <OPTION value=1955>1955</OPTION> <OPTION
  value=1956>1956</OPTION> <OPTION value=1957>1957</OPTION> <OPTION
  value=1958>1958</OPTION> <OPTION value=1959>1959</OPTION> <OPTION
  value=1960>1960</OPTION> <OPTION value=1961>1961</OPTION> <OPTION
  value=1962>1962</OPTION> <OPTION value=1963>1963</OPTION> <OPTION
  value=1964>1964</OPTION> <OPTION value=1965>1965</OPTION> <OPTION
  value=1966>1966</OPTION> <OPTION value=1967>1967</OPTION> <OPTION
  value=1968>1968</OPTION> <OPTION value=1969>1969</OPTION> <OPTION
  value=1970>1970</OPTION> <OPTION value=1971>1971</OPTION> <OPTION
  value=1972>1972</OPTION> <OPTION value=1973>1973</OPTION> <OPTION
  value=1974>1974</OPTION> <OPTION value=1975>1975</OPTION> <OPTION
  value=1976>1976</OPTION> <OPTION value=1977 selected>1977</OPTION> <OPTION
  value=1978>1978</OPTION> <OPTION value=1979>1979</OPTION> <OPTION
  value=1980>1980</OPTION> <OPTION value=1981>1981</OPTION> <OPTION
  value=1982>1982</OPTION> <OPTION value=1983>1983</OPTION> <OPTION
  value=1984>1984</OPTION> <OPTION value=1985>1985</OPTION> <OPTION
  value=1986>1986</OPTION> <OPTION value=1987>1987</OPTION> <OPTION
  value=1988>1988</OPTION> <OPTION value=1989>1989</OPTION> <OPTION
  value=1990>1990</OPTION> <OPTION value=1991>1991</OPTION> <OPTION
  value=1992>1992</OPTION></SELECT>
<select name=BirthMonth>
  <option
  value=1>1</option>
  <option value=2>2</option>
  <option value=3>3</option>
  <option value=4>4</option>
  <option value=5>5</option>
  <option
  value=6>6</option>
  <option value=7>7</option>
  <option value=8
  selected>8</option>
  <option value=9>9</option>
  <option value=10>10</option>
  <option value=11>11</option>
  <option value=12>12</option>
</select>
<SELECT
name=BirthDay > <OPTION value=1>1</OPTION> <OPTION value=2>2</OPTION> <OPTION
  value=3 selected>3</OPTION> <OPTION value=4>4</OPTION> <OPTION
  value=5>5</OPTION> <OPTION value=6>6</OPTION> <OPTION value=7>7</OPTION>
  <OPTION value=8>8</OPTION> <OPTION value=9>9</OPTION> <OPTION
  value=10>10</OPTION> <OPTION value=11>11</OPTION> <OPTION value=12>12</OPTION>
  <OPTION value=13>13</OPTION> <OPTION value=14>14</OPTION> <OPTION
  value=15>15</OPTION> <OPTION value=16>16</OPTION> <OPTION value=17>17</OPTION>
  <OPTION value=18>18</OPTION> <OPTION value=19>19</OPTION> <OPTION
  value=20>20</OPTION> <OPTION value=21>21</OPTION> <OPTION value=22>22</OPTION>
  <OPTION value=23>23</OPTION> <OPTION value=24>24</OPTION> <OPTION
  value=25>25</OPTION> <OPTION value=26>26</OPTION> <OPTION value=27>27</OPTION>
  <OPTION value=28>28</OPTION> <OPTION value=29>29</OPTION> <OPTION
  value=30>30</OPTION> <OPTION value=31>31</OPTION></SELECT> 　选择您的出生年月<BR><BR>
<div style="float:left;vertical-align:bottom;height:21px;line-height:21px;">　　　 　　　所在省市： <SCRIPT>selectcard('State','City0','City','');</SCRIPT>
　选择您的省份<BR></div>
--%>
 <div style="clear: both;">
 <BR>
　　　 　　　联系手机：
<INPUT onblur=f_telephone_check(this); onkeypress=inputInteger(); maxlength="11" name=Mobile id="yonghuming">
<SPAN id=telephone_check></SPAN> 　填写您的联系电话
 <BR>
　　　 　　　联系电话：
<INPUT onblur=f_telephone_check(this); onkeypress=inputInteger(); maxlength="11" name=Telephone id="yonghuming">
<SPAN id=telephone_check></SPAN> 　填写您的联系电话
<br>
 <span>　　　 　　　所在地址：
 <input onBlur=f_address_check(this); name=Address id="yonghuming"></span>
 <SPAN id=address_check></SPAN> 　填写您的地址</div></DIV></DIV>
　　　 　<%--　　邮政编码：
<INPUT onkeypress=inputInteger(); onblur=f_zip_check(this); maxLength=6 name=Zip id="yonghuming"><SPAN id=zip_check></SPAN> 　填写您的邮政编码
--%>

<DIV id=denglu>
<DIV id=shurukuang>　　　 　　　<span class="ju">*</span> 验证码：
  <INPUT id="yonghuming" name=vertify >
　  <img src="validate.jsp">  　如果看不清楚，请点击图片换一个验证</DIV></DIV>
<DIV><INPUT id="jihuo" type=submit value=注册会员> <input id="re" type=reset value=重新填写></DIV>
  </FORM>
  <SCRIPT>document.form1.MemberId.focus();</SCRIPT>
  <div><img height="6" src="about:blank"></div>
</div>

  <script>if(top.location==self.location)jspafter.style.display='';</script>
  <%=community.getJspAfter(teasession._nLanguage)%>
</body>
</HTML>
