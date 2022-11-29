<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter"%>
<%@ page import="tea.resource.Resource"%>
<%@ page import="tea.resource.Common" %>
<%@ page import="tea.entity.admin.*" %>
<%@ page import="tea.ui.TeaSession" %>
<%@ page import="java.io.*" %>

<%@ page import="tea.entity.admin.sales.*" %>
<%@ page import="java.util.Date" %>

<%
request.setCharacterEncoding("UTF-8");


response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}
String community=teasession._strCommunity;


int laid = 0;
if(teasession.getParameter("laid")!=null && teasession.getParameter("laid").length()>0)
laid = Integer.parseInt(teasession.getParameter("laid"));
String holder=null,family=null,firsts=null,email=null,corp=null,country=null,
city=null, street=null,webaddress=null,remark=null,member=null,member1=null,telephone=null;

int states =0,grade=0,postalcode=0,counts=0,origin=0,income=0,calling=0,duty=0,province=0,latencytype=0;
Date times =null,times1 =null;
Latency laobj = Latency.find(laid);
if(laid>0)
{
  holder = laobj.getHolder();
  states = laobj.getStates();
  family =laobj.getFamily();
  firsts = laobj.getFirsts();
  telephone = laobj.getTelephone();
  email = laobj.getEmail();
  corp = laobj.getCorp();
  grade = laobj.getGrade();
  duty = laobj.getDuty();
  country = laobj.getCountry();
  postalcode = laobj.getPostalcode();
  province = laobj.getProvince();
  city= laobj.getCity();
  street= laobj.getStreet();
  webaddress = laobj.getWebaddress();
  counts = laobj.getCounts();
  origin = laobj.getOrigin();
  income = laobj.getIncome();
  calling= laobj.getCalling();
  remark = laobj.getRemark();
  times = laobj.getTimes();
  member = laobj.getMember();
  times1 = laobj.getTimes1();
  member1 = laobj.getMember1();
  latencytype = laobj.getLatencytype();
}
if(teasession.getParameter("delete")!=null)
{
  laobj.delete();
  response.sendRedirect("/jsp/admin/sales/latency.jsp");
  return;
}


String sun = teasession.getParameter("sun");
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
  <body>

  <h1>潜在客户-</h1>
  <div id="head6"><img height="6" src="about:blank"></div>
    <br>

    <form name=form1 METHOD=post  action="/servlet/EditLatency" onsubmit="return sub(this);">
      <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
        <input type="hidden" name="laid" value="<%=laid %>">
        <tr >
          <td nowrap>潜在客户所有人:</td>
          <td nowrap><%=teasession._rv %> </td>

        </tr>
        <tr>
          <td nowrap>潜在客户状态:</td>
          <td nowrap><select name="states">
          <%
          for(int i =0;i<Latency.HOLDER.length;i++)
          {
            out.print("<option value="+i);
            if(states==i)
            out.print(" selected");
            out.print(">"+Latency.HOLDER[i]);
            out.print("</option>");
          }
          %>
          </select></td>
        </tr>
        <td>潜在客户分类    </td>
        <td><select  name="latencytype">
        <%
         int num =0;
        if(sun!=null)
        {
          num = 3;

        }
        else
        {
        num =Latency.LYTYPES.length;
        }
        for(int i = 1;i< num;i++)
        {

          out.print("<option value="+i);
          if(latencytype==i)
          {
            out.print(" selected");
          }
          out.print(">"+Latency.LYTYPES[i]+"</option >");
        }

        %>

</select></td>
<tr>
</tr>
<tr >
  <td nowrap>姓名：</td><td nowrap><input type="text" name="family" size="27" value="<%if(family!=null)out.print(family); if(firsts!=null)out.print(firsts); %>"></td>
</tr>

<tr>
  <td nowrap>电话：</td><td nowrap><input type="text" name="telephone" size="27" value="<%if(telephone!=null)out.print(telephone); %>"></td>
</tr>
<tr>
  <td nowrap>电子邮件：</td><td nowrap><input type="text" name="email" size="27" value="<%if(email!=null)out.print(email); %>"></td>
