<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
<HEAD>
<title>发送简历</title>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script language="javascript">
<!--
function SetTitle()
{
  document.all['txtTitle'].value = "我在海油人才网（ChinaHR.com）的简历";
  document.all['txtEmail'].value = document.all['hidEmail'].value;
}
function RemoveTitle()
{
  document.all['txtTitle'].value = "";
  document.all['txtEmail'].value = "";
}

function CoverLetter_Click(letterID,LetterCount)
{
  for (var i=1;i<=LetterCount;i++)
  {
    if (i == letterID)  //当前项
    {
      document.all["Lable"+i.toString()].style.fontWeight = "bold";
      document.all["TDLetter"+i.toString()].style.backgroundImage = "url('/Images/button_03.gif')";
    }
    else //其他
    {
      document.all["Lable"+i.toString()].style.fontWeight = "normal";
      document.all["TDLetter"+i.toString()].style.backgroundImage = "url('/Images/button_04.gif')";
    }
    //改成innerHTML，不用value了,不用替换，但没有格式;
    //document.all.txtLetter.innerHTML = document.all["Hidden"+letterID].value;
    document.all.txtLetter.value = document.all["Hidden"+letterID].value.replace(/&lt;/g,"<").replace(/&gt;/g,">").replace(/&quot;/g,"\"").replace(/&amp;/g,"&");
  }
}

	function CheckCVSelect()
	  {
		var CheckBoxList;
		var IsCheck = false;
		 CheckBoxList = document.all.tags("input")
		for(i=0;i<CheckBoxList.length;i++)
		{
			if(CheckBoxList[i].name.substring(0,6)=="cbLang" && CheckBoxList[i].checked)
			{IsCheck = true};
		}
	  if(!IsCheck)
			{window.alert("请选择一份简历！");return false }
		else
		  {
		  //return Sure_onsubmit();
		  }
	  }
function cvLangClientValidate(source,arguments)
{
   var cbCN =document.all['cbLangCN'];
   var cbEN =document.all['cbLangEN'];

    if(!cbCN.checked && !cbEN.checked) //中英文都没有选
    {
        arguments.IsValid=false;
        //return;
    }
    else
    {
        arguments.IsValid=true;
    }
}
//-->
          </script>

</HEAD>
<body leftMargin="0" topMargin="0" marginwidth="0" marginheight="0">
<h1><%=r.getString(teasession._nLanguage, "SendResume")%></h1>
  <div id="head6"><img height="6" src="about:blank"></div>

<DIV ID="edit_BodyDiv">
<%
  if (!request.getMethod().equals("GET"))
  {
/*
    String conent = s1 + " 你好!<br>欢迎来到" + webn + "<a href=" + web + ">" + web + "</a><br>用户名:" + s1 + "<br>密码:" + EnterPassword + "<br>注册时间:" + (new java.util.Date());
    // conent=new String(conent.getBytes());
    byte abyte[] = conent.getBytes("GB2312");
    conent = new String(abyte, "iso-8859-1");
    String str = "注册" + webn;
    str = new String(str.getBytes("GB2312"), "iso-8859-1");
    int k = tea.entity.member.Message.create(null, community.getEmail(), 0, 0, 2, 0, teasession._nLanguage, str, conent, null, null, "", null, s5, s5, s5, null, null, 0, 0);
    try {
      tea.service.Robot.activateRoboty(community.getSmtp(), k);
    }
    catch (Exception _ex) {}*/
    out.print("<script>alert('简历发送成功!');window.close();</script>");
  }
%>
<form name="Form1" method="post" language="javascript" onsubmit="if (!ValidatorOnSubmit()) return false;" id="Form1">
<script language="javascript" type="text/javascript" src="/tea/CssJs/WebUIValidation.js"></script><script language="javascript">
/*
			function onChanged(obj)
			{
			  if( obj.options[obj.selectedIndex].value != 0 )
			    document.location=obj.options[obj.selectedIndex].value;
			}
*/
	function onChanged(obj)
      {
        if (obj.options[obj.selectedIndex].value==0)
          return false;

        if ((obj.options[obj.selectedIndex].value.length)>5)
          document.location=obj.options[obj.selectedIndex].value;
        else
          document.location="../SearchLocation.aspx?locid=" + obj.options[obj.selectedIndex].value;
      }
