<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.entity.convert.*"%>
<%@page import="com.jacob.com.*"%><%

Http h=new Http(request,response);
//TeaSession ts=new TeaSession(request);
//if(ts._rv==null)
//{
//  out.print("<script>top.location='/servlet/StartLogin'</script>");
//  return;
//}

Dispatch dp=Dispatch.get(Paper.P2F,"DefaultBatchProcessingOptions").toDispatch();

Dispatch xls=Dispatch.get(dp,"ExcelOptions").toDispatch();
Dispatch ppt=Dispatch.get(dp,"PowerPointOptions").toDispatch();

Conf co=Conf.find(h.community);



%><!DOCTYPE html><html>
<head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>高级设置</h1>

<form name="form1" action="/Papers.do?repository=paper" method="post" enctype="multipart/form-data" target="_ajax" onSubmit="return mt.check(this)">
<input type="hidden" name="act" value="batch"/>
<input type="hidden" name="nexturl"/>

<h2>日志</h2>
<table id="tablecenter">
  <tr>
    <td>选项</td>
    <td><input type="checkbox" name="CreateLogFile" id="CreateLogFile"/><label for="CreateLogFile">生成日志文件</label></td>
  </tr>
  <tr>
    <td>文件名</td>
    <td><input name="LogFileName" value="<%=co.get("LogFileName")%>" usemap="<%=application.getRealPath("/res/"+h.community+"/paper/conv.log")%>"/></td>
  </tr>
  <tr>
    <td>类型</td>
    <td usemap="<%=Dispatch.get(dp,"LoggingLevel")%>"><%
    int tf=co.getInt("LoggingLevel");
    String[] LEVEL={"正常","详细"};
    for(int i=0;i<LEVEL.length;i++)
    {
      out.print("<input type='radio' name='LoggingLevel' value='"+i+"' id='o"+i+"'");
      if(tf==i)out.print(" checked");
      out.print(" /><label for='o"+i+"'>"+LEVEL[i]+"</label>　");
    }
    %></td>
  </tr>
</table>

<h2>特殊</h2>
<table id="tablecenter">
  <tr>
    <td>UseAutomation</td>
    <td><input name="UseAutomation" value="<%=co.get("UseAutomation")%>" usemap="<%=Dispatch.get(dp,"UseAutomation")%>"/></td>
  </tr>
  <tr>
    <td>KeepAutomationAppRef</td>
    <td><input name="KeepAutomationAppRef" value="<%=co.get("KeepAutomationAppRef")%>" usemap="<%=Dispatch.get(dp,"KeepAutomationAppRef")%>"/></td>
  </tr>
  <tr>
    <td>KillAllAutomationProcesses</td>
    <td><input name="KillAllAutomationProcesses" value="<%=co.get("KillAllAutomationProcesses")%>" usemap="<%=Dispatch.get(dp,"KillAllAutomationProcesses")%>"/></td>
  </tr>
  <tr>
    <td colspan="2"><h2>Excel</h2></td>
  </tr>
  <tr>
    <td>OverridePrintQuality</td>
    <td><input name="OverridePrintQuality" value="<%=co.get("OverridePrintQuality")%>" usemap="<%=Dispatch.get(xls,"OverridePrintQuality")%>"/></td>
  </tr>
  <tr>
    <td>SheetRange</td>
    <td><input name="SheetRange" value="<%=co.get("SheetRange")%>" usemap="<%=Dispatch.get(xls,"SheetRange")%>"/></td>
  </tr>
  <tr>
    <td colspan="2"><h2>PowerPoint</h2></td>
  </tr>
  <tr>
    <td>选项</td>
    <td><input type="checkbox" name="FitToPage" id="FitToPage"/><label for="FitToPage">根据纸张调整大小</label></td>
  </tr>
</table>

<h2>异常</h2>
<table id="tablecenter">
  <tr>
    <td>ActivityTimeout</td>
    <td><input name="ActivityTimeout" value="<%=co.get("ActivityTimeout")%>" usemap="<%=Dispatch.get(dp,"ActivityTimeout")%>"/></td>
  </tr>
  <tr>
    <td>AfterPrintingTimeout</td>
    <td><input name="AfterPrintingTimeout" value="<%=co.get("AfterPrintingTimeout")%>" usemap="<%=Dispatch.get(dp,"AfterPrintingTimeout")%>"/></td>
  </tr>
  <tr>
    <td>BeforePrintingTimeout </td>
    <td><input name="BeforePrintingTimeout" value="<%=co.get("BeforePrintingTimeout")%>" usemap="<%=Dispatch.get(dp,"BeforePrintingTimeout")%>"/></td>
  </tr>
  <tr>
    <td>KillProcessIfTimeout</td>
    <td><input name="ActivityTimeout" value="<%=co.get("ActivityTimeout")%>" usemap="<%=Dispatch.get(dp,"ActivityTimeout")%>"/></td>
  </tr>
  <tr>
    <td>KillSplWOW64</td>
    <td><input name="KillSplWOW64" value="<%=co.get("KillSplWOW64")%>" usemap="<%=Dispatch.get(dp,"KillSplWOW64")%>"/></td>
  </tr>
  <tr>
    <td>PressPrintButton</td>
    <td><input name="PressPrintButton" value="<%=co.get("PressPrintButton")%>" usemap="<%=Dispatch.get(dp,"PressPrintButton")%>"/></td>
  </tr>
  <tr>
    <td>PrintingTimeout</td>
    <td><input name="PrintingTimeout" value="<%=co.get("PrintingTimeout")%>" usemap="<%=Dispatch.get(dp,"PrintingTimeout")%>"/></td>
  </tr>
</table>


<h2>其它</h2>
<table id="tablecenter">
  <tr>
    <td>PageRange</td>
    <td><input name="PageRange" value="<%=co.get("PageRange")%>" usemap="<%=Dispatch.get(dp,"PageRange")%>"/></td>
  </tr>
  <tr>
    <td>GenerateExternalViewer</td>
    <td><input name="GenerateExternalViewer" value="<%=co.get("GenerateExternalViewer")%>" usemap="<%=Dispatch.get(dp,"GenerateExternalViewer")%>"/></td>
  </tr>
</table>

<br/>
<input class="but2" type="submit" value="提　交"/> <input class="but2" type="button" value="重　置" onclick="mt.reset()"/>
</form>

<script>
form1.nexturl.value=location.pathname+location.search;
form1.CreateLogFile.usemap=<%=Dispatch.get(dp,"CreateLogFile")%>;
form1.CreateLogFile.checked=<%=co.get("CreateLogFile")%>;

form1.FitToPage.usemap=<%=Dispatch.get(ppt,"FitToPage")%>;
form1.FitToPage.checked=<%=co.get("FitToPage")%>;

mt.reset=function()
{
  var arr=form1.elements;
  for(var i=0;i<arr.length;i++)
  {
    var t=arr[i].getAttribute('usemap');
    if(arr[i].type=='text')
    arr[i].value=t;
  }
};
mt.focus();
</script>
</body>
</html>
