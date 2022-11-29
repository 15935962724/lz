<%@page contentType="text/html;charset=UTF-8"%>
<%@include file="/jsp/Header.jsp"%>
<%@page import="tea.ui.*"%>
<%@page import="tea.*"%>
<html>
<%
request.setCharacterEncoding("UTF-8");
  TeaSession teasession = new TeaSession(request);
  Resource r = new Resource();
  r.add("/tea/resource/Hostel");
  if (teasession._rv.toString() == null) {
   response.sendRedirect("/jsp/admin/logg.jsp?nexturl="+request.getRequestURI()+"?"+request.getQueryString());
    return;
  }
    Hostel hostel = Hostel.find(node._nNode, 1);
  Profile profile = Profile.find(teasession._rv.toString());

  int roomPriceId =0; //Integer.parseInt(request.getParameter("roomprice"));b
  RoomPrice roomPrice = RoomPrice.find(roomPriceId);
  if(request.getParameter("roomprice")!=null){
    roomPriceId = Integer.parseInt(request.getParameter("roomprice"));
  }
  r.add("/tea/resource/Hostel");
  int roomcount = 1;
  String tetName[] = new String[13];
  String handset, phone;
  String roomType;
  String kipDateFlag, leaveDateFlag;
  String eveningArrive;
  int paymentType = 0;
  String linkmanName = "";
  boolean linkmanSex;
  String linkmanHandset = "", linkmanPhone = "";
  String linkmanMail;
  String linkmanFax;
  int linkmanaffirm = 1;
  boolean otherSend = false;
  String otherPostalcode;
  String otherName;
  String otherAddress;
  String otherRequest;
  int otheraddbed = 0;
  java.util.Enumeration enumeration = RoomPrice.findByNode(teasession._nNode);
  tetName[0] = teasession._rv.toString();
  handset = linkmanHandset = profile.getMobile();
  phone = linkmanPhone = profile.getTelephone(teasession._nLanguage);
  roomType = roomPrice.getRoomtype(teasession._nLanguage);
  kipDateFlag = "";
  leaveDateFlag = "";
  eveningArrive = "16:00";
  linkmanSex = profile.isSex();
  linkmanMail = profile.getEmail();
  linkmanFax = profile.getFax(teasession._nLanguage);
  otherRequest = "";
  otherName = profile.getFirstName(teasession._nLanguage);
  otherAddress = profile.getAddress(teasession._nLanguage);
  otherPostalcode = profile.getZip(teasession._nLanguage);
  String act = request.getParameter("act");
  if (act != null) {
    String value = request.getParameter("value");
    if (act.equals("firstname")) {
      out.println(!Profile.isExisted(value));
    }
    return;
  }

%>
<head>

<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<SCRIPT LANGUAGE="JAVASCRIPT" SRC="/tea/tea.js" type="text/javascript"></SCRIPT>
<SCRIPT LANGUAGE="JAVASCRIPT" SRC="/tea/load.js" type="text/javascript"></SCRIPT>
</head>
<SCRIPT LANGUAGE="JAVASCRIPT" type="">
function abc(){
if(submitInteger(form1.roomcount, '无效-房间数量')&&submitText(form1.kipDateFlag,'无效-住店日期')&&submitText(form1.leaveDateFlag,'无效-离开日期')){
var   test   =   document.form1.roomprice;
  var   len   =   test.length;
  for(var   i   =   0;i<len;i++){
          if(test[i].checked   ==   true){
         var roomp = test[i].value;
          }
  }

  var roomc = document.form1.roomcount.value;
  var sdate = document.form1.kipDateFlag.value;
  var edate = document.form1.leaveDateFlag.value;

  window.open('/jsp/registration/rpsanda.jsp?node=<%=node._nNode%>&roomp='+roomp+'&roomc='+roomc+'&sdate='+sdate+'&edate='+edate, 'anyname', 'width=300,height=200,left=700,top=200');

}
}

