<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>


<html>
<head>
<TITLE>ChinaHR.com 智聘系统·职位模板</TITLE>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=UTF-8">
<LINK REL="stylesheet" href="/tea/CssJs/default.css" TYPE="text/css">
<SCRIPT language="javascript" SRC="/tea/CssJs/validate.js"></SCRIPT>
<SCRIPT language="javascript">
function goAdd()
{
  window.navigate('job_template_add.asp');
  return false;
}

function selAll(objAll)
{
  var frm = document.form1;

  CheckAll(frm.chkTemplateId, objAll);
  try
  {
    for(var i=0;i<frm.chkAll.length;i++)
      frm.chkAll[i].checked = objAll.checked;
  }
  catch(e)
  {
    //Do Nothing
  }
}

function del()
{
  var frm = document.form1;
  frm.hdnTodo.value = 'delete';

  if(ConfirmDelete(frm.chkTemplateId,'职位模板'))
  {
    return true;
  }
  else
    return false;
}
</SCRIPT>
</head>

<BODY LEFTMARGIN="0" TOPMARGIN="0">
<TABLE WIDTH="100%" BORDER="0" CELLSPACING="0" CELLPADDING="0" HEIGHT="100%" CLASS="bodystyle">
  <TR>    <TD HEIGHT="50" VALIGN="top">
      <TABLE WIDTH="100%" BORDER="0" CELLPADDING="0" CELLSPACING="0" HEIGHT="20"><TR><TD CLASS="menuinactive" VALIGN="bottom"> <TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0" HEIGHT="20"><TR><TD BGCOLOR="#CCCCCC"><IMG SRC="/images/none.gif" WIDTH="1" HEIGHT="1"></TD><TD WIDTH="130" ALIGN="CENTER" VALIGN="bottom" NOWRAP CLASS="menuinactive"><IMG SRC="/images/arrow_y.gif" WIDTH="7" HEIGHT="7" ALIGN="absmiddle">&nbsp;<A href="/index_rec.asp" CLASS="menu">智聘系统首页</A></TD><TD ALIGN="CENTER" VALIGN="bottom" BGCOLOR="#333333"><IMG SRC="/images/none.gif" WIDTH="1" HEIGHT="1"></TD><TD ALIGN="CENTER" VALIGN="bottom" BGCOLOR="#CCCCCC"><IMG SRC="/images/none.gif" WIDTH="1" HEIGHT="1"></TD><TD WIDTH="100" ALIGN="CENTER" VALIGN="bottom" NOWRAP CLASS="menuactive"><IMG SRC="/images/arrow_w.gif" WIDTH="7" HEIGHT="7" ALIGN="absmiddle">&nbsp;<A href="/jobs/job_manage.asp" CLASS="menu">招聘管理</A></TD><TD ALIGN="CENTER" VALIGN="bottom" BGCOLOR="#333333"><IMG SRC="/images/none.gif" WIDTH="1" HEIGHT="1"></TD><TD ALIGN="CENTER" VALIGN="bottom" BGCOLOR="#CCCCCC"><IMG SRC="/images/none.gif" WIDTH="1" HEIGHT="1"></TD><TD WIDTH="100" ALIGN="CENTER" VALIGN="bottom" NOWRAP CLASS="menuinactive"><IMG SRC="/images/arrow_y.gif" WIDTH="7" HEIGHT="7" ALIGN="absmiddle">&nbsp;<A href="/cv_center/cv_search_chr.asp" CLASS="menu">简历查询</A></TD><TD BGCOLOR="#333333" VALIGN="bottom"><IMG SRC="/images/none.gif" WIDTH="1" HEIGHT="1"></TD><TD BGCOLOR="#CCCCCC" VALIGN="bottom"><IMG SRC="/images/none.gif" WIDTH="1" HEIGHT="1"></TD></TR></TABLE></TD><TD CLASS="menuinactive" ALIGN="right" VALIGN="bottom"> <TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0" HEIGHT="20"><TR><TD BGCOLOR="#333333" WIDTH="1" VALIGN="bottom"><IMG SRC="/images/none.gif" WIDTH="1" HEIGHT="1"></TD><TD BGCOLOR="#CCCCCC" WIDTH="1" VALIGN="bottom"><IMG SRC="/images/none.gif" WIDTH="1" HEIGHT="1"></TD><TD WIDTH="60" ALIGN="center" VALIGN="bottom" NOWRAP CLASS="menuinactive"><IMG SRC="/images/arrow_y.gif" WIDTH="7" HEIGHT="7" ALIGN="absmiddle">&nbsp;<A href="/sysset/mem_org_manage.asp" CLASS="menu">设置</A></TD><TD BGCOLOR="#333333" WIDTH="1" VALIGN="bottom"><IMG SRC="/images/none.gif" WIDTH="1" HEIGHT="1"></TD><TD BGCOLOR="#CCCCCC" WIDTH="1" VALIGN="bottom"><IMG SRC="/images/none.gif" WIDTH="1" HEIGHT="1"></TD><TD WIDTH="60" ALIGN="center" VALIGN="bottom" NOWRAP CLASS="menuinactive"><IMG SRC="/images/arrow_y.gif" WIDTH="7" HEIGHT="7" ALIGN="absmiddle">&nbsp;<A href="/contracts/mem_srv.asp" CLASS="menu">合同</A></TD><TD BGCOLOR="#333333" WIDTH="1" VALIGN="bottom"><IMG SRC="/images/none.gif" WIDTH="1" HEIGHT="1"></TD><TD BGCOLOR="#CCCCCC" WIDTH="1" VALIGN="bottom"><IMG SRC="/images/none.gif" WIDTH="1" HEIGHT="1"></TD><TD WIDTH="60" ALIGN="center" VALIGN="bottom" NOWRAP CLASS="menuinactive">&nbsp;<IMG SRC="/images/arrow_y.gif" WIDTH="7" HEIGHT="7" ALIGN="absmiddle">&nbsp;<A href="/index.asp" CLASS="menu">退出</A></TD><TD BGCOLOR="#333333" WIDTH="1" VALIGN="bottom"><IMG SRC="/images/none.gif" WIDTH="1" HEIGHT="1"></TD><TD BGCOLOR="#CCCCCC" WIDTH="1" VALIGN="bottom"><IMG SRC="/images/none.gif" WIDTH="1" HEIGHT="1"></TD><TD NOWRAP CLASS="menuinactive"><IMG SRC="/images/pic_help.gif" WIDTH="12" HEIGHT="12" HSPACE="8"></TD></TR></TABLE></TD><TD WIDTH="10" CLASS="menuinactive"></TD></TR><TR> <TD BGCOLOR="#333333" COLSPAN="3"><IMG SRC="/images/none.gif" WIDTH="1" HEIGHT="1"></TD></TR></TABLE>
