<%@page import="tea.entity.member.SMSMessage"%>
<%@page import="java.util.regex.Matcher"%>
<%@page import="java.util.regex.Pattern"%>
<%@page import="tea.db.DbAdapter"%>
<%@page import="tea.entity.Entity"%>
<%@page import="tea.entity.member.ProfileConsulting"%>
<%@page import="java.util.Enumeration"%>
<%@page import="tea.entity.member.Profile"%>
<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.ui.TeaSession" %>
<%!

public boolean checkCellPhone(String cellPhoneNr)   
{   
    String reg="^[1][\\d]{10}";   
    return startCheck(reg,cellPhoneNr);   
} 
public  boolean startCheck(String reg,String string)   
{   
    boolean tem=false;   
       
    Pattern pattern = Pattern.compile(reg);   
    Matcher matcher=pattern.matcher(string);   
       
    tem=matcher.matches();   
    return tem;   
}   

%>
<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);



String mobilePhone = teasession.getParameter("mobilePhone");


//Profile pobj = Profile.find(Profile.getMember(code));

if(mobilePhone==null)
{
	
	out.println("您的手机号不能为空");
	return;
}

if(!this.checkCellPhone(mobilePhone))
{
	out.println("您的手机号不正确，请重新输入");
	return;	
}

if(!mobilePhone.matches("^(13|15|18)\\d{9}$"))
{
	out.println("您的手机号不正确，请重新输入");
	return;	
}

if("POST".equals(request.getMethod()))
{
	String ctext = teasession.getParameter("ctext");
	String i = SMSMessage.create(teasession._strCommunity,mobilePhone,mobilePhone,teasession._nLanguage,ctext); 
	System.out.println(i);
	out.println("发送成功");
	return;
	 
}



%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">

<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/ym/ymPrompt.js" type=""></SCRIPT>
<link href="/tea/ym/skin/dmm-green/ymPrompt.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>
<script>
	function f_sub()
	{
		document.getElementById('buttonid').value='短信正在发送,请稍候...';
		document.getElementById('buttonid').disabled=true;
	
		ymPrompt.win({message:'<br><center>短信正在发送,请稍候...</center>',title:'',width:'300',height:'50',titleBar:false});
	}
</script>
<body>

<h1>发送短信</h1>
<form action="?" method="POST" name="form1">
<input type="hidden" name="mobilePhone" value="<%=mobilePhone %>">
<input type="hidden" name="id" value="<%=teasession.getParameter("id") %>">
 <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">


	<tr>
      <td align="right">发送手机号：</td>
      <td>
      		<input type="text" name="mobilePhone" value="<%=Entity.getNULL(mobilePhone) %>">
       </td>
    </tr>

	<tr>
      <td align="right">短信内容：</td>
      <td>
      		<textarea rows="3" cols="60" name="ctext"></textarea>&nbsp;
      	
       </td>
    </tr>
    </table>
	<input type="button" id="buttonid" value="发送" onclick="f_sub();">

</form>


</body>
</html>

