<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.entity.member.*"%>
<%@ page import="tea.entity.util.*"%>
<%@ page import="tea.entity.site.*"%>
<%@ page import="tea.resource.*"%>
<%@ page import="tea.entity.node.*"%>
<%@ page import="tea.entity.admin.*" %>
<%@ page import="tea.db.*"%>
<%@ page import="tea.html.*"%>
<%@ page import="tea.ui.*"%>
<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");

TeaSession teasession = new TeaSession(request);
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
  return;
}

Node node = Node.find(teasession._nNode);


//if(!node.isCreator(teasession._rv))
//{
//  response.sendError(403);
//  return;
//}//hostel.getName()

Hostel hostel =Hostel.find(teasession._nNode,teasession._nLanguage);

String map=hostel.getMap();

int logolen=0;
if(hostel.getLogo()!=null)
{
  logolen=(int)new java.io.File(application.getRealPath(hostel.getLogo())).length();
}
int picturelen=0;
if(hostel.getPicture()!=null)
{
  picturelen=(int)new java.io.File(application.getRealPath(hostel.getPicture())).length();
}


Resource r=new Resource();
r.add("/tea/resource/Hostel");

StringBuffer s1=new StringBuffer();
StringBuffer s2=new StringBuffer();
java.util.Enumeration e = Citypopedom.find(teasession._strCommunity," and member ="+DbAdapter.cite(teasession._rv.toString()),0,Integer.MAX_VALUE);
while(e.hasMoreElements())
{
  int id = ((Integer)e.nextElement()).intValue();
  Citypopedom c = Citypopedom.find(id);
  String a[] = c.getCityid().split("/");
  s1.append("var c0=new Array(new Array(0,'----------')");
  for(int i =1;i<a.length;i++)
  {
    City cy = City.find(Integer.parseInt(a[i]));
    s1.append(",new Array("+a[i]+",\""+cy.getCityname()+"\")");
    s2.append("var c"+a[i]+"=new Array(new Array(0,'----------')");
    java.util.Enumeration e2 = City.find(teasession._strCommunity," AND father="+a[i],0,Integer.MAX_VALUE);
    while(e2.hasMoreElements())
    {
      id=((Integer)e2.nextElement()).intValue();
      cy = City.find(id);
      s2.append(",new Array("+id+",\""+cy.getCityname()+"\")");
    }
    s2.append(");\r\n");
  }
  s1.append(");");
}


%>
<HTML>
<HEAD>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</HEAD>
<body onload="f_load();">
<script type="">
function f_unit(arr)
{
  form1.tupian.value=arr;
}
function f_fangxiang(arr)
{
  form1.fangxing.value=arr;
}

