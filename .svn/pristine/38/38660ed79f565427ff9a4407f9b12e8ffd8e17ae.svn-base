<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter" %>
<%@ page  import="tea.resource.*"  %>
<%@ page  import="tea.entity.admin.*" %>
<%@ page  import="tea.htmlx.*" %>
<%@ page  import="tea.entity.admin.sales.*" %>
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
StringBuffer sql = new StringBuffer();


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
  street2=obj.getStreet2();
}

String nexturl=request.getParameter("nexturl");
sql.append("  and workproject="+workproject);


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
<body onLoad="">
<!--客户或项目管理-->
<h1><%=r.getString(teasession._nLanguage,"1168574789140")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br>
<form name=form1 METHOD=get action="/servlet/EditWorkreport" onSubmit="return submitText(this.name,'<%=r.getString(teasession._nLanguage,"InvalidSubject")%>')">
  <input type=hidden name="community" value="<%=community%>"/>
  <input type=hidden name="workproject" value="<%=workproject%>"/>
  <input type=hidden name="nexturl" value="<%=nexturl%>"/>
  <input type=hidden name="action" value="editworkproject"/>
  <h2>客户信息</h2>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td><%=r.getString(teasession._nLanguage,"1168575002906")%>
        <!--名称--></td>
      <td><%if(name!=null)out.print(name);%></td>
      <td><%=r.getString(teasession._nLanguage,"1168574945796")%>
        <!--电话--></td>
      <td><%if(tel!=null)out.print(tel);%></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage,"1168574969234")%>
        <!--传真--></td>
      <td><%if(fax!=null)out.print(fax);%></td>
      <td>URL</td>
      <td><%if(url!=null)out.print(url);%></td>
    </tr>
    <tr>
      <td>E-Mail</td>
      <td><%if(email!=null)out.print(email);%></td>
    </tr>
  </table>
  <h2>其他信息</h2>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td>类型</td>
      <td ><%=r.getString(teasession._nLanguage,Workproject.CLIENT_TYPE[type])%></td>
      <td>职员数</td>
      <td><%=employee%></td>
    </tr>
    <tr>
      <td>行业</td>
      <td><%=r.getString(teasession._nLanguage,Common.SALES_CALLING[calling])%></td>
      <td>年收入</td>
      <td><%if(earning!=null)out.print(earning);%></td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage,"Text")%>
        <!--内容--></td>
      <td><%if(content!=null)out.print(content);%></td>
    </tr>
    <tr>
      <td>开单地址 - 国家/地区</td>
      <td ><%=new CountrySelection(teasession._nLanguage,country)%></td>
      <td> 发货地址 - 国家/地区 </td>
      <td ><%=new CountrySelection(teasession._nLanguage,country2)%></td>
    </tr>
    <tr>
      <td> 开单地址 - 邮政编码 </td>
      <td><%if(postcode!=null)out.print(postcode);%></td>
      <td> 发货地址 - 邮政编码 </td>
      <td><%if(postcode2!=null)out.print(postcode2);%></td>
    </tr>
    <tr>
      <td> 开单地址 - 州/省 </td>
      <td ><%if(state!=null)out.print(state);%></td>
      <td> 发货地址 - 州/省 </td>
      <td><%if(state2!=null)out.print(state2);%></td>
    </tr>
    <tr>
      <td> 开单地址 - 城市 </td>
      <td><%if(city!=null)out.print(city);%></td>
      <td> 发货地址 - 城市 </td>
      <td><%if(city2!=null)out.print(city2);%></td>
    </tr>
    <tr>
      <td>开单地址 - 街道</td>
      <td><%if(street!=null)out.print(street);%></td>
      <td> 发货地址 - 街道 </td>
      <td><%if(street2!=null)out.print(street2);%></td>
    </tr>
  </table>
  <%--
  <input type="submit" value="<%=r.getString(teasession._nLanguage,"Submit")%>" >
  <input name="newnext" type="submit" value="<%=r.getString(teasession._nLanguage,"保存并新建")%>" >
  <input type="button" value="<%=r.getString(teasession._nLanguage,"CBBack")%>" onClick="window.open('<%=nexturl%>','_self');" >
  --%>


    <h2>联系人</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
     <tr id="tableonetr">
     <td nowrap width="1"></td>
       <td nowrap><%=r.getString(teasession._nLanguage,"1168575002906")%></td>
         <td nowrap><%=r.getString(teasession._nLanguage,"1168574945796")%></td>
         <td nowrap>E-Mail</td>
         <td nowrap><!--邮编-->
         <%=r.getString(teasession._nLanguage,"1168575152750")%></td>
         <td nowrap><!--时间-->
         <%=r.getString(teasession._nLanguage,"CreateTime")%></td>
         <td></td>
       </tr><%
       java.util.Enumeration exe=Worklinkman.find(community,sql.toString(),0,200);
       for(int i=1;exe.hasMoreElements();i++)
       {

         String  member =((String)exe.nextElement().toString());
         Worklinkman work = Worklinkman.find(community,member);


       %>
         <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    <td width="1"><%=i%></td>
    <td nowrap>&nbsp;<a href="/jsp/admin/workreport/EditWorklinkman.jsp?community=<%=teasession._strCommunity%>&member=<%=member%>"><%=member%></a></td>
    <td nowrap>&nbsp;<%=work.getMobile()%></td>
    <td>&nbsp;<a href="mailto:<%=work.getEmail()%>" ><%=work.getEmail()%></a></td>
    <td>&nbsp;<%=work.getPostcode()%></td>
    <td>&nbsp;<%=work.getTimes()%></td>

 </tr>
       <%
       }



       %>

</table>

</form>
<br>
<input type=button value="返回" onClick="javascript:history.back()">
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>



