<%@page contentType="text/html;charset=UTF-8"  %>
<%@include file="/jsp/Header.jsp"%>
<%

if(!AccessMember.find(node._nNode, teasession._rv._strV).isProvider(37))
{
  response.sendError(403);
  return;
}
 r.add("/tea/resource/Event");


long lp1len=0;
long iplen=0;
float integral = 0;

String subject="",content="";
String flyerdata="";

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/tea/Calendar.js" type="text/javascript"></script>
<script src="/tea/city2.js" type="text/javascript"></script>
<script type="text/javascript">
function on_sel_rela(index)
{
//	open_win('ProductSel.jsp?index='+index,'','scrollbars',450,700);
//window.open('ProductSel.jsp?index='+index);
  window.showModalDialog("/jsp/type/nightshop/NightShopList.jsp?node=<%=teasession._nNode%>&index="+index,self,"edge:raised;status:0;help:0;resizable:1;dialogWidth:450px;dialogHeight:550px;dialogTop:"+100+";dialogLeft:"+150+"");
}

function f_load()
{
  f_editor();
  form1.subject.focus();
}
function f_sub()
{
	  if(form1.subject.value==''){
		  alert('请填写活动名称');
		  form1.subject.focus();
		  return false;
	  }
	  if(form1.timeStart.value=='')
		  {
		  	alert("请填写活动报名开始时间");
		  	form1.timeStart.focus();
		  	return false;
		  }
	  if(form1.timeStop.value=='')
		{
		  	alert("请填写活动报名结束时间");
		  	form1.timeStop.focus();
		  	return false;

		}
	  if(form1.timeHoldStart.value=='')
	  {
	  	alert("请填写活动举行开始时间");
	  	form1.timeHoldStart.focus();
	  	return false;
	  }
	  if(form1.timeHoldStop.value=='')
		{
		  	alert("请填写活动举行结束时间");
		  	form1.timeHoldStop.focus();
		  	return false;

		}

}
</script>
</head>
<body onload="f_load()">
<h1><%=r.getString(teasession._nLanguage, "Event")%><%=r.getString(teasession._nLanguage, "Edit")%></h1>
  <div id="head6"><img height="6" src="about:blank"></div>


<form name="form1" method="post" action="/servlet/EditEvent"  ENCtype=multipart/form-data target="_ajax" onSubmit="return f_sub();">
<input type="hidden" name="node" value="<%=teasession._nNode%>">
<input type="hidden" name="nexturl" value="<%=teasession.getParameter("nexturl")%>">
<input type="hidden" name="adminrole" value="<%=teasession.getParameter("adminrole") %>">
<%
Event event ;
String parameter=teasession.getParameter("nexturl");

