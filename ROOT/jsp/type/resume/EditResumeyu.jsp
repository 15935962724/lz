<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>

<%@include file="/jsp/include/ShowPicture.jsp"%>
<%
r.add("tea/ui/node/type/Report/EditReport");
Profile profile = Profile.find(teasession._rv._strR);
Resume summary=Resume.find(teasession._rv._strR,teasession._nLanguage);
String nationality =profile.getState(teasession._nLanguage);
if(nationality ==null||nationality .length()<=0)
nationality ="中国";
%>
<HTML>
<HEAD>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">



<script language="javascript" type="text/javascript">
<!--
	var Page_ValidationSummaries =  new Array(document.all["ValidationSummary1"]);
	var Page_Validators =  new Array(document.all["RequiredFieldValidatorName"], document.all["ccTypeReqVal"], document.all["RequiredFieldValidator4"], document.all["RequiredFieldValidatorOtherCity"], document.all["RegularExpressionValidator1"], document.all["RequiredContactNo1"], document.all["RegularexpressionContactNo1"]);
		// -->
</script>


<script language="javascript" type="text/javascript">
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

    <meta content="SharePoint.WebPartPage.Document" name="ProgId">
    <meta content="full" name="WebPartPageExpansion">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
    <meta content="C#" name="CODE_LANGUAGE">
    <meta content="JavaScript" name="vs_defaultClientScript">
    <meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
      <script language="javascript" src="/tea/CssJs/AreaCityDataCN.js"></script>
    <script language="javascript" src="/tea/CssJs/SummaryDataCN.js"></script>
    <script language="javascript" src="/tea/CssJs/AreaCityScipt.js"></script>
    <script language="javascript" src="/tea/CssJs/SummaryScript.js"></script>

<script language="javascript" type="text/javascript" src="/tea/CssJs/WebUIValidation.js"></script>




<script language="javascript">
  document.all('tblSecondMenu').rows(0).cells(4).className='bg2';
 document.all('tblSecondMenu').rows(0).cells(4).onmouseout='';
 document.all('a30').className='menuLink';
</script>


<script src="/tea/tea.js" type="text/javascript"></script>
    <script language="javascript">
        <!--
        //给地区父控件设置选中值
      function SetSelectedValueType( objName,varValue )
      {
        for( var i=0; i < document.all(objName).length; i ++ )
        {
          if( document.all(objName).options[i].value == varValue )
          {
            document.all(objName).selectedIndex = i;
            break;
          }
        }
      }
      //给地区子控件设置选中值
      function SetSelectedValueList( objName,varValue )
      {
          changeChildList(document.all['ResidenceState'],document.all['ResidenceCity']) //选中当前父控件的子项目（调用onchange）
          for( var i=0; i < document.all(objName).length; i ++ )
          {
            if( document.all(objName).options[i].value == varValue )
            {
              document.all(objName).selectedIndex = i;
              break;
            }
          }
      }

      function SetSelectedValueList1( objName,varValue )
      {
          changeChildList(document.all['HuKouState'],document.all['HuKouCity']);
          for( var i=0; i < document.all(objName).length; i ++ )
          {
            if( document.all(objName).options[i].value == varValue )
            {
              document.all(objName).selectedIndex = i;
              break;
            }
          }
      }
      //
function InitForm()
{
  var txtValue   = document.all['ResidenceCity'].value;
  var txtLength  = document.all['ResidenceCity'].value.length;
  var SplitValue = txtValue.substring(txtLength-1,txtLength) //最后一位是1
  //是否选择了其它城市
  if (SplitValue == "1")
  {
    //显示其它城市输入框及说明
    document.all['TrOtherCity'].style.display = "";
    document.all['RequiredFieldValidatorOtherCity'].enabled = true;
  }
  ChangeIDType();
  ChangeContactType();
}
function SelectCity()
{
  var txtValue   = document.all['ResidenceCity'].value;
  var txtLength  = document.all['ResidenceCity'].value.length;
  var SplitValue = txtValue.substring(txtLength-1,txtLength) //最后一位是1
  //是否选择了其它城市
  if (SplitValue == "1")
  {
    //显示其它城市输入框及说明
    document.all['TrOtherCity'].style.display = "";
    document.all['RequiredFieldValidatorOtherCity'].enabled = true;
  }
  else
  {
    //隐藏其它城市输入框及说明
    document.all['TrOtherCity'].style.display = "none";
    document.all['RequiredFieldValidatorOtherCity'].enabled = false;
  }
}
function ChangeContactType()
{
  if (document.all['contact_type1'].selectedIndex==0)  //手机
  {
    document.all['RegularexpressionContactNo1'].enabled = true;
  }
  else
  {
    RegularexpressionContactNo1.enabled = false;
    //document.all['RegularexpressionContactNo1'].enabled = false;
  }
}
function ChangeIDType()
{
  if (document.all['IDType'].selectedIndex==0) //身份证
  {
    document.all['RegularExpressionValidator1'].enabled = true;
  }
  else
  {
    document.all['RegularExpressionValidator1'].enabled = false;
    //document.all['RegularExpressionValidator1'].innerHTML = '';
  }
}
//-->
    </script>
    <script language="javascript" src="/tea/CssJs/AreaCN.js"></script>


    <%------------职业概况/求职意向------------%>
        <script language="javascript" src="/tea/CssJs/AreaCityDataCN.js"></script>
    <script language="javascript" src="/tea/CssJs/SummaryDataCN.js"></script>
    <script language="javascript" src="/tea/CssJs/AreaCityScipt.js"></script>
    <script language="javascript" src="/tea/CssJs/SummaryScript.js"></script>
	 <script language="javascript" type="text/javascript" src="/tea/CssJs/WebUIValidation.js"></script>

        <script language="javascript">
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
<script language="javascript">
  document.all('tblSecondMenu').rows(0).cells(4).className='bg2';
 document.all('tblSecondMenu').rows(0).cells(4).onmouseout='';
 document.all('a30').className='menuLink';
</script>
	<script language="javascript">
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
<script language="javascript">
  document.all('tblSecondMenu').rows(0).cells(4).className='bg2';
 document.all('tblSecondMenu').rows(0).cells(4).onmouseout='';
 document.all('a30').className='menuLink';
</script>






</HEAD>
<body>
<h1><%=r.getString(teasession._nLanguage, "EditResumeyu")%></h1>
  <div id="head6"><img height="6" src="about:blank"></div>
<DIV ID="edit_BodyDiv"><div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%>  </div>
  <FORM name="Form1" METHOD=POST action="/servlet/EditResume"   enctype=multipart/form-data >
    <input type='hidden' name=Node VALUE="<%=teasession._nNode%>">
