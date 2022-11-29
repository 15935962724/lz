<%@page contentType="text/html;charset=UTF-8" %><%@page import="java.util.*" %>
<%@page import="tea.db.DbAdapter"%><%@page import="tea.resource.Resource" %>
<%@page import="tea.entity.cio.*" %><%@page import="tea.ui.TeaSession" %>
<%
request.setCharacterEncoding("UTF-8");
response.setHeader("progma","no-cache");
response.setHeader("Cache-Control","no-cache");
response.setDateHeader("Expires",0);
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

StringBuilder sql=new StringBuilder();
StringBuffer param = new StringBuffer("?community=" + teasession._strCommunity);
sql.append(" AND ciocompany>0 and ciocompany in(select ciocompany from ciocompany where receipt=1) AND rname IS NULL");
String ccname=request.getParameter("ccname");
if(ccname!=null&&ccname.length()>0)
{
  sql.append(" AND ciocompany IN (SELECT ciocompany FROM CioCompany WHERE name LIKE "+DbAdapter.cite("%"+ccname+"%")+")");
  param.append("&ccname=").append(ccname);
}
String cpname=request.getParameter("cpname");
if(cpname!=null&&cpname.length()>0)
{
  sql.append(" AND name LIKE "+DbAdapter.cite("%"+cpname+"%"));
  param.append("&cpname=").append(cpname);
}
String cometrain=request.getParameter("cometrain");
if(cometrain!=null&&cometrain.length()>0)
{
  sql.append(" AND cometrain LIKE "+DbAdapter.cite("%"+cometrain+"%"));
  param.append("&cometrain=").append(cometrain);
}
String member=request.getParameter("member");
if(member!=null&&member.length()>0)
{
  sql.append(" AND member LIKE "+DbAdapter.cite("%"+member+"%"));
  param.append("&member=").append(member);
}
String cometime=request.getParameter("cometime");
if(cometime!=null&&cometime.length()>0)
{
  sql.append(" AND datediff(day,cometime,"+DbAdapter.cite(cometime)+")=0");
  param.append("&cometime=").append(cometime);
}
String backtrain=request.getParameter("backtrain");
if(backtrain!=null&&backtrain.length()>0)
{
  sql.append(" AND backtrain LIKE "+DbAdapter.cite("%"+backtrain+"%"));
  param.append("&backtrain=").append(backtrain);
}
String backtime=request.getParameter("backtime");
if(backtime!=null&&backtime.length()>0)
{
  sql.append(" AND datediff(day,backtime,"+DbAdapter.cite(backtime)+")=0");
  param.append("&backtime=").append(backtime);
}
String room=request.getParameter("room");
if(room!=null&&room.length()>0&&!room.equals("2"))
{
  sql.append(" AND room="+room);
  param.append("&room=").append(room);
}
String sex=request.getParameter("sex");
if(sex!=null&&sex.length()>0&&!sex.equals("2"))
{
  sql.append(" AND sex="+sex);
  param.append("&sex=").append(sex);
}
int count = 0;
int pos = 0;
if (request.getParameter("pos") != null) {
  pos = Integer.parseInt(request.getParameter("pos"));
}
int pageSize=10;

Resource r=new Resource();

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="">
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
<h1>参会人员住宿安排</h1>
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
	<td></td>
    </tr>
  <tr id='tableonetr'>
    <td>到港/到站日期</td>
    <td><input type="text" name="cometime" value="<%if(cometime!=null)out.print(cometime);%>" readonly="readonly" onClick="showCalendar(this)"></td>
    <td>代表号</td>
    <td><input type="text" name="member" value="<%if(member!=null)out.print(member);%>"></td>
	<td></td>
    </tr>
  <tr id='tableonetr'>
    <td>到港/到站时刻</td>
    <td><input type="text" name="textfield5"></td>
    <td>离港/发车日期</td>
    <td><input type="text" name="backtime" value="<%if(backtime!=null)out.print(backtime);%>" readonly="readonly" onClick="showCalendar(this)"></td>
	<td></td>
  </tr>
    <tr id='tableonetr'>
      <td>是否合住</td>
      <td>
        <select name="room">
        <option value="2" selected="selected">-----</option>
          <option value="1" <%if("1".equals(room))out.print(" selected ");%>>合</option>
          <option value="0" <%if("0".equals(room))out.print(" selected ");%>>单</option>
        </select>      </td>
      <td>性别</td>
	  <td>
        <select name="sex">
        <option value="2" selected="selected">-----</option>
          <option value="1" <%if("1".equals(sex))out.print(" selected ");%>>男</option>
          <option value="0" <%if("0".equals(sex))out.print(" selected ");%>>女</option>
        </select>      </td>
		<td><input name="提交" type="submit" class="buttonclass" value="模糊查找" /></td>
    </tr>
