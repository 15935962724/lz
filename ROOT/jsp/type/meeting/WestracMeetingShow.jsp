<%@page contentType="text/html;charset=UTF-8"  %>
<%@include file="/jsp/Header.jsp"%>
<%@page import="tea.entity.node.Meeting"%>
<%

/* if(!AccessMember.find(node._nNode, teasession._rv._strV).isProvider(114))
{
  response.sendError(403);
  return;
} */
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
  flyerdata=HtmlElement.htmlToText(meeting.getFlyerData());
}
%>
<INPUT TYPE="hidden" NAME="TypeAlias" VALUE="<%=request.getParameter("TypeAlias")%>">
 <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td align="right"><%=r.getString(teasession._nLanguage, "会议标题")%>：</td>
      <td>
        <%=subject%>
      </td>
    </tr>


    <tr>
      <td align="right"><%=r.getString(teasession._nLanguage, "副标题")%>：</td>
      <td>
        <%=meeting.getNULL(meeting.getSubtitle()) %>
      </td>
    </tr>

      <tr>
      <td align="right"><%=r.getString(teasession._nLanguage, "导语")%>：</td>
      <td>
       <%=meeting.getNULL(meeting.getLead()) %>
      </td>
    </tr>


    <tr>
      <td align="right"><%=r.getString(teasession._nLanguage, "会议报名时间")%>：</td>
      <td>
		开始&nbsp;<%if(meeting.getTimeStart()!=null)out.print(Entity.sdf.format(meeting.getTimeStart())); %>
        &nbsp;结束&nbsp;
       <%if(meeting.getTimeStop()!=null)out.print(Entity.sdf.format(meeting.getTimeStop())); %>

      </td>
    </tr>

    <tr>
      <td align="right"><%=r.getString(teasession._nLanguage, "会议举行时间")%>：</td>
      <td>
	     开始&nbsp;<%if(meeting.getTimeHoldStart()!=null)out.print(Entity.sdf.format(meeting.getTimeHoldStart())); %>
        &nbsp;结束&nbsp;
       <%if(meeting.getTimeHoldStop()!=null)out.print(Entity.sdf.format(meeting.getTimeHoldStop())); %>

      </td>
    </tr>

     <tr>
      <td align="right"><%=r.getString(teasession._nLanguage, "会议地址")%>：</td>
      <td><%=Entity.getNULL(meeting.getProvince())+"&nbsp;"+(!"-市-".equals(meeting.getCity2())?meeting.getCity2():"") %>&nbsp;<%=meeting.getNULL(meeting.getAddress()) %>
      <input type=hidden  size=50 class="edit_input" value="<%=meeting.getNULL(meeting.getMap()) %>"  name="map" >
      <%
    	
    if(meeting.getMap()!=null&&meeting.getMap().length()>0)
    {
    	String map = meeting.getMap();
    	String maparr[] = map.split(",");
    
        
        String url = "/jsp/admin/map/ViewGMap.jsp?node=" + teasession._nNode+ "&amp;point="+map;
    	
        out.print("<a href=\"###\" onClick=window.open('"+url+"','_blank','width=600,height=500'); >地图</a>");
    }
    %>
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
        <%=meeting.getPrescribe()%>
      </td>
    </tr>


  <tr >
    <td nowrap align="right"><%=r.getString(teasession._nLanguage, "内容简介")%>:</TD>
   
<td><%=content%></td>
  </tr>


     <tr>
      <td align="right"><%=r.getString(teasession._nLanguage, "大图上传")%>：</td>
      <td>
         
          <%if(lp1len != 0){ out.print("<a href="+meeting.getBigPicture()+"  target=_blank>"+lp1len+"</a>" + r.getString(teasession._nLanguage, "Bytes"));%><%} %>
      </td>
    </tr>
        <tr>
      <td align="right"><%=r.getString(teasession._nLanguage, "小图上传")%>：</td>
      <td>
          
          <%if(iplen != 0){ out.print("<a href="+meeting.getIntroPicture()+"  target=_blank>"+iplen+"</a>" + r.getString(teasession._nLanguage, "Bytes"));%><%} %>
      </td>
    </tr>

     <tr>
      <td align="right"><%=r.getString(teasession._nLanguage, "组织单位")%>：</td>
      <td>
        <%=meeting.getNULL(meeting.getCorp()) %>
      </td>
    </tr>

    <tr>
      <td align="right"><%=r.getString(teasession._nLanguage, "负责人")%>：</td>
      <td>
        <%=meeting.getNULL(meeting.getOrganise()) %>
      </td>
    </tr>

   <tr>
      <td align="right"><%=r.getString(teasession._nLanguage, "联系电话")%>：</td>
      <td>
        <%=meeting.getLinkman()%>
      </td>
    </tr>

    <tr>
      <td align="right"><%=r.getString(teasession._nLanguage, "会议预算")%>：</td>
      <td>
        <%=meeting.getNULL(meeting.getCarfare()) %>
      </td>
    </tr>

     <tr>
      <td align="right"><%=r.getString(teasession._nLanguage, "参会个人需缴纳的费用")%>：</td>
      <td>
        <%=meeting.getFeature()%>&nbsp;RMB
      </td>
    </tr>
   <tr>
      <td align="right"><%=r.getString(teasession._nLanguage, "是否安排餐饮")%>：</td>
      <td>
        <%if(meeting.getCatering()==0){out.println(" 是");} %>
        <%if(meeting.getCatering()==1){out.println(" 否");} %>
      </td>
    </tr>
     <tr>
      <td align="right"><%=r.getString(teasession._nLanguage, "是否安排住宿")%>：</td>
      <td>
         <%if(meeting.getStay()==0){out.println(" 是");} %>
         <%if(meeting.getStay()==1){out.println(" 否");} %>
      </td>
    </tr>
     <tr>
      <td align="right"><%=r.getString(teasession._nLanguage, "是否安排接送")%>：</td>
      <td>
        <%if(meeting.getShuttle()==0){out.println(" 是");} %>
         <%if(meeting.getShuttle()==1){out.println(" 否");} %>
      </td>
    </tr>

  </table>
  <br>
  <center>
  <input type="button" name="reset" value="返回"  onclick="window.open('<%=teasession.getParameter("nexturl")%>','_self');">

</center></form>
  <%-- <div id="language"><%=new Languages(teasession._nLanguage,request)%>  </div> --%>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>

