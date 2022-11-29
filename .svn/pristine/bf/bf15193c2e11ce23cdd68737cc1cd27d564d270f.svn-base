<%@page import="tea.entity.node.Service"%>
<%@page import="tea.entity.city.CityList"%>
<%@page contentType="text/html;charset=UTF-8"  %>
<%@include file="/jsp/Header.jsp"%>
<%

r.add("/tea/resource/NightShop");

if(!node.isCreator(teasession._rv)&&!AccessMember.find(node._nNode, teasession._rv._strV).isProvider(45))
{
    response.sendError(403);
    return;
}
//获取省id
String provinceid="0";
if(request.getParameter("provinceid")!=null){
	provinceid=request.getParameter("provinceid");
}
//获取市id
 String cityid="0";
if(request.getParameter("cityid")!=null){
	cityid=request.getParameter("cityid");
}

Date date_n=null;

NightShop obj=NightShop.find(teasession._nNode,teasession._nLanguage);
long logoLen=0;

if(obj.getLogo()!=null)
logoLen=new java.io.File(application.getRealPath(obj.getLogo())).length();




/*
String  StartHours=obj.getStartBusinessHours();
int StartHour=0,StartMinute=0;
if(StartHours.length()>2)
{
    int index=StartHours.indexOf(":");
    if(index!=-1)
    {
      StartHour=Integer.parseInt(StartHours.substring(0,index));
      StartMinute=Integer.parseInt(StartHours.substring(index+1));
    }
}

String  StopHours=obj.getStopBusinessHours();
int StopHour=0,StopMinute=0;
if(StopHours.length()>2)
{
    int index=StopHours.indexOf(":");
    if(index!=-1)
    {
        StopHour=Integer.parseInt(StopHours.substring(0,index));
        StopMinute=Integer.parseInt(StopHours.substring(index+1));
    }
}
*/



%><html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/jquery.js" type="text/javascript"></script>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<style>
#t_service{border:1px solid #CCCCCC; background:#FFFFFF;_height:24px;min-height:24px;width:400px;float:left}
#t_service span{background:#F2F6FB;margin:1 3;padding:3;height:16px}
#t_service img{margin-left:10px;width:7px;}
#t_service .ico{margin:1px;width:16px;vertical-align:middle;}
#t_event{border:1px solid #CCCCCC; background:#FFFFFF;_height:24px;min-height:24px;width:400px;float:left}
#t_event span{background:#F2F6FB;margin:1 3;padding:3;height:16px}
#t_event img{margin-left:10px;width:7px;}
#t_event .ico{margin:1px;width:16px;vertical-align:middle;}
</style>
</head> 
<script>
mt.receive=function(a,b,c)
{
	$$('t_service').innerHTML=a;
};
mt.receive1=function(a,b,c)
{
	$$('t_event').innerHTML=a;
};
function f_xp(igd,igdstrid,igdname,igdpingpai)
{
	 sendx("/jsp/admin/edn_ajax.jsp?act=ewmxp&wotype=0&wm="+igd+"&igdname="+igdname+"&igdpingpai="+igdpingpai,
			 function(data)
			 {
		 		if(data!=''&&data.length>1)
		 			{
		 			   data = data.trim();
				 	   document.getElementById(igdstrid).innerHTML=data;
		 			}
			 }
			 );
}

function f_sub()
{
	var provinceid=jQuery("#provinceidhidden").val();
	var cityid=jQuery("#cityidhidden").val();
  
	  if(provinceid==0&&cityid==0){
		  if(form1.selProvince.value==''){
			  alert("省不能为空！");
			  form1.selProvince.focus();
		  	return false;
		  }
	  }
	  if(cityid==0){
		  if(form1.selCity.value==''){
			  alert("市不能为空！");
			  form1.selCity.focus();
		 	 return false;
		  }
	  }
	if(form1.selLocation.value==''){
		alert("区不能为空！");
		form1.selLocation.focus();
		return false;
	}
	 if(form1.map.value == ''){
	  		alert("请选择地图坐标！");
		  	form1.map.focus();
		  	return false;
	  }
	 form1.submit();
}



