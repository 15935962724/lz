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

//权限校检
int purview=Safety.findByMember(teasession._strCommunity,path,teasession._rv._strV);
if(purview==-1)
{
  response.sendError(403);
  return;
}


NetDisk obj=NetDisk.find(teasession._strCommunity,path);

String prefix="/res/"+teasession._strCommunity+"/netdisk";
//刷新//////////////////////////
File f=new File(application.getRealPath(prefix+path));
obj.refresh(f);



String o=request.getParameter("o");
if(o==null)
{
  o="name";
}
boolean a=Boolean.parseBoolean(request.getParameter("a"));
boolean spic=Boolean.parseBoolean(request.getParameter("spic"));

StringBuffer sql=new StringBuffer();
sql.append(" AND path LIKE " + DbAdapter.cite(path + "_%"));
String name=request.getParameter("name");
String time0=request.getParameter("time0");
String time1=request.getParameter("time1");
String size0=request.getParameter("size0");
String size1=request.getParameter("size1");
boolean _bSearch=name!=null;
if(!_bSearch)
{
  sql.append(" AND path NOT LIKE " + DbAdapter.cite(path + "%/_%"));
}else
{
  if(name.length()>0)
  {
    sql.append(" AND name LIKE ").append(DbAdapter.cite("%"+name+"%"));
  }

  if(time0!=null&&time0.length()>0)
  {
    sql.append(" AND time>=").append(DbAdapter.cite(time0));
  }

  if(time1!=null&&time1.length()>0)
  {
    sql.append(" AND time<").append(DbAdapter.cite(time1));
  }

  if(size0!=null&&size0.length()>0)
  {
    sql.append(" AND filesize>=").append(DbAdapter.cite(size0));
  }

  if(size1!=null&&size1.length()>0)
  {
    sql.append(" AND filesize<").append(DbAdapter.cite(size1));
  }
}

Enumeration e=NetDisk.find(teasession._strCommunity,sql.toString(),o,a);

