<%@page import="tea.entity.taoism.Taoism"%>
<%@page import="java.awt.Menu"%>
<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%><%@page import="tea.ui.*"%>
<%@page import="tea.entity.admin.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?node="+h.node);
  return;
}
StringBuffer sql=new StringBuffer(),par=new StringBuffer();
int menuid=h.getInt("id");
par.append("?id="+menuid);
sql.append(" and deleted=0");
String sysId=h.get("sysId","");
if(sysId.length()>0)
{
  sql.append(" AND sysId like "+DbAdapter.cite("%"+sysId+"%"));
  par.append("&sysId="+sysId);
}

String mobile=h.get("mobile","");
if(mobile.length()>0)
{
  sql.append(" AND mobile LIKE "+DbAdapter.cite("%"+mobile+"%"));
  par.append("&mobile="+h.enc(mobile));
}
int sex=h.getInt("sex");
if(sex>0)
{
  sql.append(" AND sex="+(sex==2?0:sex));
  par.append("&sex="+sex);
}
String name=h.get("name","");
if(name.length()>0)
{
  sql.append(" AND name LIKE "+DbAdapter.cite("%"+name+"%"));
  par.append("&name="+name);
}
String QQ=h.get("QQ","");
if(QQ.length()>0)
{
  sql.append(" AND QQ LIKE "+DbAdapter.cite("%"+QQ+"%"));
  par.append("&QQ="+QQ);
}
String phone=h.get("phone","");
if(phone.length()>0)
{
  sql.append(" AND phone LIKE "+DbAdapter.cite("%"+phone+"%"));
  par.append("&phone="+phone);
}
String convertId=h.get("convertId","");
if(convertId.length()>0)
{
  sql.append(" AND convertId LIKE "+DbAdapter.cite("%"+convertId+"%"));
  par.append("&convertId="+convertId);
}
String startTime=h.get("startTime");
//Date stopTime=h.getDate("stopTime");
if(startTime!=null)
{
  sql.append(" AND convert_time like "+DbAdapter.cite("%"+startTime+"%"));
  par.append("&startTime="+startTime);
}
/* if(stopTime!=null)
{
  sql.append(" AND convert_time<= "+DbAdapter.cite(stopTime));
  par.append("&stopTime="+stopTime);
} */
int ethnic=h.getInt("ethnic",0);
if(ethnic>0)
{
  sql.append(" AND ethnic = "+ethnic);
  par.append("&ethnic="+ethnic);
}
String country1=h.get("country1","");
if(country1.length()>0)
{
  sql.append(" AND huji_c = "+DbAdapter.cite(country1));
  par.append("&country1="+h.enc(country1));
}
String city1=h.get("city1","");
if(city1.length()>0)
{
  sql.append(" AND huji_p = "+DbAdapter.cite(city1));
  par.append("&city1="+h.enc(city1));
}
String county1=h.get("county1","");
if(county1.length()>0)
{
  sql.append(" AND huji_s = "+DbAdapter.cite(county1));
  par.append("&county1="+h.enc(county1));
}

int tab=h.getInt("tab");
par.append("&tab="+tab);

int audit=h.getInt("audit");
if(audit>0){
	sql.append(" AND se.audit="+audit);
	par.append("&audit="+audit);
}
int pos=h.getInt("pos",0);
par.append("&pos=");
int size=20;
int sum=Taoism.count(sql.toString());


%>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/tea/city.js" type="text/javascript"></script>
<script src="/jsp/sup/sup.js" type="text/javascript"></script>
<script src="/tea/country3.js" type="text/javascript"></script>
</head>
<body>
<h1>??????????????????</h1> 
<div id="head6"><img height="6" src="about:blank"></div>

<!-- <h2>??????</h2> -->
<form name="form1" action="?" >
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="id" value="<%=menuid%>"/>
<table id="tablecenter" cellspacing="0"> 
  <tr>
    <td align="right">???????????????</td>
    <td><input type="text" name="sysId" value="<%=MT.f(sysId) %>"/></td>
    <td align="right">?????????</td>
    <td><input type="text" name="name" value="<%=MT.f(name) %>"/></td>
    <td align="right">?????????</td>
    <td><select name="sex">
    <option value="0" <%=sex==0?"selected":"" %>>----</option>
    <option value="2" <%=sex==2?"selected":"" %>>???</option>
    <option value="1" <%=sex==1?"selected":"" %>>???</option>
    </select></td>
    <td align="right">?????????</td>
    <td><select name="ethnic">
    <%
    for(int i=0;i<Taoism.ETHNIC.length;i++){
    	%>
    	<option value="<%=i%>" <%=ethnic==i?"selected":"" %>><%=Taoism.ETHNIC[i] %></option>
    <%
    }
    %>
    </select></td>
  </tr>
  <tr>
    <td align="right">?????????</td>
    <td><input type="text" name="mobile" value="<%=MT.f(mobile) %>"/></td>
    <td align="right">?????????</td>
    <td><input type="text" name="phone" value="<%=MT.f(phone) %>"/></td>
    <td align="right">QQ:</td>
    <td><input type="text" name="QQ" value="<%=MT.f(QQ) %>"/></td>
    <td align="right">??????????????????</td>
    <td><input type="text" name="convertId" value="<%=MT.f(convertId) %>"/></td>
  </tr>
  <tr>
    <td align="right">???????????????</td>
    <td><input type="text" name="startTime" value="<%=MT.f(startTime) %>" onClick="mt.date(this)"  class="date"/>

    </td>
    <td align="right">?????????</td>
    <td colspan="3"><script>mt.country("1","<%=country1%>","<%=city1%>","<%=county1%>");</script></td>
    <td align="center" colspan="2"><input type="submit" value="??????"></td>
  </tr>