<%=s1.toString()%>
<%=s2.toString()%>
function f_load()
{
  var o1=form1.city.options;
  for(var i=1;i<c0.length;i++)
  {
    o1[o1.length]=new Option(c0[i][1],c0[i][0]);
  }
  form1.city.value=<%=hostel.getCity()%>;
  f_load2();
  form1.borough.value=<%=hostel.getBorough()%>;
}
function f_load2()
{
  var o1=form1.city.options;
  var o2=form1.borough.options;
  while(o2.length>0)
  {
    o2[0]=null;
  }
    var c=eval("c"+o1.value);

     if("c"+o1.value != 'c0'){
       for(var i=0;i<c.length;i++)
       {
         o2[o2.length]=new Option(c[i][1],c[i][0]);
       }
     }else
      {
         o2[0]=new Option('---------');
      }
}

      function isDigit(s)
{
var patrn=/^[0-9]{1,20}$/;
if (!patrn.exec(s))
{
  alert("无效-价格");
  return false;
}
return true;
}
//function submitArea(){
//if(document.form1.city.value==0){
//alert('请选择省(区)');
//document.form1.city.focus();
//return false;
//}
//return true;
//}
</script>
<h1><%=r.getString(teasession._nLanguage, "Hostel")%><%=r.getString(teasession._nLanguage, "Edit")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div>
<form name="form1" method="post" action="/servlet/CreateHostel" enctype="multipart/form-data" onsubmit="return submitText(form1.Name,'无效-酒店名')&&submitArea()&&submitText(form1.housexing,'无效-特价房型')&&isDigit(form1.price.value);">
<INPUT type="hidden" NAME="FORE" value="1">
<input type='hidden' name="node" VALUE="<%=teasession._nNode%>">
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td><%=r.getString(teasession._nLanguage, "Name")%>: </td>
    <td colspan="2">
        <input name="Name" type="text" value="<%=HtmlElement.htmlToText(hostel.getName())%>" size="80">
    </td>
  </tr>
    <%-- <tr>
    <td><%=r.getString(teasession._nLanguage, "StarClass")%>: </td>
      <td><select name="StarClass">
        <option value="0" >-----无-----</option>
        <%
        for(int i=5;i>0;i--)
        {
          out.print("<option value="+i);
          if(i==hostel.getStarClass())
          out.print(" SELECTED ");
          out.print(">");
          for(int j=i;j>0;j--)
          out.print("☆");
        }
        %>
        </select></td>
  </tr>--%>
     <tr>
    <td><%=r.getString(teasession._nLanguage, "StarClass")%>:</td>
      <td width="20%">
      <%-- <select name="StarClass">
        <option value="0">------------</option>
        <option value="5">☆☆☆☆☆</option>
        <option value="4">☆☆☆☆</option>
        <option value="3">☆☆☆</option>
        <option value="2">☆☆</option>
        <option value="1">☆</option>
      </select>--%>
            <input type="radio" name="StarClass" value="0" <%if(hostel.getStarClass()==0)out.print(" checked");%>>未评星&nbsp;&nbsp;<br />

      <input type="radio" name="StarClass" value="7" <%if(hostel.getStarClass()==7)out.print(" checked");%>/><img alt="" src="/tea/image/star/level7.gif" />&nbsp;&nbsp;<br />
      <input type="radio" name="StarClass" value="8" <%if(hostel.getStarClass()==8)out.print(" checked");%>/><img alt="" src="/tea/image/star/level8.gif" />&nbsp;&nbsp;<br />
      <input type="radio" name="StarClass" value="9" <%if(hostel.getStarClass()==9)out.print(" checked");%>/><img alt="" src="/tea/image/star/level9.gif" />&nbsp;&nbsp;<br />
      <input type="radio" name="StarClass" value="10" <%if(hostel.getStarClass()==10)out.print(" checked");%>/><img alt="" src="/tea/image/star/level10.gif" />&nbsp;&nbsp;</td>
      <td>

      <input type="radio" name="StarClass" value="1" <%if(hostel.getStarClass()==1)out.print(" checked");%>/><img alt="" src="/tea/image/star/level1.gif" />&nbsp;&nbsp; <br />
      <input type="radio" name="StarClass" value="2"<%if(hostel.getStarClass()==2)out.print(" checked");%>/><img alt="" src="/tea/image/star/level2.gif" />&nbsp;&nbsp;<br />
      <input type="radio" name="StarClass" value="3"<%if(hostel.getStarClass()==3)out.print(" checked");%>/><img alt="" src="/tea/image/star/level3.gif" />&nbsp;&nbsp;<br />
      <input type="radio" name="StarClass" value="4"<%if(hostel.getStarClass()==4)out.print(" checked");%>/><img alt="" src="/tea/image/star/level4.gif" />&nbsp;&nbsp;<br />
      <input type="radio" name="StarClass" value="5"<%if(hostel.getStarClass()==5)out.print(" checked");%>/><img alt="" src="/tea/image/star/level5.gif" />&nbsp;&nbsp;
    </td>
  </tr>
   <tr>
    <td><%=r.getString(teasession._nLanguage, "Telephone")%>:</td>
    <td colspan="2"><input type="text" name="Phone"  value="<%=hostel.getPhone()%>"></td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "Fax")%>: </td>
    <td colspan="2"><input type="text" name="Fax"  value="<%=hostel.getFax()%>"></td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "Contact")%>:</td>
    <td colspan="2"><input type="text" name="Contact"  value="<%=hostel.getContact()%>"></td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "Address")%>:</td>
    <td colspan="2"><input name="Address" type="text" value="<%=hostel.getAddress()%>" size="80"></td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "Zip")%>: </td>
    <td colspan="2"><input type="text" name="Postalcode"  value="<%=hostel.getPostalcode()%>"></td>
  </tr>
  <!--新添加的-->
