<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="tea.ui.TeaSession"%>
<%@page import="tea.entity.site.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.resource.*"%>
<%@page import="tea.db.*"%>
<%@page import="tea.entity.member.*"%>
<%@page import="tea.entity.admin.*"%>
<%@page import="java.util.Date"%>
<%@page import="java.net.URLEncoder"%>
<%
request.setCharacterEncoding("UTF-8");
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
TeaSession teasession = new TeaSession(request);
if (teasession._rv == null) {
  response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
  return;
}

//座位设置
Seat sobj = Seat.find(teasession._nNode);
int linage = 10;//总排数
int row = 10;//总列数
if(sobj.isExists())
{
  linage = sobj.getLinage();
  row = sobj.getRow();

}
//座位编号
int seid = 0;
if(teasession.getParameter("seid")!=null && teasession.getParameter("seid").length()>0)
{
  seid = Integer.parseInt(teasession.getParameter("seid"));
}
SeatEditor seobj = SeatEditor.find(seid,teasession._nNode);
String region=null;//区域
int linagenumber=0;//排号
int seatnumber=0;//座号
int picid=0;//视图

if(seobj.isExists())
{
  region = seobj.getRegion();
  linagenumber = seobj.getLinagenumber();
  seatnumber = seobj.getSeatnumber();
  picid = seobj.getPicid();
}

//添加区域视图图片
String act = teasession.getParameter("act");
if("SeatPic".equals(act)&&"POST".equals(request.getMethod()))
{

  String filepath = teasession.getParameter("file");
  String filename = teasession.getParameter("fileName");
  if(filepath==null)
  {
    out.print("<script>alert('您上传的文件不正确,请重新上传!');history.back();</script>");
    return;
  }
  SeatPic.create(teasession._nNode,filename,filepath,teasession._strCommunity,teasession._rv.toString(),1);
  response.sendRedirect("/jsp/type/venues/right_seat.jsp?node="+teasession._nNode+"&community="+teasession._strCommunity);
  return;
}
//删除
if("f3_delete".equals(act))
{
  int spid = Integer.parseInt(teasession.getParameter("spid"));
  SeatPic spobj = SeatPic.find(spid);
  spobj.delete();
}

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" language="javascript" src="/tea/tea.js"></script>
<title>场馆信息管理</title>
</head>
<body id="bodynone2">
<div id="load" >
<img src="/tea/image/public/load.gif" align="top">正在加载...
</div>
<script>
function f3_delete(igd)
{
  if(confirm('您确定要删除这个图片吗?')){
    form3.spid.value=igd;
    form3.act.value='f3_delete';
    form3.submit();
  }
}

function f_rl()
{
  //添加到座位设置表中排数和列数
  sendx("/jsp/type/venues/seat_ajax.jsp?act=form1_right_seat&node="+form1.node.value+"&community="+form1.community.value+"&row="+form1.row.value+"&linage="+form1.linage.value,
  function(data)
  {
     window.open('/jsp/type/venues/left_seat.jsp?row='+form1.row.value+'&linage='+form1.linage.value+'&node='+form1.node.value+'&community='+form1.community.value,'RightFrame');
  }
  );

}
function se()
{
  //alert("/jsp/type/venues/seat_ajax.jsp?act=form2_right_seat&node="+form2.node.value+"&community="+form2.community.value+"&seid="+form2.seid.value+"&region="+encodeURIComponent(form2.region.value)+"&linagenumber="+form2.linagenumber.value+"&seatnumber="+form2.seatnumber.value+"&picid="+form2.picid.value);
  //保存座位编辑
  if(form2.seid.value==0)
  {
    alert("请选择座位编号!");
    return false;
  }
   sendx('/jsp/type/venues/seat_ajax.jsp?act=form2_right_seat&node='+form2.node.value+'&community='+form2.community.value+'&seid='+form2.seid.value+'&region='+encodeURIComponent(form2.region.value)+'&linagenumber='+form2.linagenumber.value+'&seatnumber='+form2.seatnumber.value+'&picid='+form2.picid.value,
  function(data)
  {
 
     // alert(data.trim());
      window.open("/jsp/type/venues/right_seat.jsp?node="+form1.node.value+"&community="+form1.community.value,"MenuFrameyu");
      window.open('/jsp/type/venues/left_seat.jsp?row='+form1.row.value+'&linage='+form1.linage.value+'&node='+form1.node.value+'&community='+form1.community.value,'RightFrame');

  }
  );
}
//删除坐标号
function se_delete()
{
  sendx('/jsp/type/venues/seat_ajax.jsp?act=form1_delete&node='+form2.node.value+'&community='+form2.community.value+'&seid='+form2.seid.value,
  function(data)
  {
      window.open("/jsp/type/venues/right_seat.jsp?node="+form1.node.value+"&community="+form1.community.value,"MenuFrameyu");
      window.open('/jsp/type/venues/left_seat.jsp?row='+form1.row.value+'&linage='+form1.linage.value+'&node='+form1.node.value+'&community='+form1.community.value,'RightFrame');

  }
  );
}
//修改座位编辑中的字段
function f_submit2()
{
  //保存座位编辑
  if(form2.seid.value==0)
  {
    alert("请选择座位编号!");
    return false;
  }  
 sendx('/jsp/type/venues/seat_ajax.jsp?act=form2_right_seat&node='+form2.node.value+'&community='+form2.community.value+'&seid='+form2.seid.value+'&region='+encodeURIComponent(form2.region.value)+'&linagenumber='+form2.linagenumber.value+'&seatnumber='+form2.seatnumber.value+'&picid='+form2.picid.value,
  function(data)
  {    
      document.getElementById("showform2").innerHTML=data.trim();
  }
  );
}
</script>

