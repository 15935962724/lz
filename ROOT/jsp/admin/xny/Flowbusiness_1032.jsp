<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.entity.node.*" %>
<%@page import="java.util.*" %><%@page import="java.io.*" %>
<%@page import="tea.entity.site.*" %><%@page import="tea.entity.*" %>
<%@page import="tea.resource.Resource" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.member.*" %>
<%@page import="tea.ui.TeaSession" %><% request.setCharacterEncoding("UTF-8");
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}
Http h=new Http(request);
String ist = "";
if(teasession.getSession().getAttribute("isshowtag") != null){
   ist = (String)teasession.getSession().getAttribute("isshowtag");
}
String member=teasession._rv._strV;

String community=teasession._strCommunity;
String nexturl=teasession.getParameter("nexturl");
int flow=h.getInt("flow");
int flowbusiness=h.getInt("flowbusiness");
int head=h.getInt("head");

int step=1;
boolean isNew=false;
if(flowbusiness==0)
{
  flowbusiness=Flowbusiness.create(teasession._strCommunity,flow,member);
  isNew=true;
}else
{
  Flowbusiness obj=Flowbusiness.find(flowbusiness);
  step=obj.getStep();
}
if(step==0)
{
  out.print("<script>alert('该流程已结束！');history.back();</script>");
  return;
}
Flowbusiness fb=Flowbusiness.find(flowbusiness);
Flowprocess fp=Flowprocess.find(flow,step);
if(!fp.isExists())
{
  out.print("<script>alert('第“"+step+"”步流程不存在！');history.back();</script>");
  return;
}
int flowprocess=fp.getFlowprocess();
Flow f=Flow.find(flow);
Flowview fv=Flowview.find(flowbusiness,flowprocess,member);

//如果不是"自由流程" && 经办人中不存在当前会员 && 创建者 && 主控人员 && 主控委托
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

