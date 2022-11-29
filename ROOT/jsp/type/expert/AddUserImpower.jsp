<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>

<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT SRC="/tea/tea.js" type="text/javascript"></SCRIPT>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=UTF-8">
<LINK href="/tea/CssJs/default.css" REL="stylesheet" TYPE="text/css">
<SCRIPT language="javascript" SRC="/tea/CssJs/validate.js"></SCRIPT>
<SCRIPT language="javascript" SRC="/tea/CssJs/CheckUserName.js"></SCRIPT>
<SCRIPT language="javascript">
function OpenWin(theURL,winName,features)
{
  window.open(theURL,winName,features);
}

function chkit()
{
	var frm=document.frmInsertUser;
	frm.selCompany.value=frm.selCompanyxx.value;
	if(!ChkTxt(frm.txtName, "姓名")) return false;
	if (frm.selOrg.value=='255' || frm.selOrg.value=='-1')	{
		alert("请选择用户所属的机构！");
		frm.selOrg.focus();
		return false;
	}
	if (!IsMail(frm.txtEmail.value)) {
		alert("请输入正确的E-mail！");
		frm.txtEmail.focus();
		return false;
	}
	if (frm.selCompany.value=='255' || frm.selCompany.value=='-1')	{
		alert("请选择用户可以操作的机构！");
		frm.selCompanyxx.focus();
		return false;
	}

	if(!CheckUserName(frm.txtUserName)) return false;
	if(!Chkpwd(frm.txtPassWord,"密码",12,6)) return false;
	if(!Chkpwd(frm.txtComfirmPwd,"确认密码",12,6)) return false;
	if(frm.txtPassWord.value!=frm.txtComfirmPwd.value) {alert('两次输入密码不一致！');frm.txtPassWord.select();return false;}
	if(frm.hiddenCount.value == null){
	    alert("请选择用户权限范围！");
		return false;
	}
	var flagstr = false;
	for(var i=0;i<frm.chkRights.length;i++)	{
	    if(frm.chkRights[i].checked){flagstr = true;}
	}
	if(!flagstr){alert("请选择用户权限范围！");	return false;}
}

function account() {

    var sum = 0;
    var count = document.frmInsertUser.chkRights.length;
    for(var i = 0; i <= count - 1; i++) {
        if (document.frmInsertUser.chkRights[i].checked) {
            sum += parseInt(document.frmInsertUser.chkRights[i].value);
        }
    }
    document.frmInsertUser.hiddenCount.value = sum;
}
</SCRIPT>
</head>
<BODY TEXT="#000000" LEFTMARGIN="0" TOPMARGIN="0">
<h1><%=r.getString(teasession._nLanguage, "AddUserImpower")%></h1>
   <div id="head6"><img height="6" src="about:blank"></div>
<FORM NAME="frmInsertUser" action="/servlet/AddUserImpower" METHOD="post" onSubmit="javascript:return chkit();">
     <table cellspacing="0" cellpadding="0" class="section">


          <TR>
            <TD COLSPAN="4"><SPAN CLASS="alert">* 必须填写</SPAN></TD>
          </TR>

          <TR>
            <TD ALIGN="RIGHT"><SPAN CLASS="alert">*</SPAN> 姓名&nbsp;</TD>
            <TD> <INPUT TYPE="text" NAME="txtName" MAXLENGTH="50" VALUE="">
            </TD>
            <TD ALIGN="RIGHT"><SPAN CLASS="alert">* </SPAN>所在机构&nbsp;</TD>
            <TD>
                <SELECT NAME="selOrg" STYLE="WIDTH: 172px">
<OPTION VALUE="">--请选择--</OPTION>
<%java.util.Enumeration enumeration=tea.entity.node.Node.findByType(21);int nodeCode;
while(                enumeration.hasMoreElements()){
   nodeCode =((Integer)enumeration.nextElement()).intValue();
%>
<OPTION VALUE="<%=nodeCode%>"><%=tea.entity.node.Node.find(nodeCode).getSubject(teasession._nLanguage)%></OPTION>
<%}enumeration=tea.entity.node.Node.findByType(18);
while(enumeration.hasMoreElements()){
     nodeCode =((Integer)enumeration.nextElement()).intValue();
%>
<OPTION VALUE="<%=nodeCode%>" ><%=tea.entity.node.Node.find(nodeCode).getSubject(teasession._nLanguage)%></OPTION>
<%}%>
</SELECT>
          </TD>
          </TR>
          <TR>
            <TD ALIGN="RIGHT"><SPAN CLASS="alert">*</SPAN> E-mail&nbsp;</TD>
            <TD> <INPUT TYPE="text" NAME="txtEmail" MAXLENGTH="120" VALUE="">
            </TD>
            <TD ALIGN="RIGHT">电话&nbsp;</TD>
            <TD> <INPUT TYPE="text" NAME="txtTelephone" MAXLENGTH="40" VALUE="">
            </TD>
          </TR>
          <TR>
            <TD ALIGN="RIGHT">职位&nbsp;</TD>
            <TD> <INPUT TYPE="text" NAME="txtWork_Title" MAXLENGTH="60" VALUE="">
            </TD>
            <TD ALIGN="RIGHT">&nbsp;</TD>
            <TD>&nbsp;</TD>
          </TR>
          <TR>
            <TD COLSPAN="4"> <HR SIZE="1"> </TD>
          </TR>
          <TR>
            <TD COLSPAN="4"><SPAN CLASS="alert">*</SPAN> 管辖机构</TD>
          </TR>
          <TR>
            <TD>&nbsp; </TD>
            <TD COLSPAN="3"> <INPUT TYPE="hidden" NAME="selCompany" VALUE="">
                     <SELECT NAME="selCompanyxx" STYLE="WIDTH: 292px">
