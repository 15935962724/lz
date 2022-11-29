<%@page import="tea.entity.city.CityList"%>
<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>

<%
r.add("/tea/resource/Service");
tea.entity.node.Service investor =tea.entity.node.Service.find(0, teasession._nLanguage);
//获取省id
/* String provinceid="0";
if(request.getParameter("provinceid")!=null){
	provinceid=request.getParameter("provinceid");
}
//获取市id
String cityid="0";
if(request.getParameter("cityid")!=null){
	cityid=request.getParameter("cityid");
} */
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<script src="/tea/tea.js" type="text/javascript"></script>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/jquery.js" type="text/javascript"></script>
<META http-equiv=Content-Type content="text/html; charset=UTF-8">
<SCRIPT language=JavaScript>
function f_xp(igd,igdstrid,igdname,igdpingpai)
{
	 sendx("/jsp/admin/edn_ajax.jsp?act=ewmxp&wotype=1&wm="+igd+"&igdname="+igdname+"&igdpingpai="+igdpingpai,
			 function(data)
			 {
		 		if(data!=''&&data.length>1)
		 			{
		 			   data = data.trim();
				 	   document.getElementById(igdstrid).innerHTML=data;
		 			}
			 }
			 )
}
<!--
function checkform(theform)
{
return(submitText(theform.Subject,'主题不能为空'))&&
(submitInteger(theform.minimum,'最小值必须是数字'))&&
(submitFloat(theform.point,'积分必须是数字'))&&
(submitFloat(theform.price,'单价必须是数字'));

}
//-->
</SCRIPT>
</head>
<style>
/*路径隐藏*/
#pathdiv{display:none;}



</style>
<BODY>
<h1><%=r.getString(teasession._nLanguage, Node.NODE_TYPE[65])%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="edit_BodyDiv">
<div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%>  </div>

<FORM name="form1" action="/servlet/EditService"  method=post enctype="multipart/form-data" onSubmit="return checkform(this);">

<%
String parameter=request.getParameter("nexturl");
boolean parambool=(parameter!=null&&!parameter.equals("null"));
if(parambool)
out.print("<input type='hidden' name=nexturl value="+parameter+">");
String subject="",text="";
Date issDate=null;
if(request.getParameter("NewNode")!=null)
{
  out.println("<INPUT TYPE=hidden NAME=NewNode VALUE=ON>");
}else
if(request.getParameter("NewBrother")!=null)
{
  out.println("<INPUT TYPE=hidden NAME=NewBrother VALUE=ON>");
}else
{
  subject=node.getSubject(teasession._nLanguage);
  text=node.getText(teasession._nLanguage);
  investor= tea.entity.node.Service.find(teasession._nNode, teasession._nLanguage);
  issDate=node.getTime();
}
%>
<%-- <input id="provinceidhidden" name="provinceidhidden" type="hidden" value="<%=provinceid %>"/>
<input id="cityidhidden" name="cityidhidden" type="hidden" value="<%=cityid %>"/>