function ShowCalendar(fieldname)
{
 window.showModalDialog("/jsp/registration/Calendar2.jsp?FIELDNAME="+fieldname,self,"edge:raised;scroll:0;status:0;help:0;resizable:1;dialogWidth:280px;dialogHeight:205px;dialogTop:"+200+"px;dialogLeft:"+300+"px");
}
//去掉字串两端的空格
//检测用户的姓名是否合法
function f_ajax(obj)
{
  var act=obj.name;
  var sv=document.getElementById('span_'+act);
  if(obj.value=="")
  {
    sv.innerHTML="<img src=/tea/image/public/check_error.gif>不能为空";
    return;
  }
  sv.innerHTML="<img src=/tea/image/public/load.gif>";
  sendx("?act="+act+"&value="+obj.value,function(v)
  {
    if(v.indexOf('true')!=-1)
    {
      sv.innerHTML="<img src=/tea/image/public/check_right.gif>";
    }else
    {
        sv.innerHTML="<img src=/tea/image/public/check_error.gif>输入错误!请重新输入";
    }
  }
  )
}
function change(bool)
{
  if (bool)
  {
    document.form1.linkmanname.value=document.form1.TxtName.value;
    document.form1.linkmanhandset.value=document.form1.handset.value;
    document.form1.linkmanphone.value=document.form1.phone.value;
    var value;
    var Object=document.getElementsByName("sex");
    for(iIndex=0;iIndex<Object.length;iIndex++)
    {
      if(Object[iIndex].checked==true)
      {
        value = Object[iIndex].value;
      }
    }

    if(value!=null)
    {
      if(value=="true")
      {
        document.all.linkmanboy.checked = "checked";
      }
      else if(value=="false")
      {
        document.all.linkmangirl.checked = "checked";
      }
    }
   }else
  {
    document.form1.linkmanname.value="";
    document.form1.linkmanhandset.value="";
    document.form1.linkmanphone.value="";
    document.form1.linkmansex.value="";
  }
}
function changexy(bool)
{
  if (bool)
  {
    if(document.getElementById("otherpostalcode").value==""||document.getElementById("otheraddress").value=="")
    {
      alert("不允许为空!");
      return false;
    }
   }
   else
  {
    document.form1.otherpostalcode.value="";
    document.form1.otheraddress.value="";
  }
}
function submitRp(){
  var radio_fag=document.form1.roomprice;
  if(!(radio_fag.checked)){
    alert('请选择房间类型');
    radio_fag.focus();
    return false;
  }
  return true;
}
function submitmem(){
  var checkMem = document.form1.newmember;

  if(checkMem.checked){


    return (submitText(form1.memberid,'请填写会员ID'));

  }
  return true;
}
function check(form)
{
if(submitInteger(form.roomcount, '无效-房间数量')
&&submitText(form.kipDateFlag,'无效-住店日期')
   &&submitText(form.leaveDateFlag,'无效-离开日期')
   &&submitText(form.TxtName,'无效-入住人')
   &&submitmem()
    &&submitQh(form.phone)
   &&submitText(form.linkmanname,'无效-联系人姓名')
   &&submitQh(form.linkmanphone)
)
  {
    if(form.linkmanhandset.value==""&&form.linkmanphone.value=="")
    {
      alert("请填写联系人的一种联系方式!");
      return false;
    }
    //入住日期和离开日期的那个判断
    var time = new Date();
    //入住日期
    var trz = new Date(Date.parse(form.kipDateFlag.value.replace("-","/")));
    //离开日期
    var tlk = new Date(Date.parse(form.leaveDateFlag.value.replace("-","/")));
    if(trz.getTime()<time.getTime())
    {
      alert('无效-入住日期');
      return false;
    }
    if(trz.getTime()>tlk.getTime())
    {
      alert('无效-离开日期');
      return false;
    }
     changexy();
//    if(submitText(form.linkmanaffirm,'无效-确认方式'))
//    {
      var affirm = document.getElementById('linkmanaffirm').value;
      if(affirm=="1")
      {
        if(submitText(form.linkmanhandset,'无效-手机号码')
          &&submitInteger(form.linkmanhandset,'无效-手机号码')
          &&submitLength(11,12,form.linkmanhandset,'无效-手机号码'))
          {
          }
          else{return false;}
      }
//      else if(affirm=="2")
//      {
//        if(submitText(form.linkmanphone,'无效-电话'))
//        {}
//        else {return false;}
//      }
      else if(affirm=="3")
      {
        if(submitText(form.linkmanfax,'无效-传真'))
        {}
        else{return false;}
      }
      else if (affirm=="4")
      {
        if(submitEmail(form.linkmanmail,'无效-电子邮件'))
        {

        }else
        {return false;}
      }
//    }
  }else
  {
	return false;
  }
}
///////////////最晚最早到达时间检测函数//////////////////////