</script>
<body onload="f_xp('<%=obj.getNstype1() %>','xxinghaoid','xxinghao','<%=obj.getNstype2() %>');" >
<h1><%=r.getString(teasession._nLanguage, "EditNightShop")%></h1>
<div id="head6"><img  height="6"></div>
<div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div>
<form name="form1" method="post" action="/servlet/EditNightShop"  enctype=multipart/form-data onSubmit="return submitText(this.name,'<%=r.getString(teasession._nLanguage, "InvalidName")%>')">
<input type=hidden name="node" value="<%=teasession._nNode%>">
<input id="provinceidhidden" name="provinceidhidden" type="hidden" value="<%=provinceid %>"/>
<input id="cityidhidden" name="cityidhidden" type="hidden" value="<%=cityid %>"/>

<input id="valuecid" name="valuecid" type="hidden" value="<%=obj.getCityid() %>"/>
<input id="valuepro" name="cityidhidden" type="hidden" value="<%=obj.getProvinceid() %>"/>
<input id="valueloc" name="cityidhidden" type="hidden" value="<%=obj.getLocation() %>"/>
<input id="valuecom" name="valuecom" type="hidden" value="<%=obj.getCommericial() %>"/>
<input id="valueland" name="valuelandmark" type="hidden" value="<%=obj.getLandmark() %>"/>
<input id="datacom" name="datacom" type="hidden" value=""/>
<input id="languagehidden" name="languagehidden" type="hidden" value="<%=teasession._nLanguage %>"/>

