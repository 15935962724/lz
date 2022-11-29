<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.ui.*" %>
<%@page import="java.util.*" %>
<%@page import="tea.entity.site.*" %>
<%@page import="tea.entity.admin.cebbank.*" %>
<%@page import="tea.resource.*"%>
<%@page import="java.net.URLEncoder"%><%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);

Community community=Community.find(teasession._strCommunity);

String code=(String)session.getAttribute("code");
if(code==null)
{
  out.println("<script>location.replace('/servlet/Node?node="+community.getNode()+"');</script>");
  return;
}

Resource r=new Resource("/tea/resource/Annuity");

String user=(String)session.getAttribute("user");
String name=(String)session.getAttribute("name");

String frame=request.getParameter("frame");

boolean if_tip=false;//true:集团用户,false:企业用户
Boolean tmp=(Boolean)session.getAttribute("if_tip");
if(tmp!=null)
{
  if_tip=tmp.booleanValue();
}

%><html>
<head>
<link href="/tea/CssJs/<%=teasession._strCommunity%>.css" rel="stylesheet" type="text/css">
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT SRC="/tea/tea.js" type="text/javascript"></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<script>
function f_open()
{
  window.open("about:blank","password_info","width=300,height=150,top=300,left=300");
  return true;
}
function f_click(obj)
{
  var cf=document.getElementById('CurrentTitle');
  if(cf)
  {
    cf.id='NodeTitle';
  }
  obj.parentNode.id='CurrentTitle';
}
function f_change(obj)
{
  var mf=parent.MenuFrame.location.href;
  var cf=parent.MenuFrame.document.getElementById('CurrentTitle');
  var tmp="&"+obj.name+"=";
  var i=mf.indexOf(tmp)+tmp.length;
  if(i>tmp.length)
  {
    var j=mf.indexOf("&",i);
    if(j==-1)
    {
      j=mf.length;
    }
    mf=mf.substring(0,i)+obj.value+mf.substring(j);
  }
  window.open(mf,"MenuFrame");
}
function f_exp()
{
  form1.action='/servlet/ExportAnnuity';
}
function f_go()
{
  form1.action='?';
}
function f_pwd()
{
  form1.action='/servlet/EditAnnuity';
  return submitText(form1.psword1,'无效-原密码')&&submitText(form1.psword2,'无效-新密码')&&submitLength(6,16,form1.psword2,'密码长度,在6-16之间.')&&submitEqual(form1.psword2,form1.psword3,'新密码 和 确认新密码 不相同');
}
function f_time()
{
  form1.action='?';
  return submitDate(form1.startdate,'<%=r.getString(teasession._nLanguage,"1186568245875")%>')&&submitDate(form1.enddate,'<%=r.getString(teasession._nLanguage,"1186568245875")%>');
}
</script>
</head>
<body id="<%if("footer".equals(frame))out.print("leftupfoot");else if("left".equals(frame))out.print("leftup"); else out.print("right_con");%>">
<%
if("header".equals(frame))
{
  out.println(community.getJspBefore(teasession._nLanguage));
}else
if("footer".equals(frame))
{
  out.println(community.getJspAfter(teasession._nLanguage));
}else//**************************************************************************////
if("mainheader".equals(frame))
{
//只有0009有此参数.0009只能集团用户看. 所以有此参数就是集团用户.
//boolean _bIf_tip=request.getParameter("if_tip")!=null;
%>

<div id="topmnue"><div id="topmnueleft"></div>
<div id="topmnueright">
<%
if(if_tip)//如果是集团用户
{
  out.print(Annuity.Annuity_0008(session,code,user,teasession._strCommunity,teasession._nLanguage));
  //out.print("<span id=go_ann><input type=submit value=GO onclick=\"return f_0008_submit();\"></span>");
  out.print("<span id=xiug_mm><a href=/jsp/admin/cebbank/Annuity.jsp?community="+teasession._strCommunity+"&tn="+Annuity.des("8003")+" target=_blank>修改密码</a></span>");
}
if(user==null)
{
  out.print(Annuity.Annuity_1013(session,teasession._strCommunity,teasession._nLanguage));//参加的企业
  out.print("<span id=t_p></span>");//个人登陆才有这个span//
}

%><!--
<span><a href="###"><%=r.getString(teasession._nLanguage,"1186540383046")%></a></span>
<span><a href="###"><%=r.getString(teasession._nLanguage,"1186540432515")%></a></span>
<span><a href="###"><%=r.getString(teasession._nLanguage,"1186540473750")%></a></span>
-->
<span id="tuic_dl"><a href="/servlet/EditAnnuity?community=<%=teasession._strCommunity%>&tn={0}" target="_top"><%=r.getString(teasession._nLanguage,"1186540514468")%></a></span>
</div>
</div>

<div id="Path">
  <Span ID=PathID1><A HREF="/servlet/Folder?node=<%=community.getNode()%>"><%=r.getString(teasession._nLanguage,"1186540578484")%></A></Span>
  <Span ID=PathID2>&nbsp;/&nbsp;<A HREF="/jsp/admin/cebbank/AnnuityDesktop.jsp?community=<%=teasession._strCommunity%>"><%=r.getString(teasession._nLanguage,"1186540625500")%></A></Span>
  <Span ID=PathID3>&nbsp;/&nbsp;<%=request.getParameter("info")%></Span>
</div>
<div id="wangxiong">
<div id="shuolan">
<table border="0" cellspacing="0" cellpadding="0" style="border-collapse:collapse"><tr><td id="xianshi"><span class="name">　<span id=corp_name></span>　<%=(user!=null)?user:name%></span> <%=r.getString(teasession._nLanguage,"1186540709296")%>　　<%=r.getString(teasession._nLanguage,"1186545084234")%>：<span class="name"><%=code%></span>
<%
if(user==null)//个人用户
{
  out.print(Annuity.Annuity_1008(session,teasession._nLanguage));
}else if(if_tip)//集团用户
{
  out.print(Annuity.Annuity_0009(session,teasession._nLanguage));
}else//企业用户
{
  out.print(Annuity.Annuity_0010(session,teasession._nLanguage));
}

%></td></tr>
</table></div>
</div>
<%




}else
if("mainfooter".equals(frame))
{%>

<!-- DIV id=xiangguan>相关内容： <A href="/servlet/Category?node=42400&Language=1">企业用户修改密码</A><A href="/servlet/Category?node=42307&Language=1">企业投资查询</A><A href="/servlet/Category?node=42305&Language=1">企业计划信息查询</A><A href="/servlet/Category?node=42306&Language=1">企业账户权益查询</A> </DIV>  -->
<!--
<DIV id=tishi><%=r.getString(teasession._nLanguage,"1186545126531")%>：1、<%=r.getString(teasession._nLanguage,"1186545172250")%>。<br/><SPAN style="MARGIN-LEFT: 36px">2、<%=r.getString(teasession._nLanguage,"1186545239453")%>。</SPAN></DIV>
-->
<%
}else
if("left".equals(frame))
{

%>
<div id="leftmenu">
<div id="bankmenu">

<span id="bankdata">
<SCRIPT language=JavaScript>
tmpDate = new Date();
date = tmpDate.getDate();
month= tmpDate.getMonth() + 1 ;
year= tmpDate.getYear();
myArray=new Array(6);
myArray[0]="星期日"
myArray[1]="星期一"
myArray[2]="星期二"
myArray[3]="星期三"
myArray[4]="星期四"
myArray[5]="星期五"
myArray[6]="星期六"
weekday=tmpDate.getDay();

document.write(year + "年"+ month + "月" + date + "日" + myArray[weekday]);
//
</SCRIPT>
</span>

<ul id="bankmenulist">
<%
ArrayList atn=new ArrayList();
if(user!=null)
{
  Map m=new HashMap();
  m.put("trade_no","8005");
  m.put("code",code);
  m.put("user",user);
  m=(Map)Annuity.conn(m);
  String ec = (String) m.get("error_code");
  if (!Annuity.EC_0000.equals(ec))
  {
    out.print("<script>alert('" +r.getString(teasession._nLanguage,"Annuity.error_code."+ec)+"');</script>");
  }else
  {
    ArrayList al=(ArrayList)m.get("result");
    for(int i=0;i<al.size();i++)
    {
      Map v=(Map)al.get(i);
      String trade_no =(String)v.get("trade_code");
      //System.out.println("权限:"+trade_no);
      if(!"0007".equals(trade_no)&&!"0008".equals(trade_no)&&!"0009".equals(trade_no)&&!"5002".equals(trade_no)&&!"5004".equals(trade_no)&&!"5006".equals(trade_no)&&!"1012".equals(trade_no))
      {
        if(!if_tip||!"1011".equals(trade_no))//就是集团用户登录进去以后 不能看到子企业的账户管理报告
        {
          atn.add(trade_no);//权限
          String trade_name =(String)v.get("trade_name");
          trade_name=r.getString(teasession._nLanguage,"Annuity."+trade_no);
          out.println("<LI><Span ID=NodeTitle><A TARGET=Annuity_Main onclick=f_click(this); HREF=/jsp/admin/cebbank/Annuity.jsp?community="+teasession._strCommunity+"&tn="+Annuity.des(trade_no)+" >"+trade_name+"</A></Span></LI>");//+"&corp_no="+corp_no+"&info="+URLEncoder.encode(trade_name,"UTF-8")
        }
      }
    }
  }
}else
{
  String trade_no[]={"1001","1002","1003","1004","1005","1006","1009","1010","1014","4001","8004"};//1008
  for(int i=0;i<trade_no.length;i++)
  {
    atn.add(trade_no[i]);//权限
    String trade_name=r.getString(teasession._nLanguage,"Annuity."+trade_no[i]);
    out.println("<LI><Span ID=NodeTitle><A TARGET=Annuity_Main onclick=f_click(this); HREF=/jsp/admin/cebbank/Annuity.jsp?community="+teasession._strCommunity+"&tn="+Annuity.des(trade_no[i])+" >"+trade_name+"</A></Span></LI>");//+"&pkc="+pkc+"&info="+URLEncoder.encode(trade_name,"UTF-8")
  }
}
session.setAttribute("annuity.trade_no",atn);
%>
</ul>
<div id="guanbi"><a name="size_button" href="javascript:fclick(this);" ><img src="/res/njjh/u/0802/080259935.gif"></a></div>
</div></div>
<script>
function fclick(im)
{
  //var value=getCookie('admin_leftup_hide');
  var obj=parent.annuity_frame2;
  if(obj.cols=="10,*")
  {
    obj.cols="147,*";
    //img.src="/tea/image/public/ico_min2.gif";
  }else
  {
    obj.cols="10,*";
    //img.src="/tea/image/public/ico_max2.gif";
  }
  size_button.focus();
}
</script>



<%}%>

</body>
</html>
