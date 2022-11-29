<%@page contentType="text/html;charset=UTF-8"%>
<%@include file="/jsp/Header.jsp"%>
<%
String community=node.getCommunity();
/*
if(!enumer_type.hasMoreElements()&&nodecode==-1)
{
  out.print(new tea.html.Script("alert('还没有创建差点的节点');history.back();"));
  return;
}*/

String member=teasession._rv.toString();

r.add("/tea/resource/Score");
int score=0;
if(request.getParameter("score")!=null)
score=Integer.parseInt(request.getParameter("score"));
Score obj=Score.find(score);

int courtid=0;
if(request.getParameter("court")!=null)
courtid=Integer.parseInt(request.getParameter("court"));

node=Node.find(courtid);
Golf objcourt= Golf.find(courtid,teasession._nLanguage);

tea.entity.member.Profile profile_obj=tea.entity.member.Profile.find(member);

%> 
<html>
<head>
<link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<title>提交个人成绩</title>
<script language="JavaScript" type="text/JavaScript">
function fcavity()
{
//alert(!form1.particular.checked);
  if(!form1.particular.checked)
  {
//

    cavitytext.style.display='';
    if(form1.cavity[1].checked)
    cavitytext2.style.display='';
  } else
  {
  //form1.sums.onfocus="";
    cavitytext.style.display='none';
    cavitytext2.style.display='none';
  }
}

function ShowCalendar(fieldname)
{
  myleft=document.body.scrollLeft+event.clientX-event.offsetX-80;
  mytop=document.body.scrollTop+event.clientY-event.offsetY+140;
// window.open('/jsp/type/hostel/Calendar.jsp');
  window.showModalDialog("/jsp/include/Calendar.jsp?FIELDNAME="+fieldname,self,"edge:raised;scroll:0;status:0;help:0;resizable:1;dialogWidth:280px;dialogHeight:205px;dialogTop:"+mytop+"px;dialogLeft:"+myleft+"px");
}
function showMember()
{
//form1.member
}
function setSums(obj)
{
value=0;
if(isNaN(parseInt(form1.fact[obj].value))||parseInt(form1.fact[obj].value)<=0  <%
 for(int index=0;index< objcourt.getStandard().length;index++)
 {
  if(objcourt.getStandard()[index]>0)
   out.print(" ||(parseInt(obj)=="+index+" && parseInt(form1.fact[obj].value)-"+objcourt.getStandard()[index]+">2)");

 }
  %>)
{
  alert('请输入真实的杆数');//text
  form1.fact[obj].focus();
  return false;
  // alert(isNaN(parseInt(form1.fact[index].value)));
}
for(index=0;index<  form1.fact.length;index++)
{
//if(submitInteger(form1.fact[index],'请输入数字123'))
  value+=parseInt(form1.fact[index].value);
}
form1.sums.value=value;
}
function setFact(obj)
{
value=0;
if(isNaN(parseInt(form1.up[obj].value))||parseInt(form1.up[obj].value)<=0  <%--
 for(int index=0;index< objcourt.getStandard().length;index++)
 {
  if(objcourt.getStandard()[index]>0)
   out.print(" ||(parseInt(obj)=="+index+" && parseInt(form1.up[obj].value)-"+objcourt.getStandard()[index]+">2)");

 }
  --%>)
{
  alert('请输入真实的杆数(上果岭杆数必需大于0)');//text
  form1.up[obj].focus();
  return false;
  // alert(isNaN(parseInt(form1.fact[index].value)));
}
form1.fact[obj].value=parseInt(form1.up[obj].value)+parseInt(form1.bunt[obj].value);
setSums(obj);
}
function submitStandard()
{
value=0;
for(index=0;index<  form1.standard.length;index++)
{
submitInteger(form1.standard[index],'请输入数字');
}
}


