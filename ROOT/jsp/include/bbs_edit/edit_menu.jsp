<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="java.io.*" %>
<%@page import="tea.resource.*" %>
<%@page import="tea.entity.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.entity.site.*"%>
<%@page import="tea.ui.*"%>
<%@page import="java.util.*"%>
<%

if("POST".equals(request.getMethod()))
{
  TeaSession teasession=new TeaSession(request);
  String url;
  byte by[]=teasession.getBytesParameter("file");
  if(by!=null)
  {
    url=new TeaServlet().write(teasession._strCommunity,by,".gif");
  }else
  {
    url=teasession.getParameter("url");
  }
  out.print("<script>parent.hte_exc('images','"+url+"'); parent.f_mh();</script>");
}

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html><head>
<STYLE>BODY {
	FONT-SIZE: 12px; MARGIN: 0px
}
TD {
	FONT-SIZE: 12px; MARGIN: 0px
}
.link {
	CURSOR: pointer; COLOR: blue; TEXT-DECORATION: underline
}
.td {
	BORDER-RIGHT: #b09a90 1px solid; BORDER-TOP: #b09a90 1px solid; BACKGROUND: #edf1fc; BORDER-LEFT: #b09a90 1px solid; BORDER-BOTTOM: #b09a90 1px solid
}
.dtd {
	BORDER-RIGHT: #fff 1px solid; BORDER-TOP: #fff 1px solid; BORDER-LEFT: #fff 1px solid; BORDER-BOTTOM: #fff 1px solid
}
.t40 {
	WIDTH: 40px
}
</STYLE>

<META http-equiv=Content-Type content="text/html; charset=utf-8">
<META content="MSHTML 6.00.5730.11" name=GENERATOR>
<SCRIPT>
if(parent.isMoz)
{
  Event.prototype.__defineGetter__("srcElement",function(){var node=this.target;while(node.nodeType!=1){node=node.parentNode}return node})
}
var col=000000
var cmdall
function $(obj)
{
  return document.getElementById(obj)
}

