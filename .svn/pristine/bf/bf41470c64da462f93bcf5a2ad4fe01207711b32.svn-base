<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter"%>
<%@page import="tea.resource.Resource"%>
<%@page import="java.util.*"%>
<%@page import="java.net.*"%>
<%@page import="java.io.*"%>
<%@page import="tea.entity.netdisk.*"%>
<%@page import="tea.entity.admin.*"%>
<%@page import="tea.ui.TeaSession"%><%
request.setCharacterEncoding("UTF-8");
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

Resource r=new Resource("/tea/resource/NetDisk");

String base=request.getParameter("base");
String path=request.getParameter("path");
if(path==null||path.length()==0)
{
  path="/";
}

//path必须大于BASE路径///////
if(!path.startsWith(base))
{
  path=base+"/";
}


NetDiskMember obj=NetDiskMember.find(teasession._strCommunity,teasession._rv._strV,path);

File f=new File(application.getRealPath(obj.getPrefix()+path));

String name=request.getParameter("name");
boolean _bSearch=name!=null;
//String o=request.getParameter("o");
//if(o==null)
//{
//  o="name";
//}
//boolean a=Boolean.parseBoolean(request.getParameter("a"));
//boolean spic=Boolean.parseBoolean(request.getParameter("spic"));
//
//StringBuffer sql=new StringBuffer();
//sql.append(" AND path LIKE " + DbAdapter.cite(path + "_%"));
//String name=request.getParameter("name");
//String time0=request.getParameter("time0");
//String time1=request.getParameter("time1");
//String size0=request.getParameter("size0");
//String size1=request.getParameter("size1");
//boolean _bSearch=name!=null;
//if(!_bSearch)
//{
//  sql.append(" AND path NOT LIKE " + DbAdapter.cite(path + "%/_%"));
//}else
//{
//  if(name.length()>0)
//  {
//    sql.append(" AND name LIKE ").append(DbAdapter.cite("%"+name+"%"));
//  }
//
//  if(time0!=null&&time0.length()>0)
//  {
//    sql.append(" AND time>=").append(DbAdapter.cite(time0));
//  }
//
//  if(time1!=null&&time1.length()>0)
//  {
//    sql.append(" AND time<").append(DbAdapter.cite(time1));
//  }
//
//  if(size0!=null&&size0.length()>0)
//  {
//    sql.append(" AND filesize>=").append(DbAdapter.cite(size0));
//  }
//
//  if(size1!=null&&size1.length()>0)
//  {
//    sql.append(" AND filesize<").append(DbAdapter.cite(size1));
//  }
//}
//
//Enumeration e=NetDisk.find(teasession._strCommunity,sql.toString(),o,a);


String father=path.substring(0,path.lastIndexOf("/",path.length()-2)+1);

%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="/tea/tea.js" type="text/javascript"></script>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script type="">
function f_action(v,p,act)
{
  form1.action=v;
  var p_old=form1.path.value;
  if(p)
  {
    form1.path.value=p;
  }
  if(act)
  {
    if(act!='rename' && act!='newfolder'&& act!='download')
    {
      if(!submitCheckbox(form1.paths,'无效-选择'))
      {
        return ;
      }
    }
    form1.act.value=act;
    if(act=='delete')
    {
      if(!confirm('确认删除所选?'))
      {
        return;
      }
    }
  }
  if(v.indexOf("?")!=0)
  {
    form1.nexturl.value=location;
  }
  form1.submit();

  //下载文件,本页没有刷新,要改回去////////
  form1.path.value=p_old;
}
</script>
</head>
<body>

<h1><%=r.getString(teasession._nLanguage, "我的网络硬盘")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br>

<form name="form1" action="?">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>">
<input type="hidden" name="path" value="<%=path%>">
<input type="hidden" name="base" value="<%=base%>">
<input type="hidden" name="act">
<input type="hidden" name="nexturl">


<table border="0" cellpadding="0" cellspacing="0" id="tablecenter" style="cursor:hand">
  <tr align="center">
    <td onMouseOver=javascript:this.bgColor='#BCD1E9' onMouseOut=javascript:this.bgColor='' onclick="f_action('?','<%=father%>');"><img src="/tea/image/netdisk/up_big.gif"><br>
      向上</td>
    <td onMouseOver=javascript:this.bgColor='#BCD1E9' onMouseOut=javascript:this.bgColor='' onclick="f_action('?','/');"><img src="/tea/image/netdisk/home.gif"><br>
      根目录</td>
    <td onMouseOver=javascript:this.bgColor='#BCD1E9' onMouseOut=javascript:this.bgColor='' onclick="location.reload();"><img src="/tea/image/netdisk/fs_refresh.gif"><br>
      刷新</td>
    <td onMouseOver=javascript:this.bgColor='#BCD1E9' onMouseOut=javascript:this.bgColor='' onclick="f_action('NetDiskMemberNewfolder.jsp',null,'newfolder');"><img src="/tea/image/netdisk/new_folder.gif"><br>
      新建</td>
    <td onMouseOver=javascript:this.bgColor='#BCD1E9' onMouseOut=javascript:this.bgColor='' onclick="f_action('NetDiskMemberUpload.jsp');"><img src="/tea/image/netdisk/upload_big.gif"><br>
      上传</td>
    <td onMouseOver=javascript:this.bgColor='#BCD1E9' onMouseOut=javascript:this.bgColor='' onclick="f_action('/servlet/EditNetDiskMember',null,'comp')"><img src="/tea/image/netdisk/zip_big.gif"><br>
      压缩</td>
    <td onMouseOver=javascript:this.bgColor='#BCD1E9' onMouseOut=javascript:this.bgColor='' onclick="f_action('/servlet/EditNetDiskMember',null,'decomp')"><img src="/tea/image/netdisk/decompress.gif"><br>
      解压</td>
    <td onMouseOver=javascript:this.bgColor='#BCD1E9' onMouseOut=javascript:this.bgColor='' onclick="f_action('/servlet/EditNetDiskMember',null,'delete');"><img src="/tea/image/netdisk/delete_big.gif"><br>
      删除</td>
