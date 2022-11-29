<%@page contentType="text/html;charset=UTF-8"  %>
<%@include file="/jsp/Header.jsp"%>
<%
String community=node.getCommunity();
java.util.Enumeration enumer_type=tea.entity.node.Node.findByType(64,community);//查找当前会员的差点节点
int nodecode=-1;
while(enumer_type.hasMoreElements())
{
   nodecode=((Integer)enumer_type.nextElement()).intValue();
   tea.entity.node.Node node_temp=  tea.entity.node.Node.find(nodecode);
   if(node_temp.getCreator()._strR.equals(teasession._rv._strR))
   {
     node=node_temp;
     teasession._nNode=nodecode;
   }
}/*
if(!enumer_type.hasMoreElements()&&nodecode==-1)
{
  out.print(new tea.html.Script("alert('还没有创建差点的节点');history.back();"));
  return;
}*/
r.add("/tea/resource/Score");
int score=0;
if(request.getParameter("score")!=null)
score=Integer.parseInt(request.getParameter("score"));
tea.entity.node.Score obj=tea.entity.node.Score.find(score);
int courtid=0;
if(request.getParameter("court")!=null)
courtid=Integer.parseInt(request.getParameter("court"));
 tea.entity.node.Golf objcourt= tea.entity.node.Golf.find(courtid,teasession._nLanguage);
 
 String fieldid= obj.getFieldid();
 String fieldid2= obj.getFieldid2();

 GolfSite obj1 = GolfSite.find(GolfSite.getGSid(obj.getNode(),fieldid));
 GolfSite obj2 = GolfSite.find(GolfSite.getGSid(obj.getNode(),fieldid2));
 
%><html>
<head><link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>提交个人成绩</title>
<script language="JavaScript" type="text/JavaScript">
function fcavity()
{/*
//alert(!form1.particular.checked);
  if(!form1.particular.checked)
  {
//

    cavitytext.style.visibility='';
    if(form1.cavity[1].checked)
    cavitytext2.style.visibility='';
  } else
  {
  //form1.sums.onfocus="";
    cavitytext.style.visibility='hidden';
    cavitytext2.style.visibility='hidden';
  }*/
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
  alert('请输入真实的杆数');//text
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
  if(!submitText(form1.courtname,'请输入球场名称.'))
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
     }
     if(isNaN(parseInt(form1.bunt[index].value))||parseInt(form1.bunt[index].value)<=0)
     {
       alert('请输入大于0的数字');//text
       form1.bunt[index].focus();
       return false;
     }
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
if(form1.particular_checkbox.checked)
{
  particular[0].style.visibility='';
  particular[1].style.visibility='';
  particular[2].style.visibility='';
particular[3].style.visibility='';
}else{
particular[0].style.visibility='hidden';
particular[1].style.visibility='hidden';
particular[2].style.visibility='hidden';
particular[3].style.visibility='hidden';
}
}
</script>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "ScoreBrowse")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br>
<div  style="width:630px"> <span style="float:left;color:#FF0000;font-weight:bold;"><img SRC="/tea/image/score/0001.jpg">　浏览个人成绩</span>
<span style="float:right;color:#FF0000;font-weight:bold;">你好：
<%

tea.entity.member.Profile profile_obj=tea.entity.member.Profile.find(teasession._rv.toString());
out.println(profile_obj.getLastName(teasession._nLanguage));
out.println(profile_obj.getFirstName(teasession._nLanguage));
%></span></div>
<form name="form1" method="post" action="/servlet/EditScore" onSubmit="return fsubmit()">
<input type=hidden name="score" value="<%=score%>" >
<input type=hidden name="Node" value="<%=teasession._nNode%>" >
  <%
  String nexturl=request.getParameter("nexturl");
  if(nexturl!=null)
  out.print(new tea.html.HiddenField("nexturl",nexturl));
  %>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter" style="text-align:left ">
 <tr>
    <td>球场：
      <%//62球场
      if(obj.getNode()==Integer.MAX_VALUE)
      {
        out.print(obj.getName());
      }else
      {
        Node court=Node.find(obj.getNode());
        out.print(court.getSubject(teasession._nLanguage));
      }
      %></td>
    <td>发球台 ：
      <%=r.getString(teasession._nLanguage,tea.entity.node.Score.TEE_TYPE[obj.getTee()])%></td>
    <td>&nbsp;</td>

  </tr>
  <tr>
    <td>是否是比赛：
      <%if(obj.isCompete())out.print("是");else out.print("否");%></td>
    <td>总杆数 ： <%=obj.getSums()%></td>
    <td>洞数：<%=obj.getCavity()%>洞</td>

  </tr>
  <tr>
    <td colspan="3"><table align="left" id="cavitytext" style="visibility:">
  <tr>
    <td>Hole</td>
    <td>1</td>
    <td>2</td>
    <td>3</td>
    <td>4</td>
    <td>5</td>
    <td>6</td>
    <td>7</td>
    <td>8</td>
    <td>9</td>
    </tr>
	<tr>
	<td>球洞图</td>
