<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>
<%
tea.db.DbAdapter dbadapter=new tea.db.DbAdapter();
try
{
dbadapter.executeQuery("SELECT Node.node,type FROM Node WHERE finished=1 AND (type=58 OR type=59 OR type=61)AND rcreator="+dbadapter.cite(teasession._rv._strR)+" AND vcreator="+dbadapter.cite(teasession._rv._strV));
if(dbadapter.next())
{
    out.print(new tea.html.Script("if(confirm('您已经申请了其它的报名,如果在此申请报名,则系统会自动删除其它的报名.是否继续?')){window.open('/servlet/DeleteNode?node="+(dbadapter.getInt(1))+"&nexturl="+java.net.URLDecoder.decode(request.getRequestURI()+"?"+request.getQueryString())+"', '_self');}else{history.back();}"));
    return;
}else
  {
    dbadapter.executeQuery("SELECT Node.node FROM Node WHERE Node.type=60 AND rcreator="+dbadapter.cite(teasession._rv._strR)+" AND vcreator="+dbadapter.cite(teasession._rv._strV));
       if(dbadapter.next()&&request.getRequestURI().startsWith("/servlet/"))
    {
      out.print(new tea.html.Script("window.open('/jsp/type/"+tea.entity.node.Node.NODE_TYPE[60].toLowerCase()+"/21shijiEdit"+tea.entity.node.Node.NODE_TYPE[60]+".jsp?node="+dbadapter.getInt(1)+"','_self');"));
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



-->
</style>
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
<h1><%=r.getString(teasession._nLanguage, "sqsyw")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<form name="form1" action="/servlet/EditGazetteer" method=post onSubmit="return(submitText(this.name, '<%=r.getString(teasession._nLanguage, "InvalidSubject")%>')&&submitText(this.birthday, '无效的出生日期')&&submitText(this.cardType, '无效的证件类型')&&submitText(this.cardNum, '无效的证件号码')&&submitText(this.address, '无效的申请人联系地址/邮编')&&submitText(this.phone, '无效的申请人电话')&&submitText(this.fax, '无效的申请人传真')&&submitText(this.mobile, '无效的申请人手机')&&submitText(this.email, '无效的申请人电子邮件')&&submitText(this.business, '无效的申请人职务')&&submitText(this.organise, '无效的所属组织名称')&&submitText(this.type, '无效的所属组织类型')&&submitText(this.oaddress, '无效的所属组织地址/邮编')&&submitText(this.ophone, '无效的所属组织电话')&&submitText(this.ofax, '无效的所属组织传真')&&submitText(this.oemail, '所属组织电子邮件'))">
<%
   String parameter=teasession.getParameter("nexturl");
   boolean   parambool=(parameter!=null&&!parameter.equals("null"));
   Gazetteer obj=Gazetteer.find(0,teasession._nLanguage);
   if(parambool)
   out.print("<input  class=\"edit_input\"  type='hidden' name=nexturl value="+parameter+">");
   String subject="";
   Date issueDate=null;
   if(request.getParameter("NewNode")!=null)
   {
     out.println("<input    TYPE=hidden NAME=NewNode VALUE=ON>");
   }else
   if(request.getParameter("NewBrother")!=null)
   {
     out.println("<input    TYPE=hidden NAME=NewBrother VALUE=ON>");
   }else
   {
     subject=node.getSubject(teasession._nLanguage);
     obj=Gazetteer.find(teasession._nNode,teasession._nLanguage);
     issueDate=node.getTime();
   }
    %>
<input  class="edit_input"  TYPE="hidden" NAME="TypeAlias" VALUE="<%=request.getParameter("TypeAlias")%>">
<input  class="edit_input"  type="hidden" name="node" value="<%=teasession._nNode%>">
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td>1.姓名</td>
    <td><input  class="edit_input"  type="text"  value="<%=obj.getName()%>" name="name">
      *</td>
    <td> 2.性别 </td>
    <td><input name="sex"  id="radio" type="radio" value="男" checked="checked"  >
      男
      <input name="sex" <%=getCheck(obj.getSex().equals("女"))%>  id="radio" type="radio" value="女"  >
      女 *</td>
  </tr>
  <tr>
    <td>3.出生日期</td>
    <td><input name="birthday" readonly="readonly" class="edit_input"  value="<%=obj.getBirthday("yyyy-MM-dd")%>"/>
      <input type="button" value="..." onclick="td_calendar('form1.birthday')"/>
      *</td>
    <td> 4.血型 </td>
    <td><select name=blood>
        <option value="A">A</option>
        <option value="B" <%=getSelect("B".equals(obj.getBlood()))%>>B</option>
        <option value="AB" <%=getSelect("AB".equals(obj.getBlood()))%>>AB</option>
        <option value="O"<%=getSelect("O".equals(obj.getBlood()))%>>O</option>
      </select>
    </td>
  </tr>
  <tr>
    <td>5.证件类型</td>
    <td><input  class="edit_input"  value="<%=obj.getCardType()%>" type=text name=cardType>
      *</td>
    <td> 6.证件号码 </td>
    <td><input  class="edit_input"  type=text  value="<%=obj.getCardNum()%>" name=cardNum>
      *</td>
  </tr>
  <tr>
    <td>7.申请人联系地址/邮编</td>
    <td colspan="3"><input  class="edit_input"  type=text name=address value="<%=obj.getAddress()%>" >
      *</td>
  </tr>
  <tr>
    <td>8.申请人电话</td>
    <td><input  class="edit_input"  type=text  value="<%=obj.getPhone()%>" name=phone>
      *</td>
    <td>9.申请人传真</td>
    <td><input  class="edit_input"  value="<%=obj.getFax()%>"  type=text name=fax >
      *</td>
  </tr>
  <tr>
    <td>10.申请人手机</td>
    <td><input  class="edit_input"  value="<%=obj.getMobile()%>"  type=text name=mobile>
      *</td>
    <td>11.申请人电子邮件</td>
    <td><input  class="edit_input"  type=text name=email value="<%=obj.getEmail()%>" >
      *</td>
  </tr>
  <tr>
    <td>12.申请人职务</td>
    <td colspan="3"><input    name="business1"  id="CHECKBOX" type="CHECKBOX" value="照相人" onclick="faddtype(form1.business,this)">
      照相人
      <input      id="CHECKBOX" type="CHECKBOX" name="business2"  onclick="faddtype(form1.business,this)" value="摄影师">
      摄影师
      <input      id="CHECKBOX" type="CHECKBOX" name="business3"   onclick="faddtype(form1.business,this)" value="技师">
      技师 <br />
      <input      id="CHECKBOX" type="CHECKBOX" name="business4"   onclick="faddtype(form1.business,this)"  value="记者(电视、广播、出版)">
      记者（电视、广播、出版） <br />
      其他（请详细说明）
      </ul>
      <input  class="edit_input"  name="business" value="<%=obj.getBusiness()%>" type="text" >
      *</td>
  </tr>
  <tr>
    <td rowspan="6">13.所属组织信息</td>
    <td>所属组织名称</td>
    <td colspan="2"><input  class="edit_input"  name="organise"  value="<%=obj.getOrganise()%>" type="text" ></td>
  </tr>
  <tr>
    <td>所属组织类型</td>
    <td colspan="2"><input    name="type1"  id="CHECKBOX" type="CHECKBOX" value="报纸" onclick="faddtype(form1.type,this)">
      报纸
      <input    name="type2"  id="CHECKBOX" type="CHECKBOX" value="杂志" onclick="faddtype(form1.type,this)">
      杂志
      <input    name="type3"  id="CHECKBOX" type="CHECKBOX" value="电视" onclick="faddtype(form1.type,this)">
      电视 <br />
      <input    name="type4"  id="CHECKBOX" type="CHECKBOX" value="电报" onclick="faddtype(form1.type,this)">
      电报
      <input    name="type5"  id="CHECKBOX" type="CHECKBOX" value="摄影机构" onclick="faddtype(form1.type,this)">
      摄影机构 <br />
      <input    name="type6"  id="CHECKBOX" type="CHECKBOX" value="广播电台" onclick="faddtype(form1.type,this)">
      广播电台 <br />
      其他（请详细说明）
      <input  class="edit_input"  type="text"  name="type" value="<%=obj.getType()%>" >
      *
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
    <td>所属组织地址/邮编</td>
    <td colspan="2"><input  class="edit_input"  type=text name=oaddress value="<%=obj.getOaddress()%>" >
      *</td>
  </tr>
  <tr>
    <td>所属组织电话</td>
    <td colspan="2"><input  class="edit_input"   name="ophone" value="<%=obj.getOphone()%>" type="text" >
      *</td>
  </tr>
  <tr>
    <td>所属组织传真</td>
    <td colspan="2"><input  class="edit_input"  name="ofax"  value="<%=obj.getOfax()%>" type="text" >
      *</td>
  </tr>
  <tr>
    <td>所属组织电子邮件</td>
    <td colspan="2"><input  class="edit_input"  type="text"  value="<%=obj.getOemail()%>" name="oemail" >
      *</td>
  </tr>
  <tr>
    <td rowspan="8">14.抵离信息 </td>
    <td>抵达日期 </td>
    <td colspan="2">抵达时间</td>
  </tr>
  <tr>
    <td><input  class="edit_input"  name="arrivaldate" value="<%=getNull(obj.getArrivalDate())%>" /></td>
    <td colspan="2"><input  class="edit_input"  name="arrivaltime" value="<%=getNull(obj.getArrivalTime())%>"/>
    </td>
  </tr>
  <tr>
    <td>航班班次</td>
    <td colspan="2">火车车次</td>
  </tr>
  <tr>
    <td><input  class="edit_input"  type=text name=arrivalflight value="<%=obj.getArrivalFlight()%>" ></td>
    <td colspan="2"><input  class="edit_input"  type=text name=arrivaltrain value="<%=obj.getArrivalTrain()%>" ></td>
  </tr>
  <tr>
    <td>离京日期</td>
    <td colspan="2">离京时间</td>
  </tr>
  <tr>
    <td><input  class="edit_input"  type="text" name="leavedata"  value="<%=getNull(obj.getLeaveDate())%>"></td>
    <td colspan="2"><input  class="edit_input"  type="text" name="leavetime"  value="<%=getNull(obj.getLeaveTime())%>"></td>
  </tr>
  <tr>
    <td>航班班次</td>
    <td colspan="2">火车车次</td>
  </tr>
  <tr>
    <td><input  class="edit_input"  type=text name=leaveflight value="<%=obj.getLeaveFlight()%>" ></td>
    <td colspan="2"><input  class="edit_input"  type=text name=leavetrain value="<%=obj.getLeaveTrain()%>" ></td>
  </tr>
  <tr>
    <td> 15.机场迎送 </td>
    <td>需要
      <input  name="welcome"  id="radio" type="radio" value="需要"  checked="checked" ></td>
    <td colspan="2"> 不需要
      <input  name="welcome"<%=getCheck(obj.getWelcome().equals("不需要"))%>  id="radio" type="radio" value="不需要"></td>
  </tr>
  <tr>
    <td> 16.备注 </td>
    <td colspan="3"><textarea name="remark" class="edit_input" cols="50" rows="7" > <%=obj.getRemark()%> </textarea>
    </td>
  </tr>
  <tr>
    <td colspan="4">请于2005年？月？日前回复到：<br />
      XXX先生<br />
      21世纪论坛秘书处<br />
      中华人民共和国北京市……<br />
      电子邮件：<br />
      电话：<br />
      传真： </td>
  </tr>
  <tr>
    <td colspan="4"> 注意：<br />
      申请人如果没有附由其机构主编或主管所出具的带有亲笔签字的证明函将不予办理。 </td>
  </tr>
  <tr>
    <td colspan="4">上传简历及其它附加文件:
      <input name="button"  type="button"  class="edit_button" onClick="window.open('/jsp/type/gazetteer/GazetteerUp.jsp?Type=60')"  value="上传"/>
    </td>
  </tr>
</table>
<p align="center">
  <input  type=SUBMIT name="GoFinish"   ID="edit_GoFinish" class="edit_button" value="<%=r.getString(teasession._nLanguage, "Finish")%>">
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</BODY>
</html>

