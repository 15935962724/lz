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
Educate educate=Educate.find(id);
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html>
<head>
<script src="/tea/tea.js" type="text/javascript"></script>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<title>教育背景</title>
<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
<meta content="C#" name="CODE_LANGUAGE">
<meta content="JavaScript" name="vs_defaultClientScript">
<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
</head>
<body bottommargin="0" leftmargin="0" topmargin="0" rightmargin="0" ms_positioning="FlowLayout">
<h1><%=r.getString(teasession._nLanguage, "Education")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
  <form name="Form1" method="post" action="/servlet/EditEducate" language="javascript" onsubmit="if (!ValidatorOnSubmit()) return false;" id="Form1">
    <%
          if(request.getParameter("Node")!=null)
          {
              out.println("<input type=hidden name=Node value="+teasession._nNode+" />");
          }
          %>
    <input type="hidden" name="nexturl" value="<%=request.getRequestURI()+"?"+request.getQueryString()%>"/>
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

      <%java.util.Enumeration enumeration=Educate.find(teasession._nNode,teasession._nLanguage);
                while(enumeration.hasMoreElements()){
                   Educate educateobj=Educate.find(((Integer)enumeration.nextElement()).intValue());

                %>
      <tr>
        <td><%=educateobj.getStart("yyyy/MM")%>--<%=educateobj.getStop("yyyy/MM")%></td>
        <td><%=educateobj.getSchool()%></td>
        <td><%=educateobj.getMajorName()%></td>
        <td><%=educateobj.getDegree(1)%></td>
        <td><input class="edit_button" type=button name=Edit value=编辑 onclick="window.open('EditEducate.jsp?id=<%=educateobj.getId()%>&node=<%=teasession._nNode%>','_self')"/>
          <input  class="edit_button" type=button name=Edit value=删除 onclick="if(confirm('确认删除？')){window.open('/servlet/DeleteEducate?id=<%=educateobj.getId()%>&node=<%=teasession._nNode%>&nexturl=<%=request.getRequestURI()+"?"+request.getQueryString()%>','_self')};"/>
        </td>
      </tr>
      <%} %>
    </table>
    <br>
