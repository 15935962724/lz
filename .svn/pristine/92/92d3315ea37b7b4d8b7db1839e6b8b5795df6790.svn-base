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
int flowbusiness=Integer.parseInt(teasession.getParameter("flowbusiness"));

int step=1;
int prev=0;
if(flowbusiness==0)
{
  prev=Integer.parseInt(teasession.getParameter("prev"));
}else
{
  Flowbusiness obj=Flowbusiness.find(flowbusiness);
  step=obj.getStep();
}
Flowbusiness fb=Flowbusiness.find(flowbusiness);
Flowprocess fp=Flowprocess.find(flow,step);
int flowprocess=fp.getFlowprocess();
Flow f=Flow.find(flow);

//如果不是"自由流程" 并 经办人中不存在当前会员
if(f.getType()!=1&&fp.getMember().indexOf("/"+member+"/")==-1&& !member.equals(fb.getCreator())&&!member.equals(fb.getMainTransactor())&&!member.equals(fb.getMainConsign()))
{
  response.sendError(403);
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
    var map=document.all("<%=step%>");
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
  window.showModalDialog('/jsp/admin/flow/EditFlowCSign.jsp?community='+form1.community.value+'&flowbusiness='+form1.flowbusiness.value+'&dynamictype='+dynamictype+'&t='+new Date().getTime(),self,'dialogWidth:400px;dialogHeight:320px;resizable:1;help:0;status:0;');
}
function f_opinion(dtw)
{
  var rs=window.showModalDialog('/jsp/admin/flow/EditFlowOpinion2.jsp?community='+form1.community.value+'&flowbusiness='+form1.flowbusiness.value+'&dtw='+dtw+'&t='+new Date().getTime(),self,'dialogWidth:400px;dialogHeight:230px;resizable:1;help:0;status:0;scroll:0;');
  if(rs)f_ajax('ajax_opinion');
}
function f_split(v)
{
  var arr=v.split(":");//有可能会是模板
  if(arr.length>1)
  {
    v=arr[1];
  }
  return encodeURIComponent(v);
}
function f_ajax(act,dt,str)
{
  if(act=="ajax_opinion")dt="/55,56,57/60,61,62/65,66,67/70,71,72/";
  var tb=document.getElementById(act);
  if(tb)
  {
    var tbs=tb.childNodes;
    while(tbs.length>0)
    {
      tb.removeChild(tbs[0]);
    }
  }
  sendx('/servlet/EditFlowdynamicvalue?flowbusiness='+form1.flowbusiness.value+'&act='+act+'&dynamictype='+dt+'&str='+encodeURIComponent(str),function(data){ eval(data); });
}
function f_load()
{
  f_swap(form1.base);
  <%
  if(flowbusiness<1)
  {
    out.print("window.showModalDialog('/jsp/admin/flow/SetFlowbusinessSubor.jsp?community='+form1.community.value+'&t='+new Date().getTime(),self,'dialogWidth:360px;dialogHeight:280px;help:0;status:0;scroll:0;');");
  }
  %>
}
</script>
</head>
<body onLoad="f_load()" onUnload="sendx(form1.action+'?act=exclusive&flowbusiness='+form1.flowbusiness.value,null);" class="BodyProcess">
<form name="form1" action="/servlet/EditFlowdynamicvalue" method="post" enctype="multipart/form-data" onSubmit="return fcheck();">
<input type="hidden" name="community" value="<%=community%>">
<input type="hidden" name="repository" value="flow">
<input type="hidden" name="node" value="<%=teasession._nNode%>">
<input type="hidden" name="flowbusiness" value="<%=flowbusiness%>">
<input type="hidden" name="nexturl" value="<%=nexturl%>">
<input type="hidden" name="prev" value="<%=prev%>">
<input type="hidden" name="flow" value="<%=flow%>">
<input type="hidden" name="adminunitorg" value="<%=AdminUnit.find(AdminUsrRole.find(teasession._strCommunity,member).getUnit()).adminunitorg%>">

<h1><div class="ProcessTitle">工作接收/办理</div>
<div id="head6"><img height="6" src="about:blank"></div>


<div class="Funciton">

