<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>
<%
 if(!node.isCreator(teasession._rv))
 {
   response.sendError(403);
   return;
 }
int id=0;
if(teasession.getParameter("id")!=null)
id=Integer.parseInt(teasession.getParameter("id"));
Employment employment=Employment.find(id);
%>
<!doctype html public "-//w3c//dtd html 4.0 transitional//en" >
<html>
<head>
<script src="/tea/tea.js" type="text/javascript"></script>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<title>工作经验</title>
<meta content="SharePoint.WebPartPage.Document" name="ProgId">
<meta content="full" name="WebPartPageExpansion">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
<meta content="C#" name="CODE_LANGUAGE">
<meta content="JavaScript" name="vs_defaultClientScript">
<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
<link href="/styles/e_resume.css" rel="stylesheet" type="text/css">
<link href="/Styles/default.css" type="text/css" rel="stylesheet">
<link href="/styles/topmenu.css" type="text/css" rel="stylesheet">
</head>
<body bottommargin="0" leftmargin="0" topmargin="0" rightmargin="0" ms_positioning="FlowLayout">
<h1><%=r.getString(teasession._nLanguage, "EditWaiterEmployment")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<form name="Form1" method="post" action="/servlet/EditEmployments" language="javascript" onsubmit="if (!ValidatorOnSubmit()) return false;" id="Form1">
  <input type="hidden" name="nexturl" value="<%=request.getRequestURI()+"?"+request.getQueryString()%>"/>
  <%
          String paramNode="";
          int currentlyNode=0;
          if(request.getParameter("Node")!=null)
          {
              out.println("<input type=hidden name=Node value="+teasession._nNode+" />");
              paramNode="Node="+teasession._nNode;
              currentlyNode=teasession._nNode;
          }
%>
  <input type="hidden" name="id" value="<%=id%>" />
  <script language="javascript" type="text/javascript" src="/tea/CssJs/WebUIValidation.js"></script>
  <script language="javascript">

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
  <link href="/styles/topmenu.css" type="text/css" rel="stylesheet">
  <script language="javascript">
  document.all('tblSecondMenu').rows(0).cells(4).className='bg2';
 document.all('tblSecondMenu').rows(0).cells(4).onmouseout='';
 document.all('a30').className='menuLink';
