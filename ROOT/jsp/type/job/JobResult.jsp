<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>

<html>
<head>
<TITLE>ChinaHR.com 智聘系统·应聘简历</TITLE>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=UTF-8">
<LINK href="/tea/CssJs/default.css" REL="stylesheet" TYPE="text/css">
<SCRIPT language="javascript" SRC="/tea/CssJs/validate.js"></SCRIPT>
<SCRIPT language=JavaScript>
<!--
//使用一个变量控制重复操作
var blActionFlag;

blActionFlag = false;

var isSure;
function tt()
{
	parent.window.mainFrm.cols = '220,*';
}

function showFrame()
{
	document.all['showBtn'].style.display = 'none';
	setTimeout('tt()',100);
}

function leon()
{
	if (parent.window.mainFrm.cols == '0,*')
	{
		document.all['showBtn'].style.display = '';
	}
	else
	{
		document.all['showBtn'].style.display = 'none';
	}
}
function OpenWin(theURL,winName,features)
  {
    window.open(theURL,winName,features);
  }
function changeCol(val)
{
  var frm=document.form1;
  var obj;
  var strCol;

  strCol = '';

  for (var i = 0; i < 4; i++)
  {
    obj = document.getElementById('sltCol' + i);
    strCol += '#' + obj.value;

    document.getElementById('sltCol' + i).disabled = true;
  }

  strCol = strCol.substring(1, strCol.length);
  frm.HidColSel.value = strCol;

  frm.submit();
}

var initVal=true;
/*function selAll()
{
  for(var i=0;i<document.form1.length;i++)
  {
    if(document.form1[i].name=="chk_id")
    {

      document.form1[i].checked=initVal;
    }
  }
  initVal=!initVal;
}*/
//--- 修改 ---
function selAll()
{
  for(var i=0;i<document.form1.length;i++)
  {
    if(document.form1[i].name=="chk_id")
    {

      document.form1[i].checked=initVal;
    }
  }
  for(i=0;i<document.form1.chkSelAll.length;i++) {
    document.form1.chkSelAll[i].checked = initVal;
  }
  initVal=!initVal;
}
//--- 结束 ---
function Sort()
{

  form1.HidSortItem.value='job_title';
  form1.hidSortFlag.value = 'true';

  form1.submit();
}

function toDel()
{
  if (blActionFlag == true)
  {
    window.alert('操作正在进行，请稍候！');

    return false;
  }

  if(checkSel())
  {
    if(confirm('简历将被永久删除。确定要删除吗？'))
    {
      form1.hidCvDelFlag.value='true';
      blActionFlag = true;

      form1.submit();
    }
    else
      return false;
  }
  else
  {
    alert("请选择要删除的简历！");
    return false;
  }
}
function doOp(val)
{
  if(checkSel())
  {
    if(val == 'apply2my')
    {
		if (blActionFlag == true)
		{
		  window.alert('操作正在进行，请稍候！');

		  return false;
		}

	    if(confirm("转入“我的人才库”的简历不能在“应聘简历”中查询。确定转入“我的人才库”吗？"))
	    {
	        form1.hidMoveFlag.value='true';
	        blActionFlag = true;

		    form1.submit();
		}
	}
	else
	{
        form1.submit();
	}
  }
  else
  {
    alert("请选择要转入的简历！");
    return false;
  }
}
function checkSel()
{
  for(var i=0;i<document.form1.length;i++)
  {
    if(document.form1[i].name=="chk_id" && document.form1[i].checked) return true;
  }
  return false;
}
function fwd()
{
  strIds=getIds();
  if(strIds!='')
  {
    OpenWin('/jobs/apply_cv_fw.asp?ids='+strIds,'newwin','scrollbars=no,width=560,height=340');
    //window.open('/jobs/apply_cv_fw.asp?ids='+strIds,'newwin');
  }
  else
  {
    alert("请选择要转发的简历！");
    return false;
  }
}
function toOrg()
{
  strIds=getIds();
  if(strIds!='')
  {
    OpenWin('/jobs/apply_cv_putjob.asp?ids='+strIds,'newwin','scrollbars=no,width=480,height=190');
  }
  else
  {
    alert("请选择要推荐的简历！");
    return false;
  }
}
function sendMail()
{
  strIds=getIds();
  if(strIds!='')
  {
    OpenWin('/jobs/apply_cv_sendmail.asp?ids='+strIds,'newwin','scrollbars=no,width=550,height=290');
  }
  else
  {
    alert("请选择要发信的简历！");
    return false;
  }
}
function toPrint()
{
  strIds=getIds();
  if(strIds!='')
  {
    window.open('apply_cv_detail.asp?opType=print&ids='+strIds);
  }
  else
  {
    alert("你没有选中任何简历！");
    return false;
  }
}
function toExport(intJobState, intLanguage)
{
  strIds=getIds();
  if(strIds!='')
  {
    OpenWin('/jobs/apply_cv_export.asp?Language=' + intLanguage + '&ids='+strIds + '&JobState=' + intJobState,'newwin','scrollbars=no,width=450,height=200');
    //window.open('/jobs/apply_cv_export.asp?ids='+strIds + '&JobState=' + intJobState,'newwin');
  }
  else
  {
    alert("请选择要导出的简历！");
    return false;
  }
}
function view()
{
  strIds=getIds();
  if(strIds!='')
  {
    window.open('apply_cv_detail.asp?ids='+strIds);
  }
  else
  {
    alert("请选择要查看的简历！");
    return false;
  }
}
function getIds()
{
  strIds = new String;
  for(var i=0;i<document.form1.length;i++)
  {
    if(document.form1[i].name=='chk_id' && document.form1[i].checked) strIds+=','+document.form1[i].value;
  }
  return strIds;
}

