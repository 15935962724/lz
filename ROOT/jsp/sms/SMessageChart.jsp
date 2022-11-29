<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.ui.*"%><%@page import="tea.db.*"%>
<%@page import="tea.entity.node.*"%><%@page import="tea.entity.member.*"%><%

Http h=new Http(request,response);

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+h.node);
  return;
}
//h.member=teasession._rv.toString();


String[] COLOR = {"FFA333", "009149", "0058C6"};

String tab=h.get("tab","hour");
Date st=h.getDate("st");
Date et=h.getDate("et");
String sst=MT.f(st),set=MT.f(et);

if(et==null)et=new Date();

StringBuilder sb=new StringBuilder();
StringBuilder htm=new StringBuilder();
if ("hour".equals(tab))
{
  if(st==null)
  {
    Calendar c = Calendar.getInstance();
    c.add(Calendar.HOUR_OF_DAY, -24);
    c.set(Calendar.MINUTE, 0);
    c.set(Calendar.SECOND, 0);
    st=c.getTime();
  }
  int minute = (int) (st.getTime() / 1000);
  int max = 100, s0 = 0, s1 = 0;
  //
  StringBuilder sb0 = new StringBuilder(), sb1 = new StringBuilder();
  String expr=DbAdapter.format("time",13);
  DbAdapter db = new DbAdapter();
  try
  {
    java.sql.ResultSet rs = db.executeQuery("SELECT "+expr+" expr,SUM(count0),SUM(count1) FROM smessage WHERE folder=2 AND time>" + DbAdapter.cite(st) + " AND time<" + DbAdapter.cite(et) + " GROUP BY "+expr+" ORDER BY expr", 0, Integer.MAX_VALUE);
    for (int i = 1; rs.next(); i++)
    {
      long time=MT.SDF[1].parse(rs.getString(1) + ":00").getTime()/1000;
      int c0 = rs.getInt(2),c1 = rs.getInt(3);
      sb0.append(",{'x':" + time + ",'y':" + c0 + "}");
      sb1.append(",{'x':" + time + ",'y':" + c1 + "}");
      max = Math.max(max, c0);
      s0 += c0;
      s1 += c1;
    }
    rs.close();
  } finally
  {
    db.close();
  }
  sb.append("{");
  sb.append("  'elements':");
  sb.append("  [");
  sb.append("    {");
  sb.append("      'type':'line',");
  if (sb0.length() > 0)
  sb.append("      'values':[" + sb0.substring(1) + "],");
  sb.append("      'text':'成功("+s0+")',");
  sb.append("      'colour':'#" + COLOR[0] + "'");
  sb.append("    },");

  sb.append("    {");
  sb.append("      'type':'line',");
  if (sb1.length() > 0)
  sb.append("      'values':[" + sb1.substring(1) + "],");
  sb.append("      'text':'失败("+s1+")',");
  sb.append("      'colour':'#" + COLOR[1] + "'");
  sb.append("    }");

  sb.append("  ],");
  sb.append("  'x_axis':");
  sb.append("  {");
  sb.append("    'steps': 3600,");
  sb.append("    'min': " + minute + ",");
  sb.append("    'max': " + (et.getTime()/1000-(set.length()<1?0:3600)) + ",");
  sb.append("    'labels':");
  sb.append("    {");
  sb.append("      'steps': 3600,");
  sb.append("      'visible-steps': 1,");
  sb.append("      'text': '#date:H#'");
  sb.append("    },");
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
} else if ("day".equals(tab))
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
  int minute = (int) (st.getTime() / 1000);
  int max = 100, s0 = 0, s1 = 0;
  //
  StringBuilder sb0 = new StringBuilder(), sb1 = new StringBuilder();
  String expr=DbAdapter.format("time",10);
  DbAdapter db = new DbAdapter();
  try
  {
    java.sql.ResultSet rs = db.executeQuery("SELECT "+expr+" expr,SUM(count0),SUM(count1) FROM smessage WHERE folder=2 AND time>" + DbAdapter.cite(st, true) + " AND time<" + DbAdapter.cite(et) + " GROUP BY "+expr+" ORDER BY expr", 0, Integer.MAX_VALUE);
    for (int i = 1; rs.next(); i++)
    {
      long time = MT.SDF[0].parse(rs.getString(1)).getTime() / 1000;
      int c0 = rs.getInt(2),c1 = rs.getInt(3);
      sb0.append(",{'x':" + time + ",'y':" + c0 + "}");
      sb1.append(",{'x':" + time + ",'y':" + c1 + "}");
      max = Math.max(max, c0);
      s0 += c0;
      s1 += c1;
    }
    rs.close();
  } finally
  {
    db.close();
  }

  sb.append("{");
  sb.append("  'elements':");
  sb.append("  [");
  sb.append("    {");
  sb.append("      'type':'line',");
  if (sb0.length() > 0)
  sb.append("      'values':[" + sb0.substring(1) + "],");
  sb.append("      'text':'成功("+s0+")',");
  sb.append("      'colour':'#" + COLOR[0] + "'");
  sb.append("    },");
  sb.append("    {");
  sb.append("      'type':'line',");
  if (sb1.length() > 0)
  sb.append("      'values':[" + sb1.substring(1) + "],");
  sb.append("      'text':'失败("+s1+")',");
  sb.append("      'colour':'#" + COLOR[1] + "'");
  sb.append("    }");
  sb.append("  ],");
  sb.append("  'x_axis':");
  sb.append("  {");
  sb.append("    'steps': 86400,");
  sb.append("    'min': " + minute + ",");
  sb.append("    'max': " + (et.getTime() / 1000-(set.length()<1?0:86400)) + ",");
  sb.append("    'labels':");
  sb.append("    {");
  sb.append("      'rotate': -45,");
  sb.append("      'steps': 86400,");
  sb.append("      'visible-steps': 1,");
  sb.append("      'text': '#date:Y-m-d#'");
  sb.append("    },");
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
} else if ("month".equals(tab))
{
  Calendar c = Calendar.getInstance();
  if(st==null)
  {
    c.add(Calendar.YEAR, -1);
    c.set(Calendar.DAY_OF_MONTH, 1);
    st=c.getTime();
  }else
    c.setTime(st);
  int max = 100, s0 = 0, s1 = 0;
  //
  HashMap hm = new HashMap();
  String expr=DbAdapter.format("time",7);
  DbAdapter db = new DbAdapter();
  try
  {
    java.sql.ResultSet rs = db.executeQuery("SELECT "+expr+" expr,SUM(count0),SUM(count1) FROM smessage WHERE folder=2 AND time>" + DbAdapter.cite(st, true) + " AND time<" + DbAdapter.cite(et) + " GROUP BY "+expr+" ORDER BY expr", 0, Integer.MAX_VALUE);
    while(rs.next())hm.put(rs.getString(1),new Integer[]{new Integer(rs.getInt(2)),new Integer(rs.getInt(3))});
    rs.close();
  } finally
  {
    db.close();
  }
  StringBuilder lab = new StringBuilder(), val0 = new StringBuilder(), val1 = new StringBuilder();
  for (int i = 0; i < 13; i++, c.add(Calendar.MONTH, 1))
  {
    String tip = MT.f(c.getTime()).substring(0, 7);
    lab.append(",'" + tip + "'");
    //
    Integer[] t = (Integer[]) hm.get(tip);
    int v0 = t == null ? 0 : t[0].intValue();
    int v1 = t == null ? 0 : t[1].intValue();
    //
    tip = tip + "<br>成功: " + v0 + "<br>失败: " + v1;
    val0.append(",{'top':").append(v0).append(",'tip':'" + tip + "'}");
    val1.append(",{'top':").append(v1).append(",'tip':'" + tip + "'}");
    max = Math.max(max, Math.max(v0, v1));
    s0+=v0;
    s1+=v1;
  }
  sb.append("{");
  sb.append("  'elements':");
  sb.append("  [");
  sb.append("    {");
  sb.append("      'type':'bar_glass',");
  sb.append("      'values':[" + val0.substring(1) + "],");
  sb.append("      'text':'成功("+s0+")',");
  sb.append("      'colour':'#" + COLOR[0] + "',");
  sb.append("      'on-show':");
  sb.append("      {");
  sb.append("        'type': 'drop',");
  sb.append("        'cascade': 1");
  sb.append("      }");
  sb.append("    },");
  sb.append("    {");
  sb.append("      'type':'bar_glass',");
  sb.append("      'values':[" + val1.substring(1) + "],");
  sb.append("      'text':'失败("+s1+")',");
  sb.append("      'colour':'#" + COLOR[1] + "',");
  sb.append("      'on-show':");
  sb.append("      {");
  sb.append("        'type': 'drop',");
  sb.append("        'cascade': 1");
  sb.append("      }");
  sb.append("    }");
  sb.append("  ],");
  sb.append("  'x_axis':");
  sb.append("  {");
  sb.append("    'labels':");
  sb.append("    {");
  sb.append("      'labels':[" + lab.substring(1) + "]");
  sb.append("    },");
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
} else if ("member".equals(tab))
{
  Calendar c = Calendar.getInstance();
  if(st==null)
  {
    c.add(Calendar.YEAR, -1);
    c.set(Calendar.DAY_OF_MONTH, 1);
    st=c.getTime();
  }else
    c.setTime(st);
  int max = 100, s0 = 0, s1 = 0;
  //
  StringBuilder lab = new StringBuilder(), val0 = new StringBuilder(), val1 = new StringBuilder();
  DbAdapter db = new DbAdapter();
  try
  {
    java.sql.ResultSet rs = db.executeQuery("SELECT member,SUM(count0),SUM(count1) FROM smessage WHERE folder=2 AND time>" + DbAdapter.cite(st, true) + " AND time<" + DbAdapter.cite(et) + " GROUP BY member ORDER BY SUM(count0) DESC", 0, 20);
    while(rs.next())
    {
      Profile m=Profile.find(rs.getInt(1));
      String tip =m.getMember();
      lab.append(",'" + tip + "'");
      //
      int v0 =rs.getInt(2),v1 =rs.getInt(3);
      //
      tip = tip + "<br>成功: " + v0 + "<br>失败: " + v1;
      val0.append(",{'top':").append(v0).append(",'tip':'" + tip + "'}");
      val1.append(",{'top':").append(v1).append(",'tip':'" + tip + "'}");
      max = Math.max(max, Math.max(v0, v1));
      s0+=v0;
      s1+=v1;
    }
    rs.close();
  } finally
  {
    db.close();
  }
  if(val0.toString()==null||val0.toString().equals("")){
	  val0.append(",");
	  val1.append(",");
	  lab.append(",");
  }
  sb.append("{");
  sb.append("  'elements':");
  sb.append("  [");
  sb.append("    {");
  sb.append("      'type':'bar_glass',");
  sb.append("      'values':[" + val0.substring(1) + "],");
  sb.append("      'text':'成功("+s0+")',");
  sb.append("      'colour':'#" + COLOR[0] + "',");
  sb.append("      'on-show':");
  sb.append("      {");
  sb.append("        'type': 'drop',");
  sb.append("        'cascade': 1");
  sb.append("      }");
  sb.append("    },");
  sb.append("    {");
  sb.append("      'type':'bar_glass',");
  sb.append("      'values':[" + val1.substring(1) + "],");
  sb.append("      'text':'失败("+s1+")',");
  sb.append("      'colour':'#" + COLOR[1] + "',");
  sb.append("      'on-show':");
  sb.append("      {");
  sb.append("        'type': 'drop',");
  sb.append("        'cascade': 1");
  sb.append("      }");
  sb.append("    }");
  sb.append("  ],");
  sb.append("  'x_axis':");
  sb.append("  {");
  sb.append("    'labels':");
  sb.append("    {");
  sb.append("      'labels':[" + lab.substring(1) + "],'size':12");
  sb.append("    },");
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
}

