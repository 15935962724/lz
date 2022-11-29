<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%><%@page import="tea.entity.*"%><%@page import="tea.entity.node.*"%><%@page import="tea.ui.*"%><%@page import="tea.entity.stat.*"%><%@page import="tea.entity.admin.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}

int menu=h.getInt("id");
String[] TAB={"日统计","月统计"},TYPE={"走势图","柱状图"};
int tab=h.getInt("tab");

String sst=h.get("st",""),set=h.get("et","");
int type=h.getInt("type");
String url=h.get("url");

Calendar c=Calendar.getInstance();



%>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>受访页面（<%=Node.find(Integer.parseInt(url)).getAnchor(h.language)%>）</h1>
<div id="head6"><img height="6" src="about:blank"></div>



<%
out.print("<div class='switch'>");
for(int i=0;i<TAB.length;i++)
{
  out.print("<a href='javascript:mt.tab("+i+")' class="+(i==tab?"current":"")+">"+TAB[i]+"</a>");
}
out.print("</div>");
%>
<script>
mt.fast=function(v)
{
  arr=v.split('—');
  form1.st.value=arr[0];
  form1.et.value=arr[1];
  form1.submit();
};
function open_flash_chart_data()
{
  return "<%=SPage.chart(h)%>".replace(/'/g,'"');
}
mt.tab=function(a)
{
  form1.st.value=form1.et.value='';
  form1.tab.value=a;
  form1.submit();
};
function save_image()
{
  mt.post("/Imgs.do?act=chart",$$('chart').get_img_binary());
}
</script>



<form name="form1" action="?">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="id" value="<%=h.getInt("id")%>"/>
<input type="hidden" name="tab" value="<%=tab%>" />
<input type="hidden" name="url" value="<%=url%>" />

<table id="tablecenter" cellspacing="0">
<tr>
  <td><select onChange="mt.fast(value);">
<%
if(tab==0)
{
  String[] arr={"本月","前一月","前二月"};
  out.print("<option value='—'>最近30天");
  c.set(Calendar.DAY_OF_MONTH,1);
  c.add(Calendar.MONTH,1);
  String last=MT.f(c.getTime());
  for(int i=0;i<arr.length;i++)
  {
    c.add(Calendar.MONTH,-1);
    String tmp=MT.f(c.getTime()),str=tmp+"—"+last;
    last=tmp;
    out.print("<option value="+str);
    if(str.equals(sst+"—"+set))out.print(" selected");
    out.print(">"+arr[i]);
  }
}else
{
  out.print("<script>$$('tablecenter').style.display='none'</script>");
}
%>
</select>
  <td>时间：<input name="st" value="<%=sst%>" class="date" onClick="mt.date(this)"/>—<input name="et" value="<%=set%>" class="date" onClick="mt.date(this)"/></td>
  <td>方式：<select name="type"><%=h.options(TYPE,type)%></select> <input type="submit" value="查询" /></td>
</tr>
</table>
</form>


<table id="tablecenter" cellspacing="0">
<tr><td><script>mt.embed('/tea/mt/chart.swf','100%',300);</script>
</table>
<input type="button" value="导出" onClick="save_image()"/>

</body>
</html>
