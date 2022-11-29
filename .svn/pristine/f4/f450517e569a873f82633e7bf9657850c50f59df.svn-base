
<html>
<head>
<TITLE>ChinaHR.com ��Ƹϵͳ�������û�</TITLE>
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
	if(!ChkTxt(frm.txtName, "����")) return false;
	if (frm.selOrg.value=='255' || frm.selOrg.value=='-1')	{
		alert("��ѡ���û�����Ļ�");
		frm.selOrg.focus();
		return false;
	}
	if (!IsMail(frm.txtEmail.value)) {
		alert("��������ȷ��E-mail��");
		frm.txtEmail.focus();
		return false;
	}
	if (frm.selCompany.value=='255' || frm.selCompany.value=='-1')	{
		alert("��ѡ���û����Բ���Ļ�");
		frm.selCompanyxx.focus();
		return false;
	}

	if(!CheckUserName(frm.txtUserName)) return false;
	if(!Chkpwd(frm.txtPassWord,"����",12,6)) return false;
	if(!Chkpwd(frm.txtComfirmPwd,"ȷ������",12,6)) return false;
	if(frm.txtPassWord.value!=frm.txtComfirmPwd.value) {alert('}���������벻һ�£�');frm.txtPassWord.select();return false;}
	if(frm.hiddenCount.value == null){
	    alert("��ѡ���û�Ȩ�޷�Χ��");
		return false;
	}
	var flagstr = false;
	for(var i=0;i<frm.chkRights.length;i++)	{
	    if(frm.chkRights[i].checked){flagstr = true;}
	}
	if(!flagstr){alert("��ѡ���û�Ȩ�޷�Χ��");	return false;}
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
<TABLE WIDTH="100%" BORDER="0" CELLSPACING="0" CELLPADDING="0" HEIGHT="100%" CLASS="bodystyle">
  <TR>
    <TD HEIGHT="50" VALIGN="top">
           <TABLE WIDTH="100%" BORDER="0" CELLPADDING="0" CELLSPACING="0" HEIGHT="20"><TR><TD CLASS="menuinactive" VALIGN="bottom"> <TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0" HEIGHT="20"><TR><TD BGCOLOR="#CCCCCC"><IMG SRC="/images/none.gif" WIDTH="1" HEIGHT="1"></TD><TD WIDTH="130" ALIGN="CENTER" VALIGN="bottom" NOWRAP CLASS="menuinactive"><IMG SRC="/images/arrow_y.gif" WIDTH="7" HEIGHT="7" ALIGN="absmiddle">&nbsp;<A href="/index_rec.asp" CLASS="menu">��Ƹϵͳ��ҳ</A></TD><TD ALIGN="CENTER" VALIGN="bottom" BGCOLOR="#333333"><IMG SRC="/images/none.gif" WIDTH="1" HEIGHT="1"></TD><TD ALIGN="CENTER" VALIGN="bottom" BGCOLOR="#CCCCCC"><IMG SRC="/images/none.gif" WIDTH="1" HEIGHT="1"></TD><TD WIDTH="100" ALIGN="CENTER" VALIGN="bottom" NOWRAP CLASS="menuinactive"><IMG SRC="/images/arrow_y.gif" WIDTH="7" HEIGHT="7" ALIGN="absmiddle">&nbsp;<A href="/jobs/job_manage.asp" CLASS="menu">��Ƹ����</A></TD><TD ALIGN="CENTER" VALIGN="bottom" BGCOLOR="#333333"><IMG SRC="/images/none.gif" WIDTH="1" HEIGHT="1"></TD><TD ALIGN="CENTER" VALIGN="bottom" BGCOLOR="#CCCCCC"><IMG SRC="/images/none.gif" WIDTH="1" HEIGHT="1"></TD><TD WIDTH="100" ALIGN="CENTER" VALIGN="bottom" NOWRAP CLASS="menuinactive"><IMG SRC="/images/arrow_y.gif" WIDTH="7" HEIGHT="7" ALIGN="absmiddle">&nbsp;<A href="/cv_center/cv_search_chr.asp" CLASS="menu">�����ѯ</A></TD><TD BGCOLOR="#333333" VALIGN="bottom"><IMG SRC="/images/none.gif" WIDTH="1" HEIGHT="1"></TD><TD BGCOLOR="#CCCCCC" VALIGN="bottom"><IMG SRC="/images/none.gif" WIDTH="1" HEIGHT="1"></TD></TR></TABLE></TD><TD CLASS="menuinactive" ALIGN="right" VALIGN="bottom"> <TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0" HEIGHT="20"><TR><TD BGCOLOR="#333333" WIDTH="1" VALIGN="bottom"><IMG SRC="/images/none.gif" WIDTH="1" HEIGHT="1"></TD><TD BGCOLOR="#CCCCCC" WIDTH="1" VALIGN="bottom"><IMG SRC="/images/none.gif" WIDTH="1" HEIGHT="1"></TD><TD WIDTH="60" ALIGN="center" VALIGN="bottom" NOWRAP CLASS="menuactive"><IMG SRC="/images/arrow_w.gif" WIDTH="7" HEIGHT="7" ALIGN="absmiddle">&nbsp;<A href="/sysset/mem_org_manage.asp" CLASS="menu">����</A></TD><TD BGCOLOR="#333333" WIDTH="1" VALIGN="bottom"><IMG SRC="/images/none.gif" WIDTH="1" HEIGHT="1"></TD><TD BGCOLOR="#CCCCCC" WIDTH="1" VALIGN="bottom"><IMG SRC="/images/none.gif" WIDTH="1" HEIGHT="1"></TD><TD WIDTH="60" ALIGN="center" VALIGN="bottom" NOWRAP CLASS="menuinactive"><IMG SRC="/images/arrow_y.gif" WIDTH="7" HEIGHT="7" ALIGN="absmiddle">&nbsp;<A href="/contracts/mem_srv.asp" CLASS="menu">��ͬ</A></TD><TD BGCOLOR="#333333" WIDTH="1" VALIGN="bottom"><IMG SRC="/images/none.gif" WIDTH="1" HEIGHT="1"></TD><TD BGCOLOR="#CCCCCC" WIDTH="1" VALIGN="bottom"><IMG SRC="/images/none.gif" WIDTH="1" HEIGHT="1"></TD><TD WIDTH="60" ALIGN="center" VALIGN="bottom" NOWRAP CLASS="menuinactive">&nbsp;<IMG SRC="/images/arrow_y.gif" WIDTH="7" HEIGHT="7" ALIGN="absmiddle">&nbsp;<A href="/index.asp" CLASS="menu">�˳�</A></TD><TD BGCOLOR="#333333" WIDTH="1" VALIGN="bottom"><IMG SRC="/images/none.gif" WIDTH="1" HEIGHT="1"></TD><TD BGCOLOR="#CCCCCC" WIDTH="1" VALIGN="bottom"><IMG SRC="/images/none.gif" WIDTH="1" HEIGHT="1"></TD><TD NOWRAP CLASS="menuinactive"><IMG SRC="/images/pic_help.gif" WIDTH="12" HEIGHT="12" HSPACE="8"></TD></TR></TABLE></TD><TD WIDTH="10" CLASS="menuinactive"></TD></TR><TR> <TD BGCOLOR="#333333" COLSPAN="3"><IMG SRC="/images/none.gif" WIDTH="1" HEIGHT="1"></TD></TR></TABLE><TABLE WIDTH="100%" BORDER="0" CELLSPACING="0" CELLPADDING="0"><TR> <TD WIDTH="150" VALIGN="BOTTOM">&nbsp;&nbsp;<script language="javascript"><!--