%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="/tea/tea.js" type="text/javascript"></script>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script type="">
function f_action(v,p,o,act,spic)
{
  form1.action=v;
  var p_old=form1.path.value;
  if(p)
  {
    form1.path.value=p;
  }
  if(o)
  {
    if(form1.o.value==o)
    {
      form1.a.value=<%=!a%>;
    }else
    {
      form1.o.value=o;
    }
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
  if(spic)
  {
    form1.spic.value=<%=!spic%>;
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

<h1><%=r.getString(teasession._nLanguage, "文件中心")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br>

<form name="form1" action="?">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>">
<input type="hidden" name="path" value="<%=path%>">
<input type="hidden" name="base" value="<%=base%>">
<input type="hidden" name="act">
<input type="hidden" name="o" value="<%=o%>">
<input type="hidden" name="a" value="<%=a%>">
<input type="hidden" name="spic" value="<%=spic%>">
<input type="hidden" name="nexturl">
<%
//SEARCH/////////
if(name!=null)out.print("<input type=hidden name=name value=\""+name+"\">");
if(time0!=null)out.print("<input type=hidden name=time0 value=\""+time0+"\">");
if(time1!=null)out.print("<input type=hidden name=time1 value=\""+time1+"\">");
if(size0!=null)out.print("<input type=hidden name=size0 value=\""+size0+"\">");
if(size1!=null)out.print("<input type=hidden name=size1 value=\""+size1+"\">");
%>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter" style="cursor:hand">
  <tr align="center">
    <td onMouseOver=javascript:this.bgColor='#BCD1E9' onMouseOut=javascript:this.bgColor='' onclick="f_action('?','<%=obj.getParent()%>');"><img src="/tea/image/netdisk/up_big.gif"><br>
      向上</td>
    <td onMouseOver=javascript:this.bgColor='#BCD1E9' onMouseOut=javascript:this.bgColor='' onclick="f_action('?','/');"><img src="/tea/image/netdisk/home.gif"><br>
      根目录</td>
    <td onMouseOver=javascript:this.bgColor='#BCD1E9' onMouseOut=javascript:this.bgColor='' onclick="location.reload();"><img src="/tea/image/netdisk/fs_refresh.gif"><br>
      刷新</td>
    <%
    if(purview>=2)
    {
    %>
    <td onMouseOver=javascript:this.bgColor='#BCD1E9' onMouseOut=javascript:this.bgColor='' onclick="f_action('Newfolder.jsp',null,null,'newfolder');"><img src="/tea/image/netdisk/new_folder.gif"><br>
      新建</td>
    <td onMouseOver=javascript:this.bgColor='#BCD1E9' onMouseOut=javascript:this.bgColor='' onclick="f_action('Upload.jsp');"><img src="/tea/image/netdisk/upload_big.gif"><br>
      上传</td>
    <td onMouseOver=javascript:this.bgColor='#BCD1E9' onMouseOut=javascript:this.bgColor='' onclick="f_action('/servlet/EditNetDisk',null,null,'comp')"><img src="/tea/image/netdisk/zip_big.gif"><br>
      压缩</td>
    <td onMouseOver=javascript:this.bgColor='#BCD1E9' onMouseOut=javascript:this.bgColor='' onclick="f_action('/servlet/EditNetDisk',null,null,'decomp')"><img src="/tea/image/netdisk/decompress.gif"><br>
      解压</td>
    <%}
    if(purview==3)
    {
    %>
    <td onMouseOver=javascript:this.bgColor='#BCD1E9' onMouseOut=javascript:this.bgColor='' onclick="f_action('/servlet/EditNetDisk',null,null,'delete');"><img src="/tea/image/netdisk/delete_big.gif"><br>
      删除</td>
    <%}%>
    <td onMouseOver=javascript:this.bgColor='#BCD1E9' onMouseOut=javascript:this.bgColor='' onclick="f_action('/jsp/netdisk/MoveCopy.jsp',null,null,'move')"><img src="/tea/image/netdisk/moveto.gif"><br>
      移动</td>
    <td onMouseOver=javascript:this.bgColor='#BCD1E9' onMouseOut=javascript:this.bgColor='' onclick="f_action('/jsp/netdisk/MoveCopy.jsp',null,null,'copy')"><img src="/tea/image/netdisk/copyto.gif"><br>
      复制</td>
<!--    <td onMouseOver=javascript:this.bgColor='#BCD1E9' onMouseOut=javascript:this.bgColor=''><img src="/tea/image/netdisk/download_big.gif"><br>
      下载</td>
    <td onMouseOver=javascript:this.bgColor='#BCD1E9' onMouseOut=javascript:this.bgColor=''><img src="/tea/image/netdisk/ab_search.gif"><br>
      搜索</td>
-->
    <td onMouseOver=javascript:this.bgColor='#BCD1E9' onMouseOut=javascript:this.bgColor='' onclick="f_action('?',null,null,null,true);"><img src="/tea/image/netdisk/spic.gif"><br>
    <%=spic?"列表":"缩略图"%></td>
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
if(spic)
{
  out.print("<table border=0 cellpadding=0 cellspacing=0 id=tablecenter><tr><td>");
  while(e.hasMoreElements())
  {
    path=(String)e.nextElement();
    NetDisk nd=NetDisk.find(teasession._strCommunity,path);
    //如果是搜索////
    if(_bSearch)
    {
      purview=Safety.findByMember(teasession._strCommunity,nd.getParent(),teasession._rv._strV);
    }
    if(purview!=-1)
    {
      name=nd.getName();
      out.print("<div id=skeletonize \">");
      out.print("<a title=\""+nd.getContentToHtml()+"\" href=\"javascript:");
      if(!nd.isType())
      {
        out.print("f_action('?','"+path+"')\"><img src=/tea/image/netdisk/dir.gif align=absmiddle>"+name);
      }else
      {
        if(purview==0)
        {
          out.print("alert('无权下载');\"><img src=/tea/image/netdisk/"+nd.getEx()+".gif>");
        }else
        {
          out.print("f_action('/servlet/EditNetDisk','"+path+"',null,'download');");
          if(name.endsWith(".jpg")||name.endsWith(".gif")||name.endsWith(".png")||name.endsWith(".bmp"))
          {
            out.print("\"><img src=\""+path+"\" width=100 height=100>");
          }else
          {
            out.print("\"><img src=/tea/image/netdisk/"+nd.getEx()+".gif>");
          }
        }
        out.print("<br>"+nd.getFileSize()+" 字节");
      }
      out.print("<br><input name=paths type=checkbox value=\""+path+"\"");
      if((nd.isType()&&purview<1)||(!nd.isType()&&Safety.findByMember(teasession._strCommunity,path,teasession._rv._strV)<1))out.print(" disabled ");
      out.print(">"+name);
      out.print("</a></div>");
    }
  }
  out.print("</td></tr></table>");
}else
{
  out.print("<table border=0 cellpadding=0 cellspacing=0 id=tablecenter><tr id=tableonetr>");
  out.print("<td><input type=checkbox onClick=\"selectAll(form1.paths,this.checked);\"></td>");
  out.print("<td><a href=javascript:f_action('?',null,'name')>"+r.getString(teasession._nLanguage, "FileName")+"</a>");
  if(o.equals("name"))out.print(a?"↓":"↑");
  out.print("<td><a href=javascript:f_action('?',null,'filesize')>"+r.getString(teasession._nLanguage, "Size")+"</a>");
  if(o.equals("filesize"))out.print(a?"↓":"↑");
  out.print("<td><a href=javascript:f_action('?',null,'time')>"+r.getString(teasession._nLanguage, "Time")+"</a>");
  if(o.equals("time"))out.print(a?"↓":"↑");
  out.print("<td>"+r.getString(teasession._nLanguage, "Operation"));

  while(e.hasMoreElements())
  {
    path=(String)e.nextElement();
    NetDisk nd=NetDisk.find(teasession._strCommunity,path);
    f=new File(application.getRealPath(prefix+path));
    if(!f.exists())
    {
      nd.delete();
      continue;
    }
    //如果是搜索////
    if(_bSearch)
    {
      purview=Safety.findByMember(teasession._strCommunity,nd.getParent(),teasession._rv._strV);
    }
    if(purview!=-1)
    {
      int pur2=-1;
      if(nd.isType())
      {
        pur2=purview;
      }else
      {
        pur2=Safety.findByMember(teasession._strCommunity,path,teasession._rv._strV);
      }
      name=nd.getName();
      out.print("<tr onMouseOver=javascript:this.bgColor='#BCD1E9' onMouseOut=javascript:this.bgColor=''>");
      out.print("<td width=1><input name=paths type=checkbox value=\""+path+"\"");
      if(pur2<1)out.print(" disabled ");
      out.print(">");
      out.print("<td><a title=\""+nd.getContentToHtml()+"\" href=\"javascript:");
      if(!nd.isType())//文件夹
      {
        out.print("f_action('?','"+path+"')\"><img src=/tea/image/netdisk/dir.gif align=absmiddle>"+name+"</a>");
        out.print("<td>&nbsp;");
      }else//文件
      {
        if(purview==0)
        {
          out.print("alert('无权下载');");
        }else
        {
          out.print("f_action('/servlet/EditNetDisk','"+path+"',null,'download');");
        }
        out.print("\"><img src=/tea/image/netdisk/"+nd.getEx()+".gif align=absmiddle>"+name+"</a>");
        out.print("<td>"+nd.getFileSize()+" 字节");
      }
      out.print("<td>"+nd.getTimeToString());
      out.print("<td>&nbsp;");
      if(pur2>1)out.print("<a href=\"javascript:f_action('/jsp/netdisk/Newfolder.jsp','"+path+"',null,'rename')\"><img src=/tea/image/public/icon_edit.gif></a>");
    }
  }
  out.print("</table>");
}
%>


</form>

</body>
</html>
