<%@page contentType="text/javascript; charset=UTF-8" %>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.ui.*" %>
<%@page import="java.io.*" %>
<%@page import="tea.db.*" %>
<%@page import="java.util.*" %>
<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession=new TeaSession(request);

int root=Integer.parseInt(request.getParameter("root"));

Node n=Node.find(root);

//int step=nr.getPath().split("/").length;

//Node n=Node.find(teasession._nNode);
//String path=n.getPath();

if(request.getParameter("ajax")!=null)
{
  //step=Integer.parseInt(request.getParameter("step"));
  out.print(n.getTreeToHtml(teasession._nLanguage,teasession._nNode));
  return;
}

%>
//其它网站,调用些JS,域名问题...
var host=document.getElementsByTagName("SCRIPT");
host=host[host.length-1].src.toLowerCase();
host=host.indexOf("http")==0?host.substring(0,host.indexOf('/',10)):"";

function nt_ex(j,step)
{
  var d=document.getElementById("ntd_"+j);
  var i=document.getElementById("nti_"+j)
  if(!d||!i)
  {
    return;
  }
  if(d.style.display=='')
  {
    d.style.display='none';
    i.src='/tea/image/tree/tree_plus.gif';
  }else
  {
    if(d.innerHTML.length==0)
    {
      d.innerHTML="　　<img src='/tea/image/public/load.gif'>load...";
      sendx(host+"/jsp/include/JsNodeTree.jsp?ajax=ON&step="+(step+1)+"&root="+j,function(data)
      {
        d.innerHTML=data;
        var j=data.lastIndexOf("<scr"+"ipt>");
        if(j!=-1)
        {
         eval(data.substring(j+8,data.length-9));
        }
      } );
    }
    d.style.display="";
    i.src="/tea/image/tree/tree_minus.gif";
  }
}

function nt_open(id)
{
  window.open(host+"/servlet/Node?node="+id,"_self");
  return false;
}

document.write("<%=n.getTreeToHtml(teasession._nLanguage,teasession._nNode)%>");

