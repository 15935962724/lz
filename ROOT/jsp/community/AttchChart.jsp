<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%><%@page import="java.util.regex.*"%><%@page import="java.io.*"%><%@page import="tea.entity.*"%><%@page import="tea.db.*"%><%@page import="tea.entity.admin.*"%><%@page import="javax.swing.filechooser.*"%><%!
String chart(String name,long free,long total,int type)
{
  StringBuilder sb=new StringBuilder();
  sb.append("<table align='left'><tr><td rowspan='"+(total>0?3:1)+"'><img src='/tea/image/vista/drive"+type+".png' /></td><td>"+name+"</td></tr>");
  if(total>0)
  {
    float per=100-(total<1?0:free*100/total);
    sb.append("<tr><td style='border:1px solid #B2B2B2; width:200px;text-align:left'><div style='background-color:#"+(per<90?"016582":"CC0033")+";width:"+per+"%;height:12px'></div></td></tr><tr><td>"+free/1073741824+" GB 可用，共 "+total/1073741824+" GB</td></tr>");
  }
  sb.append("</table>");
  return sb.toString();
}
%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?node="+h.node);
  return;
}

String[] COLOR={"FFA333", "009149", "0058C6"};

String[] TAB={"时统计","日统计","月统计","类型"};
int tab=h.getInt("tab");

int menu=h.getInt("id");

Date st=h.getDate("st");
Date et=h.getDate("et");
String sst=MT.f(st),set=MT.f(et);

if(et==null)et=new Date();

