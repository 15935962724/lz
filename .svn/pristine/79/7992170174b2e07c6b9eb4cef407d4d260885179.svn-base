<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>

<%
tea.db.DbAdapter dbadapter=new tea.db.DbAdapter();
try
{
dbadapter.executeQuery("SELECT Node.node,type FROM Node WHERE finished=1 AND (type=58 OR type=60 OR type=59)AND rcreator="+dbadapter.cite(teasession._rv._strR)+" AND vcreator="+dbadapter.cite(teasession._rv._strV));
if(dbadapter.next())
{
    out.print(new tea.html.Script("if(confirm('您已经申请了其它的报名,如果在此申请报名,则系统会自动删除其它的报名.是否继续?')){window.open('/servlet/DeleteNode?node="+(dbadapter.getInt(1))+"&nexturl="+java.net.URLDecoder.decode(request.getRequestURI()+"?"+request.getQueryString())+"', '_self');}else{history.back();}"));
    return;
}else
  {
    dbadapter.executeQuery("SELECT Node.node FROM Node WHERE Node.type=61 AND rcreator="+dbadapter.cite(teasession._rv._strR)+" AND vcreator="+dbadapter.cite(teasession._rv._strV));
        if(dbadapter.next()&&request.getRequestURI().startsWith("/servlet/"))
        {
       out.print(new tea.html.Script("window.open('/jsp/type/"+tea.entity.node.Node.NODE_TYPE[61].toLowerCase()+"/21shijiEdit"+tea.entity.node.Node.NODE_TYPE[61]+".jsp?node="+dbadapter.getInt(1)+"','_self');"));
      return;
    }
  }
}catch (Exception ex)
{ex.printStackTrace();
}finally
{
  dbadapter.close();
}
%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT SRC="/tea/tea.js" type="text/javascript"></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style type="text/css">
<!--
* {	font-size: 9pt;
	color: #000000;
	text-decoration: none;
}

.biaoti {
	background-color: #EFF0F4;color:#276A97
}

-->
</style>          <script>
function td_calendar(fieldname)
{
  myleft=document.body.scrollLeft+event.clientX-event.offsetX-80;
  mytop=document.body.scrollTop+event.clientY-event.offsetY+140;
  window.showModalDialog("/tea/inc/calendar.jsp?FIELDNAME="+fieldname,self,"edge:raised;scroll:0;status:0;help:0;resizable:1;dialogWidth:280px;dialogHeight:205px;dialogTop:"+mytop+"px;dialogLeft:"+myleft+"px");
}
        </script>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "21shijiEditEGazetteer")%></h1>
  <div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" action="/servlet/EditEGazetteer" method=post onSubmit="return(submitText(this.name, '<%=r.getString(teasession._nLanguage, "InvalidSubject")%>')&&submitText(this.name2, 'Last Name')&&submitText(this.appear, 'Name to appear on Badge ')&&submitText(this.birthday, 'Date of Birth')&&submitText(this.nationality, 'Nationality')&&submitText(this.cardNum, 'Passport Number')&&submitText(this.address, 'Applicant contact address')&&submitText(this.business, 'Applicant position')&&submitText(this.phone, 'Applicant TEL ')&&submitText(this.fax, 'Applicant FAX ')&&submitText(this.email, 'Applicant E-mail')&&submitText(this.organise, 'Name of Organization ')&&submitText(this.type, 'Type of Organization')&&submitText(this.oaddress, 'Address of Organization')&&submitText(this.ophone, 'Organization TEL ')&&submitText(this.ofax, 'Organization FAX')&&submitText(this.oemail, 'Organization E-mail'))">
   <%
   String parameter=teasession.getParameter("nexturl");
   boolean   parambool=(parameter!=null&&!parameter.equals("null"));
   EGazetteer obj=EGazetteer.find(0,teasession._nLanguage);
   if(parambool)
   out.print("<input   type='hidden' name=nexturl value="+parameter+">");
   String subject="";
   Date issueDate=null;
   if(request.getParameter("NewNode")!=null)
   {
     out.println("<input  TYPE=hidden NAME=NewNode VALUE=ON>");
   }else
   if(request.getParameter("NewBrother")!=null)
   {
     out.println("<input  TYPE=hidden NAME=NewBrother VALUE=ON>");
   }else
   {
     subject=node.getSubject(teasession._nLanguage);
     obj=EGazetteer.find(teasession._nNode,teasession._nLanguage);
     issueDate=node.getTime();
   }
    %><input class="edit_input"  TYPE="hidden" NAME="TypeAlias" VALUE="<%=request.getParameter("TypeAlias")%>">
      <input class="edit_input"  type="hidden" name="node" value="<%=teasession._nNode%>">
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">

  <tr>
    <td class="biaoti"> 1.First Name </td>
    <td colspan="3"><input class="edit_input"  type="text"  value="<%=obj.getName()%>" name="name">*</td>
  </tr>
  <tr>
    <td class="biaoti"> 2.Last Name </td>
    <td colspan="3"><input class="edit_input"  type="text"  value="<%=obj.getName2()%>" name="name2" >*</td>
  </tr>
  <tr>
    <td class="biaoti"> 3.Name to appear on Badge </td>
    <td colspan="3"><input class="edit_input"  type="text" name="appear"    value="<%=obj.getAppear()%>" >*</td>
  </tr>
  <tr>
    <td class="biaoti"> 4.Gender </td>
    <td><input  name="sex"  id="radio" type="radio" value="男" checked="checked" >男<input  name="sex" <%=getCheck(obj.getSex().equals("女"))%>  id="radio" type="radio" value="女" >女   *</td>
    <td class="biaoti"> 5.Date of Birth </td>
    <td><input style="width:100" name="birthday" readonly="readonly" value="<%=obj.getBirthday("yyyy-MM-dd")%>"/><input type="button" value="..." onclick="td_calendar('form1.birthday')"/>*</td>
  </tr>
  <tr>
    <td class="biaoti"> 6.Nationality </td>
    <td><input class="edit_input"  type="text" name="nationality" value="<%=obj.getNationality()%>" >*</td>
    <td class="biaoti"> 7.Blood Type </td>
    <td><select name=blood>
                <option value="A">A</option>
                <option value="B" <%=getSelect("B".equals(obj.getBlood()))%>>B</option>
                <option value="AB" <%=getSelect("AB".equals(obj.getBlood()))%>>AB</option>
                <option value="O"<%=getSelect("O".equals(obj.getBlood()))%>>O</option>