boolean parambool=(parameter!=null&&!parameter.equals("null"));
if(parambool)
{
  out.print("<input type='hidden' name=nexturl value="+parameter+">");
}
if(request.getParameter("NewNode")!=null)
{
  event = Event.find(0, teasession._nLanguage);
  out.println("<INPUT TYPE=hidden NAME=NewNode VALUE=ON>");
}else
{
  event = Event.find(teasession._nNode, teasession._nLanguage);
  if(event.getBigPicture()!=null && event.getBigPicture().length()>0)
  {
    java.io.File file=new File(application.getRealPath(event.getBigPicture()));
    lp1len=file.length();
  }
  if(event.getIntroPicture()!=null && event.getIntroPicture().length()>0)
  {
    java.io.File file=new File(application.getRealPath(event.getIntroPicture()));
    iplen=file.length();
  }
  subject=HtmlElement.htmlToText(node.getSubject(teasession._nLanguage));
  content=HtmlElement.htmlToText(node.getText(teasession._nLanguage));
  flyerdata=HtmlElement.htmlToText(event.getFlyerData());
}
%>
<INPUT TYPE="hidden" NAME="TypeAlias" VALUE="<%=request.getParameter("TypeAlias")%>">
 <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td align="right"><%=r.getString(teasession._nLanguage, "活动标题")%>：</td>
      <td>
        <input type="text" size=70 maxlength=255  class="edit_input" name="subject" value="<%=subject%>">
      </td>
    </tr>


    <tr>
      <td align="right"><%=r.getString(teasession._nLanguage, "副标题")%>：</td>
      <td>
        <input type="text" size=70 maxlength=255  class="edit_input" name="subtitle" value="<%=event.getNULL(event.getSubtitle()) %>">
      </td>
    </tr>

      <tr>
      <td align="right"><%=r.getString(teasession._nLanguage, "导语")%>：</td>
      <td>
       <textarea rows="3" cols="55" name="lead"><%=event.getNULL(event.getLead()) %></textarea>
      </td>
    </tr>


    <tr>
      <td align="right"><%=r.getString(teasession._nLanguage, "活动报名时间")%>：</td>
      <td>

                开始&nbsp;
        <input id="timeStart" name="timeStart" size="12"  value="<%if(event.getTimeStart()!=null)out.print(Entity.sdf.format(event.getTimeStart())); %>"  style="cursor:pointer" readonly="readonly" onclick="new Calendar().show('form1.timeStart');">
        <img style="margin-bottom:-8px;" style="cursor:pointer"  src="/tea/image/bbs_edit/table.gif"  style="cursor:pointer" onclick="new Calendar().show('form1.timeStart');" />
        &nbsp;结束&nbsp;
        <input id="timeStop" name="timeStop" size="12"  value="<%if(event.getTimeStop()!=null)out.print(Entity.sdf.format(event.getTimeStop())); %>"  style="cursor:pointer" readonly="readonly" onclick="new Calendar().show('form1.timeStop');" >
        <img style="margin-bottom:-8px;" style="cursor:pointer"  src="/tea/image/bbs_edit/table.gif"   style="cursor:pointer" onclick="new Calendar().show('form1.timeStop');" />

      </td>
    </tr>

    <tr>
      <td align="right"><%=r.getString(teasession._nLanguage, "活动举行时间")%>：</td>
      <td>

                开始&nbsp;
        <input id="timeHoldStart" name="timeHoldStart" size="12"  value="<%if(event.getTimeHoldStart()!=null)out.print(Entity.sdf.format(event.getTimeHoldStart())); %>"  style="cursor:pointer" readonly="readonly" onclick="new Calendar().show('form1.timeHoldStart');">
        <img style="margin-bottom:-8px;" style="cursor:pointer"  src="/tea/image/bbs_edit/table.gif"  style="cursor:pointer" onclick="new Calendar().show('form1.timeHoldStart');" />
        &nbsp;结束&nbsp;
        <input id="timeHoldStop" name="timeHoldStop" size="12"  value="<%if(event.getTimeHoldStop()!=null)out.print(Entity.sdf.format(event.getTimeHoldStop())); %>"  style="cursor:pointer" readonly="readonly" onclick="new Calendar().show('form1.timeHoldStop');" >
        <img style="margin-bottom:-8px;" style="cursor:pointer"  src="/tea/image/bbs_edit/table.gif"   style="cursor:pointer" onclick="new Calendar().show('form1.timeHoldStop');" />

      </td>
    </tr>

     <tr>
      <td align="right"><%=r.getString(teasession._nLanguage, "活动地址")%>：</td>
      <td>

    <select id="selProvince" name="selProvince" onChange = "getCity(this.options[this.selectedIndex].value,'')">
        <option value="">-省-</option>
        <%
        	for(int i=0;i<Event.PROVINCEP_TYPE.length;i++)
        	{
        		out.println("<option value="+Event.PROVINCEP_TYPE[i]);
        		if(Event.PROVINCEP_TYPE[i].equals(event.getProvince()))
        		{
        			out.print(" selected ");
        		}
        		out.println(">"+Event.PROVINCEP_TYPE[i]);
        		out.println("</option>");
        	}
        %>
    </select>

    <select id="selCity" name="selCity">
        <option>-市-</option>
    </select>
     <%
      	if(event.getProvince()!=null && event.getProvince().length()>0)
      	{
      		out.println("<script>getCity('"+event.getProvince()+"','"+event.getCity2()+"');</script>");

      	}

      %>
    <input type="text" name="address" value="<%=event.getNULL(event.getAddress()) %>" title="详细地址">
    <input type=hidden  size=50 class="edit_input" value="<%=event.getNULL(event.getMap()) %>"  name="map" >
	&nbsp;<a href="###" onClick="window.open('/jsp/admin/map/EditGMap.jsp?field=form1.map','_blank','width=600,height=500');">地图</a>
      </td>
    </tr>

     <tr>
      <td align="right"><%=r.getString(teasession._nLanguage, "活动类别")%>：</td>
      <td>
      	<select name="eventtype">

      		<%
      			for(int i=0;i<Event.EVENT_TYPE.length;i++)
      			{
      				out.print("<option value="+i);
      				if(event.getEventtype()==i)
      				{
      					out.println(" selected ");
      				}
      				out.print(">"+Event.EVENT_TYPE[i]);
      				out.print("</option>");
      			}
      		%>
      	</select>
      </td>
      </tr>

    <tr>
      <td align="right"><%=r.getString(teasession._nLanguage, "活动积分")%>：</td>
      <td>
        <input type="text" name="integral" value="<%=event.getIntegral() %>" size=4 maxlength="4" >
      </td>
    </tr>


    <tr>
      <td align="right"><%=r.getString(teasession._nLanguage, "参会资格")%>：</td>
      <td>
        <input type="text" class="edit_input"  name="prescribe" value="<%=event.getPrescribe()%>">
      </td>
    </tr>


  <tr >
    <td nowrap align="right"><%=r.getString(teasession._nLanguage, "内容简介")%>:</TD>
    <td nowrap><input  id="radio" type="radio" name=TextOrHtml value=0 checked="checked">
      <%=r.getString(teasession._nLanguage, "文本")%>
      <input  id="radio" type="radio" name=TextOrHtml value=1  >HTML

      <input  id="CHECKBOX" type="checkbox" name="nonuse" value="checkbox" onClick="f_editor(this)"><label for="nonuse"><%=r.getString(teasession._nLanguage, "不使用多媒体编辑器")%></label>
        <input type="checkbox" name="srccopy"/>源网站的图片贴入本地
