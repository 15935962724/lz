<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>

<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
          <script>
function td_calendar(fieldname)
{
  myleft=document.body.scrollLeft+event.clientX-event.offsetX-80;
  mytop=document.body.scrollTop+event.clientY-event.offsetY+140;
  window.showModalDialog("/tea/inc/calendar.jsp?FIELDNAME="+fieldname,self,"edge:raised;scroll:0;status:0;help:0;resizable:1;dialogWidth:280px;dialogHeight:205px;dialogTop:"+mytop+"px;dialogLeft:"+myleft+"px");
}
        </script>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "Gazetteer")%><%=r.getString(teasession._nLanguage, "Edit")%></h1>
  <div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" action="/servlet/EditEGazetteer" method=post onSubmit="return(submitText(this.name, '<%=r.getString(teasession._nLanguage, "InvalidSubject")%>'))">
   <%
   String parameter=teasession.getParameter("nexturl");
   boolean   parambool=(parameter!=null&&!parameter.equals("null"));
   EGazetteer obj=EGazetteer.find(0,teasession._nLanguage);
   if(parambool)
   out.print("<input type='hidden' name=nexturl value="+parameter+">");
   String subject="";
   Date issueDate=null;
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
     obj=EGazetteer.find(teasession._nNode,teasession._nLanguage);
     issueDate=node.getTime();
   }
    %><INPUT TYPE="hidden" NAME="TypeAlias" VALUE="<%=request.getParameter("TypeAlias")%>">
      <input type="hidden" name="node" value="<%=teasession._nNode%>">
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td>First Name </td>
    <td colspan="3"><input type="text" class="text" value="<%=obj.getName()%>" name="name"></td>
  </tr>
  <tr>
    <td>Last Name </td>
    <td colspan="3"><input type="text"  value="<%=obj.getName2()%>" name="name2" class="text"></td>
  </tr>
  <tr>
    <td>Name to appear on Badge </td>
    <td colspan="3"><input type="text" name="appear"    value="<%=obj.getAppear()%>" class="text"></td>
  </tr>
  <tr>
    <td>Gender </td>
    <td><input name="sex"  id="radio" type="radio" value="male" checked="checked" class="text">male<input name="sex" <%=getCheck(obj.getSex().equals("female"))%>  id="radio" type="radio" value="female" class="text">female</td>
    <td>Date of Birth </td>
    <td><input name="birthday" readonly="readonly" value="<%=obj.getBirthday("yyyy-MM-dd")%>"/><input type="button" value="..." onclick="td_calendar('form1.birthday')"/></td>
  </tr>
  <tr>
    <td>Nationality </td>
    <td><input type="text" name="nationality" value="<%=obj.getNationality()%>" class="text"></td>
    <td>Blood Type </td>
    <td><select name=blood>
                <option value="A">A</option><option value="B" <%=getSelect("B".equals(obj.getBlood()))%>>B</option>
                <option value="AB" <%=getSelect("AB".equals(obj.getBlood()))%>>AB</option>
                <option value="O"<%=getSelect("O".equals(obj.getBlood()))%>>O</option>
</select></td>
  </tr>
  <tr>
    <td>Passport Number </td>
    <td><input type=text  value="<%=obj.getCardNum()%>" name=cardNum></td>
    <td>Expiration date </td>
    <td> <%=new TimeSelection("expiration", obj.getExpiration())%></td>
  </tr>
  <tr>
    <td>Applicant contact address </td>
    <td colspan="3"><input type=text name=address value="<%=obj.getAddress()%>" ></td>
  </tr>
  <tr>
    <td>Applicant position </td>
    <td colspan="3">
      <input name="business1"  onclick="faddtype(form1.business,this)"  id="CHECKBOX" type="CHECKBOX" value="Photographer">Photographer
        <input name="business2" onclick="faddtype(form1.business,this)"   id="CHECKBOX" type="CHECKBOX" value="Camera Operator">Camera Operator
          <input name="business3"  onclick="faddtype(form1.business,this)"  id="CHECKBOX" type="CHECKBOX" value="Technician">Technician<br />
	<input name="business4"  id="CHECKBOX" type="CHECKBOX"  onclick="faddtype(form1.business,this)" value="Journalist(TV, Radio, Print)">Journalist(TV, Radio, Print)<br />
     Others (please specify)<input name="business" value="<%=obj.getBusiness()%>" type="text" class="text">
    </td>
  </tr>
  <tr>
    <td>Applicant TEL </td>
    <td><input type=text  value="<%=obj.getPhone()%>" name=phone></td>
    <td>Applicant FAX </td>
    <td><input value="<%=obj.getFax()%>"  type=text name=fax ></td>
  </tr>
  <tr>
    <td>Applicant E-mail </td>
    <td colspan="3"><input type=text name=email value="<%=obj.getEmail()%>" ></td>
  </tr>
  <tr>
    <td rowspan="6"> Organization Information </td>
    <td> Name of Organization </td>
    <td colspan="2"><input name="organise" value="<%=obj.getOrganise()%>" type="text" class="text"></td>
  </tr>
  <tr>
    <td> Type of Organization </td>
    <td colspan="2">
<input name="type1"  id="CHECKBOX" type="CHECKBOX" onclick="faddtype(form1.type,this)" value="Newspaper">Newspaper
  <input name="type2"  id="CHECKBOX" type="CHECKBOX" onclick="faddtype(form1.type,this)"  value="Magazine">Magazine
    <input name="type3"  id="CHECKBOX" type="CHECKBOX" onclick="faddtype(form1.type,this)"  value="TV">TV<br />