<input type="submit" name="save" value="保存" class="edit_button">
<%
//正文
dynamictype=53;
dt=DynamicType.find(dynamictype);
boolean bw=(type==1||dtw.indexOf("/"+dynamictype+"/")!=-1);
boolean br=(dtr.indexOf("/"+dynamictype+"/")!=-1||flowprocess == f.getMainProcess());
if(bw||br)
{
  out.print("<input type='hidden' name='dynamictype" + dynamictype+"' />");
  if(bw)
  {
    out.print("<input type='button' dtype='office' name='dynamictype_button" + dynamictype+"' value='"+(flowbusiness>0?"查看文件":"正文")+"' onclick=\"");
    out.print("f_attach("+dynamictype+","+bw+",true);");
    out.println("\" />");
  }else
  {
    //out.print("window.showModalDialog('/jsp/community/CommunityOfficeView.jsp?community=" + teasession._strCommunity + "&file='+encodeURIComponent(previousSibling.value),self,'dialogWidth:800px;dialogHeight:600px;resizable:1;help:0;status:0;scroll:0;');");
  }
  if(flowbusiness>0)
  {
    out.println("<input type='button' value='正文下载' onclick=window.open('/jsp/include/DownFile.jsp?community="+teasession._strCommunity+"&uri='+encodeURIComponent(form1.dynamictype"+dynamictype+".value),'_self') />");
  }
}
//附件
dynamictype=54;
dt=DynamicType.find(dynamictype);
bw=(type==1||dtw.indexOf("/"+dynamictype+"/")!=-1);
br=(dtr.indexOf("/"+dynamictype+"/")!=-1||flowprocess == f.getMainProcess());
if(bw||br)
{
  out.println("<input type='button' name='dynamictype_button" + dynamictype+"' value='附件' onclick='f_attach("+dynamictype+","+bw+",false);' />");
}
//意见
if(dtw.indexOf("/55/")!=-1)
{
  out.println("<input type='button' value='填写意见' onclick=f_opinion('"+dtw+"') />");
}
//领导批示
if(dtw.indexOf("/60/")!=-1)
{
  out.println("<input type='button' value='填写意见' onclick=f_opinion('"+dtw+"') />");
}
//部门传阅
if(dtw.indexOf("/65/")!=-1)
{
  out.println("<input type='button' value='填写意见' onclick=f_opinion('"+dtw+"') />");
}
//承办部门办理结果
if(dtw.indexOf("/70/")!=-1)
{
  out.println("<input type='button' value='填写意见' onclick=f_opinion('"+dtw+"') />");
}
//归档
//if(step==1&&((fb.isSubor()&&pstep==6)||(!fb.isSubor()&&(pstep==3||pstep==4||pstep==5))))
if(step==1&&(pstep==6||(pstep==3||pstep==4||pstep==5)))//上一步"盖章",当前步主控...
{
  out.println("<input type='button' value='归档' onclick=\"window.showModalDialog('/jsp/admin/flow/SetFlowbusinessFC.jsp?community='+form1.community.value+'&flowbusiness='+form1.flowbusiness.value+'&t='+new Date().getTime(),self,'dialogWidth:600px;dialogHeight:500px;resizable:1;help:0;status:0;');\" />");
}
%>
<input type="submit" name="submit" value="发送" class="edit_button">
<input type="button" value="返回" onClick="history.back();"  class="edit_button">
</div>
</h1>
<!--对话框中的INPUT  防止js无法校验必填问题  -start-->
<table style="display:none">
  <tr>
    <td id="td55"><input type="text" name="dynamictype55" disabled="disabled" /></td>
    <td id="td56"><input type="text" name="dynamictype56" disabled="disabled" /></td>
    <td id="td57"><input type="text" name="dynamictype57" disabled="disabled" /></td>
  </tr>
  <tr>
    <td id="td60"><input type="text" name="dynamictype60" disabled="disabled" /></td>
    <td id="td61"><input type="text" name="dynamictype61" disabled="disabled" /></td>
    <td id="td62"><input type="text" name="dynamictype62" disabled="disabled" /></td>
  </tr>
  <tr>
    <td id="td65"><input type="text" name="dynamictype65" disabled="disabled" /></td>
    <td id="td66"><input type="text" name="dynamictype66" disabled="disabled" /></td>
    <td id="td67"><input type="text" name="dynamictype67" disabled="disabled" /></td>
  </tr>
  <tr>
    <td id="td70"><input type="text" name="dynamictype70" disabled="disabled" /></td>
    <td id="td71"><input type="text" name="dynamictype71" disabled="disabled" /></td>
    <td id="td72"><input type="text" name="dynamictype72" disabled="disabled" /></td>
  </tr>
</table>
<!-- -end-->