function fsubmit()
{
  if(!submitText(form1.name,'请输入球场名称.'))
  {
    return false;
  }
  if(!form1.particular.checked)
  {
    cavity =form1.cavity[0].checked?9:18;
   if(form1.particular_checkbox.checked)
    for(index=0;index<cavity;index++)
    {
     if(isNaN(parseInt(form1.up[index].value))||parseInt(form1.up[index].value)<=0)
     {
       alert('请输入大于0的数字');//text
       form1.up[index].focus();
       return false;
     }/*
     if(isNaN(parseInt(form1.bunt[index].value))||parseInt(form1.bunt[index].value)<=0)
     {
       alert('请输入大于0的数字');//text
       form1.bunt[index].focus();
       return false;
     }*/
    }
    else
        for(index=0;index<cavity;index++)
    {
    //  alert(isNaN(parseInt(form1.fact[index].value))||parseInt(form1.fact[index].value)<=0);
     if(isNaN(parseInt(form1.fact[index].value))||parseInt(form1.fact[index].value)<=0)
     {
       alert('请输入大于0的数字');//text
       form1.fact[index].focus();
       return false;
     }
    }
  }else
    if(isNaN(parseInt(form1.sums.value))||parseInt(form1.sums.value)<=0)
  {
    alert('请输入总杆数');
    return false;
  }
  return true;
}
function setParticularShow()//输入详细实际杆
{
  var tmp=form1.particular_checkbox.checked?"":"none";
  for(var i=0;i<6;i++)
  {
    particular[i].style.display=tmp;
  }
}
</script>


<style type="text/css">
<!--
td,table,span,div,input {
	margin: 0px;
	padding: 0px;
}
-->
</style>
</head>
<body>
<div id="edit_BodyDiv">
<span style="float:left;color:#FF0000;font-weight:bold;"><img SRC="/tea/image/score/0001.jpg">提交个人成绩</span>
<span style="float:right;color:#FF0000;font-weight:bold;">你好：<%=profile_obj.getName(teasession._nLanguage)%></span>
<form name="form1" method="post" action="/servlet/EditScore" onSubmit="return fsubmit()">
<input type=hidden name="score" value="<%=score%>" >
<input type=hidden name="member" value="<%=member%>" >
<input type=hidden name="node" value="<%=teasession._nNode%>" >
  <%
  String nexturl=request.getParameter("nexturl");
  if(nexturl!=null)
  out.print(new tea.html.HiddenField("nexturl",nexturl));
  %>