<input name="type4"  id="CHECKBOX" type="CHECKBOX" onclick="faddtype(form1.type,this)"  value="Radio">Radio
  <input name="type5"  id="CHECKBOX" type="CHECKBOX" onclick="faddtype(form1.type,this)"  value="Photo Agency">Photo Agency <br />
<input name="type6"  id="CHECKBOX" type="CHECKBOX" onclick="faddtype(form1.type,this)"  value="Wire Service">Wire Service<br />
Others (please specify)<input type="text" name="type"  value="<%=obj.getType()%>"  class="text">

  <script>
function faddtype(addojb,obj)
{
  if(obj.checked)
  addojb.value+=obj.value+' ';
  else
{
var index=  addojb.value.indexOf(obj.value+' ');
if(index!=-1)
addojb.value=addojb.value.substring(0,index)+addojb.value.substring(index+(obj.value+' ').length);
}
}
</script>

    </td>
  </tr>
  <tr>
    <td> Address of Organization </td>
    <td colspan="2"><input type=text name=oaddress value="<%=obj.getOaddress()%>" ></td>
  </tr>
  <tr>
    <td> Organization TEL </td>
    <td colspan="2"><input  name="ophone" value="<%=obj.getOphone()%>" type="text" class="text"></td>
  </tr>
  <tr>
    <td> Organization FAX </td>
    <td colspan="2"><input name="ofax"  value="<%=obj.getOfax()%>" type="text" class="text"></td>
  </tr>
  <tr>
    <td> Organization E-mail </td>
    <td colspan="2"><input type="text"  value="<%=obj.getOemail()%>" name="oemail" class="text"></td>
  </tr>
  <tr>
    <td rowspan="8"> Arrival/departure details </td>      <td> Dateof arrival </td>
    <td colspan="2"> Time of arrival </td>
  </tr>
  <tr>
    <td>
      <input type="text" class="text" name="arrivaldate" value="<%=getNull(obj.getArrivalDate())%>">
    </td>
    <td colspan="2"><input type="text" class="text" name="arrivaltime" value="<%=getNull(obj.getArrivalTime())%>"></td>
  </tr>
  <tr>
    <td> Portof Arrival </td>
    <td colspan="2"> Arrival flight No. </td>
  </tr>
  <tr>
    <td><input type=text name=arrivalflight value="<%=obj.getArrivalFlight()%>" ></td>
    <td colspan="2"><input type=text name=arrivaltrain value="<%=obj.getArrivalTrain()%>" ></td>
  </tr>
  <tr>
    <td> Date of departure </td>
    <td colspan="2"> Time of departure </td>
  </tr>
  <tr>
    <td>
      <input type="text" class="text" name="leavedate" value="<%=getNull(obj.getLeaveDate())%>">
    </td>
    <td colspan="2"><input type="text" class="text" name="leavetime" value="<%=getNull(obj.getLeaveTime())%>"></td>
  </tr>
  <tr>
    <td> Port of departure </td>
    <td colspan="2"> Departure flight No. </td>
  </tr>
  <tr>
    <td><input type=text name=leaveflight value="<%=obj.getLeaveFlight()%>" ></td>
    <td colspan="2"><input type=text name=leavetrain value="<%=obj.getLeaveTrain()%>" ></td>
  </tr>
  <tr>
    <td>Airport pick-up </td>
    <td> Yes
    <input name="welcome" checked="checked"  id="radio" type="radio" value="yes"></td>
    <td colspan="2"> No
    <input name="welcome" <%=getCheck(obj.getWelcome().equals("no"))%>  id="radio" type="radio" value="no"></td>
  </tr>
  <tr>
    <td>Remark </td>
    <td colspan="3"><textarea name="remark" cols="50" rows="7" class="text"><%=obj.getRemark()%></textarea></td>
  </tr>
  <tr>
    <td colspan="4">Please Return Completed Form NO LATER THAN ????2005to:<br />
Ms./Mr.XXX<br />
China Secretariat for 21st Century Forum<br />
E-mail:<br />
Tel:
    Fax: </td>
  </tr>
  <tr>
    <td colspan="4"> <em>APPLICATIONS WITHOUT AN ACCOMPANYNING SIGNED LETTER OF ASSISGNMENT FROM THE EDITOR OR EXECUTIVE OF THE ORGANIZATION REPRESENTED WILL NOT BE PROCESSED.</em> </td>
  </tr>
</table>
文件:<input type="button"  value="上传" onclick="window.open('/jsp/type/gazetteer/GazetteerUp.jsp?Type=61')"/>
<p align="center">
         <input type=SUBMIT name="GoFinish"   ID="edit_GoFinish" class="edit_button" value="<%=r.getString(teasession._nLanguage, "Finish")%>">
<p>attention: if you are not able to send the form on line, please <a href="/tea/image/section/Media_Application_en.doc" style="color:red;">download this form</a> and fax to us.</p></LI></ul><div id="searh"><form METHOD="POST" action="/servlet/Node?node=18263&Listing=6451" NAME="condition" ><input type='hidden' name="LoginType" value="0"><input type='hidden' name="Context" value="0"><input TYPE="hidden" name="radiobutton" value="1">在线搜索:<input type="text" name="keyword" size="10" class="text" /><input type="submit" class="button"  value="标题" onClick="if (keyword.value =='') {keyword.value =''};radiobutton.value ='1'" /><input type="submit" class="button"  value="全文" onClick="if (keyword.value =='') {keyword.value =''};radiobutton.value ='2'" /></form>
<div id="head6"><img height="6">
</BODY></html>