</select></td>
  </tr>
  <tr>
    <td class="biaoti"> 8.Passport Number </td>
    <td><input class="edit_input"  type=text  value="<%=obj.getCardNum()%>" name=cardNum>*</td>
    <td class="biaoti"> 9.Expiration date </td>
    <td> <%=new TimeSelection("expiration", obj.getExpiration())%>*</td>
  </tr>
  <tr>
    <td class="biaoti"> 10.Applicant contact address </td>
    <td colspan="3"><input class="edit_input"  type=text name=address value="<%=obj.getAddress()%>" >*</td>
  </tr>
  <tr>
    <td class="biaoti"> 11.Applicant position </td>
    <td colspan="3">
      <input  name="business1"  onclick="faddtype(form1.business,this)"  id="CHECKBOX" type="CHECKBOX" value="Photographer">Photographer
        <input name="business2"   onclick="faddtype(form1.business,this)"  id="CHECKBOX" type="CHECKBOX" value="Camera Operator">Camera Operator
          <input name="business3"  onclick="faddtype(form1.business,this)"   id="CHECKBOX" type="CHECKBOX" value="Technician">Technician<br />
	<input  name="business4"  onclick="faddtype(form1.business,this)"   id="CHECKBOX" type="CHECKBOX" value="Journalist(TV, Radio, Print)">Journalist(TV, Radio, Print)<br />
     Others (please specify)<input class="edit_input"  name="business" value="<%=obj.getBusiness()%>" type="text" >*
    </td>
  </tr>
  <tr>
    <td class="biaoti"> 12.Applicant TEL </td>
    <td><input class="edit_input"  type=text  value="<%=obj.getPhone()%>" name=phone>*</td>
    <td class="biaoti"> Applicant FAX </td>
    <td><input class="edit_input"  value="<%=obj.getFax()%>"  type=text name=fax >*</td>
  </tr>
  <tr>
    <td class="biaoti"> 13.Applicant E-mail </td>
    <td colspan="3"><input class="edit_input"  type=text name=email value="<%=obj.getEmail()%>" >*</td>
  </tr>
  <tr>
    <td class="biaoti" rowspan="6"> 14.Organization Information </td>
    <td> Name of Organization </td>
    <td colspan="2"><input class="edit_input"  name="organise" value="<%=obj.getOrganise()%>" type="text" >*</td>
  </tr>
  <tr>
    <td> Type of Organization </td>
    <td colspan="2">
