<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.db.DbAdapter" %><%@page import="tea.entity.node.*" %><%@page import="java.util.*" %><%@page import="tea.entity.site.*" %><%@page import="tea.resource.Resource" %><%@page import="tea.entity.admin.*" %><%@page import="tea.entity.member.*" %><%@page import="tea.ui.TeaSession" %><% request.setCharacterEncoding("UTF-8");

response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String member=teasession._rv._strV;

String community=teasession.getParameter("community");
String nexturl=teasession.getParameter("nexturl");
int flow=Integer.parseInt(teasession.getParameter("flow"));

String tmp=teasession.getParameter("flowbusiness");
int flowbusiness=tmp==null?0:Integer.parseInt(tmp);

Flowbusiness fb=Flowbusiness.find(flowbusiness);
int step=fb.getStep();
boolean isNew=false;
if(step==-1)
{
  isNew=true;
  step=1;
}

if(step==0)
{
  out.print("<script>alert('该流程已结束！');history.back();</script>");
  return;
}
Flowprocess fp=Flowprocess.find(flow,step);
if(!fp.isExists())
{
  out.print("<script>alert('第“"+step+"”步流程不存在！');history.back();</script>");
  return;
}
int flowprocess=fp.getFlowprocess();
Flow f=Flow.find(flow);
Flowview fv=Flowview.find(flowbusiness,flowprocess,member);

//如果不是"自由流程" 并 经办人中不存在当前会员
if(f.getType()!=1&&(isNew?fp.getMember().indexOf("/"+member+"/")==-1:!fv.isExists())&&!member.equals(fb.getCreator())&&!member.equals(fb.getMainTransactor())&&!member.equals(fb.getMainConsign()))
{
  out.print("<script>alert('该流程已退回或已传下一步！');history.back();</script>");
  return;
}

//独占///
String exclusive=fb.getExclusive();
if(exclusive!=null&&!exclusive.equals(member)&&OnlineList.find(exclusive).isOnline())
{
  response.sendRedirect("/jsp/info/Alert.jsp?info="+java.net.URLEncoder.encode("该步骤 "+exclusive+" 正在办理,请等候...","UTF-8"));
  return;
}
fb.setExclusive(member);

int type=f.getType();
String dtw=fp.getDTWrite();
String dtr=fp.getDTRead();

String dtprev="/";//上一步的可填字段////
int pstep=0;
if (f.getType() == 2) //可控流程//
{
  if (flowprocess == f.getMainProcess()&&fb.isRunMain()) //如果当前是主控步骤 && 走过主控步骤
  {
    int flowview=Flowview.findLast(flowbusiness,flowprocess);
    pstep=Flowprocess.find(Flowview.find(flowview).getFlowprocess()).getStep();//主控的前一步
    Flowprocess fp2 = Flowprocess.find(flow, pstep);
    dtprev=fp2.getDTWrite();
    dtw=fp2.getMainDTWrite();
    dtr=fp2.getMainDTRead();
  }
}
boolean isCreator=member.equals(fb.getCreator());
boolean isManage=f.getType()==2 &&(member.equals(fb.getMainTransactor()) || member.equals(fb.getMainConsign()));
boolean isSubmit=isNew||fv.isExists();
if(!isSubmit)dtw="/";

StringBuffer sbcheck=new StringBuffer();

Resource r=new Resource();

ProfileBBS pb = ProfileBBS.find(teasession._strCommunity, member);
String isign=pb.getISign(teasession._nLanguage);
String sn=pb.getSerialNum();

String dtws[]=dtw.split("/");

DynamicType dt;
StringTokenizer st;
int dynamictype;

