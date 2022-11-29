<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.db.*"%><%@page import="tea.entity.*"%><%@page import="tea.ui.stat.*"%><%!

void aa(String str,StringBuilder[] sb,long[] rw)
{
  String[] arr=str.split(",");
  for(int j=0;j<arr.length;j++)
  {
    if(sb[j]==null)sb[j]=new StringBuilder();
    long val=Long.parseLong(arr[j]);
    sb[j].append(",");
    if(rw==null)
      sb[j].append(val);
    else
    {
      sb[j].append(rw[j]>0&&rw[j]<val?val-rw[j]:0);
      rw[j]=val;
    }
  }
}
%><%

Http h=new Http(request);

String menu=h.get("id","");
boolean ifr="562fb2c0c2d9af15c3054e35".equals(menu);
if(ifr)h.member=1;
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}

StringBuffer sql=new StringBuffer();
StringBuffer par=new StringBuffer();

par.append("?id="+menu);

int tab=h.getInt("tab");
par.append("&tab="+tab);


String[] DISK=null,NET=null;
String[] NAME={"CPU使用率","磁盘使用率","磁盘读/K","磁盘写/K","网络入/K","网络出/K"};
long[][] rw=new long[6][10];
StringBuilder[][] dr=new StringBuilder[6][10];

Calendar cal=Calendar.getInstance();
cal.add(Calendar.DAY_OF_YEAR,-30);
int hsum=0;

StringBuilder sw=new StringBuilder("<div class=switch>"),lab=new StringBuilder();
DbAdapter db=new DbAdapter();
try
{
  db.executeQuery("SELECT host,disk,net FROM host WHERE disk IS NOT NULL");
  for(hsum=0;db.next();hsum++)
  {
    String host=db.getString(1);
    if(hsum==tab)
    {
      DISK=db.getString(2).split(",");
      NET=db.getString(3).split(",");
      sql.append(" AND host="+DbAdapter.cite(host));
    }
    sw.append("<a href=javascript:mt.tab("+hsum+") class="+(hsum==tab?"current":"")+">"+host+"</a>");
  }
  sw.append("</div>");

  db.executeQuery("SELECT perfmon,cpu,mem,disk,dr,dw,nr,nw,time FROM perfmon WHERE time>"+DbAdapter.cite(cal.getTime())+sql.toString());
  while(db.next())
  {
    int x=2;
    for(int j=0;j<dr.length;j++)
    {
      String str=db.getString(x++);
      if(j==0)str+=","+db.getString(x++);
      aa(str,dr[j],j<2?null:rw[j]);
    }
    lab.append(",'"+MT.f(db.getDate(x),1)+"'");
  }
}finally
{
  db.close();
}
lab.append(" ");



%><!DOCTYPE html><html>
<head>
<meta name="viewport" content="width=device-width,user-scalable=0">
<link href="<%=ifr?"http://center.redcome.com":""%>/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/mt.js"></script>
<script src="/tea/script/echarts.min.js"></script>
<%
if(ifr)out.print("<style>h1{display:none}</style>");
%>
<script>
data=
{
  xAxis:[{data:[<%=lab.substring(1)%>]}],
  yAxis:[{}],
  tooltip:{trigger:'axis'}
};
function f(data)
{
  var leg=[];
  for(var i=0;i<data.series.length;i++)leg[i]=data.series[i].name;
  data.legend={data:leg};
  return data;
}
</script>
</head>
<body>
<h1>系统监控</h1>

<form name="form1" action="?">
<input type="hidden" name="id" value="<%=menu%>"/>
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="tab" value="<%=tab%>"/>
</form>

<%
if(hsum>1)out.print(sw.toString());
%>
<form name="form2" action="/Adings.do" method="post" target="_ajax">
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>

<table id="tablecenter">
<%
String[][] TYPE={new String[]{"CPU","内存"},DISK,DISK,DISK,NET,NET};
for(int i=0;i<NAME.length;i++)
{
  out.print("<tr><td><div id=chart"+i+" style=height:300px></div>");
  out.print("<script>data.title={text:'"+NAME[i]+"'};data.series=[");
  for(int j=0;dr[i][j]!=null;j++)
  {
    String str=TYPE[i][j];
    out.print((j==0?"":",")+"{name:'"+(str==null?i+"x"+j:str.replace('\\','/'))+"',type:'line',data:["+dr[i][j].substring(1)+"]}");
  }
  out.println("]; echarts.init(chart"+i+").setOption(f(data));</script>");
}
%>
</table>
</form>

<script>

//chart.style.height=(navigator.userAgent.indexOf(' Mobile')>0?150:300)+"px";
</script>
</body>
</html>
