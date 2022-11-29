<%@page contentType="text/html;charset=UTF-8" %><%@page import="java.util.*" %>
<%@page import="tea.db.DbAdapter"%><%@page import="tea.resource.Resource" %>
<%@page import="tea.entity.cio.*" %><%@page import="tea.ui.TeaSession" %>
<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String nexturl=request.getParameter("nexturl");
if(nexturl==null)
{
  nexturl=request.getRequestURI()+"?"+request.getQueryString();
}

String menuid=request.getParameter("id");
StringBuffer param=new StringBuffer("&community="+teasession._strCommunity);



//sql.append("  and id in (select id from csvdogprovenum where its = 0) ");

String menu_id=(request.getParameter("id"));
if(menu_id!=null&&menu_id.length()>0)
{
  param.append("&id=").append(menu_id);

}

int pos=0;
if(request.getParameter("pos")!=null)
{
  pos=Integer.parseInt(request.getParameter("pos"));
}
param.append("&pos=").append(pos);

StringBuilder sql=new StringBuilder();
sql.append(" AND ciocompany>0 and ciocompany in(select ciocompany from ciocompany where receipt=1) and cioclerkid!=''    ");

sql.append(" and shuttle=1 ");

String ccname=request.getParameter("ccname");
if(ccname!=null&&ccname.length()>0)
{
  sql.append(" AND ciocompany IN (SELECT ciocompany FROM CioCompany WHERE name LIKE "+DbAdapter.cite("%"+ccname+"%")+")");
}
String cpname=request.getParameter("cpname");
if(cpname!=null&&cpname.length()>0)
{
  sql.append(" AND name LIKE "+DbAdapter.cite("%"+cpname+"%"));
}
String cometrain=request.getParameter("cometrain");
if(cpname!=null&&cpname.length()>0)
{
  sql.append(" AND cometrain LIKE "+DbAdapter.cite("%"+cometrain+"%"));
}
String member=request.getParameter("member");
if(member!=null&&member.length()>0)
{
  sql.append(" AND member LIKE "+DbAdapter.cite("%"+member+"%"));
}
String cometime=request.getParameter("cometime");
if(cometime!=null&&cometime.length()>0)
{
  sql.append(" AND cometime="+DbAdapter.cite(cometime));
}
String backtrain=request.getParameter("backtrain");
if(backtrain!=null&&backtrain.length()>0)
{
  sql.append(" AND backtrain LIKE "+DbAdapter.cite("%"+backtrain+"%"));
}
String backtime=request.getParameter("backtime");
if(backtime!=null&&backtime.length()>0)
{
  sql.append(" AND backtime="+DbAdapter.cite(backtime));
}
Resource r=new Resource();

int count = CioPart.count(teasession._strCommunity,sql.toString());



%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="">
function f_actionA(act,ccid)
{
  switch(act)
  {
    case "go":
    form2.action="?";
    form2.method="get";
    break;
    case "delete":
    if(!confirm("确认删除?"))
    {
      return false;
    }
    break;
    case "edit":
    window.showModalDialog("/jsp/cio/CioClerklist.jsp?community=<%=teasession._strCommunity%>&ccid="+ccid,"","width=450,height=200,scrollbars:yes,toolbar:no,status:no,menubar:no,location:no,resizable:yes");
    location.reload();

    return;
  }
//  //form1.ciocompany.value=ccid;
//  form1.act.value=act;
//  form1.submit();
}