var strHomepage="";if("/" + strHomepage==window.parent.location.pathname){document.write("<A HREF=\"javascript:;\" ONCLICK=\"open('/user_homepage_update.asp?status=Cancel&url=/index_rec.asp','','toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=no,width=200,height=100,left='+(window.screen.availWidth-200)/2+',top='+(window.screen.availHeight-100)/2)\">ȡ����ҳ����</A>");}else{document.write("<A HREF=\"javascript:;\" ONCLICK=\"open('/user_homepage_update.asp?url='+window.parent.location.pathname,'','toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=no,width=200,height=100,left='+(window.screen.availWidth-200)/2+',top='+(window.screen.availHeight-100)/2)\">��Ϊϵͳ��ҳ</A>");}//--></script></TD><TD ALIGN="RIGHT"><IMG SRC="/images/img_menu2.gif" WIDTH="18" HEIGHT="18"></TD><TD WIDTH="310" VALIGN="BOTTOM" CLASS="menu2ndbg"> &nbsp;&nbsp;&nbsp;&nbsp;<A href="/sysset/mem_org_manage.asp"  CLASS="menu2">�����</A> <A href="/sysset/mem_user.asp"  CLASS="menu2here">�û�����</A> <A href="/sysset/mem_reg_update.asp"  CLASS="menu2">�޸�ע����Ϣ</A> <A href="/sysset/mem_pwd_update.asp"  CLASS="menu2">�޸�����</A>&nbsp;</TD></TR><TR> <TD VALIGN="BOTTOM"></TD><TD ALIGN="RIGHT"></TD><TD VALIGN="BOTTOM" BGCOLOR="#000000"><IMG SRC="/images/none.gif" WIDTH="100" HEIGHT="1"></TD></TR></TABLE>

    </TD>
  </TR>

  <TR>
  <TR>
    <TD  ALIGN="center" VALIGN="TOP">
      <TABLE WIDTH="700" BORDER="0" CELLSPACING="0" CELLPADDING="5">
        <FORM NAME="frmInsertUser" ACTION="mem_user_add.asp" METHOD="post" onSubmit="javascript:return chkit();">
          <TR VALIGN="BOTTOM">
            <TD HEIGHT="40" COLSPAN="4"><B>�����û�</B></TD>
          </TR>
          <TR>
            <TD COLSPAN="4"><SPAN CLASS="alert">* ������д</SPAN></TD>
          </TR>

          <TR>
            <TD WIDTH="100" ALIGN="RIGHT"><SPAN CLASS="alert">*</SPAN> ����&nbsp;</TD>
            <TD> <INPUT TYPE="text" NAME="txtName" MAXLENGTH="50" VALUE="">
            </TD>
            <TD ALIGN="RIGHT"><SPAN CLASS="alert">* </SPAN>���ڻ�&nbsp;</TD>
            <TD> <SELECT NAME="selOrg" STYLE="width:172px">
                <OPTION VALUE="-1">--��ѡ��--</OPTION><OPTION VALUE="22200100080912">�й���ʯ���ܹ�˾</OPTION><OPTION VALUE="222001000809120001">�й���ʯ�����޹�˾</OPTION><OPTION VALUE="222001000809120021">--�й���ʯ�����޹�˾���ֹ�˾</OPTION><OPTION VALUE="222001000809120022">--�й���ʯ�����޹�˾տ���ֹ�˾</OPTION><OPTION VALUE="222001000809120023">--�й���ʯ�����޹�˾���ڷֹ�˾</OPTION><OPTION VALUE="222001000809120024">--�й���ʯ�����޹�˾�Ϻ��ֹ�˾</OPTION><OPTION VALUE="222001000809120025">--�й���ʯ�����޹�˾�о�����</OPTION><OPTION VALUE="222001000809120007">�к��������ɷ����޹�˾</OPTION><OPTION VALUE="222001000809120008">����ʯ�͹��̹ɷ����޹�˾</OPTION><OPTION VALUE="222001000809120009">�й���ʯ�ͻ�ؼ����������ι�˾</OPTION><OPTION VALUE="222001000809120010">�к�ʵҵ��˾</OPTION><OPTION VALUE="222001000809120011">������˾</OPTION><OPTION VALUE="222001000809120012">������˾</OPTION><OPTION VALUE="222001000809120013">�Ϻ�������˾</OPTION><OPTION VALUE="222001000809120014">�Ϻ����˾</OPTION><OPTION VALUE="222001000809120015">�к�ʯ�ͻ�ѧ���޹�˾</OPTION><OPTION VALUE="222001000809120016">�к�ʯ����Ȼ�����������ι�˾</OPTION><OPTION VALUE="222001000809120017">�к��������ù�˾</OPTION><OPTION VALUE="222001000809120018">����v����Ŀ</OPTION><OPTION VALUE="222001000809120019">�к�����Ͷ���������ι�˾</OPTION><OPTION VALUE="222001000809120020">�к�ʯ�Ͳ����������ι�˾</OPTION>
              </SELECT> </TD>
          </TR>
          <TR>
            <TD ALIGN="RIGHT"><SPAN CLASS="alert">*</SPAN> E-mail&nbsp;</TD>
            <TD> <INPUT TYPE="text" NAME="txtEmail" MAXLENGTH="120" VALUE="">
            </TD>
            <TD ALIGN="RIGHT">�绰&nbsp;</TD>
            <TD> <INPUT TYPE="text" NAME="txtTelephone" MAXLENGTH="40" VALUE="">
            </TD>
          </TR>
          <TR>
            <TD ALIGN="RIGHT">ְλ&nbsp;</TD>
            <TD> <INPUT TYPE="text" NAME="txtWork_Title" MAXLENGTH="60" VALUE="">
            </TD>
            <TD ALIGN="RIGHT">&nbsp;</TD>
            <TD>&nbsp;</TD>
          </TR>
          <TR>
            <TD COLSPAN="4"> <HR SIZE="1"> </TD>
          </TR>
          <TR>
            <TD COLSPAN="4"><SPAN CLASS="alert">*</SPAN> ��Ͻ��</TD>
          </TR>
          <TR>
            <TD>&nbsp; </TD>
            <TD COLSPAN="3"> <INPUT TYPE="hidden" NAME="selCompany" VALUE="">
              <SELECT NAME="selCompanyxx" VALUE="255" STYLE="width:172px">
                <OPTION VALUE="-1">--��ѡ��--</OPTION><OPTION VALUE="22200100080912">�й���ʯ���ܹ�˾</OPTION><OPTION VALUE="222001000809120001">�й���ʯ�����޹�˾</OPTION><OPTION VALUE="222001000809120021">--�й���ʯ�����޹�˾���ֹ�˾</OPTION><OPTION VALUE="222001000809120022">--�й���ʯ�����޹�˾տ���ֹ�˾</OPTION><OPTION VALUE="222001000809120023">--�й���ʯ�����޹�˾���ڷֹ�˾</OPTION><OPTION VALUE="222001000809120024">--�й���ʯ�����޹�˾�Ϻ��ֹ�˾</OPTION><OPTION VALUE="222001000809120025">--�й���ʯ�����޹�˾�о�����</OPTION><OPTION VALUE="222001000809120007">�к��������ɷ����޹�˾</OPTION><OPTION VALUE="222001000809120008">����ʯ�͹��̹ɷ����޹�˾</OPTION><OPTION VALUE="222001000809120009">�й���ʯ�ͻ�ؼ����������ι�˾</OPTION><OPTION VALUE="222001000809120010">�к�ʵҵ��˾</OPTION><OPTION VALUE="222001000809120011">������˾</OPTION><OPTION VALUE="222001000809120012">������˾</OPTION><OPTION VALUE="222001000809120013">�Ϻ�������˾</OPTION><OPTION VALUE="222001000809120014">�Ϻ����˾</OPTION><OPTION VALUE="222001000809120015">�к�ʯ�ͻ�ѧ���޹�˾</OPTION><OPTION VALUE="222001000809120016">�к�ʯ����Ȼ�����������ι�˾</OPTION><OPTION VALUE="222001000809120017">�к��������ù�˾</OPTION><OPTION VALUE="222001000809120018">����v����Ŀ</OPTION><OPTION VALUE="222001000809120019">�к�����Ͷ���������ι�˾</OPTION><OPTION VALUE="222001000809120020">�к�ʯ�Ͳ����������ι�˾</OPTION>
              </SELECT> <SPAN CLASS="note">���û����Զ���ѡ�����Ϣ���в���</SPAN></TD>
          </TR>
          <TR>
            <TD ALIGN="RIGHT">Ȩ��&nbsp;</TD>
            <TD COLSPAN="3">

              <INPUT  id="CHECKBOX" type="CHECKBOX" NAME="chkRights" VALUE="1" onClick="account();" >
              ְλ����
              <INPUT  id="CHECKBOX" type="CHECKBOX" NAME="chkRights" VALUE="2" onClick="account();" >
              �������
              <INPUT  id="CHECKBOX" type="CHECKBOX" NAME="chkRights" VALUE="4" onClick="account();" >
              ӦƸ����
              <INPUT  id="CHECKBOX" type="CHECKBOX" NAME="chkRights" VALUE="8" onClick="account();" >
              ��˾����
              <A HREF="JavaScript:OpenWin('/help/usradd_rights.htm','newwin','scrollbars=no,width=350,height=180');">����</A></TD>
          </TR>
          <TR>
            <TD COLSPAN="4"> <HR SIZE="1"> </TD>
          </TR>
          <TR>
            <TD ALIGN="RIGHT"><SPAN CLASS="alert">*</SPAN> �û���&nbsp;</TD>
            <TD COLSPAN="3"> <INPUT TYPE="text" NAME="txtUserName" MAXLENGTH="20" VALUE="">
              <SPAN CLASS="note">20λ���ڣ���ĸ�����֡��»��ߵ����</SPAN> </TD>
          </TR>
          <TR>
            <TD ALIGN="RIGHT"><SPAN CLASS="alert">*</SPAN> ����&nbsp;</TD>
            <TD COLSPAN="3"> <INPUT TYPE="password" NAME="txtPassWord" MAXLENGTH="12">
              <SPAN CLASS="note">6-12λ</SPAN> </TD>
          </TR>
          <TR>
            <TD ALIGN="RIGHT"><SPAN CLASS="alert">*</SPAN> ȷ������&nbsp;</TD>
            <TD> <INPUT TYPE="password" NAME="txtComfirmPwd" MAXLENGTH="12"> </TD>
            <TD ALIGN="RIGHT">&nbsp;</TD>
            <TD>&nbsp;</TD>
          </TR>
          <TR>
            <TD HEIGHT="50" COLSPAN="4" ALIGN="CENTER"> <INPUT TYPE="hidden" NAME="hiddenCount" VALUE="">
              <INPUT TYPE="hidden" NAME="hiddenSubmit" VALUE="1"> <INPUT NAME="imageField32" TYPE="image" SRC="/images/btn_sure.gif" WIDTH="60" HEIGHT="21" BORDER="0">
              &nbsp;
              <!--<INPUT name="imageField6" type="image" SRC="/images/btn_cancel.gif" width="60" height="21" border="0">-->
              <A HREF="javascript:frmInsertUser.reset();"><IMG NAME="imageField6" SRC="/images/btn_cancel.gif" WIDTH="60" HEIGHT="21" BORDER="0"></A>
            </TD>
          </TR>
        </FORM>
      </TABLE>
      <br/>
    </TD>
  </TR>
  <TR>
    <TD VALIGN="bottom" HEIGHT="50">
      <TABLE width="100%" border="0" cellpadding="0" cellspacing="0">
  <TR>
    <TD align="center" height="20" class="note">&nbsp;</TD>
  </TR>
  <TR>
    <TD align="center" class="bottomstyle" height="20">&copy; ��Ƹ�� ��Ȩ���� </TD>
  </TR>
</TABLE>

    </TD>
  </TR>
</TABLE>
</BODY>

</html>