<h2>基本信息</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td colspan="2" align="right" ><A href="/jsp/type/resume/Preview.jsp" style="color=#ffffff" target=_blank >预览简历</A></td>
  </tr>
  <tr>
    <td><div align="right"><strong>姓名&nbsp;&nbsp; </strong></div></td>
    <td> <input type="TEXT" class="edit_input"  name=FirstName VALUE="<%=profile.getFirstName(teasession._nLanguage)%>" SIZE=20 MAXLENGTH=20>
     <!-- <%=r.getString(teasession._nLanguage, "LastName")%>: <input type="TEXT" class="edit_input"  name=LastName value="<%=profile.getLastName(teasession._nLanguage)%>" size=20 maxlength=20>--></td>

  </tr>
  <TR>
    <TD align="right" ></TD>
    <TD><span id="RequiredFieldValidatorName" controltovalidate="NameCN" errormessage="请填写姓名！" display="Dynamic" evaluationfunction="RequiredFieldValidatorEvaluateIsValid" initialvalue="" style="color:Red;display:none;">请填写姓名！</span></TD>
  </TR>
  <tr>
    <td align="right"><span class="alert"><strong>*</strong></span><strong>&nbsp;性别&nbsp;&nbsp;</strong></td>
    <td><span id="gender">
      <input id="radio" type="radio" name="gender" value="1" checked />
      <label for="gender_0">&nbsp;男&nbsp;</label>
      <input id="radio" type="radio" name="gender" value="0" <%=getCheck(!profile.isSex())%>/>
      <label for="gender_1">&nbsp;女</label>
      </span></td>
  </tr>
  <TR>
    <TD align="right"></TD>
    <TD><span id="ccTypeReqVal" controltovalidate="gender" errormessage="请选择性别！" display="Dynamic" evaluationfunction="RequiredFieldValidatorEvaluateIsValid" initialvalue="" style="color:Red;display:none;">请选择性别！</span></TD>
  </TR>
  <tr>
    <td align="right"><span class="alert"><strong>*</strong></span><strong>出生年月&nbsp;&nbsp;
    </strong></td>
    <td><select name="birthday:ymYear" id="birthday_ymYear">
        <option value="1990">1990</option>
        <option value="1989">1989</option>
        <option value="1988">1988</option>
        <option value="1987">1987</option>
        <option value="1986">1986</option>
        <option value="1985">1985</option>
        <option value="1984">1984</option>
        <option value="1983">1983</option>
        <option value="1982">1982</option>
        <option value="1981">1981</option>
        <option selected="selected" value="1980">1980</option>
        <option value="1979">1979</option>
        <option value="1978">1978</option>
        <option value="1977">1977</option>
        <option value="1976">1976</option>
        <option value="1975">1975</option>
        <option value="1974">1974</option>
        <option value="1973">1973</option>
        <option value="1972">1972</option>
        <option value="1971">1971</option>
        <option value="1970">1970</option>
        <option value="1969">1969</option>
        <option value="1968">1968</option>
        <option value="1967">1967</option>
        <option value="1966">1966</option>
        <option value="1965">1965</option>
        <option value="1964">1964</option>
        <option value="1963">1963</option>
        <option value="1962">1962</option>
        <option value="1961">1961</option>
        <option value="1960">1960</option>
        <option value="1959">1959</option>
        <option value="1958">1958</option>
        <option value="1957">1957</option>
        <option value="1956">1956</option>
        <option value="1955">1955</option>
        <option value="1954">1954</option>
        <option value="1953">1953</option>
        <option value="1952">1952</option>
        <option value="1951">1951</option>
        <option value="1950">1950</option>
        <option value="1949">1949</option>
        <option value="1948">1948</option>
        <option value="1947">1947</option>
        <option value="1946">1946</option>
        <option value="1945">1945</option>
        <option value="1944">1944</option>
        <option value="1943">1943</option>
        <option value="1942">1942</option>
        <option value="1941">1941</option>
        <option value="1940">1940</option>
        <option value="1939">1939</option>
        <option value="1938">1938</option>
        <option value="1937">1937</option>
        <option value="1936">1936</option>
        <option value="1935">1935</option>
        <option value="1934">1934</option>
        <option value="1933">1933</option>
        <option value="1932">1932</option>
        <option value="1931">1931</option>
        <option value="1930">1930</option>
      </select>
      年
      <select name="birthday:ymMonth" id="birthday_ymMonth">
        <option selected="selected" value="1">1</option>
        <option value="2">2</option>
        <option value="3">3</option>
        <option value="4">4</option>
        <option value="5">5</option>
        <option value="6">6</option>
        <option value="7">7</option>
        <option value="8">8</option>
        <option value="9">9</option>
        <option value="10">10</option>
        <option value="11">11</option>
        <option value="12">12</option>
      </select>
      月 </td>
  </tr>
  <tr>
    <td><div align="right"><strong>照片&nbsp;&nbsp;</strong></div></td>
    <td><input class="edit_button" type=file name=Photo  ></td>
  </tr>
  <tr>
    <td align="right"><strong>国籍&nbsp;&nbsp;</strong></td>
    <td><input class="edit_input" name="NationalityCN" id="NationalityCN" type="text" maxlength="20" size="20" value="<%=nationality%>" /></td>
  </tr>
  <tr>
    <td align="right"><span class="alert"><strong>*</strong></span><strong>&nbsp;现居住地区/城市&nbsp;&nbsp;</strong></td>
    <td><%-- %><select name="ResidenceState" id="ResidenceState" onchange="changeChildList(this,document.all['ResidenceCity']);SelectCity();">
        <option selected="selected" value="0">选择地区</option>
      </select> <select name="ResidenceCity" id="ResidenceCity" onchange="SelectCity();">
        <option selected="selected" value="0">选择城市</option>
      </select>--%><TEXTAREA name="Address" class="edit_input" ROWS="2" COLS="60"><%=profile.getAddress(teasession._nLanguage)%></TEXTAREA>
  </td>
  </tr>
  <TR>
    <TD align="right"></TD>
    <TD><span id="RequiredFieldValidator4" controltovalidate="ResidenceState" errormessage="请选择现居住地区/城市！" display="Dynamic" evaluationfunction="RequiredFieldValidatorEvaluateIsValid" initialvalue="0" style="color:Red;display:none;">请选择现居住地区/城市！</span></TD>
  </TR>
  <tr id="TrOtherCity" style="DISPLAY: none">
    <td align="right">&nbsp;</td>
    <td><input class="edit_input" name="OtherCityCN" id="OtherCityCN" type="text" maxlength="30" />
      &nbsp;&nbsp;<span class="note">请填写你居住的城市</span> </td>
  </tr>
  <TR>
    <TD align="right"></TD>
    <TD><span id="RequiredFieldValidatorOtherCity" controltovalidate="OtherCityCN" errormessage="请填写你居住的城市！" display="Dynamic" enabled="False" evaluationfunction="RequiredFieldValidatorEvaluateIsValid" initialvalue="" style="color:Red;display:none;">请填写你居住的城市！</span></TD>
  </TR><%--
  <tr>
    <td align="right">户口所在地&nbsp;&nbsp;</td>
    <td><select name="HuKouState" id="HuKouState" onchange="changeChildList(this,document.all['HuKouCity']);">
        <option selected="selected" value="0">选择地区</option>
      </select> <select name="HuKouCity" id="HuKouCity">
        <option selected="selected" value="0">选择城市</option>
      </select> &nbsp;&nbsp;<span class="note">学生填写生源地</span> </td>
  </tr>
  <tr>

    <td align="right">证件类型&nbsp;&nbsp; </td>
    <td><select name="IDType" id="IDType" onchange="ChangeIDType()">
        <option selected="selected" value="1">身份证</option>
        <option value="2">军人证</option>
        <option value="3">港澳身份证</option>
        <option value="4">台胞证</option>
        <option value="5">护照</option>
        <option value="6">其他</option>
      </select> &nbsp;&nbsp;&nbsp;<span class="note">证件号码</span>&nbsp;&nbsp;&nbsp;
      <input name="IDNo" id="IDNo" type="text" maxlength="18" /> </td>
  </tr>
  <TR>
    <TD align="right"></TD>
    <TD><span id="RegularExpressionValidator1" controltovalidate="IDNo" errormessage="请填写正确的身份证号码！" display="Dynamic" evaluationfunction="RegularExpressionValidatorEvaluateIsValid" validationexpression="\d{18}|(\d{17}([a-z]|[A-Z]))|\d{15}" style="color:Red;display:none;">请填写正确的身份证号码！</span></TD>
  </TR>--%>
  <tr>
    <td align="right"><span class="alert"><strong>*&nbsp;</strong></span><strong>教育程度&nbsp;&nbsp;</strong></td>
    <td><font size="2"><%=new tea.htmlx.DegreeSelection("Degree")%>
      <%-- %><select name="Degree" id="Degree">
        <option selected="selected" value="6">博士</option>
        <option value="5">MBA</option>
        <option value="4">硕士</option>
        <option value="3">本科</option>
        <option value="2">大专</option>
        <option value="1">中专</option>
        <option value="-5">中技</option>
        <option value="-10">高中</option>
        <option value="-15">初中</option>
        <option value="255">其它</option>
      </select>--%>
      </font>&nbsp;</td>
  </tr><%-- %>
  <tr>
    <td align="right">政治面貌&nbsp;&nbsp; </td>
    <td><select name="polity" id="polity">
        <option value="5">党员</option>
        <option value="10">团员</option>
        <option selected="selected" value="15">群众</option>
        <option value="20">民主党派</option>
        <option value="252">其他</option>
      </select> </td>
  </tr>--%>
