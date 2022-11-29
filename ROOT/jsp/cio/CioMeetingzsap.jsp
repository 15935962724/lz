<%@page contentType="text/html;charset=UTF-8" %><%@page import="java.util.*" %>
<%@ page import="tea.db.DbAdapter"%><%@page import="tea.resource.Resource" %>
<%@ page import="tea.entity.cio.*" %><%@ page import="tea.ui.TeaSession" %>
<%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String menuid=request.getParameter("id");

String nexturl=request.getParameter("nexturl");

String q=request.getParameter("q");

StringBuilder sql=new StringBuilder();
if(q!=null)
{
  sql.append(" AND name LIKE ").append(DbAdapter.cite("%"+q+"%"));
}

Resource r=new Resource();

int j=CioCompany.count(teasession._strCommunity,sql.toString());

int ccint=CioCompany.findByMember(teasession._rv.toString());

CioCompany ccp = CioCompany.find(ccint);
if(!ccp.isReceipt())
{
  response.sendRedirect("/jsp/cio/InfoCioCompany.jsp?alert="+java.net.URLEncoder.encode("您的信息还没有被审核,暂时不能查看住宿安排.","UTF-8"));
  return;
}

sql.append(" and CioCompany=").append(ccint);

int count = CioPart.count(teasession._strCommunity,sql.toString());

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="">
function f_action(act,ccid)
{
  switch(act)
  {
    case "go":
    form1.action="?";
    form1.method="get";
    break;
    case "delete":
    if(!confirm("确认删除?"))
    {
      return false;
    }
    break;
  }
  form1.ciocompany.value=ccid;
  form1.act.value=act;
  form1.submit();
}
</script>
</head>
<body style="text-align:left;">
<!--img src="/res/cavendishgroup/u/0810/081059221.jpg" border="0"/-->

<h1>查看住宿安排</h1>
<div id="firstshow">
<br>
<%=ccp.getName()%>，参会负责人您好：<br>
您的企业于<%=ccp.getTimeToString()%>提交参会报名表<br>
我们已确认了参会人员的行程信息，下面是安排好的人员接送情况！<br></div>
<h2>参会人员信息</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenterleft2" >
  <tr id='tableonetr'>

    <td nowrap id="xuhao">序号</td>
    <td nowrap id="xingm">姓名</td>
    <td nowrap id="zhiwu">酒店</td>
    <td nowrap id="qiye">房间</td>
    <td nowrap id="daog">时间</td>
    <td nowrap id="lig">状态</td>

  </tr>
<%
Enumeration e=CioPart.find(sql.toString(),0,Integer.MAX_VALUE);
for(int i=1;e.hasMoreElements();i++)
{

  CioPart cp=(CioPart)e.nextElement();
  CioCompany cc=CioCompany.find(cp.getCioCompany());
  int cpid=cp.getCioPart();

  CioClerk cck=CioClerk.find(cp.getCioClerkid());
  out.print("<tr onmouseover=bgColor='#BCD1E9' onmouseout=bgColor=''>");
  out.print("<td id='xuhao'>"+i);
  out.print("<td id='zhiwu'>"+cp.getName());
  out.print("<td id='qiye'>"+cp.getRname());
  out.print("<td id='daog'>"+cp.getRchamber());
  out.print("<td id='lig'>"+cp.getRstimeToString()+"到"+cp.getRetimeToString());
  out.print("<td id='caozuo'>");
  if(cp.getRname()!=null && cp.getRname().length()>0)
  {
    out.print("已预订");
  }
  else
  {
    out.print("未预订");
  }
}
%>
</table>
<div id="shuoming">
以上接送安排是根据您的行程信息进行的，如果行程信息变更请及时联系！<br>
010-61392325<br>
注：请提前通知我们，以便于安排工作，谢谢！<br>
</div>

</body>
</html>