</script>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <%java.util.Enumeration enumeration=Employment.find(currentlyNode,teasession._nLanguage);
                while(enumeration.hasMoreElements()){
                   Employment educateobj=Employment.find(((Integer)enumeration.nextElement()).intValue());
                %>
    <tr>
      <td><%=educateobj.getOrgName()%></td>
      <td><%=educateobj.getStartDate("yyyy/MM")%>--<%=educateobj.getEndDate("yyyy/MM")%></td>
      <td><%=educateobj.getWorkSite()%></td>
      <td><%=educateobj.getPositionName()%></td>
      <td><input class="edit_button" type=button name=Edit value=编辑 onclick="window.open('EditEmployment.jsp?id=<%=educateobj.getId()%>&<%=paramNode%>','_self')"/>
        <input class="edit_button" type=button name=Edit value=删除 onclick="if(confirm('确认删除?')){window.open('/servlet/DeleteEmployment?id=<%=educateobj.getId()%>','_self')};"/>
      </td>
    </tr>
    <%} %>
  </table>
  <table border="0" cellpadding="0" cellspacing="0">
    <tr>
      <td>新增工作经验</td>
    </tr>
    <tr>
      <td><table border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td valign="baseline" align="right"><span class="alert"><strong>*&nbsp;</strong></span><strong>公司名称</strong>&nbsp;&nbsp;</td>
            <td><input name="tbOrgName" value="<%=employment.getOrgName()%>" class="edit_input" id="tbOrgName" type="text" maxlength="120" size="30" />
              <br>
              <span id="valOrgName" controltovalidate="tbOrgName" errormessage="请填写公司名称！" display="Dynamic" evaluationfunction="RequiredFieldValidatorEvaluateIsValid" initialvalue="" style="color:Red;display:none;">请填写公司名称！</span></td>
          </tr>
          <tr>
            <td valign="top" align="right"><strong>公司简单介绍</strong>&nbsp;&nbsp;</td>
            <td><textarea name="tbOrgInfo" id="tbOrgInfo" class="edit_input" rows="3" cols="60"><%=employment.getOrgInfo()%></textarea>
              <span class="note"> <br>
              了解你所任职的公司，有助于我们对你的了解。如：国内知名的大型机械制造企业（限300字）<br>
              <span class="cell">在该公司的工作经验－每次填写一个岗位的经验，可多次添加</span> <br>
              <span id="valOrgInfo" controltovalidate="tbOrgInfo" errormessage="公司简单介绍限300个字！" display="Dynamic" evaluationfunction="RegularExpressionValidatorEvaluateIsValid" validationexpression="(.|\n){0,300}" style="color:Red;display:none;">公司简单介绍限300个字！</span> </span> </td>
          </tr>
        </table>
        <table border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td align="right" valign="baseline"><span class="alert"><strong>*</strong></span><strong>&nbsp;工作地点</strong>&nbsp;&nbsp;</td>
            <td><input class="edit_input" name="tbWorkSite" value="<%=employment.getWorkSite()%>" id="tbWorkSite" type="text" size="30" maxlength="30" />
              <br>
              <span id="valWorkSite" controltovalidate="tbWorkSite" errormessage="请填写工作地点！" display="Dynamic" evaluationfunction="RequiredFieldValidatorEvaluateIsValid" initialvalue="" style="color:Red;display:none;">请填写工作地点！</span></td>
          </tr>
          <tr>
            <td align="right"><strong>所在部门</strong>&nbsp;&nbsp;</td>
            <td><input name="tbDepartment" class="edit_input" value="<%=employment.getDepartment()%>" id="tbDepartment" type="text" size="30" maxlength="50" /></td>
          </tr>
          <tr>
            <td align="right" valign="baseline"><span class="alert"><strong>*</strong></span><strong>&nbsp;职位名称</strong>&nbsp;&nbsp;</td>
            <td><input class="edit_input" name="tbPositionName" value="<%=employment.getPositionName()%>" id="tbPositionName" type="text" size="30" maxlength="60" />
              <br>
              <span id="valPositionName" controltovalidate="tbPositionName" errormessage="请填写职位名称！" display="Dynamic" evaluationfunction="RequiredFieldValidatorEvaluateIsValid" initialvalue="" style="color:Red;display:none;">请填写职位名称！</span></td>
          </tr>
          <tr>
            <td valign="baseline" align="right"><span class="alert"><strong>*</strong></span><strong>&nbsp;开始时间</strong>&nbsp;&nbsp;</td>
            <td><select name="ymStartDate:ymYear" id="ymStartDate_ymYear" onChange="javascript: ValidatorValidate(document.all['valStartDate']);;var yearObj=document.all['ymStartDate_ymYear'];var monthObj=document.all['ymStartDate_ymMonth'];if(yearObj.selectedIndex==0){if(monthObj.options[0].value!=''){monthObj.options.add(new Option('',''),0);monthObj.selectedIndex=0;}monthObj.disabled=true;}else{if(monthObj.options[0].value==''){monthObj.remove(0);monthObj.selectedIndex=0;}monthObj.disabled=false;}">
                <option selected="selected" value="3000"></option>
                <option value="2005">2005</option>
                <option value="2004">2004</option>
                <option value="2003">2003</option>
                <option value="2002">2002</option>
                <option value="2001">2001</option>
                <option value="2000">2000</option>
                <option value="1999">1999</option>
                <option value="1998">1998</option>
                <option value="1997">1997</option>
                <option value="1996">1996</option>
                <option value="1995">1995</option>
                <option value="1994">1994</option>
                <option value="1993">1993</option>
                <option value="1992">1992</option>
                <option value="1991">1991</option>
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
                <option value="1980">1980</option>
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
              </select>
              年
              <select name="ymStartDate:ymMonth" id="ymStartDate_ymMonth" disabled="disabled">
                <option selected="selected" value=""></option>
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
              月 <br>
              <span id="valStartDate" errormessage="请选择开始时间！" display="Dynamic" evaluationfunction="CustomValidatorEvaluateIsValid" clientvalidationfunction="startDateClientValidate" style="color:Red;display:none;">请选择开始时间！</span></td>
          </tr>
          <tr>
            <td align="right" valign="baseline"><span class="alert"><strong>*</strong></span><strong>&nbsp;结束时间</strong>&nbsp;&nbsp;</td>
            <td valign="middle"><select name="ymEndDate:ymYear" id="ymEndDate_ymYear" onChange="javascript: ;var yearObj=document.all['ymEndDate_ymYear'];var monthObj=document.all['ymEndDate_ymMonth'];if(yearObj.selectedIndex==0){if(monthObj.options[0].value!=''){monthObj.options.add(new Option('',''),0);monthObj.selectedIndex=0;}monthObj.disabled=true;}else{if(monthObj.options[0].value==''){monthObj.remove(0);monthObj.selectedIndex=0;}monthObj.disabled=false;}">
                <option selected="selected" value="3000">现在</option>
                <option value="2005">2005</option>
                <option value="2004">2004</option>
                <option value="2003">2003</option>
                <option value="2002">2002</option>
                <option value="2001">2001</option>
                <option value="2000">2000</option>
                <option value="1999">1999</option>
                <option value="1998">1998</option>
                <option value="1997">1997</option>
                <option value="1996">1996</option>
                <option value="1995">1995</option>
                <option value="1994">1994</option>
                <option value="1993">1993</option>
                <option value="1992">1992</option>
                <option value="1991">1991</option>
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
                <option value="1980">1980</option>
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
              </select>
              年
              <select name="ymEndDate:ymMonth" id="ymEndDate_ymMonth" disabled="disabled">
                <option selected="selected" value=""></option>
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
              月 <span class="note">如果是当前工作，请选择“现在”<br>
              <span id="valStartEndDate" errormessage="请输入正确的开始时间或结束时间！" display="Dynamic" evaluationfunction="CustomValidatorEvaluateIsValid" clientvalidationfunction="startEndDateClientValidate" style="color:Red;display:none;">请输入正确的开始时间或结束时间！</span></span></td>
          </tr>
          <tr>
            <td align="right" valign="top"><span class="alert"><strong>*</strong></span><strong>&nbsp;工作职责和业绩</strong>&nbsp;&nbsp;</td>
            <td><font size="2">
              <textarea name="tbFunction" class="edit_input" id="tbFunction" rows="7" wrap="VIRTUAL" cols="60"><%=employment.getFunction()%></textarea>
              </font><span class="note"> （限2000字）</span><br>
              <span id="valFunction_1" controltovalidate="tbFunction" errormessage="请填写工作职责和业绩！" display="Dynamic" evaluationfunction="RequiredFieldValidatorEvaluateIsValid" initialvalue="" style="color:Red;display:none;">请填写工作职责和业绩！</span> <span id="valFunction_2" controltovalidate="tbFunction" errormessage="工作职责和业绩限2000个字！" display="Dynamic" evaluationfunction="RegularExpressionValidatorEvaluateIsValid" validationexpression="(.|\n){0,2000}" style="color:Red;display:none;">工作职责和业绩限2000个字！</span> </td>
          </tr>
          <tr>
            <td align="right" valign="top"><strong>离职/转岗原因</strong>&nbsp;&nbsp;</td>
            <td><input  class="edit_input" name="tbReasonOfLeaving"  value="<%=employment.getReasonOfLeaving()%>" id="tbReasonOfLeaving" type="text" maxlength="100" size="60" />
              <span id="valReasonOfLeaving" controltovalidate="tbReasonOfLeaving" errormessage="离职/转岗原因限100个字！" display="Dynamic" evaluationfunction="RegularExpressionValidatorEvaluateIsValid" validationexpression="(.|\n){0,100}" style="color:Red;display:none;">离职/转岗原因限100个字！</span> </td>
          </tr>
          <tr>
            <td colspan="2">&nbsp;</td>
          </tr>
        </table></td>
    </tr>
    <tr>
      <td><table border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td></td>
            <td><input type="submit"  class="edit_button" name="btnSaveAndNew" value="保存 &amp; 新增工作经验" onclick="if (typeof(Page_ClientValidate) == 'function') Page_ClientValidate(); " language="javascript" id="btnSaveAndNew" /></td>
          </tr>
        </table>
        <br>
        <div id="ValidationSummary1" headertext="你现在无法保存。原因是：" showmessagebox="True" showsummary="False" style="color:Red;display:none;"> </div></td>
    </tr>
  </table>
  <input type="submit" class="edit_button" name="btnSaveAndNext" value="关闭" onclick="javaScript:window.close(); " language="javascript"  />
  <input type="button" class="edit_button" name="btnSaveAndNext" value="完成" onClick="window.open('/jsp/type/waiter/WaiterList.jsp?node=<%=node.getFather()%>&zone=0','_self')" language="javascript"  />
  <br>
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
</form>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</html>

