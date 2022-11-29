<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.entity.site.*" %><%@page import="tea.entity.*" %><%@page import="java.io.*" %><%@page import="java.util.*" %><%@page import="tea.html.*" %><%@page import="tea.entity.site.*" %><%@page import="tea.entity.admin.*" %><%@page import="java.math.*" %><%@page import="tea.entity.member.*" %><%@page import="tea.db.DbAdapter"%><%@page import="tea.resource.*" %><%@page import="tea.entity.node.*" %><%@page import="tea.ui.*" %><% request.setCharacterEncoding("UTF-8");

response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession=new TeaSession(request);


Http h=new Http(request);
int flowbusiness=h.getInt("flowbusiness");
boolean sync=Boolean.parseBoolean(request.getParameter("sync"));
Flowbusiness fb=Flowbusiness.find(flowbusiness);

if("POST".equals(request.getMethod()))
{
  byte by[]=teasession.getBytesParameter("file");
  if(by==null)return;
  String act=h.get("act");
  String path=h.get("path");
  if("revi".equals(act))//保存没有修定的复本
  {
    path="/res/"+teasession._strCommunity+"/flow/nor_"+flowbusiness+".doc";
  }else if("tape2".equals(act))//保存未印章的复本
  {
    path="/res/"+teasession._strCommunity+"/flow/nos_"+flowbusiness+".doc";
    fb.setTape2(path);
  }else
  {
    String name=teasession.getParameter("fileName");
    if(flowbusiness==0||path.indexOf("/flow/")==-1)path="/res/"+teasession._strCommunity+"/flow/fb_"+(flowbusiness==0?System.currentTimeMillis():(long)flowbusiness)+".doc";
  }
  Filex.write(application.getRealPath(path),by);
  out.print(path);
  return;
}else if(teasession._rv==null)//偶尔传来的word没有会话状态
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

CommunityOffice co=CommunityOffice.find(teasession._strCommunity);

String file=h.get("file","").replace('?','f');
//
File fi=new File(application.getRealPath(file));
if(!fi.isFile())
{
  out.print("<script>alert('文件丢失!');</script>");
  file=co.getTemplate();
}

String field=request.getParameter("field");
boolean authority="true".equals(request.getParameter("authority"));//是否显示 签字/盖章
boolean seal="true".equals(request.getParameter("seal"));//是否打开盖章窗口

Resource r=new Resource("/tea/resource/Dynamic");

if(authority)//保存未印章的复本
{
  String path="/res/"+teasession._strCommunity+"/flow/nos_"+flowbusiness+".doc";
  File f=new File(application.getRealPath(path));
  if(!f.exists())
  Filex.copy(application.getRealPath("/res/"+teasession._strCommunity+"/flow/nor_"+flowbusiness+".doc"),f.getPath());
  fb.setTape2(path);
}


Calendar c=Calendar.getInstance();
int year=c.get(Calendar.YEAR);

ProfileBBS pb = ProfileBBS.find(teasession._strCommunity, teasession._rv._strV);
String isign = pb.getISign(teasession._nLanguage);
String sn=pb.getSerialNum();


%><html>
<head>
<title><%=co.getProductCaption()%></title>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script LANGUAGE=JAVASCRIPT src="/tea/tea.js" type="text/javascript"></script>
<script LANGUAGE=JAVASCRIPT src="/tea/mt.js" type="text/javascript"></script>
<script LANGUAGE=JAVASCRIPT src="/tea/applet/key/key.js" type="text/javascript"></script>
<script LANGUAGE=JAVASCRIPT src="/tea/applet/office/ocx.js?0917" type="text/javascript"></script>
<style type="text/css">
<!--
body
{
 margin-left: 0px;
 margin-top: 0px;
 margin-right: 0px;
 margin-bottom: 0px;
 border:0px;
 background-color:menu;
}
-->
</style>
<script>
var ocx,path=new Array(0<%for(int i=0;i<file.length();i++)out.print(","+(int)file.charAt(i));%>);
opener=window.opener||window.dialogArguments;