function f_unit(m)
{
  form1.memberid.value = m;
}

function f_jiance()
{
  var mem = form1.memberid.value;
  currentPos = "show";
  send_request("/jsp/registration/EditDestine_ajax.jsp?mem="+mem);

}
</SCRIPT>
<body id="bodynone">
<h1>会员预订房间</h1>
<div id="head6">
  <img height="6" src="about:blank" alt="">
</div>
<form name="form1" action="/jsp/registration/DesCallView.jsp" method="post" target="_self" onsubmit="return check(this);">
<input type="hidden" name="SelNumGuest" value=""/>
<%if (request.getParameter("edit") != null && request.getParameter("edit") != "ON") {%>
<input type=hidden name="edit" value="ON">
<%}%>
<%if (request.getParameter("destine") != null) {%>
<input type=hidden name="destine" value="<%=request.getParameter("destine")%>">
<%}%>
<h2>预定信息</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <!--<tr>
    <TD>房间数量：</TD>
    <td>
      <select name="roomcount" id="num_room" onchange="">
        <option selected value="1">1</option>
        <option value="2">2</option>
        <option value="3">3</option>
        <option value="4">4</option>
        <option value="5">5或5间以上</option>
      </select>
      <font color="#1EA817">※</font>
    </td>
  </tr>-->
   <tr>
    <TD>房间数量：</TD>
    <td>
      <input type="text" name="roomcount" id="num_room" value="<%if(request.getParameter("roomcount")!=null)out.print(request.getParameter("roomcount"));%>" onchange="" maxlength="2">
 <input type="hidden" name="nnode" value="<%=teasession._nNode%>">
      <font color="#1EA817">※</font>
    </td>
  </tr>
  <tr>
    <TD>住店日期：</TD>
    <td>
      <input class="text" readonly="readonly" type="text" maxLength="12" size="9" value="<%if(request.getParameter("kipDateFlag")!=null)out.print(request.getParameter("kipDateFlag"));%>" name="kipDateFlag" ID="Text3" onchange="f_ajax(this)">
      <span id="span_kipDateFlag"></span>
      &nbsp;
       <A href="###"><img onclick="showCalendar('form1.kipDateFlag');" src="/tea/image/public/Calendar2.gif" align="top"/></a>
      离开日期：
      <input class="text" readonly="readonly" type="text" maxLength="12" size="9" value="<%if(request.getParameter("leaveDateFlag")!=null)out.print(request.getParameter("leaveDateFlag"));%>" name="leaveDateFlag" ID="Text4" onchange="f_ajax(this)">
      <span id="span_leaveDateFlag"></span>
      &nbsp;
    <A href="###"><img onclick="showCalendar('form1.leaveDateFlag');" src="/tea/image/public/Calendar2.gif" align="top"/></a>
      &nbsp;&nbsp;
      <font color="#1EA817">※</font>
    </td>
  </tr>
  <tr>
    <TD>最晚到达时间：</TD>
    <td>
    <%String abc = request.getParameter("eveningarrive");%>
      <select name="eveningarrive" id="time_late" onChange="javascript:ChkLateTime()">
         <option value="10:00" <%if(abc!=null && "10:00".equals(abc))out.print("selected");%>>10:00</option>
        <option value="10:30" <%if(abc!=null && "10:30".equals(abc))out.print("selected");%>>10:30</option>
        <option value="11:00" <%if(abc!=null && "11:00".equals(abc))out.print("selected");%>>11:00</option>
        <option value="11:30" <%if(abc!=null && "11:30".equals(abc))out.print("selected");%>>11:30</option>
        <option value="12:00" <%if(abc!=null && "12:00".equals(abc))out.print("selected");%>>12:00</option>
        <option value="12:30"<%if(abc!=null && "12:30".equals(abc))out.print(" selected");%>>12:30</option>
        <option value="13:00"<%if(abc!=null && "13:00".equals(abc))out.print(" selected");%>>13:00</option>
        <option value="13:30"<%if(abc!=null && "13:30".equals(abc))out.print(" selected");%>>13:30</option>
        <option value="14:00"<%if(abc!=null && "14:00".equals(abc))out.print(" selected");%>>14:00</option>
        <option value="14:30"<%if(abc!=null && "14:30".equals(abc))out.print(" selected");%>>14:30</option>
        <option value="15:00"<%if(abc!=null && "15:00".equals(abc))out.print(" selected");%>>15:00</option>
        <option value="15:30"<%if(abc!=null && "15:30".equals(abc))out.print(" selected");%>>15:30</option>
        <option value="16:00"<%if(abc!=null && "16:00".equals(abc))out.print(" selected");%>>16:00</option>
        <option value="16:30"<%if(abc!=null && "16:30".equals(abc))out.print(" selected");%>>16:30</option>
        <option value="17:00"<%if(abc!=null && "17:00".equals(abc))out.print(" selected");%>>17:00</option>
        <option value="17:30"<%if(abc!=null && "17:30".equals(abc))out.print(" selected");%>>17:30</option>
        <option value="18:00"<%if(abc!=null && "18:00".equals(abc))out.print(" selected");%>>18:00</option>
        <option value="18:30"<%if(abc!=null && "18:30".equals(abc))out.print(" selected");%>>18:30</option>
        <option value="19:00"<%if(abc!=null && "19:00".equals(abc))out.print(" selected");%>>19:00</option>
        <option value="19:30"<%if(abc!=null && "19:30".equals(abc))out.print(" selected");%>>19:30</option>
        <option value="20:00"<%if(abc!=null && "20:00".equals(abc))out.print(" selected");%>>20:00</option>
        <option value="20:30"<%if(abc!=null && "20:30".equals(abc))out.print(" selected");%>>20:30</option>
        <option value="21:00"<%if(abc!=null && "21:00".equals(abc))out.print(" selected");%>>21:00</option>
        <option value="21:30"<%if(abc!=null && "21:30".equals(abc))out.print(" selected");%>>21:30</option>
        <option value="22:00" <%if(abc!=null && "22:00".equals(abc))out.print("selected");%>>22:00</option>
        <option value="22:00" <%if(abc!=null && "22:30".equals(abc))out.print("selected");%>>22:30</option>
        <option value="23:00" <%if(abc!=null && "23:00".equals(abc))out.print("selected");%>>23:00</option>
        <option value="23:30" <%if(abc!=null && "23:30".equals(abc))out.print("selected");%>>23:30</option>
        <option value="23:59" <%if(abc!=null && "23:59".equals(abc))out.print("selected");%>>23:59</option>
      </select>
      <font color="#1EA817">
        <font color="#1EA817">※</font>
      </font>
    </td>
  </tr>

  <tr>
    <%-- <TD>房间类型：</TD>
    <td>
    <%
    //  if (request.getParameter("edit") != null && !request.getParameter("edit").equals("ON")) {
        out.print("<select name=roomprice>");
        out.print("<option value=0>"+hostel.getHousexing()+"</option>");

        while (enumeration.hasMoreElements()) {
          int roomprice_enumer = ((Integer) enumeration.nextElement()).intValue();
          RoomPrice rp_enumer = RoomPrice.find(roomprice_enumer);
          out.print("<option value=" + roomprice_enumer);
          if (roomprice_enumer == roomPriceId){
            out.println(" selected");
          }
          out.println(">" + rp_enumer.getRoomtype(teasession._nLanguage));

       }
        out.print("</select>");
      //}
    //  else {
       // if (roomPriceId != 0) {
          //out.print("<input type=hidden  name=roomprice value=" + roomPriceId + ">" + roomPrice.getRoomtype(teasession._nLanguage));
       // }
     // }
    %>
      <font color="#1EA817">※</font>
      　　　　　&nbsp;&nbsp;<input type="button" value="查询房价" onclick="return abc();"/>
    </td>--%>
     <%
  String sb = ",";
  java.util.Enumeration enumer1 = tea.entity.node.RoomPrice.findByNode(node._nNode);
  if(enumer1.hasMoreElements()){%>
<td >选择房间类型：<br /><br /><input type="button" value="价格清单" onclick="return abc();"/></td><td align="left">  <table width="100%" id="tablecenter">
  <tr ID=tableonetr>
  <td>　</td>
    <td nowrap><%=r.getString(teasession._nLanguage, "RoomType")%>    </td>
    <td nowrap><%=r.getString(teasession._nLanguage, "Retail")%>    </td>
    <td nowrap><%=r.getString(teasession._nLanguage, "Proscenium")%>    </td>
    <td nowrap><%=r.getString(teasession._nLanguage, "Net")%>    </td>
    <td nowrap><%=r.getString(teasession._nLanguage, "Weekend")%>    </td>
  </tr>
  <%
  int z = 0;
  while (enumer1.hasMoreElements()) {
    int id = ((Integer) enumer1.nextElement()).intValue();
    tea.entity.node.RoomPrice obj = tea.entity.node.RoomPrice.find(id);
    sb = sb + id + ",";
%>


  <tr>
  <td><input type="radio" name="roomprice" value="<%=id%>" <%if(request.getParameter("roomp")!=null){if(id==Integer.parseInt(request.getParameter("roomp")))out.print("checked");}else{if(z==0)out.print("checked");}%>/></td>
    <td><%=obj.getRoomtype(teasession._nLanguage)%>    </td>
    <td><%=obj.getRetail()%>元    </td>
    <td><%=obj.getProscenium()%>元    </td>
    <td><%=obj.getNet()%>元    </td>
    <td><%=obj.getWeekend()%>元    </td>
  </tr>

<%z++;}out.print("</table></td></tr>");}%></td>

  </tr>
