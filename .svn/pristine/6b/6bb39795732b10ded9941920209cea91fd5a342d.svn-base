<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%><%@page import="java.io.*"%><%@page import="tea.entity.*"%><%@page import="tea.db.*"%><%@page import="tea.entity.admin.*"%><%@page import="tea.entity.tobacco.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?node="+h.node);
  return;
}

String[] COLOR={"FFA333", "009149", "0058C6"};

String[] TAB={"时统计","日统计","月统计","类型"};
int tab=h.getInt("tab",1);

int menu=h.getInt("id");

Date st=h.getDate("st");
Date et=h.getDate("et");
String sst=MT.f(st),set=MT.f(et);

if(et==null)et=new Date();

StringBuilder sb=new StringBuilder();
if(st==null)
{
  Calendar c=Calendar.getInstance();
  c.add(Calendar.DAY_OF_YEAR,-30);
  c.set(Calendar.MINUTE,0);
  c.set(Calendar.SECOND,0);
  st=c.getTime();
}
//
HashMap hm=new HashMap();
DbAdapter db=new DbAdapter();
try
{
  java.sql.ResultSet rs=db.executeQuery("SELECT matter,COUNT(*) AS expr FROM smoke WHERE type="+tab+" AND time>"+DbAdapter.cite(st)+" AND time<"+DbAdapter.cite(et)+" GROUP BY matter ORDER BY expr DESC",0,Integer.MAX_VALUE);
  while(rs.next())
  {
    hm.put(Integer.valueOf(rs.getInt(1)),Integer.valueOf(rs.getInt(2)));
  }
  rs.close();
}finally
{
  db.close();
}
//
StringBuilder lab=new StringBuilder(),val0=new StringBuilder(),val1=new StringBuilder();
int max=10,t1=0,t2=0;
for(int i=1;i<Smoke.MATTER_TYPE[tab].length;i++)
{
  String tip=Smoke.MATTER_TYPE[tab][i];
  Integer inte=(Integer)hm.get(Integer.valueOf(i));
  int v2=inte==null?0:inte.intValue();
  lab.append(",'"+tip+"'");
  //
  tip+="<br>数量："+v2+"条";
  val1.append(",{'top':").append(v2).append(",'tip':'"+tip+"'}");
  max=Math.max(max,v2);
  t2+=v2;
}
sb.append("{");
sb.append("  'elements':");
sb.append("  [");
//sb.append("    {");
//sb.append("      'type':'bar_glass',");
//sb.append("      'values':["+val0.substring(1)+"],");
//sb.append("      'text':'大小("+MT.f(t1)+"M)',");
//sb.append("      'colour':'#"+COLOR[0]+"',");
//sb.append("      'on-show':");
//sb.append("      {");
//sb.append("        'type': 'drop',");
//sb.append("        'cascade': 1");
//sb.append("      }");
//sb.append("    },");
sb.append("    {");
sb.append("      'type':'bar_glass',");
sb.append("      'values':["+val1.substring(1)+"],");
sb.append("      'text':'数量("+MT.f(t2)+")',");
sb.append("      'colour':'#"+COLOR[1]+"',");
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
sb.append("      'labels':["+lab.substring(1)+"],'size':12");
sb.append("    },");
sb.append("    'colour':      '#000000',");
sb.append("    'grid-colour': '#E4E4E4'");
sb.append("  },");
sb.append("  'y_axis':");
sb.append("  {");
sb.append("    'max': "+max+",");
sb.append("    'steps': "+max/10+",");
sb.append("    'colour': '#000000',");
sb.append("    'grid-colour': '#E4E4E4'");
sb.append("  },");
sb.append("  'bg_colour': '#FFFFFF',");
sb.append("  'tooltip':{'stroke':1}");
sb.append("}");


Calendar c=Calendar.getInstance();


%>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1><%=AdminFunction.find(menu).getName(h.language)%><%--=Menu.find(menu).name--%></h1>
<div id="head6"><img height="6" src="about:blank"></div>


<%
out.print("<div class='switch'>");
for(int i=1;i<Smoke.SMOKE_TYPE.length;i++)
{
  out.print("<a href='javascript:mt.tab("+i+")' class="+(i==tab?"current":"")+">"+Smoke.SMOKE_TYPE[i]+"</a>");
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
  return "<%=sb.toString()%>".replace(/'/g,'"');
}
function ofc_ready()
{
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
function line_1()
{
  var h='';
  for(var i=0;i<arguments.length;i++)h=i+"、"+arguments[i]+"\r\n";
  alert(h);
}
</script>



<form name="form1" action="?">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="id" value="<%=menu%>"/>
<input type="hidden" name="tab" value="<%=tab%>" />

<table id="tablecenter" cellspacing="0">
<tr>
  <td><select onchange="mt.fast(value);">
<%
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