</table>
</form>
<script>
//sup.hquery();
</script>

<h2>??????&nbsp;???????????????<%=sum %>???????????? <input type="button" value="??????" onClick="mt.act('edit','0')"/></h2>
<form name="form2" action="/Taoism.do" method="post" target="_ajax">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="tid"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<input type="hidden" name="menuid" value=<%=menuid %>/>
<table id="tablecenter" cellspacing="0">
<tr id="tableonetr">
  <td></td>
  <td align="center">??????</td>
  <td align="center">????????????</td>
  <td align="center">??????</td>
  <td align="center">??????</td>
  <td align="center">??????</td>
  <td align="center">??????</td>
  <td align="center">????????????</td>
  <td align="center">??????</td>
  <td align="center">??????</td>
  <td align="center">E-mail</td>
  <td align="center">QQ</td>
  <td align="center">???????????????</td>
  <td align="center">????????????</td>
  <td align="center">??????</td>
</tr>
<%
if(sum<1)
{
  out.print("<tr><td colspan='20' align='center'>????????????!</td></tr>");
}else
{
  ArrayList al = Taoism.find(sql.toString(), pos, size);
  for(int i=0;i<al.size();i++){
	  Taoism t=(Taoism)al.get(i);
	  %>
	  <tr>
	  <td align="center"><input type="checkbox" name="id" value="<%=t.id%>"/></td>
      <td align="center"><%=i+1 %></td>
      <td align="center"><%=MT.f(t.sysId) %></td>
      <td align="center"><%=MT.f(t.name) %></td><!--<a href="/jsp/taoism/TaoismView.jsp?tid=<%=t.id%>"></a>  -->
      <td align="center"><%=MT.f(t.sex==0?"???":"???") %></td>
      <td align="center"><%=MT.f(t.age) %></td>
      <td align="center"><%=Taoism.ETHNIC[t.ethnic] %></td>
      <td align="center"><%=Taoism.EDUC_LV[t.educ_lv] %></td>
      <td align="center"><%=MT.f(t.mobile) %></td>
      <td align="center"><%=MT.f(t.phone) %></td>
      <td align="center"><%=MT.f(t.email) %></td>
      <td align="center"><%=MT.f(t.qq) %></td>
      <td align="center"><%=MT.f(t.convertId) %></td>
      <td align="center"><%=MT.f(t.convert_time) %></td>
      <td align="center">
         <a href=javascript:mt.act('edit',<%=t.id %>)>??????</a>
         <a href=javascript:mt.act('del',<%=t.id %>)>??????</a></td>
      </tr>
	  <%
  }
  out.print("<tr><td><input type='checkbox' onclick='mt.select(form2.id,checked)' id='sel'/><label for='sel'>??????</label>");
  out.print("<td colspan='20' align='right'>"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,size));
}%>
</table>
<br/>
<input type="button" value="??????" onClick="form3.submit()"/>
</form>

<form name="form3" action="/Taoisms.do" method="post">
<input type="hidden" name="act" value="export" />
<input type="hidden" name="sql" value="<%=sql.toString()%>"/>
</form>

<script>
mt.disabled(form2.id);
form2.nexturl.value=location.pathname+location.search;
mt.act=function(a,id,b)
{
  form2.act.value=a;
  form2.tid.value=id;
  form2.nexturl.value="/jsp/taoism/TaoismList.jsp";
  form2.action="/Taoisms.do";
  if(a=='del')
  { 
	
    mt.show('????????????????????????',2,'form2.submit()');
  }else
  {
    if(a=='edit')
      form2.action='/jsp/taoism/TaoismEdit.jsp';
    form2.target=form2.method='';
    form2.submit();
  }
};

//setFreeze(document.getElementsByTagName('TABLE')[1],0,1);
</script>
</body>
</html>