</table>
<h2>入住人信息</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td>入 住 人：</td>
    <td>
      <input name="TxtName" type="text" value="<%if(request.getParameter("TxtName")!=null)out.print(request.getParameter("TxtName"));%>">
    </td>
  </tr>
  <tr>
    <td>会员ID：</td>
    <td>
      <input name="memberid" type="text" value="<%if(request.getParameter("memberid")!=null)out.print(request.getParameter("memberid"));%>">&nbsp;
      <input type="button" value="查询会员" onclick="window.open('/jsp/registration/membershow.jsp','new','height=300,width=500,scrollbars=no,location=no,scrollbars=1');" />
      <input type="checkbox" value="1" name="newmember" onclick="f_jiance();" />同时注册会员&nbsp;&nbsp;<span id="show">&nbsp;</span>
    </td>
  </tr>
  <tr>
    <TD>性 　　别：</TD>
    <td>
      <input id="sexb" type="radio" value="true" name="sex" checked="checked">
      男
      <input id="sexg" type="radio" value="false" name="sex">
      女
      <font color="#1EA817">※</font>
    </td>
  </tr>
  <tr>
    <TD>手机号码：</TD>
    <td>
      <input name="handset" type="text" value="" size="15">
      <font color="#1EA817">※</font>
      如果没有手机，请留下座机号码：
      <input name="phone" type="text" value="" maxlength=20>&nbsp;(请加区号)
    </td>
  </tr>
  <tr>
    <TD>付款类型：</TD>
    <td>
      <select name="paymenttype">
      <%for (int i = 0; i < RoomPrice.PAYMENT.length; i++) {%>
        <option value="<%=i%>"><%=r.getString(teasession._nLanguage,RoomPrice.PAYMENT[i])%>        </option>
      <%}%>
      </select>

      <font color="#1EA817">※</font>
    </td>
  </tr>