int unit=AdminUsrRole.find(teasession._strCommunity,member).getUnit();
AdminUnit au=AdminUnit.find(unit);
String auname=au.getName();

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
<script src="/jsp/admin/flow/flow.js"></script>
<script LANGUAGE=JAVASCRIPT src="/tea/applet/key/key.js" type="text/javascript"></script>
<style>
.dis{background:#E1E1E1}
.curbut{background:#E1E1E1}
</style>
<script type="">
function clearPrint(){//清除生成报表样式
      document.getElementById('print').className = "";
      document.getElementById('tabprint').style.display = "none";
      document.getElementById('base').className = "";
      document.getElementById('tabbase').style.display = "none";
      if(document.getElementById('opinion') != null){
        document.getElementById('opinion').className = "";
        document.getElementById('tabopinion').style.display = "none";
      }
      if(document.getElementById('process') != null){
        document.getElementById('process').className = "";
        document.getElementById('tabprocess').style.display = "none";
      }
      document.getElementById('map').className = "";
      document.getElementById('tabmap').style.display = "none";
}
var lastdiv,lastbut;
function f_swap(but)
{
  clearPrint();/////////////////////////////////////
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
    if(map)
    {
      if(map.length)
      {
        for(var i=0;i<map.length;i++)
        {
          var pstep=map[i].pstep;
          if(pstep&&pstep.indexOf("/<%=pstep%>/")!=-1)
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
  var rs=window.showModalDialog('/jsp/admin/flow/EditFlowCSign.jsp?community='+form1.community.value+'&flowbusiness='+form1.flowbusiness.value+'&dynamictype='+dynamictype+'&t='+new Date().getTime(),self,'dialogWidth:400px;dialogHeight:250px;resizable:1;help:0;status:0;');
  if(rs)f_ajax('ajax_csign');
}
function f_opinion(dtw)
{
  var rs=window.showModalDialog('/jsp/admin/flow/EditFlowOpinion2.jsp?community='+form1.community.value+'&flowbusiness='+form1.flowbusiness.value+'&dtw='+dtw+'&t='+new Date().getTime(),self,'dialogWidth:400px;dialogHeight:228px;resizable:1;help:0;status:0;scroll:0;');
  if(rs)f_ajax('ajax_opinion');
}
function f_dept(obj)
{
  var v=window.showModalDialog('/jsp/admin/flow/SelFlowDept.jsp?community='+form1.community.value+'&flowbusiness='+form1.flowbusiness.value+'&t='+new Date().getTime(),self,'dialogWidth:400px;dialogHeight:300px;resizable:1;help:0;status:0;scroll:0;');
  if(v)
  {
    obj.value=v;
  }
}
function f_review(dynamictype)
{
  //window.showModalDialog('/jsp/admin/flow/EditFlowReview.jsp?community='+form1.community.value+'&flowbusiness='+form1.flowbusiness.value+'&dynamictype='+dynamictype+'&t='+new Date().getTime(),self,'dialogWidth:400px;dialogHeight:320px;resizable:1;help:0;status:0;');
  var obj=eval("form1.dynamictype"+dynamictype);
  if(obj.value)
  {
    alert("您已经签过字,无须重复签字.");
  }else
  {
    <%
    if (isign == null || isign.length() == 0)
    {
      out.print("alert('您还没有上传你的签名.');");
    } else
    {
      out.print("if(confirm('确认签字?')){ var key=new Key(); if(key.check('"+sn+"'))obj.value='"+isign+"'; }");
    }
    %>
  }
}
function f_split(v)
{
  var arr=v.split(":");//有可能会是模板
  if(arr.length>1)v=arr[1];
  return encodeURIComponent(v.replace(/f/g,'?'));
}
function f_ajax(act,dt,str)
{
  if(act=="ajax_opinion")dt="/100,101,102/103,104,105/106,107,108/";
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
function f_send()
{
  if(<%=isNew%>)
  {
    var dt580=form1.dynamictype580;
    var v=dt580.value;//正文
    if(v.indexOf(":")!=-1||dt580.defaultValue.indexOf(v)!=-1)
    {
      alert("您还没有起草正文,不能转下一步!!!");
      return false;
    }
  }
  return true;
}
function f_load()
{
  //f_swap(form1.base);
//  var sel=form1.dynamictype580.value.indexOf(':')!=-1;
//  if(sel)
//  {
//    sel=window.showModalDialog('/jsp/admin/flow/SetFlowbusinessDocs.jsp?community=' + form1.community.value + '&field=dynamictype580&t='+new Date().getTime(),self,'dialogWidth:360px;dialogHeight:280px;help:0;status:0;scroll:0;');
//    form1.dynamictype580.value=sel;
//  }
}
function f_stop()
{
  if(!confirm("确认结束流程?"))return false;
  form1.action="/jsp/admin/xny/EditFlowbusinessNext.jsp?act=stop";
  form1.encoding="application/x-www-form-urlencoded";
}
//提醒修改doc文件
function f_reset()
{
  var t=form1.elements;
  for(var i=0;i<t.length;i++)
  {
    if(t[i].type!="text")continue;
    t[i].docValue=t[i].value;
  }
}
function f_msgdoc2()
{
  var t=form1.elements;
  for(var i=0;i<t.length;i++)
  {
    if(t[i].type!="text")continue;
    if(t[i].docValue!=t[i].value)
    {
      if(confirm("您已修改过了表单，是否保存到正文中？"))
      {
        $('office').click();
        return false;
      }
      break;
    }
  }
}
function f_msgdoc(){}
</script>
</head>
<body onUnload="sendx('/servlet/EditFlowdynamicvalue?act=exclusive&flowbusiness='+form1.flowbusiness.value,null);" class="BodyProcess">
<form name="form1" id="xxform" action="/servlet/FlowbusinessEdit" method="post" enctype="multipart/form-data" onSubmit="return fcheck()&&f_msgdoc();">
<input type="hidden" name="community" value="<%=community%>">
<input type="hidden" name="repository" value="flow">
<input type="hidden" name="node" value="<%=teasession._nNode%>">
<input type="hidden" name="flowbusiness" value="<%=flowbusiness%>">
<input type="hidden" name="nexturl" value="<%=nexturl%>">
<input type="hidden" name="flow" value="<%=flow%>">
<input type="hidden" name="adminunitorg" value="<%=AdminUnit.find(AdminUsrRole.find(teasession._strCommunity,member).getUnit()).adminunitorg%>">
<%
if(head>0)out.print("<input type='hidden' name='head' value='"+head+"' />");
%>

<h1><div class="ProcessTitle">工作接收/办理</div>
<div id="head6"><img height="6" src="about:blank"></div>

<div class="Funciton">

<input type="submit" name="save" value="保存" class="edit_button">
<%

//附件
dynamictype=582;
dt=DynamicType.find(dynamictype);
boolean bw=(type==1||dtw.indexOf("/"+dynamictype+"/")!=-1);
boolean br=(dtr.indexOf("/"+dynamictype+"/")!=-1||flowprocess == f.getMainProcess());
if(bw||br)
{
  out.println("<input type='button' name='dynamictype_button" + dynamictype+"' value='正文' onclick='f_attach("+dynamictype+","+bw+");' />");
  out.print("<div style='display:none' id='td"+dynamictype+"'></div>");
}

//意见  //领导签发  主管领导意见(或签发) 部门负责人意见
if(dtw.indexOf("/100/")!=-1)
  out.println("<input type='button' value='填写意见' onclick=f_opinion('/100/101/102/') />");
else if(dtw.indexOf("/103/")!=-1)
  out.println("<input type='button' value='填写意见' onclick=f_opinion('/103/104/105/') />");



//会签
if(dtw.indexOf("/109/")!=-1)
  out.println("<input type='button' value='填写意见' onclick='f_csign(109)' />");
else if(dtw.indexOf("/106/")!=-1)
  out.println("<input type='button' value='填写意见' onclick='f_csign(106)' />");
else if(dtw.indexOf("/618/")!=-1)
  out.println("<input type='button' value='填写意见' onclick='f_csign(618)' />");

//核稿人
if(dtw.indexOf("/33/")!=-1)
{
  out.println("<input type='hidden' name='dynamictype33' /><input type='button' value='签字' onclick='f_review(33)' />");
}
//发文字号
if(dtw.indexOf("/116/")!=-1)//||isCreator
{
  out.println("<input type='button' value='文件字号' onclick='xny.code(116)' />");
}
//归档
Flowprocess fp1=Flowprocess.find(flow,-1);
if(fp1.getStep()==step)
{
  out.println("<input type='button' value='归档' onclick=\"window.showModalDialog('/jsp/admin/flow/SetFlowbusinessFC.jsp?community='+form1.community.value+'&flowbusiness='+form1.flowbusiness.value+'&t='+new Date().getTime(),self,'dialogWidth:600px;dialogHeight:420px;resizable:1;help:0;status:0;');\" />");
}
//分发
if(f.getDistProcess()==flowprocess)
{
  out.println("<input type='submit' name='reading' value='阅毕' class='edit_button' >");
}

//催办:自由流程 && 主办人//////////////
boolean manage=f.getType()==2 &&(member.equals(fb.getMainTransactor()) || member.equals(fb.getMainConsign()));
//if(manage)
//{
//  out.println("<input type=button value='催办' onClick=\"window.open('/jsp/admin/flow/EditFlowReminder.jsp?community="+teasession._strCommunity+"&flowbusiness="+flowbusiness+"','','width=500,height=300,resizable=1'); \">");
//}
//回上一步//////////////
boolean creator=member.equals(fb.getCreator())||!fv.isExists();
boolean submit=!manage&&!creator;//是否有权办理/管理者默认没有办理权限////
//状态//
if(manage||creator)
{
  Enumeration e=Flowview.find(flowbusiness,flowprocess);
  while(e.hasMoreElements())
  {
    int flowview=((Integer)e.nextElement()).intValue();
    Flowview fv2=Flowview.find(flowview);
    if(!submit)
    {
      submit=member.equals(fv2.getTransactor())||member.equals(fv2.getConsign());
    }
  }
}
int last=Flowview.findLast(flowbusiness,flowprocess);
if(last>0)//当前不是第一步
{
  String url="/jsp/admin/xny/EditFlowbusinessBack.jsp?community="+teasession._strCommunity+"&flowbusiness="+flowbusiness+"&flow="+flow+"&nexturl="+Http.enc(nexturl);
  if(submit&&Flowview.count(flowbusiness,flowprocess)==1)//&&待办者不是多选
  {
    out.println("<input type=button class='butback' value=回上一步 onclick=window.open('"+url+"','_self');>");
  }else //上步待办者不是多选
  {
    Flowview tmp_fv=Flowview.find(last);
    if(Flowview.count(flowbusiness,tmp_fv.getFlowprocess())==1&&(member.equals(tmp_fv.getTransactor())||member.equals(tmp_fv.getConsign())))
    {
      out.println("<input type=button class='butcallback' name='callback' value=收回 onClick=window.open('"+url+"','_self');>");
    }
  }
}

if(f.getDistProcess()!=flowprocess)
out.println("<input type='submit' name='submits' value='发送' class='edit_button' onClick='return f_send()'>");
else
out.print("<style type='text/css'>#print,#opinion,#process,#map{display:none}</style>");//分发步：只显示“基本信息”

if(f.getMainProcess()==flowprocess)
out.println("<input type='submit' value='结束流程' onclick='return f_stop()'>");
%>
<input type="button" value="返回" onClick="history.back();"  class="edit_button">
</div>
</h1>
<!--对话框中的INPUT  防止js无法校验必填问题  -start-->
<div style="display:none">
<input type="text" name="dynamictype582" disabled="disabled" />
<input type="text" name="dynamictype100" disabled="disabled" />
<input type="text" name="dynamictype101" disabled="disabled" />
<input type="text" name="dynamictype102" disabled="disabled" />
<input type="text" name="dynamictype103" disabled="disabled" />
<input type="text" name="dynamictype104" disabled="disabled" />
<input type="text" name="dynamictype105" disabled="disabled" />
<input type="text" name="dynamictype109" disabled="disabled" />
<input type="text" name="dynamictype106" disabled="disabled" />
</div>
<!-- -end-->

<span class="flowname"><%=f.getName(teasession._nLanguage)%></span>
<div class="FunctionButton">
<input type="button" name="base"   value="基本信息" onClick="f_swap(this);" <%if(ist.equals("1"))out.print("class=''");else{out.print("class='curbut'");}%>/>
<input type="button" name="print" id="print"  value="来文处理签" <%if(ist.equals("1"))out.print("class='curbut'");%> onClick="getXx(this);"/>
<input type="hidden" name="param">

<script>
    function getXx(n){
      //form1.target="a";
      //form1.action="/editflowdynamicvalue2";but.className="curbut";
      //form1.submit();
      //var s = window.confirm("保存后查看发文稿纸么？\n\n\r单击取消直接查看\n\r单击确定保存后查看");
      //if(s)
      //{
        form1.param.value="ss";
        form1.submit();
      //}
      //else{
        //f_swap(n);
        //form1.target="";
      //}
      ////location="/jsp/admin/flow/FlowbusinessView.jsp?community=<%=teasession._strCommunity%>&flowitem=0&flowbusiness=<%=flowbusiness%>&dynamic=<%=f.getDynamic()%>&flow=<%=flow%>;
      //alert(document.getElementById("xxform").submit());
       //form1.target = "a";window.location.reload();
      //servlet/EditFlowdynamicvalue///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
      // document.getElementById("xxform").submit();
    }

</script>
<%
if(fb.isExists())//第一次不显示
{
  //if(dtw.indexOf("/20/")!=-1||dtw.indexOf("/23/")!=-1||dtw.indexOf("/28/")!=-1||dtw.indexOf("/146/")!=-1)
  {
    out.print("<input type='button' name='opinion' id='opinion'  value='办理意见' onclick='f_swap(this)' />");
  }
  out.print("<input type='button' name='process' id='process'  value='办理过程' onclick='f_swap(this)' />");
}
%>
<input type="button" name="map" id="map"  value="流程图" onClick="f_swap(this)"/>
</div>
<div class="Functiontable">
<table id="tabbase"  <%if(ist.equals("1"))out.print("style='display:none'");%>>
  <tr>
    <td class="tdtitle">文件标题</td>
    <td id="td99"><input type="text" name="dynamictype99" id="dynamictype99"/></td>
  </tr>

  <tr>
    <td class="tdtitle" style="border-right:0px;">来文单位</td>
    <td style="padding:0px;">
      <table id="tabbase_nei" border="0" cellspacing="0" cellpadding="0">
        <tr class="out2">
          <td class="tabtdteshu" id="td97" style="border:0px;"><input type="text" name="dynamictype97" /></td>
          <td class="tdtitle" style="border-bottom:0px;">收文单位</td>
          <td id="td98" style="border:0px;"><input type='text' name='dynamictype98' /></td>
        </tr>
      </table>
</td>
  </tr>
  <tr>
    <td class="tdtitle">备注</td>
    <td id="td113"><input type="text" name="dynamictype113" /></td>
  </tr>


<%
if(flowbusiness>0)
{
  StringBuilder read0=new StringBuilder("<tr><td class='tdtitle'>未 办 理</td><td>");
  StringBuilder read1=new StringBuilder("<tr><td class='tdtitle'>办 理 中</td><td>");
  StringBuilder read2=new StringBuilder("<tr><td class='tdtitle'>已 完 成</td><td>");
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
      AdminUnit i_au = AdminUnit.find(Integer.parseInt(cs[i]));
      out.print(i_au.getName()+", ");
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
}
%>
</table>


<!--////////////////////////发文稿纸////////////////////////////////////////////////////////////////-->
<%//String ist = (String)teasession.getSession().getAttribute("isshowtag");%>
<div id="tabprint" style="display:<%if(ist.equals("1"))out.print("");else{out.print("none");}%>" >
<iframe name="view" id="view" border="0" src="/jsp/admin/flow/FlowbusinessView.jsp?community=<%=teasession._strCommunity%>&flowitem=0&flowbusiness=<%=flowbusiness%>&dynamic=<%=f.getDynamic()%>&flow=<%=flow%>"></iframe>
</div>



<!--////////////////////////办理意见////////////////////////////////////////////////////////////////-->
<div id="tabopinion" style="display:none">
<div id="opinionMsg" ></div>
<table border=0 cellpadding=0 cellspacing=0 id=tablecenter>
<tr class=TableHeader>
  <td>意见</td>
  <td>签名</td>
  <td>日期</td>
</tr>
<tbody id="ajax_opinion"></tbody>
<script>f_ajax('ajax_opinion');</script>
<%--
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
--%>
</table>
<table border=0 cellpadding=0 cellspacing=0 id=tablecenter>
<tr class=TableHeader>
  <td>送阅时间</td>
  <td>人员</td>
  <td>传阅内容</td>
  <td>传阅签字</td>
  <td>传阅日期</td>
</tr>
<tbody id="ajax_csign"></tbody>

<script>f_ajax('ajax_csign');</script>
<%--
Enumeration dce = DynamicCsign.find(-flowbusiness);
while(dce.hasMoreElements())//146
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
--%>
</table>
<%//新增是否出现填写按钮
if(dtw.indexOf("/20/")!=-1||dtw.indexOf("/23/")!=-1||dtw.indexOf("/28/")!=-1)
{
  out.println("<input type='button' value='填写意见' onclick=f_opinion('"+dtw+"') />");
}
%>
</div>

<!--////////////////////////办理过程////////////////////////////////////////////////////////////////-->
<div id="tabprocess" style="display:none"><%=fb.getFlowviewToHtml(teasession._nLanguage)%></div>


<!--////////////////////////流程图////////////////////////////////////////////////////////////////-->
<div id="tabmap" style="display:none">
<span id="line" style="border:2px solid #FF0000; position:absolute; display:none;"></span>
<span id="flag" style="border:2px dotted #FF0000; position:absolute;"></span>
<img id="imgmap" src="/tea/flow/<%=flow%>.jpg" usemap="#Map" />
<map name="Map" onMouseOver="f_linered(event.srcElement,line)" onMouseOut="f_lineout();" onClick="f_lineclick(event.srcElement);">
<%

%>
<area shape="rect" coords="134,7,234,32" href="###" id="1"/>
<area shape="rect" coords="134,78,234,103" href="###" id="2"/>
<area shape="rect" coords="134,151,234,176" href="###" id="1" pstep="/2/"/>
<area shape="rect" coords="134,221,234,246" href="###" id="3"/>
<area shape="rect" coords="134,293,234,318" href="###" id="4"/>
<area shape="rect" coords="136,365,236,390" href="###" id="1" pstep="/3/4/"/>
<area shape="rect" coords="136,439,236,464" href="###" id="5"/>
<area shape="rect" coords="290,439,390,464" href="###" id="6"/>
<area shape="rect" coords="289,506,389,531" href="###" id="7"/>
<area shape="rect" coords="136,507,236,532" href="###" id="1" pstep="/6/7/"/>
<area shape="rect" coords="136,577,236,602" href="###" id="8"/>
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
        out.println("  obj.defaultValue=obj.value=\""+value+"\";");
        out.println("  if(obj.selectedIndex==-1)obj.selectedIndex=0;");
        out.println("  arr=form1.dynamictype_checkbox"+id+";if(arr)for(var i=0;i<arr.length;i++)if(obj.value.indexOf('　'+arr[i].value+'　')!=-1||obj.value.indexOf(arr[i].value+'　')==0)arr[i].checked=true;");
        if("sign".equals(ftype)&&value.startsWith("/res/"))//隐藏签名按钮
        {
          out.println("img=obj.nextSibling; if(img&&img.src){ img.src=\""+value+"\"; img.style.display=''; img.previousSibling.style.display='none'; }");
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
        sbcheck.append("&&(!form1.dynamictype"+id+"||submitText(form1.dynamictype"+id+",'“"+dt.getName(teasession._nLanguage)+"”必填！'))");
      }
    }else
    {
      if("sign".equals(ftype)&&value.startsWith("/res/"))
      {
        value="<img src='"+value+"' oncontextmenu='return false' />";
      }
      out.println("obj=document.all('td"+id+"');");
      out.println("if(obj)obj.innerHTML=\""+value+"\";");
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
f_load();
</script>

</form>
<iframe name="a" width="0%" height="0%">
</iframe>
<%@include file="/jsp/include/Calendar2.jsp" %>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</html>