<%--
  <tr>
    <td><%=r.getString(teasession._nLanguage, "City")%>:</td>
     <td><input type="text" name="city"  value="<%=hostel.getCity()%>">&nbsp;&nbsp;&nbsp;市/区: <input type="text" name="borough"  value="<%=hostel.getBorough()%>"></td>
  </tr>
   --%>
   <tr>
    <td><%=r.getString(teasession._nLanguage, "City")%>:</td>
     <td colspan="2"> <select name="city" onchange="f_load2()">
       <option value="0">----------</option>
        </select>&nbsp;&nbsp;&nbsp;市/区:  <select name="borough">
       <option value="0">-----------</option>
        </select></td>
  </tr>

  <tr>
    <td>地理位置:</td>
     <td colspan="2">距火车站：<input type="text" name="placeh"  value="<%=hostel.getPlaceh()%>" size="5">公里&nbsp;&nbsp;&nbsp;
      距飞机场: <input type="text" name="placef"  value="<%=hostel.getPlacef()%>" size="5">公里&nbsp;&nbsp;&nbsp;
     距市中心: <input type="text" name="places"  value="<%=hostel.getPlaces()%>" size="5" >公里&nbsp;&nbsp;&nbsp;
     距地铁: <input type="text" name="placed"  value="<%=hostel.getPlaced()%>" size="5">公里&nbsp;&nbsp;&nbsp;
     </td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "Picture")%>:</td>
    <td colspan="2"><input type="file" name="Picture" >
    <%
    if(picturelen>0)
    {
    	out.print("<a href="+hostel.getContact()+" target=_blank>"+picturelen + r.getString(teasession._nLanguage, "Bytes")+"</a>");
    	out.print("<input type=CHECKBOX name=ClearPicture onclick=\"form1.Picture.disabled=this.checked;\">"+r.getString(teasession._nLanguage, "Clear"));
    }
    %></td>
  </tr>
    <tr>
    <td>Logo:</td>
    <td colspan="2"><input type="file" name="logo">
    <%
    if(logolen>0)
    {
    	out.print("<a href="+hostel.getLogo()+" target=_blank>"+logolen + r.getString(teasession._nLanguage, "Bytes")+"</a>");
    	out.print("<input type=CHECKBOX name=ClearLogo onclick=\"form1.logo.disabled=this.checked;\">"+r.getString(teasession._nLanguage, "Clear"));
    }
     %></td>
  </tr>

   <tr>
    <td>今日特价：</td>
    <td colspan="2">房型:<input type="text" name="housexing"  value="<%=hostel.getHousexing()%>">
      价格：<input type="text" name="price"  value="<%=hostel.getPrice()%>">
      有效期：
     <input name="timeyouxiao" size="10"  value="<%=hostel.getTimeyouxiaoToString()%>" readonly="readonly"><A href="###"><img onclick="showCalendar('form1.timeyouxiao');" src="/tea/image/public/Calendar2.gif" align="top"/></a>
     --
      <input name="timeyouxiao2" size="10"  value="<%=hostel.getTimeyouxiaoToString()%>" readonly="readonly"><A href="###"><img onclick="showCalendar('form1.timeyouxiao2');" src="/tea/image/public/Calendar2.gif" align="top"/></a>
    </td>
  </tr>

  <tr>
    <td><%=r.getString(teasession._nLanguage, "今日特价说明")%>: </td>
    <td colspan="2"><textarea name="specialintro" cols="80" rows="4"><%=HtmlElement.htmlToText(hostel.getSpecialintro())%></textarea></td>
  </tr>
   <tr>
    <td><%=r.getString(teasession._nLanguage, "特殊提示")%>: </td>
    <td colspan="2"><textarea name="clew" cols="80" rows="4"><%=HtmlElement.htmlToText(hostel.getClew())%></textarea></td>
  </tr>

  <tr>
    <td><%=r.getString(teasession._nLanguage, "酒店简介")%>: </td>
    <td colspan="2"><textarea name="Intro" cols="80" rows="6"><%=HtmlElement.htmlToText(hostel.getIntro())%></textarea></td>
  </tr>
     <tr>
    <td>酒店设施:</td>
     <td colspan="2">
      餐　　厅：<input type="text" name="diningroom"  value="<%=hostel.getDiningroom()%>" size="100"><br/>
      商务中心：<input type="text" name="commerce" size="100" value="<%=hostel.getCommerce()%>"><br/>
     娱乐中心：<input type="text" name="amusement" size="100" value="<%=hostel.getAmusement()%>" ><br/>
     商　　场：<input type="text" name="emporium" size="100" value="<%=hostel.getEmporium()%>" ><br/>
      其　　他：<input type="text" name="elses" size="100" value="<%=hostel.getElses()%>" ><br/>
     </td>
  </tr>


<%--
  <tr>
    <td><%=r.getString(teasession._nLanguage, "Picture")%>1: </td>
    <td><input type=FILE name=Picture><%if(hostel.getPictureLen() > 0) out.print(hostel.getPictureLen() + r.getString(teasession._nLanguage, "Bytes"));%>
      <input id=ClearPicture  id=CHECKBOX type="CHECKBOX" name=ClearPicture ><%=r.getString(teasession._nLanguage, "Clear")%>
      </td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "PictureName")%>1: </td>
    <td><input type="text" name="PictureName" value="<%=hostel.getPictureName()%>"></td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "Picture")%>2: </td>
    <td><input type=FILE name=Picture2><%if(hostel.getPictureLen2() > 0) out.print(hostel.getPictureLen2() + r.getString(teasession._nLanguage, "Bytes"));%>
      <input id=ClearPicture  id=CHECKBOX type="CHECKBOX" name=ClearPicture2 ><%=r.getString(teasession._nLanguage, "Clear")%>
      </td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "PictureName")%>2: </td>
    <td><input type="text" name="PictureName2" value="<%=hostel.getPictureName2()%>"></td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "Picture")%>3: </td>
    <td><input type=FILE name=Picture3><%if(hostel.getPictureLen3() > 0) out.print(hostel.getPictureLen3() + r.getString(teasession._nLanguage, "Bytes"));%>
      <input id=ClearPicture  id=CHECKBOX type="CHECKBOX" name=ClearPicture3 ><%=r.getString(teasession._nLanguage, "Clear")%>
      </td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "PictureName")%>3: </td>
    <td><input type="text" name="PictureName3" value="<%=hostel.getPictureName3()%>"></td>
  </tr>