<%
boolean isFtp=new File(application.getRealPath("/res/"+teasession._strCommunity+"/ftp/")).exists();
if(isFtp)
out.print("<input type='button' value='选择图片' onclick=window.open('/jsp/site/FFtps.jsp?community="+teasession._strCommunity+"&oby=2','_blank','width=680px,height=400px,resizable=1'); />");
%>
    </td>
  </tr>
  <tr >
<td></td>
    <td nowrap >

      <textarea style="display:none" name="content" rows="12" cols="90" class="edit_input"><%=content%></textarea>
      <iframe id="editor" src="/jsp/include/FCKeditor/editor/fckeditor.html?InstanceName=content&Toolbar=<%=teasession._strCommunity%>" width="740" height="300" frameborder="no" scrolling="no"></iframe>

    </td>
  </tr>


     <tr>
      <td align="right"><%=r.getString(teasession._nLanguage, "大图上传")%>：</td>
      <td>
          <INPUT TYPE=FILE NAME=bigPicture onDblClick="window.open('<%=getNull(event.getBigPicture()).replaceAll("\\\\","/")%>');" class="edit_input">
          <%if(lp1len != 0){ out.print("<a href="+event.getBigPicture()+"  target=_blank>"+lp1len+"</a>" + r.getString(teasession._nLanguage, "Bytes"));%><INPUT  id=CHECKBOX type="CHECKBOX" NAME=ClearBigPicture VALUE=null  onclick='form1.bigPicture.disabled=this.checked'><%=r.getString(teasession._nLanguage, "Clear")%><%} %>
      </td>
    </tr>
        <tr>
      <td align="right"><%=r.getString(teasession._nLanguage, "小图上传")%>：</td>
      <td>
          <INPUT TYPE=FILE NAME=introPicture onDblClick="window.open('<%=event.getIntroPicture()%>');" class="edit_input">
          <%if(iplen != 0){ out.print("<a href="+event.getIntroPicture()+"  target=_blank>"+iplen+"</a>" + r.getString(teasession._nLanguage, "Bytes"));%><INPUT  id=CHECKBOX type="CHECKBOX" NAME=ClearIntroPicture VALUE=null  onclick='form1.introPicture.disabled=this.checked'><%=r.getString(teasession._nLanguage, "Clear")%><%} %>
      </td>
    </tr>

     <tr>
      <td align="right"><%=r.getString(teasession._nLanguage, "组织单位")%>：</td>
      <td>
        <input type="text" class="edit_input"  name="corp" value="<%=event.getNULL(event.getCorp()) %>">
      </td>
    </tr>

    <tr>
      <td align="right"><%=r.getString(teasession._nLanguage, "负责人")%>：</td>
      <td>
        <input type="text" name="organise"  class="edit_input" value="<%=event.getNULL(event.getOrganise()) %>">
      </td>
    </tr>

   <tr>
      <td align="right"><%=r.getString(teasession._nLanguage, "联系电话")%>：</td>
      <td>
        <input type="text" class="edit_input"  name="linkman" value="<%=event.getLinkman()%>">
      </td>
    </tr>

    <tr>
      <td align="right"><%=r.getString(teasession._nLanguage, "活动预算")%>：</td>
      <td>
        <input type="text" class="edit_input"  name="carfare" value="<%=event.getNULL(event.getCarfare()) %>">
      </td>
    </tr>

     <tr>
      <td align="right"><%=r.getString(teasession._nLanguage, "参会个人需缴纳的费用")%>：</td>
      <td>
        <input type="text" class="edit_input"  name="feature" value="<%=event.getFeature()%>">&nbsp;RMB
      </td>
    </tr>
   <tr>
      <td align="right"><%=r.getString(teasession._nLanguage, "是否安排餐饮")%>：</td>
      <td>
        <input type="radio" name="catering"  value="0" <%if(event.getCatering()==0){out.println(" checked");} %>>&nbsp;是　
        <input type="radio" name="catering" value="1" <%if(event.getCatering()==1){out.println(" checked");} %>>&nbsp;否
      </td>
    </tr>
     <tr>
      <td align="right"><%=r.getString(teasession._nLanguage, "是否安排住宿")%>：</td>
      <td>
        <input type="radio" name="stay" value="0" <%if(event.getStay()==0){out.println(" checked");} %>>&nbsp;是　
        <input type="radio" name="stay" value="1" <%if(event.getStay()==1){out.println(" checked");} %>>&nbsp;否
      </td>
    </tr>
     <tr>
      <td align="right"><%=r.getString(teasession._nLanguage, "是否安排接送")%>：</td>
      <td>
        <input type="radio" name="shuttle" value="0" <%if(event.getShuttle()==0){out.println(" checked");} %>>&nbsp;是　
        <input type="radio" name="shuttle" value="1" <%if(event.getShuttle()==1){out.println(" checked");} %>>&nbsp;否
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

