<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%><%@page import="java.text.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%>
<%@page import="tea.entity.stat.*"%><%

Http h=new Http(request);
//cscript c:\windows\System32\eventquery.vbs /l Security /v

ArrayList al=new ArrayList();
al.add("wevtutil");
al.add("qe");
al.add("security");
al.add("/rd:true");
//al.add("/c:3");
//al.add("/f:RenderedXml");
String act=h.get("act"),nexturl=h.get("nexturl");
if("cl".equals(act))
{
  al.set(1,act);
  al.add("/bu:"+application.getRealPath("/res/"+System.currentTimeMillis()+".evtx"));
}
String str=Filex.read(application.getRealPath("/jsp/stat/test.xml"),"GBK");
//Process p = new ProcessBuilder(al).redirectErrorStream(true).start();
//String str=new String(Filex.read(p.getInputStream()),"GBK");
//p.destroy();
if(nexturl!=null)
{
  out.print("parent.location='"+nexturl+"'");
  return;
}

StringBuilder par=new StringBuilder();
par.append("?id="+request.getParameter("id"));
par.append("&pos=");
int pos=h.getInt("pos");

HashMap TASK=new HashMap();
TASK.put(Integer.valueOf(104),"日志清除");
TASK.put(Integer.valueOf(12290),"系统完整性");
TASK.put(Integer.valueOf(12544),"登录");
TASK.put(Integer.valueOf(12545),"注销");
TASK.put(Integer.valueOf(12548),"特殊登录");
TASK.put(Integer.valueOf(14336),"凭据验证");

String[] LEVEL={"","","错误","警告","信息"};
String[] COLOR={"","#FFA333","#009149","#0058C6"};
HashMap hmc=new HashMap();

%><html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/cssjs/admin.css" rel="stylesheet" type="text/css"/>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>事件查看器</h1>
<div id="head6"><img height="6" src="about:blank"></div>


<form name="form1" action="?">
<input type="hidden" name="community" value="<%=h.community%>"/>

<table id="tablecenter" cellspacing="0">
<tr>
  <td><input type="submit" value="查询"/>
</table>
</form>

<div class="switch">
<a href='javascript:mt.tab(0)' id='security'>安全</a>
<a href='javascript:mt.tab(0)' id='application'>应用程序</a>
<a href='javascript:mt.tab(0)' id='system'>系统</a>
</div>
<textarea cols="" rows=""><%=str%></textarea>
<form name="form2" action="?" method="post" target="_ajax">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="taskmgr"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<table id="tablecenter" cellspacing="0">
<tr id='tableonetr'><td></td><td>事件ID</td><td>任务类别</td><td>时间</td><td>用户名</td><td>IP地址</td><td>操作</td></tr>
<%
//XMLArray arr=new XMLObject("<root>"+str+"</root>").getXMLObject("root").getXMLArray("event");
////System.out.println(arr);
//int sum=arr.size();
//int size=Math.min(pos+20,sum);
//Calendar c=Calendar.getInstance();
//for(int i=pos;i<size;i++)
//{
//  XMLObject t=arr.getXMLObject(i);
//  XMLObject s=t.getXMLObject("system");
//  XMLObject ed=t.getXMLObject("eventdata");
//  out.print("<tr onMouseOver=bgColor='#FFFFCA' onMouseOut=bgColor=''>");
//  out.print("<td>"+i);
//  out.print("<td>"+s.getInt("eventid"));
//  out.print("<td>"+TASK.get(Integer.valueOf(s.getInt("task"))));
//  StringBuilder sb=new StringBuilder(s.getXMLObject("timecreated.attr").getString("SystemTime"));
//  sb.setCharAt(10,' ');
//  //sb.setLength(16);
//  c.setTime(MT.SDF[1].parse(sb.toString()));
//  c.add(Calendar.HOUR,8);
//  out.print("<td>"+MT.f(c.getTime(),1));
//  if(ed!=null)
//  {
//    XMLArray data=ed.getXMLArray("data");
//    XMLArray attr=ed.getXMLArray("data.attr");
//    for(int j=0;j<attr.size();j++)
//    {
//      ed.put(attr.getXMLObject(j).get("Name"),data.get(j));
//    }
//    String id=ed.getString("TargetLogonId");
//    //hmc.get(id);
//    out.print("<td title='"+id+"'>"+ed.get("TargetUserName"));
//    out.print("<td>");
//    String ip=ed.getString("IpAddress");
//    if(ip!=null&&ip.length()>1)
//    out.print(ip+"-"+Ip.findByIp(ip));
//  }else out.print("<td><td>");
//  out.print("<td><a href=javascript:mt.act('view','')>查看</a>");
//}
//if(sum>20)out.print("<tr><td colspan='10' align='right'>"+new tea.htmlx.FPNL(h.language,par.toString(),pos,sum,20));
%>
</table>

<input type="button" value="清空" onclick="mt.act('cl','')"/>
</form>

<script>
form2.nexturl.value=location.pathname+location.search;
mt.act=function(a,id,b)
{
  form2.act.value=a;
  //form2.taskmgr.value=id;
  if(a=='cl')
  {
    mt.show('你确定要删除吗？',2,'form2.submit()');
  }else
  {
    if(a=='view')
    {
      form2.action='/jsp/stat/EvtxView.jsp';
      form2.target=form2.method='';
    }
    form2.submit();
  }
}
mt.tab=function(i)
{
  form1.tab.value=i;
  form1.submit();
};
mt.order=function(a)
{
  form1.order.value=a.id.substring(1);
  form1.submit();
};
</script>
</body>
</html>
