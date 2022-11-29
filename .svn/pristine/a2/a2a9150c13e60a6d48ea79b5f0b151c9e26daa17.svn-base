<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.entity.node.*" %>
<%@page import="java.util.*" %>
<%@page import="tea.entity.site.*" %>
<%@page import="tea.resource.Resource" %>
<%@page import="tea.entity.admin.*" %>
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
int flow=0;
if(teasession.getParameter("flow")!=null && teasession.getParameter("flow").length()>0)
{
   flow = Integer.parseInt(teasession.getParameter("flow"));
}
int flowbusiness=Integer.parseInt(teasession.getParameter("flowbusiness"));
if(teasession.getParameter("flowbusiness")!=null && teasession.getParameter("flowbusiness").length()>0)
{
    flowbusiness = Integer.parseInt(teasession.getParameter("flowbusiness"));
}

String ua=request.getHeader("user-agent");
//if(ua.indexOf("Chrome/")==-1)
{ 
  String qs=request.getQueryString();
  if(flow==2)//收文
  {
    response.sendRedirect("/jsp/admin/flow/EditFlowReceive.jsp?"+qs);
    return;
  }
  if(flow==1)//发文
  {
    response.sendRedirect("/jsp/admin/flow/EditFlowDispatch.jsp?"+qs);
    return;
  }
}

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
if(fp.getMember()==null)
{
  out.print("<script>alert('抱歉!您的文件已经删除!');history.back();</script> ");
  return;
}


//如果不是"自由流程" 并 经办人中不存在当前会员
if(f.getType()!=1&&!fp.isExists()&&!fb.isExists()&&fp.getMember().indexOf("/"+member+"/")==-1&& !member.equals(fb.getCreator())&&!member.equals(fb.getMainTransactor())&&!member.equals(fb.getMainConsign()))
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
if (f.getType() == 2) //可控流程//
{
  if (flowprocess == f.getMainProcess()&&fb.isRunMain()) //如果当前是主控步骤 && 走过主控步骤
  {
    int flowview=Flowview.findLast(flowbusiness,flowprocess);
    step=Flowprocess.find(Flowview.find(flowview).getFlowprocess()).getStep();
    Flowprocess fp2 = Flowprocess.find(flow, step);
    dtprev=fp2.getDTWrite();
    dtw=fp2.getMainDTWrite();
    dtr=fp2.getMainDTRead();
  }
}
  
//下一步待办人///如果当前步是主控,则取主控的上一步
Flowprocess fp3 = Flowprocess.find(flow, step+1);
String dtmember=fp3.getMember();

StringBuffer sbcheck=new StringBuffer();

Resource r=new Resource();

ProfileBBS pb = ProfileBBS.find(teasession._strCommunity, member);
String sn=pb.getSerialNum();

String dtws[]=dtw.split("/");


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
</style>
</head>
<body onunload="sendx(form1.action+'?act=exclusive&flowbusiness='+form1.flowbusiness.value,null);">
<h1>工作接收/办理</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" action="/servlet/EditFlowdynamicvalue" method="post" enctype="multipart/form-data" onsubmit="return fcheck();">
<input type="hidden" name="community" value="<%=community%>">
<input type="hidden" name="repository" value="flow">
<input type="hidden" name="node" value="<%=teasession._nNode%>">
<input type="hidden" name="flowbusiness" value="<%=flowbusiness%>">
<input type="hidden" name="nexturl" value="<%=nexturl%>">
<input type="hidden" name="prev" value="<%=prev%>">
<input type="hidden" name="flow" value="<%=flow%>">
<%
if(f.getItemtype()>0)
//if(flowbusiness<1)
{
   out.print("<table border=0 cellpadding=0 cellspacing=0 id=tablecenter><tr><td>项目:</td><td><select name=flowitem><option value=\"\">---------");
   Enumeration e=Flowitem.find(teasession._strCommunity,"");
   while(e.hasMoreElements())
   {
     int id=((Integer)e.nextElement()).intValue();
     Flowitem fi=Flowitem.find(id);
     out.print("<option value="+id);
     if(fb.getFlowitem()==id)
     {
       out.println(" selected");
     }
     out.println(">"+fi.getName(teasession._nLanguage));
   }
   out.print("</select></td></tr></table>");
   sbcheck.append("&&submitText(form1.flowitem,'"+r.getString(teasession._nLanguage, "InvalidParameter")+"-项目')");
}