<table border="0" cellpadding="0" cellspacing="0">
      <tr>
        <td><div align="left">新增教育背景</div></td>
      </tr>
      <tr>
        <td><table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
            <tr>
              <td valign="baseline" align="right"><span class="alert"><strong>*</strong></span><strong>&nbsp;开始时间&nbsp;</strong></td>
              <td><select name="ymStartDate:ymYear" id="ymStartDate_ymYear" onChange="javascript: ValidatorValidate(document.all['valStartDate']);;var yearObj=document.all['ymStartDate_ymYear'];var monthObj=document.all['ymStartDate_ymMonth'];if(yearObj.selectedIndex==0){if(monthObj.options[0].value!=''){monthObj.options.add(new Option('',''),0);monthObj.selectedIndex=0;}monthObj.disabled=true;}else{if(monthObj.options[0].value==''){monthObj.remove(0);monthObj.selectedIndex=0;}monthObj.disabled=false;}">
                  <option selected="selected" value="3000"></option>
                  <%String str=educate.getStart("yyyy");
            for(int len=2005;len>=1950;len--)
         {
                out.print("<option value=\""+len+"\">"+len+"</option>");
        }
            %>
                </select>
                <select name="ymStartDate:ymMonth" id="ymStartDate_ymMonth" disabled="disabled">
                  <option value=""></option>
                  <option value="1">1</option>
                  <option value="2">2</option>
                  <option value="3">3</option>
                  <option value="4">4</option>
                  <option value="5">5</option>
                  <option value="6">6</option>
                  <option value="7">7</option>
                  <option value="8">8</option>
                  <option selected="selected" value="9">9</option>
                  <option value="10">10</option>
                  <option value="11">11</option>
                  <option value="12">12</option>
                </select>
                月
                <script>Form1.ymStartDate:ymMonth.options[Form1.ymStartDate:ymMonth.selectedIndex].text='<%=educate.getStart("MM")%>';</script>
                <%=educate.getStart("MM")%> </td>
            </tr>
            <tr>
              <td></td>
              <td><span id="valStartDate" errormessage="请选择开始时间！" display="Dynamic" evaluationfunction="CustomValidatorEvaluateIsValid" clientvalidationfunction="startDateClientValidate" style="color:Red;display:none;">请选择开始时间！</span></td>
            </tr>
            <tr>
              <td align="right" valign="baseline"><span class="alert"><strong>*</strong></span><strong>&nbsp;结束时间&nbsp;&nbsp;</strong></td>
              <td><select name="ymEndDate:ymYear" id="ymEndDate_ymYear" onChange="javascript: ValidatorValidate(document.all['valEndDate']);;var yearObj=document.all['ymEndDate_ymYear'];var monthObj=document.all['ymEndDate_ymMonth'];if(yearObj.selectedIndex==0){if(monthObj.options[0].value!=''){monthObj.options.add(new Option('',''),0);monthObj.selectedIndex=0;}monthObj.disabled=true;}else{if(monthObj.options[0].value==''){monthObj.remove(0);monthObj.selectedIndex=0;}monthObj.disabled=false;}">
                  <option selected="selected" value="3000"></option>
                  <option value="2011">2011</option>
                  <option value="2010">2010</option>
                  <option value="2009">2009</option>
                  <option value="2008">2008</option>
                  <option value="2007">2007</option>
                  <option value="2006">2006</option>
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
                月 </td>
            </tr>
            <tr>
              <td align="right" valign="baseline"><span class="alert"><strong>*</strong></span><strong>&nbsp;学校名称&nbsp;&nbsp;</strong></td>
              <td><input class="edit_input" name="tbSchoolName" id="tbSchoolName" type="text" maxlength="100" size="40" value="<%=educate.getSchool()%>" /></td>
            </tr>
            <tr>
              <td align="right" valign="baseline"><strong>城市&nbsp;&nbsp;</strong></td>
              <td><font size="2">
                <input class="edit_input" name="tbRegion" id="tbRegion" type="text" size="20" maxlength="30"  value="<%=educate.getCity()%>"/>
                </font> </td>
            </tr>
            <tr>
              <td align="right" valign="baseline"><span class="alert"><strong>*</strong></span><strong>&nbsp;专业类别&nbsp;&nbsp;</strong></td>
              <td><%=new MajorSelection("ddlMajorCategory",educate.getMajorCategory())%> </td>
            </tr>
            <tr>
              <td></td>
              <td><span id="valMajorCategory" controltovalidate="ddlMajorCategory" errormessage="请选择专业类别！" display="Dynamic" evaluationfunction="CompareValidatorEvaluateIsValid" valuetocompare="0" operator="GreaterThan" style="color:Red;display:none;">请选择专业类别！</span></td>
            </tr>
            <tr>
              <td align="right" valign="baseline"><span class="alert"><strong>*</strong></span><strong>&nbsp;专业名称或研究方向&nbsp;&nbsp;</strong></td>
              <td><input class="edit_input" name="tbMajorName" id="tbMajorName" type="text" maxlength="50" size="40"  value="<%=educate.getMajorName()%>"/></td>
            </tr>
            <tr>
              <td></td>
              <td><span id="valMajorName" controltovalidate="tbMajorName" errormessage="请填写专业名称！" display="Dynamic" evaluationfunction="RequiredFieldValidatorEvaluateIsValid" initialvalue="" style="color:Red;display:none;">请填写专业名称！</span></td>
            </tr>
            <tr>
              <td align="right" valign="baseline"><span class="alert"><strong>*</strong></span><strong>&nbsp;学历&nbsp;&nbsp;</strong></td>
              <td><font size="2"><%=new DegreeSelection("ddlDegree")%></font></td>
            </tr>
            <tr>
              <td></td>
              <td><span id="valDegree" controltovalidate="ddlDegree" errormessage="请选择学历！" display="Dynamic" evaluationfunction="RequiredFieldValidatorEvaluateIsValid" initialvalue="" style="color:Red;display:none;">请选择学历！</span> </td>
            </tr>
            <tr>
              <td valign="top" align="right"><strong>专业描述&nbsp;&nbsp; </strong></td>
              <td><textarea  class="edit_input" name="tbComment" id="tbComment" rows="5" cols="60"><%=educate.getComment()%></textarea>
                <br>
                <span class="note">重点描述与你就业期望有关的信息。（限800字。</span> <a id="linkComment" href="javascript:alert(&quot;现已输入了&quot;+document.all['tbComment'].value.length+&quot;个字！&quot;);">计算字数</a>）<br>
                <span id="valComment" controltovalidate="tbComment" errormessage="专业描述限800个字！" display="Dynamic" evaluationfunction="RegularExpressionValidatorEvaluateIsValid" validationexpression="(.|\n){0,800}" style="color:Red;display:none;">专业描述限800个字！</span></td>
            </tr>
          </table></td>
      </tr>
      <tr>
        <td><!--
            <table cellspacing="0" cellpadding="0"  border="0">
              <tr>
                <td height="10"><img height="1" src="../images/spacer.gif" width="1"></td>
              </tr>
              <tr>
                <td background="../images/line_x.gif" height="1"><img height="1" src="../images/spacer.gif" width="1"></td>
              </tr>
            </table>
            -->
        </td>
      </tr>
      <tr>
        <td><br>
     <table border="0" cellpadding="0" cellspacing="0">
            <tr>
              <td></td>
              <td><input  class="edit_button" type="submit" name="btnSave" value="保存&amp;新增教育背景" onclick="if (typeof(Page_ClientValidate) == 'function') Page_ClientValidate(); " language="javascript" id="btnSave" />
