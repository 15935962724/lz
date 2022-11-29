<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.htmlx.*"%>
<%@ page import="tea.ui.TeaSession"%>
<%@ page import="java.util.*"%>
<%@ page import="tea.resource.*" %>
<%@ page import="tea.entity.site.*" %>
<%@ page import="tea.entity.member.*" %>
<%

TeaSession teasession = new TeaSession(request);

Resource r = new Resource("/tea/ui/util/SignUp1").add("/tea/htmlx/HtmlX");


String rndData="";

char Upper = '9';
char Lower = '0';
Random ran = new Random();
for(int i=0; i<15; i++)
{
   int tempval = (int)((int)Lower + (ran.nextFloat() * ((int)(Upper - Lower))));
   rndData += new Character((char)tempval).toString();
}
//session.setAttribute("RandomData",rndData); 

int nRndLen=rndData.length();


String nexturl=request.getParameter("nexturl");


Community community=Community.find(teasession._strCommunity);

%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script>
function submitCheck(form11)
{
	return(
	submitText(form11.LoginId,'<%=r.getString(teasession._nLanguage, "InvalidParameter")%>')&&
	submitText(form11.Password,'<%=r.getString(teasession._nLanguage, "InvalidPassword")%>')&&
	submitText(form11.vertify,'<%=r.getString(teasession._nLanguage, "InvalidPassword")%>')&&
	check()
	);
}
</script>
<script src="/tea/md5.js"></script>
<SCRIPT>
function verifyUserPin()
{
	var lib = key.GetLibVersion();
	var hCard;	
	var digest;
	var enData;

	try 
	{
		hCard = key.OpenDevice(1);
		if (hCard == 0)
		{
			throw new exception();
		}
		
	}catch (exception)
	{
		alert("无法连接到K盘设备, 请确认您是否插入K盘");
		return false;
	}
	
	try
	{
		
		key.VerifyUserPin(hCard, '111111');
	}
	catch (exception)
	{
		key.CloseDevice(hCard);
		alert("验证用户PIN失败!");
		return false;
	}
	
	try	
	{
		var hardid = key.GetSerialNum(hCard);
		LoginForm.hardid.value = hardid; /* 取k盘硬件id */
		
	}catch (exception)
	{
		key.CloseDevice(hCard);
		alert("取得硬件号失败!");
		return false;
	}

	try
	{
		digest = key.HTSHA1('<%=rndData%>',<%=nRndLen%>);
	}
	catch (exception)
	{
		key.CloseDevice(hCard);
		alert("SHA1 failed!");
		return false;
	}
	
	try
	{
		digest = digest + "04040404";
		enData = key.HTCrypt(hCard, 0, 0, digest, digest.length);
		LoginForm.endata.value = enData;  /* 取密文 */

	}
	catch (exception)
	{
		key.CloseDevice(hCard);
		alert("HashToken compute!");
		return false;
	}
	
	
	key.CloseDevice(hCard);
	return true;
}
	

/* ===提交表单之前，先调用check()，不成功则不提交表单 =====*/
function check()
{
	if (verifyUserPin())
	{
		//var p = document.LoginForm.password;
		//p.value = MD5(p.value);
		return true;
	}
	return false;
}
</SCRIPT>
</head>
<body>

<OBJECT id=key name=key classid="clsid:FB4EE423-43A4-4AA9-BDE9-4335A6D3C74E" codebase="/tea/download/EscaKeySupport.cab#version=1,0,0,1" style="HEIGHT: 0px; WIDTH: 0px"></OBJECT>

<FORM name=LoginForm METHOD=POST ACTION="/servlet/Login" onSubmit="return submitCheck(this);" target="_top">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="Node" value="<%=teasession._nNode%>"/>
<input type='hidden' name="LoginType" value="10">
<%
if(nexturl!=null)
	out.print("<input type=hidden name=nexturl value="+nexturl+">");
%>


<INPUT type="hidden" name="endata">	
<INPUT type="hidden" name="hardid">
<INPUT type="hidden" name="random" value="<%=rndData%>">


<table border="0" cellspacing="0" cellpadding="0" border="0">
            <tr>
              <td height="35px">帐 号：
                <input type='hidden' name="LoginType" value="0">
                <input name=LoginId onkeyup=if(event.keyCode==13)document.LoginForm.submit(); type="text"  id="userid">
              </td>
			  </tr>
			  <tr>
			  <td height="35px">
                密 码：&nbsp;&nbsp;
                <input type="password" onkeyup=if(event.keyCode==13)document.LoginForm.submit(); id="mima" name="Password">
				</td>
            </tr>
            <tr>
              <td height="35px"><A style="CURSOR: hand" onClick="window.open('/servlet/RetrievePassword?node=<%=teasession._nNode%>')" id="kuangzzp">忘记密码？</A> </td>
            </tr>
        </table>
        <div id="queren">
          <h2>请将下边的验证码输入框中</h2>
          <div id="shuru">
            <input name=vertify onkeyup=if(event.keyCode==13)document.LoginForm.submit(); type="text"  id="yanzm">
          </div>
          <div id="huantu"> <img id="validate" src="/jsp/user/validate.jsp?"> </div>
          <div id="tuzi"> <a href="###" onClick="var img=document.getElementById('validate'); img.src=img.src+'&';">看不清换一张</a> </div>
        </div>
        <div><input type=submit value="登录" id="shuangdeng"></div>

</FORM>

</body>
</html>