<TABLE WIDTH="100%" BORDER="0" CELLPADDING="0" CELLSPACING="0">
  <TR>
    <TD WIDTH="118" VALIGN="BOTTOM" NOWRAP>&nbsp;&nbsp;

	<SCRIPT language="javascript">
	    <!--
		    var strHomepage="";
			//alert(strHomepage + window.parent.location.pathname);
			if("/" + strHomepage==window.parent.location.pathname){
			    document.write("<A HREF=\"javascript:;\" ONCLICK=\"open('/user_homepage_update.asp?status=Cancel&url=/index_rec.asp','','toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=no,width=200,height=100,left='+(window.screen.availWidth-200)/2+',top='+(window.screen.availHeight-100)/2)\">取消首页设置</A>");
			}else{
			    document.write("<A HREF=\"javascript:;\" ONCLICK=\"open('/user_homepage_update.asp?url='+window.parent.location.pathname,'','toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=no,width=200,height=100,left='+(window.screen.availWidth-200)/2+',top='+(window.screen.availHeight-100)/2)\">设为系统首页</A>");
			}
		//-->
	</SCRIPT>
	</TD>
    <TD WIDTH="18" ALIGN="RIGHT"><IMG SRC="/images/img_menu2.gif" WIDTH="18" HEIGHT="18"></TD>
    <TD VALIGN="BOTTOM" CLASS="menu2ndbg">&nbsp;&nbsp;&nbsp;&nbsp;<A href="/jobs/job_manage.asp" CLASS="menu2">职位管理</A>
      &middot; <A href="/jobs/job_add.asp" CLASS="menu2">新增职位</A>
      &middot; <A href="/jobs/job_template.asp" CLASS="menu2here">职位模板</A>
      <!--&middot; <A href="/jobs/job_trash.asp" CLASS="menu2">职位回收站</A> -->
      &middot; <A href="/jobs/apply_cv_list.asp" CLASS="menu2">应聘简历</A>
      &middot; <A href="/jobs/apply_stat.asp" CLASS="menu2">应聘统计</A>
      <!--&middot; <A href="/jobs/apply_cvfilter.asp" CLASS="menu2">简历过滤器</A>-->
      &nbsp; </TD>
  </TR>
  <TR>
    <TD VALIGN="BOTTOM"></TD>
    <TD ALIGN="RIGHT"></TD>
    <TD VALIGN="BOTTOM" BGCOLOR="#000000"><IMG SRC="/images/none.gif" WIDTH="100" HEIGHT="1"></TD>
  </TR>