function f_action(act,id)
{
  switch(act)
  {
    case "edit":
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
  form1.ciopart.value=id;
  form1.act.value=act;
  form1.submit();
}
function f_trip()
{
  form1.trip.value=true;
  var tabletrip=document.getElementById("tabletrip");
  var tableinfo=document.getElementById("tableinfo");
  tabletrip.style.display="";
  tableinfo.style.display="none";
}
var ifcp=parent.document.getElementById("ifcp");
</script>
</head>
<body>

<h1>参会人员接送安排</h1>
<div id="body_nei">
<form name="form1" action="?" method="post" >
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="nexturl" value="<%=nexturl%>"/>
<input type="hidden" name="id" value="<%=menuid%>"/>
<input type="hidden" name="act" value="shuttle"/>

<table border='0' cellpadding='0' cellspacing='0' id='table_left'>
  <tr id='tableonetr'>
    <td>企业集团名称:</td>
    <td><input type="text" name="ccname" value="<%if(ccname!=null)out.print(ccname);%>"></td>
    <td>参会人员姓名</td>
    <td><input type="text" name="cpname" value="<%if(cpname!=null)out.print(cpname);%>"></td>
	<td>&nbsp;</td>
    </tr>
  <tr id='tableonetr'>
    <td>到达航班/车次</td>
    <td><input type="text" name="cometrain" value="<%if(cometrain!=null)out.print(cometrain);%>"></td>
    <td>代表号</td>
    <td><input type="text" name="member" value="<%if(member!=null)out.print(member);%>"></td>
	<td>&nbsp;</td>
    </tr>
  <tr id='tableonetr'>
    <td>到港/到站日期</td>
    <td><input type="text" name="cometime" value="<%if(cometime!=null)out.print(cometime);%>" readonly="readonly" onClick="showCalendar(this)"></td>
    <td>返回航班/车次</td>
    <td><input type="text" name="backtrain" value="<%if(backtrain!=null)out.print(backtrain);%>"></td>
	<td>&nbsp;</td>
    </tr>
  <tr id='tableonetr'>
    <td>到港/到站时刻</td>
    <td><input type="text" name="textfield5"></td>
    <td>离港/发车日期</td>
    <td><input type="text" name="backtime" value="<%if(backtime!=null)out.print(backtime);%>" readonly="readonly" onClick="showCalendar(this)"></td>
	<td><input name="提交" type="submit" class="buttonclass" value="模糊查找" /></td>
    </tr>
</table>
</form>

<form name="form2" action="/servlet/EditCioPart" method="post" >
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="nexturl" value="<%=nexturl%>"/>
<input type="hidden" name="act" value="shuttle"/>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenterleft2" >
  <tr id='tableonetr'>
    <td nowrap>&nbsp;</td>
    <td nowrap id="xuhao">序号</td>
    <td nowrap id="xingm">姓名</td>
    <td nowrap id="zhiwu">职务</td>
    <td nowrap id="qiye">企业(集团)名称</td>
    <td nowrap id="daog">接送人</td>
    <td nowrap id="lig">接送人联系方式</td>
    <td nowrap id="caozuo">操作</td>
  </tr>
<%
Enumeration e=CioPart.find(sql.toString(),pos,10);
for(int i=1;e.hasMoreElements();i++)
{

  CioPart cp=(CioPart)e.nextElement();
  CioCompany cc=CioCompany.find(cp.getCioCompany());
  int cpid=cp.getCioPart();

  CioClerk cck=CioClerk.find(cp.getCioClerkid());
  out.print("<tr onmouseover=bgColor='#BCD1E9' onmouseout=bgColor=''>");
  out.print("<td><input type=checkbox name='ciopart' value='"+cpid+"' >");
  out.print("<td id='xuhao'>"+i);
  out.print("<td id='xingm'>");
     if(cp.getName()!=null && cp.getName().length()>0)
  {
    out.print(cp.getName());
  }
  out.print("</td>");
  out.print("<td id='qiye'>");
  if(cp.getJob()!=null && cp.getJob().length()>0)
  {
    out.print(cp.getJob());
  }
  out.print("</td>");
  out.print("<td id='daog'>");
     if(cc.getName()!=null && cc.getName().length()>0)
  {
    out.print(cc.getName());
  }
  out.print("</td>");
  out.print("<td id='lig'>");
     if(cck.getSname()!=null && cck.getSname().length()>0)
  {
    out.print(cck.getSname());
  }
  out.print("</td>");
  out.print("<td id='caozuo'>");
     if(cck.getStel()!=null && cck.getStel().length()>0)
  {
    out.print(cck.getStel());
  }
  out.print("</td>");
  out.print("<td id='bianji'><a href=javascript:f_actionA('edit',"+cpid+")>重新安排接送</a>");
  //out.print("<td><a href=#    onClick=\"window.open('/jsp/cio/EditShuttleCioPart.jsp?cpids="+cpid+"',\"\",width=300,height=150)\";>安排接送</a></td>");
}
%>
<tr><td colspan="18" align="center"><%=new tea.htmlx.FPNL(teasession._nLanguage,"?"+param.toString().replaceFirst("&pos=","&")+"&pos=",pos,count,10)%></td></tr>
</table>
<input type="button" value="全选列表中人员" onClick="selectAll(form2.ciopart,true)"/>
<input type="submit" id="tianjia" value="修改选中人员接送安排" >
<input type="button" value="查看未安排接送的人员" onClick="window.open('/jsp/cio/EditShuttleCioPart.jsp','_self')"/>


<table style="margin-top:10px;">
<tr><td><select name="sname">
<%
Enumeration cioclerk = CioClerk.find("",0,Integer.MAX_VALUE) ;
if(!cioclerk.hasMoreElements())
{
  %>
   <option>暂无联系人</option>
  <%
}
while(cioclerk.hasMoreElements())
{

  CioClerk cc=(CioClerk)cioclerk.nextElement();

  out.print("<option value="+cc.getId()+">"+cc.getSname()+":"+cc.getStel()+"</option>");
}
%>

</select></td><td></td></tr>

<!--tr>
  <td>接送人姓名:</td><td><input type="text" name="sname"/></td>
  <td>接送人联系方式:</td><td><input type="text" name="stel"/></td>

  <td><input type="submit" id="tianjia" value="提交" onClick="return submitText(form2.sname,'无效-接送人姓名')&&submitText(form2.stel,'无效-接送人联系方式');"/></td>
</tr-->

</table>
</form>

<%@include file="/jsp/include/Calendar2.jsp" %>


</div><div  id="tablebottom_02">
说明：<br>
已安排接送的人员不在此显示。<br>
如需修改接送服务安排，请进入已安排接送人员界面。</div>
</body>
</html>