</table>

</form>

<form name="form2" action="/servlet/EditCioPart" method="post" >
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="nexturl" value="<%=nexturl%>"/>
<input type="hidden" name="act" value="root"/>

<table border="0" cellpadding="0" cellspacing="0"  id="tablecenterleft2">
  <tr id='tableonetr'>
    <td nowrap>&nbsp;</td>
    <td nowrap id="xuhao">序号</td>
    <td nowrap id='xingm'>姓名</td>
    <td nowrap id='sex'>性别</td>
    <td nowrap id='room'>合/单</td>
    <td nowrap id='zhiwu'>职务</td>
    <td nowrap id='qiye'>企业(集团)名称</td>
    <td nowrap id='daog'>到港/到站日期</td>
    <td nowrap id='lig'>离港/发车日期</td>
    <!--<td nowrap id='caozuo'>操作</td>-->
  </tr>
<%
Enumeration e=CioPart.find(sql.toString(),pos,pageSize);
count = CioPart.count(teasession._strCommunity,sql.toString());
if(!e.hasMoreElements())
{
out.print("<tr onmouseover=bgColor='#BCD1E9' onmouseout=bgColor=''><td colspan=10 align=center>暂无记录</td></tr>");
}
for(int i=1;e.hasMoreElements();i++)
{
  CioPart cp=(CioPart)e.nextElement();
  CioCompany cc=CioCompany.find(cp.getCioCompany());
  int cpid=cp.getCioPart();
  String sexy = cp.isSex()?"男":"女";
  String rooms=cp.isRoom()?"合":"单";
  out.print("<tr onmouseover=bgColor='#BCD1E9' onmouseout=bgColor=''>");
  out.print("<td><input type=checkbox name='ciopart' value='"+cpid+"' >");
  out.print("<td id='xuhao'>"+(pos+i));
  out.print("<td align=center id='xingm'>"+cp.getName());
  out.print("<td align=center id='sex'>"+sexy);
  out.print("<td align=center id='room'>"+rooms);
  out.print("<td align=center id='zhiwu'>"+cp.getJob());
  out.print("<td align=center id='qiye'>"+cc.getName());
  out.print("<td align=center id='daog'>"+cp.getComeTimeToString());
  out.print("<td align=center id='lig'>"+cp.getBackTimeToString());
//  out.print("<td align=center id='caozuo'><a href=#>安排住宿</a>");
}
if(count>pageSize){
    %>
    <tr>
      <td colspan="10" align="center">
        <%=new tea.htmlx.FPNL(teasession._nLanguage,request.getRequestURI()+param.toString()+"&pos=",pos,count,pageSize)%>      </td>
    </tr>
    <%}%>

</table>
<input type="button" value="全选列表中人员" onClick="selectAll(form2.ciopart,true)"/>
<input type="button" value="查看已安排住宿的人员" onClick="window.open('/jsp/cio/CioMeetingyapfan.jsp','_self')" />


<input name="button" type="button" value="需安排住宿人员统计"  onclick="window.open('/jsp/cio/CioMeetingxuapzsrytj.jsp','_self')"/>
<table style="margin-top:10px;">
<tr>
  <td>酒店:</td><td><input type="text" name="rname"/></td>
  <td>房型</td><td><input type="text" name="rchamber"/></td>
  <td>&nbsp;</td>
</tr>
<tr>
  <td>入住时间</td>
  <td><input type="text" name="rstime" readonly="" onClick="showCalendar(this)"/></td>
  <td>退房时间</td>
  <td><input type="text" name="retime" readonly="" onClick="showCalendar(this)"/></td>
  <td><input name="submit" type="submit" id="tianjia" onClick="return submitText(form2.rname,'无效-酒店')&&submitText(form2.rchamber,'无效-房型')&&submitText(form2.rstime,'无效-入住时间')&&submitText(form2.retime,'无效-退房时间');" value="安排住宿"/></td>
</tr>
</table>

</form>
</div>
<div  id="tablebottom_02">说明：<br/>
已安排住宿的人员不在此显示<br/>
如需修改住宿安排，请进入已安排住宿人员界面。	</div>
<%@include file="/jsp/include/Calendar2.jsp" %>
</body>
</html>
