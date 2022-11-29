<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>

<html>
<head>
<TITLE>查询职位·推荐职位给朋友——求职 招聘 招聘网！</TITLE>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=UTF-8">
<LINK REL="stylesheet" TYPE="text/css" href="/tea/CssJs/default.css">

<SCRIPT TYPE="text/javascript" SRC="/tea/CssJs/validate.js"></SCRIPT>
<SCRIPT TYPE="text/javascript">
<!--
function checkit(){
  var strToMail=document.form1.ToMail.value;
  if (strToMail==''){
    alert('请填写你朋友的EMAIL地址!');
    document.form1.ToMail.focus();
    return false;
  }else{
    var arrtomail = strToMail.split(",");
    //alert(arrtomail[0]);
    for (var i=0;i<arrtomail.length;i++){
      if (isMail(arrtomail[i])==false){
        alert('你朋友的Email地址输入有误!');
        document.form1.ToMail.focus();
        return false;
        break;
      }
    }
  }
  if (document.form1.FromMail.value==''){
    alert('请填写你自己的Email地址');
    document.form1.FromMail.focus();
    return false;
  }else{
    if (isMail(document.form1.FromMail.value)==false){
      alert('你的Email地址输入有误！');
      document.form1.FromMail.focus();
      return false;
    }
  }
}
//-->
</SCRIPT>
</head>
<BODY>
<h1><%=r.getString(teasession._nLanguage, "EMAIL")%></h1> 
<div id="head6"><img height="6" src="about:blank"></div> 
<TABLE BORDER="0" CELLSPACING="0" CELLPADDING="0" id="tablecenter">
  <TR>
    <TD COLSPAN="5" VALIGN="BOTTOM">
      <P><br/>
        <IMG SRC="/images/Head_EmailFriend.gif" WIDTH="194" HEIGHT="23"> </P>
      </TD>
  </TR>
</TABLE>
<TABLE BORDER="0" CELLSPACING="0" CELLPADDING="0" id="tablecenter">
  <TR>
    <TD>输入你朋友的email地址，我们将把这条职位发到他/她的邮箱。</TD>
  </TR>
</TABLE>
<TABLE BORDER="0" CELLSPACING="0" CELLPADDING="0" id="tablecenter">
  <TR>
    <TD><br/>
      <HR SIZE="1" COLOR="#000000">
      <LI>公司名称：
        易宝电脑系统(北京)有限公司
      <LI>工作地区：
        北京,南京,上海
      <LI>职位名称：
        行业销售
        <HR SIZE="1" COLOR="#000000"></TD>
  </TR>
</TABLE>
<FORM NAME="form1" ID="form1" METHOD="post" ACTION="emailfriend.asp?jid=44200173721126000022&locs=5" onSubmit="JavaScript:return checkit();">
  <TABLE BORDER="0" CELLSPACING="0" CELLPADDING="0" id="tablecenter">
    <TR>
      <TD COLSPAN="2">

        <INPUT TYPE="hidden" NAME="JID" VALUE="44200173721126000022">
        <INPUT TYPE="hidden" NAME="MID" VALUE="44200173721126">
        <INPUT TYPE="hidden" NAME="cna" VALUE="易宝电脑系统(北京)有限公司">
        <INPUT TYPE="hidden" NAME="jna" VALUE="行业销售">
        <INPUT TYPE="hidden" NAME="Locs" VALUE="北京,南京,上海">
        <INPUT TYPE="hidden" NAME="PostDate" VALUE="2005-1-28 16:34:07">
      </TD>
    </TR>
    <TR>
      <TD><SPAN CLASS="alert">*</SPAN> 朋友的E-mail：</TD>
      <TD>
        <INPUT TYPE="text" NAME="ToMail" SIZE="20" VALUE="" ID="ToMail">
        <SPAN CLASS="note">可输入多个email地址，用英文半角逗号隔开。</SPAN> </TD>
    </TR>
    <TR>
      <TD><SPAN CLASS="alert">*</SPAN> 我的E-mail：</TD>
      <TD>
        <INPUT TYPE="text" NAME="FromMail" ID="FromMail" SIZE="20" VALUE="">
        <SPAN CLASS="note">收件人将看到职位发自这个邮箱。</SPAN> </TD>
    </TR>
    <TR>
      <TD>标题：</TD>
      <TD>
        <INPUT TYPE="text" NAME="mailTitle" ID="mailTitle" SIZE="20" VALUE="">
        <SPAN CLASS="note">你填写的标题将作为邮件的主题。</SPAN> </TD>
    </TR>
    <TR>
      <TD>留言：</TD>
      <TD>
        <TEXTAREA NAME="mailNotes" ID="mailNotes" COLS="40" ROWS="5" WRAP="VIRTUAL">这是我在招聘网找到的职位, 也许适合你, 不妨一试。</TEXTAREA>
        <br/>
        <SPAN CLASS="note">跟对方说点什么。 </SPAN> </TD>
    </TR>
    <TR>
      <TD>&nbsp;</TD>
      <TD>&nbsp;<br/>
        <INPUT TYPE="submit" NAME="Submit" VALUE=" 发送 ">
      </TD>
    </TR>
  </TABLE>
</FORM>
<div id="head6"><img height="6" src="about:blank"></div> 
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div> 
</BODY>
</html>