</tr>
<tr>
  <td nowrap>公司：</td><td nowrap><input type="text" name="corp" size="27" value="<%if(corp!=null)out.print(corp); %>"></td>
</tr>
<tr>
  <td nowrap>分级：</td><td nowrap><select name="grade">
  <%
  for(int i=0;i<Latency.GRADE.length;i++)
  {
    out.print("<option value="+i);
    if(grade==i)
    out.print(" selected");
    out.print(">"+Latency.GRADE[i]);
    out.print("</option>");
  }

  %>
  </select></td>
</tr>
<tr>
  <td>职务：</td>
  <td class="right">
    <select size="1" name="duty" tabindex='12' id="Role">
    <%
    for(int i =0;i<Latency.DUTYS.length;i++)
    {
      out.print("<option value="+i);
      if(duty!=0)
      {
        out.print(" selected");
      }
      out.print(">"+Latency.DUTYS[i]+"</option>");
    }
    %>
    </select>
    <font color="#cc0000">*</font> </td>
</tr>
<tr>
  <td nowrap>国家/地区：</td><td nowrap><input type="text" name="country" size="27" value="<%if(country!=null)out.print(country); %>"></td>
</tr>
<tr>
  <td nowrap>邮政编码：</td><td nowrap><input type="text" name="postalcode" size="27" value="<%if(postalcode!=0)out.print(postalcode);%>"></td>
</tr>
<tr>
  <td nowrap>洲/省：</td>
  <td nowrap> <select name="province" id="province" onchange = "return chcity();">
  <%
  for(int i=0;i<Latency.PROVINCES.length;i++)
  {
    out.print("<option value="+i+">");
    out.print(Latency.PROVINCES[i]+"</option>");
  }

  %>
  </select></td>
</tr>
<tr>
  <td nowrap>城市：</td><td nowrap><input type="text" name="city" size="27" value="<%if(city!=null)out.print(city); %>"></td>
</tr>
<tr>
  <td nowrap>街道：</td><td nowrap><input type="text" name="street" size="27" value="<%if(street!=null)out.print(street); %>"></td>
</tr>
<tr>
  <td nowrap>网址：</td><td nowrap><input type="text" name="webaddress" size="27" value="<%if(webaddress!=null)out.print(webaddress); %>"></td>
</tr>
<tr>
  <td nowrap>员工数：</td><td nowrap><input type="text" name="counts" size="27" value="<%if(counts!=0)out.print(counts); %>"></td>
</tr>
<tr>
  <td nowrap>潜在客户来源：</td><td nowrap><select name="origin">
  <%
  for(int i=0;i<Latency.ORIGIN.length;i++)
  {
    out.print("<option value="+i);
    if(origin==i)
    out.print(" selected");
    out.print(">"+Latency.ORIGIN[i]);
    out.print("</option>");
  }
  %>
  </select></td>
</tr>
<tr>
  <td nowrap>年收入：</td><td nowrap><input type="text" name="income" size="27" value="<%if(income!=0)out.print(income); %>"></td>
</tr>
<tr>
  <td nowrap>行业：</td><td nowrap><select name="calling">
  <%
  for(int i = 0 ;i<Common.SALES_CALLING.length;i++)
  {
    out.print("<option value ="+i);
    if(calling==i)
    out.print(" selected");
    out.print(">"+Common.SALES_CALLING[i]);
    out.print("</option>");
  }
  %>
  </select></td>
</tr>
<tr>
  <td nowrap>备注：</td><td nowrap><textarea cols=37 rows=3 name="remark" wrap="yes" ><%if(remark!=null)out.print(remark); %></textarea></td>
</tr>
      </table>
      <br>
      <input type="submit" name="submit1" value="提交"> &nbsp;&nbsp;<%if(laid>0){ %> <input name="submit1" type="submit" value="升级成客户"> <%} %> &nbsp;&nbsp;<input type="button" value="返回" onclick="location='/jsp/admin/sales/latency.jsp'">
    </FORM>
  </body>
</html>



