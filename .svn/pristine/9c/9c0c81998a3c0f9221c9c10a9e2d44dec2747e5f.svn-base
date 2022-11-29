<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.ui.*"%><%@page import="tea.db.*"%>
<%@page import="tea.entity.node.*"%><%@page import="tea.entity.weibo.*"%><%

Http h=new Http(request,response);

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+h.node);
  return;
}
//h.member=teasession._rv.toString();

String[] COLOR={"FFA333", "009149", "0058C6"};
String[] TAB={"时统计","日统计","月统计"};
String[] LAB={"#date:H#","#date:Y-m-d#",null};
StringBuilder sb = new StringBuilder(),lab = new StringBuilder(), val = new StringBuilder();

int tab=h.getInt("tab");
Date st=h.getDate("st");
Date et=h.getDate("et");
String sst=MT.f(st),set=MT.f(et);

if(et==null)et=new Date();

int max=50,min=0,step=0;
if(tab==0)
{
  if(st==null)
  {
    Calendar c = Calendar.getInstance();
    c.add(Calendar.HOUR_OF_DAY, -24);
    c.set(Calendar.MINUTE, 0);
    c.set(Calendar.SECOND, 0);
    st=c.getTime();
  }
  min = (int) (st.getTime() / 1000);
  step=3600;
  //
  String expr=DbAdapter.format("time",13);
  DbAdapter db = new DbAdapter();
  try
  {
    java.sql.ResultSet rs = db.executeQuery("SELECT "+expr+" AS expr,COUNT(*) FROM wmobile WHERE time>" + DbAdapter.cite(st) + " AND time<" + DbAdapter.cite(et) + " GROUP BY "+expr+" ORDER BY expr", 0, Integer.MAX_VALUE);
    for (int i = 1; rs.next(); i++)
    {
      Date time = MT.SDF[1].parse(rs.getString(1) + ":00");
      int value = rs.getInt(2);
      val.append(",{'x':" + time.getTime() / 1000 + ",'y':" + value + "}");
      max = Math.max(max, value);
    }
    rs.close();
  } finally
  {
    db.close();
  }
}else if(tab==1)
{
  if(st==null)
  {
    Calendar c = Calendar.getInstance();
    c.add(Calendar.MONTH, -1);
    c.set(Calendar.HOUR_OF_DAY, 0);
    c.set(Calendar.MINUTE, 0);
    c.set(Calendar.SECOND, 0);
    st=c.getTime();
  }
  min = (int) (st.getTime() / 1000);
  step=86400;
  //
  String expr=DbAdapter.format("time",10);
  DbAdapter db = new DbAdapter();
  try
  {
    java.sql.ResultSet rs = db.executeQuery("SELECT "+expr+" AS expr,COUNT(*) FROM wmobile WHERE time>" + DbAdapter.cite(st, true) + " AND time<" + DbAdapter.cite(et) + " GROUP BY "+expr+" ORDER BY expr", 0, Integer.MAX_VALUE);
    for (int i = 1; rs.next(); i++)
    {
      Date time = MT.SDF[0].parse(rs.getString(1));
      int value = rs.getInt(2);
      val.append(",{'x':" + time.getTime() / 1000 + ",'y':" + value + "}");
      max = Math.max(max, value);
    }
    rs.close();
  } finally
  {
    db.close();
  }
}else if(tab==2)
{
  Calendar c = Calendar.getInstance();
  if(st==null)
  {
    c.add(Calendar.YEAR, -1);
    c.set(Calendar.DAY_OF_MONTH, 1);
    st=c.getTime();
  }else
    c.setTime(st);
  //
  HashMap hm0 = new HashMap();
  String expr=DbAdapter.format("time",7);
  DbAdapter db = new DbAdapter();
  try
  {
    java.sql.ResultSet rs = db.executeQuery("SELECT "+expr+" AS expr,COUNT(*) FROM wmobile WHERE time>" + DbAdapter.cite(st, true) + " AND time<" + DbAdapter.cite(et) + " GROUP BY "+expr+" ORDER BY expr", 0, Integer.MAX_VALUE);
    while(rs.next())hm0.put(rs.getString(1), new Integer(rs.getInt(2)));
    rs.close();
  } finally
  {
    db.close();
  }
  for (int i = 0; i < 13; i++, c.add(Calendar.MONTH, 1))
  {
    String tip = MT.f(c.getTime()).substring(0, 7);
    lab.append(",'" + tip + "'");
    //
    Integer t = (Integer) hm0.get(tip);
    int v0 = t == null ? 0 : t.intValue();
    //
    tip = tip + "<br>次数: " + v0;
    val.append(",{'top':").append(v0).append(",'tip':'" + tip + "'}");
    max = Math.max(max, v0);
  }
}