function go(pageNum)
{
  form1.PageNum.value=pageNum;
  form1.submit();
}
function dgo(Num)
{
  //--- 有效性检查 ---
  var objPage
  objPage = form1.all["txtPageNo"+Num];
  if((Trim(objPage.value).length==0) || (isNaN(objPage.value)) || (parseInt(objPage.value)<=0))
  {
    alert("请填写正确的页码！");
    objPage.select();
    return false;
  }
  //--- 结束 ---
  form1.PageNum.value=form1.all["txtPageNo"+Num].value;
  form1.submit();
  return false;
}
//-->
</SCRIPT>
</head>
<BODY LEFTMARGIN="0" TOPMARGIN="0" CLASS="bodystyle">
<TABLE WIDTH="100%" BORDER="0" CELLSPACING="0" CELLPADDING="0" HEIGHT="100%" CLASS="bodystyle">
  <TR>
    <TD VALIGN="top" HEIGHT="50">
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
      &middot; <A href="/jobs/job_template.asp" CLASS="menu2">职位模板</A>
      <!--&middot; <A href="/jobs/job_trash.asp" CLASS="menu2">职位回收站</A> -->
      &middot; <A href="/jobs/apply_cv_list.asp" CLASS="menu2here">应聘简历</A>
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
    <TD VALIGN="top" ALIGN="center"><FORM NAME="form1" METHOD="post" ACTION="">
        <TABLE WIDTH="95%" BORDER="0" CELLPADDING="2" CELLSPACING="1">
          <TR>
            <TD HEIGHT="20">现有 <SPAN CLASS="alert">112</SPAN> 人应聘。点击“应聘职位”可排序。你还可以 <a href="/jobs/apply_cv_search_e.asp">按条件查询应聘简历</a> 。</TD>
            <TD ALIGN="RIGHT">
              第1/6页 &nbsp;上页&nbsp;<A HREF="JavaScript: go(2);">下页</A>
              <INPUT NAME="txtPageNo1" TYPE="text" SIZE="3" MAXLENGTH="3" onkeydown="javascript:if (event.keyCode == 13) { dgo('1');return false;}">
              页
              <INPUT NAME="imageField1" TYPE="image" SRC="/images/btn_go.gif" ALIGN="TOP" WIDTH="30"
                HEIGHT="21" BORDER="0" onClick="JavaScript: dgo('1');return false;"></TD>
          </TR>
        </TABLE>
        <TABLE WIDTH="95%" BORDER="0" CELLPADDING="2" CELLSPACING="1" CLASS="tblstyle">
          <TR CLASS="TblTitleStyle">
            <TD WIDTH="20"> <INPUT  id="CHECKBOX" type="CHECKBOX" NAME="chkSelAll" VALUE="checkbox" onClick="JavaScript: selAll();">
            </TD>
            <TD ALIGN="center" NOWRAP>姓名</TD>
            <TD> <DIV ALIGN="center"><A HREF="JavaScript: Sort();">应聘职位</A>

              </DIV></TD>
            <TD><DIV align="center"><SELECT id="sltCol0" name="sltCol0" ONCHANGE="JavaScript: changeCol('0');"><OPTION VALUE="PositionNameCN,PositionNameEN" SELECTED>现职位</OPTION><OPTION VALUE="contact_type1,contact_no1">联系方式</OPTION><OPTION VALUE="Degree">学历</OPTION><OPTION VALUE="ExpectSalaryType,ExpectSalaryClass,ExpectSalarySum">期望薪水</OPTION><OPTION VALUE="birthday">年龄</OPTION><OPTION VALUE="gender">性别</OPTION><OPTION VALUE="0 AS ExpectState,0 AS ExpectCity">期望地区</OPTION><OPTION VALUE="langType1,langType2,langType3">语言</OPTION><OPTION VALUE="SchoolNameCN,SchoolNameEn">毕业院校</OPTION><OPTION VALUE="MajorNameCN,MajorNameEN">专业</OPTION><OPTION VALUE="HukouState,HukouCity">户口</OPTION></SELECT></DIV></TD><TD><DIV align="center"><SELECT id="sltCol1" name="sltCol1" ONCHANGE="JavaScript: changeCol('1');"><OPTION VALUE="ResidenceState,ResidenceCity,CurrStateInputCN,CurrStateInputEN" SELECTED>现地区</OPTION><OPTION VALUE="contact_type1,contact_no1">联系方式</OPTION><OPTION VALUE="Degree">学历</OPTION><OPTION VALUE="ExpectSalaryType,ExpectSalaryClass,ExpectSalarySum">期望薪水</OPTION><OPTION VALUE="birthday">年龄</OPTION><OPTION VALUE="gender">性别</OPTION><OPTION VALUE="0 AS ExpectState,0 AS ExpectCity">期望地区</OPTION><OPTION VALUE="langType1,langType2,langType3">语言</OPTION><OPTION VALUE="SchoolNameCN,SchoolNameEn">毕业院校</OPTION><OPTION VALUE="MajorNameCN,MajorNameEN">专业</OPTION><OPTION VALUE="HukouState,HukouCity">户口</OPTION></SELECT></DIV></TD><TD><DIV align="center"><SELECT id="sltCol2" name="sltCol2" ONCHANGE="JavaScript: changeCol('2');"><OPTION VALUE="experience" SELECTED>工作经验</OPTION><OPTION VALUE="contact_type1,contact_no1">联系方式</OPTION><OPTION VALUE="Degree">学历</OPTION><OPTION VALUE="ExpectSalaryType,ExpectSalaryClass,ExpectSalarySum">期望薪水</OPTION><OPTION VALUE="birthday">年龄</OPTION><OPTION VALUE="gender">性别</OPTION><OPTION VALUE="0 AS ExpectState,0 AS ExpectCity">期望地区</OPTION><OPTION VALUE="langType1,langType2,langType3">语言</OPTION><OPTION VALUE="SchoolNameCN,SchoolNameEn">毕业院校</OPTION><OPTION VALUE="MajorNameCN,MajorNameEN">专业</OPTION><OPTION VALUE="HukouState,HukouCity">户口</OPTION></SELECT></DIV></TD><TD><DIV align="center"><SELECT id="sltCol3" name="sltCol3" ONCHANGE="JavaScript: changeCol('3');"><OPTION VALUE="0 AS apply_date1" SELECTED>投递时间</OPTION><OPTION VALUE="contact_type1,contact_no1">联系方式</OPTION><OPTION VALUE="Degree">学历</OPTION><OPTION VALUE="ExpectSalaryType,ExpectSalaryClass,ExpectSalarySum">期望薪水</OPTION><OPTION VALUE="birthday">年龄</OPTION><OPTION VALUE="gender">性别</OPTION><OPTION VALUE="0 AS ExpectState,0 AS ExpectCity">期望地区</OPTION><OPTION VALUE="langType1,langType2,langType3">语言</OPTION><OPTION VALUE="SchoolNameCN,SchoolNameEn">毕业院校</OPTION><OPTION VALUE="MajorNameCN,MajorNameEN">专业</OPTION><OPTION VALUE="HukouState,HukouCity">户口</OPTION></SELECT></DIV></TD></TR>