</table>
<h2>联系人信息</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td colspan=2>
      <input id="CHECKBOX" type="CHECKBOX" onclick="javascript:change(this.checked);">
      与入住人相同
    </td>
  </tr>
  <tr>
    <TD>联系人姓名：</TD>
    <td>
      <input name="linkmanname" type="text" value="<%if(request.getParameter("linkmanname")!=null)out.print(request.getParameter("linkmanname"));%>" size="15">
      <font color="#1EA817">※</font>
    </td>
  </tr>
  <tr>
    <TD>性 　　别：</TD>
    <td>
      <input id="linkmanboy" type="radio" value="true" name="linkmansex" checked="checked">
      男
      <input id="linkmangirl" type="radio" name="linkmansex" value="false">
      女
      <font color="#1EA817">※</font>
    </td>
  </tr>
  <tr>
    <TD>手机号码：</TD>
    <td>
      <input name="linkmanhandset" type="text" value="<%if(request.getParameter("linkmanhand")!=null)out.print(request.getParameter("linkmanhand"));%>" size="15">
      <font color="#1EA817">※</font>
      如果没有手机，请留下座机号码：
      <input name="linkmanphone" type="text" value="<%if(request.getParameter("linkmanph")!=null)out.print(request.getParameter("linkmanph"));%>" maxlength=20>&nbsp;(请加区号)
    </td>
  </tr>
  <tr>
    <TD>电子邮件：</TD>
    <td>
      <input name="linkmanmail" type="text" style="width:180px;" value="" size="25">
    </td>
  </tr>
  <tr>
    <TD>传　　真：</TD>
    <td>
      <input name="linkmanfax" type="text" style="width:180px;" value="<%=linkmanFax%>" size="15">
      <font color="#1EA817">※</font>
    </td>
  </tr>
  <tr>
    <TD>确认方式：</TD>
    <td>
      <select name="linkmanaffirm" id="linkmanaffirm">
        <option value="0">不需确认
        <option value="1">使用短信来确认
        <option value="2">使用电话来确认
        <option value="3">使用传真来确认
        <option value="4">使用e-mail来确认
      </select>
      <font color="#1EA817">※</font>
    </td>
  </tr>
  <tr>
    <td height="45" align="center" colspan="2">
      <font color="#DC441C">
        <strong>为了与您及时确认并联系，请您确认留下的联系方式</strong>
      </font>
    </td>
  </tr>
