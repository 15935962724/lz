<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.resource.Resource" %>
<%@page import="tea.entity.util.*" %>
<%@page import="tea.entity.netdisk.*" %>
<%@page import="tea.ui.*" %>
<%@page import="java.io.*" %>


<%!
private void  tree1(Writer jw,File file,int step,int len,String member,String community)throws Exception
{
  File files[]=file.listFiles(new FilenameFilter()
  {
    public boolean accept(File dir, String name)
    {
      return new File(dir,name).isDirectory();
    }
  });
  if(files!=null)
  for(int i=0;i<files.length;i++)
  {
    int j=files[i].hashCode();
    String path=files[i].getAbsolutePath().substring(len).replaceAll("\\\\","/")+"/";
    //同步/////////////
    NetDisk nd = NetDisk.find(community, path);
    if (!nd.isExists())
    {
      NetDisk.create(community, path, member, false, "",0);
    }
    for(int loop=1;loop<step;loop++)
    {
      jw.write("　");
    }
    if(step>0)jw.write("　");

    tea.html.Anchor a=new tea.html.Anchor("###","<IMG SRC=/tea/image/tree/tree_plus.gif BORDER=0 align=absmiddle ID=img"+j+" />"+ files[i].getName());
    a.setOnClick("fclick('"+j+"','"+java.net.URLEncoder.encode(path,"UTF-8")+"')");
    jw.write(a.toString());
    jw.write("<br/>");
    jw.write("<Div id=\"divid"+j+"\" style=display:none>");
    tree1(jw,files[i],++step,len,member,community);
    jw.write("</Div>");
    step--;
  }
}
%>

<%
TeaSession teasession = new TeaSession(request);
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String community=teasession._strCommunity;

String prefix="/res/"+community+"/netdisk/";
File dir = new File(application.getRealPath(prefix));

%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
  <script src="/tea/tea.js" type="text/javascript"></script>
  <script type="">
  function fclick(j,path)
  {
    var div=document.all('divid'+j);
    if(div.style.display=='')
    {
      div.style.display='none';
      document.all('img'+j).src='/tea/image/tree/tree_plus.gif';
    }else
    {
      div.style.display='';
      document.all('img'+j).src='/tea/image/tree/tree_minus.gif';
    };//
    window.open('/jsp/netdisk/Safetys.jsp?path='+path,'NetDiskMainFrame');
  }
  </script>
  <style>
		body		{
	text-align: left;
	margin-left: 10px;
	margin-top: 10px;
	margin-right: 10px;
	margin-bottom: 10px;
}
  </style>
</head>
<body style="font-size:9pt; " align=left>

<img src="/tea/image/other/img-globe.gif" width="16" height="16">
<a href="/jsp/netdisk/Safetys.jsp?path=/" target="NetDiskMainFrame" >根目录</a><br>
<div style="padding-left:3px">
<%
tree1(out,dir,0,dir.getAbsolutePath().length(),teasession._rv._strV,teasession._strCommunity);
%>
</div>

</body>
</html>