<OPTION VALUE="">--请选择--</OPTION>
<% enumeration=tea.entity.node.Node.findByType(21);
while(                enumeration.hasMoreElements()){
   nodeCode =((Integer)enumeration.nextElement()).intValue();
%>
<OPTION VALUE="<%=nodeCode%>"><%=tea.entity.node.Node.find(nodeCode).getSubject(teasession._nLanguage)%></OPTION>
<%}enumeration=tea.entity.node.Node.findByType(18);
while(enumeration.hasMoreElements()){
     nodeCode =((Integer)enumeration.nextElement()).intValue();
%>
<OPTION VALUE="<%=nodeCode%>" ><%=tea.entity.node.Node.find(nodeCode).getSubject(teasession._nLanguage)%></OPTION>
<%}%>
</SELECT>
              <SPAN CLASS="note">该用户可以对所选机构的信息进行操作</SPAN></TD>
          </TR>
          <TR>
            <TD ALIGN="RIGHT">权限&nbsp;</TD>
            <TD COLSPAN="3">
                <%
 enumeration=               tea.entity.member.Power.findByType(21);
while(enumeration.hasMoreElements())
{tea.entity.member.Power power =tea.entity.member.Power .find(((Integer)enumeration.nextElement()).intValue());                %>
<INPUT  id="CHECKBOX" type="CHECKBOX" NAME="chkRights" VALUE="<%=power.getId()%>" onClick="account();" ><%=power.getName()%>
<%    }%>
          </TD>
          </TR>
          <TR>
            <TD COLSPAN="4"> <HR SIZE="1"> </TD>
          </TR>
          <TR>
            <TD ALIGN="RIGHT"><SPAN CLASS="alert">*</SPAN> 用户名&nbsp;</TD>
            <TD COLSPAN="3"> <INPUT TYPE="text" NAME="txtUserName" MAXLENGTH="20" VALUE="">
              <SPAN CLASS="note">20位以内，字母、数字、下划线的组合</SPAN> </TD>
          </TR>
          <TR>
            <TD ALIGN="RIGHT"><SPAN CLASS="alert">*</SPAN> 密码&nbsp;</TD>
            <TD COLSPAN="3"> <INPUT TYPE="password" NAME="txtPassWord" MAXLENGTH="12">
              <SPAN CLASS="note">6-12位</SPAN> </TD>
          </TR>
          <TR>
            <TD ALIGN="RIGHT"><SPAN CLASS="alert">*</SPAN> 确认密码&nbsp;</TD>
            <TD> <INPUT TYPE="password" NAME="txtComfirmPwd" MAXLENGTH="12"> </TD>
            <TD ALIGN="RIGHT">&nbsp;</TD>
            <TD>&nbsp;</TD>
          </TR>
          <TR>
            <TD COLSPAN="4" ALIGN="CENTER"> <INPUT TYPE="hidden" NAME="hiddenCount" VALUE="">
              <INPUT TYPE="hidden" NAME="hiddenSubmit" VALUE="1"> <INPUT NAME="imageField32" TYPE="image" SRC="/images/btn_sure.gif" WIDTH="60" HEIGHT="21" BORDER="0">
              &nbsp;
              <!--<INPUT name="imageField6" type="image" SRC="/images/btn_cancel.gif" width="60" height="21" border="0">-->
              <A HREF="javascript:frmInsertUser.reset();"><IMG NAME="imageField6" SRC="/images/btn_cancel.gif" WIDTH="60" HEIGHT="21" BORDER="0"></A>
            </TD>
          </TR>

      </TABLE>  </FORM>
      <br/>
    </TD>
  </TR>
  <TR>
    <TD VALIGN="bottom">&nbsp;    </TD>
  </TR>
</TABLE>
<div id="head6"><img height="6" src="about:blank"></div>
</BODY>

</html>

