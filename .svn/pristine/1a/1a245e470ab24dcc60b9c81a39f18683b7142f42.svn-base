<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter" %>
<%@ page  import="tea.resource.*"  %>
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

int workproject=0;
if(request.getParameter("workproject")!=null)
{
  workproject=Integer.parseInt(request.getParameter("workproject"));
}
String name=null,tel=null,fax=null,url=null,email=null,content=null;
int type=0;
int employee=50;
int calling=0;

String earning=null;// 年收入
	// /////////开单地址
String country=null;
String postcode=null;
String state=null;
String city=null;
String street=null;
	// /////////发货地址
String country2=null;
String postcode2=null;
String state2=null;
String city2=null;
String street2=null;

if(workproject>0)
{
  Workproject obj=Workproject.find(workproject);
  name=obj.getName(teasession._nLanguage);
  tel=obj.getTel();
  fax=obj.getFax();
  url=obj.getUrl();
  email=obj.getEmail();
  content=obj.getContent(teasession._nLanguage);


  type=obj.getType();
  employee=obj.getEmployee();
  calling=obj.getCalling();
  earning=obj.getEarning();

  country=obj.getCountry();
  postcode=obj.getPostcode();
  state=obj.getState();
  city=obj.getCity();
  street=obj.getStreet();

  country2=obj.getCountry2();
  postcode2=obj.getPostcode2();
  state2=obj.getState2();
  city2=obj.getCity2();

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
<script>
	function sub()
	{

		var string_value =form1.cost.value;
		var str_value = form1.overallmoney.value;
		var type="^\s*[+-]?[0-9]+\s*$";
		var re = new RegExp(type);

	if(string_value!="" && str_value!=""){
		if(string_value.match(re)==null)
		{
			alert("您的“预计成本”输入有误！");
			return false;
		}
		if(str_value.match(re)==null)
		{
			alert("您的“项目总金额输入有误！”");
			return false;
		}
	}

	}
</script>
<!--客户或项目管理-->
<h1><%=r.getString(teasession._nLanguage,"1168574789140")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br>
<form name=form1 METHOD=get action="/servlet/EditWorkreport" onSubmit="return submitText(this.name,'<%=r.getString(teasession._nLanguage,"InvalidSubject")%>')&&sub();">
  <input type=hidden name="community" value="<%=community%>"/>
  <input type=hidden name="workproject" value="<%=workproject%>"/>
  <input type=hidden name="nexturl" value="<%=nexturl%>"/>
  <input type=hidden name="action" value="editworkproject"/>
  <h2>客户信息</h2>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td><%=r.getString(teasession._nLanguage,"1168575002906")%>
        <!--名称--></td>
      <td><input name="name" size="40"  value="<%if(name!=null)out.print(name);%>"></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage,"1168574945796")%>
        <!--电话--></td>
      <td><input name="tel" size="30" value="<%if(tel!=null)out.print(tel);%>"></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage,"1168574969234")%>
        <!--传真--></td>
      <td><input name="fax" size="30" value="<%if(fax!=null)out.print(fax);%>"></td>
    </tr>
    <tr>
      <td>URL</td>
      <td><input name="url" size="40" value="<%if(url!=null)out.print(url);%>"></td>
    </tr>
    <tr>
      <td>E-Mail</td>
      <td><input name="email" size="40"  value="<%if(email!=null)out.print(email);%>"></td>
    </tr>

  </table>
  <h2>联系人</h2>
   <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr id="tableonetr">

        <td nowrap>会员ID</td>
        <td nowrap> 姓 名</td>
        <td nowrap> 性别</td>
        <td nowrap>工作电话</td>
        <td nowrap>手机</td>
      </tr>
      <%
      java.util.Enumeration  e = Worklinkman.find(teasession._strCommunity," AND workproject ="+workproject,0,Integer.MAX_VALUE);
      if(!e.hasMoreElements())
      {
        out.print("<tr><td colspan=10 align=center>暂无记录</td></tr>");
      }
      while(e.hasMoreElements())
      {
        String wlmember=((String)e.nextElement());
        Worklinkman obj=Worklinkman.find(teasession._strCommunity,wlmember);
        tea.entity.member.Profile profile=tea.entity.member.Profile.find(wlmember);

        %>
        <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
          <td nowrap align="center">&nbsp;<%=wlmember%></td>
          <td nowrap align="center">&nbsp;<%=profile.getLastName(teasession._nLanguage)+profile.getFirstName(teasession._nLanguage) %></td>
          <td nowrap align="center">&nbsp;<%=r.getString(teasession._nLanguage,obj.isSex()?"Man":"Woman")%></td>
          <td nowrap align="center">&nbsp;<%=obj.getWorktel()%></td>
          <td nowrap align="center">&nbsp;<%=profile.getMobile()%></td>
        </tr>
        <% } %>
        </table>
  <h2>其他信息</h2>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td>类型</td>
      <td ><select name="type" >
          <%
          for(int i=0;i<Workproject.CLIENT_TYPE.length;i++)
          {
			out.print("<option value="+i);
			if(type==i)
			out.print(" SELECTED ");
			out.print(" >"+r.getString(teasession._nLanguage,Workproject.CLIENT_TYPE[i]));
          }
          %>
        </select>
      </td>
      <td>职员数</td>
      <td><input  name="employee" size="20" tabindex="7" type="text"  value="<%=employee%>"/></td>
    </tr>
    <tr>
      <td>行业</td>
      <td><select name="calling" tabindex="8">
          <%
          for(int i=0;i<Common.SALES_CALLING.length;i++)
          {
			out.print("<option value="+i);
			if(calling==i)
			out.print(" SELECTED ");
			out.print(" >"+r.getString(teasession._nLanguage,Common.SALES_CALLING[i]));
          }
          %>
        </select>
      </td>
      <td>年收入</td>
      <td><input name="earning" size="20" tabindex="9" type="text"  value="<%if(earning!=null)out.print(earning);%>"/></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage,"Text")%>
        <!--内容--></td>
      <td><textarea name="content" rows="4" cols="40"><%if(content!=null)out.print(content);%>