%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type="text/javascript"></SCRIPT>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<style>
.dis{background:#E1E1E1}
.curbut{background:#E1E1E1}
</style>
<script type="">
var lastdiv,lastbut;
function f_swap(but)
{
  but.blur();
  var name=but.name;
  if(lastdiv)lastdiv.style.display="none";
  if(lastbut)lastbut.className="";
  var tab=document.all("tab"+name);
  tab.style.display="";
  but.className="curbut";
  lastdiv=tab;
  lastbut=but;
  if(name=="map")
  {
    var map=document.all("s<%=step%>");
    if(map.length)
    {
      for(var i=0;i<map.length;i++)
      {
        var pstep=map[i].pstep;
        if(pstep&&pstep.indexOf("<%=pstep%>")!=-1)
        {
          map=map[i];
          break;
        }
      }
      if(map.length)map=map[0];//第一次是主控时,上一步为0
    }
    f_linered(map,flag);
  }
}
function f_attach(dynamictype,act,flag)
{
  var rs=window.showModalDialog('/jsp/admin/flow/EditFlowAttach.jsp?community='+form1.community.value+'&field=dynamictype'+dynamictype+'&act='+act+'&count='+(flag?1:50)+'&info='+encodeURIComponent(flag?'上传正文':'上传附件')+'&t='+new Date().getTime(),self,'dialogWidth:400px;dialogHeight:320px;help:0;status:0;scroll:0;');
  if(rs!=undefined)
  {
    if(flag)//上传正文
    {
      document.all("dynamictype"+dynamictype).value=rs.substring(1);
    }else//上传附件
    {
      var td=document.getElementById("td"+dynamictype);
      td.innerHTML=f_file(rs,dynamictype);
    }
  }
}
function f_file(path,dt)
{
  if(path.length<2)//""或:
  {
    return "<input type='hidden' name='dynamictype"+dt+"' />";//防止接不到此值,而不改库
  }
  var tdh="";
  var arr=path.split(":");
  for(var i=1;i<arr.length;i++)
  {
    var name=arr[i].substring(arr[i].lastIndexOf('/')+1);
    tdh+="<a href='/jsp/include/DownFile.jsp?uri="+encodeURIComponent(arr[i])+"&name="+encodeURIComponent(name)+"'>";
    var j=name.lastIndexOf('.');
    if(j!=-1)name=name.substring(0,j);
    tdh+=name+"</a>,　";
    tdh+="<input type='hidden' name='dynamictype"+dt+"' value=\""+arr[i]+"\" />";
  }
  return tdh;
}
function f_csign(dynamictype)
{
  var rs=window.showModalDialog('/jsp/admin/flow/EditFlowCSign.jsp?community='+form1.community.value+'&flowbusiness='+form1.flowbusiness.value+'&dynamictype='+dynamictype+'&t='+new Date().getTime(),self,'dialogWidth:400px;dialogHeight:200px;resizable:1;help:0;status:0;');
  if(rs)f_ajax('ajax_csign');
}
function f_opinion(dtw)
{
  var rs=window.showModalDialog('/jsp/admin/flow/EditFlowOpinion2.jsp?community='+form1.community.value+'&flowbusiness='+form1.flowbusiness.value+'&dtw='+dtw+'&t='+new Date().getTime(),self,'dialogWidth:400px;dialogHeight:230px;resizable:1;help:0;status:0;scroll:0;');
  if(rs)f_ajax('ajax_opinion');
}
function f_split(v)
{
  var arr=v.split(":");//有可能会是模板
  if(arr.length>1)v=arr[1];
  return encodeURIComponent(v.replace(/f/g,'?'));
}
function f_ajax(act,dt,str)
{
  if(act=="ajax_opinion")dt="/113,114,115/116,117,118/171,170,172/";
  var tb=document.getElementById(act);
  if(tb)
  {
    var tbs=tb.childNodes;
    if(tbs.length>0)
    {
      while(tbs.length>0)tb.removeChild(tbs[0]);
      $('view').contentWindow.location.reload();//刷新:处理笺
    }
  }
  sendx('/servlet/EditFlowdynamicvalue?flowbusiness='+form1.flowbusiness.value+'&act='+act+'&dynamictype='+dt+'&str='+encodeURIComponent(str),function(data){ eval(data); });
}
function f_load()
{
  f_swap(form1.base);
  if(<%=isNew%>)
  {
    var rs=window.showModalDialog('/jsp/admin/flow/SetFlowbusinessSubor.jsp?community='+form1.community.value,self,'dialogWidth:380px;dialogHeight:120px;help:0;status:0;scroll:0;');
    if(rs)
    {
      var j=rs.indexOf(';');
      form1.adminunitorg.value=rs.substring(0,j);
      form1.dynamictype108.value=rs.substring(j+1);
    }
  }
}
function submitSign(a)
{
  if(!a)
  {
    alert('您必须“签名”才能传下一步！');
    return false;
  }
  return true;
}
</script>
</head>
<body onunload="sendx('/servlet/EditFlowdynamicvalue?act=exclusive&flowbusiness='+form1.flowbusiness.value,null);" class="BodyProcess">
<form name="form1" action="/servlet/CecFlowbusinessEdit" method="post" enctype="multipart/form-data" onSubmit="return fcheck()">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>">
<input type="hidden" name="repository" value="flow">
<input type="hidden" name="node" value="<%=teasession._nNode%>">
<input type="hidden" name="flowbusiness" value="<%=flowbusiness%>">
<input type="hidden" name="nexturl" value="<%=nexturl%>">
<input type="hidden" name="flow" value="<%=flow%>">
<input type="hidden" name="adminunitorg" value="<%=AdminUnit.find(AdminUsrRole.find(teasession._strCommunity,member).getUnit()).adminunitorg%>">

<h1><div class="ProcessTitle">工作接收/办理</div>
<div id="head6"><img height="6" src="about:blank"></div>

<div class="Funciton">

<%
if(dtw.length()>2)out.println("<input type='submit' name='save' value='保存' class='edit_button'>");

//正文附件
dynamictype=120;
dt=DynamicType.find(dynamictype);
boolean bw=(type==1||dtw.indexOf("/"+dynamictype+"/")!=-1);
boolean br=(dtr.indexOf("/"+dynamictype+"/")!=-1||flowprocess == f.getMainProcess());
if(bw||br)
{
  out.println("<input type='button' name='dynamictype_button" + dynamictype+"' value='"+(isNew?"正文":"查看文件")+"' onclick='f_attach("+dynamictype+","+bw+",true);' />");
  out.print("<input type='hidden' name='dynamictype"+dynamictype+"'>");
}
//附件
dynamictype=160;
dt=DynamicType.find(dynamictype);
bw=(type==1||dtw.indexOf("/"+dynamictype+"/")!=-1);
br=(dtr.indexOf("/"+dynamictype+"/")!=-1||flowprocess == f.getMainProcess());
if(bw||br)
{
  out.println("<input type='button' name='dynamictype_button" + dynamictype+"' value='附件' onclick='f_attach("+dynamictype+","+bw+",false);' />");
}
//上报
dynamictype=169;
dt=DynamicType.find(dynamictype);
bw=(type==1||dtw.indexOf("/"+dynamictype+"/")!=-1);
br=dtr.indexOf("/"+dynamictype+"/")!=-1;
if(bw||br)
{
  out.println("<input type='button' name='dynamictype_button" + dynamictype+"' value='上报' onclick='f_attach("+dynamictype+","+bw+",false);' />");
}

//拟办意见
if(dtw.indexOf("/113/")!=-1)
{
  out.println("<input type='button' value='拟办意见' onclick=f_opinion('/113/114/115/') />");
}
//领导批示
if(dtw.indexOf("/116/")!=-1)
{
  out.println("<input type='button' value='公司领导批示' onclick=f_opinion('/116/117/118/') />");
}
//领导批示2
if(dtw.indexOf("/171/")!=-1)
{
  out.println("<input type='button' value='公司领导批示' onclick=f_opinion('/171/170/172/') />");
}
//会签
if(dtw.indexOf("/119/")!=-1)
{
  out.println("<input type='button' value='填写意见' onclick='f_csign(119)' />");
  sbcheck.append("&&submitSign(form1.dynamictype119_2)");
}else if(dtw.indexOf("/168/")!=-1)
{
  out.println("<input type='button' value='填写意见' onclick='f_csign(168)' />");
  sbcheck.append("&&submitSign(form1.dynamictype168_2)");
}
//发文字号
//if(dtw.indexOf("/109/")!=-1)
//{
//  out.println("<input type='button' value='文件字号' onclick=\"window.showModalDialog('/jsp/admin/cec/SetFlowbusinessSN_1033.jsp?community='+form1.community.value+'&flowbusiness='+form1.flowbusiness.value+'&code='+encodeURIComponent($('td109').innerHTML)+'&dynamictype=109&t='+new Date().getTime(),self,'dialogWidth:350px;dialogHeight:105px;resizable:1;help:0;status:0;');\" />");
//}
//归档
Flowprocess fp1=Flowprocess.find(flow,-1);
if(isSubmit)
{
  if(fp1.getStep()==step)out.println("<input type='button' value='归档' onclick=\"window.showModalDialog('/jsp/admin/flow/SetFlowbusinessFC.jsp?community='+form1.community.value+'&flowbusiness='+form1.flowbusiness.value+'&t='+new Date().getTime(),self,'dialogWidth:600px;dialogHeight:500px;resizable:1;help:0;status:0;');\" />");

  //第3步 //&&Flowview.count(" AND flowbusiness="+flowbusiness+" AND state<2 AND step="+fv.getStep())>1
  if(step==3||step==4)
  out.println("<input type='submit' name='off' value='阅毕' onclick=\"return confirm('确认要阅毕吗？')\"/>");

  if(fp1.getStep()!=step)
  out.print("<input type='submit' name='submit' value='发送' class='edit_button' onclick='return f_send()'>");
}
%>
<input type="button" value="返回" onClick="history.back();"  class="edit_button">
</div>
</h1>
<script>
function f_send()
{
  <%
  if(fp1.getStep()==step)
  {
    out.print("return confirm('您还没有归档，确认要发送吗？');");
  }
  %>
  return true;
}
</script>


<!--对话框中的INPUT  防止js无法校验必填问题  -start-->
<table style="display:none">
<tr><td>
    <input type="text" name="dynamictype113" disabled="disabled" />
    <input type="text" name="dynamictype114" disabled="disabled" />
    <input type="text" name="dynamictype115" disabled="disabled" />

    <input type="text" name="dynamictype116" disabled="disabled" />
    <input type="text" name="dynamictype117" disabled="disabled" />
    <input type="text" name="dynamictype118" disabled="disabled" />

    <input type="text" name="dynamictype171" disabled="disabled" />
    <input type="text" name="dynamictype170" disabled="disabled" />
    <input type="text" name="dynamictype172" disabled="disabled" />
</table>
<!-- -end-->

<span class="flowname"><%=f.getName(teasession._nLanguage)%></span>
<div class="FunctionButton">
<input type="button" name="base" value="基本信息" onClick="f_swap(this)"/>
<input type="button" name="print" value="收文稿纸" onClick="f_swap(this)"/>
<%
if(fb.isExists())//第一次不显示
{
  //if(dtw.indexOf("/55/")!=-1||dtw.indexOf("/60/")!=-1||dtw.indexOf("/65/")!=-1||dtw.indexOf("/70/")!=-1)
  {
    out.print("<input type='button' name='opinion'  value='办理意见' onclick='f_swap(this)' />");
  }
  out.print("<input type='button' name='process'  value='办理过程' onclick='f_swap(this)' />");
}
%>
<input type="button" name="map"  value="流程图" onClick="f_swap(this)"/>
</div>


<div class="Functiontable">
<table id="tabbase" style="display:none">
  <tr>
    <td class="tdtitle">来文标题</td>
    <td colspan="3" id="td112"><input type="text" name="dynamictype112" /></td>
  </tr>
  <tr>
    <td class="tdtitle">来文时间</td>
    <td colspan="3" id="td110"><input name='dynamictype110' type='text' onclick='showCalendar(this,true)' readonly='true' /></td>
  </tr>
  <tr>
    <td class="tdtitle">分类</td>
    <td colspan="3" id="td111"><input name='dynamictype111' /></td>
  </tr>
  <tr>
    <td class="tdtitle">附件</td>
    <td style="padding:0px;">
    <table id="tabbase_nei" border="0" cellspacing="0" cellpadding="0">
    <tr class="out">
    <td  class="tabtdteshu" id="td160" style="border-top:0px;border-left:0px;"></td>
    <td class="tdtitle" style="border-top:0px;">上报</td>
    <td id="td169" style="border-top:0px;"></td>
    </tr>
    </table>
    </td>
  </tr>
  <tr>
    <td class="tdtitle">来文单位</td>
    <td style="padding:0px;">
    <table id="tabbase_nei" border="0" cellspacing="0" cellpadding="0">
    <tr class="out">
    <td  class="tabtdteshu" id="td108" style="border-top:0px;border-left:0px;"><input type="text" name="dynamictype108"  /></td>
    <td class="tdtitle" style="border-top:0px;">来文编号</td>
    <td id="td109" style="border-top:0px;"><input name='dynamictype109' /></td>
    <%--
    <td id="td109" onpropertychange="var dt109=form1.dynamictype109; if(dt109.value!=innerHTML)dt109.value=innerHTML;" style="border-top:0px;"></td>
    <input type='hidden' name='dynamictype109' onpropertychange="var td109=document.getElementById('td109'); if(td109.innerHTML!=value) td109.innerHTML=value;" />
    --%>
    </tr>
    </table>
    </td>
  </tr>
<%
if(flowbusiness>0)
{
  StringBuilder read0=new StringBuilder("<tr><td class='tdtitle'>未 办 理</td><td colspan='3'>");
  StringBuilder read1=new StringBuilder("<tr><td class='tdtitle'>办 理 中</td><td colspan='3'>");
  StringBuilder read2=new StringBuilder("<tr><td class='tdtitle'>已 完 成</td><td colspan='3'>");
  Enumeration e=Flowview.find(flowbusiness,flowprocess);
  while(e.hasMoreElements())
  {
    int flowview=((Integer)e.nextElement()).intValue();
    Flowview fv2=Flowview.find(flowview);
    switch(fv2.getState())
    {
      case 0:
      read0.append(fv2.getTransactor()).append(", ");
      break;
      case 1:
      read1.append(fv2.getTransactor()).append(" ("+fv2.getTimeToString()+"), ");
      break;
      case 2:
      read2.append(fv2.getTransactor()).append(" ("+fv2.getTimeToString()+"), ");
      break;
    }
  }
  out.print(read0.toString());
  out.print(read1.toString());
  out.print(read2.toString());
}

%>
</table>



<!--////////////////////////发文稿纸////////////////////////////////////////////////////////////////-->
<div id="tabprint" style="display:none">
<iframe id="view" border="0" src="/jsp/admin/cec/FlowbusinessView.jsp?community=<%=teasession._strCommunity%>&flowitem=0&flowbusiness=<%=flowbusiness%>&dynamic=<%=f.getDynamic()%>&flow=<%=flow%>"></iframe>
</div>



<!--////////////////////////办理意见////////////////////////////////////////////////////////////////-->
<div id="tabopinion" style="display:none">
<table border=0 cellpadding=0 cellspacing=0 id=tablecenter>
<tr class=TableHeader>
  <td>意见</td>
  <td>签名</td>
  <td>日期</td>
</tr>
<tbody id="ajax_opinion"></tbody>
<script>f_ajax('ajax_opinion');</script>
</table>
<table border=0 cellpadding=0 cellspacing=0 id=tablecenter>
<tr class=TableHeader>
  <td>送签时间</td>
  <td>会签部门/人员</td>
  <td>会签意见</td>
  <td>签名</td>
  <td>签出日期</td>
</tr>
<tbody id="ajax_csign"></tbody>
<script>f_ajax('ajax_csign');</script>
</table>
</div>


<!--////////////////////////办理过程////////////////////////////////////////////////////////////////-->
<div id="tabprocess" style="display:none"><%=fb.getFlowviewToHtml(teasession._nLanguage)%></div>


<!--////////////////////////流程图////////////////////////////////////////////////////////////////-->
<div id="tabmap" style="display:none">
<span id="line" style="border:2px solid #FF0000; position:absolute; display:none;"></span>
<span id="flag" style="border:2px dotted #FF0000; position:absolute;"></span>
<img id="imgmap" src="/jsp/admin/cec/<%=flow%>.png" usemap="#Map" />
<map name="Map" onMouseOver="f_linered(event.srcElement,line)" onMouseOut="f_lineout();" onClick="f_lineclick(event.srcElement);">
  <area shape="rect" coords="89,6,190,33" href="###" id="s1"/>
  <area shape="rect" coords="91,79,191,119" href="###" id="s2"/>
  <area shape="rect" coords="89,165,190,192" href="###" id="s1" pstep="/2/"/>
  <area shape="rect" coords="89,235,189,264" href="###" id="s3"/>
  <area shape="rect" coords="89,309,188,335" href="###" id="s4"/>
  <area shape="rect" coords="89,380,188,408" href="###" id="s5"/>
  <area shape="rect" coords="88,452,188,480" href="###" id="s1" pstep="/5/"/>
  <area shape="rect" coords="90,526,189,554" href="###" id="s6"/>
  <area shape="rect" coords="90,594,189,622" href="###" id="s1" pstep="/6/"/>
  <area shape="rect" coords="90,669,189,697" href="###" id="s7"/>
  <area shape="rect" coords="89,742,188,770" href="###" id="s8"/>
</map>
</div>
<script type="">
var line=document.getElementById("line");
function f_linered(obj,line)
{
  var arr=obj.coords.split(",");
  for(var i=0;i<arr.length;i++)
  {
    arr[i]=parseInt(arr[i]);
  }
  var left=2,top=2;
  var imgmap=document.getElementById("imgmap");
  do
  {
    imgmap.offsetLeft;
    left+=imgmap.offsetLeft;
    top+=imgmap.offsetTop;
    imgmap=imgmap.offsetParent;
  }while(imgmap);
  line.style.left=arr[0]+left;
  line.style.top=arr[1]+top;
  line.style.width=arr[2]-arr[0];
  line.style.height=arr[3]-arr[1];
  line.style.display="";
}
function f_lineout()
{
  line.style.display="none";
}
function f_lineclick(obj)
{
  window.showModalDialog('/jsp/admin/flow/Flowview.jsp?community=' + form1.community.value + '&flow='+form1.flow.value + '&flowbusiness='+form1.flowbusiness.value+ '&setp='+obj.id.substring(1),self,'dialogWidth:400px;dialogHeight:300px;resizable:1;help:0;status:0;');
}
</script>
</div>


<script type="">
<%
Enumeration e2=DynamicType.findByDynamic(f.getDynamic(),"",0,Integer.MAX_VALUE);
while(e2.hasMoreElements())
{
  int id=((Integer)e2.nextElement()).intValue();
  dt=DynamicType.find(id);
  if(!dt.isHidden())continue;

  //if(120==id)
  //System.out.println("abccc");

  String ftype=dt.getType();
  DynamicValue av = DynamicValue.find(-flowbusiness, teasession._nLanguage, id);
  String value=av.getValue();
  if(dt.getFather()>0)
  {
    Enumeration e=av.findMulti(" AND member="+DbAdapter.cite(member),0,1);
    value=e.hasMoreElements()?((DynamicValue.Multi) e.nextElement()).getValue():null;
  }
  if(value==null)value="";
  value=value.replaceAll("\"","&quot;").replaceAll("\r\n","\\\\r\\\\n");
  int state=1;
  if(type==1||dtw.indexOf("/"+id+"/")!=-1||"office".equals(ftype)||"file".equals(ftype))
  {
    if(value.length()<1&&!"checkbox".equals(ftype))value=dt.getDefaultvalueToString(teasession);
    if(value.length()>0)
    {
      out.println("obj=form1.dynamictype"+id+";");
      out.println("if(obj)");
      out.println("{");
      out.println("  obj.value=\""+value+"\";");
      out.println("  arr=form1.dynamictype_checkbox"+id+";if(arr)for(var i=0;i<arr.length;i++)if(obj.value.indexOf('　'+arr[i].value+'　')!=-1||obj.value.indexOf(arr[i].value+'　')==0)arr[i].checked=true;");
      if("sign".equals(ftype))//隐藏签名按钮
      {
        out.println("img=obj.nextSibling; if(img&&img.src){ img.src=\""+value+"\"; img.nextSibling.style.display='none'; }");
      }
      out.println("}");
    }
    if(dt.isNeed())
    {
      sbcheck.append("&&submitText(form1.dynamictype"+id+",'“"+dt.getName(teasession._nLanguage)+"”必填！')");
    }
  }else if("sign".equals(ftype))//&&dtr.indexOf("/"+id+"/")==-1)//||flowprocess == f.getMainProcess()
  {
    out.println("obj=document.all('dynamictype_image"+id+"'); if(obj)obj.src=\""+value+"\";");
    out.println("obj=document.all('dynamictype_button"+id+"'); if(obj)obj.style.display='none';");
  }else
  {
    out.println("obj=document.all('td"+id+"'); if(obj)obj.innerHTML=\""+value+"\";");
  }
  //附件
  Enumeration e = av.findMulti("", 0, Integer.MAX_VALUE);
  if(e.hasMoreElements())
  {
    StringBuffer h_attrib=new StringBuffer();
    for(int i = 1; e.hasMoreElements(); i++)
    {
      DynamicValue.Multi dvm = (DynamicValue.Multi) e.nextElement();
      String path=dvm.getValue();
      h_attrib.append(":").append(path);
    }
    out.println("obj=document.all('td"+id+"'); if(obj)obj.innerHTML=f_file(\""+h_attrib.toString().replaceAll("\\\"","\\\\\"")+"\","+id+");");
  }
}

StringBuffer sb=new StringBuffer("/");
e2 = DynamicType.findByDynamic(f.getDynamic()," AND type='select' AND defaultvalue=12 AND hidden=1", 0, Integer.MAX_VALUE);
while(e2.hasMoreElements())
{
  int dtid=((Integer)e2.nextElement()).intValue();
  sb.append(dtid).append("/");
}
%>
function fcheck()
{
  return true<%=sbcheck.toString()%>;
}
f_load();
</script>

</form>


</body></html>
