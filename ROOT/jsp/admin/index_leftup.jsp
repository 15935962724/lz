<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.entity.*" %><%@page import="tea.ui.*" %><%@page import="tea.resource.*" %><%@page import="java.util.*" %><%@page import="tea.entity.node.*" %><%@page import="tea.entity.admin.*" %><%@page import="tea.entity.site.*" %><%

request.setCharacterEncoding("UTF-8");

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community+"&nexturl="+java.net.URLEncoder.encode("/jsp/admin/?community="+h.community+"&node="+h.node,"UTF-8"));
  return;
}

if(request.getParameter("ajax")!=null)
{
  //int step=Integer.parseInt(request.getParameter("step"));
  int father=Integer.parseInt(request.getParameter("father"));
  boolean isNode=Boolean.parseBoolean(request.getParameter("isNode"));
  if(isNode)
  {
    out.print(Node.find(father).getTreeToHtml(h.language,0));
  }else
  {
    AdminFunction af=AdminFunction.find(father);
    if(af.getType()==2)
    {
      father=Integer.parseInt(af.getUrl(h.language));
      out.print(Node.find(father).getTreeToHtml(h.language,0));
    }else
    out.print(af.getTreeToHtml(h));
  }
  return;
}

Resource r = new Resource("/tea/resource/fun");

Community c=Community.find(h.community);
String desktop=c.getDesktop();

boolean def=!h.getBool("def");//(desktop==null||desktop.length()<1)||

int root=h.getInt("id");
AdminFunction af=AdminFunction.find(root);

%><!doctype html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<style>
/*节点菜单*/
.nt_step{padding-left:18px}
</style>
<script>
if(top.location==self.location)top.location="/jsp/admin/indextop.jsp?community=<%=h.community%>&node=<%=h.node%>&tree="+encodeURIComponent(self.location);

var A;
function tree(a,t)
{
  if(t==1)
  {
    if(A)A.className='';
    a.className='current';
    A=a;
  }else
  {
    var isNode=a.id.charAt(0)=='n';//节点菜单
    var d=a.parentNode;
    d=isNode?d.lastChild:d.nextSibling;

    var ish=d.style.display=="";
    d.style.display=ish?"none":"";
    a.className=ish?"plus":"minus";
    a.firstChild.src="/tea/image/tree/tree_"+(ish?"plus":"minus")+".gif";
    if(ish)return;
    if(d.innerHTML!="")return;
    d.innerHTML="load...";
    mt.send("?ajax=ON&father="+a.id.substring(1)+"&isNode="+isNode,function(h){d.innerHTML=h||"无子项";mt.click(d);});
  }
}
//function f_click(j,step)
//{
//  var divid=$("divid"+j),imgid=$("img"+j),isNode=false;
//  if(!divid)
//  {
//    divid=$("ntd_"+j);
//    imgid=$("nti_"+j);
//    isNode=true;
//  }
//  if(divid.style.display=="")
//  {
//    divid.style.display="none";
//    imgid.src="/tea/image/tree/tree_plus.gif";
//  }else
//  {
//    divid.style.display="";
//    imgid.src="/tea/image/tree/tree_minus.gif";
//    if(divid.innerHTML=="")
//    {
//      divid.innerHTML="　　<img src=/tea/image/public/load.gif>load...";
//      sendx("?ajax=ON&community=<%=h.community%>&father="+j+"&step="+(step+1)+"&isNode="+isNode,
//      function(data)
//      {
//        divid.innerHTML=data;
//        f_open(divid);
//      });
//    }else
//    {
//      f_open(divid);
//    }
//  }
//}
function f_open(obj)
{
  var h=obj.innerHTML;
  var i=h.indexOf("<script>")+8;
  if(i>10)
  {
    var j=h.indexOf("</"+"script>",i);
    eval(h.substring(i,j));
  }
}
function nt_ex(i,j){f_click(i,j);}
function nt_open(i){window.open('/jsp/general/NodeLists.jsp?node='+i,'m');}
mt.click=function(a)
{
  var arr=a.getElementsByTagName("A");
  var j=0;//arr[0].href.indexOf('javascript:')==0?1:0;
  if(arr[j].href.indexOf('javascript:')==0&&arr[j].className=='minus');//文件夹 && 已展开
  else
    arr[j].click();
};
</script>
</head>
<body id="leftup">
<div id="leftupdiv2">
<div id="leftup_bottom">

<span class="title"><img src="/tea/image/other/img-globe.gif" width="16" height="16">
<%=af.getName(h.language)%></span>

<div><%=af.getTreeToHtml(h)%></div>

<script>
if(mt.get('auto')!='false')
{
  mt.click(document);
}

//var a0=document.all('a0');
//if(a0)
//{
//  if(a0.length)
//  {
//
//  }
//  if(a0.length<3)
//  {
//    var i=a0.length;
//    while(i>0)
//    {
//      eval(a0[--i].href);
//    }
//  }
//}
</script>

</div>
</div>
</body>
</html>
