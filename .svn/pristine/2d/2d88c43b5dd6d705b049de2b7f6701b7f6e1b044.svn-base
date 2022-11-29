<%@page contentType="text/html;charset=UTF-8"  %>
<%@include file="/jsp/Header.jsp"%>
<%@page import="tea.entity.node.Meeting"%>
<%

/* if(!AccessMember.find(node._nNode, teasession._rv._strV).isProvider(37))
{
  response.sendError(403);
  return;
} */
 r.add("/tea/resource/Meeting");


long lp1len=0;
long iplen=0;
float integral = 0;

String subject="",content="",issue="";
String flyerdata="";

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<link href="/tea/tea.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/tea/Calendar.js" type="text/javascript"></script>
<script src="/tea/city2.js" type="text/javascript"></script>
<script src="/tea/ckeditor/ckeditor.js" type="text/javascript"></script>
<script type="text/javascript">
function on_sel_rela(index)
{
//	open_win('ProductSel.jsp?index='+index,'','scrollbars',450,700);
//window.open('ProductSel.jsp?index='+index);
  window.showModalDialog("/jsp/type/nightshop/NightShopList.jsp?node=<%=teasession._nNode%>&index="+index,self,"edge:raised;status:0;help:0;resizable:1;dialogWidth:450px;dialogHeight:550px;dialogTop:"+100+";dialogLeft:"+150+"");
}

function f_load()
{
	f_myeditor("","nonuse","content");
	f_myeditor("","nonuse2","issue");
  form1.subject.focus();
}
function f_sub()
{
	  if(form1.subject.value==''){
		  alert('请填写会议名称');
		  form1.subject.focus();
		  return false;
	  }
	  if(form1.timeStart.value=='')
		  {
		  	alert("请填写会议报名开始时间");
		  	form1.timeStart.focus();
		  	return false;
		  }
	  if(form1.timeStop.value=='')
		{
		  	alert("请填写会议报名结束时间");
		  	form1.timeStop.focus();
		  	return false;

		}
	  if(form1.timeHoldStart.value=='')
	  {
	  	alert("请填写会议举行开始时间");
	  	form1.timeHoldStart.focus();
	  	return false;
	  }
	  if(form1.timeHoldStop.value=='')
		{
		  	alert("请填写会议举行结束时间");
		  	form1.timeHoldStop.focus();
		  	return false;

		}

}

//FCK编辑器
function f_myeditor(obj,nonuseName,contentName)
{
	if(!obj){
		  form1[nonuseName].checked=localStorage.getItem('fck.editor')=='true';
	}else{
		  localStorage.setItem('fck.editor',form1[nonuseName].checked);
	}
	var ewebeditor=document.getElementById('editor2');
  var t=form1[contentName].style;
  if(form1[nonuseName].checked)
  {
    if(ewebeditor)
	{
	  t.display="";
	  ewebeditor.style.display="none";
	}else
	{
	  var fck=CKEDITOR.instances[contentName];
	  if(fck)
	  {
	    fck.destroy();
	    form1[contentName].value=form1[contentName].defaultValue;
	  }
	}
  }else
  {
    if(ewebeditor)
	{
      t.display="none";
	  ewebeditor.style.display="";
	}else
      CKEDITOR.replace(form1[contentName]);
  }
}

</script>
<script>
      
      </script>
</head>
<body onload="f_load()">
<h1>会议编辑</h1>
  <div id="head6"><img height="6" src="about:blank"></div>


<form name="form1" method="post" action="/servlet/EditMeeting"  ENCtype=multipart/form-data target="_ajax" onSubmit="return f_sub();">
<input type="hidden" name="node" value="<%=teasession._nNode%>">
<input type="hidden" name="act" value="edit">
<input type="hidden" name="nexturl" value="<%=teasession.getParameter("nexturl")%>">
<input type="hidden" name="adminrole" value="<%=teasession.getParameter("adminrole") %>">
<%
Meeting meeting ;
String parameter=teasession.getParameter("nexturl");