</textarea></td>
    </tr>
     <tr >
    <td colspan="2" align="center">开单地址</td>
    <td colspan="2" align="center">发货地址</td>
  </tr>
    <tr>
      <td>国家</td>
      <td ><%=new CountrySelection("country",teasession._nLanguage,country)%></td>
      <td> 国家</td>
      <td ><%=new CountrySelection("country2",teasession._nLanguage,country2)%></td>
    </tr>
    <tr>
      <td> 邮编 </td>
      <td><input name="postcode" maxlength="6" size="10" value="<%if(postcode!=null)out.print(postcode);%>"></td>
      <td> 邮编 </td>
      <td><input name="postcode2" maxlength="6" size="10" value="<%if(postcode2!=null)out.print(postcode2);%>"/></td>
    </tr>
    <tr>
      <td> 州/省 </td>
      <td ><input  id="state" maxlength="20" name="state" size="20" tabindex="13" type="text"  value="<%if(state!=null)out.print(state);%>"/></td>
      <td> 州/省 </td>
      <td><input  id="state2" maxlength="20" name="state2" size="20" tabindex="18" type="text" value="<%if(state2!=null)out.print(state2);%>" /></td>
    </tr>
    <tr>
      <td> 城市 </td>
      <td><input  id="city" maxlength="40" name="city" size="20" tabindex="14" type="text"  value="<%if(city!=null)out.print(city);%>"/></td>
      <td> 城市 </td>
      <td><input  id="city2" maxlength="40" name="city2" size="20" tabindex="19" type="text"  value="<%if(city2!=null)out.print(city2);%>"/></td>
    </tr>
    <tr>
      <td>街道</td>
      <td><textarea  cols="27" id="street" maxlength="255" name="street" rows="2" tabindex="15" ><%if(street!=null)out.print(street);%></textarea></td>
      <td> 街道 </td>
      <td><textarea  cols="27" id="street2" maxlength="255" name="street2" rows="2" tabindex="20" ><%if(street2!=null)out.print(street2);%></textarea></td>
    </tr>
  </table>

  <input type="submit" value="<%=r.getString(teasession._nLanguage,"Submit")%>" >
  <input name="newnext" type="submit" value="<%=r.getString(teasession._nLanguage,"保存并新建")%>" >
  <input type="submit" name="xiayibu" value="<%=r.getString(teasession._nLanguage,"该客户项目管理") %>">
  <input type="button" value="<%=r.getString(teasession._nLanguage,"添加联系人")%>" onClick="window.open('/jsp/admin/workreport/EditWorklinkman.jsp?community=<%=community%>&nexturl=<%=java.net.URLEncoder.encode(nexturl,"UTF-8")%>','_self');">
  <input type="button" value="<%=r.getString(teasession._nLanguage,"CBBack")%>" onClick="window.open('<%=nexturl%>','_self');" >

</form>
<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>



