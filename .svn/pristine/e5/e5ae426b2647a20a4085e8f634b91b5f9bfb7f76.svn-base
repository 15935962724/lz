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



//联系人管理
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<script>
function f_copy()
{
	form1.country2.value=form1.country.value;
	form1.postcode2.value=form1.postcode.value;
	form1.state2.value=form1.state.value;
	form1.city2.value=form1.city.value;
	form1.street2.value=form1.street.value;
}
</script>
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
      <td><input name="name" size="40"  value="<%if(name!=null)out.print(name);%>"></td>
      <td><%=r.getString(teasession._nLanguage,"1168574945796")%>
          <!--电话--></td>
      <td><input name="tel" size="30" value="<%if(tel!=null)out.print(tel);%>"></td>
    </tr>
    <tr>
	<td>手机</td>
      <td><input name="mobile" size="40" value="<%if(mobile!=null)out.print(mobile);%>"></td>
	        <td>E-Mail</td>
      <td><input name="email" size="40"  value="<%if(email!=null)out.print(email);%>"></td>
    </tr>
    <tr>
      <td>客户</td>
      <td>
      <input type=hidden name=clienttype value="<%=clienttype%>" >
      <select name="client" onChange="f_client(this.selectedIndex);">
      <option value="0">-------------
         <%
         int len=0;
         java.util.Enumeration e= Latency.findByCommunity(teasession._strCommunity,"");
          while(e.hasMoreElements())
          {
        	int id=((Integer)e.nextElement()).intValue();
        	Latency l=Latency.find(id);
			out.print("<option value="+id);
			if(!clienttype&&client==id)
			out.print(" SELECTED ");
			out.print(" >"+l.getFamily()+l.getFirsts());
            len++;
          }
          e= Workproject.find(teasession._strCommunity,"",0,200);
          while(e.hasMoreElements())
          {
        	int id=((Integer)e.nextElement()).intValue();
        	Workproject wp=Workproject.find(id);
			out.print("<option value="+id);
			if(clienttype&&client==id)
			out.print(" SELECTED ");
			out.print(" >"+wp.getName(teasession._nLanguage));
          }
          %>
      </select><input type="button" value="..." onclick="window.open('/jsp/admin/sales/clientserver.jsp?community=<%=teasession._strCommunity%>&client=form1.client&clienttype=form1.clienttype','','width=550,height=400,top='+(screen.height-400)/2+',left='+(screen.width-550)/2+',scrollbars=0,resizable=0,status=0');" >
      <script type="text/javascript">
      function f_client(v)
      {
      	form1.clienttype.value=v><%=len%>;
      }
      </script>
      </td>
      <td>直属上司</td>
      <td><select name="supervisor">
      <option value="0">-------------
         <%
          e= SalesLinkman.find(teasession._strCommunity," AND saleslinkman!="+saleslinkman,0,200);
          while(e.hasMoreElements())
          {
        	int id=((Integer)e.nextElement()).intValue();
        	SalesLinkman sl=SalesLinkman.find(id);
			out.print("<option value="+id);
			if(supervisor==id)
			out.print(" SELECTED ");
			out.print(" >"+sl.getName(teasession._nLanguage));
          }
          %>
      </select></td>
    </tr>
	<tr>
      <td>职务</td>
      <td><input name="job" size="40" value="<%if(job!=null)out.print(job);%>"></td>
    </tr>
  </table>
  <h2>地址信息<a href="javascript:f_copy();">将邮寄地址复制到其他地址</a></h2>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td>邮寄地址 - 国家/地区</td>
      <td ><%=new CountrySelection("country",teasession._nLanguage,country)%></td>
      <td> 其他地址 - 国家/地区 </td>
      <td ><%=new CountrySelection("country2",teasession._nLanguage,country2)%></td>
    </tr>
    <tr>
      <td> 邮寄地址 - 邮政编码 </td>
      <td><input name="postcode" maxlength="6" size="10" value="<%if(postcode!=null)out.print(postcode);%>"></td>
      <td> 其他地址 - 邮政编码 </td>
      <td><input name="postcode2" maxlength="6" size="10" value="<%if(postcode2!=null)out.print(postcode2);%>"/></td>
    </tr>
    <tr>
      <td> 邮寄地址 - 州/省 </td>
      <td ><input  id="state" maxlength="20" name="state" size="20" tabindex="13" type="text"  value="<%if(state!=null)out.print(state);%>"/></td>
      <td> 其他地址 - 州/省 </td>
      <td><input  id="state2" maxlength="20" name="state2" size="20" tabindex="18" type="text" value="<%if(state2!=null)out.print(state2);%>" /></td>
    </tr>
    <tr>
      <td> 邮寄地址 - 城市 </td>
      <td><input  id="city" maxlength="40" name="city" size="20" tabindex="14" type="text"  value="<%if(city!=null)out.print(city);%>"/></td>
      <td> 其他地址 - 城市 </td>
      <td><input  id="city2" maxlength="40" name="city2" size="20" tabindex="19" type="text"  value="<%if(city2!=null)out.print(city2);%>"/></td>
    </tr>
    <tr>
      <td>邮寄地址 - 街道</td>
      <td><textarea  cols="27" id="street" maxlength="255" name="street" rows="2" tabindex="15" ><%if(street!=null)out.print(street);%></textarea></td>
      <td> 其他地址 - 街道 </td>
      <td><textarea  cols="27" id="street2" maxlength="255" name="street2" rows="2" tabindex="20" ><%if(street2!=null)out.print(street2);%></textarea></td>
    </tr>
  </table>
   <h2>其他信息</h2>
   <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr>
       <td>传真</td>
       <td ><input maxlength="40" name="fax" size="20" tabindex="14" type="text"  value="<%if(fax!=null)out.print(fax);%>"/></td>
       <td>潜在客户来源</td>
       <td><select name="origin" >
           <%
          for(int i=0;i<Latency.ORIGIN.length;i++)
          {
			out.print("<option value="+i);
			if(origin==i)
			out.print(" SELECTED ");
			out.print(" >"+r.getString(teasession._nLanguage,Latency.ORIGIN[i]));
          }
          %>
       </select></td>
     </tr>
     <tr>
       <td>家庭电话</td>
       <td><input  maxlength="40" name="hometel" size="20" tabindex="14" type="text"  value="<%if(hometel!=null)out.print(hometel);%>"/></td>
       <td>出生日期</td>
       <td><input name="birth" size="20" tabindex="9" type="text"  value="<%if(birth!=null)out.print(birth);%>"/></td>
     </tr>
     <tr>
       <td>其他电话</td>
       <td><input  maxlength="40" name="othertel" size="20" tabindex="14" type="text"  value="<%if(othertel!=null)out.print(othertel);%>"/></td>
       <td>部门</td>
       <td><input name="unit" size="20" tabindex="9" type="text"  value="<%if(unit!=null)out.print(unit);%>"/></td>
     </tr>
     <tr>
       <td>助理</td>
       <td><input   maxlength="40" name="assistant" size="20" tabindex="14" type="text"  value="<%if(assistant!=null)out.print(assistant);%>"/></td>
       <td>&nbsp;</td>
       <td>&nbsp;</td>
     </tr>
     <tr>
       <td>助理电话</td>
       <td><input   maxlength="40" name="assistanttel" size="20" tabindex="14" type="text"  value="<%if(assistanttel!=null)out.print(assistanttel);%>"/></td>
       <td>&nbsp;</td>
       <td>&nbsp;</td>
     </tr>
     <tr>
       <td><%=r.getString(teasession._nLanguage,"Text")%>
           <!--内容--></td>
       <td colspan="3"><textarea name="content" rows="4" cols="40"><%if(content!=null)out.print(content);%></textarea></td>
     </tr>
   </table>
   <input type="submit" value="<%=r.getString(teasession._nLanguage,"Submit")%>" >
  <input name="newnext" type="submit" value="<%=r.getString(teasession._nLanguage,"保存并新建")%>" >
  <input type="button" value="<%=r.getString(teasession._nLanguage,"CBBack")%>" onClick="window.open('<%=nexturl%>','_self');" >
</form>
<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>