<%
//if(request.getParameter("Node")!=null)
int nodecode=teasession._nNode;
java.util.Enumeration enumeration=Apply.findByNode(nodecode);
while(enumeration.hasMoreElements()){
    Apply apply=Apply.find(nodecode,enumeration.nextElement().toString());
%>
<TR CLASS="TblTrStyle"><TD><INPUT  id="CHECKBOX" type="CHECKBOX" NAME="chk_id" VALUE="14423069"></TD>
    <TD><A href="/jsp/type/resume/Preview.jsp?member=<%=apply.getMember()%>" TARGET="_BLANK"><%=apply.getMember()%></A></TD>
    <TD>信息及管理制度高级主管</TD>
    <TD>总裁助理</TD>
    <TD>北京</TD>
    <TD>2 年</TD>
    <TD><%=apply.getAppDate("yyyy-MM-dd")%></TD></TR>
   <% }%>
        </TABLE>
        <TABLE WIDTH="95%" BORDER="0" CELLPADDING="2" CELLSPACING="1">
          <TR>
            <TD WIDTH="20" ALIGN="CENTER"><INPUT  id="CHECKBOX" type="CHECKBOX" NAME="chkSelAll" VALUE="checkbox"  onClick="JavaScript: selAll();"></TD>
            <TD> 全部选中</TD>
            <TD ALIGN="RIGHT">
              第1/6页 &nbsp;上页&nbsp;<A HREF="JavaScript: go(2);">下页</A>
              <INPUT NAME="txtPageNo2" TYPE="text" SIZE="3" MAXLENGTH="3" onkeydown="javascript:if (event.keyCode == 13) { dgo('2');return false;}">
              页
              <INPUT NAME="imageField2" TYPE="image" SRC="/images/btn_go.gif" ALIGN="TOP" WIDTH="30"
                HEIGHT="21" BORDER="0" onClick="JavaScript: dgo('2');return false;"></TD>
          </TR>
        </TABLE>
        <TABLE WIDTH="95%" BORDER="0" CELLPADDING="0" CELLSPACING="0">
          <TR>
            <TD ALIGN="CENTER"><br/> <INPUT NAME="imageField3" TYPE="image" SRC="/images/btn_view.gif" BORDER="0" onClick="JavaScript: view();return false;">
              &nbsp; <INPUT NAME="imageField4" TYPE="image" SRC="/images/btn_mail.gif" BORDER="0" onClick="JavaScript:sendMail(); return false;">
              &nbsp; <INPUT NAME="imageField82" TYPE="image" SRC="/images/btn_export.gif" BORDER="0" onClick="JavaScript:toExport(1, 2); return false;">
              &nbsp; <INPUT NAME="imgDel" TYPE="image" SRC="/images/btn_del.gif" BORDER="0" onClick="JavaScript:toDel();;return false;"><br/>
              &nbsp;

			  <INPUT NAME="imageField5" TYPE="image" SRC="/images/btn_saveto.gif" BORDER="0" onClick="JavaScript: doOp('apply2my');return false;//window.parent.navigate('/cv_center/cv_search_my_list.asp');//return false;"  VSPACE="8">
              &nbsp;

			  <INPUT NAME="imageField6" TYPE="image" SRC="/images/btn_forward.gif" BORDER="0" onClick="JavaScript:fwd(); return false;" VSPACE="8">
              &nbsp; <INPUT NAME="imageField7" TYPE="image" SRC="/images/btn_commend.gif" BORDER="0" onClick="JavaScript:toOrg(); return false;" VSPACE="8">
              &nbsp;<br/>
              <!--<INPUT NAME="imageField8" TYPE="image" SRC="/images/btn_print.gif" WIDTH="60" HEIGHT="21" BORDER="0" OnClick="JavaScript: toPrint();return false;">-->

              <br/> </TD>
          </TR>
        </TABLE>
        <TABLE WIDTH="700" BORDER="0" CELLSPACING="1" CELLPADDING="0">
          <TR>
            <TD WIDTH="380"> <br/>
              <TABLE WIDTH="120" BORDER="0" CELLSPACING="0" CELLPADDING="0">
                <TR BGCOLOR="#FF6600">
                  <TD BGCOLOR="#FF6600" VALIGN="top" WIDTH="5"><IMG SRC="/images/pic_corner7.gif" WIDTH="3" HEIGHT="3"></TD>
                  <TD HEIGHT="16" VALIGN="bottom"><IMG SRC="/images/arrow_white.gif" WIDTH="3" HEIGHT="5" ALIGN="absmiddle">
                    <FONT COLOR="#FFFFFF">应聘简历说明</FONT></TD>
                  <TD ALIGN="right" VALIGN="top" WIDTH="5"><IMG SRC="/images/pic_corner9.gif" WIDTH="3" HEIGHT="3"></TD>
                </TR>
              </TABLE>
            </TD>
          </TR>
          <TR BGCOLOR="#EEEEEE">
            <TD ALIGN="center" VALIGN="top" STYLE="padding-top:5px;padding-bottom:5px">
              <TABLE WIDTH="98%" BORDER="0" CELLSPACING="0" CELLPADDING="3">

                  <TR>
                    <TD VALIGN="TOP"><IMG SRC="/images/arrow_red.gif" WIDTH="3" HEIGHT="5" VSPACE="3" ALIGN="absmiddle"></TD>
                    <TD>说明：标有 <IMG SRC="/images/en.gif" BORDER="0" ALIGN="ABSMIDDLE"> 的简历附有英文简历。</TD>
                  </TR>

                <TR>
                  <TD VALIGN="TOP"><IMG SRC="/images/arrow_red.gif" WIDTH="3" HEIGHT="5" VSPACE="3" ALIGN="absmiddle"></TD>
                  <TD> 查看：你可以选择多份简历，集中查看和打印。</TD>
                </TR>
                <TR>
                  <TD VALIGN="TOP"><IMG SRC="/images/arrow_red.gif" WIDTH="3" HEIGHT="5" VSPACE="3" ALIGN="absmiddle"></TD>
                  <TD>发信给候选人：选择应聘者，给他们发信。可以感谢其应聘或通知面试。</TD>
                </TR>
                <TR>
                  <TD VALIGN="TOP"><IMG SRC="/images/arrow_red.gif" WIDTH="3" HEIGHT="5" VSPACE="3" ALIGN="absmiddle"></TD>
                  <TD>导出：将简历压缩为winzip格式，下载解压后即可浏览html格式的简历。</TD>
                </TR>
                <TR>
                  <TD VALIGN="TOP"><IMG SRC="/images/arrow_red.gif" WIDTH="3" HEIGHT="5" VSPACE="3" ALIGN="absmiddle"></TD>
                  <TD>转入我的人才库：将有价值的简历保存在<A href="/cv_center/cv_search_my.asp">我的人才库</A>，长期储备，随时查询。</TD>
                </TR>
                <TR>
                  <TD VALIGN="TOP"><IMG SRC="/images/arrow_red.gif" WIDTH="3" HEIGHT="5" VSPACE="3" ALIGN="absmiddle"></TD>
                  <TD>发送到邮箱：将简历转发到指定的E-mail邮箱。</TD>
                </TR>
                <TR>
                  <TD VALIGN="TOP"><IMG SRC="/images/arrow_red.gif" WIDTH="3" HEIGHT="5" VSPACE="3" ALIGN="absmiddle"></TD>
                  <TD>推荐：如果某个应聘者更适合其他招聘中的职位，你可以将简历推荐给该职位。</TD>
                </TR>
              </TABLE>
            </TD>
           </TR>

          </TR>
        </TABLE>

      <INPUT TYPE="HIDDEN" NAME="PageNum" VALUE="1">
      <INPUT TYPE="HIDDEN" NAME="HidSortDirect" VALUE="">
      <INPUT TYPE="HIDDEN" NAME="HidSortItem" VALUE="">
      <INPUT TYPE="HIDDEN" NAME="HidOpType" VALUE="">
      <INPUT TYPE="HIDDEN" NAME="HidIsAlert" VALUE="">
      <INPUT TYPE="HIDDEN" NAME="HidColNum" VALUE="">
      <INPUT TYPE="HIDDEN" NAME="HidColSel" VALUE="PositionNameCN,PositionNameEN#ResidenceState,ResidenceCity,CurrStateInputCN,CurrStateInputEN#experience#0 AS apply_date1">

      <INPUT TYPE="HIDDEN" NAME="HidAutoNumber" VALUE="">
      <INPUT TYPE="HIDDEN" NAME="hidCvDelFlag" VALUE="">
      <INPUT TYPE="HIDDEN" NAME="hidSortFlag" VALUE="">
      <INPUT TYPE="HIDDEN" NAME="hidMoveFlag" VALUE="">

      <INPUT TYPE="HIDDEN" NAME="rdoJobState" VALUE="">
      <INPUT TYPE="HIDDEN" NAME="sltOrgId" VALUE="">
      <INPUT TYPE="HIDDEN" NAME="sltJobId" VALUE="">
      <INPUT TYPE="HIDDEN" NAME="sltCurrIndId" VALUE="">
      <INPUT TYPE="HIDDEN" NAME="sltCurrOccId" VALUE="">
      <INPUT TYPE="HIDDEN" NAME="sltCurrOccLevelId" VALUE="">
      <INPUT TYPE="HIDDEN" NAME="sltCurrCctgrId" VALUE="">
      <INPUT TYPE="HIDDEN" NAME="sltTgtIndId" VALUE="">
      <INPUT TYPE="HIDDEN" NAME="sltTgtOccId" VALUE="">
      <INPUT TYPE="HIDDEN" NAME="sltDegId" VALUE="">
      <INPUT TYPE="HIDDEN" NAME="chkDegUp" VALUE="">
      <INPUT TYPE="HIDDEN" NAME="sltLanId" VALUE="">
      <INPUT TYPE="HIDDEN" NAME="sltWyearId" VALUE="">
      <INPUT TYPE="HIDDEN" NAME="txtAgeFrom" VALUE="">
      <INPUT TYPE="HIDDEN" NAME="txtAgeTo" VALUE="">
      <INPUT TYPE="HIDDEN" NAME="txtKeyWords" VALUE="">
      <INPUT TYPE="HIDDEN" NAME="txtCvSerialNo" VALUE="">
      <INPUT TYPE="HIDDEN" NAME="sltJobTypeId" VALUE="">
      <INPUT TYPE="HIDDEN" NAME="sltApplyDate" VALUE="">
      <INPUT TYPE="HIDDEN" NAME="txtApplyDateStart" VALUE="">
      <INPUT TYPE="HIDDEN" NAME="txtApplyDateEnd" VALUE="">
      <INPUT TYPE="HIDDEN" NAME="sltCurrentCityId" VALUE="">
      <INPUT TYPE="HIDDEN" NAME="sltTgtLocId" VALUE="">
      <INPUT TYPE="HIDDEN" NAME="sltTgtCityId" VALUE="">
      <INPUT TYPE="HIDDEN" NAME="sltResidentCityId" VALUE="">
      <INPUT TYPE="HIDDEN" NAME="sltMajorId" VALUE="">
      <INPUT TYPE="HIDDEN" NAME="txtMajorName" VALUE="">
      <INPUT TYPE="HIDDEN" NAME="sltLanLevelId" VALUE="">
      <INPUT TYPE="HIDDEN" NAME="rdoGender" VALUE="">
      <INPUT TYPE="HIDDEN" NAME="rdoIsAbroad" VALUE="">
      <INPUT TYPE="HIDDEN" NAME="rdoCvLang" VALUE="">
      <INPUT TYPE="HIDDEN" NAME="txtName" VALUE="">
      <INPUT TYPE="HIDDEN" NAME="sltPolityId" VALUE="">
      <INPUT TYPE="HIDDEN" NAME="txtWyear" VALUE="">

  </FORM></TD>
  </TR>
<SCRIPT language="JavaScript">
<!--
if(isSure==true)
{
  form1.HidOpType.value="apply2my";
  form1.HidIsAlert.value="y";
  form1.submit();
}
-->
</SCRIPT>
  <TR HEIGHT="40">
    <TD VALIGN="bottom">
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