<tr>
  <td><div align="right"><strong> 教育背景&nbsp;&nbsp;</strong></div></td><td>  <input class="edit_button" name="" VALUE="<%=r.getString(teasession._nLanguage, "New")%>" type="button" onclick="window.open('EditEducate.jsp')"></td></tr>
<tr>
  <td><div align="right"><strong> 工作经验&nbsp;&nbsp;</strong></div></td><td>  <input class="edit_button" name="" VALUE="<%=r.getString(teasession._nLanguage, "New")%>" type="button" onclick="window.open('EditEmployment.jsp')"></td></tr>
<tr><td>  </td></tr>
</table>


<h2>职业概况</h2>
                      <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">

              <tr>
                <td vAlign="baseline" align="right" width="130"><span class="alert"><strong>*&nbsp;</strong></span><strong>现从事行业</strong></td>
                <td><span class="note">
                    <%=new tea.htmlx.TradeSelection("NowTrade",summary.getNowTrade())%>
&nbsp;<span class="note">学生请选择“在校学生”</span><br>
                    <span id="valNowTrade" controltovalidate="NowTrade" errormessage="请选择现从事行业！" display="Dynamic" evaluationfunction="CompareValidatorEvaluateIsValid" valuetocompare="0" operator="GreaterThan" style="color:Red;display:none;">请选择现从事行业！</span></span></td>
              </tr>
              <tr>
                <td vAlign="baseline" align="right"><strong><nobr>*&nbsp;现从事职业&nbsp;&nbsp;</nobr></strong></td>
                <td><span class="note"><SELECT id="NowMainCareer" name="NowMainCareer"></SELECT><select name="NowCareer" id="NowCareer">
</select>
<script>
Form1.NowCareer.options[Form1.NowCareer.selectedIndex].text='<%=summary.getNowMainCareer()%>';
</script>
                    <span class="note"><nobr>学生请选择“在校学生”</nobr><br>
                     <span id="valNowCareer" controltovalidate="NowCareer" errormessage="请选择现从事职业！" display="Dynamic" evaluationfunction="CompareValidatorEvaluateIsValid" valuetocompare="0" operator="GreaterThan" style="color:Red;display:none;">请选择现从事职业！</span></span></FONT></FONT></span></td>
              </tr>

              <tr>
                <td vAlign="baseline" align="right"><span class="alert"><strong>*</strong></span><strong>&nbsp;现职位级别&nbsp;&nbsp;</strong></td>
                <td noWrap><select class="edit_input" name="NowCareerLevel" id="NowCareerLevel">
	<option value="0"></option>
	<option value="高级决策层(CEO, EVP, GM...)"<%=getSelect(summary.getNowCareerLevel().equals("高级决策层(CEO, EVP, GM...)"))%>>高级决策层(CEO, EVP, GM...)</option>
	<option value="高级职位(管理类)" <%=getSelect(summary.getNowCareerLevel().equals("高级职位(管理类)"))%>>高级职位(管理类)</option>
	<option value="高级职位(非管理类)"<%=getSelect(summary.getNowCareerLevel().equals("高级职位(非管理类)"))%>>高级职位(非管理类)</option>
	<option value="中级职位(两年以上工作经验)"<%=getSelect(summary.getNowCareerLevel().equals("中级职位(两年以上工作经验)"))%>>中级职位(两年以上工作经验)</option>
	<option value="初级职位(两年以下工作经验)"<%=getSelect(summary.getNowCareerLevel().equals("初级职位(两年以下工作经验)"))%>>初级职位(两年以下工作经验)</option>
	<option value="学生"<%=getSelect(summary.getNowCareerLevel().equals("学生"))%>>学生</option>
</select>&nbsp;<span class="note"><span class="note">学生请选择“在校学生”</span><br>
                    <span id="valNowCareerLevel" controltovalidate="NowCareerLevel" errormessage="请选择现从事职业级别！" display="Dynamic" evaluationfunction="CompareValidatorEvaluateIsValid" valuetocompare="0" operator="GreaterThan" style="color:Red;display:none;">请选择现从事职业级别！</span></span></td>
              </tr>
              <tr>
                <td vAlign="baseline" align="right"><span class="alert"><strong>*&nbsp;</strong></span><strong>工作经验&nbsp;&nbsp;</strong></td>
                <td><input class="edit_input" name="Experience" id="Experience" type="text" maxlength="2" size="2" value="<%=summary.getExperience()%>" />
                  年 <span class="note"><span class="note">请填写数字，没有工作经验请填写0。</span><br>
                    </FONT><span id="valExperience_required" controltovalidate="Experience" errormessage="请填写工作经验！" display="Dynamic" evaluationfunction="RequiredFieldValidatorEvaluateIsValid" initialvalue="" style="color:Red;display:none;">请填写工作经验！</span><span id="valExperience_limit" controltovalidate="Experience" errormessage="请填写正确的工作经验年限！" display="Dynamic" type="Integer" evaluationfunction="RangeValidatorEvaluateIsValid" maximumvalue="99" minimumvalue="0" style="color:Red;display:none;">请填写正确的工作经验年限！</span></span></td>
              </tr>
              <tr>
                <td vAlign="baseline" align="right"><span class="alert"><strong>*</strong></span><strong>&nbsp;是否有海外工作经历&nbsp;&nbsp;</strong></td>
                <td><table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
	<tr>
		<td><input id="radio" type="radio" name="Has_Abroad" value="True" <%=getCheck(summary.isHasAbroad())%> /><label for="Has_Abroad_0">是 </label></td><td><input id="radio" type="radio" name="Has_Abroad" value="False"  <%=getCheck(!summary.isHasAbroad())%> /><label for="Has_Abroad_1">否 </label></td>
	</tr>
</table></FONT></td>
              </tr>
              <tr>
                <td vAlign="baseline" align="right"><strong>目前月薪（税前）&nbsp;&nbsp;</strong></td>
                <td><%--<select name="SalaryType" id="SalaryType">
	<option value="1">年薪</option>
	<option selected="selected" value="2">月薪</option>
	<option value="3">日薪</option>
	<option value="4">时薪</option>
</select>
                  <select name="SalaryClass" id="SalaryClass">
	<option value="0">RMB</option>
	<option value="1">US$</option>
	<option value="2">HK$</option>
</select>--%>
                  <input class="edit_input" name="SalarySum" id="SalarySum" type="text" maxlength="7" size="8" value="<%=summary.getSalarySum()%>" />
                  元(人民币)
                  <br>
                  <span id="valSalarySum" controltovalidate="SalarySum" errormessage="请填写正确的薪资数额！" display="Dynamic" type="Integer" evaluationfunction="CompareValidatorEvaluateIsValid" operator="DataTypeCheck" style="color:Red;display:none;">请填写正确的薪资数额！</span></td>
              </tr>
            </table>
			<h2>求职意向</h2>
           <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">

              <tr>
                <td vAlign="baseline" align="right" width="130"><span class="alert"><strong>*</strong></span><strong>&nbsp;期望工作性质</strong></td>
                <td colSpan="3"><table id="ExpectWorkKind" border="0">
	<tr>
		<td><input id="CHECKBOX" type="CHECKBOX" name="ExpectWorkKind:0" <%=getCheck((summary.getExpectWorkKind()&2)!=0)%> /><label for="ExpectWorkKind_0">全职</label></td><td><input id="CHECKBOX" type="CHECKBOX" name="ExpectWorkKind:1" <%=getCheck((summary.getExpectWorkKind()&4)!=0)%>/><label for="ExpectWorkKind_1">兼职</label></td><td><input id="CHECKBOX" type="CHECKBOX" <%=getCheck((summary.getExpectWorkKind()&8)!=0)%>name="ExpectWorkKind:2" /><label for="ExpectWorkKind_2">临时</label></td><td><input class="edit_input" <%=getCheck((summary.getExpectWorkKind()&16)!=0)%> id="CHECKBOX" type="CHECKBOX" name="ExpectWorkKind:3" /><label for="ExpectWorkKind_3">实习</label></td>
	</tr>
