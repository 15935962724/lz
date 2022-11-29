<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%><%@page import="java.io.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%><%@page import="tea.ui.*"%>
<%@page import="tea.entity.sup.*"%><%@page import="tea.entity.member.*"%><%

Http h=new Http(request,response);
if(h.member<1)return;

Profile p=Profile.find(h.member);

int supplier=h.getInt("supplier",p.getProfile());
SupSupplier ss=SupSupplier.find(supplier);

String type=h.get("type");
if(type.length()<2)type=ss.type;
boolean b1=type.contains("|1|")||type.contains("|2|"),b2=type.contains("|3|")||type.contains("|4|");

String qualification=h.get("qualification");
boolean itype=h.getBool("itype");

String opener=h.get("opener","");

%>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/res/GYS/cache/qua.js" type="text/javascript"></script>
<style>
.list{border:1px solid #0A95F1;height:280px;overflow:auto;text-align:left;width:95%;padding:5px;margin-bottom:10px}
.switch{margin:0px;border:0px}
.tree{padding-left:20px;}
</style>
</head>
<body class="iframe">


<form name="form1" action="?" onsubmit="mt.query(this.name.value);return false;">
<table id="tablecenter" cellspacing="0">
<tr>
  <td class="th">编号/名称：</td><td><input name="name" onkeyup="if(defaultValue!=value)mt.query(value);defaultValue=value;"/></td>
  <!-- <td><input type="submit" value="查询"/></td> -->
</tr>
</table>
</form>


<form name="form2" action="?" method="post" target="_ajax">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="subqualification"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>

<%-- <%
out.print("<div class='switch'>");
if(b1)out.println("<a href='###' onclick='mt.tab(this)' name='a_tab'>设备</a>");
if(b2)out.println("<a href='###' onclick='mt.tab(this)' name='a_tab'>物资</a>");
out.print("<span id='result'></span></div>");
%> --%>
<div class="list" id="list">
<%

  out.print("<div name='tab' style=''><script>document.write(mt.tree(qua,13100524,'"+qualification+"',"+itype+"));</script></div>");

/* if(b2)
{
  out.print("<div name='tab' style='display:none'><script>document.write(mt.tree(qua,299,'"+qualification+"',"+itype+"));</script></div>");
} */
%>
</div>

<input type="button" value="确 定" onclick="f_ok()"/>
<input type="button" value="取 消" onclick="pmt.close()"/>
</form>

<script>
var pmt=parent.mt;
function f_ok()
{
  var attr=['name','value','data'];
  var arr=form2.id,h='';
  if(!arr.length)arr=[arr];
  for(var i=0;i<arr.length;i++)
  {
    var t=arr[i];
    if(t.disabled||!t.checked)continue;
    eval('d='+t.getAttribute('data'));
    h+="<span id='_q"+t.value+"' path='"+d.path+"'><input type='hidden' name='qualification'";
    for(var j=0;j<attr.length;j++)
      h+=" "+attr[j]+"='"+t.getAttribute(attr[j])+"'";
    h+=" />"+d.name+"<img src='/tea/image/d7.gif' onclick='mt.fdel(this)' /></span>";
    //删除旧的
    //t=parent.$('_q'+t.value);
    //if(t)t.parentNode.removeChild(t);textContent
  }
  _er.mt.receive(h);
  pmt.close()
}

mt.query=function(a)
{
  var j=0,arr=document.getElementsByTagName('LABEL');
  for(var i=0;i<arr.length;i++)
  {
    var v=arr[i].innerText;
    if(v.indexOf(a)!=-1)
    {
      j++;
      v=v.replace(a,'<font color=red>'+a+'</font>');
      mt.hidden(arr[i],false);
    }else
    {
      arr[i].parentNode.style.display='none';
    }
    arr[i].innerHTML=v;
  }
  $$('result').innerHTML="共查询到"+j+"项！";
//  if(a=='')
//  {
//    arr=document.getElementsByTagName('IMG');
//    for(var i=0;i<arr.length;i++)
//    {
//      if(arr[i].auto!=null)
//      {
//        console.log(i+"、"+arr[i].auto);
//        mt.ex(arr[i]);
//      }
//    }
//  }
};
mt.hidden=function(t,b)
{
  while(t.getAttribute('name')!='tab')
  {
    if(t.className=='tree')//父类
    {
      var s=t.previousSibling;
      s.style.display=b?'none':'';
      mt.ex(s.firstChild,true);
    }
    t.style.display=b?'none':'';
    t=t.parentNode;
  }
};
//mt.query=function(a)
//{
//  var arr=$$('list').getElementsByTagName('DIV');
//  for(var i=0;i<arr.length;i++)
//  {
//    var v=arr[i].innerText,b=v.indexOf(a)!=-1;
//  }
//};
mt.ex=function(a,b)
{
  var d=a.parentNode.nextSibling;
  a.auto=b;
  if(b==null)b=a.src.indexOf('plus')!=-1;
  d.style.display=b?'':'none';
  a.src='/tea/image/tree/'+(b?'minus':'plus')+'.gif';
};
mt.select=function(a)
{
  var p=a.parentNode;
  if(p.parentNode.className==''&&a.checked)//第一级
  {
    a.checked=false;
    mt.tip(a,'不能直接选中第一级分类！');
    return;
  }
  //向下
  var d=p.nextSibling;
  d=d.getElementsByTagName('INPUT');
  for(var i=0;i<d.length;i++)d[i].checked=a.checked;
  //向上
  if(!a.checked)return;
  d=p;
  while((d=d.parentNode).getAttribute('name')!='tab')//最顶层
  {
    d=d.previousSibling;
    d.childNodes[1].checked=true;
  }
};
$name('a_tab')[0].click();

mt.fit();
</script>
</body>
</html>