Enumeration e2=DynamicType.findByDynamic(f.getDynamic());
while(e2.hasMoreElements())
{
  int id=((Integer)e2.nextElement()).intValue();
  DynamicType dt_obj=DynamicType.find(id);
  if(dt_obj.isHidden())
  {
    int state=1;
    if(type==1||dtw.indexOf("/"+id+"/")!=-1)
    {
      state=0;
    }else if(dtr.indexOf("/"+id+"/")!=-1||flowprocess == f.getMainProcess())
    {
      state=2;
    }
    if(dt_obj.isNeed()&&state==0)
    {
      sbcheck.append("&&submitText(form1.dynamictype"+id+",'"+r.getString(teasession._nLanguage, "InvalidParameter")+"-"+dt_obj.getName(teasession._nLanguage)+"')");
    }
    out.print(dt_obj.getText(teasession,-flowbusiness,state));
    if(dtprev.indexOf("/"+id+"/")!=-1)//上一步所填的项///
    {
      out.print("<script>before"+id+".innerHTML='<font color=red>↑</font>';</script>");
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

<script type="text/javascript">
//禁用输入框
function f_dis()
{
  var inp=new Array("INPUT","SELECT","TEXTAREA");
  for(var j=0;j<inp.length;j++)
  {
    var arr=document.getElementsByTagName(inp[j]);
    for(var i=0;i<arr.length;i++)
    {
      if(arr[i].dis)continue;
      var dt=arr[i].name.replace(/\D+/g, "");
      if(dt)
      {
        if("<%=dtw%>".indexOf("/"+dt+"/")!=-1)
        {
          //arr[i].disabled=false;//有些区别用户
        }else
        if(arr[i].dtype=='office'&&"<%=dtr%>".indexOf("/"+dt+"/")!=-1) //只读状态 && 按钮 && 正文
        {
          arr[i].style.background='';
          arr[i].style.border='1px solid #D3D3D3';
        }else
        {
          arr[i].disabled=true;
          arr[i].style.background="#E1E1E1";
        }
      }
      arr[i].dis=true;
    }
  }
}
f_dis();
//setInterval(f_dis,200);


//从会员列表中删除下步没有的待办人
function f_dtmember()
{
  var arr="<%=sb.toString()%>".split("/");
  for(var i=1;i<arr.length;i++)
  {
    var os=document.all("dynamictype"+arr[i]);
    if(!os)continue;
    if(!os.length)os=new Array(os);
    for(var j=0;j<os.length;j++)
    {
      if(os[j].disabled)
      {
        os[j].style.display="none";
        continue;
      }
      var op=os[j].options;
      for(var x=1;x<op.length;x++)
      {
        if("<%=dtmember%>".indexOf("/"+op[x].value+"/")==-1)
        {
          op[x--]=null;
        }
      }
    }
  }
}
f_dtmember();
setInterval(f_dtmember,200);

//把对"正文"的说明文字变灰///
var ss=document.getElementsByTagName("SPAN");
if(!ss.length)ss=new Array(ss);
for(var i=0;i<ss.length;i++)
{
  if(!isNaN(parseInt(ss[i].id))&&ss[i].id!="<%=flowprocess%>")
  {
    ss[i].style.background="#CCCCCC";
  }
}

function fcheck()
{
  return true<%=sbcheck.toString()%>;
}
</script>

<%
if(dtws.length!=2||"/office/csign/".indexOf("/"+DynamicType.find(Integer.parseInt(dtws[1])).getType()+"/")==-1)
{
  out.print("<input type=submit name=submit value=提交 class=edit_button>");
  out.print("<input type=reset value=重置 class=edit_button>");
  out.print("<input type=button value=返回 onClick=history.back();  class=edit_button>");
}
%>
</form>

<%@include file="/jsp/include/Calendar2.jsp" %>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</html>