<input   name="type1"  id="CHECKBOX" type="CHECKBOX" onclick="faddtype(form1.type,this)" value="Newspaper">Newspaper
  <input   name="type2"  id="CHECKBOX" type="CHECKBOX" onclick="faddtype(form1.type,this)"  value="Magazine">Magazine
    <input   name="type3"  id="CHECKBOX" type="CHECKBOX" onclick="faddtype(form1.type,this)"  value="TV">TV<br />
<input   name="type4"  id="CHECKBOX" type="CHECKBOX" onclick="faddtype(form1.type,this)"  value="Radio">Radio
  <input   name="type5"  id="CHECKBOX" type="CHECKBOX" onclick="faddtype(form1.type,this)"  value="Photo Agency">Photo Agency <br />
<input   name="type6"  id="CHECKBOX" type="CHECKBOX" onclick="faddtype(form1.type,this)"  value="Wire Service">Wire Service<br />
Others (please specify)<input class="edit_input"  type="text" name="type"  value="<%=obj.getType()%>"  >*

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
    <td colspan="2"><input class="edit_input"  type=text name=oaddress value="<%=obj.getOaddress()%>" >*</td>
  </tr>
  <tr>
    <td> Organization TEL </td>
    <td colspan="2"><input class="edit_input"   name="ophone" value="<%=obj.getOphone()%>" type="text" >*</td>
  </tr>
  <tr>
    <td> Organization FAX </td>
    <td colspan="2"><input class="edit_input"  name="ofax"  value="<%=obj.getOfax()%>" type="text" >*</td>
  </tr>
  <tr>
    <td> Organization E-mail </td>
    <td colspan="2"><input class="edit_input"  type="text"  value="<%=obj.getOemail()%>" name="oemail" >*</td>
  </tr>
  <tr>
    <td class="biaoti" rowspan="8"> 15.Arrival/departure details </td>
    <td> Dateof arrival </td>
    <td colspan="2"> Time of arrival </td>
  </tr>
  <tr>
    <td>
      <input class="edit_input"  type="text"  name="arrivaldate" value="<%=getNull(obj.getArrivalDate())%>">
    </td>
    <td colspan="2"><input class="edit_input"  type="text"  name="arrivaltime" value="<%=getNull(obj.getArrivalTime())%>"></td>
  </tr>
  <tr>
    <td> Portof Arrival </td>
    <td colspan="2"> Arrival flight No. </td>
  </tr>
  <tr>
    <td><input class="edit_input"  type=text name=arrivalflight value="<%=obj.getArrivalFlight()%>" ></td>
    <td colspan="2"><input class="edit_input"  type=text name=arrivaltrain value="<%=obj.getArrivalTrain()%>" ></td>
  </tr>
  <tr>
    <td> Date of departure </td>
    <td colspan="2"> Time of departure </td>
  </tr>
  <tr>
    <td>
      <input class="edit_input"  type="text"  name="leavedate" value="<%=getNull(obj.getLeaveDate())%>">
    </td>
    <td colspan="2"><input class="edit_input"  type="text"  name="leavetime" value="<%=getNull(obj.getLeaveTime())%>"></td>
  </tr>
  <tr>
    <td> Port of departure </td>
    <td colspan="2"> Departure flight No. </td>
  </tr>
  <tr>
    <td><input class="edit_input"  type=text name=leaveflight value="<%=obj.getLeaveFlight()%>" ></td>
    <td colspan="2"><input class="edit_input"  type=text name=leavetrain value="<%=obj.getLeaveTrain()%>" ></td>
  </tr>
  <tr>
    <td class="biaoti">16.Airport pick-up </td>
    <td> Yes
    <input  name="welcome" checked="checked"  id="radio" type="radio" value="yes"></td>
    <td colspan="2"> No
    <input name="welcome" <%=getCheck(obj.getWelcome().equals("no"))%>  id="radio" type="radio" value="no"></td>
  </tr>
  <tr>
    <td class="biaoti">17.Remark </td>
    <td colspan="3"><textarea name="remark" cols="50" rows="7" ><%=obj.getRemark()%></textarea></td>
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
  </tr><tr>
    <td colspan="4">attach resume and other documents:
      <input class="edit_button" name="button" type="button" onClick="window.open('/jsp/type/gazetteer/GazetteerUp.jsp?Type=61')"  value="attach resume and other documents"/> </td>
  </tr>
</table>
  <p align="center">
         <input  type=SUBMIT name="GoFinish"   ID="edit_GoFinish" class="edit_button" value="<%=r.getString(teasession._nLanguage, "Finish")%>">
		   <div id="head6"><img height="6" src="about:blank"></div>
</BODY></html>

