<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%><%@page import="java.io.*"%>
<%@page import="tea.entity.shop.*"%><%@page import="tea.entity.*"%><%
Http h=new Http(request,response);

int oby=h.getInt("oby");
int pos=h.getInt("pos");
String act=h.get("act");

StringBuilder par=new StringBuilder();
par.append("?community="+h.community);
par.append("&act="+act);

int len=application.getRealPath("/").length()-1;

File[] fs=new File(application.getRealPath("/res/"+h.community+"/ftp/")).listFiles();
if(fs==null)
{
  out.print("<script>alert('抱歉，本站暂没开能此功能！')</script>");
  return;
}

if(oby>0)
{
  par.append("&oby="+oby);
  for(int i=0;i<fs.length;i++)
  {
    long ilm=fs[i].lastModified();
    long ile=fs[i].length();
    for(int j=i;j<fs.length;j++)
    {
      long jlm=fs[j].lastModified();
      long jle=fs[j].length();
      if(oby==2&&ilm<jlm||oby==1&&ile<jle)
      {
        File sw=fs[i];
        fs[i]=fs[j];
        fs[j]=sw;
        ilm=jlm;
        ile=jle;
      }
    }
  }
}
par.append("&pos=");

%><html>
<head>
<base target="_self" />
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/mt.js" type="text/javascript"></script>
<style>
.tbn{border:1px solid #CCCCCC; width:100px; height:100px;overflow: hidden;margin:10px;}
.file{width:0;filter:alpha(opacity=0);opacity:0;margin-left:-69px}
#tablecenter div{float:left;text-align:center;}
</style>
</head>
<body><h1>选择图片</h1><div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" action="?">
<input type="hidden" name="community" value="<%=h.community%>" />
<input type="hidden" name="act" value="<%=act%>" />
排序：<select name="oby" onchange="form1.submit();">
<option value="2">时间</option>
<option value="1">大小</option>
<option value="0">名称</option>
</select>
</form>

<table id="tablecenter" cellspacing="0">
<tr><td>
<%
for(int i=pos;i<pos+10&&i<fs.length;i++)
{
  String path=fs[i].getPath().substring(len).replace('\\','/'),name=fs[i].getName();
  out.print("<div><span");
  if("select".equals(act))
  out.print(" onclick=f_act('sel',this)");
  else
  out.print(" onmouseover=f_act('copy',this)");
  out.print(" class='tbn' title='文件名："+name+"&#13;时　间："+MT.f(new Date(fs[i].lastModified()),1)+"'><img src='"+path+"' /></span><br/>"+MT.f(name,12)+"</div>");
}
%>
</td>
</tr>
<tr><td><%=new tea.htmlx.FPNL(h.language,par.toString(),pos,fs.length,10)%></td>
</table>

<%
if("select".equals(act))
{
  out.print("<input type='button' value='确定' onclick='f_ok()' />");
}
%>

<script>
if(opener||dialogArguments)document.write("<input type='button' value='关闭' onclick='window.close()' />");

form1.oby.value="<%=oby%>";
var imgs=document.images;
if(imgs)
for(var i=1;i<imgs.length;i++)
{
  var w=imgs[i].width,h=imgs[i].height;
  if(w<100&&h<100)continue;
  if(w>h)imgs[i].width=100;else imgs[i].height=100;
}

document.write("<img id='i_sel' src='/tea/image/public/ok_20.gif' style='position:absolute;display:none' /><a id='a_copy' href='javascript:;' style='position:absolute;background:#FFF;color:#FF0000;display:none'>复制</a>");
var img,is=$('i_sel'),ac=$('a_copy');
function f_act(a,c)
{
  img=c.firstChild;
  if(a=='sel')
  {
    is.style.top=mt.top(c)+78+"px";
    is.style.left=mt.left(c)+2+"px";
    is.style.display='';
  }else if(a=='copy')
  {
    ac.style.top=mt.top(c)+86+"px";
    ac.style.left=mt.left(c)+2+"px";
    ac.style.display='';
    ac.onclick=function()
    {
      img.removeAttribute("width");
      img.removeAttribute("height");
      mt.copy(img);
    }
  }
}
function f_ok()
{
  if(!img)
  {
    mt.show('请先图片选择！');
    return;
  }
  window.returnValue=img.src.substring(img.src.indexOf('/',10));
  window.close();
}
</script>
</body>
</html>