</TABLE>

    </TD>
  </TR>
  <TR>
    <TD VALIGN="top" ALIGN="center">
      <TABLE WIDTH="95%" BORDER="0" CELLSPACING="0" CELLPADDING="5">
	  <TR>
          <TD>

            <br/>
<FONT CLASS=note>如果要发布的多个职位有相似的职位信息，你可以建立职位模板，新增职位时只需调出模板稍加修改即可发布，而不必重复输入相同的内容。</FONT>

			</TD>
        </TR>

        <FORM NAME="form1" METHOD="post" ACTION="job_template.asp">
          <INPUT TYPE="hidden" NAME="hdnTodo" VALUE="">
          <TR>
            <TD>
              <TABLE WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="2" CLASS="tblstyle">
                <TR>
                  <TD WIDTH="20" CLASS="TblTitleStyle">
                    <INPUT  id="CHECKBOX" type="CHECKBOX" NAME="chkAll" onClick="selAll(this);">
                  </TD>
                  <TD NOWRAP CLASS="TblTitleStyle">模板名称</TD><TD NOWRAP CLASS="TblTitleStyle">职位名称</TD><TD NOWRAP CLASS="TblTitleStyle">所属机构</TD><TD NOWRAP CLASS="TblTitleStyle">职业类别</TD><TD NOWRAP CLASS="TblTitleStyle">工作地区</TD>
                  <TD NOWRAP CLASS="TblTitleStyle">操作</TD>
                </TR>
                <TR><TD CLASS="TblTrStyle" ALIGN="center"><INPUT  id="CHECKBOX" type="CHECKBOX" NAME="chkTemplateId" VALUE="44530"></TD><TD CLASS="TblTrStyle">健康安全环保类</TD><TD CLASS="TblTrStyle">HSE分析员</TD><TD CLASS="TblTrStyle">中国海洋石油有限公司深圳分公司</TD><TD CLASS="TblTrStyle">安全消防</TD><TD CLASS="TblTrStyle">深圳</TD><TD CLASS="TblTrStyle" ALIGN="CENTER"><A HREF="job_template_update.asp?template_id=44530">修改</A></TD></TR><TR><TD CLASS="TblTrStyle" ALIGN="center"><INPUT  id="CHECKBOX" type="CHECKBOX" NAME="chkTemplateId" VALUE="44588"></TD><TD CLASS="TblTrStyle">秘书</TD><TD CLASS="TblTrStyle">投资者关系高级分析员兼CFO秘书</TD><TD CLASS="TblTrStyle">中国海洋石油有限公司</TD><TD CLASS="TblTrStyle">部门助理/秘书/文员、CFO/财务总监/经理</TD><TD CLASS="TblTrStyle">北京</TD><TD CLASS="TblTrStyle" ALIGN="CENTER"><A HREF="job_template_update.asp?template_id=44588">修改</A></TD></TR>
              </TABLE>
              <TABLE WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="2" HEIGHT="40">
                <TR>
                  <TD WIDTH="20">
                    <INPUT  id="CHECKBOX" type="CHECKBOX" NAME="chkAll" onClick="selAll(this);">
                  </TD>
                  <TD>全部选中 </TD>
                </TR>
              </TABLE>
            </TD>
          </TR>
          <TR>
            <TD ALIGN="center">

              <INPUT TYPE="image" NAME="btnAdd" VALUE="新增职位模板" onClick="return goAdd();" SRC="/images/btn_addtemplet.gif" WIDTH="102" HEIGHT="21">

              &nbsp;
              <INPUT TYPE="image" BORDER="0" NAME="btnDelete" SRC="/images/btn_del.gif" WIDTH="60" HEIGHT="21" onClick="return del();">
            </TD>
          </TR>
        </FORM>

      </TABLE>
    </TD>
  </TR>
  <TR>
    <TD VALIGN="bottom" HEIGHT="50">
      <TABLE width="100%" border="0" cellpadding="0" cellspacing="0">
  <TR>
    <TD align="center" height="20" class="note">&nbsp;</TD>
  </TR>
  <TR>
    <TD align="center" class="bottomstyle" height="20">&copy; 招聘网 版权所有 </TD>
  </TR>
</TABLE>

    </TD>
  </TR>
</TABLE>
</BODY>
</html>