</table>
<h2>特殊要求</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td>旅客留言：</td>
    <td>
      <textarea name="otherrequest" rows="5" style="width:500px;" cols=""><%=otherRequest%>      </textarea>
      最多255个字符
    </td>
  </tr>
  <tr>
    <td>是/否加床：</td>
    <td>
      <input name="otheraddbed" type="text" style="width:70px;" size="3" maxlength="3" value="<%=otheraddbed%>">(不填为不需要加床)
      　　　　　如您在最晚到店时间以后到店，请及时与我们联系.
    </td>
  </tr>
</table>
<h2>酒店说明</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr id="mobilesend" style="DISPLAY: yes">
    <td colspan="2">当您成功入住酒店后，我们会按照您填写的邮编地址，在15天内给您邮寄一份最新商旅手册。</td>
  </tr>
  <tr id="mobilesend" style="DISPLAY: yes">
    <td colspan="2">
      <input name="othersend" id="CHECKBOX" type="CHECKBOX" value="no" onclick="javascript:changexy(this.checked);">
      我需要（注：如果您需要寄卡，请确保您填写的会员注册信息是真实的,我们会按此邮寄。）
    </td>
  </tr>
  <tr id="mobilesend" style="DISPLAY: yes">
    <td width="15%">收件人姓名：</td>
    <td>
      <input id="othername" type="text" name="othername" size=6 value="" maxlength=6>
    </td>
  </tr>
  <tr id="mobilesend" style="DISPLAY: yes">
    <td>邮政编码：</td>
    <td>
      <input id="otherpostalcode" type="text" name="otherpostalcode" size=6 value="" maxlength=6>
    </td>
  </tr>
  <tr id="mobilesend" style="DISPLAY: yes">
    <td>通讯地址：</td>
    <td>
      <input id="otheraddress" type="text" name="otheraddress" size="30" maxlength="64" value="">
    </td>
  </tr>
</table>
<table width="750" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="719" height="50" align="center">
      <input type="submit" name="" value="下一步"/>
    </td>
  </tr>
</table>
</form>
<div id="head6">
  <img height="6" src="about:blank" alt="">
</div>
</body>
</html>
