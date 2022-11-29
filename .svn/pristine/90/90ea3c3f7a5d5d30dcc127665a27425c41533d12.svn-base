<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>

<%
Job job= Job.find(teasession._nNode,teasession._nLanguage);
%>
<html>
<head>
<title>职位详细介绍</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style type="text/css">
<!--
h1{background-image:url(/tea/image/section/11443.jpg);background-repeat: no-repeat;height:18px;line-height:18px;font-weight:100;font-size:9pt;color:#ffffff;padding-left:35px;padding-top:2px;padding-bottom:2px;margin:0px;margin-bottom:5px;clear: both;}
#zhiweinei{border:2px solid #ffffff;}
#zhiweiwai{border:2px solid #0A6CCE;width:496px;}
body,td,th {
	font-size: 9pt;
}
.in{border:1px solid #1470BD;background:#ffffff;color:#1470BD;padding-top:3px;
	line-height:12px;cursor:hand;}
-->
</style>
<script language="JavaScript" type="text/JavaScript">
<!--
function MM_callJS(jsStr) { //v2.0
  return eval(jsStr)
}
//-->
</script>

</head>
<body><div id="zhiweiwai" ><div id="zhiweinei">
<h1 style="margin-bottom:0px;">职位详细介绍</h1>
<table  width="488"  border="1" cellpadding="2" cellspacing="0" bordercolor="#C3C3C3" style="border-collapse:collapse;">
  <tr>
    <td height="25" nowrap width="100px"><div align="left"><span>职位编号：</span></div></td>
    <td width="350px"><div align="left"><span><Span ID=JobIDJobCode><%=job.getTxtRefCode()%></Span></span></div></td>
  </tr>
  <tr>
    <td height="25" nowrap><div  align="left"><span >职位名称：</span></div></td>
    <td><div align="left"><span><Span ID=JobIDname><A href="/servlet/Node?node=<%=teasession._nNode%>" target="_blank"><%=job.getName()%></A></Span></span></div></td>
  </tr>
  <tr>
    <td height="25" nowrap><div  align="left"><span >所属机构：</span></div></td>
    <td><div align="left"><span><Span ID=JobIDOrgId><A href="/servlet/Node?node=<%=job.getSltOrgId()%>" target="_blank"><%=Node.find(job.getSltOrgId()).getSubject(1)%></A></Span></span></div></td>
  </tr>
  <tr>
    <td height="25" nowrap><div  align="left"><span >职位性质：</span></div></td>
    <td><div align="left"><span><Span ID=JobIDJobType><%=job.getSltJobType()%></Span></span></div></td>
  </tr>
  <tr>
    <td height="25" nowrap><div  align="left"><span >职业类别：</span></div></td>
    <td><div align="left"><span><Span ID=JobIDOccClass> <%java.util.Enumeration enumerationOccId=job.getSltOccId();while(enumerationOccId.hasMoreElements()){out.println(enumerationOccId.nextElement()+" ");}%>
    </Span></span></div></td>
  </tr>
  <tr>
    <td height="25" nowrap><div  align="left"><span > 职位有效期 ：</span></div></td>
    <td><div align="left"><span><Span ID=JobIDvalidity><%=job.getValidityDateToString()%></Span></span></div></td>
  </tr>
  <tr>
    <td height="25" nowrap><div align="left"><span >招聘人数：</span></div></td>
    <td><div align="left"><span><Span ID=JobIDHeadCount><%=job.getTxtHeadCount()%></Span>人</span></div></td>
  </tr>
  <tr>
    <td height="25" nowrap><div  align="left"><span >月薪范围：</span></div></td>
    <td><div align="left"><span><Span ID=JobIDSalaryId><%=job.getSltSalaryId()%></Span></span></div></td>
  </tr>
  <tr>
    <td height="25" nowrap><div  align="left"><span >工作地区：</span></div></td>
    <td><div align="left"><span><Span ID=JobIDProvinceId> <%java.util.Enumeration enumerationLocId=job.getSltLocId();
while(enumerationLocId.hasMoreElements()){
out.print(enumerationLocId.nextElement()+" ");}%></Span></span></div></td>
  </tr>
  <tr>
    <td height="25" nowrap><div  align="left"><span >最低工作经验：</span></div></td>
    <td><div align="left"><span><Span ID=JobIDReqWyearId><%=job.getSltReqWyearId()%></Span>年</span></div></td>
  </tr>
  <tr>
    <td height="25" nowrap><div  align="left"><span >学历：</span></div></td>
    <td><div align="left"><span><Span ID=JobIDReqDegId><%=job.getSltReqDegId()%></Span></span></div></td>
  </tr>
  <tr>
    <td height="25" nowrap><div  align="left"><span >发布时间：</span></div></td>
    <td><div align="left"><span><Span ID=JobIDissuetime><%=node.getTime("yyyy-MM-dd")%></Span></span></div></td>
  </tr>

  <tr>
    <td height="25" nowrap><div  align="left"><span>职位描述及要求：</span></div></td>
    <td><div align="left"><span><Span ID=JobIDtext>
        <%
        if ( (node.getOptions() & 0x40) == 0) //TEXT
        out.print(Text.toHTML(node.getText(teasession._nLanguage)));
        else //HTML
        out.print(node.getText(teasession._nLanguage));
        %>
</Span></span></div></td>
  </tr>
</table>
  <div align="center">
    <input name="Submit" class="in" type="submit" onClick="javaScript:window.close();" value="关闭">
  </div>
</div></div>
<div align="center">

</div>
</body>
</html>