--%>


<tr>
      <td><%=r.getString(teasession._nLanguage, "酒店图片")%>:</td>
      <td colspan="2"><input type="button"  class="edit_button" onclick="window.showModalDialog('/jsp/type/TypePicture.jsp?node=<%=teasession._nNode%>','new','dialogHeight=500px;dialogWidth=700px;scrollbars=1');" value="<%=r.getString(teasession._nLanguage, "添加酒店图片")%>"/>
<input type="hidden" name="tupian" value="" />
</td>
    </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage, "其他房型")%>: </td>
    <td colspan="2"><input type=button class="edit_button" onClick="window.showModalDialog('/jsp/type/hostel/EditRoomPrice.jsp?node=<%=teasession._nNode%>','new','dialogHeight=650px;dialogWidth=900px;scrollbars=1')" value="<%=r.getString(teasession._nLanguage, "添加其他房型")%>">
    <input type="hidden" name="fangxing" value="" />
    </td>
  </tr>

 <tr>
    <td>付款方式: </td>
    <td colspan="2">
    <%
    for(int i =0;i<Hostel.PAY_MENT.length;i++)
    {
      out.print("<input  type=CHECKBOX name=payment_"+i+" value=" + i);
        if (hostel.getPayment() == i)
          out.print(" checked=checked");
       if(i == 4){
          out.print("><label>" + Hostel.PAY_MENT[i] + "</label>");
        }else{
          out.print("><label>" + Hostel.PAY_MENT[i] + "　　</label>");
        }
      out.print("<input type=text name=paymenttext_"+i+"  size=100 value=");
      switch(i)
      {
        case 0:
            if(hostel.getPayment()==0)
                //out.print(hostel.getPaymenttext());
                 if(hostel.getPaymenttext()!=null && hostel.getPaymenttext().length()>0)out.print("本酒店订房客人只能到前台自付房款");
             else
                out.print("本酒店订房客人只能到前台自付房款");
             break;
        case 1:
        if(hostel.getPayment()==1)
            out.print(hostel.getPaymenttext());
        else
            out.print("前台自付但需要信用卡担保:本酒店订房客人需到前台自付,订房时需提供信用卡号担保.");
        break;
        case 2:
         if(hostel.getPayment()==2)
             out.print(hostel.getPaymenttext());
          else
            out.print("本酒店订房,客人需把住房款预付到酒店指定账户");
            break;
        case 3:
         if(hostel.getPayment()==3)
             out.print(hostel.getPaymenttext());
         else
            out.print("本酒店委托网站代收住房款");
          break;
      }
      out.print("> <br/>");
    }
    %>
     <!-- <input type="radio" name="payment"  value="1">
      <label>前台自付</label>
      <input type="text" name="sincepay2"  size=100
        value="本酒店订房客人只能到前台自付房款"/>
      <br/>
     <input type="radio" name="payment"  value="2">
     <label></label>
     <label>担　　保</label>
      <input type="text" name="assure2"  size=100
        value="前台自付但需要信用卡担保:本酒店订房客人需到前台自付,订房时需提供信用卡号担保."/>
     <br/>
     <input type="radio" name="payment"  value="3">
     <label>预　　付</label>
      <input type="text" name="advance2"  size=100
        value="本酒店订房,客人需把住房款预付到酒店指定账户"/>
       <br/>
      <input type="radio" name="payment"  value="4">
      <label>代　　收</label>
      <input type="text" name="eraaccept2"  size=100
        value="本酒店委托网站代收住房款"/>
       <br/>
      <input type="radio" name="payment"  value="5">
      <label>会员积分担保</label>
      <input type="text" name="integralassure2"  size=100
        value=""/>
-->
      <br/>
</td>  </tr>
</table>
<INPUT TYPE=SUBMIT NAME="GoBack"  class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "GoBack")%>">
<INPUT TYPE=SUBMIT name="GoFinish" ID="edit_GoFinish" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "Submit")%>">
  </form>
   <div id="head6"><img height="6" src="about:blank"></div>
 <div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>

</body>
</HTML>
