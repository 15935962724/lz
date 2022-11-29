<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>

<%
tea.db.DbAdapter dbadapter=new tea.db.DbAdapter();
try
{
dbadapter.executeQuery("SELECT Node.node,type FROM Node WHERE finished=1 AND (type=58 OR type=60 OR type=61)AND rcreator="+dbadapter.cite(teasession._rv._strR)+" AND vcreator="+dbadapter.cite(teasession._rv._strV));
if(dbadapter.next())
{
    out.print(new tea.html.Script("if(confirm('您已经申请了其它的报名,如果在此申请报名,则系统会自动删除其它的报名.是否继续?')){window.open('/servlet/DeleteNode?node="+(dbadapter.getInt(1))+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString())+"', '_self');}else{history.back();}"));
    return;
}else
  {
    dbadapter.executeQuery("SELECT Node.node FROM Node WHERE Node.type=59 AND rcreator="+dbadapter.cite(teasession._rv._strR)+" AND vcreator="+dbadapter.cite(teasession._rv._strV));
      if(dbadapter.next()&&request.getRequestURI().startsWith("/servlet/"))
    {
  out.print(new tea.html.Script("window.open('/jsp/type/"+tea.entity.node.Node.NODE_TYPE[59].toLowerCase()+"/21shijiEdit"+tea.entity.node.Node.NODE_TYPE[59]+".jsp?node="+dbadapter.getInt(1)+"','_self');"));
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
</style>    <script>
function td_calendar(fieldname)
{
  myleft=document.body.scrollLeft+event.clientX-event.offsetX-80;
  mytop=document.body.scrollTop+event.clientY-event.offsetY+140;
  window.showModalDialog("/tea/inc/calendar.jsp?FIELDNAME="+fieldname,self,"edge:raised;scroll:0;status:0;help:0;resizable:1;dialogWidth:280px;dialogHeight:205px;dialogTop:"+mytop+"px;dialogLeft:"+myleft+"px");
}
        </script>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "21shijiEditERegister")%></h1>
  <div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" action="/servlet/EditERegister" method=post onSubmit="return(submitText(this.name, '<%=r.getString(teasession._nLanguage, "InvalidSubject")%>')&&submitText(this.middle, 'First and middle names')&&submitText(this.birthday, 'Date of birth (mm-dd-yyyy)')&&submitText(this.nationality, 'Nationality')&&submitText(this.cardNum, 'Passport number')&&submitText(this.expiration, 'Expiration date')&&submitText(this.job, 'Place of birth')&&submitText(this.workPlace, 'Organization/Company')&&submitText(this.address, 'Position')&&submitText(this.email, 'Email')&&submitText(this.address, 'Address of the organization/company')&&submitText(this.postal, 'Postal Code')&&submitText(this.phone, 'Business phone number')&&submitText(this.fax, 'Business fax number')&&submitText(this.mobile, 'Mobile phone')&&submitText(this.place, 'Place to apply visa'))">
  <%
   String parameter=teasession.getParameter("nexturl");
   boolean   parambool=(parameter!=null&&!parameter.equals("null"));
   ERegister obj=ERegister.find(0,teasession._nLanguage);
   if(parambool)
   out.print("<input   type='hidden' name=nexturl value="+parameter+">");
   String subject="";
   Date issueDate=null;
   if(request.getParameter("NewNode")!=null)
   {
     out.println("<input   TYPE=hidden NAME=NewNode VALUE=ON>");
   }else
   if(request.getParameter("NewBrother")!=null)
   {
     out.println("<input    TYPE=hidden NAME=NewBrother VALUE=ON>");
   }else
   {subject=node.getSubject(teasession._nLanguage);
   obj=ERegister.find(teasession._nNode,teasession._nLanguage);
   issueDate=node.getTime();
 }
    %>
  <input  class="edit_input"  TYPE="hidden" NAME="TypeAlias" VALUE="<%=request.getParameter("TypeAlias")%>">
  <input  class="edit_input"  type="hidden" name="node" value="<%=teasession._nNode%>">
 <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td valign="top" class="biaoti">1. Surnames</td>
      <td colspan="3" valign="top"><input  class="edit_input"  type="text" name="name"  value="<%=subject%>" >*</td>
    </tr>
    <tr>
      <td valign="top" class="biaoti">2. First and middle names
      <td colspan="3" valign="top"><input  class="edit_input"  type="text" name="middle" value="<%=getNull(obj.getMiddle())%>" >*</td>
    </tr>
    <tr>
      <td valign="top" class="biaoti">3. Gender
      <td  valign="top"><input   id="radio" type="radio"  checked="checked" name="sex" value="male"/>
        male
        <input   id="radio" type="radio" <%=getCheck("female".equals(obj.getSex()))%>  name="sex" value="female" />
        female *</td>
      <td valign="top" class="biaoti">4. Date of birth (mm-dd-yyyy) </td>
      <td valign="top"><input name="birthday" class="edit_input"  readonly="readonly" value="<%=obj.getBirthday("yyyy-MM-dd")%>"/><input type="button" class="edit_input"  value="..." onclick="td_calendar('form1.birthday')"/>*</td>
    </tr>
    <tr>
      <td valign="top" class="biaoti">5. Nationality</td>
      <td  valign="top"><input  class="edit_input"  type="text" name="nationality" value="<%=getNull(obj.getNationality())%>" >*</td>
      <!-- 国籍 -->
      <td  valign="top" class="biaoti">6. Blood type</td>
      <td valign="top"><select name=blood>
          <option value="A">A</option><option value="B" <%=getSelect("B".equals(obj.getBlood()))%>>B</option>
          <option value="AB" <%=getSelect("AB".equals(obj.getBlood()))%>>AB</option>
          <option value="O"<%=getSelect("O".equals(obj.getBlood()))%>>O</option>
        </select> </td>
    </tr>
    <tr>
      <td valign="top" class="biaoti">7. Passport number</td>
      <td  valign="top"><input  class="edit_input"  type=text  value="<%=obj.getCardNum()%>" name=cardNum>*</td>
      <td  valign="top" class="biaoti">8. Expiration date</td>
      <td valign="top"><input  class="edit_input"  type="text" name="expiration" value="<%=getNull(obj.getExpiration())%>" >*</td>
    </tr>
    <tr>
      <td valign="top" class="biaoti">9. Place of birth</td>
      <td colspan="3" valign="top"><input  class="edit_input"  type=text name=job value="<%=obj.getJob()%>" >*</td>
    </tr>
    <tr>
      <td valign="top" class="biaoti">10. Organization/Company</td>
      <td colspan="3" valign="top"><input  class="edit_input"  type=text name=workPlace value="<%=obj.getWorkPlace()%>" >*</td>
    </tr>
    <tr>
      <td valign="top" class="biaoti">11. Position</td>
      <td  valign="top"><input  class="edit_input"  type=text name=address value="<%=obj.getAddress()%>" >*</td>
      <td  valign="top" class="biaoti">12. Email</td>
      <td  valign="top"><input  class="edit_input"  type=text name=email value="<%=obj.getEmail()%>" >*</td>
    </tr>
    <tr>
      <td valign="top" class="biaoti">13. Address of the organization/company</td>
      <td  valign="top"><input  class="edit_input"  type=text name=address value="<%=obj.getAddress()%>" >*</td>
      <td  valign="top" class="biaoti">14.Postal Code</td>
      <td valign="top"><input  class="edit_input"  type="text" name="postal"  value="<%=getNull(obj.getPostal())%>">*</td>
    </tr>
    <tr>
      <td valign="top" class="biaoti">15.Business phone number</td>
      <td  valign="top"><input  class="edit_input"  type=text  value="<%=obj.getPhone()%>" name=phone>*</td>
      <td  valign="top" class="biaoti">16.Business fax number</td>
      <td  valign="top"><input  class="edit_input"  value="<%=obj.getFax()%>"  type=text name=fax >*</td>
    </tr>
    <tr>
      <td valign="top" class="biaoti">17.Mobile phone
      <td  valign="top"><input  class="edit_input"  value="<%=obj.getMobile()%>"  type=text name=mobile>*</td>
      <td  valign="top" class="biaoti">18.Place to apply visa</td>
      <td  valign="top"><input  class="edit_input"  type="text" name="place"  value="<%=getNull(obj.getPlace())%>" >*</td>
    </tr>
    <tr>
      <td rowspan="8" valign="top" class="biaoti">19.Arrival/departure details</td>
      <td  valign="top">Dateof arrival</td>
      <td colspan="2" valign="top">Time of arrival</td>
    </tr>
    <tr>
      <td valign="top" ><input  class="edit_input"  type=text value="<%=obj.getRichDate()%>"  name=richDate></td>
      <td  valign="top"  colspan="2" ><input  class="edit_input"  type=text name=richtime value="<%=obj.getRichTime()%>" ></td>
    </tr>
    <tr>
      <td valign="top" >Port of Arrival</td>
      <td  valign="top"  colspan="2" >Arrival flight No.</td>
    </tr>
    <tr>
      <td valign="top" ><input  class="edit_input"  type=text name=flightNum value="<%=obj.getFlightNum()%>" ></td>
      <td  valign="top"  colspan="2" ><input  class="edit_input"  type=text name=trainNum value="<%=obj.getTrainNum()%>" ></td>
    </tr>
    <tr>
      <td valign="top" >Date of departure</td>
      <td  valign="top"  colspan="2" >Time of departure</td>
    </tr>
    <tr>
      <td valign="top" ><input  class="edit_input"  type="text" value="<%=getNull(obj.getDeparturedate())%>" name="departuredate" ></td>
      <td  valign="top"  colspan="2" ><input  class="edit_input"  type="text"  value="<%=getNull(obj.getDeparturetime())%>"  name="departuretime" ></td>
    </tr>
    <tr>
      <td valign="top" >Port of departure</td>
      <td  valign="top"  colspan="2" >Departure flight No.</td>
    </tr>
    <tr>
      <td valign="top" ><input  class="edit_input"  type="text"  value="<%=getNull(obj.getDepartureflight())%>"  name="departureflight" ></td>
      <td  valign="top"  colspan="2" ><input  class="edit_input"  type="text"   value="<%=getNull(obj.getDeparturetrain())%>" name="departuretrain" ></td>
    </tr>
    <tr>
      <td valign="top" class="biaoti">20.Airport pick-up
      <td valign="top">Yes
        <input   id="radio" type="radio" name=welcome value="yes" checked="checked"> </td>
      <td valign="top" colspan="2">No
        <input   id="radio" type="radio" name=welcome value="no" <%=getCheck("no".equals(obj.getWelcome()))%>></td>
    </tr>
    <tr>
      <td valign="top" class="biaoti">21.Title</td>
      <td colspan="3" valign="top"><%java.util.Enumeration enumer=tea.entity.node.Conference.findByCommunity(node.getCommunity());while(enumer.hasMoreElements())
{String value=tea.entity.node.Conference.find(((Integer)enumer.nextElement()).intValue()).getEname();
  %>
        <input   id="CHECKBOX" type="CHECKBOX" name="subject" value="<%=value%>" /><%=value%>
        <%  }%></td>
    </tr>

    <tr>
      <td valign="top" class="biaoti">22.Remark</td>
      <td colspan="11" valign="top"><textarea  cols=55 rows=5 name=addition><%=obj.getAddition()%></textarea></td>
    </tr>
    <tr>
      <td valign="top" class="biaoti">23.Famulus information</td>
      <td colspan="11" valign="top"><textarea cols=55 rows=5 name=employee><%=obj.getEmployee()%></textarea></td>
    </tr>
    <tr>
      <td valign="top" colspan="4">24. attach resume and other documents
        <input  class="edit_button"  name="button" type="button" onClick="window.open('/jsp/type/gazetteer/GazetteerUp.jsp?Type=59')"  value="attach resume and other documents"/> </td>
    </tr>
  </table>
  <p align="center">
    <input type=SUBMIT name="GoFinish"   ID="edit_GoFinish" class="edit_button" value="<%=r.getString(teasession._nLanguage, "Finish")%>">
</form>
<div id="head6"><img height="6" src="about:blank"></div>
</BODY>
</html>