<%
String parameter=teasession.getParameter("nexturl");
boolean parambool=(parameter!=null&&!parameter.equals("null"));
if(parambool)
out.print("<input type='hidden' name=nexturl value="+parameter+">");
int code=0;
String subject="",text="";
if(request.getParameter("NewNode")!=null)
{
   out.println("<INPUT TYPE=hidden NAME=NewNode VALUE=ON>");
}else
{
  code=teasession._nNode;
  subject=HtmlElement.htmlToText(node.getSubject(teasession._nLanguage));
  text=node.getText(teasession._nLanguage);
}
%>
  <input type="hidden" name="TypeAlias" value="<%=request.getParameter("TypeAlias")%>">
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <%-- <%
    if(code>0)
    {%>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "NightShopCode")%>:</td>
      <td><%=code%></td>
    </tr>
    <%}%> --%>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Name")%>:</td>
      <td><input type="text" size=70 maxlength=255   name="name" value="<%=subject%>">
      </td>
    </tr>
    <tr>
    <td>选择可提供的服务：</td>
    <td><div id="t_service" alt="选择可提供的服务" style="width:740px;height:auto;"><%if(Service.f(MT.f(obj.services))!=null){out.print(Service.f(MT.f(obj.services)));}%></div><input type="button" value="添加" onClick="mt.show('/jsp/type/nightshop/ServiceList.jsp',2,'选择服务',600,450)"/></td>
  </tr>
    <tr>
    <td>选择可提供的活动：</td>
    <td><div id="t_event" alt="选择可提供的活动" style="width:740px;height:auto;"><%if(Event.f(MT.f(obj.activitys))!=null){out.print(Event.f(MT.f(obj.activitys)));}%></div><input type="button" value="添加" onClick="mt.show('/jsp/type/nightshop/EventList.jsp',2,'选择活动',600,450)"/></td>
  </tr>
    <tr>
      <td>logo:</td>
      <td><input type=file  size=40  name=logo>
          <%
          if(logoLen>0)
          {
            out.print("<a href="+obj.getLogo()+" target=_blank>"+logoLen+ r.getString(teasession._nLanguage, "Bytes")+"</a>");
            out.print("<input type=checkbox name=ClearLogo onclick='form1.logo.disabled=this.checked'>"+r.getString(teasession._nLanguage, "Clear"));
          }
          %>
          </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Type")%>:</td>
      <td>
 <select name="xpinpai" onchange="f_xp(this.value,'xxinghaoid','xxinghao','0');">
 				<option value="0">----</option>
 				<%
 				java.util.List catList  = WomenOptions.findByTpyeAndLan(0,0,teasession._nLanguage);
 				if(catList!=null && !catList.isEmpty()){
	 				for(int i = 0;i<catList.size();i++){
	 					java.util.List detaList = (java.util.List)catList.get(i);
	 					String id = (String)detaList.get(0);
	 					String name = (String)detaList.get(1);
	 					out.println("<option value="+id);
	 		            if(obj.getNstype1()==Integer.parseInt(id))
	 		            {
	 		            	out.println(" selected ");
	 		            }
	 		           
	 		            out.println(">"+name);
	 		            out.print("</option>");
		 					
		 				}
 				}				
 				
 				%>
 			</select>
 			<span id="xxinghaoid">
	 			<select name="xxinghao">
	 				<option value="0">----</option>
	 				
	 			</select>
 			</span>
    
      </td>
    </tr>
    <!-- 
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Area")%>:</td>
      <td><input type="text"  size=70  name="area" value="<%if(obj.getArea()!=null)out.print(obj.getArea());%>" >
      </td>
    </tr>
     -->
     <tr>
      <td align="right"><%=r.getString(teasession._nLanguage, "Address")%>：</td>
      <td>
     
    <select id="selProvince" name="selProvince" onChange = "getCityByProvince(this.value,0)"  style="width: 90px;">
     <%if(obj.getProvinceid() ==null||obj.getProvinceid().equals("")){%>
        <option value="">----请选择----</option>
     <% }else{%>
        <option value="<%=obj.getProvinceid() %>"><%=CityList.getProvinceName(Integer.parseInt(obj.getProvinceid()), teasession._nLanguage) %></option>
     <% }%>
    </select>
    
    <select id="selCity" name="selCity" onChange = "getLocationByCity(this.value)" style="width: 100px;">
    <%if(obj.getCityid() ==null||obj.getCityid().equals("")){%>
        <option value="">----请选择----</option>
     <% }else{%>
        <option value="<%=obj.getCityid() %>"><%=CityList.getProvinceName(Integer.parseInt(obj.getCityid()), teasession._nLanguage) %></option>
        <% }%>
    </select>
    
    <select id="selLocation" name="selLocation" style="width: 160px;">
    <%if(obj.getLocation()==null||obj.getLocation().equals("")){%>
        <option value="">--------请选择--------</option>
     <% }else{%>
        <option value="<%=obj.getLocation()%>"><%=obj.getNULL(obj.getLocation()) %></option>
       <% }%>
    </select>
    <input type="text"  size=70  name="address" value="<%if(obj.getAddress()!=null)out.print(obj.getAddress());%>">
    </tr>
    
    <tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "商圈")%>：</td>
    <td>
		 <select id="selCommericial" name="selCommericial" style="width: 160px;">
		 <!-- 
    <%if(obj.getCommericial() ==null||obj.getCommericial().equals("")){%>
        <option value="">--------请选择--------</option>
     <% }else{%>
        <option value="<%=obj.getCommericial()%>"><%=obj.getNULL(obj.getCommericial()) %></option>
       <% }%>
		  -->
    </select>
      <%=r.getString(teasession._nLanguage, "输入查询商圈")%>：
    <input id="cominput" type="text">
	</td>
    </tr>
    <tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "地标")%>：</td>
    <td>
		 <select id="selLandmark" name="selLandmark" style="width: 160px;">
     <!-- 
	    <%if(obj.getLandmark() ==null||obj.getLandmark().equals("")){%>
	        <option value="">--------请选择--------</option>
	     <% }else{%>
        <option value="<%=obj.getLandmark()%>"><%=obj.getNULL(obj.getLandmark()) %></option>
       <% }%>
       -->
    </select>
      <%=r.getString(teasession._nLanguage, "输入查询地标")%>：
    <input id="landinput" type="text">
	</td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "服务范围")%>: </td>
      <td><input type="text"  size=70  name="serArea" value="<%=MT.f(obj.serArea)%>">
      </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "MusicType")%>: </td>
      <td><input type="text"  size=70  name="musicType" value="<%if(obj.getMusicType()!=null)out.print(obj.getMusicType());%>">
      </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "DeilStyle")%>:</td>
      <td><input type="text"  size=70  name="deilStyle" value="<%if(obj.getDeilStyle()!=null)out.print(obj.getDeilStyle());%>">
      </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Circumstance")%>:</td>
      <td><input type="text"  size=70  name="circumstance" value="<%if(obj.getCircumstance()!=null)out.print(obj.getCircumstance());%>">
      </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "BusinessHours")%>:</td>
      <td><input  size=70  name="starthour" value="<%if(obj.getStartBusinessHours()!=null)out.print(obj.getStartBusinessHours());%>">
          <%--
        <select name="starthour">
         <%for(int i=0;i<24;i++){%>
          <option <%=getSelect(StartHour==i)%>><%=i%></option>
<%}%>
        </select>

        <%=r.getString(teasession._nLanguage, "Hour")%>
        <select name="startminute" >
              <%for(int i=0;i<60;i=i+5){%>
            <option value="<%=i%>"  <%=getSelect(StartMinute==i)%>><%=i%></option>
            <%}%>
        </select>
        <%=r.getString(teasession._nLanguage, "Minute")%>--
        <select name="stophour" >
          <%for(int i=0;i<24;i++){%>
          <option  <%=getSelect(StopHour==i)%>><%=i%></option>
<%}%>
        </select><%=r.getString(teasession._nLanguage, "Hour")%>
        <select name="stopminute" >
          <%for(int i=0;i<60;i=i+5){%>
            <option value="<%=i%>"   <%=getSelect(StopMinute==i)%>><%=i%></option>
            <%}%>
        </select><%=r.getString(teasession._nLanguage, "Minute")%>
