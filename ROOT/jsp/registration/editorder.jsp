<%@page contentType="text/html;charset=UTF-8"%>
<%@include file="/jsp/Header.jsp"%>
<%@page import="tea.ui.*" %>
<%@page import="tea.*" %>
<%@ page import=" tea.entity.node.*"%>
<html>
<%
request.setCharacterEncoding("UTF-8");
  TeaSession teasession = new TeaSession(request);
  if(teasession._rv.toString()==null)
{
  response.sendRedirect("/jsp/user/StartLogin.jsp");
  return ;
}

  int destine = Integer.parseInt(teasession.getParameter("destine"));
  String member =  teasession._rv.toString();
  Destine obj = Destine.find(destine);

  String act=request.getParameter("act");
  if(act!=null)
  {
    String value=request.getParameter("value");
    if(act.equals("firstname"))
    {
      out.println(!Profile.isExisted(value));
    }
    return;
  }
  Hostel h = Hostel.find(obj.getNode(), teasession._nLanguage);

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
 window.showModalDialog("/jsp/registration/Calendar2.jsp?FIELDNAME="+fieldname,self,"edge:raised;scroll:0;status:0;help:0;resizable:1;dialogWidth:280px;dialogHeight:205px;dialogTop:"+200+"px;dialogLeft:"+300+"px");
}
//去掉字串两端的空格
//检测用户的姓名是否合法
function f_ajax(obj1)
{
  var act=obj1.name;
  var sv=document.getElementById('span_'+act);
  if(obj1.value=="")
  {
    sv.innerHTML="<img src=/tea/image/public/check_error.gif>不能为空";
    return;
  }
  sv.innerHTML="<img src=/tea/image/public/load.gif>";
  sendx("?act="+act+"&value="+obj1.value,function(v)
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
//      alert("不允许为空!");
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
if(submitText(form.roomcount, '无效-房间数量')
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
  <div id="head6"><img height="6" src="about:blank" alt=""></div>
<form name="form1" action="/servlet/AuditDestine_hy?node=<%=teasession._nNode%>" method="post" target="_self" onsubmit="return check(this);">
 <h2>更改预定信息</h2>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <TD>房间数量：</TD>
      <td>  <input type="text" name="roomcount" id="num_room" value="<%=obj.getRoomcount()%>" onchange="" maxlength="2">
      <input type="hidden" name="member" value="<%=member%>" />
      <font color="#1EA817">※</font>
      <input type=hidden name="destine" value="<%=destine%>">
       <input type=hidden name="nexturl" value="<%=request.getParameter("nexturl")%>">
      </td>
    </tr>
        <tr>
      <TD>住店日期：</TD>
      <td>
      <input name="kipDateFlag" size="7"  value="<%=obj.getKipdateToString()%>"><A href="###"><img onclick="showCalendar('form1.kipDateFlag');" src="/tea/image/public/Calendar2.gif" align="top"/></a>

      离开日期：
       <input name="leaveDateFlag" size="7"  value="<%=obj.getLeavedateToString()%>"><A href="###"><img onclick="showCalendar('form1.leaveDateFlag');" src="/tea/image/public/Calendar2.gif" align="top"/></a>

         <font color="#1EA817">※</font> </td>
    </tr>
    <tr>
      <TD> 最晚到达时间：</TD>
      <td><select name="eveningarrive" id="time_late">
          <option value="10:00"<%=getSelect(obj.getEveningarrive().equals("10:00"))%>>10:00</option>
          <option value="10:30"<%=getSelect(obj.getEveningarrive().equals("10:30"))%>>10:30</option>
          <option value="11:00"<%=getSelect(obj.getEveningarrive().equals("11:00"))%>>11:00</option>
          <option value="11:30"<%=getSelect(obj.getEveningarrive().equals("11:30"))%>>11:30</option>
          <option value="12:00"<%=getSelect(obj.getEveningarrive().equals("12:00"))%>>12:00</option>
          <option value="12:30"<%=getSelect(obj.getEveningarrive().equals("12:30"))%>>12:30</option>
          <option value="13:00"<%=getSelect(obj.getEveningarrive().equals("13:00"))%>>13:00</option>
          <option value="13:30"<%=getSelect(obj.getEveningarrive().equals("13:30"))%>>13:30</option>
          <option value="14:00"<%=getSelect(obj.getEveningarrive().equals("14:00"))%>>14:00</option>
          <option value="14:30"<%=getSelect(obj.getEveningarrive().equals("14:30"))%>>14:30</option>
          <option value="15:00"<%=getSelect(obj.getEveningarrive().equals("15:00"))%>>15:00</option>
          <option value="15:30"<%=getSelect(obj.getEveningarrive().equals("15:30"))%>>15:30</option>
          <option value="16:00"<%=getSelect(obj.getEveningarrive().equals("16:00"))%>>16:00</option>
          <option value="16:30"<%=getSelect(obj.getEveningarrive().equals("16:30"))%>>16:30</option>
          <option value="17:00"<%=getSelect(obj.getEveningarrive().equals("17:00"))%>>17:00</option>
          <option value="17:30"<%=getSelect(obj.getEveningarrive().equals("17:30"))%>>17:30</option>
          <option value="18:00"<%=getSelect(obj.getEveningarrive().equals("18:00"))%>>18:00</option>
          <option value="18:30"<%=getSelect(obj.getEveningarrive().equals("18:30"))%>>18:30</option>
          <option value="19:00"<%=getSelect(obj.getEveningarrive().equals("19:00"))%>>19:00</option>
          <option value="19:30"<%=getSelect(obj.getEveningarrive().equals("19:30"))%>>19:30</option>
          <option value="20:00"<%=getSelect(obj.getEveningarrive().equals("20:00"))%>>20:00</option>
          <option value="20:30"<%=getSelect(obj.getEveningarrive().equals("20:30"))%>>20:30</option>
          <option value="21:00"<%=getSelect(obj.getEveningarrive().equals("21:00"))%>>21:00</option>
          <option value="21:30"<%=getSelect(obj.getEveningarrive().equals("21:30"))%>>21:30</option>
          <option value="22:00"<%=getSelect(obj.getEveningarrive().equals("22:00"))%>>22:00</option>
          <option value="22:00"<%=getSelect(obj.getEveningarrive().equals("22:30"))%>>22:30</option>
          <option value="23:00"<%=getSelect(obj.getEveningarrive().equals("23:00"))%>>23:00</option>
          <option value="23:30"<%=getSelect(obj.getEveningarrive().equals("23:30"))%>>23:30</option>
          <option value="23:59"<%=getSelect(obj.getEveningarrive().equals("23:59"))%>>23:59</option>
        </select>
        <font color="#1EA817"> <font color="#1EA817">※</font> </font> </td>
    </tr>
     <tr>

      <%
        int roomprice = obj.getRoomprice();
        RoomPrice rp = RoomPrice.find(roomprice);
if(roomprice == -1){
  out.print("<td>房间类型</td><td>无</td>");
}
  String sb = ",";
  java.util.Enumeration enumer1 = tea.entity.node.RoomPrice.findByNode(obj.getNode());
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
    tea.entity.node.RoomPrice obj2 = tea.entity.node.RoomPrice.find(id);
    sb = sb + id + ",";
%>


  <tr>
  <td><input type="radio" name="roomprice" value="<%=id%>" <%if(id==roomprice)out.print("checked");%>/></td>
    <td><%=obj2.getRoomtype(teasession._nLanguage)%>  </td>
    <td><%=obj2.getRetail()%>元    </td>
    <td><%=obj2.getProscenium()%>元    </td>
    <td><%=obj2.getNet()%>元    </td>
    <td><%=obj2.getWeekend()%>元    </td>
  </tr>

<%z++;}out.print("</table></td></tr>");}%></td>
   </td>
  </tr>
      <%-- <tr>
      <TD>总价：</TD>
    <td><%=rp.getRetail()+"元"%>
    <input type="hidden" name="roomprice" value="<%=roomprice%>" />
   <font color="#1EA817">※</font></td>
    </tr>--%>
  </table>
<h2>入住人信息</h2>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
      <td>入 住 人：</td>
      <td><input name="TxtName" type="text" value="<%=obj.getHumanname(teasession._nLanguage)%>">
      </td>
 </tr>
    <tr>
      <TD> 性 　　别：</TD>
      <td><input  id="sexb" type="radio" value="true" name="sex" checked="checked">
        男
        <input  id="sexg" type="radio"value="false"  name="sex" <%if(!obj.isSex())out.print("checked");%>>
        女 <font color="#1EA817">※</font> </td>
    </tr>
<tr>
      <TD>手机号码：</TD>
      <td>
        <input name="handset" type="text"  value="<%=obj.getHandset()%>" size="15"><font color="#1EA817">※</font>
        如果没有手机，请留下座机号码：<input name="phone" type="text" value="<%=obj.getPhone()%>" maxlength=20>&nbsp;(请加区号)
      </td>
    </tr>
    <tr>
      <TD>付款类型：</TD>
      <td><select name="paymenttype">
          <%for (int i = 0; i < RoomPrice.PAYMENT.length; i++) {%>
          <option value="<%=i%>" <%if(obj.getPaymenttype() == i)out.print("selected");%>><%=r.getString(teasession._nLanguage,RoomPrice.PAYMENT[i])%></option>
          <%}%>
        </select>
    </tr>
  </table>
  <h2>联系人信息</h2>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td colspan=2>
        <input  id="CHECKBOX" type="CHECKBOX" onclick="javascript:change(this.checked);">
        与入住人相同 </td>
    </tr>
    <tr>
      <TD> 联系人姓名：</TD>
      <td><input name="linkmanname" type="text"   value="<%=obj.getLinkmanname(teasession._nLanguage)%>" size="15">
        <font color="#1EA817">※</font> </td>
    </tr>
     <tr>
      <TD> 性 　　别：</TD>
      <td><input  id="linkmanboy" type="radio" value="true" name="linkmansex" checked="checked">
        男
        <input  id="linkmangirl" type="radio" name="linkmansex" value="false"<%if(!obj.isLinkmansex()){out.println("checked");}%>>
        女 <font color="#1EA817">※</font> </td>
    </tr>
    <tr>
      <TD> 手机号码：</TD>
      <td>
        <input name="linkmanhandset" type="text"  value="<%=obj.getLinkmanhandset()%>" size="15"><font color="#1EA817">※</font>
        如果没有手机，请留下座机号码：<input name="linkmanphone" type="text" value="<%=obj.getLinkmanphone()%>"   maxlength=20>&nbsp;(请加区号)
      </td>
    </tr>
    <tr>
      <TD>电子邮件：</TD>
      <td><input name="linkmanmail" type="text"  style="width:180px;" value="<%=obj.getLinkmanmail().trim()%>" size="25">
      </td>
    </tr>
    <tr>
      <TD>传　　真：</TD>
      <td><input name="linkmanfax" type="text"  style="width:180px;" value="<%=obj.getLinkmanfax()%>" size="15">
        <font color="#1EA817">※</font> </td>
    </tr>
    <tr>
      <TD>确认方式：</TD>
      <td><select name="linkmanaffirm" id="linkmanaffirm" >
          <option value="0" <%=getSelect(obj.getLinkmanaffirm()==0)%>>不需确认
          <option value="1" <%=getSelect(obj.getLinkmanaffirm()==1)%>>使用短信来确认
          <option value="2"<%=getSelect(obj.getLinkmanaffirm()==2)%>>使用电话来确认
          <option value="3"<%=getSelect(obj.getLinkmanaffirm()==3)%>>使用传真来确认
          <option value="4"<%=getSelect(obj.getLinkmanaffirm()==4)%>>使用e-mail来确认
        </select>
        <font color="#1EA817">※</font>
      </td>
    </tr>
    <tr>
      <td height="45" align="center" colspan="2"><font color="#DC441C"> <strong>为了与您及时确认并联系，请您确认留下的联系方式</strong> </font> </td>
    </tr>
  </table>
  <script language="javascript" type="text/javascript">
	function CompStr(Str1,Str2)
	{if (Str1==Str2) return true;
	else return false;}
  </script>
<h2>特殊要求 </h2>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td>旅客留言：</td>
      <td>
        <textarea name="otherrequest" rows="5"  style="width:500px;" cols=""><%=obj.getRequest(teasession._nLanguage)%></textarea>
        最多255个字符
      </td>
    </tr>
    <tr>
      <td>加床数量：</td>
      <td>
        <input name="otheraddbed" type="text"  style="width:70px;" size="3" maxlength="3" value="<%=obj.getOtheraddbed()%>">如您在最晚到店时间以后到店，请及时与我们联系.
      </td>
    </tr></table>
    <h2>酒店说明</h2>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">

    <tr>

 <td>说明：</td><td align="left"><%=h.getClew() %></td>
 </tr>
 <tr>
<td colspan="2">如需酒店其它优惠信息请留下E-MAIL，我们会按照您填写的邮箱地址发送至您的邮箱!</td>
 </tr>
 <tr>
 <td colspan="2">您的邮箱：<input type="text" name="othersend" value="<%=obj.getLinkmanmail().trim()%>"/></td>
 </tr>
 <tr><td colspan="2"><input name="othersend" id="CHECKBOX" type="CHECKBOX" value="no" onclick="javascript:changexy(this.checked);">
      我需要</td>
 </tr>

    <!--<tr id="mobilesend" style="DISPLAY: yes">
      <td colspan="2" >当酒店确认后，我们会按照您填写的E-MAIL地址将确认邮件发送至您的邮箱。</td>
    </tr>
    <tr id="mobilesend" style="DISPLAY: yes">
      <td colspan="2" ><input name="othersend"  id="CHECKBOX" type="CHECKBOX" value="" <%if(obj.getOtherpostalcode()!=null)out.print("checked");%> onclick="javascript:changexy(this.checked);">
        我需要（注：如果您需要寄卡，请确保您填写的会员注册信息是真实的,我们会按此邮寄。） </td>
    </tr>
    <tr id="mobilesend" style="DISPLAY: yes">
      <TD>邮政编码：</td>
      <td><input id="otherpostalcode" type="text" name="otherpostalcode"  size=6 value="<%=obj.getOtherpostalcode()%>" maxlength=6></td>
    </tr>
    <tr id="mobilesend" style="DISPLAY: yes">
      <TD>通讯地址：</td>
      <td><input id="otheraddress" type="text" name="otheraddress"  size="30" maxlength="64" value="<%=obj.getAddress(teasession._nLanguage)%>">
      </td>
    </tr>-->
  </table>
  <table width="750" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td width="719" height="50" align="center"><input type="submit" name="" value="<%=r.getString(teasession._nLanguage," 修 改 ")%>"/>&nbsp;&nbsp;&nbsp;&nbsp;

<input type=button value=" 返 回 " onClick="javascript:history.back()">
      </td>
    </tr>
  </table>
</form>
<div id="head6"><img height="6" src="about:blank" alt="" ></div>
</body>
</html>
