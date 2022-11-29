<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter" %>
<%@ page  import="tea.resource.*"  %>
<%@ page  import="tea.entity.admin.sales.*" %>
<%@ page  import="tea.entity.admin.*" %>
<%@ page  import="tea.htmlx.*" %>
<%@ page import="tea.ui.TeaSession" %>
<%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String community=teasession._strCommunity;

Resource r=new Resource("/tea/resource/Workreport");

int saleslinkman=Integer.parseInt(request.getParameter("saleslinkman"));

String name=null;
String tel=null;
String mobile=null;
String email=null;
int client=0;// 客户
boolean clienttype=false;
int supervisor=0;// 直属上司
String job=null;
// /////////邮寄地址
String country=null;
String postcode=null;
String state=null;
String city=null;
String street=null;
// /////////其他地址
String country2=null;
String postcode2=null;
String state2=null;
String city2=null;
String street2=null;

String fax=null;
int origin=0;
String hometel=null;
java.util.Date birth=null;
String othertel=null;
String unit=null;
String assistant=null;
String assistanttel=null;

String content=null;
if(saleslinkman>0)
{
  SalesLinkman obj=SalesLinkman.find(saleslinkman);
  name=obj.getName(teasession._nLanguage);
  tel=obj.getTel();
  mobile=obj.getMobile();
  email=obj.getEmail();
  client=obj.getClient();// 客户
  clienttype=obj.isClienttype();
  supervisor=obj.getSupervisor();// 直属上司
  job=obj.getJob();
  
  country=obj.getCountry();
  postcode=obj.getPostcode();
  state=obj.getState();
  city=obj.getCity();
  street=obj.getStreet();
  
  country2=obj.getCountry2();
  postcode2=obj.getPostcode2();
  state2=obj.getState2();
  city2=obj.getCity2();
  street2=obj.getStreet2();

  fax=obj.getFax();
  origin=obj.getOrigin();
  hometel=obj.getHometel();
  birth=obj.getBirth();
  othertel=obj.getOthertel();
  unit=obj.getUnit();
  assistant=obj.getAssistant();
  assistanttel=obj.getAssistanttel();
  content=obj.getContent();
}

String nexturl=request.getParameter("nexturl");

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<body onLoad="form1.name.focus();">
<!--联系人管理-->
<h1><%=r.getString(teasession._nLanguage,"联系人管理")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br>
<form name=form1 METHOD=get action="/servlet/EditSalesLinkman" onSubmit="return submitText(this.name,'<%=r.getString(teasession._nLanguage,"InvalidSubject")%>')">
  <input type=hidden name="community" value="<%=community%>"/>
  <input type=hidden name="saleslinkman" value="<%=saleslinkman%>"/>
  <input type=hidden name="nexturl" value="<%=nexturl%>"/>
  <input type=hidden name="act" value="editsaleslinkman"/>
  <h2>联系人信息</h2>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td><%=r.getString(teasession._nLanguage,"姓名")%>
          <!--名称--></td>
      <td><%if(name!=null)out.print(name);%></td>
      <td><%=r.getString(teasession._nLanguage,"1168574945796")%>
          <!--电话--></td>
      <td><%if(tel!=null)out.print(tel);%></td>
    </tr>
    <tr>
	<td>手机</td>
      <td><%if(mobile!=null)out.print(mobile);%></td>
	        <td>E-Mail</td>
      <td><%if(email!=null)out.print(email);%></td>
    </tr>
    <tr>
      <td>客户</td>
      <td>
         <%
         if(client>0)
         {
         	out.print(clienttype?Workproject.find(client).getName(teasession._nLanguage):Latency.find(client).getFamily());
         }
          %>
       </td>
      <td>直属上司</td>
      <td>
         <%
          if(supervisor>0)
          {
        	SalesLinkman sl=SalesLinkman.find(supervisor);
			out.print(sl.getName(teasession._nLanguage));
          }
          %></td>
    </tr>
	<tr>
      <td>职务</td>
      <td><%if(job!=null)out.print(job);%></td>
    </tr>
  </table>
  <h2>地址信息</h2>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td>邮寄地址 - 国家/地区</td>
      <td ><%=new CountrySelection(teasession._nLanguage,country)%></td>
      <td> 其他地址 - 国家/地区 </td>
      <td ><%=new CountrySelection(teasession._nLanguage,country2)%></td>
    </tr>
    <tr>
      <td> 邮寄地址 - 邮政编码 </td>
      <td><%if(postcode!=null)out.print(postcode);%></td>
      <td> 其他地址 - 邮政编码 </td>
      <td><%if(postcode2!=null)out.print(postcode2);%></td>
    </tr>
    <tr>
      <td> 邮寄地址 - 州/省 </td>
      <td ><%if(state!=null)out.print(state);%></td>
      <td> 其他地址 - 州/省 </td>
      <td><%if(state2!=null)out.print(state2);%></td>
    </tr>
    <tr>
      <td> 邮寄地址 - 城市 </td>
      <td><%if(city!=null)out.print(city);%></td>
      <td> 其他地址 - 城市 </td>
      <td><%if(city2!=null)out.print(city2);%></td>
    </tr>
    <tr>
      <td>邮寄地址 - 街道</td>
      <td><%if(street!=null)out.print(street);%></td>
      <td> 其他地址 - 街道 </td>
      <td><%if(street2!=null)out.print(street2);%></td>
    </tr>
  </table>
   <h2>其他信息</h2>
   <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr>
       <td>传真</td>
       <td ><%if(fax!=null)out.print(fax);%></td>
       <td>潜在客户来源</td>
       <td>
           <%
			if(origin>0)
			out.print(r.getString(teasession._nLanguage,Latency.ORIGIN[origin]));
          %></td>
     </tr>
     <tr>
       <td>家庭电话</td>
       <td><%if(hometel!=null)out.print(hometel);%></td>
       <td>出生日期</td>
       <td><%if(birth!=null)out.print(birth);%></td>
     </tr>
     <tr>
       <td>其他电话</td>
       <td><%if(othertel!=null)out.print(othertel);%></td>
       <td>部门</td>
       <td><%if(unit!=null)out.print(unit);%></td>
     </tr>
     <tr>
       <td>助理</td>
       <td><%if(assistant!=null)out.print(assistant);%></td>
       <td>&nbsp;</td>
       <td>&nbsp;</td>
     </tr>
     <tr>
       <td>助理电话</td>
       <td><%if(assistanttel!=null)out.print(assistanttel);%></td>
       <td>&nbsp;</td>
       <td>&nbsp;</td>
     </tr>
     <tr>
       <td><%=r.getString(teasession._nLanguage,"Text")%>
           <!--内容--></td>
       <td colspan="3"><%if(content!=null)out.print(content);%></td>
     </tr>
   </table>

</form>
<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>