--%>
      </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Options")%>: </td>
      <td><input  id="CHECKBOX" type="CHECKBOX" name="depot" <%=getCheck((obj.getOptions()&1)!=0)%>>
          <%=r.getString(teasession._nLanguage, "Depot")%>
          <%-- <input  id="CHECKBOX" type="CHECKBOX" name="ticket" <%=getCheck((obj.getOptions()&2)!=0)%> ><%=r.getString(teasession._nLanguage, "Ticket")%>--%>
          <input  id="CHECKBOX" type="CHECKBOX" name="open" <%=getCheck((obj.getOptions()&4)!=0)%> >
          <%=r.getString(teasession._nLanguage, "DayOpenBusiness")%>
          <input  id="CHECKBOX" type="CHECKBOX" name="electron" <%=getCheck((obj.getOptions()&8)!=0)%>>
          <%=r.getString(teasession._nLanguage, "ElectroTicket")%> </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Synopsis")%>:</td>
      <td><textarea name="synopsis" cols="60" rows="5"  ><%if(obj.getSynopsis()!=null)out.print(obj.getSynopsis());%>
</textarea>
      </td>
    </tr>
    
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Capability")%>:</td>
      <td><input type="text"  size=70  name="capability" value="<%if(obj.getCapability()!=null)out.print(obj.getCapability());%>"></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Payment")%>:</td>
      <td><input type="text"  size=70  name="payment" value="<%if(obj.getPayment()!=null)out.print(obj.getPayment());%>">
      </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Intro")%>:</td>
      <td><textarea name="intro" cols="60" rows="5"  ><%out.print(text) ;//=obj.getIntro()%></textarea>
      </td>
    </tr>
     
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Trait")%>:</td>
      <td><input type="text"  size=70  name="trait" value="<%if(obj.getTrait()!=null)out.print(obj.getTrait());%>">
      </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Depreciate")%>:</td>
      <td><input type="text"  size=70  name="depreciate" value="<%if(obj.getDepreciate()!=null)out.print(obj.getDepreciate());%>">
      </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "PracticeHours")%>:</td>
      <td><%=new TimeSelection("Issue", date_n)%> </td>
    </tr>
    <%-- <tr>
      <td><%=r.getString(teasession._nLanguage, "Address")%>:</td>
      <td><input type="text"  size=70  name="address" value="<%if(obj.getAddress()!=null)out.print(obj.getAddress());%>">
      </td>
    </tr> --%>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "NightShopPicture")%>:</td>
      <td><input type="button" class="edit_button"  onClick="window.open('<%if(obj.getType()!=null)out.print(request.getContextPath());%>/jsp/type/TypePicture.jsp?node=<%=teasession._nNode%>')" value="<%=r.getString(teasession._nLanguage, "New")%>"/>
      <input type="button" value="360实景图" onclick="window.open('/jsp/admin/map/UpMapReal.jsp?node=<%=teasession._nNode%>','','width=500,height=350');"/>
      </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Map")%>:</td>
      <td><input type=text size=70 value="<%=getNull(obj.getMap())%>" name=map>
      <input type=button value="标点" onclick="window.open('/jsp/admin/map/EditGMap.jsp?community=<%=teasession._strCommunity%>&node=<%=teasession._nNode%>&field=form1.map','_blank','width=600,height=500');" >
      </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Principal")%>:</td>
      <td><input type="text"  size=70  name="principal" value="<%if(obj.getPrincipal()!=null)out.print(obj.getPrincipal());%>">
      </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Phone")%>:</td>
      <td><input type="text"  size=70  name="phone" value="<%if(obj.getPhone()!=null)out.print(obj.getPhone());%>">
      </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Fax")%>: </td>
      <td><input type="text"  size=70  name="fax" value="<%if(obj.getFax()!=null)out.print(obj.getFax());%>">
      </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Postalcode")%>: </td>
      <td><input type="text"  size=70  name="postalcode" value="<%if(obj.getPostalcode()!=null)out.print(obj.getPostalcode());%>">
      </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Cooperate")%>: </td>
      <td><input type="text"  size=70  name="cooperate" value="<%if(obj.getCooperate()!=null)out.print(obj.getCooperate());%>">
      </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Sponsor")%>:</td>
      <td><input type="text"  size=70  name="sponsor" value="<%if(obj.getCooperate()!=null)out.print(obj.getSponsor());%>">
      </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Consume")%>:</td>
      <td><input type="text"  size=70  name="consume" value="<%if(obj.getConsume()!=null)out.print(obj.getConsume());%>">
      </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Acreage")%>:</td>
      <td><input type="text"  size=70  name="acreage" value="<%if(obj.getAcreage()!=null)out.print(obj.getAcreage());%>">
      </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "AverageConsume")%>:</td>
      <td><input type="text"  size=70  name="averageConsume" value="<%if(obj.getAverageConsume()!=null)out.print(obj.getAverageConsume());%>">
      </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Price")%>:</td>
      <td><input type="text"  size=70  name="price" value="<%if(obj.getPrice()!=null)out.print(obj.getPrice());%>">
      </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Among")%>:</td>
      <td><input type="text"  size=70  name="among" value="<%if(obj.getAmong()!=null)out.print(obj.getAmong());%>">
      </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Operation")%>:</td>
      <td><input type="text"  size=70  name="operation" value="<%if(obj.getOperation()!=null)out.print(obj.getOperation());%>">
      </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Loo")%>:</td>
      <td><input type="text"  size=70  name="loo" value="<%if(obj.getLoo()!=null)out.print(obj.getLoo());%>">
      </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Destine")%>:</td>
      <td><input type="text"  size=70  name="destine" value="<%if(obj.getDestine()!=null)out.print(obj.getDestine());%>">
      </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Block")%>:</td>
      <td><input type="text"  size=70  name="block" value="<%if(obj.getBlock()!=null)out.print(obj.getBlock());%>">
      </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "CoverCharge")%>:</td>
      <td><input type="text"  size=70  name="coverCharge" value="<%if(obj.getCoverCharge()!=null)out.print(obj.getCoverCharge());%>">
      </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Member")%>:</td>
      <td><input type="text"  size=70  name="member" value="<%if(obj.getMember()!=null)out.print(obj.getMember());%>">
      </td>
    </tr>
    <tr>
      <td>Email:</td>
      <td><input type="text"   size=70   name="email" value="<%if(obj.getEmail()!=null)out.print(obj.getEmail());%>">
      </td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Ticket")%>:</td>
      <td><input type="text"  size=70  name="ticket" value="<%if(obj.getTicket()!=null)out.print(obj.getTicket());%>">
      </td>
    </tr>
  </table>
  <center>
    <input type="submit" name="GoBack" value="<%=r.getString(teasession._nLanguage, "GoBack")%>">
    <input type="button" name="GoFinish" onclick="f_sub();" value="<%=r.getString(teasession._nLanguage, "Finish")%>">
  </center>
</form>
<div id="head6"><img height="6" src="about:blank"></div>
 <div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
 
</body>
<script src="/tea/procity.js" type="text/javascript"></script>
<script type="text/javascript">
mt.uploads(form1);

</script>
</html>