StringBuilder sb=new StringBuilder();
if(tab==0)
{
  if(st==null)
  {
    Calendar c=Calendar.getInstance();
    c.add(Calendar.HOUR_OF_DAY,-24);
    c.set(Calendar.MINUTE,0);
    c.set(Calendar.SECOND,0);
    st=c.getTime();
  }
  int minute=(int)(st.getTime()/1000);
  int max=100,t1=0,t2=0;
  //
  StringBuilder sb0=new StringBuilder(),sb1=new StringBuilder();
  String expr=DbAdapter.format("time",13);
  DbAdapter db=new DbAdapter();
  try
  {
    System.out.println("SELECT "+expr+" AS expr,SUM(length)/1048576,COUNT(*) FROM attch WHERE time>"+DbAdapter.cite(st)+" AND time<"+DbAdapter.cite(et)+" GROUP BY "+expr+" ORDER BY expr");
    java.sql.ResultSet rs=db.executeQuery("SELECT "+expr+" AS expr,SUM(length)/1048576,COUNT(*) FROM attch WHERE time>"+DbAdapter.cite(st)+" AND time<"+DbAdapter.cite(et)+" GROUP BY "+expr+" ORDER BY expr",0,Integer.MAX_VALUE);
    for(int i=1;rs.next();i++)
    {
      String str=rs.getString(1)+":00";
      int v1=rs.getInt(2);
      int v2=rs.getInt(3);
      long time=MT.SDF[1].parse(str).getTime()/1000;
      String tip="日期："+str+"\\n大小："+v1+"M\\n数量："+v2+"个";
      sb0.append(",{'x':"+time+",'y':"+v1+",'tip':'"+tip+"'}");
      sb1.append(",{'x':"+time+",'y':"+v2+",'tip':'"+tip+"'}");
      max=Math.max(max,v1);
      max=Math.max(max,v2);
      t1+=v1;
      t2+=v2;
    }
    rs.close();
  }finally
  {
    db.close();
  }
  sb.append("{");
  sb.append("  'elements':");
  sb.append("  [");
  sb.append("    {");
  sb.append("      'type':'line',");
  if(sb0.length()>0)
  sb.append("      'values':["+sb0.substring(1)+"],");
  sb.append("      'text':'大小("+MT.f(t1)+"M)',");
  sb.append("      'colour':'#"+COLOR[0]+"'");
  sb.append("    },");

  sb.append("    {");
  sb.append("      'type':'line',");
  if(sb1.length()>0)
  sb.append("      'values':["+sb1.substring(1)+"],");
  sb.append("      'text':'数量("+MT.f(t2)+")',");
  //sb.append("      'dot-style':{'on-click':'line_1(11)'},");
  sb.append("      'colour':'#"+COLOR[1]+"'");
  sb.append("    }");

  sb.append("  ],");
  sb.append("  'x_axis':");
  sb.append("  {");
  sb.append("    'steps': 3600,");
  sb.append("    'min': "+minute+",");
  sb.append("    'max': "+(et.getTime()/1000-(set.length()<1?0:3600))+",");
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
  sb.append("    'max': "+max+",");
  sb.append("    'steps': "+max / 10+",");
  sb.append("    'colour': '#000000',");
  sb.append("    'grid-colour': '#E4E4E4'");
  sb.append("  },");
  sb.append("  'bg_colour': '#FFFFFF',");
  sb.append("  'tooltip':{'stroke':1}");
  sb.append("}");
}else if(tab==1)
{
  if(st==null)
  {
    Calendar c=Calendar.getInstance();
    c.add(Calendar.MONTH, -1);
    c.set(Calendar.HOUR_OF_DAY, 0);
    c.set(Calendar.MINUTE, 0);
    c.set(Calendar.SECOND, 0);
    st=c.getTime();
  }
  int minute=(int)(st.getTime()/1000);
  int max=100,t1=0,t2=0;
  //
  StringBuilder sb0=new StringBuilder(),sb1=new StringBuilder();
  String expr=DbAdapter.format("time",10);
  DbAdapter db=new DbAdapter();
  try
  {
    java.sql.ResultSet rs=db.executeQuery("SELECT "+expr+" AS expr,SUM(length)/1048576,COUNT(*) FROM attch WHERE time>"+DbAdapter.cite(st)+" AND time<"+DbAdapter.cite(et)+" GROUP BY "+expr+" ORDER BY expr",0,Integer.MAX_VALUE);
    for(int i=1;rs.next();i++)
    {
      String str=rs.getString(1);
      int v1=rs.getInt(2);
      int v2=rs.getInt(3);
      long time=MT.SDF[0].parse(str).getTime()/1000;
      String tip="日期："+str+"\\n大小："+v1+"M\\n数量："+v2+"个";
      sb0.append(",{'x':"+time+",'y':"+v1+",'tip':'"+tip+"'}");
      sb1.append(",{'x':"+time+",'y':"+v2+",'tip':'"+tip+"'}");
      max=Math.max(max,v1);
      max=Math.max(max,v2);
      t1+=v1;
      t2+=v2;
    }
    rs.close();
  }finally
  {
    db.close();
  }

  sb.append("{");
  sb.append("  'elements':");
  sb.append("  [");
  sb.append("    {");
  sb.append("      'type':'line',");
  if(sb0.length()>0)
  sb.append("      'values':["+sb0.substring(1)+"],");
  sb.append("      'text':'大小("+MT.f(t1)+"M)',");
  sb.append("      'colour':'#"+COLOR[0]+"'");
  sb.append("    },");

  sb.append("    {");
  sb.append("      'type':'line',");
  if(sb1.length()>0)
  sb.append("      'values':["+sb1.substring(1)+"],");
  sb.append("      'text':'数量("+MT.f(t2)+")',");
  sb.append("      'colour':'#"+COLOR[1]+"'");
  sb.append("    }");

  sb.append("  ],");
  sb.append("  'x_axis':");
  sb.append("  {");
  sb.append("    'steps': 86400,");
  sb.append("    'min': "+minute+",");
  sb.append("    'max': "+(et.getTime() / 1000-(set.length()<1?0:86400))+",");
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
  sb.append("    'max': "+max+",");
  sb.append("    'steps': "+max / 10+",");
  sb.append("    'colour': '#000000',");
  sb.append("    'grid-colour': '#E4E4E4'");
  sb.append("  },");
  sb.append("  'bg_colour': '#FFFFFF',");
  sb.append("  'tooltip':{'stroke':1}");
  sb.append("}");
}else if(tab==2)
{
  Calendar c=Calendar.getInstance();
  if(st==null)
  {
    c.add(Calendar.YEAR,-1);
    c.set(Calendar.DAY_OF_MONTH,1);
    st=c.getTime();
  }else
    c.setTime(st);
  int max=100,t1=0,t2=0;
  //
  HashMap hm=new HashMap();
  String expr=DbAdapter.format("time",7);
  DbAdapter db=new DbAdapter();
  try
  {
    java.sql.ResultSet rs=db.executeQuery("SELECT "+expr+" AS expr,SUM(length)/1048576,COUNT(*) FROM attch WHERE time>"+DbAdapter.cite(st,true)+" AND time<"+DbAdapter.cite(et)+" GROUP BY "+expr+" ORDER BY expr",0,Integer.MAX_VALUE);
    while(rs.next())
    {
      hm.put(rs.getString(1),new int[]{rs.getInt(2),rs.getInt(3)});
    }
    rs.close();
  }finally
  {
    db.close();
  }
  StringBuilder lab=new StringBuilder(),val0=new StringBuilder(),val1=new StringBuilder();
  for(int i=0;i<13;i++,c.add(Calendar.MONTH,1))
  {
    String tip=MT.f(c.getTime()).substring(0,7);
    lab.append(",'"+tip+"'");
    //
    int[] arr=(int[])hm.get(tip);
    if(arr==null)arr=new int[]{0,0};
    //
    tip=tip+"<br>大小："+arr[0]+"M<br>数量："+arr[1]+"个";
    val0.append(",{'top':").append(arr[0]).append(",'tip':'"+tip+"'}");
    val1.append(",{'top':").append(arr[1]).append(",'tip':'"+tip+"'}");
    max=Math.max(max,Math.max(arr[0],arr[1]));
    t1+=arr[0];
    t2+=arr[1];
  }
  sb.append("{");
  sb.append("  'elements':");
  sb.append("  [");
  sb.append("    {");
  sb.append("      'type':'bar_glass',");
  sb.append("      'values':["+val0.substring(1)+"],");
  sb.append("      'text':'大小("+MT.f(t1)+"M)',");
  sb.append("      'colour':'#"+COLOR[0]+"',");
  sb.append("      'on-show':");
  sb.append("      {");
  sb.append("        'type': 'drop',");
  sb.append("        'cascade': 1");
  sb.append("      }");
  sb.append("    },");

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
  sb.append("      'labels':["+lab.substring(1)+"]");
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
}else if(tab==3)
{
  if(st==null)st=new Date(0);
  int max=100,t1=0,t2=0;
  //
  StringBuilder lab=new StringBuilder(),val0=new StringBuilder(),val1=new StringBuilder();
  DbAdapter db=new DbAdapter();
  try
  {
    java.sql.ResultSet rs=db.executeQuery("SELECT type,SUM(length),COUNT(*) AS expr FROM attch WHERE time>"+DbAdapter.cite(st,true)+" AND time<"+DbAdapter.cite(et)+" GROUP BY type ORDER BY expr DESC",0,Integer.MAX_VALUE);
    while(rs.next())
    {
      String tip=rs.getString(1).toUpperCase();
      long v=rs.getLong(2);
      int v1=(int)(v/1048576);
      int v2=rs.getInt(3);
      lab.append(",'"+tip+"'");
      //
      tip+="<br>大小："+v1+"M<br>数量："+v2+"个<br>平均："+MT.f(v/v2/1024F)+"K";
      val0.append(",{'top':").append(v1).append(",'tip':'"+tip+"'}");
      val1.append(",{'top':").append(v2).append(",'tip':'"+tip+"'}");
      max=Math.max(max,Math.max(v1,v2));
      t1+=v1;
      t2+=v2;
    }
    rs.close();
  }finally
  {
    db.close();
  }
  sb.append("{");
  sb.append("  'elements':");
  sb.append("  [");
  sb.append("    {");
  sb.append("      'type':'bar_glass',");
  sb.append("      'values':["+val0.substring(1)+"],");
  sb.append("      'text':'大小("+MT.f(t1)+"M)',");
  sb.append("      'colour':'#"+COLOR[0]+"',");
  sb.append("      'on-show':");
  sb.append("      {");
  sb.append("        'type': 'drop',");
  sb.append("        'cascade': 1");
  sb.append("      }");
  sb.append("    },");
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
  sb.append("      'labels':["+lab.substring(1)+"]");
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
}

