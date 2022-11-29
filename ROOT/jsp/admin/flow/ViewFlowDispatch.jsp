<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.entity.node.*" %>
<%@page import="java.util.*" %>
<%@page import="java.net.*" %>
<%@page import="tea.entity.site.*" %>
<%@page import="tea.resource.Resource" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.netdisk.*" %>
<%@page import="tea.entity.member.*" %>
<%@page import="tea.ui.TeaSession" %>
<% request.setCharacterEncoding("UTF-8");
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
int flowbusiness=Integer.parseInt(teasession.getParameter("flowbusiness"));

int flow=0;
int step=1;
int prev=0;
if(flowbusiness==0)
{
  prev=Integer.parseInt(teasession.getParameter("prev"));
  flow=Integer.parseInt(teasession.getParameter("flow"));
}else
{
  Flowbusiness obj=Flowbusiness.find(flowbusiness);
  step=obj.getStep();
  flow=obj.getFlow();
}
Flowbusiness fb=Flowbusiness.find(flowbusiness);
Flowprocess fp=Flowprocess.find(flow,step);
int flowprocess=fp.getFlowprocess();
Flow f=Flow.find(flow);

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
dtr=dtw="/";//去掉编辑权限

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
function f_attach(dynamictype,act)
{
  var rs=window.showModalDialog('/jsp/admin/flow/EditFlowAttach.jsp?community='+form1.community.value+'&field=dynamictype'+dynamictype+'&act='+act+'&t='+new Date().getTime(),self,'dialogWidth:400px;dialogHeight:320px;help:0;status:0;scroll:0;');
  if(rs!=undefined)
  {
    var td=document.getElementById("td"+dynamictype);
    td.innerHTML=f_file(rs,dynamictype);
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
  window.showModalDialog('/jsp/admin/flow/EditFlowCSign.jsp?community='+form1.community.value+'&flowbusiness='+form1.flowbusiness.value+'&dynamictype='+dynamictype+'&t='+new Date().getTime(),self,'dialogWidth:400px;dialogHeight:250px;resizable:1;help:0;status:0;');
}
function f_opinion(dtw)
{
  window.showModalDialog('/jsp/admin/flow/EditFlowOpinion.jsp?community='+form1.community.value+'&flowbusiness='+form1.flowbusiness.value+'&dtw='+dtw+'&t='+new Date().getTime(),self,'dialogWidth:400px;dialogHeight:320px;resizable:1;help:0;status:0;');
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
</script>
</head>
<body onLoad="f_swap(form1.base);" onUnload="sendx(form1.action+'?act=exclusive&flowbusiness='+form1.flowbusiness.value,null);" class="BodyProcess">
<form name="form1" action="/servlet/EditFlowdynamicvalue" method="post" enctype="multipart/form-data" onSubmit="javascript:return fcheck();">
<input type="hidden" name="community" value="<%=community%>">
<input type="hidden" name="repository" value="flow">
<input type="hidden" name="node" value="<%=teasession._nNode%>">
<input type="hidden" name="flowbusiness" value="<%=flowbusiness%>">
<input type="hidden" name="nexturl" value="<%=nexturl%>">
<input type="hidden" name="prev" value="<%=prev%>">
<input type="hidden" name="flow" value="<%=flow%>">
<h1><div class="ProcessTitle">工作接收/办理</div>
<div id="head6"><img height="6" src="about:blank"></div>


<div class="Funciton">

<%
//正文
dynamictype=35;
dt=DynamicType.find(dynamictype);
boolean bw=(type==1||dtw.indexOf("/"+dynamictype+"/")!=-1);
boolean br=true;//(dtr.indexOf("/"+dynamictype+"/")!=-1||flowprocess == f.getMainProcess());
if(bw||br)
{
  out.print("<input type='hidden' size='100' name='dynamictype" + dynamictype+"' />");
  String name="起草正文";
  if(fb.isExists())
  {
    name=bw?"编辑正文":"查看正文";
  }
  out.print("<input type='button' dtype='office' name='dynamictype_button" + dynamictype+"' value='"+name+"' onclick=\""); //open,showModalDialog
  if(bw)
  {
    out.print("var sel=previousSibling.value.indexOf(':')!=-1; window.showModalDialog('/jsp/admin/flow/EditDynamicOffice.jsp?community=" + teasession._strCommunity + "&field=dynamictype" + dynamictype+"&sync="+dt.isSync()+"&t='+new Date().getTime(),self,'dialogWidth:'+(sel?300:880)+'px;dialogHeight:'+(sel?280:600)+'px;resizable:1;help:0;status:0;scroll:0;');");
  } else
  {
    out.print("window.showModalDialog('/jsp/community/CommunityOfficeView.jsp?community=" + teasession._strCommunity + "&file='+f_split(previousSibling.value),self,'dialogWidth:880px;dialogHeight:600px;resizable:1;help:0;status:0;scroll:0;');");
  }
  out.println("\" />");
  out.println("<input type='button' value='下载正文' onclick=window.open('/jsp/include/DownFile.jsp?name="+URLEncoder.encode("down.doc","UTF-8")+"&uri='+f_split(form1.dynamictype" + dynamictype+".value),'_self'); />");
}
//附件
dynamictype=37;
dt=DynamicType.find(dynamictype);
bw=(type==1||dtw.indexOf("/"+dynamictype+"/")!=-1);
br=true;//(dtr.indexOf("/"+dynamictype+"/")!=-1||flowprocess == f.getMainProcess());
if(bw||br)
{
  out.println("<input type='button' name='dynamictype_button" + dynamictype+"' value='"+(bw?"管理附件":"查看附件")+"' onclick='f_attach("+dynamictype+","+bw+");' />");
}
//意见  //领导签发  主管领导意见(或签发) 部门负责人意见
if(dtw.indexOf("/20/")!=-1||dtw.indexOf("/23/")!=-1||dtw.indexOf("/28/")!=-1)
{
  out.println("<input type='button' value='填写意见' onclick=f_opinion('"+dtw+"') />");
}
//会签
if(dtw.indexOf("/40/")!=-1)
{
  out.println("<input type='button' value='填写意见' onclick='f_csign(40)' />");
}
%>
<input type="button" value="返回" onClick="history.back();"  class="edit_button">
</div>
</h1>
<div class="FunctionButton">
<input type="button" name="base"   value="基本信息" onClick="f_swap(this)"/>
<input type="button" name="print"  value="发文稿纸" onClick="f_swap(this)"/>
<%
if(fb.isExists())//第一次不显示
{
  //if(dtw.indexOf("/937/")!=-1||dtw.indexOf("/938/")!=-1||dtw.indexOf("/943/")!=-1||dtw.indexOf("/40/")!=-1)
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
    <td class="tdtitle">文件标题</td>
    <td id="td34"><input type="text" name="dynamictype34" /></td>
  </tr>
  <tr>
    <td class="tdtitle">主 题 词</td>
    <td  id="td36"><input type="text" name="dynamictype36" /></td>
  </tr>
  <tr>
    <td class="tdtitle">主　　送</td>
    <td  id="td38"><input type="text" name="dynamictype38" /></td>
  </tr>
  <tr>
    <td class="tdtitle">抄　　送</td>
    <td  id="td39"><input type="text" name="dynamictype39" /></td>
  </tr>
  <tr>
    <td class="tdtitle">附　　件</td>
    <td id="td37"></td>
  </tr>
  <tr>
    <td class="tdtitle">文件类型</td>
    <td id="td41">
    <%
    out.print("<select name='dynamictype41'>");
    dt=DynamicType.find(41);
    st = new StringTokenizer(dt.getContent(teasession._nLanguage), "/");
    while(st.hasMoreTokens())
    {
      String str = st.nextToken();
      out.print("<option value=\"" + str + "\"");
      out.print(">" + str);
    }
    out.print("</select>");
    %>
    </td>
  </tr>
  <tr>
    <td class="tdtitle" style="border-right:0px;">发文代号</td>
    <td style="padding:0px;border:0px;">
    <table id="tabbase_nei" border="0" cellspacing="0" cellpadding="0">
    <tr class="out">
    <td  class="tabtdteshu" id="td42">
    <%
    out.print("<select name='dynamictype42'>");
    dt=DynamicType.find(42);
    Enumeration efi=FlowIssuecode.find(" AND community="+DbAdapter.cite(teasession._strCommunity),0,100);
    while(efi.hasMoreElements())
    {
      FlowIssuecode fi =(FlowIssuecode)efi.nextElement();
      out.print("<option value=\"" + fi.name + "\"");
      out.print(">" + fi.name);
    }
    out.print("</select>");
    %>
    </td>
    <td class="tdtitle">文件字号</td>
    <td id="td19" onpropertychange="var dt19=form1.dynamictype19; if(dt19.value!=innerHTML)dt19.value=innerHTML;"></td>
    </tr>
    </table>
    </td>
    <input type='hidden' name='dynamictype19' onpropertychange="var td19=document.getElementById('td19'); if(td19.innerHTML!=value) td19.innerHTML=value;" />
  </tr>
  <tr>
    <td class="tdtitle" style="border-right:0px;">机密程度</td>
    <td style="padding:0px;border:0px;">
    <table id="tabbase_nei" border="0" cellspacing="0" cellpadding="0">
    <tr>
    <td  class="tabtdteshu" id="td17">
    <%
    dynamictype=17;
    out.print("<input type='hidden' name='dynamictype" + dynamictype + "' />");
    dt=DynamicType.find(dynamictype);
    st = new StringTokenizer(dt.getContent(teasession._nLanguage), "/");
    for (int index = 0; st.hasMoreTokens(); index++)
    {
      String str = st.nextToken();
      String id = String.valueOf(dynamictype) + "_" + index;
      out.print("<input type='checkbox' name='dynamictype_checkbox" + dynamictype + "' value=\"" + str + "\" id='" + id + "' onclick=\"if(this.checked){dynamictype" + dynamictype + ".value+=this.value+'&#12288;';}else{dynamictype" + dynamictype + ".value=dynamictype" + dynamictype + ".value.replace(this.value+'&#12288;','');}\" /><label for=" + id + ">" + str + "</label> ");
    }
    %>
    </td>
    <td class="tdtitle">缓急程度</td>
    <td id="td18">
    <%
    dynamictype=18;
    out.print("<input type='hidden' name='dynamictype" + dynamictype + "' />");
    dt=DynamicType.find(dynamictype);
    st = new StringTokenizer(dt.getContent(teasession._nLanguage), "/");
    for (int index = 0; st.hasMoreTokens(); index++)
    {
      String str = st.nextToken();
      String id = String.valueOf(dynamictype) + "_" + index;
      out.print("<input type='checkbox' name='dynamictype_checkbox" + dynamictype + "' value=\"" + str + "\" id='" + id + "' onclick=\"if(this.checked){dynamictype" + dynamictype + ".value+=this.value+'&#12288;';}else{dynamictype" + dynamictype + ".value=dynamictype" + dynamictype + ".value.replace(this.value+'&#12288;','');}\" /><label for=" + id + ">" + str + "</label> ");
    }

//    out.print("<select name='dynamictype18'>");
//    dt=DynamicType.find(18);
//    st = new StringTokenizer(dt.getContent(teasession._nLanguage), "/");
//    while(st.hasMoreTokens())
//    {
//      String str = st.nextToken();
//      out.print("<option value=\"" + str + "\"");
//      out.print(">" + str);
//    }
//    out.print("</select>");
    %>

    </td>
    </tr>
    </table>
    </td>
  </tr>
  <tr>
    <td class="tdtitle" style="border-right:0px;">拟 稿 人</td>
    <td style="padding:0px;border:0px;">
    <table id="tabbase_nei" border="0" cellspacing="0" cellpadding="0">
    <tr>
    <td  class="tabtdteshu" id="td31"><input type="text" name="dynamictype31"  /></td>
    <td class="tdtitle">电　　话</td>
    <td id="td32"><input type="text" name="dynamictype32"  /></td>
    </tr>
    </table>
    </td>
  </tr>
  <tr>
    <td class="tdtitle" style="border-right:0px;">拟稿日期</td>
    <td style="padding:0px;border:0px;">
    <table id="tabbase_nei" border="0" cellspacing="0" cellpadding="0">
    <tr>
    <td  class="tabtdteshu" id="td43"><input type="text" name="dynamictype43" onclick='showCalendar(this)' readonly='true'  /></td>
    <td class="tdtitle">成文日期</td>
    <td id="td44"><input type="text" name="dynamictype44" onclick='showCalendar(this)' readonly='true'  /></td>
    </tr>
    </table>
    </td>
  </tr>
  <tr>
    <td class="tdtitle" style="border-right:0px;">主办部门</td>
    <td style="padding:0px;border:0px;">
    <table id="tabbase_nei" border="0" cellspacing="0" cellpadding="0">
    <tr class="out2">
    <td  class="tabtdteshu" id="td26"><input type="text" name="dynamictype26" /></td>
    <td class="tdtitle">份　　数</td>
    <td id="td27"><input type="text" name="dynamictype27" /></td>
    </tr>
    </table>
    </td>
  </tr>
<%
if(step>0)//事件未结束
{
  StringBuilder read0=new StringBuilder("<tr><td class='tdtitle'>未办理</td><td colspan='3'>");
  StringBuilder read1=new StringBuilder("<tr><td class='tdtitle'>已办理</td><td colspan='3'>");
  StringBuilder read2=new StringBuilder("<tr><td class='tdtitle'>已完成</td><td colspan='3'>");
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
  //管理层设置候选人
  String csunit = fb.getCSUnit();
  String csmember = fb.getCSMember();
  if (fb.isExists() && (csunit.length() > 2 || csmember.length() > 2))//有人会签就会清空 csunit 和 csmember 字段
  {
    out.print("<tr><td class='tdtitle'>会签人员</td><td colspan='3'><font color='red'>");
    String cs[] = csunit.split("/");
    for (int i = 1; i < cs.length; i++)
    {
      AdminUnit au = AdminUnit.find(Integer.parseInt(cs[i]));
      out.print(au.getName()+", ");
    }
    cs = csmember.split("/");
    for (int i = 1; i < cs.length; i++)
    {
      out.print(cs[i]+", ");
    }
    out.print("</font>");
  }
  out.print(read0.toString());
  out.print(read1.toString());
  out.print(read2.toString());
}else
{
  int filecenter=fb.getFileCenter();
  Enumeration efcs=FileCenterSafety.findByFileCenter(filecenter," AND fcs.filecenter="+filecenter);
  if(efcs.hasMoreElements())
  {
    FileCenterSafety fcs=FileCenterSafety.find(((Integer)efcs.nextElement()).intValue());
    out.print("<tr><td class='tdtitle'>分发范围</td><td colspan='3'>"+fcs.getMemberToHtml(", ")+fcs.getUnitToHtml(", ")+fcs.getRoleToHtml(", "));
    StringBuilder read1=new StringBuilder("<tr><td class='tdtitle'>未阅人员</td><td colspan='3'>");
    StringBuilder read2=new StringBuilder("<tr><td class='tdtitle'>已阅人员</td><td colspan='3'>");
    ArrayList alm=new ArrayList(Arrays.asList(fcs.getMember().split("/")));//人员
    ArrayList alu=new ArrayList(Arrays.asList(fcs.getUnit().split("/")));//部门
    ArrayList alr=new ArrayList(Arrays.asList(fcs.getRole().split("/")));//角色
    efcs=Ifnotread.findByNewid(filecenter);
    while(efcs.hasMoreElements())
    {
      Ifnotread obj=(Ifnotread)efcs.nextElement();
      String rm=obj.getMember();
      if(alm.contains(rm))
      {
        alm.remove(rm);
        read2.append(rm).append("(").append(obj.getNdateToString()).append("), ");
      }
      AdminUsrRole raur=AdminUsrRole.find(teasession._strCommunity,teasession._rv._strV);
      int rn=raur.getUnit();
      String tmp=String.valueOf(rn);
      if(alu.contains(tmp))
      {
        alu.remove(tmp);
        read2.append(AdminUnit.find(rn).getName()).append("(").append(obj.getNdateToString()).append("), ");
      }
      String rarr[]=raur.getRole().split("/");
      for(int i=1;i<rarr.length;i++)
      {
        int rr=Integer.parseInt(rarr[i]);
        tmp=String.valueOf(rr);
        if(alr.contains(tmp))
        {
          alr.remove(tmp);
          read2.append(AdminRole.find(rr).getName()).append("(").append(obj.getNdateToString()).append("), ");
        }
      }
    }
    //未阅人员
    for(int i=1;i<alm.size();i++)
    {
      read1.append(alm.get(i)).append(", ");
    }
    for(int i=1;i<alu.size();i++)
    {
      read1.append(AdminUnit.find(Integer.parseInt((String)alu.get(i))).getName()).append(", ");
    }
    for(int i=1;i<alr.size();i++)
    {
      read1.append(AdminRole.find(Integer.parseInt((String)alr.get(i))).getName()).append(", ");
    }
    out.print(read1.toString());
    out.print(read2.toString());
  }
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
<%
int arr[][]={{28,29,30},{23,24,25},{20,21,22}};
for(int i=0;i<arr.length;i++)
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
  if(v[0]!=null||v[1]!=null||v[1]!=null)
  {
    out.print("<tr><td>&nbsp;");
    if(v[0]!=null)out.print(v[0].replaceAll("<", "&lt;").replaceAll("\r\n","<br/>"));
    out.print("<td>&nbsp;");
    if(v[1]!=null&&v[1].length()>0)out.print("<img src='"+v[1]+"' oncontextmenu='return false' height='30'>");
    out.print("<td>&nbsp;");
    if(v[2]!=null)out.print(v[2]);
  }
}
%>
</tr>
</table>
<table border=0 cellpadding=0 cellspacing=0 id=tablecenter>
<tr class=TableHeader>
  <td>送签时间</td>
  <td>会签部门/人员</td>
  <td>会签意见</td>
  <td>签名</td>
  <td>签出日期</td>
</tr>
<%
Enumeration dce = DynamicCsign.find(-flowbusiness);
while(dce.hasMoreElements())//40
{
  String dcm = (String) dce.nextElement();
  DynamicCsign dc = DynamicCsign.find(-flowbusiness, dcm);
  String v0=dc.getContent();
  String v1=dc.getSign();
  int dcc=dc.getComment();
  out.print("<tr><td>"+dc.getStartTimeToString());
  out.print("<td>"+dcm);
  out.print("<td>"+(dcc==2?v0.replaceAll("<", "&lt;").replaceAll("\r\n","<br/>"):DynamicCsign.COMMENT_TYPE[dcc]));
  out.print("<td>");
  if(v1!=null&&v1.length()>0)out.print("<img src='"+v1+"' oncontextmenu='return false' height='30'>");
  out.print("<td>"+dc.getEndTimeToString());
}
%>
</table>
</div>

<!--////////////////////////办理过程////////////////////////////////////////////////////////////////-->
<div id="tabprocess" style="display:none"><%=fb.getFlowviewToHtml(teasession._nLanguage)%></div>


<!--////////////////////////流程图////////////////////////////////////////////////////////////////-->
<div id="tabmap" style="display:none">
<span id="line" style="border:2px solid #FF0000; position:absolute; display:none;"></span>
<span id="flag" style="border:2px dotted #FF0000; position:absolute; display:none;"></span>
<img id="imgmap" src="/tea/flow/dispatch.jpg" usemap="#Map" />
<map name="Map" onMouseOver="f_linered(event.srcElement,line)" onMouseOut="f_lineout();" onClick="f_lineclick(event.srcElement);">
<area shape="rect" coords="153,39,256,63" href="###"  id="1"/>
<area shape="rect" coords="152,109,255,136" href="###" id="2"/>
<area shape="rect" coords="153,183,255,210" href="###" id="3" pstep="2"/>
<area shape="rect" coords="153,256,255,283" href="###" id="4"/>
<area shape="rect" coords="154,330,256,356" href="###" id="3" pstep="4"/>
<area shape="rect" coords="22,403,124,430" href="###" id="5"/>
<area shape="rect" coords="153,403,255,428" href="###" id="6"/>
<area shape="rect" coords="288,404,390,431" href="###" id="7"/>
<area shape="rect" coords="152,470,255,496" href="###" id="3" pstep="567"/>
<area shape="rect" coords="153,542,256,566" href="###" id="8"/>
<area shape="rect" coords="152,610,256,638" href="###" id="9"/>
<area shape="rect" coords="153,678,256,706" href="###" id="10" />
<area shape="rect" coords="154,749,255,774" href="###" id="3" />
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
StringBuffer h=new StringBuffer();
Enumeration e2=DynamicType.findByDynamic(f.getDynamic());
while(e2.hasMoreElements())
{
  int id=((Integer)e2.nextElement()).intValue();
  dt=DynamicType.find(id);
  if(dt.isHidden())
  {
    String ftype=dt.getType();
    DynamicValue av = DynamicValue.find(-flowbusiness, teasession._nLanguage, id);
    String value=av.getValue();
    if(value==null)value="";
    value=value.replaceAll("\"","&quot;").replaceAll("\r\n","\\\\r\\\\n");
    int state=1;
    if(type==1||dtw.indexOf("/"+id+"/")!=-1||"office".equals(ftype))
    {
      if(!av.isExists()&&!"checkbox".equals(ftype))value=dt.getDefaultvalueToString(teasession);
      if(value.length()>0)
      {
        out.println("obj=form1.dynamictype"+id+";");
        out.println("if(obj)");
        out.println("{");
        out.println("  obj.value=\""+value+"\";");
        out.println("  arr=form1.dynamictype_checkbox"+id+";if(arr)for(var i=0;i<arr.length;i++)if(obj.value.indexOf('　'+arr[i].value+'　')!=-1||obj.value.indexOf(arr[i].value+'　')==0)arr[i].checked=true;");
        if("sign".equals(ftype))//隐藏签名按钮
        {
          out.println("img=obj.nextSibling; if(img.src){ img.src=\""+value+"\"; img.nextSibling.style.display='none'; }");
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

<%--
if(dtws.length!=2||"/office/csign/".indexOf("/"+DynamicType.find(Integer.parseInt(dtws[1])).getType()+"/")==-1)
{
  out.print("<input type=submit name=submit value=提交 class=edit_button>");
  out.print("<input type=reset value=重置 class=edit_button>");
  out.print("<input type=button value=返回 onClick=history.back();  class=edit_button>");
}
--%>
<%=h.toString()%>
</form>

<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</html>