<%	    for(int index=0;index<9;index++)
{if(objcourt.getHole()[index]!=null&&objcourt.getHole()[index].length()>0)
  out.print("<td><A name=ahole"+index+" href="+objcourt.getHole()[index]+" target=_blank><img src="+objcourt.getHole()[index]+" name=imghole"+index+" width=20 height=20></a></td>");
  else
  out.print("<td>无</td>");
}
%>
	</tr>
  <tr>
    <td>标准杆</td>
    <%
    for(int index=0;index<9;index++)
    out.print("<td>"+obj1.getStandard(index+1)+"</td>");
    %><!--input name='standard' readonly onchange=\"submitStandard()\" onkeyup='submitStandard()' type='text' value='"+' size='2'-->
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
      out.print("<td>"+obj.getFact()[index]);
    }
    out.print(new tea.html.Script("form1.particular.checked="+bool_particular+";fcavity();"));
    %>
    </tr><!--tr><td colspan="20" ><input onfocus="" name="particular_checkbox" onclick="setParticularShow();"  id="CHECKBOX" type="CHECKBOX" value="">输入详细实际杆</td>
      </tr-->
      <tr id="particular" style="visibility:"><td  >上</td> <%
           bool_particular=false;
    for(int index=0;index<9;index++)
    {
      if(obj.getFact()[index]>0)
      {
        bool_particular=true;
      }
      out.print("<td>"+obj.getUp()[index]);
    }
    %>
      </tr>
	  <tr id="particular" style="visibility:"><td  >推</td> <%
    for(int index=0;index<9;index++)
    {
      out.print("<td>"+obj.getBunt()[index]+"</td>");
    }
    %>
      </tr>
</table>
      <table id="cavitytext2" style="visibility:<%//if(obj.getCavity()==9)out.print("hidden");%>">
        <tr>
          <td>10</td>
          <td>11</td>
          <td>12</td>
          <td>13</td>
          <td>14</td>
          <td>15</td>
          <td>16</td>
          <td>17</td>
          <td>18</td>
        </tr><tr>

<%	    for(int index=9;index<18;index++)
{if(objcourt.getHole()[index]!=null&&objcourt.getHole()[index].length()>0)
  out.print("<td><A name=ahole"+index+" href="+objcourt.getHole()[index]+" target=_blank><img src="+objcourt.getHole()[index]+" name=imghole"+index+" width=20 height=20></a></td>");
  else
  out.print("<td>无</td>");}
%>
	</tr>
        <tr>
    <%
    for(int index=9;index<18;index++)
    out.print("<td>"+obj2.getStandard(index-8)+"</td>");
    %><!--input name='standard' readonly type='text'  onchange=\"submitStandard()\" onkeyup='submitStandard()'  value='' size='2'-->
        </tr>
        <tr>
        <%
    for(int index=9;index<18;index++)
    out.print("<td>"+obj.getFact()[index]+"</td>");
    %>
        </tr><!--tr><td>&nbsp;</td></tr-->
          <tr id="particular" style="visibility:"><%
    for(int index=9;index<18;index++)
    {
      out.print("<td>"+obj.getUp()[index]+"</td>");
    }
    %>
      </tr>
	  <tr id="particular" style="visibility:"><%
    for(int index=9;index<18;index++)
    {
      out.print("<td>"+obj.getBunt()[index]+"</td>");
    }
    %>
      </tr>
      </table>
      <%
          if(obj.isExists())
    out.print(new tea.html.Script("form1.particular_checkbox.checked="+bool_particular+";setParticularShow();"));
      %>
      </td>
  </tr>
  <tr><td>备忘记录</td>
    <td colspan="20"><%=tea.html.HtmlElement.htmlToText(obj.getText())%></td>
  </tr>
  <tr>
    <td>打球日期</td>
    <td><%=new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date())%>
    </td>
    <td>&nbsp;      </td>
    <td>&nbsp;</td>
  </tr>
  <%
java.text.SimpleDateFormat sdf=new  java.text.SimpleDateFormat ("yyyy-MM-dd hh:mm");
  %>
  <tr><td>创建日期</td><td><%=sdf.format(obj.getCreateTime())%></td></tr>
  <tr><td>打球日期</td><td><%=sdf.format(obj.getAlterTime())%></td></tr>
</table>
</form>


<script type="">
function fcourtname(selectObj,textObj)
{
window.open('/jsp/type/score/EditScore.jsp?court='+selectObj.options[selectObj.selectedIndex].value,'_self');
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

  }*/
}
if(form1.courtnode.selectedIndex==0)
for(index=1;index<form1.elements.length;index++)
{
  if(form1.elements[index].name!="courtnode")
  form1.elements[index].disabled="disabled";
}
</script>
<input name="submit" type="submit" class="edit_button" onClick="javaScript:window.close();"  id="edit_submit"  value="关闭">
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>