<input id="valuecid" name="valuecid" type="hidden" value="<%=investor.cityid %>"/>
<input id="valuepro" name="cityidhidden" type="hidden" value="<%=investor.cityid>0?(Integer.parseInt(String.valueOf(investor.cityid).substring(0,2))):investor.cityid %>"/>
<input id="valueloc" name="cityidhidden" type="hidden" value="<%=investor.locationid %>"/>
<input id="valuecom" name="valuecom" type="hidden" value="<%=investor.commericial %>"/>
<input id="valueland" name="valuelandmark" type="hidden" value="<%=investor.landmark %>"/> --%>
<input type='hidden' name="node" value="<%=teasession._nNode%>">
<INPUT TYPE="hidden" NAME="TypeAlias" VALUE="<%=request.getParameter("TypeAlias")%>">

  <TABLE border="0" cellspacing="0" cellpadding="0" id="tablecenter" style="BORDER-COLLAPSE: collapse">
    <tr>
      <td align=right nowrap ><%=r.getString(teasession._nLanguage, "Subject")%>:</td>
      <td colspan="20"><input type="TEXT" class="edit_input"  name=Subject value="<%=HtmlElement.htmlToText(subject)%>" size=70 maxlength=255><FONT color=#ff0000>(*)</FONT> </td>
    </tr>
    
    <tr>
      <td align=right nowrap><%=r.getString(teasession._nLanguage, "Type")%>:</td>
      <td>
 <select name="xpinpai" onchange="f_xp(this.value,'xxinghaoid','xxinghao','0');">
 				<option value="0">----</option>
 				<%
 				java.util.List catList  = WomenOptions.findByTpyeAndLan(0,1,teasession._nLanguage);
 				if(catList!=null && !catList.isEmpty()){
	 				for(int i = 0;i<catList.size();i++){
	 					java.util.List detaList = (java.util.List)catList.get(i);
	 					String id = (String)detaList.get(0);
	 					String name = (String)detaList.get(1);
	 					out.println("<option value="+id);
	 		            if(investor.nstype1==Integer.parseInt(id))
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
    
     <%-- <tr>
      <td align="right"><%=r.getString(teasession._nLanguage, "区域")%>：</td>
      <td>
     
    <select id="selProvince" name="selProvince" onChange = "getCityByProvince(this.value,0)"  style="width: 90px;">
     <%if(investor.cityid==0){%>
        <option value="">----请选择----</option>
     <% }else{%>
        <option value="<%=investor.cityid>0?String.valueOf(investor.cityid).substring(0,2):investor.cityid %>"><%=CityList.getProvinceName((investor.cityid>0?Integer.parseInt(String.valueOf(investor.cityid).substring(0,2)):investor.cityid), teasession._nLanguage) %></option>
     <% }%>
    </select>
    
    <select id="selCity" name="selCity" onChange = "getLocationByCity(this.value)" style="width: 100px;">
    <%if(investor.cityid==0){%>
        <option value="">----请选择----</option>
     <% }else{%>
        <option value="<%=investor.cityid %>"><%=CityList.getProvinceName(investor.cityid, teasession._nLanguage) %></option>
        <% }%>
    </select>
    
    <select id="selLocation" name="selLocation" style="width: 160px;">
    <%if(investor.locationid==null||investor.locationid.equals("")){%>
        <option value="">--------请选择--------</option>
     <% }else{%>
        <option value="<%=investor.locationid%>"><%=investor.locationid %></option>
       <% }%>
    </select>
    </tr>
    
    <tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "商圈")%>：</td>
    <td>
		 <select id="selCommericial" name="selCommericial" style="width: 160px;">
		 
    <%if(investor.commericial ==null||investor.commericial.equals("")){%>
        <option value="">--------请选择--------</option>
     <% }else{%>
        <option value="<%=investor.commericial%>"><%=investor.commericial %></option>
       <% }%>
		  
    </select>
      <%=r.getString(teasession._nLanguage, "输入查询商圈")%>：
    <input id="cominput" type="text">
	</td>
    </tr>
    <tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "地标")%>：</td>
    <td>
		 <select id="selLandmark" name="selLandmark" style="width: 160px;">
     
	    <%if(investor.landmark ==null||investor.landmark.equals("")){%>
	        <option value="">--------请选择--------</option>
	     <% }else{%>
        <option value="<%=investor.landmark%>"><%=investor.landmark %></option>
       <% }%>
       
    </select>
      <%=r.getString(teasession._nLanguage, "输入查询地标")%>：
    <input id="landinput" type="text">
	</td>    <tr> --%>
      <td align=right nowrap ><%=r.getString(teasession._nLanguage, "Unit")%>:</td>
      <td colSpan=3><INPUT name=unit   class="edit_input" value="<%=getNull(investor.getUnit())%>"></td>
    </tr>
    <tr>
      <td align=right nowrap ><%=r.getString(teasession._nLanguage, "Minimum")%>:</td>
      <td colSpan=3><INPUT name=minimum onkeydown="this.onchange();" onkeyup="this.onchange();" onchange="if(!isNaN(parseInt(this.value))&&parseInt(this.value)!=this.value)this.value=parseInt(this.value);" class="edit_input" value="<%=investor.getMinimum()%>">          </td>
    </tr>
    <tr>
      <td align=right vAlign=top nowrap><%=r.getString(teasession._nLanguage, "Synopsis")%>:</td>
      <td colSpan=3><TEXTAREA name=synopsis class="edit_input" rows=6 cols=45><%=HtmlElement.htmlToText(getNull(investor.getSynopsis()))%></TEXTAREA></td>
    </tr>
    <tr>
      <td align=right nowrap><%=r.getString(teasession._nLanguage, "Price")%>:</td>
      <td><INPUT name=price  class="edit_input"  value="<%=getNull(investor.getPrice())%>"><FONT color=#ff0000>(*)</FONT> </td>
    </tr>
    <tr>
      <td align=right vAlign=top nowrap><%=r.getString(teasession._nLanguage, "Quality")%>:</td>
      <td colSpan=3><TEXTAREA class="edit_input" name="quality" rows="6" cols="45"><%=getNull(investor.getQuality())%></TEXTAREA></td>
    </tr>
    <tr>
    <td align=right nowrap><%=r.getString(teasession._nLanguage, "Point")%>:</td>
    <td colSpan=3><input type="text" name="point" value="<%=investor.getPoint()%>"></td>
    </tr>
    <tr>
      <td align=right><%=r.getString(teasession._nLanguage, "Picture")%>:</td>
      <td colSpan=3><input type=file onDblClick="window.open('<%=investor.getPicture()%>')" name="picture">
      <%
      if(investor.getPicture()!=null&&investor.getPicture().length()>0)
      {
        out.print(  new java.io.File(application.getRealPath(investor.getPicture())).length()+r.getString(teasession._nLanguage,"Bytes"));
      }
      %>
      <input id="CHECKBOX" type="CHECKBOX" name="clear" onclick="form1.picture.disabled=checked; form1.picture.style.backgroundColor=checked?'#CCC':'';">清空</td>
    </tr>
    <tr>
      <td align=right><%=r.getString(teasession._nLanguage, "Picture")%>2:</td>
      <td colSpan=3><input type=file onDblClick="window.open('<%=investor.getPicture2()%>')" name="picture2">
      <%
      if(  investor.getPicture2()!=null&&investor.getPicture2().length()>0)
      {
        out.print(  new java.io.File(application.getRealPath(investor.getPicture2())).length()+r.getString(teasession._nLanguage,"Bytes"));
      }
      %>
      <input  id="CHECKBOX" type="CHECKBOX" name="clear2" value="checkbox" onClick="form1.picture2.disabled=checked; form1.picture2.style.backgroundColor=checked?'#CCC':'';">清空</td>
    </tr>
    <tr>
      <td align=right><%=r.getString(teasession._nLanguage, "Text")%>:</td>
      <td colSpan=3><TEXTAREA class="edit_input"  name=text rows="6" cols="45"><%=HtmlElement.htmlToText(getNull(text))%></TEXTAREA></td>
    </tr>
    <tr>
      <td align=right vAlign=top nowrap><%=r.getString(teasession._nLanguage, "Time")%>:</td>
      <td colSpan=3><TEXTAREA class="edit_input" id=time name=time rows="6" cols="45"><%=getNull(investor.getTime())%></TEXTAREA></td>
    </tr>
    