var dtpath=opener.document.all("<%=field%>");
var submit=opener.document.all("submits");
function f_submit()
{
  if(!confirm("确认修改完毕?"))return;
  sign.ro(false);
  var re=ocx.SaveToURL('?community=<%=teasession._strCommunity%>&flowbusiness=<%=flowbusiness%>&sync=<%=sync%>&path='+encodeURIComponent(mt.dec(path)),'file');
  if(re&&re.indexOf('\n')==-1)dtpath.value=re;
  //if(!submit)dt.form.submit();

  doc.AcceptAllRevisions();//接受所有修订
  doc.TrackRevisions = false;//关闭修订模式
  ocx.SaveToURL('?community=<%=teasession._strCommunity%>&flowbusiness=<%=flowbusiness%>&act=revi','file');
  window.close();
}


//盖章
var ssign;

var dialog;
function f_open()
{
  try
  {
    var key=new Key();
    if(key.check("<%=sn%>"))
    {
      dialog=window.open('/jsp/admin/office/CachetList.jsp?esp=on','_do_cachet','width=680,height=350,top=200');
      //document.body.onfocus=function(){ try{dialog.focus();}catch(e){} };
    }
  }catch(e)
  {
  }
}
function f_SelSign(ss)
{
  ssign=ss;
  //form1.addseal.disabled=false;
  //f_AddSign();
}
function f_AddSign()
{
  if(!ssign||!dialog)return;
  try
  {
    var t=dialog.document;
    return;
  }catch(e)
  {
    if(e.number!=-2147024891)return;
  }
  dialog=null;
  var j=ssign.indexOf('?');
  try
  {
    ocx.AddSignFromURL("<%=teasession._rv%>",ssign,0,0,"signkey",1,100,1,"");
  }catch(e)//点"取消"报错
  {}
}
setInterval(f_AddSign,200);

function checkSign()
{
  //if(ocx.DoCheckSign(true)=='该文档没有任何合法签名。')
  if(sign.get().length<1)
  {
    return "您还没有盖章呢!!!!";
  }
}

function f_pic()
{
  <%
  if(isign==null||isign.length()<1)
  {
    out.print("alert('您还没有上传你的签名.');");
  }else
  {
    out.print("var key=new Key(); if(key.check('"+sn+"'))ocx.AddPicFromURL('"+isign+"',false,0,0,1,100,3);");
  }
  %>
}
function f_value(bm)
{
  var dt=opener.document.all("dynamictype"+bm);
  if(dt)
  {
    dt=dt.value.trim();
  }else
  {
    dt=opener.document.all("td"+bm);
    if(dt)
    {
      dt=dt.innerHTML;
    }else
    {
      switch(bm)
      {
        case "year":
        dt="<%=year%>";
        break;
      }
    }
  }
  if(bm=="19")
  {
    dt=dt.replace(/.*〔\d+〕(\d+)号/,"$1");
  }
  return dt;
}

function f_test()
{
  //  ocx.SetSignsVisible("*",true,0);//显示全部签名印章
  //  ocx.SetReadOnly(true,'',1);//设定文档为只读状态

  //ocx.ActiveDocument.Protect(3,false,"password",false,true);
  //ocx.ActiveDocument.Tables(1).Cell(2, 1).Range.Editors.Add (-1);
  ocx.ActiveDocument.Unprotect("password");
  ocx.ActiveDocument.Protect(3,false,"password",false,true);

  var cou=ocx.ActiveDocument.Revisions.Count;//获取修订的数目
  for(var i=1;i<=cou;i++)
  {
    var rev=ocx.ActiveDocument.Revisions(i);//获取修改的内容
    if(rev.Author=="<%=teasession._rv%>")
    {
    alert(rev.Range);
      rev.Range.Editors.Add(-1);
    }
  }
}
function f_revis()
{
  doc.ShowRevisions=!doc.ShowRevisions;
}
</script>
</head>
<body>
<script>
ocx=ActionX("<%=co.getProductCaption()%>","<%=co.getProductKey()%>","100%","95%");
ocx.FileNew=false;
ocx.FileOpen=false;
ocx.FileClose=false;
ocx.FileSave=false;
ocx.FileSaveAs=false;
ocx.FilePrint=false;
ocx.IsShowToolMenu = false;
try
{
  ocx.OpenFromURL(mt.dec(path));
}catch(e)
{
  if(e.number==-2147217149)
  alert("您没有正确安装Word，或者您安装的是精简版。请重新安装Microsoft Word！");
}
</script>
<%--
if(authority)
{
  File nos=new File(application.getRealPath(MT.f(fb.tape2)));
  if(!nos.isFile()||nos.length()<1)
  {
    %>
    <script>
    //正在保存未印章的复本，请稍等...
      var doc=ocx.ActiveDocument;
      doc.AcceptAllRevisions();//接受所有修订
      doc.TrackRevisions = false;//关闭修订模式
      ocx.SaveToURL('?community=<%=teasession._strCommunity%>&flowbusiness=<%=flowbusiness%>&act=tape2','file');
      //ocx.OpenFromURL(path);//360：显示"正在保存。。。"提示框
      location.replace(location.href+'&t='+new Date().getTime());
      </script>
      <%
      return;
   }
}
--%>
<form name='form1' action='?'>
<script>
var doc=ocx.ActiveDocument;

