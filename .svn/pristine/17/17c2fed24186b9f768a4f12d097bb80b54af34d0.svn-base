<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>

<html>
<head>
<TITLE>应聘简历</TITLE>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=UTF-8">
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
<BODY>
<h1><%=r.getString(teasession._nLanguage, "应聘简历")%></h1> 
<div id="head6"><img height="6" src="about:blank"></div>
<TABLE BORDER="0" CELLSPACING="0" CELLPADDING="0" id="tablecenter" >

  <TR>
    <TD><FORM NAME="form1" METHOD="post" ACTION="">
        <TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0" id="tablecenter">
          <TR>
            <TD> 第1/6页 &nbsp;上页&nbsp;<A HREF="JavaScript: go(2);">下页</A>
              <INPUT    class="edit_button"   NAME="txtPageNo1" TYPE="text" SIZE="3" MAXLENGTH="3" onkeydown="javascript:if (event.keyCode == 13) { dgo('1');return false;}">
              页
            <INPUT   class="edit_button"   NAME="imageField1" TYPE="image" SRC="/images/btn_go.gif" ALIGN="TOP" WIDTH="30"
                HEIGHT="21" BORDER="0" onClick="JavaScript: dgo('1');return false;"></TD>
          </TR>
        </TABLE>
        <TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0" id="tablecenter">
          <TR >
            <TD> <INPUT   class="edit_button"    id="CHECKBOX" type="CHECKBOX" NAME="chkSelAll" VALUE="checkbox" onClick="JavaScript: selAll();">
            </TD>
            <TD>姓名</TD>
            <TD> <DIV ALIGN="center">应聘职位</DIV></TD>
            <TD><DIV align="center"><SELECT id="sltCol0" name="sltCol0" ONCHANGE="JavaScript: changeCol('0');"><OPTION VALUE="PositionNameCN,PositionNameEN" SELECTED>现职位</OPTION><OPTION VALUE="contact_type1,contact_no1">联系方式</OPTION><OPTION VALUE="Degree">学历</OPTION><OPTION VALUE="ExpectSalaryType,ExpectSalaryClass,ExpectSalarySum">期望薪水</OPTION><OPTION VALUE="birthday">年龄</OPTION><OPTION VALUE="gender">性别</OPTION><OPTION VALUE="0 AS ExpectState,0 AS ExpectCity">期望地区</OPTION><OPTION VALUE="langType1,langType2,langType3">语言</OPTION><OPTION VALUE="SchoolNameCN,SchoolNameEn">毕业院校</OPTION><OPTION VALUE="MajorNameCN,MajorNameEN">专业</OPTION><OPTION VALUE="HukouState,HukouCity">户口</OPTION></SELECT></DIV></TD><TD><DIV align="center"><SELECT id="sltCol1" name="sltCol1" ONCHANGE="JavaScript: changeCol('1');"><OPTION VALUE="ResidenceState,ResidenceCity,CurrStateInputCN,CurrStateInputEN" SELECTED>现地区</OPTION><OPTION VALUE="contact_type1,contact_no1">联系方式</OPTION><OPTION VALUE="Degree">学历</OPTION><OPTION VALUE="ExpectSalaryType,ExpectSalaryClass,ExpectSalarySum">期望薪水</OPTION><OPTION VALUE="birthday">年龄</OPTION><OPTION VALUE="gender">性别</OPTION><OPTION VALUE="0 AS ExpectState,0 AS ExpectCity">期望地区</OPTION><OPTION VALUE="langType1,langType2,langType3">语言</OPTION><OPTION VALUE="SchoolNameCN,SchoolNameEn">毕业院校</OPTION><OPTION VALUE="MajorNameCN,MajorNameEN">专业</OPTION><OPTION VALUE="HukouState,HukouCity">户口</OPTION></SELECT></DIV></TD><TD><DIV align="center"><SELECT id="sltCol2" name="sltCol2" ONCHANGE="JavaScript: changeCol('2');"><OPTION VALUE="experience" SELECTED>工作经验</OPTION><OPTION VALUE="contact_type1,contact_no1">联系方式</OPTION><OPTION VALUE="Degree">学历</OPTION><OPTION VALUE="ExpectSalaryType,ExpectSalaryClass,ExpectSalarySum">期望薪水</OPTION><OPTION VALUE="birthday">年龄</OPTION><OPTION VALUE="gender">性别</OPTION><OPTION VALUE="0 AS ExpectState,0 AS ExpectCity">期望地区</OPTION><OPTION VALUE="langType1,langType2,langType3">语言</OPTION><OPTION VALUE="SchoolNameCN,SchoolNameEn">毕业院校</OPTION><OPTION VALUE="MajorNameCN,MajorNameEN">专业</OPTION><OPTION VALUE="HukouState,HukouCity">户口</OPTION></SELECT></DIV></TD><TD><DIV align="center"><SELECT id="sltCol3" name="sltCol3" ONCHANGE="JavaScript: changeCol('3');"><OPTION VALUE="0 AS apply_date1" SELECTED>投递时间</OPTION><OPTION VALUE="contact_type1,contact_no1">联系方式</OPTION><OPTION VALUE="Degree">学历</OPTION><OPTION VALUE="ExpectSalaryType,ExpectSalaryClass,ExpectSalarySum">期望薪水</OPTION><OPTION VALUE="birthday">年龄</OPTION><OPTION VALUE="gender">性别</OPTION><OPTION VALUE="0 AS ExpectState,0 AS ExpectCity">期望地区</OPTION><OPTION VALUE="langType1,langType2,langType3">语言</OPTION><OPTION VALUE="SchoolNameCN,SchoolNameEn">毕业院校</OPTION><OPTION VALUE="MajorNameCN,MajorNameEN">专业</OPTION><OPTION VALUE="HukouState,HukouCity">户口</OPTION></SELECT></DIV></TD></TR>
