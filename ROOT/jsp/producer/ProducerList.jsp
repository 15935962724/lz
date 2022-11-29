<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.entity.admin.GoodsType"%><%@ page import="tea.ui.*"%><%@ page import="java.util.*"%><%!
private String encode(String path)throws java.io.UnsupportedEncodingException//加密
{
  StringBuffer sb=new StringBuffer(path);/*
  for(int i=0;i<path.length();i++)
  {
    char ch=(char)((int)path.charAt(i)+255);
    sb.append(ch);
  }*/
  return java.net.URLEncoder.encode(sb.toString(),"UTF-8");
}
private String decode(String path)throws java.io.UnsupportedEncodingException//解密
{
  StringBuffer sb=new StringBuffer(path);/*
  for(int i=0;i<path.length();i++)
  {
    char ch=(char)((int)path.charAt(i)-255);
    sb.append(ch);
  }*/
  return java.net.URLDecoder.decode(sb.toString(),"UTF-8");
}

private void  tree1(java.io.Writer jw,java.io.File file,String path,int step,String community)throws Exception
{
  StringBuffer sb=new StringBuffer();
  for(int loop=0;loop<step;sb.append("<img src=/tea/image/tree/tree_line.gif align=absmiddle>"),loop++);
  java.io.File files[]=file.listFiles();
  if(files!=null)
  for(int i=0;i<files.length;i++)
  {
    if(files[i].isDirectory())
    {
      int j=Math.abs(files[i].hashCode());
      boolean bool=false;
      java.io.File sub_files[]=files[i].listFiles();
      if(sub_files!=null)
      for(int k=0;k<sub_files.length;k++)
      {
        if(sub_files[k].isDirectory())
        {
          bool=true;
          break;
        }
      }
      if(!bool)
      {
        tea.html.Anchor a2=new tea.html.Anchor("EditProducer.jsp?community="+community+"&path="+encode(path+files[i].getName()+"/"),files[i].getName());
        a2.setTarget("producer_edit");
        jw.write("<div>"+sb.toString()+"<IMG SRC=/tea/image/tree/tree_blank.gif BORDER=0 align=absmiddle ID=img"+j+" />"+a2.toString()+"</div><Div id=divid"+j+" style=display:none></Div>");
      }else
      {
        tea.html.Anchor a=new tea.html.Anchor("javascript:void(0);","<IMG SRC=/tea/image/tree/tree_plus.gif BORDER=0 align=absmiddle ID=img"+j+" />");

        a.setOnClick("if(divid"+j+".style.display==''){divid"+j+".style.display='none';document.all('img"+j+"').src='/tea/image/tree/tree_plus.gif';}else{if(divid"+j+".innerHTML.length==0)sendx('/jsp/producer/ProducerList.jsp?ajax=ON&community="+community+"&step="+(step+1)+"&path="+encode(path+files[i].getName()+"/")+"',function(data){divid"+j+".innerHTML=data; }); divid"+j+".style.display='';document.all('img"+j+"').src='/tea/image/tree/tree_minus.gif';}");

        tea.html.Anchor a2=new tea.html.Anchor("EditProducer.jsp?community="+community+"&path="+encode(path+files[i].getName()+"/"),files[i].getName());
        a2.setTarget("producer_edit");
        jw.write("<div>"+sb.toString()+a.toString()+a2.toString()+"</div><Div id=divid"+j+" style=display:none></Div>");
      }
    }
  }
}

private String deploy(java.io.File file,String community,int len)throws Exception
{
  int id=Math.abs(file.hashCode());
  if(file.isDirectory())
  {
    java.io.File pf=file.getParentFile();
    return deploy(pf,community,len)+"if(document.all('img"+id+"').src.indexOf('tree_plus.gif')!=-1){if(divid"+id+".innerHTML.length==0)     \r\n"+
    "     sendx('/jsp/producer/ProducerList.jsp?ajax=ON&community="+community+"&step='+(++step)+'&path="+pf.getAbsolutePath().substring(len).replaceAll("\\\\\\\\","/")+"',function(d){divid"+id+".innerHTML=d;});     \r\n"+
    "     divid"+id+".style.display='';               \r\n"+
    "     document.all('img"+id+"').src='/tea/image/tree/tree_minus.gif';}              \r\n";
//    return deploy(obj.getFather())+"document.getElementById('divid"+id+"').style.display='';if(document.getElementById('img"+id+"').src.indexOf('tree_plus.gif')!=-1)document.getElementById('img"+id+"').src='"+path+"/tea/image/tree/tree_minus.gif';";
  }else
  {
    return "";
  }
}
%><%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
String community=request.getParameter("community");

int step=0;
if(request.getParameter("ajax")!=null)
{
  step=Integer.parseInt(request.getParameter("step"));
  String path=request.getParameter("path");
  java.io.File file=new java.io.File(application.getRealPath(path));
  tree1(out,file,path,step,community);
  return;
}


if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String path="/res/"+community+"/producer/";
java.io.File file_root=new java.io.File(application.getRealPath(path));

%>
<html>
  <head>
    <META http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<style type="text/css">
<!--
body {text-align:left;
	margin-left: 10px;
	margin-top: 10px;
	margin-right: 0px;
	margin-bottom: 0px;
}
img{ border:0px}
-->
</style></head>
<body>
<hr color="#CB9966" size="1">
<A target=producer_edit href="/jsp/producer/EditProducer.jsp?node=<%=teasession._nNode%>&community=<%=community%>&path=<%=path%>" >根目录</A><br/>
<%

tree1(out,file_root,path,0,community);

int rootid=0;

//自动展开
if(request.getParameter("path")!=null)
{
  path=(request.getParameter("path"));
  int len=application.getRealPath("/").length();
  out.print("<SCRIPT>var step=1;"+deploy(new java.io.File(path),community,len)+"</SCRIPT>");
}
if(request.getParameter("editproducer")!=null)
{
  out.print("<SCRIPT>window.open('/jsp/producer/EditProducer.jsp?node="+teasession._nNode+"&community="+community+"&path="+encode(path)+"','producer_edit');</SCRIPT>");
}
%>

<hr color="#CB9966" size="1">
</BODY>
</html>

