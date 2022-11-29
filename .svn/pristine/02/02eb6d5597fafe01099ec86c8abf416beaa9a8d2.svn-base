<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%><%
tea.db.DbAdapter dbadapter=new tea.db.DbAdapter();
try
{
  dbadapter.executeQuery("SELECT Node.node,type FROM Node WHERE finished=1 AND (type=59 OR type=60 OR type=61)AND rcreator="+dbadapter.cite(teasession._rv._strR)+" AND vcreator="+dbadapter.cite(teasession._rv._strV));
  if(dbadapter.next())
  {
    out.print(new tea.html.Script("if(confirm('您已经申请了其它的报名,如果在此申请报名,则系统会自动删除其它的报名.是否继续?')){window.open('/servlet/DeleteNode?node="+(dbadapter.getInt(1))+"&nexturl="+java.net.URLDecoder.decode(request.getRequestURI()+"?"+request.getQueryString())+"', '_self');}else{history.back();}"));
    return;
  }else
  {
    dbadapter.executeQuery("SELECT Node.node FROM Node WHERE Node.type=58 AND rcreator="+dbadapter.cite(teasession._rv._strR)+" AND vcreator="+dbadapter.cite(teasession._rv._strV));
    if(dbadapter.next()&&request.getRequestURI().startsWith("/servlet/"))
    {
  out.print(new tea.html.Script("window.open('/jsp/type/"+tea.entity.node.Node.NODE_TYPE[58].toLowerCase()+"/21shijiEdit"+tea.entity.node.Node.NODE_TYPE[58]+".jsp?node="+dbadapter.getInt(1)+"','_self');"));
      return;
    }
  }
}catch (Exception ex)
{
  ex.printStackTrace();
}finally
{
  dbadapter.close();
}
%>
<html>
<head>
<SCRIPT SRC="/tea/tea.js" type="text/javascript"></SCRIPT>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">


       <script>
function td_calendar(fieldname)
{
  myleft=document.body.scrollLeft+event.clientX-event.offsetX-80;
  mytop=document.body.scrollTop+event.clientY-event.offsetY+140;
  window.showModalDialog("/tea/inc/calendar.jsp?FIELDNAME="+fieldname,self,"edge:raised;scroll:0;status:0;help:0;resizable:1;dialogWidth:280px;dialogHeight:205px;dialogTop:"+mytop+"px;dialogLeft:"+myleft+"px");
}
        </script>
<style type="text/css">
<!--
* {	font-size: 9pt;
	color: #000000;
	text-decoration: none;
}

