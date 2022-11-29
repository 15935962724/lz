<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.db.DbAdapter" %><%@page import="tea.entity.node.*" %><%@page import="java.util.*" %><%@page import="java.io.*" %><%@page import="tea.entity.site.*" %><%@page import="tea.entity.*" %><%@page import="tea.resource.Resource" %><%@page import="tea.entity.admin.*" %><%@page import="tea.entity.member.*" %><%@page import="tea.ui.TeaSession" %><% request.setCharacterEncoding("UTF-8");
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}
String ist = "";
if(teasession.getSession().getAttribute("isshowtag") != null){
   ist = (String)teasession.getSession().getAttribute("isshowtag");
}
String member=teasession._rv._strV;

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
boolean isManage=f.getType()==2 &&(member.equals(fb.getMainTransactor()) || member.equals(fb.getMainConsign()));
boolean isSubmit=isNew||fv.isExists();
if(!isSubmit)dtw="/";

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
<script LANGUAGE=JAVASCRIPT src="/tea/applet/key/key.js" type="text/javascript"></script>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
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
function f_attach2(obj)
{
  var v=obj.value;
  var j=v.lastIndexOf('\\');
  if(j!=-1)v=v.substring(j+1);
  $('td'+obj.name.substring(11)).innerHTML=v;
}
function f_csign(dynamictype)
{
  var rs=window.showModalDialog('/jsp/admin/flow/EditFlowCSign.jsp?community='+form1.community.value+'&flowbusiness='+form1.flowbusiness.value+'&dynamictype='+dynamictype+'&t='+new Date().getTime(),self,'dialogWidth:400px;dialogHeight:175px;resizable:1;help:0;status:0;');
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
  if(act=="ajax_opinion")dt="/86,87,88/123,95,126/124,96,128/";
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
function f_code()
{
  form1.dynamictype90.value="中电控股"+$('fi_c').value+"["+$('fi_y').value+"]"+$('fi_s').value+"号";
}
function f_load()
{
  //如果备选文件大于1个，则弹出对话框。
  if(!form1.dynamictype107)return;
  var v=form1.dynamictype107.value;
  if(v.charAt(0)==':')
  {
    if(v.charAt(v.length-1)==':')v=v.substring(0,v.length-1);
    sel=v.split(':').length==2?v.substring(1):window.showModalDialog('/jsp/admin/flow/SetFlowbusinessDocs.jsp?community=' + form1.community.value + '&field=dynamictype107&t='+new Date().getTime(),self,'dialogWidth:360px;dialogHeight:280px;help:0;status:0;scroll:0;');
    form1.dynamictype107.value=sel;
  }
}
function f_isign(id,img)
{
  if(!confirm('确认签字?'))return;
  $('td'+id).innerHTML=(img.indexOf("/res/")==0?"<img src='" + img + "' oncontextmenu='return false' />":img)+"<input name='dynamictype"+id+"' type='hidden' value='"+img+"' />";
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
<body onUnload="sendx('/servlet/EditFlowdynamicvalue?act=exclusive&flowbusiness='+form1.flowbusiness.value,null);" class="BodyProcess">
<form name="form1" id="xxform" action="/servlet/CecFlowbusinessEdit" method="post" enctype="multipart/form-data" onSubmit="return fcheck();">
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

//正文
dynamictype=107;
dt=DynamicType.find(dynamictype);
boolean bw=(type==1||dtw.indexOf("/"+dynamictype+"/")!=-1);
boolean br=(dtr.indexOf("/"+dynamictype+"/")!=-1||flowprocess == f.getMainProcess());
if(bw||br)
{
  boolean authority=flowprocess==f.stampprocess;
  out.print("<input type='hidden' name='dynamictype" + dynamictype+"' />");
  out.print("<input type='button' dtype='office' name='dynamictype_button" + dynamictype+"' value='"+(pstep==0&&step==1?"起草正文":"查看文件")+"' onclick=\""); //open,showModalDialog
  if(bw)
  {
    out.print("window.open('/jsp/admin/flow/EditDynamicOffice.jsp?community=" + teasession._strCommunity + "&field=dynamictype" + dynamictype+"&flowbusiness="+flowbusiness+"&sync="+dt.isSync()+"&seal='+(event.srcElement!=this)+'&authority="+authority+"&file='+f_split(previousSibling.value));");
  } else if(br)
  {
    out.print("window.open('/jsp/admin/flow/ViewDynamicOffice.jsp?community=" + teasession._strCommunity + "&flowview="+fv.getFlowview()+"&file='+f_split(form1.dynamictype" + dynamictype+".value));");
  }
  out.println("\" />");

  if(authority)
  {
    out.println("<input type='button' value='盖章' onclick='form1.dynamictype_button107.onclick()' >");
    //保留未盖章的文件
    File nos=new File(application.getRealPath(MT.f(fb.tape2)));
    if(!nos.isFile()||nos.length()<1)
    {
      File fs=new File(application.getRealPath(DynamicValue.find(-flowbusiness, teasession._nLanguage, dynamictype).getValue()));
      if(fs.length()>0)
      {
        fb.tape2="/res/"+teasession._strCommunity+"/flow/nos_"+flowbusiness+".doc";
        fb.setTape2(fb.tape2);
        Filex.write(application.getRealPath(fb.tape2),Filex.read(fs.getPath()));
      }
    }
  }
//  if(step==9)
//  {
//    out.println("<input type='button' value='下载正文' onclick=\"window.showModalDialog('/jsp/admin/flow/DownDynamicOffice.jsp?flowbusiness="+flowbusiness+"&file='+f_split(form1.dynamictype" + dynamictype+".value),self,'dialogWidth:400px;dialogHeight:100px;resizable:1;help:0;status:0;scroll:0;');\" >");
//  }
}

if(dtw.indexOf("/down/")!=-1)
out.println("<input type='button' value='下载' onclick=location.href='/servlet/EditFlowdynamicvalue?act=down&community='+form1.community.value+'&flowbusiness='+form1.flowbusiness.value+'&dynamictype=/107/101/' >");
if(dtw.indexOf("/print/")!=-1)
out.println("<input type='button' value='打印' onclick=\"window.open('/jsp/admin/flow/ViewDynamicOffice.jsp?community=" + teasession._strCommunity + "&flowview="+fv.getFlowview()+"&file='+f_split(form1.dynamictype" + dynamictype+".value)+'&act=print&auto=1')\" >");


//附件
dynamictype=101;
dt=DynamicType.find(dynamictype);
bw=(type==1||dtw.indexOf("/"+dynamictype+"/")!=-1);
br=(dtr.indexOf("/"+dynamictype+"/")!=-1||flowprocess == f.getMainProcess());
if(bw||br)
{
  out.println("<input type='button' name='dynamictype_button" + dynamictype+"' value='随文附件' onclick='f_attach("+dynamictype+","+bw+");' />");
}
//if(dtw.indexOf("/101/")!=-1)out.println("<input type='button' value='随文附件' /><input type='file' name='dynamictype101' size='1' style='width:10px;filter:alpha(opacity=0);opacity:0;margin-left:-70px;' onchange='f_attach2(this)' />");

dynamictype=103;
dt=DynamicType.find(dynamictype);
bw=(type==1||dtw.indexOf("/"+dynamictype+"/")!=-1);
br=(dtr.indexOf("/"+dynamictype+"/")!=-1||flowprocess == f.getMainProcess());
if(bw||br)
{
  out.println("<input type='button' name='dynamictype_button" + dynamictype+"' value='参阅资料' onclick='f_attach("+dynamictype+","+bw+");' />");
}

if(dtw.indexOf("/161/")!=-1)
  out.println("<input type='button' value='盖章' onclick=\"f_isign(161,'"+MT.f(ProfileBBS.find(teasession._strCommunity ,member).getISign(teasession._nLanguage),member)+"')\" />");
if(dtw.indexOf("/105/")!=-1)
  out.println("<input type='button' value='校对签字' onclick=\"f_isign(105,'"+MT.f(ProfileBBS.find(teasession._strCommunity ,member).getISign(teasession._nLanguage),member)+"')\" />");
//终审签字按钮应该在"公司领导批示"完返回到文件管理员 才会显示
if(dtw.indexOf("/106/")!=-1)//&&Flowview.find(flowbusiness," AND flowprocess=7").hasMoreElements()
  out.println("<input type='button' value='终审签字' onclick=\"f_isign(106,'"+MT.f(ProfileBBS.find(teasession._strCommunity ,member).getISign(teasession._nLanguage),member)+"')\" />");


if(dtw.indexOf("/86/")!=-1)
  out.println("<input type='button' value='总经理签发' onclick=f_opinion('/86/87/88/') />");
else if(dtw.indexOf("/123/")!=-1)
  out.println("<input type='button' value='审核意见' onclick=f_opinion('/123/95/126/') />");
else if(dtw.indexOf("/124/")!=-1)
  out.println("<input type='button' value='复核意见' onclick=f_opinion('/124/96/128/') />");

//会签
if(dtw.indexOf("/97/")!=-1)
{
  out.println("<input type='button' value='填写意见' onclick='f_csign(97)' />");
  sbcheck.append("&&submitSign(form1.dynamictype97_2)");
}
//核稿人
if(dtw.indexOf("/33/")!=-1)
{
  out.println("<input type='hidden' name='dynamictype33' /><input type='button' value='签字' onclick='f_review(33)' />");
}
//发文字号
//if(dtw.indexOf("/90/")!=-1)
//{
//  out.println("<input type='button' value='文件字号' onclick=\"window.showModalDialog('/jsp/admin/flow/SetFlowbusinessSN.jsp?community='+form1.community.value+'&flowbusiness='+form1.flowbusiness.value+'&code='+encodeURIComponent($('td90').innerHTML)+'&issuecode='+encodeURIComponent(form1.dynamictype121?form1.dynamictype121.value:$('td121').innerHTML)+'&dynamictype=90&t='+new Date().getTime(),self,'dialogWidth:350px;dialogHeight:105px;resizable:1;help:0;status:0;');\" />");
//}
//归档
Flowprocess fp1=Flowprocess.find(flow,-1);
if(fp1.getStep()==step)
{
  out.println("<input type='button' value='归档' onclick=\"window.showModalDialog('/jsp/admin/flow/SetFlowbusinessFC.jsp?community='+form1.community.value+'&flowbusiness='+form1.flowbusiness.value+'&t='+new Date().getTime(),self,'dialogWidth:600px;dialogHeight:420px;resizable:1;help:0;status:0;');\" />");
}
//分发
if(f.getDistProcess()==flowprocess)
{
//  int corg=AdminUnitOrg.find(teasession._strCommunity,fb.getCreator());//创建者公司
//  int morg=AdminUnitOrg.find(teasession._strCommunity,member);//办理者公司
//  out.print("<script>function f_start(){");
//  //总公司发文 接收人为分子公司人员
//  if(corg>0&&AdminUnitOrg.find(teasession._strCommunity,0)==corg && morg>0&&AdminUnitOrg.find(teasession._strCommunity,1)==morg)
//  {
//    if(!Flowbusiness.findByCommunity(teasession._strCommunity," AND prev="+flowbusiness).hasMoreElements())
//    //out.print("form1.start.value=confirm('是否启动"+MT.f(AdminUnitOrg.find(morg).name)+"收文流程?');");
//    out.print("form1.start.value=true;");
//    //else
//    //out.print("alert('已经启动"+MT.f(AdminUnitOrg.find(morg).name)+"收文流程了');");
//  }
//  out.print("}</script>");
//  out.print("<input type='hidden' name='start' value='false'>");

  out.println("<input type='submit' name='reading' value='阅毕' class='edit_button' onclick='return f_read()' >");
}

if(isManage&&!isSubmit)
{
  out.println("<input type=button value='催办' onClick=\"window.showModalDialog('/jsp/admin/flow/EditFlowReminder.jsp?community="+teasession._strCommunity+"&flowbusiness="+flowbusiness+"',self,'dialogWidth=500px;dialogHeight=300px;help:0;status:0;resizable=1'); \">");
}
int last=Flowview.findLast(flowbusiness,flowprocess);
if(last>0)//当前不是第一步
{
  String url="/jsp/admin/flow/EditFlowbusinessBack.jsp?community="+teasession._strCommunity+"&flowbusiness="+flowbusiness+"&flow="+flow+"&nexturl="+Http.enc(nexturl);
  if(isSubmit&&Flowview.count(flowbusiness,flowprocess)==1)//&&待办者不是多选
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

if(f.getDistProcess()!=flowprocess && fp1.getStep()!=step && isSubmit)
{
  out.print("<input type='submit' name='submits' value='发送' class='edit_button' onClick='return f_send()'>");
}
%>
<input type="button" value="返回" onClick="history.back();"  class="edit_button">
</div>
</h1>
<script>
function f_send()
{
  if(<%=isNew%>)
  {
    var dt107=form1.dynamictype107;
    var v=dt107.value;//正文
    if(v.indexOf(":")!=-1||dt107.defaultValue.indexOf(v)!=-1)
    {
      alert("您还没有起草正文,不能转下一步!!!");
      return false;
    }
  }
  <%
  if(fp1.getStep()==step)
  {
    out.print("return confirm('您还没有归档，确认要发送吗？');");
  }
  %>
  return true;
}
function f_read()
{
  <%
  if(fv.getSumPrint()>0&&fv.getUsePrint()==0)
  out.print("return confirm('您还未进行打印，确认阅毕吗？');");
  %>
}
</script>

<!--对话框中的INPUT  防止js无法校验必填问题  -start-->
<table style="display:none">
<tr><td>
    <input type="text" name="dynamictype86" disabled="disabled" />
    <input type="text" name="dynamictype87" disabled="disabled" />
    <input type="text" name="dynamictype88" disabled="disabled" />

    <input type="text" name="dynamictype123" disabled="disabled" />
    <input type="text" name="dynamictype95" disabled="disabled" />
    <input type="text" name="dynamictype126" disabled="disabled" />

    <input type="text" name="dynamictype124" disabled="disabled" />
    <input type="text" name="dynamictype96" disabled="disabled" />
    <input type="text" name="dynamictype128" disabled="disabled" />
</table>
<!-- -end-->

<span class="flowname"><%=f.getName(teasession._nLanguage)%></span>
<div class="FunctionButton">
<input type="button" name="base"   value="基本信息" onClick="f_swap(this);" <%if(ist.equals("1"))out.print("class=''");else{out.print("class='curbut'");}%>/>
<input type="button" name="print" id="print"  value="发文稿纸" <%if(ist.equals("1"))out.print("class='curbut'");%> onClick="getXx(this);"/>
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
  //if(dtw.indexOf("/20/")!=-1||dtw.indexOf("/23/")!=-1||dtw.indexOf("/28/")!=-1||dtw.indexOf("/40/")!=-1)
  {
    out.print("<input type='button' name='opinion'  value='办理意见' onclick='f_swap(this)' />");
  }
  out.print("<input type='button' name='process'  value='办理过程' onclick='f_swap(this)' />");
}
%>
<input type="button" name="map"  value="流程图" onClick="f_swap(this)"/>
</div>
<div class="Functiontable">
<table id="tabbase"  <%if(ist.equals("1"))out.print("style='display:none'");%>>
  <tr>
    <td class="tdtitle">文件标题</td>
    <td id="td89"><input type="text" name="dynamictype89" id="dynamictype89"/></td>
  </tr>
  <tr>
    <td class="tdtitle">主 题 词</td>
    <td  id="td104"><table class="addbutton"><tr><td class="td1"><input type="text" name="dynamictype104" id="dynamictype104" /></td><td class="td2"><input type="button" value="提取" onClick="f_ajax('ajax_key','104',form1.dynamictype89.value);"/></td></tr></table></td>
  </tr>
  <tr>
    <td class="tdtitle">主　　送</td>
    <td  id="td98"><table class="addbutton"><tr><td class="td1"><input type="text" name="dynamictype98" id="dynamictype98"/></td><td class="td2"><input type="button" value="选择" onClick="f_dept(form1.dynamictype98);"/></td></tr></table></td>
  </tr>
  <tr>
    <td class="tdtitle">抄　　送</td>
    <td  id="td99"><table class="addbutton"><tr><td class="td1"><input type="text" name="dynamictype99" id="dynamictype99"/></td><td class="td2"><input type="button" value="选择" onClick="f_dept(form1.dynamictype99);"/></td></tr></table></td>
  </tr>
  <tr>
    <td class="tdtitle">参阅资料</td>
    <td id="td103"></td>
  </tr>
  <tr>
    <td class="tdtitle">文件字号</td>
    <td style="padding:0px;border:0px;border-right:1px solid #ABAEB3;">
    <table id="tabbase_nei" border="0" cellspacing="0" cellpadding="0">
    <tr>
    <td class="tabtdteshu" id="td90"><%
    if(dtw.indexOf("/90/")!=-1)
    {
      String v90=DynamicValue.find(-flowbusiness,teasession._nLanguage,90).getValue();
      if(MT.f(v90).length()<1)v90="中电控股综字["+Calendar.getInstance().get(Calendar.YEAR)+"]"+SeqTable.getSeqNo("flowbusiness.sn")+"号";
      //
      int is=v90.indexOf('['),ie=v90.indexOf(']',is);
      String fi_c=v90.substring(4,is);
      String fi_y=v90.substring(is+1,ie);
      String fi_s=v90.substring(ie+1,v90.length()-1);
      out.print("中电控股<select id='fi_c' onchange='f_code()'>");
      Enumeration efi=FlowIssuecode.find(" AND community="+DbAdapter.cite(teasession._strCommunity),0,100);
      while(efi.hasMoreElements())
      {
        FlowIssuecode fi =(FlowIssuecode)efi.nextElement();
        out.print("<option value=\"" + fi.name + "\"");
        if(fi_c.indexOf(fi.name)!=-1)out.print(" selected='true'");
        out.print(">" + fi.name);
      }
      out.print("</select>");
      out.print("[<input id='fi_y' value='"+fi_y+"' onchange='f_code()' mask='int' size='4'/>]<input id='fi_s' value='"+fi_s+"' onchange='f_code()' mask='int' size='4'/>号");
      out.print("<input type='hidden' name='dynamictype90' value=\""+v90+"\"/>");
    }
    %></td>
    <td class="tdtitle">正文打印份数</td>
    <td id="td100"><input type="text" name="dynamictype100" mask="int" /></td></tr>
    </table>
    </td>
  </tr>
  <tr>
    <td class="tdtitle">随文发附件</td>
    <td style="padding:0px;border:0px;border-right:1px solid #ABAEB3;">
    <table id="tabbase_nei" border="0" cellspacing="0" cellpadding="0">
    <tr>
    <td class="tabtdteshu" id="td101"></td>
    <td class="tdtitle">附件打印份数</td>
    <td id="td102"><input type="text" name="dynamictype102" mask="int" /></td>
    </tr>
    </table>
    </td>
  </tr>
  <tr>
    <td class="tdtitle">密　　级</td>
    <td style="padding:0px;border:0px;border-right:1px solid #ABAEB3;">
    <table id="tabbase_nei" border="0" cellspacing="0" cellpadding="0">
    <tr>
    <td  class="tabtdteshu" id="td93" title="机密程度: 机密 秘密 "><input type="text" name="dynamictype93"  />
    <%
//    dynamictype=93;
//    out.print("<input type='hidden' name='dynamictype" + dynamictype + "' />");
//    dt=DynamicType.find(dynamictype);
//    st = new StringTokenizer(dt.getContent(teasession._nLanguage), "/");
//    for (int index = 0; st.hasMoreTokens(); index++)
//    {
//      String str = st.nextToken();
//      String id = String.valueOf(dynamictype) + "_" + index;
//      out.print("<input type='checkbox' name='dynamictype_checkbox" + dynamictype + "' value=\"" + str + "\" id='" + id + "' onclick=\"if(this.checked){dynamictype" + dynamictype + ".value+=this.value+'&#12288;';}else{dynamictype" + dynamictype + ".value=dynamictype" + dynamictype + ".value.replace(this.value+'&#12288;','');}\" /><label for=" + id + ">" + str + "</label> ");
//    }
    %>
    </td>
    <td class="tdtitle">急　　缓</td>
    <td id="td94" title="缓急程度: 特急 急件 "><input type="text" name="dynamictype94"  />
    <%
//    dynamictype=94;
//    out.print("<input type='hidden' name='dynamictype" + dynamictype + "' />");
//    dt=DynamicType.find(dynamictype);
//    st = new StringTokenizer(dt.getContent(teasession._nLanguage), "/");
//    for (int index = 0; st.hasMoreTokens(); index++)
//    {
//      String str = st.nextToken();
//      String id = String.valueOf(dynamictype) + "_" + index;
//      out.print("<input type='checkbox' name='dynamictype_checkbox" + dynamictype + "' value=\"" + str + "\" id='" + id + "' onclick=\"if(this.checked){dynamictype" + dynamictype + ".value+=this.value+'&#12288;';}else{dynamictype" + dynamictype + ".value=dynamictype" + dynamictype + ".value.replace(this.value+'&#12288;','');}\" /><label for=" + id + ">" + str + "</label> ");
//    }

//    out.print("<select name='dynamictype94'>");
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
    <td class="tdtitle">部门审核</td>
    <td style="padding:0px;border:0px;border-right:1px solid #ABAEB3;">
    <table id="tabbase_nei" border="0" cellspacing="0" cellpadding="0">
    <tr>
    <td  class="tabtdteshu" id="td95"></td>
    <td class="tdtitle">综合管理部</td>
    <td id="td96"></td>
    </tr>
    </table>
    </td>
  </tr>
  <tr>
    <td class="tdtitle">拟 稿 人</td>
    <td style="padding:0px;border:0px;border-right:1px solid #ABAEB3;">
    <table id="tabbase_nei" border="0" cellspacing="0" cellpadding="0">
    <tr>
    <td  class="tabtdteshu" id="td91"><input type="hidden" name="dynamictype91"  /><img src='/tea/image/public/blank_png.gif' oncontextmenu='return false' /></td>
    <td class="tdtitle">电　　话</td>
    <td id="td92"><input type="text" name="dynamictype92"  /></td>
    </tr>
    </table>
    </td>
  </tr>
  <tr>
    <td class="tdtitle">校　　对</td>
    <td style="padding:0px;border:0px;border-right:1px solid #ABAEB3;">
    <table id="tabbase_nei" border="0" cellspacing="0" cellpadding="0">
    <tr>
    <td  class="tabtdteshu" id="td105"><input type="hidden" name="dynamictype105"  /><img src='/tea/image/public/blank_png.gif' oncontextmenu='return false' /></td>
    <td class="tdtitle">终　　审</td>
    <td id="td106"><input type="hidden" name="dynamictype106"  /><img src='/tea/image/public/blank_png.gif' oncontextmenu='return false' /></td>
    </tr>
    </table>
    </td>
  </tr>
  <tr>
    <td class="tdtitle">盖　　章</td>
    <td id="td161"><input type="hidden" name="dynamictype161"  /><img src='/tea/image/public/blank_png.gif' oncontextmenu='return false' /></td>
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
<iframe name="view" id="view" border="0" src="/jsp/admin/cec/FlowbusinessView.jsp?community=<%=teasession._strCommunity%>&flowitem=0&flowbusiness=<%=flowbusiness%>&dynamic=<%=f.getDynamic()%>&flow=<%=flow%>"></iframe>
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
  <td>送签时间</td>
  <td>会签部门/人员</td>
  <td>会签意见</td>
  <td>签名</td>
  <td>签出日期</td>
</tr>
<tbody id="ajax_csign"></tbody>

<script>f_ajax('ajax_csign');</script>
<%--
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
<img id="imgmap" src="/jsp/admin/cec/<%=flow%>.png" usemap="#Map" />
<map name="Map" onMouseOver="f_linered(event.srcElement,line)" onMouseOut="f_lineout();" onClick="f_lineclick(event.srcElement);">
<area shape="rect" coords="166,2,267,29" href="###" id="1"/>
<area shape="rect" coords="166,74,267,102" href="###" id="2"/>
<area shape="rect" coords="166,147,266,174" href="###" id="3"/>
<area shape="rect" coords="166,222,266,249" href="###" id="4" pstep="/3/"/>
<area shape="rect" coords="165,294,267,321" href="###" id="6"/>
<area shape="rect" coords="13,294,114,320" href="###" id="5"/>
<area shape="rect" coords="164,367,266,393" href="###" id="7"/>
<area shape="rect" coords="165,436,265,464" href="###" id="4" pstep="/7/"/>
<area shape="rect" coords="166,509,268,535" href="###" id="8"/>
<area shape="rect" coords="169,578,267,606" href="###" id="9"/>
<area shape="rect" coords="169,651,267,679" href="###" id="10"/>
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
  if(!dt.isHidden())continue;

  String ftype=dt.getType();
  DynamicValue av = DynamicValue.find(-flowbusiness, teasession._nLanguage, id);
  String value=MT.f(av.getValue());
  value=value.replaceAll("\"","&quot;").replaceAll("\r\n","\\\\r\\\\n");
//  if(id==91)
//  System.out.println(ftype);
  if("file".equals(ftype)&&value.length()>0)
  {
    out.println("obj=$('td"+id+"'); if(obj)obj.innerHTML=f_file(\":"+value+"\","+id+");");
  }else if(type==1||dtw.indexOf("/"+id+"/")!=-1||"office".equals(ftype))
  {
    if(!av.isExists()&&!"checkbox".equals(ftype))value=dt.getDefaultvalueToString(teasession);
    if(value.length()>0)
    {
      out.println("obj=form1.dynamictype"+id+";");
      out.println("if(obj)");
      out.println("{");
      out.println("  obj.defaultValue=obj.value=\""+value+"\";");
      out.println("  if(obj.selectedIndex==-1)obj.selectedIndex=0;");
      out.println("  img=obj.nextSibling;if(img&&img.tagName=='IMG')"+(value.startsWith("/res/")?"img.src='"+value+"';":"img.parentNode.replaceChild(document.createTextNode('"+value+"'),img);"));
      out.println("  arr=form1.dynamictype_checkbox"+id+";if(arr)for(var i=0;i<arr.length;i++)if(obj.value.indexOf('　'+arr[i].value+'　')!=-1||obj.value.indexOf(arr[i].value+'　')==0)arr[i].checked=true;");
      out.println("}");
    }
    if(dt.isNeed())
    {
      sbcheck.append("&&submitText(form1.dynamictype"+id+",'“"+dt.getName(teasession._nLanguage)+"”必填！')");
    }
  }else
  {
    if("sign".equals(ftype)&&value.startsWith("/res/"))value="<img src='" + value + "' oncontextmenu='return false' />";
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
<iframe name="a" width="0%" height="0%"></iframe>
<%@include file="/jsp/include/Calendar2.jsp" %>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</html>