Calendar c=Calendar.getInstance();


%>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1><%=menu<1?"附件统计":AdminFunction.find(menu).getName(h.language)%><%--=Menu.find(menu).name--%></h1>
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
}else if(tab==2)
{
  out.print("<script>$$('tablecenter').style.display='none'</script>");
}else if(tab==3)
{
  out.print("<option value=''>全部");
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


<h2>空间详情</h2>
<table width="90%" align="center">
  <tr>
<%
if(System.getProperty("os.name").startsWith("Win"))//SunOS,Linux,Windows 2003
{
  FileSystemView fsv=FileSystemView.getFileSystemView();
  File[] fs=File.listRoots();
  for(int i=0;i<fs.length;i++)
  {
    long free=fs[i].getFreeSpace(),total=fs[i].getTotalSpace();
    //long free=80,total=100;
    char path=fs[i].getPath().charAt(0);
    int type;
    if(path=='A')
      type=0;
    else if(path==System.getenv("SystemRoot").charAt(0))
      type=1;
    else if(path==application.getRealPath("/").toUpperCase().charAt(0))
      type=4;
    else if(fsv.isHiddenFile(fs[i]))
      type=2;
    else type=3;
    String name=new String[]{"软盘驱动器","系统","磁盘","光盘驱动器","网站"}[type]+" ("+path+":)";
    try
    {
      String tmp=fsv.getSystemDisplayName(fs[i]);
      if(tmp.length()>0)name=tmp;
    }catch(Throwable ex)//IOException: Could not get shell folder ID list
    {}
    out.print("<td>"+chart(name,free,total,type));
  }
}else
{
  //文件系统 容量 已用 可用 已用% 挂载点
  Matcher m=Pattern.compile("([a-z0-9/]+)\\s+(\\d+)\\s+(\\d+)\\s+(\\d+)\\s+(\\d+)%\\s+([\\w/]+)").matcher(OS.exec("df -k"));
  while(m.find())
  {
    String path=m.group(6);
    int type=Http.REAL_PATH.startsWith(path+"/")?4:2;
    long total=Long.parseLong(m.group(2))*1024;
    if(total<1)continue;
    out.print("<td>"+chart(m.group(1)+"("+path+")",Long.parseLong(m.group(4))*1024,total,type));
  }
}
%></tr>
</table>

</body>
</html>
