<%@page contentType="text/html;charset=UTF-8"  %><%@page import="tea.entity.*" %>
<%@include file="/jsp/include/Header.jsp"%>
<%

Http h=new Http(request);

if(teasession._rv==null)
{
  if((node.getOptions1()& 1) == 0)
  {
    response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
    return;
  }
}else if(!"admin".equals(h.key))
{
  if (!node.isCreator(teasession._rv)&&!AccessMember.find(node._nNode, teasession._rv._strV).isProvider(62))
  {
    response.sendError(403);
    return;
  }
}


r.add("/tea/resource/Golf");


int l2=0;
int l1=0;
Date date_n=null;
//int i=0;
Golf court=null;//Golf.find(teasession._nNode);

String subject="";
String logo=null;
long logoLen=0;
if(node.getType()!=1)
{
  subject=tea.html.HtmlElement.htmlToText(node.getSubject(teasession._nLanguage));

  court=Golf.find(teasession._nNode,teasession._nLanguage);
  logo=court.getLogo();
  if(logo!=null)
  {
    logoLen=new java.io.File(application.getRealPath(logo)).length();
  }
}else
{
  court=Golf.find(0,1);
}
//String[] posid=court.posid.split("-");
String posid = court.posid;

boolean isRole=request.getParameter("role")!=null;

%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script>
function setInt(obj)
{
  if(isNaN(parseInt(obj.value)))
  {
    obj.value='0';
  }else
  obj.value=parseInt(obj.value);
}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "球场管理")%></h1>
  <div id="head6"><img height="6" src="about:blank"></div>

<div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div>
<form name="form1" method="post" action="/servlet/EditGolf?"  ENCtype="multipart/form-data" onSubmit="return mt.check(this);">
<input type=hidden name="community" value="<%=teasession._strCommunity%>">
<input type=hidden name="repository" value="golf">
<input type=hidden name="node" value="<%=teasession._nNode%>">
<input type=hidden name="key" value="<%=MT.enc(h.key)%>">
<%
String parameter=teasession.getParameter("nexturl");
boolean parambool=(parameter!=null&&!parameter.equals("null"));
if(parambool)
out.print("<input type='hidden' name=nexturl value=\""+parameter+"\">");
%>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
      <%--
    if(code>0)
    {%>
      <tr>
        <td><%=r.getString(teasession._nLanguage, "CourtCode")%>:</td>
        <td><%=code%></td>
      </tr>
      <%}--%>
      <%
      if(isRole)
      {
        out.print("<input type=hidden name=posid value=\""+posid+"\"/>");//<input type=hidden name=seq value=\""+posid[1]+"\"/>
        out.print("<tr><td>设备编号：</td><td><input disabled='' value=\""+posid+"\"/>&nbsp;注：如需修改设备编号，请联系机构管理员。");
        //&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;球场序号：<select disabled=''><option>"+posid[1]+"</select><br>注：如需修改设备编号及球场序号，请联系机构管理员。
      }else
      {
      %>
      <tr>
        <td>设备编号：</td>
        <td><input type="text"  size=50 class="edit_input" name="posid" value="<%=posid%>" alt="设备编号" />
       <!--  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;球场序号： -->
        <%
      /*  out.print("<select name='seq'>");
        for(char i='A';i<='Z';i++)
        {
          out.print("<option value="+i);
          if(posid[1].equals(String.valueOf(i)))out.print(" selected='true'");
		out.print("</select>");
*/
          out.print("</td></tr>");
        }
      %>
      <tr>
        <td><%=r.getString(teasession._nLanguage, "Name")%>：</td>
        <td><input type="text" size=70  maxlength="100"  class="edit_input" name="name" value="<%=subject%>" alt="球场名称"></td>
      </tr>
      <tr>
        <td>标志图：</td>
        <td>
        <%
        out.print("<input type=FILE class=edit_input size=40  name=logo ");
        if(logoLen<1)out.print(" alt='标志图'");
        out.print(" />");
        if(logoLen>0)
        {
          out.print("<a href='"+logo+"' target='_blank'>"+logoLen+ r.getString(teasession._nLanguage, "Bytes")+"</a>");
          out.print("<input type=checkbox name=ClearLogo onclick='form1.logo.disabled=this.checked'>"+r.getString(teasession._nLanguage, "Clear"));
        }
        %></td>
      </tr>
      <tr>
        <td><%=r.getString(teasession._nLanguage, "Type")%>：</td>
        <td>
          <select name="type" alt="球场类型">
          <option value="">------------</option>
          <%=Table.options(Table.GTYPE,teasession._strCommunity,court.getType())%>
          </select>
          <%-- <input type="text"  size=70 class="edit_input" name="type"  value="<%=court.getType()%>"> --%>
        </td>
      </tr>
      <tr>
        <td><%=r.getString(teasession._nLanguage, "Area")%>：</td>
        <td>
          <select name="area" alt="球场区域">
          <option value="">------------</option>
          <%=Table.options(Table.CITY,teasession._strCommunity,court.getArea())%>
          </select>
          <%--          <input type="text"  size=70 class="edit_input" name="area" value="<%=court.getArea()%>" >          --%>
        　<%=r.getString(teasession._nLanguage, "BusinessHours")%>：
        <input class="edit_input" size=10  name="starthour" value="<%=court.getStartBusinessHours()%>">
        　<%=r.getString(teasession._nLanguage, "Capability")%>：
