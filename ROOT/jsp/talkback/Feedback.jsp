<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>


<html>
<head>
<TITLE>意见反馈</TITLE>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=UTF-8">
<LINK REL="stylesheet" TYPE="text/css" href="/tea/CssJs/default.css">
<SCRIPT language="JavaScript" SRC="/pub/bottommenu/comments/private/validate.js"></SCRIPT>
<SCRIPT language="JavaScript">
function filter1()
{
	if(document.form1.txt_adv_desc.value.length > 1000){
		alert("问题/意见/建议描述字数为" + document.form1.txt_adv_desc.value.length + "字，大于1000字！");
		return false;
	}
	if(document.form1.txt_lnkname.value.length > 20){
		alert("姓名字数为" + document.form1.txt_lnkname.value.length + "字，大于20字！");
		return false;
	}
	if(document.form1.txt_tel.value.length > 20){
		alert("电话长度为" + document.form1.txt_tel.value.length + "字，大于20字！");
		return false;
	}
	if(document.form1.txt_email.value.length > 50){
		alert("email长度为" + document.form1.txt_email.value.length + "字，大于50字！");
		return false;
	}
	if(Trim(document.form1.txt_adv_desc.value)==""){
		alert("请填写问题/意见/建议描述!");
		document.form1.txt_adv_desc.focus();
		return false;
	}
	if(Trim(document.form1.txt_lnkname.value)==""){
		alert("请填写姓名!");
		document.form1.txt_lnkname.focus();
		return false;
	}
	if(document.form1.txt_email.value==""){
		alert("请填写E-mail!");
		document.form1.txt_email.focus();
		return false;
	}
	if(!IsMail(document.form1.txt_email.value)){
		alert("E-mail格式错误!");
		document.form1.txt_email.focus();
		return false;
	}
return true;
}
</SCRIPT>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
</head>
<BODY BGCOLOR="#FFFFFF" TOPMARGIN="0">
 <div id="edit_BodyDiv">
 <table class="section" cellspacing="0" cellpadding="0"  border="0">
	<tr id="TableCaption">
    <TD>个人用户意见反馈</TD>
  </TR>
  <TR VALIGN="TOP">

    <TD><FORM NAME="form1" METHOD="post" action="/servlet/EditTalkback?node=<%=teasession._nNode%>">
        <input type="hidden" name="Hint" value="0">
                    <input type="hidden" name="nexturl" value="/servlet/Node?node=<%=teasession._nNode%>">
<br/>
  在使用本网以下求职服务过程中，你是否遇到了问题？或者有什么建议？请告诉我们！
        <br>
        <br><SPAN CLASS='alert'>*</SPAN> 必须填写
<HR SIZE="1">
        <TABLE WIDTH="100%" BORDER="0" CELLPADDING="2" CELLSPACING="0">
          <TR>
            <TD WIDTH="20"><INPUT  id="CHECKBOX" type="CHECKBOX" NAME="Subject" VALUE="1">
            </TD>
            <TD WIDTH="522">填写注册信息时</TD>
          </TR>
          <TR>
            <TD><INPUT  id="CHECKBOX" type="CHECKBOX" NAME="Subject" VALUE="2"></TD>
            <TD>搜索职位时</TD>
          </TR>
          <TR>
            <TD><INPUT  id="CHECKBOX" type="CHECKBOX" NAME="Subject" VALUE="4"></TD>
            <TD>申请职位，投递应聘简历过程中 </TD>
          </TR>
          <TR>
            <TD><INPUT  id="CHECKBOX" type="CHECKBOX" NAME="Subject" VALUE="8"></TD>
            <TD>登录/修改简历 </TD>
          </TR>

          <TR>
            <TD>&nbsp;</TD>
            <TD>&nbsp;</TD>
          </TR>
          <TR BGCOLOR="#D7EEFF">
            <TD HEIGHT="22" COLSPAN="2">&nbsp;<SPAN CLASS='alert'>*</SPAN> 问题/意见/建议描述<SPAN CLASS="note">（请尽可能详细描述页面位置和问题，以便我们尽快确认。限1000字）</SPAN></TD>
          </TR>
          <TR>
            <TD COLSPAN="2"><TEXTAREA NAME="Content"  class="edit_input" COLS="60" ROWS="5" WRAP="VIRTUAL"></TEXTAREA></TD>
          </TR>
          <TR>
            <TD>&nbsp;</TD>
            <TD>&nbsp;</TD>
          </TR>
          <TR BGCOLOR="#D7EEFF">
            <TD HEIGHT="22" COLSPAN="2">&nbsp;请告知你的联系信息，以便我们与你保持联系。</TD>
          </TR>
          <TR VALIGN="BOTTOM">
            <TD HEIGHT="36" COLSPAN="2"><SPAN CLASS="alert">* </SPAN>你的姓名&nbsp;
              <INPUT  class="edit_input" NAME='txt_lnkname' TYPE='text' SIZE='20' MAXLENGTH='20' VALUE=''></TD>
          </TR>
          <TR>
            <TD HEIGHT="24" COLSPAN="2">　 &nbsp;　电话&nbsp;
              <INPUT  class="edit_input" NAME="txt_tel" TYPE="text" SIZE="20" MAXLENGTH="20"></TD>
          </TR>
          <TR>
            <TD HEIGHT="24" COLSPAN="2"><SPAN CLASS="alert">*</SPAN>  E-mail&nbsp;
            <INPUT  class="edit_input" NAME='txt_email' TYPE='text' SIZE='50' MAXLENGTH='50'></TD>
          </TR>
          <TR>
            <TD HEIGHT="36" COLSPAN="2">　　　　　&nbsp;
              <INPUT class="edit_button" TYPE="submit" NAME="Submit" VALUE="提交" onClick="return filter1()" style="height:20px">　
              <input type="submit" class="edit_button" name="btnSaveAndNext" value="关闭" onclick="javaScript:window.close(); " language="javascript"  /></TD>
          </TR>
        </TABLE>
      </FORM>

    </TD>
  </TR>
</TABLE>
<br/>
<br/> </div>
</BODY>
</html>


