<%@page contentType="text/html;charset=UTF-8" %><%@ page import="java.net.*"%><%@ page import="java.util.*"%><%@ page import="java.text.*"%><%@ page import="java.security.*"%><%@ page import="com.capinfo.crypt.*"%><%@ page import="tea.entity.member.*"%>
<%@ page import="tea.ui.*"%><%@ page import="java.math.*"%><%@ page import="tea.entity.csvclub.alipay.*"%><%@ page import="tea.entity.csvclub.encrypt.*" %><%@ page import="tea.entity.admin.mov.*" %><%@ page import="tea.entity.admin.*" %>
<%@ page import="tea.entity.citybcst.*" %><%@ page import="tea.db.*" %>
<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");

TeaSession teasession = new TeaSession(request);
StringBuffer param=new StringBuffer();
StringBuffer sql=new StringBuffer();
param.append("?community="+teasession._strCommunity);
int pos=0;
if(request.getParameter("pos")!=null)
{
  pos=Integer.parseInt(request.getParameter("pos"));
}
param.append("&pos=").append(pos);

String menu_id=(request.getParameter("id"));
if(menu_id!=null&&menu_id.length()>0)
{
  param.append("&id=").append(menu_id);
}
  int intcity=0;
String city="";
if(teasession.getParameter("city")!=null && teasession.getParameter("city").length()>0)
{
  city=teasession.getParameter("city");
  if(city.equals("0"))
  {
  }
  else
  {
    intcity=Integer.parseInt(city);
    sql.append(" and city="+city);
  }
  param.append("&city="+city);

}

String street="";
if(teasession.getParameter("street")!=null && teasession.getParameter("street").length()>0)
{
   street=teasession.getParameter("street");
  if(street.equals("0"))
  {
  }
  else
  {
    sql.append(" and street="+street);
  }
  param.append("&street="+street);
}

String telephone="";
if(teasession.getParameter("telephone")!=null && teasession.getParameter("telephone").length()>0)
{
  telephone=teasession.getParameter("telephone");
  sql.append(" and telephone="+DbAdapter.cite(telephone));
  param.append("&telephone="+telephone);
}


String firstname="";
if(teasession.getParameter("firstname")!=null && teasession.getParameter("firstname").length()>0)
{
  firstname=teasession.getParameter("firstname");
  sql.append(" and firstname="+DbAdapter.cite(firstname));
  param.append("&firstname="+firstname);
}
String sex="";
if(teasession.getParameter("sex")!=null && teasession.getParameter("sex").length()>0)
{
  sex=teasession.getParameter("sex");
  if(sex.equals("2"))
  {
  }else
  {
    sql.append(" and sex="+sex);
  }
  param.append("&sex="+sex);
}


int count=0;
count=CityBcst.count(sql.toString());


%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script>if(parent.lantk) {document.getElementsByTagName("LINK")[0].href="/res/csvclub/cssjs/community_02.css"; }</script>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type="" ></SCRIPT>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/jsp/csvclub/js.js" type=""></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache"/>
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache"/>
<META HTTP-EQUIV="Expires" CONTENT="0"/>
<title>城市服务管理广播社区信息员申请列表</title>
<script type="">


var obj;
function f_ajax(v,n)
{
  obj=document.all(n).options;
  while(obj.length>1)obj[1]=null;
  sendx("/servlet/Ajax?act=cityname&value="+v,f_load);
}
function f_load(d)
{
  d=eval(d);
  for(var i=0;i<d.length;i++)
  {
    obj[i+1]=new Option(d[i][1],d[i][0]);
  }
}</script>
</head>
<body>
<h1>城市服务管理广播社区信息员申请列表</h1>
<form  name="form1" action="/jsp/citybroadcast/Citybcst.jsp"  method="GET">
<h2>查询</h2>
<TABLE border="0" CELLPADDING="0" CELLSPACING="0" id="tablecenter">
  <tr><td>姓名:</td>
    <td><input name="firstname" value="<%if(firstname!=null)out.print(firstname);%>" /></td>
    <td colspan="3">所在地区： 城区  <select  name="city" onchange="f_ajax(value,'street')"><option  value="0">-------</option>
    <%
    Enumeration eu = Cityname.findByCommunity(" and levelid=1 ",0,8);
    for(int i=0;eu.hasMoreElements();i++)
    {
      int cid= Integer.parseInt(String.valueOf(eu.nextElement()));
      Cityname cityobj = Cityname.find(cid);
      out.print("<option value="+cid);
      if(intcity==cid)
      {
        out.print(" selected ");
      }
      out.print(">"+cityobj.getCityname()+"</option>");
    }
    %>
    </select>　
    街道<select name="street" onchange="f_ajax(value,'community2')"><option value="0">-------</option></select>　
    社区<select name="community2"><option  value="0">-------</option></select>

