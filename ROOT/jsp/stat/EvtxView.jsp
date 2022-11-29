<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%><%@page import="java.text.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%>
<%@page import="tea.entity.stat.*"%><%

Http h=new Http(request);
//cscript c:\windows\System32\eventquery.vbs /l Security /v

ArrayList al=new ArrayList();
al.add("wevtutil");
al.add("qe");
al.add("security");
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
//String str="<Event xmlns='http://schemas.microsoft.com/win/2004/08/events/event'><System><Provider Name='Microsoft-Windows-Eventlog' Guid='{fc65ddd8-d6ef-4962-83d5-6e5cfe9ce148}'/><EventID>1102</EventID><Version>0</Version><Level>4</Level><Task>104</Task><Opcode>0</Opcode><Keywords>0x4020000000000000</Keywords><TimeCreated SystemTime='2013-01-30T08:26:16.148867800Z'/><EventRecordID>12905</EventRecordID><Correlation/><Execution ProcessID='640' ThreadID='8012'/><Channel>Security</Channel><Computer>WIN-PRJJPGKQVRA</Computer><Security/></System><UserData><LogFileCleared xmlns:auto-ns3='http://schemas.microsoft.com/win/2004/08/events' xmlns='http://manifests.microsoft.com/win/2004/08/windows/eventlog'><SubjectUserSid>S-1-5-21-258140067-1953656055-2204958895-500</SubjectUserSid><SubjectUserName>zgmzbadmin</SubjectUserName><SubjectDomainName>WIN-PRJJPGKQVRA</SubjectDomainName><SubjectLogonId>0x8b9f6</SubjectLogonId></LogFileCleared></UserData></Event>"+
//"<Event xmlns='http://schemas.microsoft.com/win/2004/08/events/event'><System><Provider Name='Microsoft-Windows-Security-Auditing' Guid='{54849625-5478-4994-A5BA-3E3B0328C30D}'/><EventID>4776</EventID><Version>0</Version><Level>0</Level><Task>14336</Task><Opcode>0</Opcode><Keywords>0x8020000000000000</Keywords><TimeCreated SystemTime='2013-01-30T08:28:40.516125200Z'/><EventRecordID>12906</EventRecordID><Correlation/><Execution ProcessID='880' ThreadID='932'/><Channel>Security</Channel><Computer>WIN-PRJJPGKQVRA</Computer><Security/></System><EventData><Data Name='PackageName'>MICROSOFT_AUTHENTICATION_PACKAGE_V1_0</Data><Data Name='TargetUserName'>zgmzbadmin</Data><Data Name='Workstation'>WIN-PRJJPGKQVRA</Data><Data Name='Status'>0x0</Data></EventData></Event>"+
//"<Event xmlns='http://schemas.microsoft.com/win/2004/08/events/event'><System><Provider Name='Microsoft-Windows-Security-Auditing' Guid='{54849625-5478-4994-A5BA-3E3B0328C30D}'/><EventID>4648</EventID><Version>0</Version><Level>0</Level><Task>12544</Task><Opcode>0</Opcode><Keywords>0x8020000000000000</Keywords><TimeCreated SystemTime='2013-01-30T08:28:40.517125200Z'/><EventRecordID>12907</EventRecordID><Correlation/><Execution ProcessID='880' ThreadID='932'/><Channel>Security</Channel><Computer>WIN-PRJJPGKQVRA</Computer><Security/></System><EventData><Data Name='SubjectUserSid'>S-1-5-18</Data><Data Name='SubjectUserName'>WIN-PRJJPGKQVRA$</Data><Data Name='SubjectDomainName'>WORKGROUP</Data><Data Name='SubjectLogonId'>0x3e7</Data><Data Name='LogonGuid'>{00000000-0000-0000-0000-000000000000}</Data><Data Name='TargetUserName'>zgmzbadmin</Data><Data Name='TargetDomainName'>WIN-PRJJPGKQVRA</Data><Data Name='TargetLogonGuid'>{00000000-0000-0000-0000-000000000000}</Data><Data Name='TargetServerName'>localhost</Data><Data Name='TargetInfo'>localhost</Data><Data Name='ProcessId'>0x6688</Data><Data Name='ProcessName'>C:\\Windows\\System32\\winlogon.exe</Data><Data Name='IpAddress'>219.143.89.135</Data><Data Name='IpPort'>47934</Data></EventData></Event>";
//out.print(str);
XMLArray arr=new XMLObject("<root>"+str+"</root>").getXMLObject("root").getXMLArray("event");
//System.out.println(arr);
Calendar c=Calendar.getInstance();
for(int i=0;i<arr.size();i++)
{
  XMLObject t=arr.getXMLObject(i);
  XMLObject s=t.getXMLObject("system");
  XMLObject ed=t.getXMLObject("eventdata");
  out.print("<tr onMouseOver=bgColor='#FFFFCA' onMouseOut=bgColor=''>");
  out.print("<td>"+i);
  out.print("<td>"+s.getInt("eventid"));
  out.print("<td>"+TASK.get(Integer.valueOf(s.getInt("task"))));
  StringBuilder sb=new StringBuilder(s.getXMLObject("timecreated.attr").getString("SystemTime"));
  sb.setCharAt(10,' ');
  //sb.setLength(16);
  c.setTime(MT.SDF[1].parse(sb.toString()));
  c.add(Calendar.HOUR,8);
  out.print("<td>"+MT.f(c.getTime(),1));
  if(ed!=null)
  {
    XMLArray data=ed.getXMLArray("data");
    XMLArray attr=ed.getXMLArray("data.attr");
    for(int j=0;j<attr.size();j++)
    {
      ed.put(attr.getXMLObject(j).get("Name"),data.get(j));
    }
    String id=ed.getString("TargetLogonId");
    //hmc.get(id);
    out.print("<td title='"+id+"'>"+ed.get("TargetUserName"));
    String ip=ed.getString("IpAddress");
    if(ip!=null&&ip.length()>1)
    out.print("<td>"+ip+"-"+Ip.findByIp(ip));
    out.print("<td><a href=mt.act('view','')>查看</a>");
  }
}
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
      form2.action='/jsp/stat/TaskMgrView.jsp';
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