<div class="FunctionButton">
<input type="button" name="base"   value="基本信息" onClick="f_swap(this)"/>
<input type="button" name="print"  value="收文稿纸" onClick="f_swap(this)"/>
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
    <td class="tdtitle">文件名称</td>
    <td colspan="3" id="td52"><input type="text" name="dynamictype52" /></td>
  </tr>
  <tr>
    <td class="tdtitle">收文日期</td>
    <td colspan="3" id="td49"><input name='dynamictype49' type='text' onclick='showCalendar(this)' readonly='true' /></td>
  </tr>
  <tr>
    <td class="tdtitle">附　　件</td>
    <td colspan="3" id="td54"></td>
  </tr>
  <tr>
    <td class="tdtitle">来文单位</td>
    <td style="padding:0px;border:0px;">
    <table id="tabbase_nei" border="0" cellspacing="0" cellpadding="0">
    <tr class="out">
    <td  class="tabtdteshu" id="td50" style="border-top:0px;border-left:0px;"><input type="text" name="dynamictype50"  /></td>
    <td class="tdtitle" style="border-top:0px;">来文字号</td>
    <td id="td51" style="border-top:0px;"><input type="text" name="dynamictype51"  /></td> </tr>
    </table>
    </td>
  </tr>
  <tr>
    <td class="tdtitle">机密程度</td>

    <td style="padding:0px;border:0px;">
    <table id="tabbase_nei" border="0" cellspacing="0" cellpadding="0">
    <tr class="out2">
    <td  class="tabtdteshu"  id="td47" style="border-left:0px;">
    <%
    dynamictype=47;
    out.print("<input type='hidden' name='dynamictype" + dynamictype + "' />");
    dt=DynamicType.find(dynamictype);
    st = new StringTokenizer(dt.getContent(teasession._nLanguage), "/");
    for (int index = 0; st.hasMoreTokens(); index++)
    {
      String str = st.nextToken();
      String id = String.valueOf(dynamictype) + "_" + index;
      out.print("<input type='checkbox' name='dynamictype_checkbox" + dynamictype + "' value=\"" + str + "\" id='" + id + "' onclick=\"if(this.checked){dynamictype" + dynamictype + ".value+=this.value+'&#12288;';}else{dynamictype" + dynamictype + ".value=dynamictype" + dynamictype + ".value.replace(this.value+'&#12288;','');}\" /><label for=" + id + ">" + str + "</label> ");
    }
    %>    </td>
    <td class="tdtitle">缓急程度</td>
    <td id="td48">
    <%
    dynamictype=48;
    out.print("<input type='hidden' name='dynamictype" + dynamictype + "' />");
    dt=DynamicType.find(dynamictype);
    st = new StringTokenizer(dt.getContent(teasession._nLanguage), "/");
    for (int index = 0; st.hasMoreTokens(); index++)
    {
      String str = st.nextToken();
      String id = String.valueOf(dynamictype) + "_" + index;
      out.print("<input type='checkbox' name='dynamictype_checkbox" + dynamictype + "' value=\"" + str + "\" id='" + id + "' onclick=\"if(this.checked){dynamictype" + dynamictype + ".value+=this.value+'&#12288;';}else{dynamictype" + dynamictype + ".value=dynamictype" + dynamictype + ".value.replace(this.value+'&#12288;','');}\" /><label for=" + id + ">" + str + "</label> ");
    }
    %></td> </tr>
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
<iframe id="view" border="0" src="/jsp/admin/flow/FlowbusinessView.jsp?community=<%=teasession._strCommunity%>&flowitem=0&flowbusiness=<%=flowbusiness%>&dynamic=<%=f.getDynamic()%>&flow=<%=flow%>"></iframe>
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
<%--
int arr[][]={{55,56,57},{60,61,62},{65,66,67},{70,71,72}};
for(int i=0;i<arr.length;i++)
{
  if(i>0)
  {
    DynamicValue dv0 = DynamicValue.find(-flowbusiness, teasession._nLanguage, arr[i][0]);
    DynamicValue dv1 = DynamicValue.find(-flowbusiness, teasession._nLanguage, arr[i][1]);
    DynamicValue dv2 = DynamicValue.find(-flowbusiness, teasession._nLanguage, arr[i][2]);
    Enumeration e=dv0.findMulti("",0,Integer.MAX_VALUE);
    while(e.hasMoreElements())
    {
      DynamicValue.Multi m = (DynamicValue.Multi) e.nextElement();
      String v[]=new String[3];
      v[0] = m.getValue();
      String dvm=m.getMember();
      Enumeration e1=dv1.findMulti(" AND member="+DbAdapter.cite(dvm),0,1);
      if(e1.hasMoreElements())
      {
        v[1]=((DynamicValue.Multi) e1.nextElement()).getValue();
      }
      Enumeration e2=dv2.findMulti(" AND member="+DbAdapter.cite(dvm),0,1);
      if(e2.hasMoreElements())
      {
        v[2]=((DynamicValue.Multi) e2.nextElement()).getValue();
      }
      out.print("<tr><td>&nbsp;");
      if(v[0]!=null)out.print(v[0].replaceAll("<", "&lt;").replaceAll("\r\n","<br/>"));
      out.print("<td>&nbsp;");
      if(v[1]!=null&&v[1].length()>0)out.print("<img src='"+v[1]+"' oncontextmenu='return false' height='30'>");
      out.print("<td>&nbsp;");
      if(v[2]!=null)out.print(v[2]);
    }
  }else
  {
    String v[]=new String[3];
    for(int j=0;j<v.length;j++)
    {
      DynamicValue dv = DynamicValue.find(-flowbusiness, teasession._nLanguage, arr[i][j]);
      if(dv.isExists())
      {
        v[j]=dv.getValue();
      }
    }
    out.print("<tr><td>&nbsp;");
    if(v[0]!=null)out.print(v[0].replaceAll("<", "&lt;").replaceAll("\r\n","<br/>"));
    out.print("<td>&nbsp;");
    if(v[1]!=null&&v[1].length()>0)out.print("<img src='"+v[1]+"' oncontextmenu='return false' height='30'>");
    out.print("<td>&nbsp;");
    if(v[2]!=null)out.print(v[2]);
  }
}
--%>
</tr>
</table>
</div>