</script>
<h2>发送邮件</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
   
    <TR>
      <TD align="right" ><strong> * &nbsp;
      E-mail &nbsp;&nbsp; </strong></TD>
      <TD>
        <input class="edit_input"  name="txtEmail" id="txtEmail" type="text" maxlength="70" size="37"/>
        请填写收信人的E-mail地址
        <br>
        <span id="RequiredFieldValidator1" controltovalidate="txtEmail" errormessage="请填写收信人的E-mail地址！" display="Dynamic" evaluationfunction="RequiredFieldValidatorEvaluateIsValid" initialvalue="" style="color:Red;display:none;">请填写收信人的E-mail地址！</span>
        <span id="RegularExpressionValidator1" controltovalidate="txtEmail" errormessage="请填写正确的E-mail地址！" display="Dynamic" evaluationfunction="RegularExpressionValidatorEvaluateIsValid" validationexpression="\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" style="color:Red;display:none;">请填写正确的E-mail地址！</span>
      </TD>
    </TR>
    <TR>
      <TD align="right">
        <div align="right"><strong><span class="alert">*</span> &nbsp;
          信函主题
        &nbsp;&nbsp;
                </strong></div></TD>
      <TD>
        <input class="edit_input"  name="txtTitle" id="txtTitle" type="text" maxlength="100" size="37"/>
        <span id="Requiredfieldvalidator2" controltovalidate="txtTitle" errormessage="请填写信函主题！" display="Dynamic" evaluationfunction="RequiredFieldValidatorEvaluateIsValid" initialvalue="" style="color:Red;display:none;">请填写信函主题！</span>
      </TD>
    </TR>
    <TR>
      <TD align="right">
        <div align="right"><strong><span class="alert">*</span> &nbsp;
          要发送的简历
        &nbsp;&nbsp;
                </strong></div></TD>
      <TD>
          <%
java.util.Enumeration enumeration=  Resume.getNode(teasession._rv.toString(),1);
int resumeNode=0;
while(enumeration.hasMoreElements())
{resumeNode=((Integer)enumeration.nextElement()).intValue();%>
<input  id="radio" type="radio" name="resume" <%=getCheck(resumeNode==teasession._nNode)%> value="<%=resumeNode%>"/><%=(Resume.find(resumeNode,1).getName())%>
<%}          %>
        <input name="cbLangCN" id="CHECKBOX" type="CHECKBOX" value="0" checked="checked"  style="color:Red;display:none;"/>

        <input name="cbLangEN" id="CHECKBOX" type="CHECKBOX" value="1" disabled="disabled"  style="color:Red;display:none;"/>

        <span id="CustomValidator1" errormessage="请至少选择一个语言版本的简历！" display="Dynamic" evaluationfunction="CustomValidatorEvaluateIsValid" clientvalidationfunction="cvLangClientValidate" style="color:Red;display:none;">请至少选择一个语言版本的简历！</span>
      </TD>
    </TR>
    <TR>
      <TD>      </TD>
      <TD>
        <input   class="edit_button" type="submit" name="btnSend" value=" 发送 " onclick="if (typeof(Page_ClientValidate) == 'function') Page_ClientValidate(); " language="javascript" id="btnSend"/>
      </TD>
    </TR>
  </TABLE>
<script language="javascript" type="text/javascript">
<!--
	var Page_Validators =  new Array(document.all["RequiredFieldValidator1"], document.all["RegularExpressionValidator1"], document.all["Requiredfieldvalidator2"], document.all["CustomValidator1"]);
		// -->
</script><script language="javascript" type="text/javascript">
<!--
var Page_ValidationActive = false;
if (typeof(clientInformation) != "undefined" && clientInformation.appName.indexOf("Explorer") != -1) {
    if ((typeof(Page_ValidationVer) != "undefined") && (Page_ValidationVer == "125"))
        ValidatorOnLoad();
}

function ValidatorOnSubmit() {
    if (Page_ValidationActive) {
        return ValidatorCommonOnSubmit();
    }
    return true;
}
// -->
</script>
</form>
<script language="javascript">
      var obj=document.all["Lable1"];
      if(obj!=null) obj.click();
    </script></div><div id="head6"><img height="6" src="about:blank"></div>
</body>
</HTML>