function menu_ini(cmd)
{
  cmdall=cmd
  document.body.style.background="#ffffff"
  var l="<table width=100% cellspacing=0 cellpadding=0 border=0>"
  if(cmd=="img")
  {
    l+="<table width=300 border=0 cellpadding=3 style=margin:3px><tr><td>网络:</td><td><input name=url value=http:// size=30></td></tr> <tr><td>上传:</td><td><input type=file name=file></td></tr>";
    l+="<tr><td colspan=2 align=center><button type=submit >确定</button>&nbsp;&nbsp;&nbsp;<button onclick=parent.f_mh()>取消</button></td></tr></table>";
    Fwindow(300,100)
  }else
  if(cmd=="font")
  {
    var a="宋体,黑体,楷体,隶书,幼圆,Arial,Arial Narrow,Arial Black,Comic Sons MS,Courier,System,Times New Roman,Verdana".split(",")
    for(var i=0;i<a.length;i++)
    {
      l+="<tr onmouseover='this.style.background=\"#316ac5\";this.firstChild.style.color=\"#FFF\"' onmouseout='this.style.background=\"\";this.firstChild.style.color=\"#000\"'><td style='padding:2px;font-family:"+a[i]+"' onmousedown='parent.hte_exc(\"family\",\""+a[i]+"\")'>"+a[i]+"</td></tr>"
    }
    if(parent.isIE)
    Fwindow(100,240)
    else
    Fwindow(100,250)
  }else
  if(cmd=="size")
  {
    var a=new Array("极小","特小","小","中","大","特大","极大")
    for(var i=1;i<=7;i++)
    {
      l+="<tr onmouseover='this.style.background=\"#316ac5\";this.firstChild.style.color=\"#FFF\"' onmouseout='this.style.background=\"\";this.firstChild.style.color=\"#000\"'><td style='padding:2px' onmousedown='parent.hte_exc(\"size\",\""+i+"\")'>"+a[i-1]+"</font></td></tr>"
    }
    Fwindow(60,125)
  }else
  if(cmd=="color")
  {
    document.body.style.background="#f3f6fd"
    l="<table border='0' cellspacing='5' cellpadding='0' align=center>\
    <tr> \
    <td colspan='3' id=scolor style='background:#"+(cmd=="color"?"000000":"FFFFFF")+";border:1px solid #000000;height:20px;width:60px' onmousedown='parent.hte_exc(\""+(cmd=="color"?"color":"BackColor")+"\",this.style.background)'>&nbsp;</td>\
    <td colspan='5' style='padding-left:10px' id=colortext>选择色彩</td>\
    </tr>"
    var c="000000,993300,333300,003300,003366,000080,333399,333333,800000,FF6600,808000,008000,008080,0000FF,666699,808080,FF0000,FF9900,99CC00,339966,33CCCC,3366FF,800080,999999,FF00FF,FFCC00,FFFF00,00FF00,00FFFF,00CCFF,993366,C0C0C0,FF99CC,FFCC99,FFFF99,CCFFCC,CCFFFF,99CCFF,CC99FF,FFFFFF".split(",")
    for(var i=0;i<5;i++)
    {
      l+="<tr>"
      for(var j=0;j<8;j++)
      {
        l+="<td style='width:13px;height:15px;border:1px solid #000;font-size:2px;background:#"+c[j+i*8]+"' onmousemove='$(\"scolor\").style.background=$(\"colortext\").innerHTML=\"#"+c[j+i*8]+"\"' onmouseout='this.style.border=\"1px solid #000\"' onmouseover='this.style.border=\"1px solid #FF0000\"' onmousedown='parent.hte_exc(\""+(cmd=="color"?"color":"BackColor")+"\",\"#"+c[(j+i*8)]+"\")'>&nbsp;</td>"
      }
      l+="</tr>"
    }
    Fwindow(160,130)
  }else
  if(cmd=="face")
  {
    l="<table width=100% cellspacing=2 cellpadding=0>"
    for(var i=0;i<6;i++)
    {
      l+="<tr>"
      for(var j=0;j<10;j++)
      {
        var v=(j+i*8+1);
        var name=v;
        if(v<10)
        name="00"+v;
        else if(v<100)
        name="0"+v;
        l+="<td style='width:22px;height:22px;margin:1px;border:1px solid #FFF' onmouseover='this.style.border=\"1px solid #139a39\"' onmouseout='this.style.border=\"1px\"'><img src=/tea/image/face/"+name+".gif onmousedown='parent.hte_exc(\"face\",\""+name+"\")'></td>"
      }
      l+="</tr>"
    }
    Fwindow(240,146)
  }else
  if(cmd=="table")
  {
    document.body.style.background="#f3f6fd"
    l='<table width="260" border="0" cellpadding="3" style="margin:3px">\
    <tr> \
    <td align=right width="80">行数：</td>\
    <td width="40"><input class=t40 value="3" maxlength="2"></td>\
    <td>列数：<input class=t40 value="3" maxlength="2"></td>\
    </tr>\
    <tr> \
    <td align=right>表格宽度：</td>\
    <td><input class=t40 value="200" id="w"></td>\
    <td> \
    <input type="radio" name="rad" id=r1 value="0" checked><LABEL for=r1>像素</LABEL> \
    <input type="radio" name="rad" id=r2 value="1" onclick="document.getElementById(\'w\').value=\'100\'"><LABEL for=r2>百分比</LABEL></td>\
    </tr>\
    <tr> \
    <td align=right>边框粗细：</td>\
    <td><input class=t40 value="1"></td>\
    <td>像素</td>\
    </tr>\
    <tr> \
    <td align=right>单元格边距：</td>\
    <td><input class=t40 value="1"></td>\
    <td>&nbsp;</td>\
    </tr>\
    <tr> \
    <td align=right>单元格间距:</td>\
    <td><input class=t40 value="1"></td>\
    <td>&nbsp;</td>\
    </tr>\
    <tr> \
    <td colspan="3" align=center><button onclick="add_table()">确定</button>&nbsp;&nbsp;&nbsp;<button onclick="parent.f_mh()">取消</button></td>\
    </tr>'
    Fwindow(260,200)
  }
  form1.innerHTML=l+"</table>"
  parent.$("wEditorMenu").style.display=""

  parent.wEdit.document.body.onclick=parent.f_mh;
}

function add_table()
{
	var o=document.getElementsByTagName("input")
	var k=""
	for(var i=0;i<o.length;i++)
        {
		if(o[i].getAttribute("type")=="radio"&&!o[i].checked)
			continue
		var h=o[i].value==""?"1":o[i].value
		k+=h+","
	}
	parent.hte_exc("table",k)
}

function Fwindow(w,h)
{
	parent.$("wEditorMenu").style.width=w+"px"
	parent.$("wEditorMenu").style.height=h+"px"
}

function menu(e)
{
	var ee=e.srcElement
	var etp=e.type
	if(ee.tagName!="TD")
		return
	if(etp=="mouseover")
		ee.className="td"
	if(etp=="mouseout")
		ee.className="dtd"
}

document.onmouseup=function()
{
  if(cmdall!="img" && cmdall!="table")
  {
    parent.$("wEditorMenu").style.display="none"
  }
}

//document.onkeypress=function()
//{
//	if(event.keyCode<47 || event.keyCode>58)return false;
//}
</SCRIPT>
</head>
<BODY ondragstart=return(false) style="MARGIN: 0px; OVERFLOW: hidden; CURSOR: default" bgColor=white>
<form name="form1" action="?" method="post" enctype="multipart/form-data">
</form>
</BODY>
</html>
