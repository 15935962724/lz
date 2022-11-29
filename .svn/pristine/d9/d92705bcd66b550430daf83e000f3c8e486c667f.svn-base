<%@ page contentType="text/html; charset=UTF-8" %><%@page import="tea.entity.*" %><%@page import="java.util.*" %><%!
String options(HashMap hm,int val)
{
  StringBuilder htm=new StringBuilder();
  Iterator it=hm.keySet().iterator();
  while(it.hasNext())
  {
    Integer key=(Integer)it.next();
    htm.append("<option value="+key);
    if(key.equals(val))htm.append(" selected");
    htm.append(">"+hm.get(key));
  }
  return htm.toString();
}
%><%

if(!OS.isWin)
{
  response.sendRedirect("/jsp/os/Event1s.jsp?"+request.getQueryString());
  return;
}

Http h=new Http(request,response);

String menu=h.get("id","");
boolean ifr="562fb2c0c2d9af15c3054e35".equals(menu);
if(ifr)h.member=1;
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}

//账户锁定策略: 不能是administrator 必须是存在的用户
//无法打开事件查询。 拒绝访问。
StringBuilder sql=new StringBuilder(),par=new StringBuilder();

par.append("?id="+menu+"&community="+h.community);

int task=h.getInt("task");
if(task>0)
{
  sql.append("/q:*[System[Task="+task+"]]");
  par.append("&task="+task);
}

String[] TAB={"安全","应用程序","系统"},NAME={"security","application","system"};
int tab=h.getInt("tab");
par.append("&tab="+tab);

par.append("&pos=");
int pos=h.getInt("pos");

String str=null;
try
{
  str=OS.exec("wevtutil qe "+NAME[tab]+" /c:"+(pos+20)+" /rd:true "+sql.toString(),"></Event>",pos);
}catch(Throwable ex)
{
  out.print("不支持！");
  return;
}

//String str=Filex.read(application.getRealPath("/aa.txt"),"utf-8");
//Filex.write(application.getRealPath("/wevt.txt"),str);

XMLObject xml=new XMLObject("<root>"+str+"</root>").getXMLObject("root");
XMLArray event=xml.getXMLArray("event");


HashMap KEYWORDS=new HashMap(),TASK=new HashMap(),ENV=new HashMap();
KEYWORDS.put("0x80000000000000","经典");//系统启动
KEYWORDS.put("0x8000000000000000","同步时间");
KEYWORDS.put("0x8000000000000010","时间");
KEYWORDS.put("0x8020000000000000","审核成功");
KEYWORDS.put("0x8010000000000000","<font color=red>审核失败</font>");
KEYWORDS.put("0x8080000000000000","服务");

TASK.put(new Integer(104),"日志清除");
TASK.put(new Integer(12290),"系统完整性");
TASK.put(new Integer(12544),"登录");
TASK.put(new Integer(12545),"注销");
TASK.put(new Integer(12548),"特殊登录");//为新登录分配了特殊权限。
TASK.put(new Integer(12801),"注册表");
TASK.put(new Integer(12804),"其他对象访问事件");//已请求到对象的句柄。
TASK.put(new Integer(12809),"筛选平台数据包丢弃");

String[] LEVEL={"","","错误","警告","信息"};

ENV.put("%%1553","指定的访问权未知(bit 1)");
ENV.put("%%2313","未知用户名或密码错误。");
ENV.put("%%14592","入站");
ENV.put("%%14597","传输");

Calendar c=Calendar.getInstance();

%><!DOCTYPE html><html><head>
<link href="<%=ifr?"http://center.redcome.com":""%>/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/mt.js" type="text/javascript"></script>
<%
if(ifr)out.print("<style>h1{display:none}</style>");
%>
</head>
<body>
<h1>事件查看器</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" action="?">
<input type="hidden" name="id" value="<%=menu%>"/>
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="tab" value="<%=tab%>"/>
<table id="tablecenter" cellspacing="0">
<tr>
  <td class="th">类别:</td><td><select name="task"><option value="">--</option><%=options(TASK,task)%></select></td>
  <td class="th">关键字:</td><td><select name="keywords"><option value="">--</option><%//=options(KEYWORDS,keywords)%></select></td>
  <td><input type="submit" value="查询"/></td>
</tr>
</table>
</form>

<%
out.print("<div class='switch'>");
for(int i=0;i<TAB.length;i++)
{
  out.print("<a href='javascript:mt.tab("+i+")'>"+TAB[i]+"</a>");
}
out.print("</div>");
%>
<form name="form2" action="/IpSecs.do" method="post" target="_ajax" onSubmit="return mt.check(this)">
<input type="hidden" name="act"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="srcaddr"/>
<input type="hidden" name="dstaddr"/>

