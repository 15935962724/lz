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
sql.append(" AND ciocompany>0 and ciocompany in(select ciocompany from ciocompany where receipt=1) AND cometime IS NOT NULL");
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

String member=request.getParameter("member");
if(member!=null&&member.length()>0)
{
  sql.append(" AND member LIKE "+DbAdapter.cite("%"+member+"%"));
  param.append("&member=").append(member);
}

String rstime=request.getParameter("cometime");
if(rstime!=null&&rstime.length()>0)
{
  sql.append(" AND datediff(day,cometime,"+DbAdapter.cite(rstime)+")=0");
    param.append("&cometime=").append(rstime);
}

String retime=request.getParameter("backroom");
if(retime!=null&&retime.length()>0)
{
  sql.append(" AND datediff(day,backroom,"+DbAdapter.cite(retime)+")=0");
    param.append("&backroom=").append(retime);
}

String rname = request.getParameter("rname");
if(rname!=null&&rname.length()>0)
{
  sql.append(" AND rname LIKE "+DbAdapter.cite("%"+rname+"%"));
    param.append("&rname=").append(rname);
}

String room=request.getParameter("room");
if(room!=null&&room.length()>0&&!"2".equals(room))
{
  sql.append(" AND room="+room);
    param.append("&room=").append(room);
}
String sex=request.getParameter("sex");
if(sex!=null&&sex.length()>0&&!"2".equals(sex))
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
<h1>参会人员住宿管理</h1>
<div id="body_nei">
<form name="form1" action="?" method="get" >
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="nexturl" value="<%=nexturl%>"/>
<input type="hidden" name="id" value="<%=menuid%>"/>
<input type="hidden" name="act" value="shuttle"/>

<table border='0' cellpadding='0' cellspacing='0' id='table_left'>
  <tr id='tableonetr'>
    <td>企业集团名称：</td>
    <td><input type="text" name="ccname" value="<%if(ccname!=null)out.print(ccname);%>"></td>
    <td>参会人员姓名：</td>
    <td><input type="text" name="cpname" value="<%if(cpname!=null)out.print(cpname);%>"></td>
	<td></td>
    </tr>
  <tr id='tableonetr'>

    <td>代表号：</td>
    <td><input type="text" name="member" value="<%if(member!=null)out.print(member);%>"></td>
    <td>酒店名称：</td>
    <td><input type="text" name="rname" value="<%if(rname!=null)out.print(rname);%>"></td>
	<td></td>
    </tr>
  <tr id='tableonetr'>
    <td>入住日期：</td>
    <td><input type="text" name="cometime" value="<%if(rstime!=null)out.print(rstime);%>" readonly="readonly" onClick="showCalendar(this)"></td>
    <td>离店日期：</td>
    <td><input type="text" name="backroom" value="<%if(retime!=null)out.print(retime);%>" readonly="readonly" onClick="showCalendar(this)"></td>
	<td></td>
  </tr>
    <tr id='tableonetr'>
      <td>是否合住：</td>
      <td>
        <select name="room">
          <option value="2" selected="selected">-----</option>
          <option value="1" <%if("1".equals(room))out.print(" selected ");%>>合</option>
          <option value="0" <%if("0".equals(room))out.print(" selected ");%>>单</option>
        </select>      </td>
      <td>性别：</td>
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
<input type="hidden" name="act" value="rername"/>
<input type="hidden" name="ciopart"/>

<table border="0" cellpadding="0" cellspacing="0"  id="tablecenterleft2">
  <tr id='tableonetr'>
  <td>&nbsp;</td>
    <td nowrap id="xuhao">序号</td>
    <td nowrap id='xingm'>姓名</td>
    <td nowrap id='daibiao'>代表号</td>
    <td nowrap id='sex'>性别</td>
    <td nowrap id='room'>合/单</td>
    <td id='qiye'>企业(集团)名称</td>
    <td id='jiudian'>酒店</td>
    <td id='room'>房间</td>
    <td nowrap id='date'>时间</td>
    <td id='caozuo' width="10%">操作</td>
  </tr>
