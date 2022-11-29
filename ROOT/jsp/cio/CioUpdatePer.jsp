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

int ciopart=Integer.parseInt(request.getParameter("ciopart"));
boolean sex=true,talk=false,room=false,seat=false,bd=false,vip=false,shuttle=true;
String name=null,job=null,mobile=null,tel=null,tourism=null,dept=null,email=null,fax=null,address=null,zip=null,member=null,cometrain=null,rstimes=null,backtimes=null,cometimes=null,backrooms=null,backtrain=null,rname=null,rchamber=null;
int cioclerkid=-1;
Date cometime=null,backroom=null,backtime=null,rstime=null,retime=null;
if(ciopart>0)
{
  CioPart cp=CioPart.find(ciopart);
  name=cp.getName();
  sex=cp.isSex();
  job=cp.getJob();
  mobile=cp.getMobile();
  tel=cp.getTel();
  dept=cp.getDept();
  email=cp.getEmail();
  fax=cp.getFax();
  address=cp.getAddress();
  zip=cp.getZip();
  talk=cp.isTalk();
  tourism=cp.getTourism();
  room=cp.isRoom();
  member=cp.getMember();
  shuttle=cp.isShuttle();
  cometrain=cp.getComeTrain();
  cometime=cp.getComeTime();
  cometimes=cp.getComeTimeToString();
  backrooms=cp.getBackRoomToString();
  backroom=cp.getBackRoom();
  backtrain=cp.getBackTrain();
  backtime=cp.getBackTime();
  backtimes=cp.getBackTimeToString();
  seat=cp.isSeat();
  bd=cp.isBd();
  vip=cp.isVip();
  rname=cp.getRname();
  rchamber=cp.getRchamber();
  rstime=cp.getRstime();
  rstimes=cp.getRstimeToString();
  retime=cp.getRetime();
  cioclerkid=cp.getCioClerkid();
}

StringBuilder sql=new StringBuilder();

int sumRow = CioSeatSet.sumRow();
int sumCol = CioSeatSet.sumCol();
String noseat1="";
String noseat = "";
noseat=CioSeatSet.notSeat();

  Enumeration eee = CioSeatSet.noProSeat();
  String noProSeat="";
  if(noseat!= null){
  while(eee.hasMoreElements())
  {
    noProSeat += ","+eee.nextElement();
  }
  if(noseat.length()>0)
  {
    noseat1=noseat.substring(1,noseat.length()-1).replaceAll("/","),new Array(").replaceAll("-",",");
  }
}

Resource r=new Resource();

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script type="">
function check(form)
{
  return submitText(form.name,'无效-姓名')
  &&submitText(form.job,'无效-职务')
  &&submitText(form.mobile,'无效-手机')
  &&submitInteger(form.mobile,'无效-手机')
  &&submitLength(11,12,form.mobile,'无效-手机')
  &&submitInteger(form.tel,'无效-电话')
  &&submitInteger(form.fax,'无效-传真')
  &&submitEmail(form.email,'无效-邮箱')
  &&submitInteger(form.zip,'无效-邮编');
}
function submitInteger(text, alerttext)
{if(text.value.length>0){
	if (isNaN(parseInt(text.value)))
	{
		alert(alerttext);
		text.focus();
		return false;
	}
	text.value=parseInt(text.value);
	return true;
      }
        return true;
}

function submitEmail(text, alerttext)
{
	var   strReg="";
	var   r;
	var str = text.value;
        if(str.length>0){
          strReg=/^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/i;
          r=str.search(strReg);
          if(r==-1)
          {
            alert(alerttext);
            text.focus();
            return false;
          }

          return true;
        }
        return true;
}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

</head>
<body  id="qiyelog_05">
<h1>人员信息变更</h1>
<div id="tes_body">
<div id="head6"><img height="6" src="about：blank"></div>
<br/>
<form name="form1" action="/servlet/EditCioPart" method="post" onSubmit="return(check(this));">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="nexturl" value="<%=nexturl%>"/>
<input type="hidden" name="ciopart" value="<%=ciopart%>"/>
<input type="hidden" name="st" value="<%=seat%>"/>
<input type="hidden" name="act" value="upperson"/>