<!--////////////////////////办理过程////////////////////////////////////////////////////////////////-->
<div id="tabprocess" style="display:none"><%=fb.getFlowviewToHtml(teasession._nLanguage)%></div>


<!--////////////////////////流程图////////////////////////////////////////////////////////////////-->
<div id="tabmap" style="display:none">
<span id="line" style="border:2px solid #FF0000; position:absolute; display:none;"></span>
<span id="flag" style="border:2px dotted #FF0000; position:absolute;"></span>
<img id="imgmap" src="/tea/flow/receive.jpg" usemap="#Map" />
<map name="Map" onMouseOver="f_linered(event.srcElement,line)" onMouseOut="f_lineout();" onClick="f_lineclick(event.srcElement);">
<area shape="rect" coords="155,28,257,53" href="#" id="1" pstep="0"/>
<area shape="rect" coords="154,101,257,144" href="#" id="2"/>
<area shape="rect" coords="154,186,257,212" href="#" id="1" pstep="2"/>
<area shape="rect" coords="289,260,391,285" href="#" id="5"/>
<area shape="rect" coords="156,259,257,286" href="#" id="4"/>
<area shape="rect" coords="23,259,126,287" href="#" id="3"/>
<area shape="rect" coords="154,327,256,355" href="#" id="1" pstep="345"/>
<area shape="rect" coords="154,397,257,425" href="#" id="6" />
<area shape="rect" coords="154,468,257,494" href="#" id="1" pstep="6"/>
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
  window.showModalDialog('/jsp/admin/flow/Flowview.jsp?community=' + form1.community.value + '&flow='+form1.flow.value + '&flowbusiness='+form1.flowbusiness.value+ '&setp='+obj.id,self,'dialogWidth:400px;dialogHeight:300px;resizable:1;help:0;status:0;');
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

  //    if(54==id)
  //    {
    //      System.out.println("abccc");
    //    }
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
//      if("csign".equals(ftype))
//      {
//         DynamicCsign dc = DynamicCsign.find(-flowbusiness, member);
//         out.println("form1.csignstarttime"+id+".value='"+dc.getStartTimeToString()+"';");
//         out.println("f_showarea(form1.csigncomment"+id+"["+dc.getComment()+"]);");
//         out.println("form1.csignendtime"+id+".value='"+dc.getEndTimeToString()+"';");
//         String content=dc.getContent();
//         if(content!=null)
//         {
//           content=content.replaceAll("\"","&quot;").replaceAll("\r\n","\\\\r\\\\n");
//           out.println("form1.csigncontent"+id+".value=\""+content+"\";");
//         }
//         String csign=dc.getSign();
//         if(csign!=null&&csign.length()>0)
//         {
//           out.println("document.getElementById('imgcsign"+id+"').src=form1.csignsign"+id+".value=\""+csign+"\"; form1.dynamictype_button"+id+".style.display='none';");
//         }
//      }
      if(dt.isNeed())
      {
        sbcheck.append("&&submitText(form1.dynamictype"+id+",'"+r.getString(teasession._nLanguage, "InvalidParameter")+"-"+dt.getName(teasession._nLanguage)+"')");
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
    if(id==54)
    {
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
</script>

</form>

<%@include file="/jsp/include/Calendar2.jsp" %>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</html>