sb.append("{");
sb.append("  'elements':");
sb.append("  [");
sb.append("    {");
sb.append("      'type':'"+(tab==2?"bar_glass":"line")+"',");
if(val.length()>0)
sb.append("      'values':[" + val.substring(1) + "],");
sb.append("      'text':'"+TAB[tab]+"',");
sb.append("      'colour':'#"+COLOR[tab]+"',");
sb.append("      'on-show':");
sb.append("      {");
sb.append("        'type': 'drop',");
sb.append("        'cascade': 1");
sb.append("      }");
sb.append("    }");
sb.append("  ],");
sb.append("  'x_axis':");
sb.append("  {");
if(LAB[tab]!=null)
{
  sb.append("    'steps': "+step+",");
  sb.append("    'min': " + min + ",");
  sb.append("    'max': " + (et.getTime()/1000-(set.length()<1?0:step)) + ",");
  sb.append("    'labels':");
  sb.append("    {");
  if(tab==1)
  sb.append("      'rotate': -45,");
  sb.append("      'steps': "+step+",");
  sb.append("      'visible-steps': 1,");
  sb.append("      'text': '"+LAB[tab]+"'");
  sb.append("    },");
}else
{
  sb.append("    'labels':");
  sb.append("    {");
  sb.append("      'labels':[" + lab.substring(1) + "]");
  sb.append("    },");
}
sb.append("    'colour':      '#000000',");
sb.append("    'grid-colour': '#E4E4E4'");
sb.append("  },");
sb.append("  'y_axis':");
sb.append("  {");
sb.append("    'max': " + max + ",");
sb.append("    'steps': " + max / 10 + ",");
sb.append("    'colour': '#000000',");
sb.append("    'grid-colour': '#E4E4E4'");
sb.append("  },");
sb.append("  'bg_colour': '#FFFFFF',");
sb.append("  'tooltip':{'stroke':1}");
sb.append("}");

Calendar c = Calendar.getInstance();




%>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/mt.js" type="text/javascript"></script>
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
  return "<%=sb.toString()%>".replace(/'/g,'"');
}
mt.tab=function(i)
{
  form1.st.value=form1.et.value='';
  form1.tab.value=i;
  form1.submit();
};
function save_image()
{
  mt.post("/Imgs.do?act=chart",$('chart').get_img_binary());
}
</script>
</head>
<body>
<h1>查看——使用次数统计</h1>
<div id="head6"><img height="6" src="about:blank"></div>


<%
out.print("<div class='switch'>");
for(int i=0;i<TAB.length;i++)
{
  out.print("<a href='javascript:mt.tab("+i+")'");
  if(i==tab)out.print(" class='current'");
  out.print(">"+TAB[i]+"</a>");
}
out.print("</div>");
%>


<form name="form1" action="?">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="id" value="<%=h.getInt("id")%>"/>
<input type="hidden" name="tab" value="<%=tab%>" />

<table id="tablecenter" cellspacing="0">
<tr>
  <td><select onchange="mt.fast(value);">
<%
if(tab==0)
{
  String[] arr={"今天","昨天","前天"};
  out.print("<option value='—'>最近24小时");
  c.add(Calendar.DAY_OF_YEAR,1);
  String last=MT.f(c.getTime());
  for(int i=0;i<arr.length;i++)
  {
    c.add(Calendar.DAY_OF_YEAR,-1);
    String tmp=MT.f(c.getTime()),str=tmp+"—"+last;
    last=tmp;
    out.print("<option value="+str);
    if(str.equals(sst+"—"+set))out.print(" selected");
    out.print(">"+arr[i]);
  }
}else if(tab==1)
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
  out.print("<script>$('tablecenter').style.display='none'</script>");
}
%>
</select>
  <td>时间：<input name="st" value="<%=sst%>" class="date" onclick="mt.date(this)"/>—<input name="et" value="<%=set%>" class="date" onclick="mt.date(this)"/> <input type="submit" value="查询" /></td>
</tr>
</table>
</form>


<table id="tablecenter" cellspacing="0">
<tr><td><script>mt.embed('/tea/mt/chart.swf','100%',300);</script>
</table>
<input type="button" value="导出" onclick="save_image()"/>

</body>
</html>