</td>
</tr>
<tr>
  <td>联系电话</td>
  <td><input name="telephone" value="<%if(telephone!=null) out.print(telephone);%>" /></td>
  <td colspan="3">性别：<select  name="sex">
    <option value="2" <%if(sex.equals("2"))out.print(" selected ");%>>----</option>
    <option value="0" <%if(sex.equals("0"))out.print(" selected ");%>>男</option>
    <option value="1" <%if(sex.equals("1")){out.print(" selected ");}else{out.print("");}%>>女</option>
</select> 　<input type="submit" value="查询" /></td>
</tr>
</table>
</form>
<h2>列表（<%=count%>）</h2>
<form action="/servlet/EditCityBcstExcel" method="GET">
<input type="hidden" name="act" value="Citybcst">
<input type="hidden" name="sql" value="<%=sql.toString()%>">
<input type="hidden" name="files" value="citybcst">
<input type="hidden" name="count" value="<%=count%>">

<TABLE border="0" CELLPADDING="0" CELLSPACING="0" id="tablecenter">
  <tr id="tabletrone">
    <td>姓名</td>
    <td>性别</td>
    <td>年龄</td>
    <td>身份证号</td>
    <td>所在城区</td>
    <td>所在街道</td>
    <td>所在社区</td>
    <td>居住地址</td>
    <td>联系电话</td>
    <td>　</td>
  </tr>
  <%
  Enumeration eucity = CityBcst.findByCommunity2(sql.toString(),pos,10);
  for(int i=0;eucity.hasMoreElements();i++)
  {
    int bcstid= Integer.parseInt(String.valueOf(eucity.nextElement()));
    CityBcst cityobj = CityBcst.find(bcstid);
    Cityname obj1 = Cityname.find(cityobj.getCity());
    Cityname obj2 = Cityname.find(cityobj.getStreet());
    Cityname obj3 = Cityname.find(cityobj.getCommunity());
    %>
    <tr>
      <tr>
        <td><%=cityobj.getFirstname()%></td>
        <td><%if(cityobj.getSex()==1){out.print("女");}else{out.print("男");};%></td>
        <td><%=cityobj.getAge()%></td>
        <td><%=cityobj.getCard()%>　</td>
        <td><%if(obj1.getCityname()==null && cityobj.getOther()!=null){out.print(cityobj.getOther());}else{out.print(obj1.getCityname());}%></td>
        <td><%if(obj2.getCityname()==null && cityobj.getOther2()!=null){out.print(cityobj.getOther2());}else{out.print(obj2.getCityname());}%></td>
        <td><%if(obj3.getCityname()==null && cityobj.getOther3()!=null){out.print(cityobj.getOther3());}else{out.print(obj3.getCityname());}%></td>
        <td><%=cityobj.getAddr()%></td>
        <td><%=cityobj.getTelephone()%></td>
        <td><input type="button"  onclick="window.open('/jsp/citybroadcast/EditCitybroadcast.jsp?ids=<%=bcstid%>','_self')" value="编辑"/></td>
      </tr>
      <%
      }
      %>
      <tr><td><%=new tea.htmlx.FPNL(teasession._nLanguage,param.toString().replaceFirst("&pos=","&")+"&pos=",pos,count,10)%></td></tr>
      <tr><td colspan="10" align="center"><input type="submit"  value="导出"/></td></tr>
</table>
</form>
</body>
</html>