<table id="tablecenter" cellspacing="0">
<tr id="tableonetr">
  <td>事件ID</td>
  <td>类别</td>
  <td>时间</td>
  <td>计算机</td>
  <td>关键字</td>
  <td>账户名</td>
  <td>进程名</td>
  <td>源网络地址</td>
  <td>备注</td>
</tr>
<%
for(int i=0;i<event.size();i++)
{
  xml=event.getXMLObject(i);

  XMLObject sys=xml.getXMLObject("system");
  //
  StringBuilder sb=new StringBuilder(sys.getXMLObject("timecreated.attr").getString("SystemTime"));
  sb.setCharAt(10,' ');
  //sb.setLength(16);
  c.setTime(MT.d(sb.toString()));
  c.add(Calendar.HOUR,8);

  task=sys.getInt("task");
  out.print("<tr><td>"+sys.getString("eventid"));
  out.print("<td>"+TASK.get(task));
  out.print("<td>"+MT.f(c.getTime(),1));
  out.print("<td>"+sys.getString("computer"));
  out.print("<td>"+KEYWORDS.get(sys.getString("keywords")));
  //
  HashMap hm=new HashMap();
  XMLObject data=xml.getXMLObject("eventdata");
  XMLArray name=data.getXMLArray("data.attr"),value=data.getXMLArray("data");
  if(name!=null)
  for(int j=0;j<name.size();j++)
  {
    hm.put(name.getXMLObject(j).getString("Name"),value.getString(j));
  }
  Object un=hm.get("TargetUserName");
  if(un==null)un=hm.get("SubjectUserName");
  Object pn=hm.get("ProcessName");
  if(pn==null)pn=hm.get("Application");
  out.print("<td>"+un);
  out.print("<td>["+hm.get("ProcessId")+"]"+pn);
  out.print("<td>"+hm.get("IpAddress")+":"+hm.get("IpPort"));
  out.print("<td>");
  String htm="";
//  if("0x80000000000000".equals(sys.getString("keywords")))
//  {
//    htm="系统启动时间为 "+value.getInt(4)+" 秒。";
//  }else if("0x8080000000000000".equals(sys.getString("keywords")))
//  {
//    Object sn=hm.get("ServiceName");
//    if(sn!=null)
//    htm=sn+"服务安装！";
//    else
//    htm=hm.get("param1")+" 服务处于 "+hm.get("param2")+" 状态。";
//  }else if("0x8000000000000010".equals(sys.getString("keywords")))
//  {
//    htm="系统时间已从 ‎"+hm.get("OldTime")+" 更改为 ‎"+hm.get("NewTime")+"。";
//  }else if("0x8000000000000000".equals(sys.getString("keywords")))
//  {
//    htm="时间服务现在用时间源 "+hm.get("TimeSource")+" 同步系统时间。";
//  }else
  switch(task)
  {
    case 12548:
    htm=hm.get("PrivilegeList").toString().replaceAll("\n","<br/>");
    break;
    case 12804://访问请求信息
    htm="访问: "+hm.get("AccessList")+"<br/>原因:"+hm.get("AccessReason");
    break;
    case 12809://网络信息
    htm="方向: "+hm.get("Direction")+"<br/>层名称:"+hm.get("LayerName");
    break;
    case 12544:
    htm+=hm.get("FailureReason");//原因
    break;
    default:
    htm=value.toString();
  }
  Iterator it=ENV.keySet().iterator();
  while(it.hasNext())
  {
    String key=(String)it.next();
    htm=htm.replaceAll(key,(String)ENV.get(key));
  }
  out.print(htm);
}
out.print("<tr><td colspan='20' align='right'>"+new tea.htmlx.FPNL(h.language,par.toString(),pos,Integer.MAX_VALUE,20));
%>
</table>
</form>

<script>
form2.nexturl.value=location.pathname+location.search;
mt.act=function(a,b)
{
  form2.act.value=a;
  if(a=='del')
  {
    var tr=mt.ftr(b).childNodes;
    form2.srcaddr.value=tr[1].innerHTML;
    form2.dstaddr.value=tr[2].innerHTML;
    mt.show('确认删除？',2,'form2.submit()');
  }else if(a=='clear')
  {
    mt.show('确认清空？',2,'form2.submit()');
  }else if(a=='add')
  {
    form2.action='/jsp/os/IpSecEdit.jsp';
    form2.target=form2.method='';
    form2.submit();
  }
};
</script>
</body>
</html>