<h2>基本信息：</h2>
<div id="qiy_xx">
<table border="0" cellpadding="0" cellspacing="0" id="tableinfo">
  <tr>
    <td nowrap>姓名</td>
    <td nowrap><input type="text" name="name" value="<%if(name!=null)out.print(name);%>"></td>
      <td nowrap>性别</td>
      <td nowrap>
        <select name="sex">
          <option value="true" selected="selected">先生</option>
          <option value="false" <%if(!sex)out.print("selected='selected'");%>>女士</option>
        </select>
      </td>
  </tr>
  <tr>
    <td>职务</td>
    <td><input type="text" name="job" value="<%if(job!=null)out.print(job);%>"></td>
      <td>手机</td>
      <td><input type="text" name="mobile" value="<%if(mobile!=null)out.print(mobile);%>"></td>
  </tr>
  <tr>
    <td>电话</td>
    <td><input type="text" name="tel" value="<%if(tel!=null)out.print(tel);%>"></td>
      <td>部门或子企业</td>
      <td><input type="text" name="dept" value="<%if(dept!=null)out.print(dept);%>"></td>
  </tr>
  <tr>
    <td>E-Mail</td>
    <td><input type="text" name="email" value="<%if(email!=null)out.print(email);%>"></td>
    <td>传真</td>
    <td><input type="text" name="fax" value="<%if(fax!=null)out.print(fax);%>"></td>
  </tr>
  <tr>
    <td>通信地址</td>
    <td><input type="text" name="address" value="<%if(address!=null)out.print(address);%>"></td>
      <td>邮编</td>
      <td><input type="text" name="zip" value="<%if(zip!=null)out.print(zip);%>"></td>
  </tr>
  <tr>

   <td>
  是否合住</td><td>
  <select name="room">
    <option value="true" selected="selected">是</option>
    <option value="false" <%if(!room)out.print("selected='selected'");%>>否</option>
</select></td>
<%
  out.print("<td>是否发言</td>");
  out.print("<td><select name='talk'><option value='true' selected='selected'>是</option><option value='false' ");
  if(!talk)out.print("selected='selected'");
  out.print(">否</option></select></td>");
%>
  </tr>
  <tr>
  <%

  out.print("<td>是否报到</td>");
  out.print("<td><select name='bd'><option value='true' selected='selected'>是</option><option value='false' ");
  if(!bd)out.print("selected='selected'");
  out.print(">否</option></select></td>");


  out.print("<td>是否VIP</td>");
  out.print("<td><select name='vip'><option value='true' selected='selected'>是</option><option value='false' ");
  if(!vip)out.print("selected='selected'");
  out.print(">否</option></select></td>");


%></tr>
  <tr>
<td>
是否需要接机</td><td>
  <select name="shuttle" onChange="s_change(value,'1');">
    <option value="true" selected="selected">是</option>
    <option value="false" <%if(!shuttle)out.print("selected='selected'");%>>否</option>
  </select>
  </td>
   <td id="sn">联系人信息</td>
   <td id="sn1"><select name="sname">
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

  out.print("<option value="+cc.getId());
  if(cc.getId()==cioclerkid)out.print(" selected='selected'");
  out.print(">"+cc.getSname()+":"+cc.getStel()+"</option>");
}
%>
</select></td>
  <tr>

<td>参光意向</td><td colspan="3"><%

for(int i=1;i<CioPart.TOURISM_TYPE.length;i++)
{
  out.print("<input type='checkbox' name='tourism' value='"+i+"'");
  if(tourism!=null&&tourism.indexOf("/"+i+"/")!=-1)
  {
    out.print(" checked='true' ");
  }
  out.print(" />"+CioPart.TOURISM_TYPE[i]+" ");
}%>
  </td>

  </tr>
    <tr>
    <%
      out.print("<td>是否安排座位</td>");
  out.print("<td><select name='seat' onchange=\"s_change(value,'2');\"><option value='true' selected='selected'>是</option><option value='false' ");
  if(!seat)out.print("selected='selected'");
  out.print(">否</option></select></td>");
    %>
  <%
  int sr = CioSeatSet.seatRow(ciopart);
    int sc = CioSeatSet.seatCol(ciopart);
  %>

    <td id="zw1">
  座位信息</td><td id="zw">
 排：<select name="seatrow" onChange="f_change(value)">
    <%
    for(int z=1;z<=sumRow;z++)
    {
        out.print("<option value="+z+">"+z+"</option>");
    }
    %>
    </select>&nbsp;
    列：<select name="seatcol">
      </select>
  </td>

  </tr>
</table>
</div>
<h2>行程信息：</h2>
<div id="qiy_xx">
<table border="0" cellpadding="0" cellspacing="0" id="tableinfo">
  <tr>
    <td>到达航班/车次</td>
    <td><input type="text" name="cometrain" value="<%if(cometrain!=null)out.print(cometrain);%>"></td>
      <td>返回航班/车次</td>
      <td><input type="text" name="backtrain" value="<%if(backtrain!=null)out.print(backtrain);%>"></td>
  </tr>
  <tr>
    <td>到港/到站日期</td>
    <td><input type="text" name="cometime" value="<%if(cometime!=null)out.print(cometimes);%>" onClick="showCalendar(this,-50)" readonly="readonly"></td>
      <td>离港日期</td>
      <td><input type="text" name="backtime" value="<%if(backtime!=null)out.print(backtimes);%>" onClick="showCalendar(this,-50)" readonly="readonly"></td>
  </tr>
  <tr>
    <td>到港/到站时刻</td>
    <td>
    <%