</table> </td>
              </tr>
              <tr>
                <td vAlign="baseline" align="right"></td>
                <td colSpan="3"><span id="valExpectWorkKind" errormessage="请选择期望工作性质！" display="Dynamic" evaluationfunction="CustomValidatorEvaluateIsValid" clientvalidationfunction="ExpectWorkKindClientValidate" style="color:Red;display:none;">请选择期望工作性质！</span></td>
              </tr>
              <tr>
                <td vAlign="top" noWrap align="right"><strong>期望从事行业&nbsp;&nbsp;<br>
  （可选5项）&nbsp;&nbsp;</strong>
                </td>
                <td vAlign="top" width="30%"><select id="srcExpectTrade" style="WIDTH: 160px" multiple size="5" name="srcExpectTrade"></select>
                </td>
                <td width="12%"><input class="edit_button" id="btnAddExpectTrade" style="WIDTH: 60px" type="button" value="添加>>" name="btnAddExpectTrade">
                  <br>
                  <input class="edit_button" id="btnDelExpectTrade" style="WIDTH: 60px" type="button" value="<<删除" name="btnDelExpectTrade"></FONT>
                </td>
                <td vAlign="middle" width="33%"><select id="ExpectTrade" style="WIDTH: 160px" multiple size="5" name="ExpectTrade">
                    <%
                    StringTokenizer tokenizer=new StringTokenizer(summary.getExpectTrade(),"&");
                    while(tokenizer.hasMoreTokens())
                    {String str=tokenizer.nextToken();
                    %>
                    <option value="<%=str%>"><%=str%></option>
                    <%}%>
                </select></td>
              </tr>
              <TR>
                <TD vAlign="top" align="right" rowSpan="2"><span class="alert"><strong>*</strong></span><strong>&nbsp;期望从事职业&nbsp;&nbsp;<br>
  （可选5项）&nbsp;&nbsp;</strong></TD>
                <TD vAlign="top" colSpan="3">
                    <SELECT id="ExpectMainCareer" name="ExpectMainCareer">

                    </SELECT>
                </TD>
              </TR>
              <tr>
                <td vAlign="top"><select class="edit_input" id="srcExpectCareer" style="WIDTH: 160px" multiple size="5" name="srcExpectCareer">
                </select>                  </FONT>
                  <span id="ExpectCareerValidator" errormessage="请选择期望从事职业！" display="Dynamic" evaluationfunction="CustomValidatorEvaluateIsValid" clientvalidationfunction="expectCareerClientValidate" style="color:Red;display:none;">请选择期望从事职业！</span></td>
                <td><input class="edit_button" id="btnAddExpectCareer" style="WIDTH: 60px" type="button" value="添加>>" name="btnAddExpectCareer">
                  <br>
                  <input class="edit_button" id="btnDelExpectCareer" style="WIDTH: 60px" type="button" value="<<删除" name="btnDelExpectCareer"></FONT>
                </td>
                <td vAlign="top" width="33%"><select class="edit_input" id="ExpectCareer" style="WIDTH: 160px" multiple size="5" name="ExpectCareer">
                     <%
                     tokenizer=new StringTokenizer(summary.getExpectCareer(),"&");
                    while(tokenizer.hasMoreTokens())
                    {String str=tokenizer.nextToken();
                    %>
                    <option value="<%=str%>"><%=str%></option>
                    <%}%>
                </select><%=summary.getExpectCareer()%></td>
              </tr>
              <tr>
                <td vAlign="baseline" align="right" rowSpan="2"><span class="alert"><strong>*</strong></span><strong>&nbsp;期望工作地区&nbsp;&nbsp;<br>
  （可选5项）&nbsp;&nbsp;</strong></td>
                <td colSpan="3"><select id="ExpectState" name="ExpectState">

                </select></FONT>
                </td>
              </tr>
              <tr>
                <td vAlign="top"><select class="edit_input" id="srcExpectCity" style="WIDTH: 160px" multiple size="5" name="srcExpectCity"></select></FONT>
                  <span id="AreaCityValidator" errormessage="请选择期望工作地区！" display="Dynamic" evaluationfunction="CustomValidatorEvaluateIsValid" clientvalidationfunction="areaCityClientValidate" style="color:Red;display:none;">请选择期望工作地区！</span></td>
                <td><input class="edit_button" id="btnAddExpectCity" style="WIDTH: 60px" type="button" value="添加>>" name="btnAddExpectCity">
                  <br>
                  <input class="edit_button" id="btnDelExpectCity" style="WIDTH: 60px" type="button" value="<<删除" name="btnDelExpectCity"></FONT></td>
                <td vAlign="top" width="33%"><select class="edit_input" id="ExpectCity" style="WIDTH: 160px" multiple size="5" name="ExpectCity">
                                           <%
                     tokenizer=new StringTokenizer(summary.getExpectCity(),"&");
                    while(tokenizer.hasMoreTokens())
                    {String str=tokenizer.nextToken();
                    %>
                    <option value="<%=str%>"><%=str%></option>
                    <%}%>
                </select></td>
              </tr>
              <tr>
                <td vAlign="baseline" align="right"><strong>期望月薪（税前）&nbsp;&nbsp;</strong></td>
                <td colSpan="3"><%--<select name="ExpectSalaryType" id="ExpectSalaryType">
	<option value="1">年薪</option>
	<option selected="selected" value="2">月薪</option>
	<option value="3">日薪</option>
	<option value="4">时薪</option>
</select>
                  <select name="ExpectSalaryClass" id="ExpectSalaryClass">
	<option value="0">RMB</option>
	<option value="1">US$</option>
	<option value="2">HK$</option>
</select>--%>
                  <input class="edit_input" name="ExpectSalarySum" id="ExpectSalarySum" type="text" maxlength="7" size="8"  value="<%=summary.getExpectSalarySum()%>" />
                  元(人民币) 不填表示面议<br>
                  <span id="valExpectSalarySum" controltovalidate="ExpectSalarySum" errormessage="请填写正确的薪资数额！" display="Dynamic" type="Integer" evaluationfunction="CompareValidatorEvaluateIsValid" operator="DataTypeCheck" style="color:Red;display:none;">请填写正确的薪资数额！</span></td>
              </tr>
              <tr>
                <td vAlign="baseline" align="right"><strong>到岗时间&nbsp;&nbsp;</strong></td>
                <td colSpan="3"><select name="JoinDateType" id="JoinDateType">
  <option value="100" selected>面谈</option>
	<option value="0"<%=getSelect(summary.getJoinDateType().equals("0"))%>>立即</option>
	<option value="7" <%=getSelect(summary.getJoinDateType().equals("7"))%>>1周以内</option>
	<option value="30"<%=getSelect(summary.getJoinDateType().equals("30"))%>>1个月内</option>
	<option value="60"<%=getSelect(summary.getJoinDateType().equals("60"))%>>1～3个月</option>
	<option value="90"<%=getSelect(summary.getJoinDateType().equals("90"))%>>3个月后</option>
</select><%-- %>
                  或
                  <select name="JoinDateYear" id="JoinDateYear">
	<option value=""></option>
	<option value="2005">2005</option>
	<option value="2006">2006</option>
	<option value="2007">2007</option>
</select>
                  年
                  <select name="JoinDateMonth" id="JoinDateMonth">
	<option value=""></option>
	<option value="1">1</option>
	<option value="2">2</option>
	<option value="3">3</option>
	<option value="4">4</option>
	<option value="5">5</option>
	<option value="6">6</option>
	<option value="7">7</option>
	<option value="8">8</option>
	<option value="9">9</option>
	<option value="10">10</option>
	<option value="11">11</option>
	<option value="12">12</option>
</select>
                  月
                  <select name="JoinDateDay" id="JoinDateDay">
	<option value=""></option>
	<option value="1">1</option>
	<option value="2">2</option>
	<option value="3">3</option>
	<option value="4">4</option>
	<option value="5">5</option>
	<option value="6">6</option>
	<option value="7">7</option>
	<option value="8">8</option>
	<option value="9">9</option>
	<option value="10">10</option>
	<option value="11">11</option>
	<option value="12">12</option>
	<option value="13">13</option>
	<option value="14">14</option>
	<option value="15">15</option>
	<option value="16">16</option>
	<option value="17">17</option>
	<option value="18">18</option>
	<option value="19">19</option>
	<option value="20">20</option>
	<option value="21">21</option>
	<option value="22">22</option>
	<option value="23">23</option>
	<option value="24">24</option>
	<option value="25">25</option>
	<option value="26">26</option>
	<option value="27">27</option>
	<option value="28">28</option>
	<option value="29">29</option>
	<option value="30">30</option>
	<option value="31">31</option>
