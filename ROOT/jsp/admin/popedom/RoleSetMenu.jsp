<%@page contentType="text/html;charset=UTF-8" %><%@ page import="java.io.*" %><%@ page import="java.util.*" %><%@ page  import="tea.entity.*" %><%@ page import="tea.entity.admin.*" %><%!

private String tree1(Http h,int menu,int step,int type,String function)throws Exception
{
  if(function==null)function="|";
  StringBuilder htm=new StringBuilder();
  //h.member==14100001判断是否为webmaster，如果是，则显示全部，如果不是则显示当前用户的功能菜单
  Iterator it=AdminFunction.find(" AND father="+menu,(h.member==14100001?null:h)).iterator();
  while(it.hasNext())
  {
    AdminFunction t = (AdminFunction)it.next();
    if(!t.hidden)continue;

    if(step<1)
    htm.append("</td><td style=padding:20px valign=top nowrap>");
    if(t.type==1)
    {
      htm.append("<img src='/tea/image/tree/minus.gif' onclick='fclick3(this)'>");
    }else//功能菜单
    {
      htm.append("<img src='/tea/image/tree/minus.gif' />");
    }
    htm.append("<input ");
    int j=function.indexOf("|"+t.id+":");
    if(j==-1)j=function.indexOf("|"+t.id+"|");
    if(j!=-1)htm.append(" checked ");
    htm.append(" onclick='mt.select(this)' type='checkbox' name='menu"+type+"' id=check"+t.id+type+" value="+t.id+"><label for=check"+t.id+type+" title='"+MT.f(t.getContent(h.language))+"' >"+t.getName(h.language)+"</label>");
    if(t.action!=null)
    {
      String name="menu"+type+"_"+t.id,value=++j<1?"":function.substring(j,function.indexOf('|',j));
      String[] arr=t.action.split(",");
      for(int i=0;i<arr.length;i++)
      htm.append(" <input type='checkbox' name='"+name+"' value='"+arr[i]+"' "+(value.contains(arr[i])?" checked ":"")+" id='"+name+"_"+i+"'><label for='"+name+"_"+i+"'>"+Res.get(h.language,"menu."+arr[i])+"</label>");
    }
    htm.append("<br/><div class='tree'>");
    if(t.type==0)
    {
      htm.append(tree1(h,t.id,step+1,type,function));
    }
    htm.append("</div>\r\n");
  }
  return htm.toString();
}
%>
<%

Http h=new Http(request,response);
if(h.member<1)
{
  out.print("<script>top.location='/servlet/StartLogin?community="+h.community+"'</script>");
  return;
}
if(h.isIllegal())
{
  response.sendError(404,request.getRequestURI());
  return;
}

Res.add("/tea/resource/Common");

String key=h.get("role");

AdminRole r=AdminRole.find(Integer.parseInt(MT.dec(key)));
AdminFunction root=AdminFunction.getRoot(h.community,h.status);


%>
<html>
<head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/mt.js" type="text/javascript"></script>
<style type="text/css">
.tree{ padding-left:15px}
</style>
<script type="">
function fclick3(a)
{
  var b=a.src.indexOf('plus')!=-1;
  a.src='/tea/image/tree/'+(b?'minus':'plus')+'.gif';
  while(a.tagName!='DIV')a=a.nextSibling;
  a.style.display=b?'':'none';
}

mt.select=function(a)
{
  //向下
  var d=a;
  while(d.tagName!='DIV')d=d.nextSibling;
  d=d.getElementsByTagName('INPUT');
  for(var i=0;i<d.length;i++)d[i].checked=a.checked;
  //向上
  var d=a;
  while((d=d.parentNode).tagName!='TD')//最顶层
  {
    while(d.tagName!='INPUT')d=d.previousSibling;
    if(a.checked)d.checked=true;
  }
};
</script>

<style type="text/css">
<!--
#tablecenter1{border:1px solid #CCCCCC;}

#tablecenter1 div{height:0px;width:150px;float:left;line-height:0px}
#tablecenter1 div div{height:0px;line-height:0px}
#tablecenter1 div div div{height:0px;line-height:0px}
#tablecenter1 div div div div{height:0px;line-height:0px}
-->
</style>
</head>
<body>
<h1>角色的权限设置</h1>

<form name="form1" action="/Roles.do" method="post" target="_ajax">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="role" value="<%=key%>"/>
<input type="hidden" name="act" value="setmenu"/>
<input type="hidden" name="nexturl" value="<%=h.get("nexturl")%>"/>

<%
if(r.distinguish)
out.print("<div class='switch'><a href='###' onclick='mt.tab(this)' name='a_tab' class='current'>外网</a><a href='###' onclick='mt.tab(this)' name='a_tab'>内网</a></div>");
%>

<table name="tab" cellpadding="0" cellspacing="0" id="tablecenter" >
<tr><%=tree1(h,root.id,0,0,r.getAdminfunction())%></tr>
</table>

<%
if(r.distinguish)
{
  out.print("<table name='tab' id='tablecenter' style='display:none'>");
  out.print("<tr>"+tree1(h,root.id,0,1,r.getEthernet()));
  out.print("</tr></table>");
}
%>


<br/>
<div style="position:fixed; bottom:0px; background-color:#FFFFFF; text-align:center; width:100%"><input class="but" type="submit" value="保存" > <input class="but" type="button" value="返回" onClick="history.back();"></div>
</form>


</body>
</html>
