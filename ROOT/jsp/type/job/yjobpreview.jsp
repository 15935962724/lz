<%@page contentType="text/html;charset=utf-8" %>
<%@page import="tea.ui.TeaSession"%>
<%@page import="tea.entity.site.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.resource.*"%>
<%@page import="tea.db.*"%>
<%@page import="tea.entity.member.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@page import="tea.html.*" %>
<%@page import="tea.htmlx.*" %>

<%
 TeaSession teasession = new TeaSession(request);
  if (teasession._rv == null) {
    response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
    return;
  }
  Resource r = new Resource();
Job job= Job.find(teasession._nNode,teasession._nLanguage);

Node node = Node.find(teasession._nNode);
%>
<html>
<head>
<title>职位详细介绍</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script language="JavaScript" type="text/JavaScript">
<!--
function MM_callJS(jsStr) { //v2.0
  return eval(jsStr)
}
//-->
</script>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "职位详细介绍")%></h1>
    <div id="head6"><img height="6" src="about:blank"></div>
    <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">

      <tr>
        <td><div  align="left"><span >职位名称：</span></div></td>
        <td><div align="left"><span><Span ID=JobIDname>
                    <%=node.getSubject(teasession._nLanguage)%></Span>
</span>
    </div>
        </td>
      </tr>
      <tr>
        <td><div  align="left"><span >所属机构：</span></div></td>
        <td><div align="left"><span><Span ID=JobIDOrgId><A href="/servlet/Node?node=<%=job.getOrgId()%>" target="_blank"><%=Node.find(job.getOrgId()).getSubject(1)%></A></Span></span></div></td>
      </tr>
      <tr>
        <td><div  align="left"><span >职位性质：</span></div></td>
        <td><div align="left"><span><Span ID=JobIDJobType><%=job.getJobTypeToString(teasession._nLanguage)%></Span></span></div></td>
      </tr>
      <tr>
        <td><div  align="left"><span >职业类别：</span></div></td>
        <td><div align="left"><span><Span ID=JobIDOccClass><%=job.getOccIdToHtml()%></Span></span></div></td>
      </tr>
      <tr>
        <td><div  align="left"><span > 职位有效期 ：</span></div></td>
        <td><div align="left"><span><Span ID=JobIDvalidity><%=job.getValidityDateToString()%></Span></span></div></td>
      </tr>
      <tr>
        <td><div align="left"><span >招聘人数：</span></div></td>
        <td><div align="left"><span><Span ID=JobIDHeadCount><%=job.getHeadCount()%></Span>人</span></div></td>
      </tr>
      <tr>
        <td><div  align="left"><span >月薪范围：</span></div></td>
        <td><div align="left"><span><Span ID=JobIDSalaryId><%=job.getSalaryId()%></Span></span></div></td>
      </tr>
      <tr>
        <td><div  align="left"><span >工作地区：</span></div></td>
        <td><div align="left"><span><Span ID=JobIDProvinceId><%=job.getLocIdToHtml()%></Span></span></div></td>
      </tr>
      <tr>
        <td><div  align="left"><span >最低工作经验：</span></div></td>
        <td><div align="left"><span><Span ID=JobIDReqWyearId><%=job.getReqWyearId()%></Span>年</span></div></td>
      </tr>
      <tr>
        <td><div  align="left"><span >学历：</span></div></td>
        <td><div align="left"><span><Span ID=JobIDReqDegId><%=DegreeSelection.getDegree(job.getReqDegId())%></Span></span></div></td>
      </tr>
      <tr>
        <td><div  align="left"><span >发布时间：</span></div></td>
        <td><div align="left"><span><Span ID=JobIDissuetime><%=node.getTimeToString()%></Span></span></div></td>
      </tr>
      <tr>
        <td><div  align="left"><span>职位描述及要求：</span></div></td>
        <td><div align="left"><span><Span ID=JobIDtext>
        <br>
            <%


        if ( (node.getOptions() & 0x40) == 0) //TEXT
        out.print(Text.toHTML(node.getText(teasession._nLanguage)));
        else //HTML
        out.print(node.getText(teasession._nLanguage));
        %>
            </Span></span></div></td>
      </tr>
      <!--<tr>
      <td colspan="2" align="center">
      <input TYPE="button" NAME="Submit" VALUE="申请该职位 " ONCLICK="window.open('/jsp/type/job/EditJobApply.jsp?node=<%=teasession._nNode%>')">
      <input TYPE="button" NAME="Submit" VALUE="该公司所有职位 " ONCLICK="window.open('/jsp/type/job/JobPosition.jsp?rigd=<%=job.getOrgId()%>')">
      </td>
      </tr>-->
    </table>
    <div align="center">
      <input name="Submit" class="in" type="submit" onClick="javaScript:window.close();" value="关闭">
    </div>
<div align="center"> </div>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>

