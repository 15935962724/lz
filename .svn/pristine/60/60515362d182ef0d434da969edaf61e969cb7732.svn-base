<%@page contentType="text/html;charset=UTF-8" %><%@ page import="java.io.*" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.Resource" %><%@ page import="tea.entity.admin.*" %><%@ page import="tea.ui.TeaSession" %><% request.setCharacterEncoding("UTF-8");
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

byte by[] = new byte[81920];
InputStream fis = AdminFunction.class.getResourceAsStream("/tea/menu.properties");
int len = fis.read(by);
fis.close();
h = new String(by,0,len,"utf-8")+"#";
h=h.replaceAll("\r","").replaceAll("(\n\n)+","\n");
%>
<%!
String h;


%>
<%


Resource r=new Resource("/tea/resource/userpriv");



%>
<!doctype html>
<html>
  <head>
    <TITLE><%=r.getString(teasession._nLanguage, "SetPurview")%></TITLE>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
        <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
          <META HTTP-EQUIV="Expires" CONTENT="0">
      <link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
      <script src="/tea/tea.js" type="text/javascript"></script>
<style type="text/css">
.tree{ padding-left:15px}
</style>
<script type="">
function fsel(obj,bool)
{
fclick(obj,bool);
if(bool)
fclick4(obj,bool);
}

function fclick(obj,bool)
{
  for(var objchild=obj.firstChild;objchild;objchild=objchild.nextSibling)
  {
    if(objchild.type=='checkbox')
    objchild.checked=bool;
    else
    fclick(objchild,bool);
  }
}

function fclick4(obj)
{
  obj=obj.parentNode;
  if(obj)
  {
    var idvalue=obj.id;
    if(idvalue&&idvalue.indexOf("div")==0)
    {
      document.getElementById("check"+idvalue.substring(3)).checked=true;
    }
    fclick4(obj);
  }
}

function fclick2(value)
{
      document.all(value).checked=true;
}

function fclick3(j)
{
  if(document.all("div"+j).style.display=="")
  {
    document.all("div"+j).style.display='none';
    document.all("img"+j).src='/tea/image/tree/tree_plus.gif';
  }else
  {
    document.all("div"+j).style.display='';
    document.all("img"+j).src='/tea/image/tree/tree_minus.gif';
  }
}

function f_load()
{
  ProgressBar.setValue(100);

}

<!-- 进度条----------------------------------------------------------------------------------------------------- -->
document.write("<div id=ProgressBar align=center >");
document.write("页面载入中,请等待...<br>");
document.write("<input id=chart style='border:0px;font-family:Arial;' size=55 readonly><br>");//
document.write("<span id=percent>0%</span>");
document.write("</div>");

ProgressBar.setValue=function f_ffff(v)
{

  var bar="";
  for(var i=0;i<v;i++)
  {
     bar=bar+"|";
  }
  chart.value=bar;
  percent.innerHTML=v+"%";
  if(v>99)
  {
    body.style.display="";
    ProgressBar.style.display="none";
  }

}
</script>

<style type="text/css">
<!--
#tablecenter1{border:1px solid #CCCCCC;}

#tablecenter1 div{height:0px;width:150px;float:left;line-height:0px}
#tablecenter1 div div{height:0px;line-height:0px}
#tablecenter1 div div div{height:0px;line-height:0px}
#tablecenter1 div div div div{height:0px;line-height:0px}
-->
div{padding-left:20px}
</style>
</head>
<BODY onload="f_load();">

<div id=body style="display:none">


<div id="head6"><img  height="6"></div>
<br>

<form name="form1" action="/servlet/EditAdminPopedom" method="post">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="act" value="editadminrole2"/>

<table border="0" align="left" cellpadding="0" cellspacing="0" id="tablecenter" >
<tr>
<%!
StringBuffer sb=new StringBuffer();
public void find(String str)
{
  int s=h.indexOf("#"+str+"\n");
  if(s==-1)return;
  int e=h.indexOf('#',s+1);
  String[] arr=h.substring(s,e).split("\n");
  for(int i=1;i<arr.length;i++)
  {
    if(arr[i].equals("-"))
    {
      //sb.append("<div style=\"background-color:#CCCCCC; line-height:1px\">&nbsp;</div>");
    }else
    {
      s=arr[i].indexOf(",");
      if(s==-1)
      {
        if("ROOT".equals(str))sb.append("<td valign='top'>");
        sb.append("<div>"+arr[i]);
        find(arr[i]);
      }else
      {
        sb.append("<div><a href='"+arr[i].substring(s+1)+"' target='_blank'>"+arr[i].substring(0,s)+"</a>");
      }
      sb.append("</div>");
    }
  }
}
%>
<%sb=new StringBuffer();find("ROOT");%>
<%=sb.toString()%>
  <tr>
   <td align="center" colSpan="50">
     <input   type="submit" value="<%=r.getString(teasession._nLanguage, "Submit")%>" >
     <input  onclick="history.back();" type="button" value="<%=r.getString(teasession._nLanguage, "CBBack")%>">
  </td>
</tr>
</table>
</form>

<br>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>

</div>
</body>
</html>