boolean parambool=(parameter!=null&&!parameter.equals("null"));
if(parambool)
{
  out.print("<input type='hidden' name=nexturl value="+parameter+">");
}
if(request.getParameter("NewNode")!=null)
{
  meeting = Meeting.find(0, teasession._nLanguage);
  out.println("<INPUT TYPE=hidden NAME=NewNode VALUE=ON>");
}else
{
  meeting = Meeting.find(teasession._nNode, teasession._nLanguage);
  if(meeting.getBigPicture()!=null && meeting.getBigPicture().length()>0)
  {
    java.io.File file=new File(application.getRealPath(meeting.getBigPicture()));
    lp1len=file.length();
  }
  if(meeting.getIntroPicture()!=null && meeting.getIntroPicture().length()>0)
  {
    java.io.File file=new File(application.getRealPath(meeting.getIntroPicture()));
    iplen=file.length();
  }
  subject=HtmlElement.htmlToText(node.getSubject(teasession._nLanguage));
  content=HtmlElement.htmlToText(node.getText(teasession._nLanguage));
  issue=HtmlElement.htmlToText(meeting.getIssue());
  flyerdata=HtmlElement.htmlToText(meeting.getFlyerData());
}
%>
<INPUT TYPE="hidden" NAME="TypeAlias" VALUE="<%=request.getParameter("TypeAlias")%>">
 <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td align="right"><%=r.getString(teasession._nLanguage, "会议标题")%>：</td>
      <td>
        <input type="text" size=70 maxlength=255  class="edit_input" name="subject" value="<%=subject%>">
      </td>
    </tr>


    <tr>
      <td align="right"><%=r.getString(teasession._nLanguage, "副标题")%>：</td>
      <td>
        <input type="text" size=70 maxlength=255  class="edit_input" name="subtitle" value="<%=meeting.getNULL(meeting.getSubtitle()) %>">
      </td>
    </tr>

      <tr>
      <td align="right"><%=r.getString(teasession._nLanguage, "导语")%>：</td>
      <td>
       <textarea rows="3" cols="55" name="lead"><%=meeting.getNULL(meeting.getLead()) %></textarea>
      </td>
    </tr>


    <tr>
      <td align="right"><%=r.getString(teasession._nLanguage, "会议报名时间")%>：</td>
      <td>

                开始&nbsp;
        <input id="timeStart" name="timeStart" size="12"  value="<%if(meeting.getTimeStart()!=null)out.print(Entity.sdf.format(meeting.getTimeStart())); %>"  style="cursor:pointer" readonly="readonly" onclick="new Calendar().show('form1.timeStart');">
        <img style="margin-bottom:-8px;" style="cursor:pointer"  src="/tea/image/bbs_edit/table.gif"  style="cursor:pointer" onclick="new Calendar().show('form1.timeStart');" />
        &nbsp;结束&nbsp;
        <input id="timeStop" name="timeStop" size="12"  value="<%if(meeting.getTimeStop()!=null)out.print(Entity.sdf.format(meeting.getTimeStop())); %>"  style="cursor:pointer" readonly="readonly" onclick="new Calendar().show('form1.timeStop');" >
        <img style="margin-bottom:-8px;" style="cursor:pointer"  src="/tea/image/bbs_edit/table.gif"   style="cursor:pointer" onclick="new Calendar().show('form1.timeStop');" />

      </td>
    </tr>

    <tr>
      <td align="right"><%=r.getString(teasession._nLanguage, "会议举行时间")%>：</td>
      <td>

                开始&nbsp;
        <input id="timeHoldStart" name="timeHoldStart" size="12"  value="<%if(meeting.getTimeHoldStart()!=null)out.print(Entity.sdf.format(meeting.getTimeHoldStart())); %>"  style="cursor:pointer" readonly="readonly" onclick="new Calendar().show('form1.timeHoldStart');">
        <img style="margin-bottom:-8px;" style="cursor:pointer"  src="/tea/image/bbs_edit/table.gif"  style="cursor:pointer" onclick="new Calendar().show('form1.timeHoldStart');" />
        &nbsp;结束&nbsp;
        <input id="timeHoldStop" name="timeHoldStop" size="12"  value="<%if(meeting.getTimeHoldStop()!=null)out.print(Entity.sdf.format(meeting.getTimeHoldStop())); %>"  style="cursor:pointer" readonly="readonly" onclick="new Calendar().show('form1.timeHoldStop');" >
        <img style="margin-bottom:-8px;" style="cursor:pointer"  src="/tea/image/bbs_edit/table.gif"   style="cursor:pointer" onclick="new Calendar().show('form1.timeHoldStop');" />

      </td>
    </tr>

     <tr>
      <td align="right"><%=r.getString(teasession._nLanguage, "会议地址")%>：</td>
      <td>

    <select id="selProvince" name="selProvince" onChange = "getCity(this.options[this.selectedIndex].value,'')">
        <option value="">-省-</option>
        <%
        	for(int i=0;i<Meeting.PROVINCEP_TYPE.length;i++)
        	{
        		out.println("<option value="+Meeting.PROVINCEP_TYPE[i]);
        		if(Meeting.PROVINCEP_TYPE[i].equals(meeting.getProvince()))
        		{
        			out.print(" selected ");
        		}
        		out.println(">"+Meeting.PROVINCEP_TYPE[i]);
        		out.println("</option>");
        	}
        %>
    </select>

    <select id="selCity" name="selCity">
        <option>-市-</option>
    </select>
     <%
      	if(meeting.getProvince()!=null && meeting.getProvince().length()>0)
      	{
      		out.println("<script>getCity('"+meeting.getProvince()+"','"+meeting.getCity2()+"');</script>");

      	}

      %>
    <input type="text" name="address" value="<%=meeting.getNULL(meeting.getAddress()) %>" title="详细地址">
    <input type="hidden"  size=50 class="edit_input" value="<%=meeting.getNULL(meeting.getMap()) %>"  name="map" >
	&nbsp;<a href="###" onClick="javascript:bMap();">地图</a>
	<script type="text/javascript">
      function bMap(){
    		//window.open('/jsp/admin/map/EditBMap.jsp?field=form1.map','_blank','width=600,height=500');
    		var selProvince = document.getElementById("selProvince");
    		var selCity = document.getElementById("selCity");
    		var province=selProvince.options[selProvince.selectedIndex].value;
    		var city= selCity.options[selCity.selectedIndex].value;
    		var address = form1.address.value;
    		var pointAndZoom = form1.map.value;
    		var searchVal = province+city+address;
    		//alert(searchVal);
    		mt.show('/jsp/admin/map/EditBMap.jsp?pointAndZoom='+pointAndZoom+'&searchVal='+searchVal,0,'地图标注',800,600);
    	}
      mt.remap=function(pointAndZoom,province,city,address){
    	  form1.map.value=pointAndZoom;
    	  form1.selProvince.value=province;
    	  form1.address.value=address;
    	  getCity(province,city);
      };
      </script>
      </td>
    </tr>

     <%-- <tr>
      <td align="right"><%=r.getString(teasession._nLanguage, "会议类别")%>：</td>
      <td>
      	<select name="eventtype">

      		<%
      			for(int i=0;i<Meeting.EVENT_TYPE.length;i++)
      			{
      				out.print("<option value="+i);
      				if(meeting.getEventtype()==i)
      				{
      					out.println(" selected ");
      				}
      				out.print(">"+Meeting.EVENT_TYPE[i]);
      				out.print("</option>");
      			}
      		%>
      	</select>
      </td>
      </tr> --%>

    <%-- <tr>
      <td align="right"><%=r.getString(teasession._nLanguage, "会议积分")%>：</td>
      <td>
        <input type="text" name="integral" value="<%=meeting.getIntegral() %>" size=4 maxlength="4" >
      </td>
    </tr> --%>


    <tr>
      <td align="right"><%=r.getString(teasession._nLanguage, "参会资格")%>：</td>
      <td>
        <input type="text" class="edit_input"  name="prescribe" value="<%=meeting.getPrescribe()%>">
      </td>
    </tr>
    
	<tr>
        <td nowrap align="right"><%=r.getString(teasession._nLanguage, "内容简介")%>：</td>
        <td>
          <input type="checkbox" name="nonuse" value="checkbox" onClick="f_myeditor(this,'nonuse','content')"><%=r.getString(teasession._nLanguage, "NonuseEditor")%>
        </td>
      </tr>
       <tr>
        <td colspan="2">
          <textarea name="content" rows="12" cols="90" class="edit_input"><%=content%></textarea>
          <script>if(mt.isIE6)document.write("<iframe id='editor' src='/jsp/include/FCKeditor/editor/fckeditor.html?InstanceName=content&Toolbar=<%=teasession._strCommunity%>' width='730' height='300' frameborder='no' scrolling='no'></iframe>");</script>
        </td>
      </tr>
      
      <tr>
        <td nowrap align="right"><%=r.getString(teasession._nLanguage, "议题")%>：</td>
        <td>
          <input type="checkbox" name="nonuse2" value="checkbox" onClick="f_myeditor(this,'nonuse2','issue')"><%=r.getString(teasession._nLanguage, "NonuseEditor")%>
        </td>
      </tr>
       <tr>
        <td colspan="2">
          <textarea name="issue" rows="12" cols="90" class="edit_input"><%=issue%></textarea>
          <script>if(mt.isIE6)document.write("<iframe id='editor2' src='/jsp/include/FCKeditor/editor/fckeditor.html?InstanceName=issue&Toolbar=<%=teasession._strCommunity%>' width='730' height='300' frameborder='no' scrolling='no'></iframe>");</script>
        </td>
      </tr>
      
     <tr>
      <td align="right"><%=r.getString(teasession._nLanguage, "大图上传")%>：</td>
      <td>
          <INPUT TYPE=FILE NAME=bigPicture onDblClick="window.open('<%=getNull(meeting.getBigPicture()).replaceAll("\\\\","/")%>');" class="edit_input">
          <%if(lp1len != 0){ out.print("<a href="+meeting.getBigPicture()+"  target=_blank>"+lp1len+"</a>" + r.getString(teasession._nLanguage, "Bytes"));%><INPUT  id=CHECKBOX type="CHECKBOX" NAME=ClearBigPicture VALUE=null  onclick='form1.bigPicture.disabled=this.checked'><%=r.getString(teasession._nLanguage, "Clear")%><%} %>
      </td>
    </tr>
        <tr>
      <td align="right"><%=r.getString(teasession._nLanguage, "小图上传")%>：</td>
      <td>
          <INPUT TYPE=FILE NAME=introPicture onDblClick="window.open('<%=meeting.getIntroPicture()%>');" class="edit_input">
          <%if(iplen != 0){ out.print("<a href="+meeting.getIntroPicture()+"  target=_blank>"+iplen+"</a>" + r.getString(teasession._nLanguage, "Bytes"));%><INPUT  id=CHECKBOX type="CHECKBOX" NAME=ClearIntroPicture VALUE=null  onclick='form1.introPicture.disabled=this.checked'><%=r.getString(teasession._nLanguage, "Clear")%><%} %>
      </td>
    </tr>

     <tr>
      <td align="right"><%=r.getString(teasession._nLanguage, "组织单位")%>：</td>
      <td>
        <input type="text" class="edit_input"  name="corp" value="<%=meeting.getNULL(meeting.getCorp()) %>">
      </td>
    </tr>

    <tr>
      <td align="right"><%=r.getString(teasession._nLanguage, "负责人")%>：</td>
      <td>
        <input type="text" name="organise"  class="edit_input" value="<%=meeting.getNULL(meeting.getOrganise()) %>">
      </td>
    </tr>

   <tr>
      <td align="right"><%=r.getString(teasession._nLanguage, "联系电话")%>：</td>
      <td>
        <input type="text" class="edit_input"  name="linkman" value="<%=meeting.getLinkman()%>">
      </td>
    </tr>

    <tr>
      <td align="right"><%=r.getString(teasession._nLanguage, "会议预算")%>：</td>
      <td>
        <input type="text" class="edit_input"  name="carfare" value="<%=meeting.getNULL(meeting.getCarfare()) %>">
      </td>
    </tr>

     <tr>
      <td align="right"><%=r.getString(teasession._nLanguage, "参会个人需缴纳的费用")%>：</td>
      <td>
        <input type="text" class="edit_input"  name="feature" value="<%=meeting.getFeature()%>">&nbsp;RMB
      </td>
    </tr>
   <tr>
      <td align="right"><%=r.getString(teasession._nLanguage, "是否安排餐饮")%>：</td>
      <td>
        <input type="radio" name="catering"  value="0" <%if(meeting.getCatering()==0){out.println(" checked");} %>>&nbsp;是　
        <input type="radio" name="catering" value="1" <%if(meeting.getCatering()==1){out.println(" checked");} %>>&nbsp;否
      </td>
    </tr>
     <tr>
      <td align="right"><%=r.getString(teasession._nLanguage, "是否安排住宿")%>：</td>
      <td>
        <input type="radio" name="stay" value="0" <%if(meeting.getStay()==0){out.println(" checked");} %>>&nbsp;是　
        <input type="radio" name="stay" value="1" <%if(meeting.getStay()==1){out.println(" checked");} %>>&nbsp;否
      </td>
    </tr>
     <tr>
      <td align="right"><%=r.getString(teasession._nLanguage, "是否安排接送")%>：</td>
      <td>
        <input type="radio" name="shuttle" value="0" <%if(meeting.getShuttle()==0){out.println(" checked");} %>>&nbsp;是　
        <input type="radio" name="shuttle" value="1" <%if(meeting.getShuttle()==1){out.println(" checked");} %>>&nbsp;否
      </td>
    </tr>

  </table>
  <br>
  <center>
  <INPUT TYPE=SUBMIT name="GoFinish" ID="edit_GoFinish" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "Submit")%>">&nbsp;
  <input type="button" name="reset" value="返回"  onclick="window.open('<%=teasession.getParameter("nexturl")%>','_self');">

</center></form>
  <div id="language"><%=new Languages(teasession._nLanguage,request)%>  </div>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>