<%
Enumeration e=CioPart.find(sql.toString(),pos,pageSize);
count = CioPart.count(teasession._strCommunity,sql.toString());
if(!e.hasMoreElements())
{
out.print("<tr onmouseover=bgColor='#BCD1E9' onmouseout=bgColor=''><td colspan=15 align=center>暂无记录</td></tr>");
}
for(int i=1;e.hasMoreElements();i++)
{
  CioPart cp=(CioPart)e.nextElement();
  CioCompany cc=CioCompany.find(cp.getCioCompany());
  int cpid=cp.getCioPart();
  String sexy = cp.isSex()?"男":"女";
  String rooms=cp.isRoom()?"合":"单";
  String rrname="";
  if(cp.getRname()!=null)
  {
    rrname=cp.getRname();
  }
  String rchamber = "";
  if(cp.getRchamber()!=null)
  {
    rchamber=cp.getRchamber();
  }
  out.print("<tr onmouseover=bgColor='#BCD1E9' onmouseout=bgColor=''>");
  out.print("<td><input type=checkbox name=chb value="+cpid+">");
  out.print("<td id='xuhao'>"+(pos+i));
  out.print("<td align=center id='xingm'>"+cp.getName());
  out.print("<td align=center id='daibiao'>"+cp.getMember());
  out.print("<td align=center id='sex'>"+sexy);
  out.print("<td align=center id='room'>"+rooms);
  out.print("<td nowrap align=center id='qiye'>"+cc.getName());
  out.print("<td nowrap align=center id='jiudian'>"+rrname);
  out.print("<td nowrap align=center id='room'>"+rchamber);
  out.print("<td align=center id='date'>"+cp.getComeTimeToString()+"至"+cp.getBackRoomToString());
  out.print("<td align=center id='cz"+i+"'><a href=# onclick='c_seat(cz"+i+",rch,\""+cp.getRchamber()+"\","+cpid+");'>编辑房间</a>");
}
if(count>pageSize){
    %>
    <tr>
      <td colspan="11" align="right" style="padding-right:5px;">
        <%=new tea.htmlx.FPNL(teasession._nLanguage,request.getRequestURI()+param.toString()+"&pos=",pos,count,pageSize)%>      </td>
    </tr>
    <%}%>
</table>
 <div id="tablebottom_button02">
 <input name="button" type="button" value="已安排住宿人员统计"  onclick="window.open('/jsp/cio/CioMeetingyapfan2.jsp','_self')"/>
<input name="button" type="button" value="全选列表中会员" onClick="selectAll(form2.chb,true);"/>
    </div>

<div id="tablebottom_button02">
酒店名称：<input type="text" name="rname"/>
<input type="submit" value="添加" onClick="return submitText(form2.rname,'无效-酒店名称');"/>
</div>
<div id="rch" style="display:none;position:absolute;z-index:99;background-color:#E0EDFE;">
 <div id="rch1">房间名称</div><div id="rch2"><select name="rchamber">
 <option value="单人标准间">单人标准间</option>
  <option value="双人标准间">双人标准间</option>
 </select></div>
      <a href="#" onClick="form2.act.value='resethouse';form2.submit();">确定</a>
</div>
</form>
</div>
<%@include file="/jsp/include/Calendar2.jsp" %>
 <script type="">
    var cm = null;

    function getPos(el,sProp)
    {
      var iPos = 0 ;
      　　while (el!=null)   　　
      {
        iPos+=el["offset" + sProp];
        　el = el.offsetParent;
      }
      　　return iPos;
    }
    function c_seat(id,m,cp,cpid)
    {
      form2.rchamber.value=cp;
      form2.ciopart.value=cpid;

      m.style.display='none';
      if(id!=cm)
      {
        m.style.display='';
        m.style.pixelLeft = getPos(id,"Left")+60;
        m.style.pixelTop = getPos(id,"Top") + id.offsetHeight-18;
        cm=id;
      }else
      {
        m.style.display='none';
        cm=null;
      }
    }

    function div_display()
    {
      document.all('setseat').style.display='none';
    1}
    </script>
</body>
</html>