<!--    <td onMouseOver=javascript:this.bgColor='#BCD1E9' onMouseOut=javascript:this.bgColor='' onclick="f_action('/jsp/netdisk/MoveCopy.jsp',null,'move')"><img src="/tea/image/netdisk/moveto.gif"><br>
      移动</td>
    <td onMouseOver=javascript:this.bgColor='#BCD1E9' onMouseOut=javascript:this.bgColor='' onclick="f_action('/jsp/netdisk/MoveCopy.jsp',null,'copy')"><img src="/tea/image/netdisk/copyto.gif"><br>
      复制</td>
   <td onMouseOver=javascript:this.bgColor='#BCD1E9' onMouseOut=javascript:this.bgColor=''><img src="/tea/image/netdisk/download_big.gif"><br>
      下载</td>
    <td onMouseOver=javascript:this.bgColor='#BCD1E9' onMouseOut=javascript:this.bgColor=''><img src="/tea/image/netdisk/ab_search.gif"><br>
      搜索</td>
-->
<!--
    <td onMouseOver=javascript:this.bgColor='#BCD1E9' onMouseOut=javascript:this.bgColor=''><img src="/tea/image/netdisk/send.gif"><br>
      传发</td>
-->
  </tr>
</table>


<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td><%=obj.getAncestor(base)%></td>
  </tr>
</table>
<%
out.print("<table border=0 cellpadding=0 cellspacing=0 id=tablecenter><tr id=tableonetr>");
out.print("<td><input type=checkbox onClick=\"selectAll(form1.paths,this.checked);\"></td>");
out.print("<td>"+r.getString(teasession._nLanguage, "FileName"));
out.print("<td>"+r.getString(teasession._nLanguage, "Size"));
out.print("<td>"+r.getString(teasession._nLanguage, "Time"));
out.print("<td>"+r.getString(teasession._nLanguage, "Operation"));

File fs[]=f.listFiles();
if(fs==null||fs.length<1)
{
  out.print("<tr><td colspan='5' align='center' style='color:#FF0000'>暂无记录</td></tr>");
}else
{
  StringBuffer sb=new StringBuffer();
  for(int i=0;i<fs.length;i++)
  {
    name=fs[i].getName();
    String time=obj.sdf2.format(new Date(fs[i].lastModified()));
    if(fs[i].isDirectory())//文件夹
    {
      out.print("<tr onMouseOver=javascript:this.bgColor='#BCD1E9' onMouseOut=javascript:this.bgColor=''>");
      out.print("<td width=1><input name=paths type=checkbox value=\""+path+name+"/\">");
      out.print("<td><a href=\"javascript:f_action('?','"+path+name+"/');\"><img src=/tea/image/netdisk/dir.gif align=absmiddle>"+name+"</a>");
      out.print("<td>&nbsp;");
      out.print("<td>"+time);
      out.print("<td><a href=\"javascript:f_action('/jsp/netdisk/NetDiskMemberNewfolder.jsp','"+path+name+"/','rename');\"><img src=/tea/image/public/icon_edit.gif></a>");
      out.print("<a href='###' onclick=\"f_action('/jsp/netdisk/EditNetDiskShare.jsp','"+path+name+"/');\"><img src=/tea/image/netdisk/my.gif></a>");
    }else//文件
    {
      String ex=name.substring(name.lastIndexOf(".")+1);
      sb.append("<tr onMouseOver=javascript:this.bgColor='#BCD1E9' onMouseOut=javascript:this.bgColor=''>");
      sb.append("<td width=1><input name=paths type=checkbox value=\""+path+name+"/\">");
      sb.append("<td><a href=\"javascript:f_action('/servlet/EditNetDiskMember','"+path+name+"','download');\"><img src=/tea/image/netdisk/"+ex+".gif align=absmiddle>"+name+"</a>");
      sb.append("<td>"+fs[i].length()+" 字节");
      sb.append("<td>"+time);
      sb.append("<td><a href=\"javascript:f_action('/jsp/netdisk/NetDiskMemberNewfolder.jsp','"+path+name+"','rename');\"><img src=/tea/image/public/icon_edit.gif></a>");
    }
  }
  out.print(sb.toString());
}
out.print("</table>");
%>
</form>
</body>
</html>