<table border="0" cellpadding="0" cellspacing="0" class="section" style="text-align:left ">
  <tr>
    <td colspan="4">&nbsp;</td>
  </tr><tr>
    <td width="65" nowrap>选择球场</td>
    <td colspan="3"><select name="golf" onchange="fname(this,form1.name)">
      <option value="0" selected >--------请选择--------</option>
      <%//62球场
      java.util.Enumeration enumer=tea.entity.node.Node.findByType(62,community);
      StringBuffer sb=new StringBuffer();
      for(int index=1;enumer.hasMoreElements();index++)
      {
        int nodecode=((Integer)enumer.nextElement()).intValue();
        Node n=Node.find(nodecode);
        tea.entity.node.Golf court= tea.entity.node.Golf.find(nodecode,teasession._nLanguage);
        String name=n.getSubject(teasession._nLanguage);
        sb.append("case "+index+" : \r\nform1.name.value='"+name+"';");
        for(int i=0;i<18;i++)
        sb.append("form1.standard["+i+"].value="+court.getStandard()[i]+";");
        sb.append("break;\r\n");
        out.print("<option value="+nodecode);
        if(courtid==nodecode)
        out.print(" selected ");
        else
        if(nodecode==obj.getNode())
        out.print(" selected ");
        out.print(" >"+name+"</option>");
      }
      %>
      <option value="<%=Integer.MAX_VALUE%>" <%if(Integer.MAX_VALUE==courtid||obj.getNode()==Integer.MAX_VALUE)out.print(" selected ");%> >--------未列球场--------</option>
    </select>　<br>

    如果没有您打球的球场，请选择最下面的选项，并输入球场名称。</td>
    </tr>
  <tr>
    <td nowrap>球场</td>
    <td width="247"><input type="text" style="display:<%if(obj.getNode()!=Integer.MAX_VALUE&&Integer.MAX_VALUE!=courtid)out.print("none");%>"  name="name" value="<%=getNull(courtid!=0?node.getSubject(teasession._nLanguage):obj.getName())%>"  ></td>
    <td width="58" nowrap>发球台</td>
    <td width="315" nowrap>
       <img SRC="/tea/image/score/01.jpg" width="12" height="12"><input  id="radio" type="radio" name="tee"  value="0">
       <img SRC="/tea/image/score/02.jpg" width="12" height="12"><input  id="radio" type="radio" name="tee"  value="1">
       <img SRC="/tea/image/score/03.jpg" width="12" height="12"><input  id="radio" type="radio" name="tee" checked value="2">
       <img SRC="/tea/image/score/04.jpg" width="12" height="12"><input  id="radio" type="radio" name="tee"  value="3">
       <img SRC="/tea/image/score/05.jpg" width="12" height="12"><input  id="radio" type="radio" name="tee"  value="4">
      <!--select name="tee">
      <option selected>蓝色</option>
      <option >白色</option>
      <option>黄色</option>
      <option>红色</option>
    </select--></td>
  </tr>
  <tr>
    <td nowrap>是否是比赛</td>
    <td><input  id="CHECKBOX" type="CHECKBOX" name="compete" value="checkbox" <%if(obj.isCompete())out.print(" CHECKED ");%>>
    比赛成绩请打勾</td>
    <td nowrap>总杆数</td>
    <td nowrap><input name="sums" type="text" onFocus="if(!form1.particular.checked){form1.particular.focus();alert('如果输入详细杆数,则不能输入总杆数了.');}" onChange="submitInteger(this,'请输入数字');" value="<%=obj.getSums()%>" size="10">
    <input name="particular"   id="CHECKBOX" type="CHECKBOX" onclick="fcavity();">只输入总杆数
    <input name="cavity"  id="radio" type="radio" <%if(obj.getCavity()==9)out.print(" CHECKED ");%> value="9" onclick="if(!particular.checked)cavitytext2.style.display='none';">
    9洞
    <input name="cavity"  id="radio" type="radio" value="18" onclick="if(!particular.checked)cavitytext2.style.display='';" <%if(obj.getCavity()!=9)out.print(" CHECKED ");%> >
    18洞</td>
  </tr>
  <tr>
    <td colspan="4">
<hr>
	<table height="100" border="0" align="left" cellpadding="0" cellspacing="0" id="cavitytext" >
  <tr>
    <td width="39">Hole</td>
    <td height=20px width="13"><img SRC="/tea/image/score/001.jpg" width="13" height="13"></td>
    <td width="13"><img SRC="/tea/image/score/002.jpg" width="13" height="13"></td>
    <td width="13"><img SRC="/tea/image/score/003.jpg" width="13" height="13"></td>
    <td width="13"><img SRC="/tea/image/score/004.jpg"></td>
    <td width="13"><img SRC="/tea/image/score/005.jpg"></td>
    <td width="13"><img SRC="/tea/image/score/006.jpg"></td>
    <td width="13"><img SRC="/tea/image/score/007.jpg"></td>
    <td width="13"><img SRC="/tea/image/score/008.jpg"></td>
    <td width="16"><img SRC="/tea/image/score/009.jpg"></td>
    </tr>
	<tr>
	<td height="20">球洞图</td>