&nbsp; </td>
            </tr>
          </table>
          <br>
          <div id="ValidationSummary1" headertext="你现在无法保存。原因是：" showmessagebox="True" showsummary="False" style="color:Red;display:none;"> </div></td>
      </tr>
    </table>
    <br>
    <script language="javascript" type="text/javascript">
<!--
	var Page_ValidationSummaries =  new Array(document.all["ValidationSummary1"]);
	var Page_Validators =  new Array(document.all["valStartDate"], document.all["valEndDate"], document.all["valStartEndDate"], document.all["valSchoolName"], document.all["valMajorCategory"], document.all["valMajorName"], document.all["valDegree"], document.all["valComment"]);
		// -->
</script>
    <input type="submit" class="edit_button" name="btnSaveAndNext2" value="关闭" onClick="javaScript:window.close(); " language="javascript"  />
    <input type="button" class="edit_button" name="btnSaveAndNext" value="完成" onClick="window.open('/jsp/type/waiter/WaiterList.jsp?node=<%=node.getFather()%>&zone=0','_self')" language="javascript"  />
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
  <script language="javascript">
var startYearObj=document.all['ymStartDate_ymYear'];
var startMonthObj=document.all['ymStartDate_ymMonth'];
var endYearObj=document.all['ymEndDate_ymYear'];
var endMonthObj=document.all['ymEndDate_ymMonth'];

function startDateClientValidate(source,arguments)
{
    arguments.IsValid=(startYearObj.selectedIndex>0);
}

function endDateClientValidate(source,arguments)
{
    arguments.IsValid=(endYearObj.selectedIndex>0);
}

function startEndDateClientValidate(source,arguments)
{
    if(startYearObj.selectedIndex>0 && startMonthObj.selectedIndex>0 && endYearObj.selectedIndex>0 && endMonthObj.selectedIndex>0)
    {
        var start=new Date(startYearObj.value,startMonthObj.value,1);
        var end=new Date(endYearObj.value,endMonthObj.value,1);
        arguments.IsValid=(end>=start);
    }
}
    </script>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</html>