</select>
                  日<br>
                  <span id="JoinDateValidator" errormessage="请选择正确的日期！" display="Dynamic" evaluationfunction="CustomValidatorEvaluateIsValid" clientvalidationfunction="JoinDateClientValidate" style="color:Red;display:none;">请选择正确的日期！</span>--%></td>
              </tr>
    </table>

            <div id="ValidationSummary1" headertext="你现在无法保存。原因是：" showmessagebox="True" showsummary="False" style="color:Red;display:none;">

</div>

      <br>

<script language="javascript" type="text/javascript">
<!--
	var Page_ValidationSummaries =  new Array(document.all["ValidationSummary1"]);
	var Page_Validators =  new Array(document.all["valNowTrade"], document.all["valNowCareer"], document.all["valNowCareerLevel"], document.all["valExperience_required"], document.all["valExperience_limit"], document.all["valSalarySum"], document.all["valExpectWorkKind"], document.all["ExpectCareerValidator"], document.all["AreaCityValidator"], document.all["valExpectSalarySum"], document.all["JoinDateValidator"]);
		// -->
</script>


<script language="javascript" type="text/javascript">
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


<%--  </form>--%>
    <script language="javascript">
/*期望工作地区*/
var expectStateObj=document.all['ExpectState'];
var srcExpectCityObj=document.all['srcExpectCity'];
var expectCityObj=document.all['ExpectCity'];
var areaCityValidatorObj=document.all['AreaCityValidator'];

if(typeof(Form1.btnAddExpectCity)=="object") Form1.btnAddExpectCity.onclick=function()
{
    addCityNodes(expectStateObj,srcExpectCityObj,expectCityObj,"期望工作地区限选5项！");
    ValidatorValidate(areaCityValidatorObj);
}
if(typeof(Form1.btnDelExpectCity)=="object") Form1.btnDelExpectCity.onclick=function()
{
    removeChildNodes(expectCityObj);
    ValidatorValidate(areaCityValidatorObj);
}
if(typeof(expectStateObj)=="object") expectStateObj.onchange=function()
{
    onChangeProvince(document.all['ExpectState'],document.all['srcExpectCity']);
}

function areaCityClientValidate(source,arguments)
{
    if (expectCityObj.lengTD>0)
    {
        arguments.IsValid=true;
    }
    else
    {
        arguments.IsValid=false;
    }
}

if(typeof(expectStateObj)=="object" && typeof(srcExpectCityObj)=="object" && typeof(expectCityObj)=="object")
{
    //initProvince(expectStateObj,srcExpectCityObj,"");
    initProvince(expectStateObj,srcExpectCityObj,"");
    initCityNodes(expectCityObj,"");
}

/*期望从事职业*/
var ExpectMainCareerObj = document.all['ExpectMainCareer'];
var srcExpectCareerObj=document.all['srcExpectCareer'];
var expectCareerObj=document.all['ExpectCareer'];
var expectCareerValidatorObj=document.all['ExpectCareerValidator'];

if(typeof(Form1.btnAddExpectCareer)=="object") Form1.btnAddExpectCareer.onclick=function()
{
    addOccupationNodes(ExpectMainCareerObj,srcExpectCareerObj,expectCareerObj,"期望从事职业限选5项！");
    ValidatorValidate(expectCareerValidatorObj);
}
if(typeof(Form1.btnDelExpectCareer)=="object") Form1.btnDelExpectCareer.onclick=function()
{
    removeChildNodes(expectCareerObj);
   ValidatorValidate(expectCareerValidatorObj);
}
if(typeof(ExpectMainCareerObj)=="object") ExpectMainCareerObj.onchange=function()
{
    onChangeOccupation(ExpectMainCareerObj,srcExpectCareerObj);
}

function expectCareerClientValidate(source,arguments)
{
    if (expectCareerObj.lengTD>0)
    {
        arguments.IsValid=true;
    }
    else
    {
        arguments.IsValid=false;
    }
}