<%	    for(int index=0;index<9;index++)
{if(objcourt.getHole()[index]!=null&&objcourt.getHole()[index].length()>0)
  out.print("<td><A name=ahole"+index+" href="+objcourt.getHole()[index]+" target=_blank><img src="+objcourt.getHole()[index]+" name=imghole"+index+" width=20 height=20></a></td>");
  else
  out.print("<td>无</td>");
}
%>
	</tr>
  <tr>
    <td height=20px>标准杆</td>
    <%
    for(int index=0;index<9;index++)
    out.print("<td>"+(courtid==0?obj.getStandard()[index]:objcourt.getStandard()[index])+"</td>");
    %><!--input name='standard' readonly onchange=\"submitStandard()\" onkeyup='submitStandard()' type='text' value='"+' size='1'-->
    </tr>
  <tr>
    <td>实际杆</td>
        <%boolean bool_particular=false;
    for(int index=0;index<9;index++)
    {
      if(obj.getFact()[index]<=0)
      {
        bool_particular=true;
      }
      out.print("<td><input name='fact' onfocus=\"if(particular_checkbox.checked){alert('如果输入详细实际杆,则不有输入实际杆了,谢谢合作');particular_checkbox.focus();}\" onChange='setSums("+index+")'  type='text' value='"+obj.getFact()[index]+"' size='1'></td>");
    }
     %>
    </tr><tr><td colspan="10" ><input onfocus="" name="particular_checkbox" onclick="setParticularShow();"  id="CHECKBOX" type="CHECKBOX" value="">输入详细实际杆</td>
      </tr>
<!-- 详细实际杆/////////////////////// -->
      <tr id="particular" style="display:none"><td>上球道</td> <%
      for(int index=0;index<9;index++)
      {
        out.print("<td><input name='fairway"+index+"'  type='checkbox'></td>");
      }
      %>
      </tr>
      <tr id="particular" style="display:none"><td>上</td> <%
      bool_particular=false;
      for(int index=0;index<9;index++)
      {
        if(obj.getFact()[index]>0)
        {
          bool_particular=true;
        }
        out.print("<td><input name='up' onChange='setFact("+index+")'  type='text' value='"+obj.getUp()[index]+"' size='1'></td>");
      }
    %>
      </tr>
	  <tr id="particular" style="display:none"><td  >推</td> <%
    for(int index=0;index<9;index++)
    {
      out.print("<td><input name='bunt' onChange='setFact("+index+")'  type='text' value='"+obj.getBunt()[index]+"' size='1'></td>");
    }
    %>
      </tr>
</table>


<!-- 后9洞////////// -->
      <table height="100" border="0" cellpadding="0" cellspacing="0" id="cavitytext2" style="display:<%if(obj.getCavity()==9)out.print("none");%>">
        <tr>
          <td height=20px><img SRC="/tea/image/score/010.jpg" width="13" height="13"></td>
          <td><img SRC="/tea/image/score/011.jpg"></td>
          <td><img SRC="/tea/image/score/012.jpg"></td>
          <td><img SRC="/tea/image/score/013.jpg"></td>
          <td><img SRC="/tea/image/score/014.jpg"></td>
          <td><img SRC="/tea/image/score/015.jpg"></td>
          <td><img SRC="/tea/image/score/016.jpg"></td>
          <td><img SRC="/tea/image/score/017.jpg"></td>
          <td><img SRC="/tea/image/score/018.jpg"></td>
        </tr><tr>

