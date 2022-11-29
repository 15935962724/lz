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
<h1><%=r.getString(teasession._nLanguage, "ERegistr")%><%=r.getString(teasession._nLanguage, "EDit")%></h1>
  <div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" action="/servlet/EditERegister" method=post onSubmit="return(submitText(this.name, '<%=r.getString(teasession._nLanguage, "InvalidSubject")%>'))">
   <%
   String parameter=teasession.getParameter("nexturl");
   boolean   parambool=(parameter!=null&&!parameter.equals("null"));
   ERegister obj=ERegister.find(0,teasession._nLanguage);
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
   {subject=node.getSubject(teasession._nLanguage);
   obj=ERegister.find(teasession._nNode,teasession._nLanguage);
   issueDate=node.getTime();
 }
    %>
          <INPUT TYPE="hidden" NAME="TypeAlias" VALUE="<%=request.getParameter("TypeAlias")%>">
 <input type="hidden" name="node" value="<%=teasession._nNode%>">
          <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
            <tr>
              <td valign="top">1. Surnames</td>
              <td colspan="10" valign="top"><input type="text" name="name"  value="<%=subject%>" class="text"></td>
            </tr>
            <tr>
              <td valign="top">2. First and middle names
              <td colspan="10" valign="top"><input type="text" name="middle" value="<%=getNull(obj.getMiddle())%>" class="text"></td>
            </tr>
            <tr>
              <td valign="top">3. Gender
              <td colspan="2" valign="top"><input  id="radio" type="radio"  checked="checked" name="sex" value="male"/>male<input   id="radio" type="radio" <%=getCheck("female".equals(obj.getSex()))%>  name="sex" value="female" />female</td>
              <td colspan="7" valign="top">4. Date of birth (mm-dd-yyyy) </td>
              <td valign="top"><input name="birthday" readonly="readonly" value="<%=obj.getBirthday("yyyy-MM-dd")%>"/><input type="button" value="..." onclick="td_calendar('form1.birthday')"/></td>
            </tr>
            <tr>
              <td valign="top">5. Nationality</td>
              <td colspan="2" valign="top"><input type="text" name="nationality" value="<%=getNull(obj.getNationality())%>" class="text"></td><!-- 国籍 -->
              <td colspan="7" valign="top">6. Blood type</td>
              <td valign="top"><select name=blood>
    <option value="A">A</option>
    <option value="B" <%=getSelect("B".equals(obj.getBlood()))%>>B</option>
    <option value="AB" <%=getSelect("AB".equals(obj.getBlood()))%>>AB</option>
    <option value="O"<%=getSelect("O".equals(obj.getBlood()))%>>O</option>
  </select>
              </td>
            </tr>
            <tr>
              <td valign="top">7. Passport number</td>
              <td colspan="2" valign="top"><input type=text  value="<%=obj.getCardNum()%>" name=cardNum></td>
              <td colspan="7" valign="top">8. Expiration date</td>
              <td valign="top"><input type="text" name="expiration" value="<%=getNull(obj.getExpiration())%>" class="text"></td>
            </tr>
            <tr>
              <td valign="top">9. Place of birth</td>
              <td colspan="10" valign="top"><input type=text name=job value="<%=obj.getJob()%>" ></td>
            </tr>
            <tr>
              <td valign="top">10. Organization/Company</td>
              <td colspan="10" valign="top"><input type=text name=workPlace value="<%=obj.getWorkPlace()%>" ></td>
            </tr>
            <tr>
              <td valign="top">11. Position</td>
              <td colspan="2" valign="top"><input type=text name=address value="<%=obj.getAddress()%>" ></td>
              <td colspan="7" valign="top">12. Email</td>
              <td  valign="top"><input type=text name=email value="<%=obj.getEmail()%>" ></td>
            </tr>
            <tr>
              <td valign="top">13. Address of the organization/company</td>
              <td colspan="2" valign="top"><input type=text name=address value="<%=obj.getAddress()%>" ></td>
              <td colspan="7" valign="top">14.Postal Code</td>
              <td valign="top"><input type="text" name="postal" class="text" value="<%=getNull(obj.getPostal())%>"></td>
            </tr>
            <tr>
              <td valign="top">15.Business phone number</td>
              <td colspan="2" valign="top"><input type=text  value="<%=obj.getPhone()%>" name=phone></td>
              <td colspan="7" valign="top">16.Business fax number</td>
              <td  valign="top"><input value="<%=obj.getFax()%>"  type=text name=fax ></td>
            </tr>
            <tr>
              <td valign="top">17.Mobile phone
              <td colspan="2" valign="top"><input value="<%=obj.getMobile()%>"  type=text name=mobile></td>
              <td colspan="7" valign="top">18.Place to apply visa</td>
              <td  valign="top"><input type="text" name="place"  value="<%=getNull(obj.getPlace())%>" class="text"></td>
            </tr>
            <tr>
              <td rowspan="8" valign="top">19.Arrival/departure details</td>
              <td colspan="4" valign="top">Dateof arrival</td>
              <td colspan="6" valign="top">Time of arrival</td>
            </tr>
            <tr>
              <td valign="top" colspan="4"><input type=text value="<%=obj.getRichDate()%>"  name=richDate></td>
              <td colspan="6" valign="top"><input type=text name=richtime value="<%=obj.getRichTime()%>" ></td>
            </tr>
            <tr>
              <td valign="top" colspan="4">Port of Arrival</td>
              <td colspan="6" valign="top">Arrival flight No.</td>
            </tr>
            <tr>
              <td valign="top" colspan="4"><input type=text name=flightNum value="<%=obj.getFlightNum()%>" ></td>
              <td colspan="6" valign="top"><input type=text name=trainNum value="<%=obj.getTrainNum()%>" ></td>
            </tr>
            <tr>
              <td valign="top" colspan="4">Date of departure</td>
              <td colspan="6" valign="top">Time of departure</td>
            </tr>
            <tr>
              <td valign="top" colspan="4"><input type="text" value="<%=getNull(obj.getDeparturedate())%>" name="departuredate" class="text"></td>
              <td colspan="6" valign="top"><input type="text"  value="<%=getNull(obj.getDeparturetime())%>"  name="departuretime" class="text"></td>
            </tr>
            <tr>
              <td valign="top" colspan="4">Port of departure</td>
              <td colspan="6" valign="top">Departure flight No.</td>
            </tr>
            <tr>
              <td valign="top" colspan="4"><input type="text"  value="<%=getNull(obj.getDepartureflight())%>"  name="departureflight" class="text"></td>
              <td colspan="6" valign="top"><input type="text"   value="<%=getNull(obj.getDeparturetrain())%>" name="departuretrain" class="text"></td>
            </tr>
            <tr>
              <td valign="top">20.Airport pick-up
              <td colspan="5" valign="top">Yes
                <input  id="radio" type="radio" name=welcome value="yes" checked="checked">
              </td>
              <td colspan="5" valign="top">No
                    <input  id="radio" type="radio" name=welcome value="no" <%=getCheck("no".equals(obj.getWelcome()))%>></td>
            </tr>
            <tr>
              <td rowspan="2" valign="top">21.Submit document</td>
              <td rowspan="2" valign="top">
              <input type="button"  value="上传" onclick="window.open('/jsp/type/gazetteer/GazetteerUp.jsp?Type=59')"/>
              </td>
            </tr>
            <tr>
              <td colspan="2" valign="top">Title</td>
              <td colspan="7" valign="top"><%java.util.Enumeration enumer=tea.entity.node.Conference.findByCommunity(node.getCommunity());while(enumer.hasMoreElements())
{String value=tea.entity.node.Conference.find(((Integer)enumer.nextElement()).intValue()).getEname();
  %>
<span><input  id="CHECKBOX" type="CHECKBOX" name="subject" value="<%=value%>" /><%=value%></span>
<%  }%></td>
            </tr>
            <tr>
              <td rowspan="3" valign="top">22.Group discussion</td>
              <td valign="top"></td>
              <td colspan="4" valign="top"></td>
              <td colspan="3" valign="top"></td>
              <td colspan="2" valign="top"></td>
            </tr>
            <tr>
              <td valign="top"></td>
              <td colspan="4" valign="top"></td>
              <td colspan="3" valign="top"></td>
              <td colspan="2" valign="top"></td>
            </tr>
            <tr>
              <td valign="top"></td>
              <td colspan="4" valign="top"></td>
              <td colspan="3" valign="top"></td>
              <td colspan="2" valign="top"></td>
            </tr>
            <tr>
              <td valign="top">23.Remark</td>
              <td colspan="10" valign="top"><textarea  cols=20 rows=10 name=addition><%=obj.getAddition()%></textarea></td>
            </tr>
            <tr>
              <td valign="top">24.Famulus information</td>
              <td colspan="10"><textarea cols=20 rows=10 name=employee><%=obj.getEmployee()%></textarea></td>
            </tr>
          </table>
          <p align="center">
            <input type="button" class="button" value="hold" />
            <input type="submit" class="button" value="submit" />
          <p>attention: if you are not able to send the form on line, please <a href="/tea/image/section/Application.doc" style="color:red;">download this form</a> and fax to us.</p>
        </LI>
<p align="center">
         <input type=SUBMIT name="GoFinish"   ID="edit_GoFinish" class="edit_button" value="<%=r.getString(teasession._nLanguage, "Finish")%>">
        </form>
      </ul>
      <div id="searh"></div>
    </DIV>
  </DIV>
</DIV>
 <div id="head6"><img height="6" src="about:blank"></div>
</BODY>
</html>

