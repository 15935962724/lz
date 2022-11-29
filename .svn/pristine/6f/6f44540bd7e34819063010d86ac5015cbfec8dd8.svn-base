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
<script src="/tea/Calendar.js" type="text/javascript"></script>
<script src="/tea/city2.js" type="text/javascript"></script>

</head>
<body>
<h1>活动详细信息</h1>
  <div id="head6"><img height="6" src="about:blank"></div>


<form name="form1" method="post" action="/servlet/EditEvent"  ENCtype=multipart/form-data onSubmit="return f_sub();">
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
  content=(node.getText(teasession._nLanguage));
  flyerdata=HtmlElement.htmlToText(event.getFlyerData());
}
%>
<INPUT TYPE="hidden" NAME="TypeAlias" VALUE="<%=request.getParameter("TypeAlias")%>">
 <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td align="right"><%=r.getString(teasession._nLanguage, "活动标题")%>：</td>
      <td><%=subject%></td>
    </tr>
    
    
    <tr>
      <td align="right"><%=r.getString(teasession._nLanguage, "副标题")%>：</td>
      <td>
       <%=event.getNULL(event.getSubtitle()) %>
      </td>
    </tr>
    
      <tr>
      <td align="right"><%=r.getString(teasession._nLanguage, "导语")%>：</td>
      <td>
      <%=event.getNULL(event.getLead()) %>
      </td>
    </tr>
    
     
    <tr>
      <td align="right"><%=r.getString(teasession._nLanguage, "活动报名时间")%>：</td>
      <td>
   
                开始&nbsp;<%if(event.getTimeStart()!=null)out.print(Entity.sdf.format(event.getTimeStart())); %>
        &nbsp;结束&nbsp;
       <%if(event.getTimeStop()!=null)out.print(Entity.sdf.format(event.getTimeStop())); %>

      </td>
    </tr>
    
      <tr>
      <td align="right"><%=r.getString(teasession._nLanguage, "活动举行时间")%>：</td>
      <td>
   
                开始&nbsp;<%if(event.getTimeHoldStart()!=null)out.print(Entity.sdf.format(event.getTimeHoldStart())); %>
        &nbsp;结束&nbsp;
       <%if(event.getTimeHoldStop()!=null)out.print(Entity.sdf.format(event.getTimeHoldStop())); %>

      </td>
    </tr>
    
     <tr>
      <td align="right"><%=r.getString(teasession._nLanguage, "活动地址")%>：</td>
      <td><%=Entity.getNULL(event.getProvince())+"&nbsp;"+(!"-市-".equals(event.getCity2())?event.getCity2():"") %>&nbsp;<%=event.getNULL(event.getAddress()) %>
    <input type=hidden  size=50 class="edit_input" value="<%=event.getNULL(event.getMap()) %>"  name="map" >
    
    <%
    	
    if(event.getMap()!=null&&event.getMap().length()>0)
    {
    	String map = event.getMap();
    	String maparr[] = map.split(",");
    
        
        String url = "/jsp/admin/map/ViewGMap.jsp?node=" + teasession._nNode+ "&amp;point="+map;
    	
        out.print("<a href=\"###\" onClick=window.open('"+url+"','_blank','width=600,height=500'); >地图</a>");
    }
    %>
    
	
      </td>
    </tr>
    
     <tr>
      <td align="right"><%=r.getString(teasession._nLanguage, "活动类别")%>：</td>
      <td><%if(event.getEventtype()>0){out.println(Event.EVENT_TYPE[event.getEventtype()]);} %>
      	
      </td>
      </tr>
    
    <tr>
      <td align="right"><%=r.getString(teasession._nLanguage, "活动积分")%>：</td> 
      <td>
        <%=event.getIntegral() %>
      </td>
    </tr> 
    
    
    <tr>
      <td align="right"><%=r.getString(teasession._nLanguage, "参会资格")%>：</td>
      <td>
        <%=event.getPrescribe()%>
      </td>
    </tr>
    
   
  <tr >
    <td nowrap align="right"><%=r.getString(teasession._nLanguage, "内容简介")%>:</TD>
   
<td><%=content%></td>
  </tr>
  
    
     <tr>
      <td align="right"><%=r.getString(teasession._nLanguage, "大图上传")%>：</td>
      <td>
         
          <%if(lp1len != 0){ out.print("<a href="+event.getBigPicture()+"  target=_blank>"+lp1len+"</a>" + r.getString(teasession._nLanguage, "Bytes"));%><%} %>
      </td>
    </tr>
        <tr>
      <td align="right"><%=r.getString(teasession._nLanguage, "小图上传")%>：</td>
      <td>
          
          <%if(iplen != 0){ out.print("<a href="+event.getIntroPicture()+"  target=_blank>"+iplen+"</a>" + r.getString(teasession._nLanguage, "Bytes"));%><%} %>
      </td>
    </tr>
   
     <tr>
      <td align="right"><%=r.getString(teasession._nLanguage, "组织单位")%>：</td>
      <td>
       <%=event.getNULL(event.getCorp()) %>
      </td>
    </tr>
    
    <tr>
      <td align="right"><%=r.getString(teasession._nLanguage, "负责人")%>：</td>
      <td>
       <%=event.getNULL(event.getOrganise()) %>
      </td>
    </tr>
    
   <tr>
      <td align="right"><%=r.getString(teasession._nLanguage, "联系电话")%>：</td>
      <td>
        <%=event.getLinkman()%>
      </td>
    </tr>
    
    <tr>
      <td align="right"><%=r.getString(teasession._nLanguage, "活动预算")%>：</td>
      <td>
        <%=event.getNULL(event.getCarfare()) %>
      </td>
    </tr>
    
     <tr>
      <td align="right"><%=r.getString(teasession._nLanguage, "参会个人需缴纳的费用")%>：</td>
      <td>
        <%=event.getFeature()%>&nbsp;RMB
      </td>
    </tr>
   <tr>
      <td align="right"><%=r.getString(teasession._nLanguage, "是否安排餐饮")%>：</td>
      <td>
         <%if(event.getCatering()==0){out.println(" 是");} %>
        <%if(event.getCatering()==1){out.println(" 否");} %>
      </td>
    </tr>
     <tr>
      <td align="right"><%=r.getString(teasession._nLanguage, "是否安排住宿")%>：</td>
      <td>
         <%if(event.getStay()==0){out.println(" 是");} %>
         <%if(event.getStay()==1){out.println(" 否");} %>
      </td>
    </tr>
     <tr>
      <td align="right"><%=r.getString(teasession._nLanguage, "是否安排接送")%>：</td>
      <td>
         <%if(event.getShuttle()==0){out.println(" 是");} %>
         <%if(event.getShuttle()==1){out.println(" 否");} %>
      </td>
    </tr>

  </table>
  <br>
  <center>
  
  <input type="button" name="reset" value="返回"  onclick="window.open('<%=teasession.getParameter("nexturl")%>','_self');">
  
</center></form>

</body>
</html>