Calendar c = Calendar.getInstance();




%>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>查看——短信统计</h1>
<div id="head6"><img height="6" src="about:blank"></div>



<div class="switch">
<a href="###" onclick="mt.tab(id)" id="thour">时统计</a>
<a href="###" onclick="mt.tab(id)" id="tday">日统计</a>
<a href="###" onclick="mt.tab(id)" id="tmonth">月统计</a>
<a href="###" onclick="mt.tab(id)" id="tmember">发送者</a>
</div>
<script>
$('t<%=tab%>').className='current';
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
function ofc_ready()
{
}
mt.tab=function(a)
{
  form1.st.value=form1.et.value='';
  form1.tab.value=a.substring(1);
  form1.submit();
};
function save_image()
{
  mt.post("/Imgs.do?act=chart",$('chart').get_img_binary());
}
function line_1()
{
  var h='';
  for(var i=0;i<arguments.length;i++)h=i+"、"+arguments[i]+"\r\n";
  alert(h);
}
</script>



<form name="form1" action="?">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="id" value="<%=h.getInt("id")%>"/>
<input type="hidden" name="tab" value="<%=tab%>" />

<table id="tablecenter" cellspacing="0">
<tr>
  <td><select onchange="mt.fast(value);">
<%
if ("hour".equals(tab))
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
}else if("day".equals(tab))
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
