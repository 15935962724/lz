<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.entity.weibo.*"%><%@page import="tea.ui.*"%><%@page import="tea.db.*"%><%

Http h=new Http(request,response);

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+h.node);
  return;
}
//h.member=teasession._rv.toString();


String act=h.get("act");

StringBuilder lab=new StringBuilder(),val=new StringBuilder();




String[] COLOR = {"FFA333","009149","0058C6","0058C6"};
String[] TAB={"制造商","固件版本","分辨率","城市/地区"};
String[] FIELD={"manufacturer","version","display","city"};


int tab=h.getInt("tab");
if(tab==3)WMobile.ref();


StringBuilder sb=new StringBuilder();

int max=50;
DbAdapter db=new DbAdapter();
try
{
  db.executeQuery("SELECT "+FIELD[tab]+",COUNT(*) FROM wmobile GROUP BY "+FIELD[tab]+"");
  while(db.next())
  {
    String field=db.getString(1);
    int sum=db.getInt(2);

    lab.append(",'").append(field).append("'");
    val.append(",").append(sum);
    max=Math.max(max,sum);
  }
}finally
{
  db.close();
}

sb.append("{");
sb.append("  'elements':");
sb.append("  [");
sb.append("    {");
sb.append("      'type':'bar_glass',");
sb.append("      'values':[" + val.substring(1) + "],");
sb.append("      'text':'"+TAB[tab]+"',");
sb.append("      'colour':'#" + COLOR[tab] + "',");
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
sb.append("      'size':12,");
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




%>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/mt.js" type="text/javascript"></script>
<script>
function open_flash_chart_data()
{
  return "<%=sb.toString()%>".replace(/'/g,'"');
}
function save_image()
{
  mt.post("/Imgs.do?act=chart",$('chart').get_img_binary());
}
mt.tab=function(i)
{
  form1.tab.value=i;
  form1.submit();
};
</script>
</head>
<body>
<h1>查看——固件环境统计</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" action="?">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="id" value="<%=h.getInt("id")%>"/>
<input type="hidden" name="tab" value="<%=tab%>"/>
</form>

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

<table id="tablecenter" cellspacing="0">
<tr><td><script>mt.embed('/tea/mt/chart.swf','100%',300);</script>
</table>
<input type="button" value="导出" onclick="save_image()"/>


</body>
</html>