if(typeof(ExpectMainCareerObj)=="object" && typeof(srcExpectCareerObj)=="object" && typeof(expectCareerObj)=="object")
{
    //initProvince(expectStateObj,srcExpectCityObj,"");
    InitMainOccupation(ExpectMainCareerObj,srcExpectCareerObj,"");
    initOccupationNodes(expectCareerObj,"");
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
 /*从事职业*/
var NowMainCareerObj = document.all['NowMainCareer'];
var NowCareerObj=document.all['NowCareer'];
var NowCareerValidatorObj=document.all['valNowCareer'];

if(typeof(NowMainCareerObj)=="object") NowMainCareerObj.onchange=function()
{
    onChangeNowOccupation(NowMainCareerObj,NowCareerObj);
    if(NowCareerValidatorObj != null)
    ValidatorValidate(NowCareerValidatorObj);
}
if(typeof(NowMainCareerObj)=="object" && typeof(NowCareerObj)=="object" )
{
    InitNowMainOccupation(NowMainCareerObj,NowCareerObj,"");
    for(var i=0;i<NowCareerObj.options.length;i++)
    {
      var optiontemp = NowCareerObj.options[i];
      if(optiontemp.value == "")
        optiontemp.selected = true;
    }
}
/*////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
var srcExpectCareerObj=document.all['srcExpectCareer'];
var expectCareerObj=document.all['ExpectCareer'];
var expectCareerValidatorObj=document.all['ExpectCareerValidator'];

if(typeof(Form1.btnAddExpectCareer)=="object") Form1.btnAddExpectCareer.onclick=function()
{
    addChildNodes(srcExpectCareerObj,expectCareerObj,"期望从事职业限选5项！");
    ValidatorValidate(expectCareerValidatorObj);
}
if(typeof(Form1.btnDelExpectCareer)=="object") Form1.btnDelExpectCareer.onclick=function()
{
    removeChildNodes(expectCareerObj);
    ValidatorValidate(expectCareerValidatorObj);
}

function expectCareerClientValidate(source,arguments)
{
    if (expectCareerObj.lengTD>0)
    {
        arguments.IsValid=true;
    }
    else
    {
        arguments.IsValid=false;
    }
}

if(typeof(srcExpectCareerObj)=="object" && typeof(expectCareerObj)=="object")
{
    initExpectCareerNodes(srcExpectCareerObj,expectCareerObj,"");
}
*////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/*期望从事行业*/
var srcExpectTradeObj=document.all['srcExpectTrade'];
var expectTradeObj=document.all['ExpectTrade'];

if(typeof(Form1.btnAddExpectTrade)=="object") Form1.btnAddExpectTrade.onclick=function()
{
    addChildNodes(srcExpectTradeObj,expectTradeObj,"期望从事行业限选5项！");
}
if(typeof(Form1.btnDelExpectTrade)=="object") Form1.btnDelExpectTrade.onclick=function()
{
    removeChildNodes(expectTradeObj);
}

function ExpectTradeClientValidate(source,arguments)
{
    if (expectTradeObj.lengTD>0)
    {
        arguments.IsValid=true;
    }
    else
    {
        arguments.IsValid=false;
    }
}

if(typeof(srcExpectTradeObj)=="object" && typeof(expectTradeObj)=="object")
{
    initExpectTradeNodes(srcExpectTradeObj,expectTradeObj,"");
}


/*btnSave为服务器端button*/
if(typeof(document.all['btnSave'])=="object") document.all['btnSave'].onclick=function()
{
    if(typeof(Page_ClientValidate)!='function') return false;

    Page_ClientValidate();
    if(!Page_IsValid) return false;

    selectAll(expectCityObj);
    selectAllOccupations(expectCareerObj);
    selectAll(expectTradeObj);
    return true;
}

/*ExpectWorkKindValidator*/
var workKindObjs=new Array(document.all['ExpectWorkKind_0'],document.all['ExpectWorkKind_1'],document.all['ExpectWorkKind_2'],document.all['ExpectWorkKind_3']);
var expectWorkKindValidatorObj=document.all['valExpectWorkKind'];

for(var i=0;i<4;i++)
{
    if(typeof(workKindObjs[i])=="object") workKindObjs[i].onclick=function()
    {
        ValidatorValidate(expectWorkKindValidatorObj);
    }
}

function ExpectWorkKindClientValidate(source,arguments)
{
    for(var i=0;i<4;i++)
    {
        if(workKindObjs[i].checked)
        {
            arguments.IsValid=true;
            return;
        }
    }
    arguments.IsValid=false;
}

/*JoinDateValidator*/
var joinDateTypeObj=document.all['JoinDateType'];
var joinDateObjs=new Array(document.all['JoinDateYear'],document.all['JoinDateMonth'],document.all['JoinDateDay']);
var joinDateValidatorObj=document.all['JoinDateValidator'];

joinDateTypeObj.onchange=function()
{
    for(var i=0;i<3;i++)
    {
       joinDateObjs[i].selectedIndex=0;
    }
}

for(var i=0;i<3;i++)
{
    joinDateObjs[i].onchange=function()
    {
        joinDateTypeObj.selectedIndex=0;
        if(!joinDateValidatorObj.isvalid) ValidatorValidate(joinDateValidatorObj);
    }
}

//取得mm月的总天数
//d31={1,3,5,7,8,10,12};
//d30={4,6,9,11};
//d28/d29={2}
function getMonthDays(yy,mm)
{
    if(mm==2)
    {
        if(yy%4==0 || (yy%100==0 && yy%400==0)) return 29;
        else return 28;
    }
    else if(mm==4 || mm==6 || mm==9 || mm==11) return 30;
    else return 31;
}

function JoinDateClientValidate(source,arguments)
{
    if(joinDateObjs[0].selectedIndex==0 && joinDateObjs[1].selectedIndex==0 && joinDateObjs[2].selectedIndex==0)
    {
        arguments.IsValid=true;
        return;
    }
    else if(joinDateObjs[0].selectedIndex>0 && joinDateObjs[1].selectedIndex>0 && joinDateObjs[2].selectedIndex>0)
    {
        var year=parseInt(joinDateObjs[0].value,10);
        var month=parseInt(joinDateObjs[1].value,10);
        var date=parseInt(joinDateObjs[2].value,10);

        if(date<=getMonthDays(year,month))
        {
            arguments.IsValid=true;
            return;
        }
    }
    arguments.IsValid=false;
}


/*TwoChangeClientValidate*/
var lang1Objs=new Array(document.all['sLanguageCN1'],document.all['sLevelCN1'],document.all['Language1Validator'],document.all['Level1Validator']);
var lang2Objs=new Array(document.all['sLanguageCN2'],document.all['sLevelCN2'],document.all['Language2Validator'],document.all['Level2Validator']);
var lang3Objs=new Array(document.all['sLanguageCN3'],document.all['sLevelCN3'],document.all['Language3Validator'],document.all['Level3Validator']);
/*
if(lang2Objs[0]!=null) lang2Objs[0].onchange=function()
{
    if(!lang2Objs[2].isvalid || !lang2Objs[3].isvalid)
    {
        ValidatorValidate(lang2Objs[2]);
        ValidatorValidate(lang2Objs[3]);
    }
}
if(lang2Objs[1]!=null) lang2Objs[1].onchange=function()
{
    if(!lang2Objs[2].isvalid || !lang2Objs[3].isvalid)
    {
        ValidatorValidate(lang2Objs[2]);
        ValidatorValidate(lang2Objs[3]);
    }
}

if(lang3Objs[0]!=null) lang3Objs[0].onchange=function()
{
    if(!lang3Objs[2].isvalid || !lang3Objs[3].isvalid)
    {
        ValidatorValidate(lang3Objs[2]);
        ValidatorValidate(lang3Objs[3]);
    }
}
if(lang3Objs[1]!=null) lang3Objs[1].onchange=function()
{
    if(!lang3Objs[2].isvalid || !lang3Objs[3].isvalid)
    {
        ValidatorValidate(lang3Objs[2]);
        ValidatorValidate(lang3Objs[3]);
    }
}

function TwoChangeClientValidate(source,arguments)
{

    var valObj=document.all[source.controltovalidate];
    var anotherObj=document.all[source.anothercontrol];
    arguments.IsValid=!(valObj.selectedIndex==0 && anotherObj.selectedIndex>0);
}
*/
function initTwoControls(firstObj,secondObj)
{
    if(secondObj.selectedIndex==0) secondObj.disabled=true;
    else secondObj.remove(0);
}

function changeTwoControls(firstObj,secondObj)
{
    if(firstObj.selectedIndex==0)
    {
        if(secondObj.options[0].value!="0")
        {
            secondObj.options.add(new Option("","0"),0);
            secondObj.selectedIndex=0;
        }
        secondObj.disabled=true;
    }
    else
    {
        if(secondObj.options[0].value=="0")
        {
            secondObj.remove(0);
            secondObj.selectedIndex=0;
        }
        secondObj.disabled=false;
    }
}

if(lang1Objs[0]!=null)
{
    initTwoControls(lang1Objs[0],lang1Objs[1]);
}
if(lang1Objs[0]!=null) lang1Objs[0].onchange=function()
{
    changeTwoControls(lang1Objs[0],lang1Objs[1]);
}

if(lang2Objs[0]!=null)
{
    initTwoControls(lang2Objs[0],lang2Objs[1]);
}
if(lang2Objs[0]!=null) lang2Objs[0].onchange=function()
{
    changeTwoControls(lang2Objs[0],lang2Objs[1]);
}

if(lang3Objs[0]!=null)
{
    initTwoControls(lang3Objs[0],lang3Objs[1]);
}
if(lang3Objs[0]!=null) lang3Objs[0].onchange=function()
{
    changeTwoControls(lang3Objs[0],lang3Objs[1]);
}
    </script>


<h2>自我评价/职业目标</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">

							<tr>
								<td valign="top" align="right" ><span class="alert"><strong>*&nbsp;</strong></span><strong>自我评价&nbsp;&nbsp;</strong></td>
								<td>
									<span class="note">
										<textarea class="edit_input" name="SelfValueCN" rows="4" cols="60" id="textarea"><%=summary.getSelfValue()%></textarea>
										<br>
										概述你的职业优势，如：“3年IT销售经验”、“5年外资大型企业人事经理经验”。 <br>
									（限200字。
									<a id="linkSelfValueCN" href="javascript:alert(&quot;现已输入了&quot;+document.all['SelfValueCN'].value.length+&quot;个字！&quot;);">计算字数</a>）<br>
										<span id="valSelfValue_required" controltovalidate="SelfValueCN" errormessage="请填写自我评价！" display="Dynamic" evaluationfunction="RequiredFieldValidatorEvaluateIsValid" initialvalue="" style="color:Red;display:none;">请填写自我评价！</span>
										<span id="valSelfValue_limit" controltovalidate="SelfValueCN" errormessage="自我评价限200个字！" display="Dynamic" evaluationfunction="RegularExpressionValidatorEvaluateIsValid" validationexpression="(.|\n){0,200}" style="color:Red;display:none;">自我评价限200个字！</span>								  </span>							  </td>
							</tr>
							<tr>
								<td valign="top" align="right"><strong>职业目标&nbsp;&nbsp;</strong></td>
								<td><span class="note">
										<textarea class="edit_input" name="ObjectCN" rows="7" cols="60" id="ObjectCN"><%=summary.getSelfAim()%></textarea><br>
										让招聘单位了解你的职业方向。（限500字。
										<a id="linkObjectCN" href="javascript:alert(&quot;现已输入了&quot;+document.all['ObjectCN'].value.length+&quot;个字！&quot;);">计算字数</a>）<br>
										<span id="valObject" controltovalidate="ObjectCN" errormessage="职业目标限500个字！" display="Dynamic" evaluationfunction="RegularExpressionValidatorEvaluateIsValid" validationexpression="(.|\n){0,500}" style="color:Red;display:none;">职业目标限500个字！</span><br>
									</span>
								</td>
							</tr>
	</table>



 <P ALIGN=CENTER>
            <input type="submit" name="GoBack" id="edit_GoBack" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "GoBack")%>">
            <input type=SUBMIT name="GoFinish" ID="edit_GoFinish" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "Finish")%>">
    </P>






