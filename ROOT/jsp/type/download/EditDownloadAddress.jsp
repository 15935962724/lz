<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.resource.*"%>
<%@include file="/jsp/Header.jsp"%>
<%
Resource r = new Resource();

  String id=request.getParameter("id");


  if(request.getParameter("delete")!=null)
  {
    tea.entity.node.DownloadAddress download=   tea.entity.node.DownloadAddress.find(Integer.parseInt(id));
    download.delete(teasession._nLanguage);
  }else
  if(request.getMethod().equals("POST"))
  {
    String url=request.getParameter("url");
    String name=request.getParameter("name");
    int type=Integer.parseInt(request.getParameter("type"));
    String ver=request.getParameter("ver");
    String content=request.getParameter("content");
    int size=Integer.parseInt(request.getParameter("size"));
    if(size<1)
    {
      String url2=new String(url.getBytes("ISO-8859-1"),"UTF-8");
      if(url.startsWith("/tea/download/"))
      {
        size=(int)(new java.io.File(application.getRealPath(url)).length()/1024);
      }else
      {
        try
        {
          StringBuffer url3=new StringBuffer();
          for(int index=0;index<url2.length();index++)
          {
            String temp=String.valueOf(url2.charAt(index));
            if(temp.getBytes().length==2)
            {
              temp=java.net.URLEncoder.encode(temp,"UTF-8");
            }
            url3.append(temp);
          }
          //java.net.URLEncoder.encode(url,"GBK")
          System.out.println(url3.toString());
          java.net.URLConnection urlconn = new java.net.URL(url3.toString()).openConnection();
          size = urlconn.getContentLength()/1024;
        }catch(Exception e)
        {
        }
      }
    }else
    {
       size=size*Integer.parseInt(request.getParameter("unit"));
    }
    if (size >1)
    {
      tea.entity.node.Download obj=tea.entity.node.Download.find(teasession._nNode,teasession._nLanguage);
      if(size>obj.getSize())
      obj.setSize(size);
    }
    int language=Integer.parseInt(request.getParameter("language"));
    if(!"0".equals(id))
    {
      int idcode=Integer.parseInt(id);
      tea.entity.node.DownloadAddress download=tea.entity.node.DownloadAddress.find(idcode);
      download.set(name,url,type,ver,content,size,language);
    }else
    {
      DownloadAddress.create(teasession._nNode,name,url,type,ver,content,size,language);
    }
}


%>
<html>
<head>
<script src="/tea/tea.js" type="text/javascript"></script>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="">
function downadd(templet,name,url)
{
  count=0;
  index= url.value.indexOf("\r\n");
  while(index!=-1)
  {
    count++;
    index= url.value.indexOf("\r\n",index+1);
  }
  name.value='';
  if(url.value.charAt(url.value.length-1)!='\n')
  count++;
  for(index=0;index<count;index++)
  {
    name.value+=templet.value.replace('index',index+1)+'\r\n';
  }
}

function downadd2(templet,name,url)
{
  var index=templet.value.indexOf("\\tea\\");
  if(index!=-1)
  {
    var str=templet.value.substring(index);
    while(str!=str.replace("\\","/"))
    {
      str=str.replace("\\","/");
    }
    url.value+=str;
    index=templet.value.lastIndexOf("\\");
    var endindex=templet.value.lastIndexOf(".");
    if(endindex<index+1)
    name.value+=templet.value.substring(index+1);
    else
    name.value+=templet.value.substring(index+1,endindex);
  }
}
  </script>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "Download")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%> </div>
<form method="POST" name="form1">
  <input type="hidden" name="id" value="0"/>
  <input type="hidden" name="Node" value="<%=teasession._nNode%>"/>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td>名称:</td>
      <td><input name="name" type="text" value="官方下载" size="40"></td>
    </tr>
    <tr>
      <td>下载地址</td>
      <td><input name="url" value="http://" size="40" ></td>
    </tr>
    <tr>
      <td>版本</td>
      <td><input name="ver" value="v" ></td>
    </tr>
    <tr>
      <td>大小</td>
      <td><input name="size" value="0" >
      <select name="unit" >
	      <option value="0.0009765625"  >B
          <option value="1" selected >K
          <option value="1024" >M
        </select>
      </td>
    </tr>
    <tr>
      <td>类型</td>
      <td><select name="type" >
          <option value="0" selected >http
          <option value="1" >电骡
          <option value="2" >BT
        </select>
      </td>
    </tr>
    <tr>
      <td>内容</td>
      <td><input name="content" size="40" >
      </td>
    </tr>
    <tr>
      <td>语言</td>
      <td><select name="language" >
          <option value=-1>未知
          <%
        for(int index=0;index<tea.resource.Common.LANGUAGE.length;index++)
        {//
          out.print("<OPTION value="+index+" "+(index==1?" SELECTED ":"")+" >"+r.getString(teasession._nLanguage,tea.resource.Common.LANGUAGE[index])+"</OPTION>");
        }
        %>
        </select>
      </td>
    </tr>
    <%
    if("webmaster".equals(teasession._rv.toString()))
    {
    %>
    <tr>
      <td>附住功能 </td>
      <td><input name="file" type="file">
        <input type="button" name="" value="生成下载地址" onclick="downadd2(form1.file,form1.name,form1.url)"/>
      </td>
    </tr><%}%>
  </table>
  <input type=submit value="提交" />
  <input type="button" name="Pictureview" id="Pictureview" class="edit_button" value="<%=r.getString(teasession._nLanguage, "Pictureview")%>" onClick="window.open('/servlet/InsertPicture', '_blank');">
  <input type="button" value="<%=r.getString(teasession._nLanguage, "GoBack")%>" onclick="window.open('EditDownload.jsp?node=<%=teasession._nNode%>','_self');">
</form>
<!--input type="button" value="<%=r.getString(teasession._nLanguage, "Finish")%>" onclick="window.open('/servlet/Node?node=<%=teasession._nNode%>','_self');"-->
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <%
java.util.Enumeration enumer=  tea.entity.node.DownloadAddress.findByNode(teasession._nNode);
if(enumer!=null)
{
int idcode;
while(enumer.hasMoreElements())
{
   tea.entity.node.DownloadAddress obj= (tea.entity.node.DownloadAddress)enumer.nextElement();
//idcode=((Integer)enumer.nextElement()).intValue();
//String name=download.getName(idcode);
//String url=download.getUrl(idcode);

%>
  <tr>
    <td><%=new tea.html.Anchor(obj.getUrl(),obj.getName()+obj.getVer()).toString()%>
    <td><%=obj.getUrl()%></td>
    <td><%=obj.getLen()%></td>
    <td><input type="button" value="编辑" onclick="form1.name.value='<%=obj.getName()%>';form1.url.value='<%=obj.getUrl()%>';form1.size.value='<%=obj.getLen()%>';form1.id.value='<%=obj.getId()%>';form1.ver.value='<%=obj.getVer()%>';form1.content.value='<%=obj.getContent()%>';form1.name.focus();">
      <input type="button" value="删除" onclick="if(confirm('<%=r.getString(teasession._nLanguage, "ConfirmDelete")%>')){window.open('<%=request.getRequestURI()%>?node=<%=teasession._nNode%>&id=<%=obj.getId()%>&delete=ON','_self');}">
      <%
}
}
%>
</table>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</html>

