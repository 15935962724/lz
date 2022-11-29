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
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "sqsyw")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="head6"><img height="6" src="about:blank"></div>
<br>
<form name="form1" action="/servlet/EditGazetteer" method=post onSubmit="return(submitText(this.name, '<%=r.getString(teasession._nLanguage, "InvalidSubject")%>'))">
<%
   String parameter=teasession.getParameter("nexturl");
   boolean   parambool=(parameter!=null&&!parameter.equals("null"));
   Gazetteer obj=Gazetteer.find(0,teasession._nLanguage);
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
     obj=Gazetteer.find(teasession._nNode,teasession._nLanguage);
     issueDate=node.getTime();
   }
    %>
<INPUT TYPE="hidden" NAME="TypeAlias" VALUE="<%=request.getParameter("TypeAlias")%>">
<input type="hidden" name="node" value="<%=teasession._nNode%>">
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td>姓名</td>
    <td><input type="text" class="text" value="<%=obj.getName()%>" name="name"></td>
    <td> 性别 </td>
    <td><input name="sex"  id="radio" type="radio" value="男" checked="checked" class="text"  >
      男
      <input name="sex" <%=getCheck(obj.getSex().equals("女"))%>  id="radio" type="radio" value="女" class="text"  >
      女</td>
  </tr>
  <tr>
    <td>出生日期</td>
    <td><input name="birthday" readonly="readonly" value="<%=obj.getBirthday("yyyy-MM-dd")%>"/>
      <input type="button" value="..." onclick="td_calendar('form1.birthday')"/>
    <td> 血型 </td>
    <td><select name=blood>
        <option value="A">A</option>
        <option value="B" <%=getSelect("B".equals(obj.getBlood()))%>>B</option>
        <option value="AB" <%=getSelect("AB".equals(obj.getBlood()))%>>AB</option>
        <option value="O"<%=getSelect("O".equals(obj.getBlood()))%>>O</option>
      </select>
    </td>
  </tr>
  <tr>
    <td>证件类型</td>
    <td><input value="<%=obj.getCardType()%>" type=text name=cardType></td>
    <td> 证件号码 </td>
    <td><input type=text  value="<%=obj.getCardNum()%>" name=cardNum></td>
  </tr>
  <tr>
    <td>申请人联系地址/邮编</td>
    <td colspan="3"><input type=text name=address value="<%=obj.getAddress()%>" ></td>
  </tr>
  <tr>
    <td>申请人电话</td>
    <td><input type=text  value="<%=obj.getPhone()%>" name=phone></td>
    <td>申请人传真</td>
    <td><input value="<%=obj.getFax()%>"  type=text name=fax ></td>
  </tr>
  <tr>
    <td>申请人手机</td>
    <td><input value="<%=obj.getMobile()%>"  type=text name=mobile></td>
    <td>申请人电子邮件</td>
    <td><input type=text name=email value="<%=obj.getEmail()%>" ></td>
  </tr>
  <tr>
    <td>申请人职务</td>
    <td colspan="3"><input name="business1"  id="CHECKBOX" type="CHECKBOX" value="照相人" onclick="faddtype(form1.business,this)">
      照相人
      <input   id="CHECKBOX" type="CHECKBOX" name="business2"  onclick="faddtype(form1.business,this)" value="摄影师">
      摄影师
      <input  id="CHECKBOX" type="CHECKBOX" name="business3"   onclick="faddtype(form1.business,this)" value="技师">
      技师
      <input   id="CHECKBOX" type="CHECKBOX" name="business4"   onclick="faddtype(form1.business,this)"  value="记者(电视、广播、出版)">
      记者（电视、广播、出版） <br />
      其他（请详细说明）
      </ul>
      <input name="business" value="<%=obj.getBusiness()%>" type="text" class="text"></td>
  </tr>
  <tr>
    <td rowspan="6">所属组织信息</td>
    <td>所属组织名称</td>
    <td colspan="2"><input name="organise"  value="<%=obj.getOrganise()%>" type="text" class="text"></td>
  </tr>
  <tr>
    <td>所属组织类型</td>
    <td colspan="2"><input name="type1"  id="CHECKBOX" type="CHECKBOX" value="报纸" onclick="faddtype(form1.type,this)">
      报纸
      <input name="type2"  id="CHECKBOX" type="CHECKBOX" value="杂志" onclick="faddtype(form1.type,this)">
      杂志
      <input name="type3"  id="CHECKBOX" type="CHECKBOX" value="电视" onclick="faddtype(form1.type,this)">
      电视 <br />
      <input name="type4"  id="CHECKBOX" type="CHECKBOX" value="电报" onclick="faddtype(form1.type,this)">
      电报
      <input name="type5"  id="CHECKBOX" type="CHECKBOX" value="摄影机构" onclick="faddtype(form1.type,this)">
      摄影机构 <br />
      <input name="type6"  id="CHECKBOX" type="CHECKBOX" value="广播电台" onclick="faddtype(form1.type,this)">
      广播电台 <br />
      其他（请详细说明）
      <input type="text"  name="type" value="<%=obj.getType()%>" class="text">
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
    <td colspan="2"><input type=text name=oaddress value="<%=obj.getOaddress()%>" ></td>
  </tr>
  <tr>
    <td>所属组织电话</td>
    <td colspan="2"><input  name="ophone" value="<%=obj.getOphone()%>" type="text" class="text"></td>
  </tr>
  <tr>
    <td>所属组织传真</td>
    <td colspan="2"><input name="ofax"  value="<%=obj.getOfax()%>" type="text" class="text"></td>
  </tr>
  <tr>
    <td>所属组织电子邮件</td>
    <td colspan="2"><input type="text"  value="<%=obj.getOemail()%>" name="oemail" class="text"></td>
  </tr>
  <tr>
    <td rowspan="8">抵离信息
      </td>
    <td>抵达日期 </td>
    <td colspan="2">抵达时间</td>
  </tr>
  <tr>
    <td><input name="arrivaldate" value="<%=getNull(obj.getArrivalDate())%>" /></td>
    <td colspan="2"><input name="arrivaltime" value="<%=getNull(obj.getArrivalTime())%>"/>
    </td>
  </tr>
  <tr>
    <td>航班班次</td>
    <td colspan="2">火车车次</td>
  </tr>
  <tr>
    <td><input type=text name=arrivalflight value="<%=obj.getArrivalFlight()%>" ></td>
    <td colspan="2"><input type=text name=arrivaltrain value="<%=obj.getArrivalTrain()%>" ></td>
  </tr>
  <tr>
    <td>离京日期</td>
    <td colspan="2">离京时间</td>
  </tr>
  <tr>
    <td><input type="text" name="leavedata" class="text" value="<%=getNull(obj.getLeaveDate())%>"></td>
    <td colspan="2"><input type="text" name="leavetime" class="text" value="<%=getNull(obj.getLeaveTime())%>"></td>
  </tr>
  <tr>
    <td>航班班次</td>
    <td colspan="2">火车车次</td>
  </tr>
  <tr>
    <td><input type=text name=leaveflight value="<%=obj.getLeaveFlight()%>" ></td>
    <td colspan="2"><input type=text name=leavetrain value="<%=obj.getLeaveTrain()%>" ></td>
  </tr>
  <tr>
    <td> 机场迎送 </td>
    <td>需要
      <input name="welcome"  id="radio" type="radio" value="需要"  checked="checked" ></td>
    <td colspan="2"> 不需要
      <input name="welcome"<%=getCheck(obj.getWelcome().equals("不需要"))%>  id="radio" type="radio" value="不需要"></td>
  </tr>
  <tr>
    <td> 备注 </td>
    <td colspan="3"><textarea name="remark" cols="50" rows="7" class="text"><%=obj.getRemark()%></textarea>
    </td>
  </tr>
</table>
文件:
<input type="button"  value="上传" onclick="window.open('/jsp/type/gazetteer/GazetteerUp.jsp?Type=60')"/>
<p align="center">
  <input type=SUBMIT name="GoFinish"   ID="edit_GoFinish" class="edit_button" value="<%=r.getString(teasession._nLanguage, "Finish")%>">
<p>说明:如果您不方便在线填写,请<a href="/tea/image/section/Media_Application_zh.doc" style="color:red;">下载此表</a>填好后传真给我们</p>
</LI>
</ul>
<br>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</BODY>
</html>