<input type="text"  size=10 class="edit_input" name="capability" value="<%=court.getCapability()%>"></td>
      </tr>
      <%--
      <tr>
        <td><%=r.getString(teasession._nLanguage, "MusicType")%>: </td>
        <td><input type="text"  size=70 class="edit_input" name="musicType" value="<%=court.getMusicType()%>">
        </td>
      </tr>
      <tr>
        <td><%=r.getString(teasession._nLanguage, "DeilStyle")%>:</td>
        <td><input type="text"  size=70 class="edit_input" name="deilStyle" value="<%=court.getDeilStyle()%>">
        </td>
      </tr>

      <tr>
        <td><%=r.getString(teasession._nLanguage, "Circumstance")%>:</td>
        <td><input type="text"  size=70 class="edit_input" name="circumstance" value="<%=court.getCircumstance()%>">
        </td>
      </tr>

            <tr>
        <td><%=r.getString(teasession._nLanguage, "Options")%>: </td>
        <td><input  id="CHECKBOX" type="CHECKBOX" name="depot" <%=getCheck((court.getOptions()&1)!=0)%>  >
          <%=r.getString(teasession._nLanguage, "Depot")%>
          <!-- <input  id="CHECKBOX" type="CHECKBOX" name="ticket" <%=getCheck((court.getOptions()&2)!=0)%> ><%=r.getString(teasession._nLanguage, "Ticket")%>--!>
          <input  id="CHECKBOX" type="CHECKBOX" name="open" <%=getCheck((court.getOptions()&4)!=0)%>  >
          <%=r.getString(teasession._nLanguage, "DayOpenBusiness")%>
          <input  id="CHECKBOX" type="CHECKBOX" name="electron" <%=getCheck((court.getOptions()&8)!=0)%>  >
          <%=r.getString(teasession._nLanguage, "ElectroTicket")%> </td>
      </tr>

            <tr>
        <td><%=r.getString(teasession._nLanguage, "Payment")%>:</td>
        <td><input type="text"  size=70 class="edit_input" name="payment" value="<%=court.getPayment()%>">
        </td>
      </tr>

      --%>




      <%--
          <tr>
        <td><%=r.getString(teasession._nLanguage, "Trait")%>:</td>
        <td><input type="text"  size=70 class="edit_input" name="trait" value="<%=court.getTrait()%>">
        </td>
      </tr>
      <tr>
        <td><%=r.getString(teasession._nLanguage, "Depreciate")%>:</td>
        <td><input type="text"  size=70 class="edit_input" name="depreciate" value="<%=court.getDepreciate()%>">
        </td>
      </tr>
      <tr>
        <td><%=r.getString(teasession._nLanguage, "PracticeHours")%>:</td>
        <td><%=new TimeSelection("Start", date_n)%> </td>
      </tr>
      --%>
      <tr>
        <td><%=r.getString(teasession._nLanguage, "Address")%>：</td>
        <td><input type="text"  size=50 class="edit_input" name="address" value="<%=court.getAddress()%>">
          <%=r.getString(teasession._nLanguage, "Postalcode")%>：
        <input name="postalcode" type="text"   class="edit_input" value="<%=court.getPostalcode()%>" size="10"></td>
      </tr>

      <tr>
        <td><%=r.getString(teasession._nLanguage, "Map")%>：</td>
        <td><input type=text   size=50 class="edit_input" value="<%=getNull(court.getMap())%>"  name="map" readonly="readonly">
          <input type="button" value="标点" onClick="window.open('/jsp/admin/map/EditGMap.jsp?field=form1.map','_blank','width=600,height=500');"/>
        </td>
      </tr>
      <%--
        <td><%=r.getString(teasession._nLanguage, "Principal")%>:</td>
        <td><input type="text"   class="edit_input" name="principal" value="<%=court.getPrincipal()%>">

              <tr>
        <td><%=r.getString(teasession._nLanguage, "Cooperate")%>: </td>
        <td><input type="text"  size=70 class="edit_input" name="cooperate" value="<%=court.getCooperate()%>">
        </td>
      </tr>
      <tr>
        <td><%=r.getString(teasession._nLanguage, "Sponsor")%>:</td>
        <td><input type="text"  size=70 class="edit_input" name="sponsor" value="<%=court.getSponsor()%>">
        </td>
      </tr>
            <tr>
        <td><%=r.getString(teasession._nLanguage, "Consume")%>:</td>
        <td><input type="text" class="edit_input" name="consume" value="<%=court.getConsume()%>">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <%=r.getString(teasession._nLanguage, "AverageConsume")%>:
          <input type="text" class="edit_input" name="averageConsume" value="<%=court.getAverageConsume()%>">
        </td>
      </tr>
      --%>

      <tr>
        <td><%=r.getString(teasession._nLanguage, "Phone")%>：</td>
        <td><input name="phone" type="text"   class="edit_input" value="<%=court.getPhone()%>" size="20">
          　
          &nbsp;<%=r.getString(teasession._nLanguage, "Fax")%>：
          <input name="fax" type="text"   class="edit_input" value="<%=court.getFax()%>" size="20">
        　</td>
      </tr>
      <tr>
        <td>网址：</td>
        <td><input type="text"  size=25 class="edit_input" name="url" value="<%=court.url%>">
          　
        Email：
            <input type="text"   size=25  class="edit_input" name="email" value="<%=court.getEmail()%>"></td>
      </tr>
      <tr>
        <td><%=r.getString(teasession._nLanguage, "Price")%>：</td>
        <td><input type="text"  size=10 class="edit_input" name="price" value="<%=court.getPrice()%>">
        　
        <%=r.getString(teasession._nLanguage, "Destine")%>：
        <input type="text"  size=4 class="edit_input" name="destine" value="<%=court.getDestine()%>">　<%=r.getString(teasession._nLanguage, "Member")%>：
        <input name="member" type="text" class="edit_input" value="<%=court.getMember()%>" size="4">　<%=r.getString(teasession._nLanguage, "Ticket")%>：
        <input type="text"  size=4 class="edit_input" name="ticket" value="<%=getNull(court.getTicket())%>"></td>
      </tr>

      <%--
      <tr>
        <td><%=r.getString(teasession._nLanguage, "Among")%>:</td>
        <td><input type="text"  size=70 class="edit_input" name="among" value="<%=court.getAmong()%>">
        </td>
      </tr>
      <tr>
        <td><%=r.getString(teasession._nLanguage, "Operation")%>:</td>
        <td><input type="text"  size=70 class="edit_input" name="operation" value="<%=court.getOperation()%>">
        </td>
      </tr>
      <tr>
        <td><%=r.getString(teasession._nLanguage, "Loo")%>:</td>
        <td><input type="text"  size=70 class="edit_input" name="loo" value="<%=court.getLoo()%>">
        </td>
      </tr>
      <tr>
        <td><%=r.getString(teasession._nLanguage, "Block")%>:</td>
        <td><input type="text"  size=70 class="edit_input" name="block" value="<%=court.getBlock()%>">
        </td>
      </tr>
              <td><%=r.getString(teasession._nLanguage, "CoverCharge")%>:</td>
        <td><input type="text" class="edit_input" name="coverCharge" value="<%=court.getCoverCharge()%>">
      --%>
      <%--
      <tr>
        <td><%=r.getString(teasession._nLanguage, "Stylist")%>:</td>
        <td><input type="text"  size=70 class="edit_input" name="stylist" value="<%=getNull(court.getStylist())%>">
        </td>
      </tr>
      --%>
      <tr>
        <td><%=r.getString(teasession._nLanguage, "Cavity")%>：</td>
        <td><input name="cavity" type="text" class="edit_input" value="<%=getNull(court.getCavity())%>" size="10">
          　 <%=r.getString(teasession._nLanguage, "Haulm")%>：
          <input name="haulm" type="text" class="edit_input" value="<%=getNull(court.getHaulm())%>" size="4">　<%=r.getString(teasession._nLanguage, "Acreage")%>： <input type="text"  size=4 class="edit_input" name="acreage" value="<%=court.getAcreage()%>">　<%=r.getString(teasession._nLanguage, "PLength")%>：
        <input name="plength" type="text" class="edit_input" value="<%=getNull(court.getPLength())%>" size="4"></td>
      </tr>
      <tr>
        <td><%=r.getString(teasession._nLanguage, "PGrass")%>：</td>
        <td><input type="text"  size=２０ class="edit_input" name="pgrass" value="<%=getNull(court.getPGrass())%>">　<%=r.getString(teasession._nLanguage, "CGrass")%>： <input type="text"  size=20 class="edit_input" name="cgrass" value="<%=getNull(court.getCGrass())%>"></td>
      </tr>
      <tr>
        <td><%=r.getString(teasession._nLanguage, "Synopsis")%>：</td>
        <td><textarea name="synopsis" cols="60" rows="5"  class="edit_input"><%=court.getSynopsis()%></textarea>
        </td>
      </tr>
       <tr>
        <td><%=r.getString(teasession._nLanguage, "Intro")%>：</td>
        <td><textarea name="intro" cols="60" rows="10"  class="edit_input"><%=tea.html.HtmlElement.htmlToText(node.getText(teasession._nLanguage))%></textarea>
        </td>
      </tr>
      <%--
      <tr>
        <td><%=r.getString(teasession._nLanguage, "Difficulty")%>:</td>
        <td><input type="text"  class="edit_input" name="difficulty" value="<%=getNull(court.getDifficulty())%>">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <%=r.getString(teasession._nLanguage, "Gradient")%>:
          <input type="text"  class="edit_input" name="gradient" value="<%=getNull(court.getGradient())%>">
        </td>
      </tr>
      --%>
    </table>
    <!--
    <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <%
    out.print("<tr><td>洞号：</td>");
    for(int i=0;i<9;i++)out.print("<td>"+(i+1)+"H / "+(i+10)+"H");
    for(int x=0;x<18;x+=9)
    {
    %>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Standard")%>：</td>
<%
      for(int index=x;index<9+x;index++)
      out.print("<td><input type=text  class=edit_input name='standard"+index+"' value='"+court.getStandard()[index]+"' onclick='select()' size=1 mask='int'   >");
      %>
       <tr>
      <td>码数：</td>
      <%
      for(int index=x;index<9+x;index++)
      out.print("<td><input type=text  class=edit_input name='yardage"+index+"' value='"+court.yardage[index]+"' onclick='select()' size=1 mask='int'   >");
      %>
      <tr>
        <td>球洞图：</td>
        <%
        for(int index=x;index<9+x;index++)
        {
          String hole=court.getHole()[index];
          //out.println("<td><input type=file ondblclick=window.open('"+hole+"'); class=edit_input name='hole"+index+"' >");
          out.print("<td><input type='button' style='position:absolute' value='上传' style=margin-bottom:4px /><input type='file' name='hole"+index+"' style='position:absolute;width:8px;cursor:hand;filter:Alpha(opacity=0)' onChange=\"this.previousSibling.value='已 浏 览';\" style=margin-bottom:4px/>　　　　　　　");
          if(hole!=null&&hole.length()>0)
          {
            out.println("<br><input  id=CHECKBOX type=CHECKBOX name=clearhole"+index+" onclick='form1.hole"+index+".disabled=checked'>"+r.getString(teasession._nLanguage, "Clear"));
          }
        }  %>
      </tr>

<%     }%>
    </table>
     -->
    <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
      <tr>
        <td></td>
        <td><%=r.getString(teasession._nLanguage, "Member")%></td>
        <td><%=r.getString(teasession._nLanguage, "MemberGuest")%></td>
        <td><%=r.getString(teasession._nLanguage, "GroupGuest")%></td>
        <td><%=r.getString(teasession._nLanguage, "Visiter")%></td>
      </tr>
      <tr>
        <td><%=r.getString(teasession._nLanguage, "GreenFee(9holes)")%><%=r.getString(teasession._nLanguage, "Weekday")%></td>
        <td><input name="megreen9w" type="text" class="edit_input" size="10"  VALUE="<%=getNull(court.getMeGreen9W()                  )%>"
        >
        </td>
        <td><input name="mggreen9w" type="text" class="edit_input" size="10" VALUE="<%=getNull(court.getMgGreen9W()                  )%>" >
        </td>
        <td><input name="gggreen9w" type="text" class="edit_input" size="10" VALUE="<%=getNull(court.getGgGreen9W()                  )%>" >
        </td>
        <td><input name="vigreen9w" type="text" class="edit_input" size="10" VALUE="<%=getNull(court.getViGreen9W()                  )%>" >
        </td>
      </tr>
      <tr>
        <td><%=r.getString(teasession._nLanguage , "Holiday")%></td>
        <td><input type="text" class="edit_input" size="10" VALUE="<%=getNull(court.getMeGreen9H()                  )%>" name="megreen9h">
        </td>
        <td><input name="mggreen9h" type="text" class="edit_input" size="10" VALUE="<%=getNull(court.getMgGreen9H()                  )%>" >
        </td>
        <td><input name="gggreen9h" type="text" class="edit_input" size="10" VALUE="<%=getNull(court.getGgGreen9H()                  )%>" >
        </td>
        <td><input name="vigreen9h" type="text" class="edit_input" size="10" VALUE="<%=getNull(court.getViGreen9H()                  )%>" >
        </td>
      </tr>
      <tr>
        <td><%=r.getString(teasession._nLanguage, "GreenFee(18holes)")%><%=r.getString(teasession._nLanguage, "Weekday")%></td>
        <td><input type="text" class="edit_input" size="10" VALUE="<%=getNull(court.getMeGreen18W()                 )%>" name="megreen18w">
        </td>
        <td><input type="text" class="edit_input" size="10" VALUE="<%=getNull(court.getMgGreen18W()                 )%>" name="mggreen18w">
        </td>
        <td><input type="text" class="edit_input" size="10" VALUE="<%=getNull(court.getGgGreen18W()                 )%>" name="gggreen18w">
        </td>
        <td><input type="text" class="edit_input" size="10" VALUE="<%=getNull(court.getViGreen18W()                 )%>" name="vigreen18w">
        </td>
      </tr>
      <tr>
        <td><%=r.getString(teasession._nLanguage,  "Holiday")%></td>
        <td><input type="text" class="edit_input" size="10" VALUE="<%=getNull(court.getMeGreen18H()                 )%>"  name="megreen18h">
        </td>
        <td><input type="text" class="edit_input" size="10" VALUE="<%=getNull(court.getMgGreen18H()                 )%>"  name="mggreen18h">
        </td>
        <td><input type="text" class="edit_input" size="10" VALUE="<%=getNull(court.getGgGreen18H()                 )%>"  name="gggreen18h">
        </td>
        <td><input type="text" class="edit_input" size="10" VALUE="<%=getNull(court.getViGreen18H()                 )%>"  name="vigreen18h">
        </td>
      </tr>
      <tr>
        <td><%=r.getString(teasession._nLanguage,  "CellationChargeFee")%></td>
        <td><input type="text" class="edit_input" size="10" VALUE="<%=getNull(court.getMeExeunt()                   )%>"  name="meexeunt">
        </td>
        <td><input type="text" class="edit_input" size="10" VALUE="<%=getNull(court.getMgExeunt()                   )%>"  name="mgexeunt">
        </td>
        <td><input type="text" class="edit_input" size="10" VALUE="<%=getNull(court.getGgExeunt()                   )%>"  name="ggexeunt">
        </td>
        <td><input type="text" class="edit_input" size="10" VALUE="<%=getNull(court.getViExeunt()                   )%>"  name="viexeunt">
        </td>
      </tr>
      <tr>
        <td><%=r.getString(teasession._nLanguage , "CaddieFee(9holes)")%></td>
        <td><input type="text" class="edit_input" size="10" VALUE="<%=getNull(court.getMeCaddie9()                  )%>"  name="mecaddie9">
        </td>
        <td><input type="text" class="edit_input" size="10" VALUE="<%=getNull(court.getMgCaddie9()                  )%>"  name="mgcaddie9">
        </td>
        <td><input type="text" class="edit_input" size="10" VALUE="<%=getNull(court.getGgCaddie9()                  )%>"  name="ggcaddie9">
        </td>
        <td><input type="text" class="edit_input" size="10" VALUE="<%=getNull(court.getViCaddie9()                  )%>"  name="vicaddie9">
        </td>
      </tr>
      <tr>
        <td><%=r.getString(teasession._nLanguage,  "Bogey")%></td>
        <td><input type="text" class="edit_input" size="10" VALUE="<%=getNull(court.getMeCaddie9B()                 )%>"  name="mecaddie9b">
        </td>
        <td><input type="text" class="edit_input" size="10" VALUE="<%=getNull(court.getMgCaddie9B()                 )%>"  name="mgcaddie9b">
        </td>
        <td><input type="text" class="edit_input" size="10" VALUE="<%=getNull(court.getGgCaddie9B()                 )%>"  name="ggcaddie9b">
        </td>
        <td><input type="text" class="edit_input" size="10" VALUE="<%=getNull(court.getViCaddie9B()                 )%>"  name="vicaddie9b">
        </td>
      </tr>
      <tr>
        <td><%=r.getString(teasession._nLanguage,  "CaddieFee(18holes)")%></td>
        <td><input type="text" class="edit_input" size="10" VALUE="<%=getNull(court.getMeCaddie18()                 )%>"  name="mecaddie18">
        </td>
        <td><input type="text" class="edit_input" size="10" VALUE="<%=getNull(court.getMgCaddie18()                 )%>"  name="mgcaddie18">
        </td>
        <td><input type="text" class="edit_input" size="10" VALUE="<%=getNull(court.getGgCaddie18()                 )%>"  name="ggcaddie18">
        </td>
        <td><input type="text" class="edit_input" size="10" VALUE="<%=getNull(court.getViCaddie18()                 )%>"  name="vicaddie18">
        </td>
      </tr>
      <tr>
        <td><%=r.getString(teasession._nLanguage,  "Bogey")%></td>
        <td><input type="text" class="edit_input" size="10" VALUE="<%=getNull(court.getMeCaddie18B()                )%>"  name="mecaddie18b">
        </td>
        <td><input type="text" class="edit_input" size="10" VALUE="<%=getNull(court.getMgCaddie18B()                )%>"  name="mgcaddie18b">
        </td>
        <td><input type="text" class="edit_input" size="10" VALUE="<%=getNull(court.getGgCaddie18B()                )%>"  name="ggcaddie18b">
        </td>
        <td><input type="text" class="edit_input" size="10" VALUE="<%=getNull(court.getViCaddie18B()                )%>"  name="vicaddie18b">
        </td>
      </tr>
      <tr>
        <td><%=r.getString(teasession._nLanguage,  "ReservedCaddieFee")%></td>
        <td><input type="text" class="edit_input" size="10" VALUE="<%=getNull(court.getMeReserved()                 )%>"  name="mereserved">
        </td>
        <td><input type="text" class="edit_input" size="10" VALUE="<%=getNull(court.getMgReserved()                 )%>"  name="mgreserved">
        </td>
        <td><input type="text" class="edit_input" size="10" VALUE="<%=getNull(court.getGgReserved()                 )%>"  name="ggreserved">
        </td>
        <td><input type="text" class="edit_input" size="10" VALUE="<%=getNull(court.getViReserved()                 )%>"  name="vireserved">
        </td>
      </tr>
      <tr>
        <td><%=r.getString(teasession._nLanguage,  "BuggyFee(9holes)")%></td>
        <td><input type="text" class="edit_input" size="10" VALUE="<%=getNull(court.getMeBuggy9()                   )%>"  name="mebuggy9">
        </td>
        <td><input type="text" class="edit_input" size="10" VALUE="<%=getNull(court.getMgBuggy9()                   )%>"  name="mgbuggy9">
        </td>
        <td><input type="text" class="edit_input" size="10" VALUE="<%=getNull(court.getGgBuggy9()                   )%>"  name="ggbuggy9">
        </td>
        <td><input type="text" class="edit_input" size="10" VALUE="<%=getNull(court.getViBuggy9()                   )%>"  name="vibuggy9">
        </td>
      </tr>
      <tr>
        <td><%=r.getString(teasession._nLanguage,  "BuggyFee(18holes)")%></td>
        <td><input type="text" class="edit_input" size="10" VALUE="<%=getNull(court.getMeBuggy18()                  )%>"  name="mebuggy18">
        </td>
        <td><input type="text" class="edit_input" size="10" VALUE="<%=getNull(court.getMgBuggy18()                  )%>"  name="mgbuggy18">
        </td>
        <td><input type="text" class="edit_input" size="10" VALUE="<%=getNull(court.getGgBuggy18()                  )%>"  name="ggbuggy18">
        </td>
        <td><input type="text" class="edit_input" size="10" VALUE="<%=getNull(court.getViBuggy18()                  )%>"  name="vibuggy18">
        </td>
      </tr>
      <tr>
        <td><%=r.getString(teasession._nLanguage,  "DrivingRangeBall")%></td>
        <td><input type="text" class="edit_input" size="10" VALUE="<%=getNull(court.getMeDriving()                  )%>"  name="medriving">
        </td>
        <td><input type="text" class="edit_input" size="10" VALUE="<%=getNull(court.getMgDriving()                  )%>"  name="mgdriving">
        </td>
        <td><input type="text" class="edit_input" size="10" VALUE="<%=getNull(court.getGgDriving()                  )%>"  name="ggdriving">
        </td>
        <td><input type="text" class="edit_input" size="10" VALUE="<%=getNull(court.getViDriving()                  )%>"  name="vidriving">
        </td>
      </tr>
      <tr>
        <td><%=r.getString(teasession._nLanguage,  "ClubRental-perClub")%></td>
        <td><input type="text" class="edit_input" size="10" VALUE="<%=getNull(court.getMeClub()                     )%>"  name="meclub">
        </td>
        <td><input type="text" class="edit_input" size="10" VALUE="<%=getNull(court.getMgClub()                     )%>"  name="mgclub">
        </td>
        <td><input type="text" class="edit_input" size="10" VALUE="<%=getNull(court.getGgClub()                     )%>"  name="ggclub">
        </td>
        <td><input type="text" class="edit_input" size="10" VALUE="<%=getNull(court.getViClub()                     )%>"  name="viclub">
        </td>
      </tr>
      <tr>
        <td><%=r.getString(teasession._nLanguage,  "CommonClubs")%></td>
        <td><input type="text" class="edit_input" size="10" VALUE="<%=getNull(court.getMeCommon()                   )%>"  name="mecommon"></td>
        <td><input type="text" class="edit_input" size="10" VALUE="<%=getNull(court.getMgCommon()                   )%>"  name="mgcommon"></td>
        <td><input type="text" class="edit_input" size="10" VALUE="<%=getNull(court.getGgCommon()                   )%>"  name="ggcommon"></td>
        <td><input type="text" class="edit_input" size="10" VALUE="<%=getNull(court.getViCommon()                   )%>"  name="vicommon"></td>
      </tr>
      <tr>
        <td><%=r.getString(teasession._nLanguage,  "Pro.rentalClubs")%></td>
        <td><input  name="mepro" type="text" class="edit_input" size="10" VALUE="<%=getNull(court.getMePro()                      )%>"></td>
        <td><input type="text" class="edit_input" size="10" VALUE="<%=getNull(court.getMgPro()                      )%>"  name="mgpro"></td>
        <td><input type="text" class="edit_input" size="10" VALUE="<%=getNull(court.getGgPro()                      )%>"  name="ggpro"></td>
        <td><input type="text" class="edit_input" size="10" VALUE="<%=getNull(court.getViPro()                      )%>"  name="vipro"></td>
      </tr>
      <tr>
        <td><%=r.getString(teasession._nLanguage,  "SpikedShoes")%></td>
        <td><input type="text" class="edit_input" size="10" VALUE="<%=getNull(court.getMeSpiked()                   )%>"  name="mespiked"></td>
        <td><input type="text" class="edit_input" size="10" VALUE="<%=getNull(court.getMgSpiked()                   )%>"  name="mgspiked"></td>
        <td><input type="text" class="edit_input" size="10" VALUE="<%=getNull(court.getGgSpiked()                   )%>"  name="ggspiked"></td>
        <td><input type="text" class="edit_input" size="10" VALUE="<%=getNull(court.getViSpiked()                   )%>"  name="vispiked"></td>
      </tr>
      <tr>
        <td><%=r.getString(teasession._nLanguage,  "UmbrellaRental")%></td>
        <td><input type="text" class="edit_input" size="10" VALUE="<%=getNull(court.getMeUmbrella()                 )%>"  name="meumbrella"></td>
        <td><input type="text" class="edit_input" size="10" VALUE="<%=getNull(court.getMgUmbrella()                 )%>"  name="mgumbrella"></td>
        <td><input type="text" class="edit_input" size="10" VALUE="<%=getNull(court.getGgUmbrella()                 )%>"  name="ggumbrella"></td>
        <td><input type="text" class="edit_input" size="10" VALUE="<%=getNull(court.getViUmbrella()                 )%>"  name="viumbrella"></td>
      </tr>
      <tr>
        <td><%=r.getString(teasession._nLanguage,  "FacilitiesFee")%></td>
        <td><input type="text" class="edit_input" size="10" VALUE="<%=getNull(court.getMeFacilities()               )%>"  name="mefacilities"></td>
        <td><input type="text" class="edit_input" size="10" VALUE="<%=getNull(court.getMgFacilities()               )%>"  name="mgfacilities"></td>
        <td><input type="text" class="edit_input" size="10" VALUE="<%=getNull(court.getGgFacilities()               )%>"  name="ggfacilities"></td>
        <td><input type="text" class="edit_input" size="10" VALUE="<%=getNull(court.getViFacilities()               )%>"  name="vifacilities"></td>
      </tr>
      <tr>
        <td><%=r.getString(teasession._nLanguage,  "NondesignatedGreenFee")%><%=r.getString(teasession._nLanguage, "Weekday")%></td>
        <td><input type="text" class="edit_input" size="10" VALUE="<%=getNull(court.getMeNonDesignatedW()           )%>"  name="menondesignatedw"></td>
        <td><input type="text" class="edit_input" size="10" VALUE="<%=getNull(court.getMgNonDesignatedW()           )%>"  name="mgnondesignatedw"></td>
        <td><input type="text" class="edit_input" size="10" VALUE="<%=getNull(court.getGgNonDesignatedW()           )%>"  name="ggnondesignatedw"></td>
        <td><input type="text" class="edit_input" size="10" VALUE="<%=getNull(court.getViNonDesignatedW()           )%>"  name="vinondesignatedw"></td>
      </tr>
      <tr>
        <td><%=r.getString(teasession._nLanguage,  "Holiday")%>
        <td><input type="text" class="edit_input" size="10" VALUE="<%=getNull(court.getMeNonDesignatedH()           )%>"  name="menondesignatedh"></td>
        <td><input type="text" class="edit_input" size="10" VALUE="<%=getNull(court.getMgNonDesignatedH()           )%>"  name="mgnondesignatedh"></td>
        <td><input type="text" class="edit_input" size="10" VALUE="<%=getNull(court.getGgNonDesignatedH()           )%>"  name="ggnondesignatedh"></td>
        <td><input type="text" class="edit_input" size="10" VALUE="<%=getNull(court.getViNonDesignatedH()           )%>"  name="vinondesignatedh"></td>
      </tr>
    </table>
    <center>
    <!--<input type=submit name="GoBack"  id="edit_GoNext" class="edit_button" value="<%=r.getString(teasession._nLanguage, "GoBack")%>">-->

<%--
  <input type="submit" name="GoNext" class="edit_button"  onClick="" value="<%=r.getString(teasession._nLanguage, "GolfPicture")%>"/>
--%>
    <input type=submit name="GoFinish" ID="edit_GoFinish" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "Finish")%>">
    <input type="button" value="返回" onClick="history.back();"/>
  </form>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</html>