<%
for(int index=9;index<18;index++)
{if(objcourt.getHole()[index]!=null&&objcourt.getHole()[index].length()>0)
out.print("<td height=20px><A name=ahole"+index+" href="+objcourt.getHole()[index]+" target=_blank><img src="+objcourt.getHole()[index]+" name=imghole"+index+" width=20 height=20></a></td>");
else
out.print("<td height=20px>无</td>");}
%>
	</tr>
        <tr>
    <%
    for(int index=9;index<18;index++)
    out.print("<td height=20px>"+(courtid==0?obj.getStandard()[index]:objcourt.getStandard()[index])+"</td>");
    %><!--input name='standard' readonly type='text'  onchange=\"submitStandard()\" onkeyup='submitStandard()'  value='' size='1'-->
        </tr>
        <tr>
        <%
    for(int index=9;index<18;index++)
    out.print("<td><input name='fact' onfocus=\"if(particular_checkbox.checked){alert('如果输入详细实际杆,则不有输入实际杆了,谢谢合作');particular_checkbox.focus();}\"  type='text'   onChange='setSums("+index+")'  value='"+obj.getFact()[index]+"' size='1'></td>");
    %>
        </tr><tr><td ><input  id=CHECKBOX type="CHECKBOX" name="ffffffffffff" style="visibility:hidden " value="afd"></td>
        </tr>

      <tr id="particular" style="display:none"><%
      for(int index=9;index<18;index++)
      {
        out.print("<td><input name='fairway"+index+"' type='checkbox'></td>");
      }
      %>
      </tr>
      <tr id="particular" style="display:none"><%
    for(int index=9;index<18;index++)
    {
      out.print("<td><input name='up' onChange='setFact("+index+")'  type='text' value='"+obj.getUp()[index]+"' size='1'></td>");
    }
    %>
      </tr>
	  <tr id="particular" style="display:none"><%
    for(int index=9;index<18;index++)
    {
      out.print("<td><input name='bunt' onChange='setFact("+index+")'  type='text' value='"+obj.getBunt()[index]+"' size='1'></td>");
    }
    %>
      </tr>
      </table>
      <%
        if(obj.isExists())//只输入总杆数
    out.print(new tea.html.Script("form1.particular.checked="+bool_particular+";fcavity();"));

          if(obj.isExists())//输入详细实际杆
    out.print(new tea.html.Script("form1.particular_checkbox.checked="+bool_particular+";setParticularShow();"));
      %></td>
  </tr>
    <tr><td>球童编号</td>
    <td colspan="20"><input name="caddy"/></td>
  </tr>
  <tr><td>备忘记录</td>
    <td colspan="20"><textarea  name="text" cols="80" rows="6" ><%=tea.html.HtmlElement.htmlToText(obj.getText())%></textarea></td>
  </tr>
  <tr>
    <td>打球日期</td>
    <td><input type="text"  readonly="readonly" name="times" value="<%=new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date())%>">
    <input type="button" name="Submit" value="..." onclick="ShowCalendar('form1.times')"></td>
    <td>&nbsp;      </td>
    <td><input type="submit" class=in name="Submit" value="提交"></td>
  </tr>
</table>
</form>
</div>

<script type="">
function fname(selectObj,textObj)
{
window.open('<%=request.getRequestURI()%>?court='+selectObj.options[selectObj.selectedIndex].value+'&<%=request.getQueryString()%>','_self');
/*  textObj.readonly=selectObj.selectedIndex!=0;
  switch(selectObj.selectedIndex)
  {
    case 0:
    textObj.value='';
    form1.standard[1].value='0';
    form1.standard[2].value='0';
    form1.standard[3].value='0';
    form1.standard[4].value='0';
    form1.standard[5].value='0';
    form1.standard[6].value='0';
    form1.standard[7].value='0';
    form1.standard[8].value='0';
    form1.standard[9].value='0';
    form1.standard[10].value='0';
    form1.standard[11].value='0';
    form1.standard[12].value='0';
    form1.standard[13].value='0';
    form1.standard[14].value='0';
    form1.standard[15].value='0';
    form1.standard[16].value='0';
    form1.standard[17].value='0';
    form1.standard[0].value='0';
    textObj.focus();
    break;
    <%=sb.toString()%>
  }*/
}
if(form1.golf.selectedIndex==0)
for(index=1;index<form1.elements.length;index++)
{
  if(form1.elements[index].name!="golf")form1.elements[index].disabled="disabled";
}
</script>

</body>
</html>