<%/////////////////////JAVASCRIPT///////////START/////////////////%>
<script language="javascript">
var startYearObj=document.all['ymStartDate_ymYear'];
var startMonthObj=document.all['ymStartDate_ymMonth'];
var endYearObj=document.all['ymEndDate_ymYear'];
var endMonthObj=document.all['ymEndDate_ymMonth'];

function startDateClientValidate(source,arguments)
{
    arguments.IsValid=(startYearObj.selectedIndex>0);
}

function startEndDateClientValidate(source,arguments)
{
    if((startYearObj.selectedIndex>0 && startMonthObj.selectedIndex>0) && !(endYearObj.selectedIndex>0 && endMonthObj.selectedIndex==0))
    {
        var start=new Date(startYearObj.value,startMonthObj.value,1);
        var end=new Date(endYearObj.value,endMonthObj.value,1);
        arguments.IsValid=(end>=start);
    }
}

      </script>

<script language="javascript" type="text/javascript">
<!--
	var Page_ValidationSummaries =  new Array(document.all["ValidationSummary1"]);
	var Page_Validators =  new Array(document.all["valOrgName"], document.all["valOrgInfo"], document.all["valWorkSite"], document.all["valPositionName"], document.all["valStartDate"], document.all["valStartEndDate"], document.all["valFunction_1"], document.all["valFunction_2"], document.all["valReasonOfLeaving"]);
		// -->
</script>


<script language="javascript" type="text/javascript">
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




<%-------------------------------------职业概况/求职意向----------------------------------------------------%>
<script language="javascript" type="text/javascript">
<!--
	var Page_ValidationSummaries =  new Array(document.all["ValidationSummary1"]);
	var Page_Validators =  new Array(document.all["valNowTrade"], document.all["valNowCareer"], document.all["valNowCareerLevel"], document.all["valExperience_required"], document.all["valExperience_limit"], document.all["valSalarySum"], document.all["valExpectWorkKind"], document.all["ExpectCareerValidator"], document.all["AreaCityValidator"], document.all["valExpectSalarySum"], document.all["JoinDateValidator"]);
		// -->
</script>


<script language="javascript" type="text/javascript">
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





<script language="javascript" type="text/javascript">
<!--
	var Page_ValidationSummaries =  new Array(document.all["ValidationSummary1"]);
	var Page_Validators =  new Array(document.all["valNowTrade"], document.all["valNowCareer"], document.all["valNowCareerLevel"], document.all["valExperience_required"], document.all["valExperience_limit"], document.all["valSalarySum"], document.all["valExpectWorkKind"], document.all["ExpectCareerValidator"], document.all["AreaCityValidator"], document.all["valExpectSalarySum"], document.all["JoinDateValidator"]);
		// -->
</script>


<script language="javascript" type="text/javascript">
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





  </FORM>
<%-----1111111111------%>
 <script language="javascript">
        initParentList(document.all['HuKouState']);
        initParentList(document.all['ResidenceState']);
    </script>
    <script>SetSelectedValueType( 'ResidenceState',31000 );SetSelectedValueList( 'ResidenceCity',115 );SetSelectedValueType( 'HuKouState',30000 );SetSelectedValueList1( 'HuKouCity',5 );</script>

<%-------------------------------------职业概况/求职意向----------------------------------------------------%>
 <script language="javascript">
/*期望工作地区*/
var expectStateObj=document.all['ExpectState'];
var srcExpectCityObj=document.all['srcExpectCity'];
var expectCityObj=document.all['ExpectCity'];
var areaCityValidatorObj=document.all['AreaCityValidator'];

if(typeof(Form1.btnAddExpectCity)=="object") Form1.btnAddExpectCity.onclick=function()
{
    addCityNodes(expectStateObj,srcExpectCityObj,expectCityObj,"期望工作地区限选5项！");
    ValidatorValidate(areaCityValidatorObj);
}
if(typeof(Form1.btnDelExpectCity)=="object") Form1.btnDelExpectCity.onclick=function()
{
    removeChildNodes(expectCityObj);
    ValidatorValidate(areaCityValidatorObj);
}
if(typeof(expectStateObj)=="object") expectStateObj.onchange=function()
{
    onChangeProvince(document.all['ExpectState'],document.all['srcExpectCity']);
}

function areaCityClientValidate(source,arguments)
{
    if (expectCityObj.lengTD>0)
    {
        arguments.IsValid=true;
    }
    else
    {
        arguments.IsValid=false;
    }
}

if(typeof(expectStateObj)=="object" && typeof(srcExpectCityObj)=="object" && typeof(expectCityObj)=="object")
{
    //initProvince(expectStateObj,srcExpectCityObj,"");
    initProvince(expectStateObj,srcExpectCityObj,"");
    initCityNodes(expectCityObj,"");
}

/*期望从事职业*/
var ExpectMainCareerObj = document.all['ExpectMainCareer'];
var srcExpectCareerObj=document.all['srcExpectCareer'];
var expectCareerObj=document.all['ExpectCareer'];
var expectCareerValidatorObj=document.all['ExpectCareerValidator'];

if(typeof(Form1.btnAddExpectCareer)=="object") Form1.btnAddExpectCareer.onclick=function()
{
    addOccupationNodes(ExpectMainCareerObj,srcExpectCareerObj,expectCareerObj,"期望从事职业限选5项！");
    ValidatorValidate(expectCareerValidatorObj);
}
if(typeof(Form1.btnDelExpectCareer)=="object") Form1.btnDelExpectCareer.onclick=function()
{
    removeChildNodes(expectCareerObj);
   ValidatorValidate(expectCareerValidatorObj);
}
if(typeof(ExpectMainCareerObj)=="object") ExpectMainCareerObj.onchange=function()
{
    onChangeOccupation(ExpectMainCareerObj,srcExpectCareerObj);
}

function expectCareerClientValidate(source,arguments)
{
    if (expectCareerObj.lengTD>0)
    {
        arguments.IsValid=true;
    }
    else
    {
        arguments.IsValid=false;
    }
}