.biaoti {
	background-color: #EFF0F4;color:#276A97
}
.style1 {color: #FF0000}

-->
</style>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "21shijiEditRegister")%></h1>
  <div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" action="/servlet/EditRegister" method=post onSubmit="return(submitText(this.name, '<%=r.getString(teasession._nLanguage, "InvalidSubject")%>')&&submitText(this.birthday  , '无效出生日期')&&submitText(this.cardType  , '无效证件类型')&&submitText(this.cardNum  , '无效证件号码')&&submitText(this.workPlace, '无效工作单位')&&submitText(this.job      , '无效职务')&&submitText(this.email    , '无效电子邮箱')&&submitText(this.address  , '无效单位地址/邮编')&&submitText(this.phone    , '无效电话')&&submitText(this.fax      , '无效传真')&&submitText(this.mobile   , '无效手机'))">
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
   {
   subject=node.getSubject(teasession._nLanguage);
   obj=Register.find(teasession._nNode,teasession._nLanguage);
   issueDate=node.getTime();
 }
    %>
  <INPUT TYPE="hidden" NAME="TypeAlias" VALUE="<%=request.getParameter("TypeAlias")%>">
  <input type="hidden" name="node" value="<%=teasession._nNode%>">
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td> 1.姓名:</td>
      <td ><input class="edit_input" type=text name=name value="<%=subject%>">*</td>
      <td>2.性别:</td>
      <td><select name=sex>
        <option value="男" selected="selected">男</option>
        <option value="女"<%=obj.getSex().equals("女")%>>女</option>
      </select>*</td>
    </tr>
    <tr>
      <td> 3.出生日期:</td>
      <td><input name="birthday" class="edit_input" readonly="readonly" value="<%=obj.getBirthday("yyyy-MM-dd")%>"/><input class="edit_input" type="button" value="..." onclick="td_calendar('form1.birthday')"/>*</td>
      <td>4.血型: </td>
      <td><select name=blood>
        <option value="A">A</option><option value="B" <%=getSelect("B".equals(obj.getBlood()))%>>B</option>
        <option value="AB" <%=getSelect("AB".equals(obj.getBlood()))%>>AB</option>
        <option value="O"<%=getSelect("O".equals(obj.getBlood()))%>>O</option>
      </select></td>
    </tr>
    <tr>
      <td>5.证件类型:</td>
      <td><input class="edit_input" value="<%=obj.getCardType()%>" type=text name=cardType>*</td>
      <td>6.证件号码:</td>
      <td><input type=text class="edit_input"   value="<%=obj.getCardNum()%>" name=cardNum>*</td>
    </tr>
    <tr>
      <td>7.工作单位:        </td>
      <td colspan="3"><input class="edit_input" type=text name=workPlace value="<%=obj.getWorkPlace()%>" >*</td>
    </tr>
    <tr>
      <td>8.职务:        </td>
      <td><input class="edit_input" type=text name=job value="<%=obj.getJob()%>" >*</td>
      <td>9.电子邮箱: </td>
      <td><input class="edit_input" type=text name=email value="<%=obj.getEmail()%>" >*</td>
    </tr>
    <tr>
      <td>10.单位地址/邮编:        </td>
      <td colspan="3"><input class="edit_input" type=text name=address value="<%=obj.getAddress()%>" >*</td>
    </tr>
    <tr>
      <td> 11.电话:        </td>
      <td><input type=text  class="edit_input" value="<%=obj.getPhone()%>" name=phone>*</td>
      <td>12.传真:        </td>
      <td><input class="edit_input" value="<%=obj.getFax()%>"  type=text name=fax >*</td>
    </tr>
    <tr>
      <td>13.手机:</td>
      <td  colspan="3"><input class="edit_input" value="<%=obj.getMobile()%>"  type=text name=mobile>*</td>
    </tr>
    <tr>
      <td> 14.到京日期:        </td>
      <td><input class="edit_input" type=text value="<%=obj.getRichDate()%>"  name=richDate></td>
      <td>15.到京时间:        </td>
      <td><input class="edit_input" type=text name=richTime value="<%=obj.getRichTime()%>" ></td>
    </tr>
    <tr>
      <td>16.到京航班:</td>
      <td><input class="edit_input" type=text name=flightNum value="<%=obj.getFlightNum()%>" ></td>
      <td>17.到京车次:</td>
      <td><input  class="edit_input"type=text name=trainNum value="<%=obj.getTrainNum()%>" ></td>
    </tr>

    <tr>
      <td>18.离京日期:</td>
            <td ><input type="text" name="leavedata"  class="edit_input"  value="<%=getNull(obj.getLeaveDate())%>">
            <td>
            19.离京时间:</td><td><input type="text" name="leavetime"  class="edit_input"  value="<%=getNull(obj.getLeaveTime())%>">
          </tr>
          <tr>
            <td>20.到京航班: </td>
              <td><input type=text class="edit_input"  name=leaveflight value="<%=getNull(obj.getLeaveFlight())%>" ></td>
              <td>21.离京车次:
              <td><input type=text class="edit_input"  name=leavetrain value="<%=getNull(obj.getLeaveTrain())%>" >
          </tr>


    <tr>
      <td>22.机场送迎:</td>
      <td colspan="3" ><input  id="radio" type="radio" name=welcome value="需要" checked="checked">
        需要
        <input  id="radio" type="radio" name=welcome value="不需要" <%=getCheck("不需要".equals(obj.getWelcome()))%>>
      不需要</td>
    </tr>
    <tr>
      <td>23.请选择参加的分议题讨论:</td>
      <td colspan="3" >
        <%java.util.Enumeration enumer=tea.entity.node.Conference.findByCommunity(node.getCommunity());while(enumer.hasMoreElements())
{String value=tea.entity.node.Conference.find(((Integer)enumer.nextElement()).intValue()).getName();
  %>
       <input  id="CHECKBOX" type="CHECKBOX" name="subject" value="<%=value%>" /><%=value%>
        <%  }%>    </td>
    </tr>
    <tr>
      <td>24.备注：</td>
      <td colspan="3" ><textarea  class="edit_input" cols=55 rows=5 name=addition><%=obj.getAddition()%></textarea></td>
    <tr>
      <td>25.随行人员姓名</td>
      <td colspan="3" ><textarea class="edit_input" cols=55 rows=5 name=employee><%=obj.getEmployee()%></textarea></td>
    </tr>
    <tr>
      <td colspan="4"> 26.上传简历及其它附加文件 :
        <input name="button" type="button"  class="edit_button" onClick="window.open('/jsp/type/gazetteer/GazetteerUp.jsp?Type=58')" value="上传"/></td>
    </tr>
  </table>
  <p align="center">
    <input type=SUBMIT name="GoNext" id="edit_GoNext" class="edit_button" value="<%=r.getString(teasession._nLanguage, "CBNext")%>" <%out.print(" style=visibility:hidden ");%>>
    <input type=SUBMIT name="GoFinish"   ID="edit_GoFinish" class="edit_button" value="<%=r.getString(teasession._nLanguage, "Finish")%>">
</form>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>