sign.ro(false);
var sel=doc.Application.Selection;
doc.Application.UserName="<%=teasession._rv%>";
doc.TrackRevisions = true;//修订模式
doc.ShowRevisions=false;//显示/不显示修订文字
doc.CommandBars("Reviewing").Enabled = false;
doc.CommandBars("Track Changes").Enabled = false;
//
var bms=doc.BookMarks;
for(var i=bms.Count;i>0;i--)
{
  try
  {
    var bm=bms(i).name.replace('dynamictype','id');//本来是id, 为兼容dynamictype
    if(bm.indexOf("id")!=0)continue;
    bm=bm.substring(2);
    var dt=f_value(bm);
    if(!dt)continue;

    if(bm=="42")//发文代号
    {
      if(dt.length>4)dt="";
    }else
    if(bm=="41")//文件类型
    {
      var name=decodeURI(path);
      if(dt!="请示"||(name.indexOf("党委文件模板")==-1&&name.indexOf("工会文件模板")==-1&&name.indexOf("公司文件模板")==-1))
        continue;
      try
      {
        bms("id"+bm+"_del").Range.Text="";//删除回车
      }catch(e331z)
      {}
      dt="\r\n\r\n\r\n\r\n\r\n\r\n\r\n";//顶端均要降至一页的一半距离
    }else
    {
      var time=Date.parse(dt.replace(/-/g,"/"));
      if(!isNaN(time))
      {
        dt=dt.replace("-","年").replace("-","月")+"日";
      }
    }
    if(bms(i).Range.Text!=dt)bms(i).Range.Text=dt;
  }catch(eee)
  {
  }
}

//锁定印章
var arr=sign.get();
if(arr.length<1||<%=authority%>)
{
  sign.lock();
  document.write("<input type='button' onclick='f_revis()' value='显示/隐藏 修改记录' />");
}else
sign.ro(true);
//
ocx.SetAutoCheckSignKey("signkey");
</script>
<script for="ocx" event="OnSignSelect(issign,signinfo)">
if(issign)
{
  ocx.SetReadOnly(true,"",0);
  ocx.SetReadOnly(false,"",0);
}
</script>
<%
if(authority)
{
  //out.print("h=h+\"<input type='button' onclick='f_pic()' value=' 签 字 '> \";");
  out.println("<input type='button' name='butseal' onclick='f_open()' value=' 盖 章 '>");
  //out.println("<input type='button' name='addseal' onclick='f_AddSign()' value=' 盖 章 ' disabled='true'>");
  out.println("<script>sign.stamp=true;window.onbeforeunload=checkSign;</script>");
}
%>
<!--
<input type="button" onclick="ocx.ActiveDocument.CommandBars('Standard').Controls('插入表格(&I)...').Execute;"/>-->
<input type='button' onclick='f_submit()' value='<%=r.getString(teasession._nLanguage, "保存文档")%>'>
<input type='button' onclick='window.close()' value=' 取 消 '>
</form>

<%
if(seal)out.print("<script>f_open();</script>");
%>
</body></html>
