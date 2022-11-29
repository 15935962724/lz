<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.resource.Resource" %>
<%@page import="tea.ui.*" %>
<% request.setCharacterEncoding("UTF-8");
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession = new TeaSession(request);
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

int role=Integer.parseInt(request.getParameter("role"));
NetDiskSize nds=NetDiskSize.find(role);
if("POST".equals(request.getMethod()))
{
  int single=Integer.parseInt(request.getParameter("single"))*1024;
  int size=Integer.parseInt(request.getParameter("size"))*1024;
  int sum;
  if(request.getParameter("sum_max")!=null)
	  sum=Integer.MAX_VALUE;
  else
	  sum=Integer.parseInt(request.getParameter("sum"));
  java.util.Date  enddate=  NetDiskSize.sdf.parse(request.getParameter("enddateYear")+"-"+request.getParameter("enddateMonth")+"-"+request.getParameter("enddateDay"));
  nds.set(single,sum,size,enddate);
  response.sendRedirect("/jsp/info/Succeed.jsp");
  return;
}

String _strId=request.getParameter("id");

AdminRole ar=AdminRole.find(role);
Resource r=new Resource();

%><html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script>
function f_click(obj)
{
  form1.sum.disabled=obj.checked;
  form1.sum.style.backgroundColor=(obj.checked?"#CCCCCC":"");
}
</script>
</head>
<body onload="f_click(form1.sum_max)">
<h1>网络硬盘空间管理</h1>
<div id="head6"><img height="6" alt=""></div>

<form name="form1" action="?" method="post" onSubmit="return submitInteger(this.single,'<%=r.getString(teasession._nLanguage,"InvalidParameter")%>-上传文件大小')&&submitInteger(this.size,'<%=r.getString(teasession._nLanguage,"InvalidParameter")%>-总空间')&&submitInteger(this.single,'<%=r.getString(teasession._nLanguage,"InvalidParameter")%>-上传文件大小')&&(this.sum_max.checked||submitInteger(this.sum,'<%=r.getString(teasession._nLanguage,"InvalidParameter")%>-文件总数'))">
<%
if(_strId!=null)
out.print("<input type=hidden name=id value="+_strId+">");
%>
<input type="hidden" name="Node" value="<%=teasession._nNode%>"/>
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
 <TABLE border="0" cellPadding="0" cellSpacing="0"  id="tablecenter">
    <TR>
      <TD>角色：</TD>
      <TD><%=ar.getName()%>
        <INPUT type="hidden" name="role" value="<%=role%>">
      </TD>
    </TR>
    <TR>
      <TD>文件大小：</TD>
      <TD><INPUT name="single" type="text" id="single" value="<%=nds.getSingle()/1024%>" onKeyPress="if(event.keyCode<48||event.keyCode>57)event.returnValue=false;" size="35">M</TD></TR>
    <TR>
      <TD>总空间：</TD>
      <TD><input name="size" type="text" id="size" value="<%=nds.getSize()/1024%>" onKeyPress="if(event.keyCode<48||event.keyCode>57)event.returnValue=false;" size="35">M</TD>
    </TR>
    <TR>
      <TD>文件总数：</TD>
      <TD><INPUT name="sum"  type="text" value="<%if(Integer.MAX_VALUE!=nds.getSum())out.print(nds.getSum());%>" onKeyPress="if(event.keyCode<48||event.keyCode>57)event.returnValue=false;" >个
       <input name="sum_max" type="checkbox" onclick="f_click(this);" "<%if(Integer.MAX_VALUE==nds.getSum())out.print(" CHECKED ");%>">无限制
      </TD>
    </TR>
    <TR>
      <TD>结束日期:</TD>
      <TD><%=new tea.htmlx.TimeSelection("enddate", nds.getEnddate())%></TD>
    </TR>
    <TR>
      <TD height="40" colspan="4" align="middle"  >
        <INPUT id="Submit2" type="submit" onClick="" value="<%=r.getString(teasession._nLanguage, "Submit")%>" name="Submit2">
        <input type="button" value="返回" onClick="history.back();"/>
      </TD>
    </TR>
  </TABLE>
</form>
  <div id="head6"><img height="6" alt=""></div>
  已用空间:<%=((int)(100*(nds.getUseSize(new java.io.File(application.getRealPath("/res/"+teasession._strCommunity+"/netdiskmember/")))/1024F)))/100F%>M
</body>
</html>