<%
int nodecode=teasession._nNode;
java.util.Enumeration enumeration=Apply.findByResume(nodecode);
while(enumeration.hasMoreElements()){
    Apply apply=Apply.find(nodecode,((Integer)enumeration.nextElement()).intValue());
%>
<TR><TD><INPUT   class="edit_button"    id="CHECKBOX" type="CHECKBOX" NAME="chk_id" VALUE="14423069"></TD>
    <TD><A href="/jsp/type/resume/Preview.jsp?member=<%=apply.getResumeNode()%>" TARGET="_BLANK"><%=apply.getResumeNode()%></A></TD>
    <TD>信息及管理制度高级主管</TD>
    <TD>总裁助理</TD>
    <TD>北京</TD>
    <TD>2 年</TD>
    <TD><%=apply.getAppDate("yyyy-MM-dd")%></TD></TR>
   <% }%>
        </TABLE>
        <TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0" id="tablecenter">
          <TR>
            <TD><INPUT  id="CHECKBOX" type="CHECKBOX" NAME="chkSelAll" VALUE="checkbox"  onClick="JavaScript: selAll();"></TD>
            <TD> 全部选中</TD>
            <TD>
              第1/6页 &nbsp;上页&nbsp;<A HREF="JavaScript: go(2);">下页</A>
              <INPUT NAME="txtPageNo2"   class="edit_button"   TYPE="text" SIZE="3" MAXLENGTH="3" onkeydown="javascript:if (event.keyCode == 13) { dgo('2');return false;}">
              页
              <INPUT NAME="imageField2"   class="edit_button"   TYPE="image" SRC="/images/btn_go.gif" ALIGN="TOP" WIDTH="30"
                HEIGHT="21" BORDER="0" onClick="JavaScript: dgo('2');return false;"></TD>
          </TR>
        </TABLE>
        <TABLE id="tablecenter" BORDER="0" CELLPADDING="0" CELLSPACING="0">
          <TR>
            <TD><br/> <INPUT NAME="imageField3"  type="button"  class="edit_button"  BORDER="0" onClick="JavaScript: view();return false;">
              <INPUT NAME="imageField4"  type="button"  class="edit_button"  BORDER="0" onClick="JavaScript:sendMail(); return false;">
              <INPUT NAME="imageField82"  type="button"  class="edit_button"  BORDER="0" onClick="JavaScript:toExport(1, 2); return false;">
              <INPUT NAME="imgDel"  type="button"  class="edit_button"  BORDER="0" onClick="JavaScript:toDel();;return false;">
			  <INPUT NAME="imageField5" type="button"   class="edit_button"  BORDER="0" onClick="JavaScript: doOp('apply2my');return false;//window.parent.navigate('/cv_center/cv_search_my_list.asp');//return false;"  VSPACE="8">
              <INPUT NAME="imageField6"  type="button"   class="edit_button"   BORDER="0" onClick="JavaScript:fwd(); return false;" VSPACE="8">
            <INPUT NAME="imageField7"  type="button"   class="edit_button"  BORDER="0" onClick="JavaScript:toOrg(); return false;" VSPACE="8">

             <br/>
                           <br/> </TD>
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
      <input type="HIDDEN" name="sltLanLevelId" value="">
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
</TABLE>
<div id="head6"><img height="6" src="about:blank"></div> 
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</BODY>
</html>

