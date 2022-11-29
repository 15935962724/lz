<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>

<html>
<head>
<script src="/tea/tea.js" type="text/javascript"></script>
          <script>
function td_calendar(fieldname)
{
  myleft=document.body.scrollLeft+event.clientX-event.offsetX-80;
  mytop=document.body.scrollTop+event.clientY-event.offsetY+140;
  window.showModalDialog("/tea/inc/calendar.jsp?FIELDNAME="+fieldname,self,"edge:raised;scroll:0;status:0;help:0;resizable:1;dialogWidth:280px;dialogHeight:205px;dialogTop:"+mytop+"px;dialogLeft:"+myleft+"px");
}
        </script>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "Register")%><%=r.getString(teasession._nLanguage, "Edit")%></h1>
  <div id="head6"><img height="6" src="about:blank"></div>

<div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%> </div>
<form name="form1" action="/servlet/EditRegister" method=post onSubmit="return(submitText(this.name, '<%=r.getString(teasession._nLanguage, "InvalidSubject")%>')&&submitText(this.birthday  , '<%=r.getString(teasession._nLanguage, "InvalidParameter")%>')&&submitText(this.cardType  , '<%=r.getString(teasession._nLanguage, "InvalidParameter")%>')&&submitText(this.cardNum  , '<%=r.getString(teasession._nLanguage, "InvalidParameter")%>')&&submitText(this.workPlace, '<%=r.getString(teasession._nLanguage, "InvalidParameter")%>')&&submitText(this.job      , '<%=r.getString(teasession._nLanguage, "InvalidParameter")%>')&&submitText(this.email    , '<%=r.getString(teasession._nLanguage, "InvalidParameter")%>')&&submitText(this.address  , '<%=r.getString(teasession._nLanguage, "InvalidParameter")%>')&&submitText(this.phone    , '<%=r.getString(teasession._nLanguage, "InvalidParameter")%>')&&submitText(this.fax      , '<%=r.getString(teasession._nLanguage, "InvalidParameter")%>')&&submitText(this.mobile   , '<%=r.getString(teasession._nLanguage, "InvalidParameter")%>'))">
  <%
   String parameter=teasession.getParameter("nexturl");
   boolean   parambool=(parameter!=null&&!parameter.equals("null"));
   Register obj=Register.find(0,teasession._nLanguage);
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
   obj=Register.find(teasession._nNode,teasession._nLanguage);
   issueDate=node.getTime();
 }
    %>
  <INPUT TYPE="hidden" NAME="TypeAlias" VALUE="<%=request.getParameter("TypeAlias")%>">
  <input type="hidden" name="node" value="<%=teasession._nNode%>">
 <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td> 1.姓名:***
        <input type=text name=name value="<%=subject%>"></td>
      <td>2.性别:***
        <select name=sex>
          <option value="男" selected="selected">男</option>
          <option value="女"<%=obj.getSex().equals("女")%>>女</option>
        </select></td>
    </tr>
    <tr>
      <td> 3.出生日期:***<input name="birthday" readonly="readonly" value="<%=obj.getBirthday("yyyy-MM-dd")%>"/><input type="button" value="..." onclick="td_calendar('form1.birthday')"/></td>
      <td>4.血型: ***
        <select name=blood>
          <option value="A">A</option> <option value="B" <%=getSelect("B".equals(obj.getBlood()))%>>B</option>
          <option value="AB" <%=getSelect("AB".equals(obj.getBlood()))%>>AB</option>
          <option value="O"<%=getSelect("O".equals(obj.getBlood()))%>>O</option>
        </select>