<!--    <tr>
      <td align=right vAlign=top nowrap><%=r.getString(teasession._nLanguage, "Type")%>:</td>
      <td colSpan=3><input type="text" name="type" value="<%=getNull(investor.getType())%>"></td>
    </tr>-->
    
    <tr>
      <td align=right vAlign=top nowrap><%=r.getString(teasession._nLanguage, "Thing")%>:</td>
      <td colSpan=3><TEXTAREA name=thing rows="6" cols="45" class="edit_input"><%=getNull(investor.getThing())%></TEXTAREA>
      </td>
    </tr>
    <tr>
      <td align=right vAlign=top nowrap><%=r.getString(teasession._nLanguage, "Tools")%>:</td>
      <td colSpan=3><TEXTAREA rows="6" cols="45" class="edit_input" size=18 name=tools><%=getNull(investor.getTools())%></TEXTAREA></td>
    </tr>
    <tr align=middle>
      <td colSpan=4><INPUT type=submit  ID="edit_GoFinish" class="edit_button" value=提交 name=Submit>
        <INPUT type=reset value=重填  ID="edit_GoFinish" class="edit_button" name=Submit2>
          <input type="submit" name="GoBack" id="edit_GoBack" class="edit_button" value="<%=r.getString(teasession._nLanguage, "Super")%>">
      </td>
    </tr>
</TABLE>
</FORM>
<script>
document.form1.Subject.focus();
window.onload=f_xp('<%=investor.nstype1 %>','xxinghaoid','xxinghao','<%=investor.nstype2 %>');
</script>
<script src="/tea/procity.js" type="text/javascript"></script>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</html>