if(typeof(ExpectMainCareerObj)=="object" && typeof(srcExpectCareerObj)=="object" && typeof(expectCareerObj)=="object")
{
    //initProvince(expectStateObj,srcExpectCityObj,"");
    InitMainOccupation(ExpectMainCareerObj,srcExpectCareerObj,"");
    initOccupationNodes(expectCareerObj,"");
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
 /*从事职业*/
var NowMainCareerObj = document.all['NowMainCareer'];
var NowCareerObj=document.all['NowCareer'];
var NowCareerValidatorObj=document.all['valNowCareer'];

if(typeof(NowMainCareerObj)=="object") NowMainCareerObj.onchange=function()
{
    onChangeNowOccupation(NowMainCareerObj,NowCareerObj);
    if(NowCareerValidatorObj != null)
    ValidatorValidate(NowCareerValidatorObj);
}
if(typeof(NowMainCareerObj)=="object" && typeof(NowCareerObj)=="object" )
{
    InitNowMainOccupation(NowMainCareerObj,NowCareerObj,"");
    for(var i=0;i<NowCareerObj.options.length;i++)
    {
      var optiontemp = NowCareerObj.options[i];
      if(optiontemp.value == "")
        optiontemp.selected = true;
    }
}
/*////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
var srcExpectCareerObj=document.all['srcExpectCareer'];
var expectCareerObj=document.all['ExpectCareer'];
var expectCareerValidatorObj=document.all['ExpectCareerValidator'];

if(typeof(Form1.btnAddExpectCareer)=="object") Form1.btnAddExpectCareer.onclick=function()
{
    addChildNodes(srcExpectCareerObj,expectCareerObj,"期望从事职业限选5项！");
    ValidatorValidate(expectCareerValidatorObj);
}
if(typeof(Form1.btnDelExpectCareer)=="object") Form1.btnDelExpectCareer.onclick=function()
{
    removeChildNodes(expectCareerObj);
    ValidatorValidate(expectCareerValidatorObj);
}

function expectCareerClientValidate(source,arguments)
{
    if (expectCareerObj.lengTD>0)
    {
        arguments.IsValid=true;
    }
    else
    {
        arguments.IsValid=false;
    }
}

if(typeof(srcExpectCareerObj)=="object" && typeof(expectCareerObj)=="object")
{
    initExpectCareerNodes(srcExpectCareerObj,expectCareerObj,"");
}
*////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/*期望从事行业*/
var srcExpectTradeObj=document.all['srcExpectTrade'];
var expectTradeObj=document.all['ExpectTrade'];

if(typeof(Form1.btnAddExpectTrade)=="object") Form1.btnAddExpectTrade.onclick=function()
{
    addChildNodes(srcExpectTradeObj,expectTradeObj,"期望从事行业限选5项！");
}
if(typeof(Form1.btnDelExpectTrade)=="object") Form1.btnDelExpectTrade.onclick=function()
{
    removeChildNodes(expectTradeObj);
}

function ExpectTradeClientValidate(source,arguments)
{
    if (expectTradeObj.lengTD>0)
    {
        arguments.IsValid=true;
    }
    else
    {
        arguments.IsValid=false;
    }
}

if(typeof(srcExpectTradeObj)=="object" && typeof(expectTradeObj)=="object")
{
    initExpectTradeNodes(srcExpectTradeObj,expectTradeObj,"");
}


/*btnSave为服务器端button*/
if(typeof(document.all['btnSave'])=="object") document.all['btnSave'].onclick=function()
{
    if(typeof(Page_ClientValidate)!='function') return false;

    Page_ClientValidate();
    if(!Page_IsValid) return false;

    selectAll(expectCityObj);
    selectAllOccupations(expectCareerObj);
    selectAll(expectTradeObj);
    return true;
}

/*ExpectWorkKindValidator*/
var workKindObjs=new Array(document.all['ExpectWorkKind_0'],document.all['ExpectWorkKind_1'],document.all['ExpectWorkKind_2'],document.all['ExpectWorkKind_3']);
var expectWorkKindValidatorObj=document.all['valExpectWorkKind'];

for(var i=0;i<4;i++)
{
    if(typeof(workKindObjs[i])=="object") workKindObjs[i].onclick=function()
    {
        ValidatorValidate(expectWorkKindValidatorObj);
    }
}

function ExpectWorkKindClientValidate(source,arguments)
{
    for(var i=0;i<4;i++)
    {
        if(workKindObjs[i].checked)
        {
            arguments.IsValid=true;
            return;
        }
    }
    arguments.IsValid=false;
}

/*JoinDateValidator*/
var joinDateTypeObj=document.all['JoinDateType'];
var joinDateObjs=new Array(document.all['JoinDateYear'],document.all['JoinDateMonth'],document.all['JoinDateDay']);
var joinDateValidatorObj=document.all['JoinDateValidator'];

joinDateTypeObj.onchange=function()
{
    for(var i=0;i<3;i++)
    {
       joinDateObjs[i].selectedIndex=0;
    }
}

for(var i=0;i<3;i++)
{
    joinDateObjs[i].onchange=function()
    {
        joinDateTypeObj.selectedIndex=0;
        if(!joinDateValidatorObj.isvalid) ValidatorValidate(joinDateValidatorObj);
    }
}

//取得mm月的总天数
//d31={1,3,5,7,8,10,12};
//d30={4,6,9,11};
//d28/d29={2}
function getMonthDays(yy,mm)
{
    if(mm==2)
    {
        if(yy%4==0 || (yy%100==0 && yy%400==0)) return 29;
        else return 28;
    }
    else if(mm==4 || mm==6 || mm==9 || mm==11) return 30;
    else return 31;
}

function JoinDateClientValidate(source,arguments)
{
    if(joinDateObjs[0].selectedIndex==0 && joinDateObjs[1].selectedIndex==0 && joinDateObjs[2].selectedIndex==0)
    {
        arguments.IsValid=true;
        return;
    }
    else if(joinDateObjs[0].selectedIndex>0 && joinDateObjs[1].selectedIndex>0 && joinDateObjs[2].selectedIndex>0)
    {
        var year=parseInt(joinDateObjs[0].value,10);
        var month=parseInt(joinDateObjs[1].value,10);
        var date=parseInt(joinDateObjs[2].value,10);

        if(date<=getMonthDays(year,month))
        {
            arguments.IsValid=true;
            return;
        }
    }
    arguments.IsValid=false;
}


/*TwoChangeClientValidate*/
var lang1Objs=new Array(document.all['sLanguageCN1'],document.all['sLevelCN1'],document.all['Language1Validator'],document.all['Level1Validator']);
var lang2Objs=new Array(document.all['sLanguageCN2'],document.all['sLevelCN2'],document.all['Language2Validator'],document.all['Level2Validator']);
var lang3Objs=new Array(document.all['sLanguageCN3'],document.all['sLevelCN3'],document.all['Language3Validator'],document.all['Level3Validator']);
/*
if(lang2Objs[0]!=null) lang2Objs[0].onchange=function()
{
    if(!lang2Objs[2].isvalid || !lang2Objs[3].isvalid)
    {
        ValidatorValidate(lang2Objs[2]);
        ValidatorValidate(lang2Objs[3]);
    }
}
if(lang2Objs[1]!=null) lang2Objs[1].onchange=function()
{
    if(!lang2Objs[2].isvalid || !lang2Objs[3].isvalid)
    {
        ValidatorValidate(lang2Objs[2]);
        ValidatorValidate(lang2Objs[3]);
    }
}

if(lang3Objs[0]!=null) lang3Objs[0].onchange=function()
{
    if(!lang3Objs[2].isvalid || !lang3Objs[3].isvalid)
    {
        ValidatorValidate(lang3Objs[2]);
        ValidatorValidate(lang3Objs[3]);
    }
}
if(lang3Objs[1]!=null) lang3Objs[1].onchange=function()
{
    if(!lang3Objs[2].isvalid || !lang3Objs[3].isvalid)
    {
        ValidatorValidate(lang3Objs[2]);
        ValidatorValidate(lang3Objs[3]);
    }
}

function TwoChangeClientValidate(source,arguments)
{

    var valObj=document.all[source.controltovalidate];
    var anotherObj=document.all[source.anothercontrol];
    arguments.IsValid=!(valObj.selectedIndex==0 && anotherObj.selectedIndex>0);
}
*/
function initTwoControls(firstObj,secondObj)
{
    if(secondObj.selectedIndex==0) secondObj.disabled=true;
    else secondObj.remove(0);
}

function changeTwoControls(firstObj,secondObj)
{
    if(firstObj.selectedIndex==0)
    {
        if(secondObj.options[0].value!="0")
        {
            secondObj.options.add(new Option("","0"),0);
            secondObj.selectedIndex=0;
        }
        secondObj.disabled=true;
    }
    else
    {
        if(secondObj.options[0].value=="0")
        {
            secondObj.remove(0);
            secondObj.selectedIndex=0;
        }
        secondObj.disabled=false;
    }
}

if(lang1Objs[0]!=null)
{
    initTwoControls(lang1Objs[0],lang1Objs[1]);
}
if(lang1Objs[0]!=null) lang1Objs[0].onchange=function()
{
    changeTwoControls(lang1Objs[0],lang1Objs[1]);
}

if(lang2Objs[0]!=null)
{
    initTwoControls(lang2Objs[0],lang2Objs[1]);
}
if(lang2Objs[0]!=null) lang2Objs[0].onchange=function()
{
    changeTwoControls(lang2Objs[0],lang2Objs[1]);
}

if(lang3Objs[0]!=null)
{
    initTwoControls(lang3Objs[0],lang3Objs[1]);
}
if(lang3Objs[0]!=null) lang3Objs[0].onchange=function()
{
    changeTwoControls(lang3Objs[0],lang3Objs[1]);
}
    </script>




  <script>Form1.FirstName.focus();</script>
</DIV><div id="head6"><img height="6" src="about:blank"></div>  <div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</HTML>