int ichour=0;
int icmin=0;
if(cometime!=null)
{
  ichour = Integer.parseInt(CiopCount.rehour(cometime));
  icmin = Integer.parseInt(CiopCount.reMin(cometime));
}

int ibhour=0;
int ibmin=0;
if(backtime!=null)
{
   ibhour = Integer.parseInt(CiopCount.rehour(backtime));
  ibmin = Integer.parseInt(CiopCount.reMin(backtime));
}

    out.print("<select name='cth'>");
    for(int i=0;i<24;i++)
    {
      out.print("<option value="+i);
      if(i==ichour)out.print(" selected=''");
      out.print(">"+i);
    }
    out.print("</select>时");
    out.print("<select name='ctm'>");
    for(int i=0;i<60;i=i+10)
    {
      out.print("<option value="+i);
      if(i==icmin)out.print(" selected=''");
      out.print(">"+i);
    }
    out.print("</select>分");
    %>
    </td>
    <td>离港/发车时刻</td>
    <td>
    <%
    out.print("<select name='bth'>");
    for(int i=0;i<24;i++)
    {
      out.print("<option value="+i);
      if(i==ibhour)out.print(" selected=''");
      out.print(">"+i);
    }
    out.print("</select>时");
    out.print("<select name='btm'>");
    for(int i=0;i<60;i=i+10)
    {
      out.print("<option value="+i);
      if(i==ibmin)out.print(" selected=''");
      out.print(">"+i);
    }
    out.print("</select>分");
    //      <input type="text" name="backtime">
    %>
    </td>
  </tr>
</table>
</div>
<h2>住宿信息：</h2>
<div id="qiy_xx">
<table border="0" cellpadding="0" cellspacing="0" id="tableinfo">
<tr>
<td nowrap>入住酒店</td><td><input type="text" name="rname" value="<%if(rname!=null)out.print(rname);%>"/></td>
<td nowrap>入住房型</td><td><select name="rchamber">
 <option value="单人标准间" selected="selected">单人标准间</option>
  <option value="双人标准间" <%if(rchamber!=null){if(rchamber.equals("双人标准间"))out.print("selected");}%>>双人标准间</option>
 </select></td>
</tr>
<tr>
<td nowrap>入住日期</td><td><input type="text" name="rstime" value="<%if(rstime!=null)out.print(rstimes);%>" onClick="showCalendar(this,-50)" readonly="readonly"></td>
<td nowrap>离店日期</td><td><input type="text" name="backroom" value="<%if(backroom!=null)out.print(backrooms);%>" onClick="showCalendar(this,-50)" readonly="readonly"></td>
</tr>
</table>

</div>
<input type='submit' name='edit' class='buttonclass' value='编辑'>
<input type='button' class='buttonclass' onclick="window.location.href='/jsp/cio/OkCioCompany3.jsp';" value='返回'>


</form>
<%@include file="/jsp/include/Calendar2.jsp" %>
 <script type="">
 var nos = new Array(new Array(<%=noseat1+")"+noProSeat+")"%>;
 function f_find(v1,v2)
{
    for(var j=0;j<nos.length;j++)
    {
      if(nos[j][0]==v1&&nos[j][1]==v2)
      return false;
    }
    return true;
}
var gsc;
function f_change(sr,sc)
{
  if(sc)gsc=sc;
  var c=form1.seatcol.options;
  while(c.length>0)
  {
    c[0]=null;
  }
  for(var i=1;i<=<%=sumCol%>;i++)
  {
    if(i==gsc||f_find(sr,i))    c[c.length]=new Option(i,i);
  }
}




    function s_change(v,ty)
    {


      if(ty=='2'){
        if(v=="true")
        {
           form1.seatrow.value=<%=sr%>;
      f_change(<%=sr%>,<%=sc%>);
      form1.seatcol.value=<%=sc%>;
          zw.style.display="";
          zw1.style.display="";
        }else
        {
          zw.style.display="none";
          zw1.style.display="none";
        }
      }else
      {
      if(v=="true")
        {
          sn.style.display="";
          sn1.style.display="";
        }else
        {
          sn.style.display="none";
          sn1.style.display="none";
        }
      }
    }
    s_change(form1.seat.value,'2');
    s_change(form1.shuttle.value,'1');

var gsc;
function f_change(sr,sc)
{
  if(sc)gsc=sc;
  var c=form1.seatcol.options;
  while(c.length>0)
  {
    c[0]=null;
  }
  for(var i=1;i<=<%=sumCol%>;i++)
  {
    if(i==gsc||f_find(sr,i))    c[c.length]=new Option(i,i);
  }
}

    </script>
    </div>
</body>
</html>
