<%@page contentType="text/html;charset=UTF-8"%>
<%@include file="/jsp/Header.jsp"%>
<%@page import="tea.ui.*"%>
<%@page import="tea.*"%>
<html>
<%
request.setCharacterEncoding("UTF-8");
  TeaSession teasession = new TeaSession(request);
  if (teasession._rv.toString() == null) {
  response.sendRedirect("/jsp/admin/logg.jsp?nexturl="+request.getRequestURI()+"?"+request.getQueryString());
    return;
  }
  Profile profile = Profile.find(teasession._rv.toString());
  int roomPriceId = Integer.parseInt(request.getParameter("roomprice"));
  RoomPrice roomPrice = RoomPrice.find(roomPriceId);
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
  Hostel hostel = Hostel.find(node._nNode, 1);
%>
<head>
<script src="/tea/tea.js" type="text/javascript"></script>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<SCRIPT LANGUAGE="JAVASCRIPT" SRC="/tea/tea.js" type="text/javascript"></SCRIPT>
</head>
<SCRIPT LANGUAGE="JAVASCRIPT" type="">
function ShowCalendar(fieldname)
{
 window.showModalDialog("Calendar2.jsp?FIELDNAME="+fieldname,self,"edge:raised;scroll:0;status:0;help:0;resizable:1;dialogWidth:280px;dialogHeight:205px;dialogTop:"+200+"px;dialogLeft:"+300+"px");
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
//    if(document.getElementById("otherpostalcode").value==""||document.getElementById("otheraddress").value=="")
//    {
//      alert("邮编和地址不允许为空!");
//      return false;
//    }
   }
   else
  {
//    document.form1.otherpostalcode.value="";
//    document.form1.otheraddress.value="";
  }
}
function check(form)
{
if(submitInteger(form.roomcount, '无效-房间数量')
&&submitText(form.kipDateFlag,'无效-住店日期')
   &&submitText(form.leaveDateFlag,'无效-离开日期')
   &&submitText(form.TxtName,'无效-入住人')
   &&submitQh(form.phone)
   &&submitText(form.linkmanname,'无效-联系人姓名')
   &&submitQh(form.linkmanphone)
)
  {
    if(form.handset.value==""&&form.phone.value=="")
    {
      alert("请填写一种联系方式!");
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
//    if(submitSelect(form.linkmanaffirm,'无效-确认方式'))
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
</SCRIPT>
<body>
<h1>会员预订房间</h1>
<div id="head6">
  <img height="6" src="about:blank" alt="">
</div>
<form name="form1" <%--action="/servlet/EditDestine?node=<%=teasession._nNode%>"--%> action="/jsp/type/hostel/DesView.jsp" method="post" target="_self" onsubmit="return check(this);">
<input type="hidden" name="SelNumGuest" value=""/>
<input type="hidden" name="roompriceid" value="<%=roomPriceId%>"/>
<%if (request.getParameter("edit") != null && request.getParameter("edit") != "ON") {%>
<input type=hidden name="edit" value="ON">
<%}%>
<%if (request.getParameter("destine") != null) {%>
<input type=hidden name="destine" value="<%=request.getParameter("destine")%>">
<%}%>
<h2>预定信息</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <TD>房间数量：</TD>
    <td>
      <input type="text" name="roomcount" id="num_room" onchange="" maxlength="2" value="<%if(request.getParameter("roomcount")!=null)out.print(request.getParameter("roomcount"));%>">

      <font color="#1EA817">※</font>
    </td>
  </tr>
  <tr>
    <TD>住店日期：</TD>
    <td>
      <input class="text" readonly="readonly" type="text" maxLength="12" size="9" value="<%if(request.getParameter("kipDateFlag")!=null)out.print(request.getParameter("kipDateFlag"));%>" name="kipDateFlag" ID="Text3" onchange="f_ajax(this)">
      <span id="span_kipDateFlag"></span>
      &nbsp;
      <a href="javascript:ShowCalendar('form1.kipDateFlag')" target="_self">
        <img id="dimg3" style="POSITION: relative" src="/tea/image/public/Calendar2.gif" border="0" align="middle" alt=""">
      </a>

      　　
      离开日期：
      <input class="text" readonly="readonly" type="text" maxLength="12" size="9" value="<%if(request.getParameter("leaveDateFlag")!=null)out.print(request.getParameter("leaveDateFlag"));%>" name="leaveDateFlag" ID="Text4" onchange="f_ajax(this)">
      <span id="span_leaveDateFlag"></span>
      &nbsp;
      <a href="javascript:ShowCalendar('form1.leaveDateFlag')" target="_self">
        <img id="dimg4" style="POSITION: relative" src="/tea/image/public/Calendar2.gif" border="0" align="middle" alt="">
      </a>
      &nbsp;&nbsp;
      <font color="#1EA817">※</font>
    </td>
  </tr>
  <tr>
    <TD>最晚到达时间：</TD>
    <td>
    <%String abc = request.getParameter("eveningarrive"); %>
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
        <%
  String sb = ",";
  java.util.Enumeration enumer1 = tea.entity.node.RoomPrice.findByNode(node._nNode);
  if(enumer1.hasMoreElements()){%>
<td >选择房间类型：</td><td align="left">  <table width="100%" id="tablecenter">
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
      <input name="handset" type="text" value="<%=handset%>" size="15">
      <font color="#1EA817">※</font>
      如果没有手机，请留下座机号码：
      <input name="phone" type="text" value="<%=phone%>" maxlength=20>&nbsp;(请加区号)
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
      <input name="linkmanhandset" type="text" value="<%=linkmanHandset%>" size="15">
      <font color="#1EA817">※</font>
      如果没有手机，请留下座机号码：
      <input name="linkmanphone" type="text" value="<%=linkmanPhone%>" maxlength=20>&nbsp;(请加区号)
    </td>
  </tr>
  <tr>
    <TD>电子邮件：</TD>
    <td>
      <input name="linkmanmail" type="text" style="width:180px;" value="<%=linkmanMail%>" size="25">
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
    <td>加床数量：</td>
    <td>
      <input name="otheraddbed" type="text" style="width:70px;" size="3" maxlength="3" value="<%=otheraddbed%>">(不填为不需要加床)
      　　　　　如您在最晚到店时间以后到店，请及时与我们联系.
    </td>
  </tr>
</table>
<h2>酒店说明</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
 <tr>

 <td>说明</td><td align="left"><%=hostel.getClew() %></td>
 </tr>
 <tr>
<td colspan="2">如需酒店其它优惠信息请留下E-MAIL，我们会按照您填写的邮箱地址发送至您的邮箱!</td>
 </tr>
 <tr>
 <td colspan="2">您的邮箱：<input type="text" name="othermail" value="<%=linkmanMail%>"/></td>
 </tr>
 <tr><td colspan="2"><input name="othersend" id="CHECKBOX" type="CHECKBOX" value="no" onclick="javascript:changexy(this.checked);">
      我需要</td>
 </tr>
  <!-- <tr id="mobilesend" style="DISPLAY: yes">
    <td colspan="2">当酒店确认后，我们会按照您填写的E-MAIL地址将确认邮件发送至您的邮箱。</td>
  </tr>
  <tr id="mobilesend" style="DISPLAY: yes">
    <td colspan="2">
      <input name="othersend" id="CHECKBOX" type="CHECKBOX" value="no" onclick="javascript:changexy(this.checked);">
      我需要（注：如果您需要寄卡，请确保您填写的会员注册信息是真实的,我们会按此邮寄。）
    </td>
  </tr>
  <tr id="mobilesend" style="DISPLAY: yes">
    <td>邮政编码：</td>
    <td>
      <input id="otherpostalcode" type="text" name="otherpostalcode" size=6 value="<%=otherPostalcode%>" maxlength=6>
    </td>
  </tr>
  <tr id="mobilesend" style="DISPLAY: yes">
    <td>通讯地址：</td>
    <td>
      <input id="otheraddress" type="text" name="otheraddress" size="30" maxlength="64" value="<%=otherAddress%>">
    </td>
  </tr>-->
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