</td>
    </tr>
    <tr>
      <td>5.证件类型:***
        <input value="<%=obj.getCardType()%>" type=text name=cardType></td>
      <td>6.证件号码:***
        <input type=text  value="<%=obj.getCardNum()%>" name=cardNum>
        ***</td>
    </tr>
    <tr>
      <td colspan="2">7.工作单位:
        <input type=text name=workPlace value="<%=obj.getWorkPlace()%>" ></td>

    </tr>
    <tr>
      <td>8.职务:
        <input type=text name=job value="<%=obj.getJob()%>" ></td>
      <td>9.电子邮箱: ***
        <input type=text name=email value="<%=obj.getEmail()%>" ></td>
    </tr>
    <tr>
      <td colspan="2">10.单位地址/邮编:
        <input type=text name=address value="<%=obj.getAddress()%>" ></td>

    </tr>
    <tr>
      <td> 11.电话:
        <input type=text  value="<%=obj.getPhone()%>" name=phone></td>
      <td>12.传真:
        <input value="<%=obj.getFax()%>"  type=text name=fax ></td>
    </tr>
    <tr>
      <td>13.手机:***
        <input value="<%=obj.getMobile()%>"  type=text name=mobile></td>
    </tr>
    <tr>
      <td> 14.到京日期:
        <input type=text value="<%=obj.getRichDate()%>"  name=richDate></td>
      <td>15.到京时间:
        <input type=text name=richTime value="<%=obj.getRichTime()%>" ></td>
      /tr>
    <tr>
      <td>16.到京航班:***
        <input type=text name=flightNum value="<%=obj.getFlightNum()%>" ></td>
      <td>17.到京车次:***
        <input type=text name=trainNum value="<%=obj.getTrainNum()%>" ></td>
      </tr>
                <tr>
            <td>离京日期</td>
            <td colspan="2">离京时间</td>
          </tr>
          <tr>
            <td>
            <input type="text" name="leavedata" class="text" value="<%=getNull(obj.getLeaveDate())%>"></td>
              <td colspan="2"><input type="text" name="leavetime" class="text" value="<%=getNull(obj.getLeaveTime())%>"></td>
          </tr>
          <tr>
            <td>航班班次</td>
            <td colspan="2">火车车次</td>
          </tr>
          <tr>
            <td><input type=text name=leaveflight value="<%=getNull(obj.getLeaveFlight())%>" ></td>
              <td colspan="2"><input type=text name=leavetrain value="<%=getNull(obj.getLeaveTrain())%>" ></td>
          </tr>
    <tr>
      <td>18.机场送迎:*** </td>
      <td><input  id="radio" type="radio" name=welcome value="需要" checked="checked">
        需要
        <input  id="radio" type="radio" name=welcome value="不需要" <%=getCheck("不需要".equals(obj.getWelcome()))%>>
        不需要</td>
    </tr>
    <tr>
      <td>19.请选择参加的分议题讨论:***</td>
      <td><!--select name=subject>
<option value="subject1">题目一</option>
<option value="subject2">题目二</option>
<option value="subject3">题目三</option>
</select>-->
        <%java.util.Enumeration enumer=tea.entity.node.Conference.findByCommunity(node.getCommunity());while(enumer.hasMoreElements())
{String value=tea.entity.node.Conference.find(((Integer)enumer.nextElement()).intValue()).getName();
  %>
        <span><input  id="CHECKBOX" type="CHECKBOX" name="subject" value="<%=value%>" />
        <%=value%> </span>
        <%  }%>
          </tr>
    <tr>
      <td>20.备注：</td>
      <td><textarea  cols=20 rows=10 name=addition><%=obj.getAddition()%></textarea></td>
    <tr>
    <tr>
      <td>21.随行人员姓名</td>
      <td><textarea cols=20 rows=10 name=employee><%=obj.getEmployee()%></textarea></td>
    </tr>
    <tr>
      <td  height="2">文件:
        <input type="button"  value="上传" onclick="window.open('/jsp/type/gazetteer/GazetteerUp.jsp?Type=58')"/> </td>
      <td>&nbsp;</td>
    </tr>
  </table>
  <p align="center">
    <input type=SUBMIT name="GoNext" id="edit_GoNext" class="edit_button" value="<%=r.getString(teasession._nLanguage, "CBNext")%>" <%out.print(" style=visibility:hidden ");%>>
    <input type=SUBMIT name="GoFinish"   ID="edit_GoFinish" class="edit_button" value="<%=r.getString(teasession._nLanguage, "Finish")%>">
</form>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>