<form name="form1">
  <input type="hidden" name="act">
  <input type="hidden" name="node" value="<%=teasession._nNode%>">
  <input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>

  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr> 
     <td align="center" colspan="2"><%=Node.find(teasession._nNode).getSubject(teasession._nLanguage) %></td>
  </tr>
  <tr id="tableonetr">
    <td colspan="2">座位设置</td>
  </tr>
  <tr>
    <td align="right">总排数:</td>
    <td align="left"><input name="linage" value="<%=linage%>" size="6"   mask="float" ></td>
  </tr>
   <tr>
    <td align="right">总列数:</td>
    <td align="left"><input name="row" value="<%=row%>" size="6"   mask="float" ></td>
  </tr>
   <tr>
    <td colspan="2" align="center"><input type="button" value=" 确定 " onClick="f_rl();"/></td>
  </tr>
  </table>

 </form>
 <form name="form2">
  <input type="hidden" name="act">
  <input type="hidden" name="node" value="<%=teasession._nNode%>">
  <input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr id="tableonetr">
    <td colspan="2">座位编辑</td>
  </tr>
  <tr>
    <td align="right">编号:</td>
    <td align="left"><input name="seid" value="<%if(seid!=0)out.print(seid);%>" size="6" readonly="readonly"/></td>
  </tr>
  <tr>
    <td align="right">区域:</td>
    <td align="left"><input name="region" id="region" value="<%if(region!=null)out.print(region);%>" size="6" onkeyup="f_submit2();"></td>
  </tr>
   <tr>
    <td align="right">排号:</td>
    <td align="left"><input name="linagenumber" id="linagenumber" value="<%=linagenumber%>" size="6"   mask="float"  onkeyup="f_submit2();"></td>
  </tr>
    <tr>
    <td align="right">座号:</td>
    <td align="left"><input name="seatnumber" id="seatnumber" value="<%=seatnumber%>" size="6"   mask="float"  onkeyup="f_submit2();"></td>
  </tr>
    <tr>
    <td align="right">视图:</td>
    <td align="left"> 
    <select name="picid" id="picid" onchange="f_submit2();">
    <option value="">--请选择视图--</option>
    <%
    java.util.Enumeration e2 = SeatPic.find(teasession._strCommunity," AND node = "+teasession._nNode+" order by times desc  ",0,Integer.MAX_VALUE);
    for(int i = 1;e2.hasMoreElements();i++)
    {
      int spid2 = ((Integer)e2.nextElement()).intValue();
      SeatPic spobj2 = SeatPic.find(spid2);
      out.print("<option value="+spid2);
      if(picid == spid2)
      {
        out.print(" selected ");
      }
      out.print(">"+spobj2.getPicname());
      out.print("</option>");
    }
    %>

    </select>
    </td>
  </tr>
   <tr>
    <td colspan="2">
    <input type="button" value=" 保存 " onClick="se();"/>&nbsp;
    <%
    	if(seobj.isExists())
    	{
    		out.print(" <input type=button value=\" 删除 \" onclick=se_delete();>");
    	}
     %>
    <span id ="showform2">&nbsp;</span>
    </td>

  </tr>
  </table>
  </form>

  <form name="form3" action="?" method="POST"  enctype="multipart/form-data">
  <input type="hidden" name="act" value="SeatPic">
  <input type="hidden" name="node" value="<%=teasession._nNode%>">
   <input type="hidden" name="spid">
  <input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr id="tableonetr">
    <td colspan="2">座位视图编辑</td>
  </tr>
    <tr>
    <td colspan="2">上传各区域视图：</td>
  </tr>
    <tr>
    <td colspan="2"><input type="file" name="file"   onchange='form3.submit();' ></td>
  </tr>
  <%
  java.util.Enumeration e = SeatPic.find(teasession._strCommunity," AND type = 1 AND node = "+teasession._nNode+" order by times desc  ",0,Integer.MAX_VALUE);
  for(int i = 1;e.hasMoreElements();i++)
  {
    int spid = ((Integer)e.nextElement()).intValue();
    SeatPic spobj = SeatPic.find(spid);
  %>
  <tr>
      <td><%=i %>:&nbsp;<%=spobj.getPicname()%></td>
      <td align="right"><a href="javascript:f3_delete('<%=spid%>');">删除</a> </td>
  </tr>
  <%} %>
  </table>

  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr id="tableonetr">
    <td colspan="2">座位总数&nbsp;&nbsp;&nbsp; <font color="red"><%=SeatEditor.count(teasession._strCommunity," and node= "+teasession._nNode) %></font>&nbsp;个</td>
  </tr>
  </table>

   <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr id="tableonetr">
    <td colspan="2">

      <input type="button" value="完成座位设置"  onClick="javascript:window.parent.close(1);">
    </td>
  </tr>
  </table>

  </form>
    <script>
var load=document.getElementById('load');
load.style.display='none';
</script>
</body>
</html>
