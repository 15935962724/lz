<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter"%>
<%@page import="tea.resource.Resource"%>
<%@page import="java.util.*"%>
<%@page import="java.net.*"%>
<%@page import="java.io.*"%>
<%@page import="tea.entity.netdisk.*"%>
<%@page import="tea.entity.admin.*"%><%@page import="tea.entity.*"%>
<%@page import="tea.entity.member.*"%>
<%@page import="tea.ui.TeaSession"%>
<%@page import="tea.htmlx.FPNL"%><%
request.setCharacterEncoding("UTF-8");
response.setHeader("Cache-Control", "no-cache");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String strid=request.getParameter("id");

Resource r=new Resource().add("/tea/resource/FileCenter");

int base=0;
String tmp=request.getParameter("base");
if(tmp!=null)base=Integer.parseInt(tmp);

if(base==0)base=FileCenter.getRootId(teasession._strCommunity);


int filecenter=0;
tmp=request.getParameter("filecenter");
if(tmp!=null)filecenter=Integer.parseInt(tmp);

if(filecenter==0)filecenter=base;



FileCenter obj=FileCenter.find(filecenter);

String path=obj.getPath();

////path必须大于BASE路径///////
if(filecenter!=base&&!path.startsWith(FileCenter.find(base).getPath()))
{
  filecenter=base;
  obj=FileCenter.find(filecenter);
  path=obj.getPath();
}

//权限校检
int purview=FileCenterSafety.findByMember(filecenter,teasession._rv._strV);
if(purview==-1)
{
  response.sendError(403);
  return;
}


int pos=0;
tmp=request.getParameter("pos");
if(tmp!=null)pos=Integer.parseInt(tmp);


String prefix="/res/"+teasession._strCommunity+"/netdisk";

String o=request.getParameter("o");
if(o==null)o="make";

String act=request.getParameter("act");
boolean a=Boolean.parseBoolean(request.getParameter("a"));
boolean spic=Boolean.parseBoolean(request.getParameter("spic"));

StringBuffer par=new StringBuffer();
par.append("?community=").append(teasession._strCommunity);
par.append("&id=").append(strid);
par.append("&base=").append(base);
par.append("&filecenter=").append(filecenter);
par.append("&o=").append(o).append("&a=").append(a);
par.append("&act=").append(act);

StringBuffer sql=new StringBuffer();
String q=request.getParameter("q");
String content=request.getParameter("content");
String code=request.getParameter("code");
String unit=request.getParameter("unit");
String adminunit=request.getParameter("adminunit");
String time0=request.getParameter("time0");
String time1=request.getParameter("time1");
String size0=request.getParameter("size0");
String size1=request.getParameter("size1");
tmp=request.getParameter("year");
int year=tmp==null?0:Integer.parseInt(tmp);

boolean _bSearch=q!=null;
boolean _bNew="new".equals(act);

if(_bNew)
{
  FileCenterSet fcs = FileCenterSet.find(teasession._strCommunity);
  //时间///
  Calendar c=Calendar.getInstance();
  c.set(c.DAY_OF_YEAR,c.get(c.DAY_OF_YEAR)-fcs.getNewday());
  sql.append(" AND type=1 AND make>").append(DbAdapter.cite(c.getTime(),true));
  //文件夹///
  tmp=fcs.getFileCenter();
  String str[]=tmp.split("/");
  if(str.length>1)
  {
    sql.append(" AND (");
    for(int i=1;i<str.length;i++)
    {
      if(i>1)
      {
        sql.append(" OR");
      }
      sql.append(" path LIKE ").append(DbAdapter.cite("%/"+str[i]+"/%"));
    }
    sql.append(")");
  }
}else if(!_bSearch)
{
  sql.append(" AND father=").append( filecenter);
}
if(_bSearch)
{
  sql.append(" AND path LIKE ").append(DbAdapter.cite(path + "_%"));
  if(q.length()>0)
  {
    sql.append(" AND subject LIKE ").append(DbAdapter.cite("%"+q+"%"));
  }
  par.append("&q=").append(URLEncoder.encode(q,"UTF-8"));

  if(code!=null&&code.length()>0)
  {
    sql.append(" AND code LIKE ").append(DbAdapter.cite("%"+code+"%"));
    par.append("&code=").append(URLEncoder.encode(code,"UTF-8"));
  }
  if(unit!=null&&unit.length()>0)
  {
    sql.append(" AND unit LIKE ").append(DbAdapter.cite("%"+unit+"%"));
    par.append("&unit=").append(URLEncoder.encode(unit,"UTF-8"));
  }
  if(adminunit!=null&&adminunit.length()>0)
  {
    sql.append(" AND member IN( SELECT member FROM AdminUsrRole WHERE unit=").append(adminunit).append(")");
    par.append("&adminunit=").append(adminunit);
  }
  if(content!=null&&content.length()>0)
  {
    sql.append(" AND content LIKE ").append(DbAdapter.cite("%"+content+"%"));
    par.append("&content=").append(URLEncoder.encode(content,"UTF-8"));
  }
  if(time0!=null&&time0.length()>0)
  {
    sql.append(" AND time>=").append(DbAdapter.cite(time0));
    par.append("&time0=").append(time0);
  }

  if(time1!=null&&time1.length()>0)
  {
    sql.append(" AND time<").append(DbAdapter.cite(time1));
    par.append("&time1=").append(time1);
  }

  if(size0!=null&&size0.length()>0)
  {
    sql.append(" AND filesize>=").append(DbAdapter.cite(size0));
    par.append("&size0=").append(size0);
  }

  if(size1!=null&&size1.length()>0)
  {
    sql.append(" AND filesize<").append(DbAdapter.cite(size1));
    par.append("&size1=").append(size1);
  }
  if(year>0)
  {
    sql.append(" AND make>").append(DbAdapter.cite(Entity.sdf.parse(year+"-01-01")));
    sql.append(" AND make<").append(DbAdapter.cite(Entity.sdf.parse((year+1)+"-01-01")));
    par.append("&year=").append(year);
  }
}
out.println("<!--"+sql.toString()+"-->");

par.append("&pos=");

int maxpur=-1;//当前目录下最高权限//

int sum=0;//数量

int cpur=FileCenterSafety.findByMember(teasession._strCommunity,teasession._rv._strV);

Enumeration e=FileCenter.find(teasession._strCommunity,sql.toString(),o,a);

%>
<HTML>
<HEAD>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type="text/javascript"></SCRIPT>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script type="">
function f_action(v,p,o,act,spic)
{
  form1.action=v;
  if(v.indexOf("?")!=0)
  {
    form1.method="post";
    form1.nexturl.value=location;
  }else
  {
    form1.pos.value=0;
  }
  var p_old=form1.filecenter.value;
  if(p)
  {
    form1.filecenter.value=p;
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
    if(act=='delete' || act=='move' || act=='copy')
    {
      if(!submitCheckbox(form1.filecenters,'无效-选择'))
      {
        return ;
      }
    }
    if(act=='delete')
    {
      if(!confirm('确认删除所选?'))
      {
        return;
      }
    }
    form1.act.value=act;
  }
  if(spic)
  {
    form1.spic.value=<%=!spic%>;
  }

  form1.submit();

  //下载文件,本页没有刷新,要改回去////////
  form1.filecenter.value=p_old;
}
</script>
</HEAD>
<body>

<h1><%=obj.getSubject()%> ( <span id="sum">0</span> )</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br>

<form name="form1" action="?">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>">
<input type="hidden" name="id" value="<%=strid%>">
<input type="hidden" name="filecenter" value="<%=filecenter%>">
<input type="hidden" name="base" value="<%=base%>">
<input type="hidden" name="act" value="<%=act%>">
<input type="hidden" name="o" value="<%=o%>">
<input type="hidden" name="a" value="<%=a%>">
<input type="hidden" name="spic" value="<%=spic%>">
<input type="hidden" name="pos" value="<%=pos%>">
<input type="hidden" name="nexturl">
<%
//SEARCH/////////
if(q!=null)out.print("<input type=hidden name=q value=\""+q+"\">");
if(content!=null)out.print("<input type=hidden name=content value=\""+content+"\">");
if(code!=null)out.print("<input type=hidden name=code value=\""+code+"\">");
if(unit!=null)out.print("<input type=hidden name=unit value=\""+unit+"\">");
if(adminunit!=null)out.print("<input type=hidden name=adminunit value=\""+adminunit+"\">");
if(time0!=null)out.print("<input type=hidden name=time0 value=\""+time0+"\">");
if(time1!=null)out.print("<input type=hidden name=time1 value=\""+time1+"\">");
if(size0!=null)out.print("<input type=hidden name=size0 value=\""+size0+"\">");
if(size1!=null)out.print("<input type=hidden name=size1 value=\""+size1+"\">");
%>
<!--<style>
.caozuoanniu img{width:18;height:18}
</style>-->
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter" style="cursor:hand" class="caozuoanniu">
  <tr align="center">
  <%
  if(!_bNew)
  {
    if(filecenter!=base)
    {
      out.print("<td onMouseOver=javascript:this.bgColor='#BCD1E9' onMouseOut=javascript:this.bgColor='' onClick=f_action('?','"+obj.getFather()+"');><img style='margin-right:3px' src=/tea/image/public/goup.gif align=absmiddle>向上</td>");
      out.print("<td onMouseOver=javascript:this.bgColor='#BCD1E9' onMouseOut=javascript:this.bgColor='' onClick=f_action('?','"+base+"');><img style='margin-right:3px' src=/tea/image/public/main.gif  align=absmiddle>根目录</td>");
    }
  }
  out.print("<td onMouseOver=javascript:this.bgColor='#BCD1E9' onMouseOut=javascript:this.bgColor='' onClick=location.reload();><img style='margin-right:3px' src=/tea/image/public/reload.gif  align=absmiddle>刷新</td>");
  if(!_bNew)
  {
    if(purview>2)
    {
      out.print("<td onMouseOver=javascript:this.bgColor='#BCD1E9' onMouseOut=javascript:this.bgColor='' onClick=f_action('/jsp/netdisk/EditFileCenter.jsp',null,null,'newfolder');><img style='margin-right:3px' src=/tea/image/public/newbuild.gif align=absmiddle>新建</td>");
    }
    if(purview>1)
    {
      out.print("<td onMouseOver=javascript:this.bgColor='#BCD1E9' onMouseOut=javascript:this.bgColor='' onClick=f_action('/jsp/netdisk/EditFileCenter.jsp',null,null,'upload');><img style='margin-right:3px' src=/tea/image/public/upload.gif align=absmiddle>上传</td>");
      /*
      <td onMouseOver=javascript:this.bgColor='#BCD1E9' onMouseOut=javascript:this.bgColor='' onclick="f_action('/servlet/EditFileCenter',null,null,'comp')"><img src="/tea/image/netdisk/zip_big.gif">压缩</td>
      <td onMouseOver=javascript:this.bgColor='#BCD1E9' onMouseOut=javascript:this.bgColor='' onclick="f_action('/servlet/EditFileCenter',null,null,'decomp')"><img src="/tea/image/netdisk/decompress.gif">解压</td>
      */
    }
  }
  if(cpur>3)
  {
    out.print("<td id=td_delete onMouseOver=javascript:this.bgColor='#BCD1E9' onMouseOut=javascript:this.bgColor='' onClick=f_action('/servlet/EditFileCenter',null,null,'delete');><img style='margin-right:3px' src=/tea/image/public/delte.gif align=absmiddle>删除</td>");
    out.print("<td id=td_move onMouseOver=javascript:this.bgColor='#BCD1E9' onMouseOut=javascript:this.bgColor='' onClick=f_action('/jsp/netdisk/FileCenterMoveCopy.jsp',null,null,'move');><img style='margin-right:3px' src=/tea/image/public/move.gif align=absmiddle>移动</td>");
  }
  if(cpur>2)
  {
    out.print("<td id=td_copy onMouseOver=javascript:this.bgColor='#BCD1E9' onMouseOut=javascript:this.bgColor='' onClick=f_action('/jsp/netdisk/FileCenterMoveCopy.jsp',null,null,'copy');><img style='margin-right:3px' src=/tea/image/public/copy.gif align=absmiddle>复制</td>");
  }
/*
<td onMouseOver=javascript:this.bgColor='#BCD1E9' onMouseOut=javascript:this.bgColor=''><img src="/tea/image/netdisk/download_big.gif">下载</td>
<td onMouseOver=javascript:this.bgColor='#BCD1E9' onMouseOut=javascript:this.bgColor='' onClick="f_action('?',null,null,null,true);"><img src="/tea/image/netdisk/spic.gif"><%=spic?"列表":"缩略图"% ></td>
*/
//if(!_bNew)
{
  out.print("<td onMouseOver=javascript:this.bgColor='#BCD1E9' onMouseOut=javascript:this.bgColor='' onClick=f_action('/jsp/netdisk/FileCenterSearch.jsp',null,null,null,true);><img style='margin-right:3px' src=/tea/image/public/research.gif align=absmiddle>搜索</td>");
}

  //<td onMouseOver=javascript:this.bgColor='#BCD1E9' onMouseOut=javascript:this.bgColor=''><img src="/tea/image/netdisk/send.gif"><br>传发</td>
%>
</tr>
</table>


<%
if(!_bNew)
{
  out.print("<table border=0 cellpadding=0 cellspacing=0 id=tablecenter><tr><td>"+obj.getAncestor("?id="+strid,base)+"</td></tr></table>");
}

if(spic)
{
  out.print("<table border=0 cellpadding=0 cellspacing=0 id=tablecenter><tr><td>");

  while(e.hasMoreElements())
  {
    int id=((Integer)e.nextElement()).intValue();
    FileCenter nd=FileCenter.find(id);

    purview=FileCenterSafety.findByMember(id,teasession._rv._strV);
    if(purview!=-1)
    {
      if(purview>maxpur)
      {
        maxpur=purview;
      }
      String subject=nd.getSubject();
      out.print("<div id=skeletonize>");
      out.print("<img src=/tea/image/netdisk/"+(nd.isType()?"file":"dir")+"_big.gif>");
      out.print("<br><input name=filecenters type=checkbox value=\""+id+"\"");
      if(purview<1)out.print(" disabled ");
      out.print(">");
      if(!nd.isType())
      {
        out.print("<a href=\"javascript:f_action('?','"+id+"')\">");
      }else if(purview>0)
      {
        out.print("<a href=\"javascript:f_action('/jsp/netdisk/FileCenterView.jsp','"+id+"');\">");
      }
      out.print(subject+"</a></div>");
    }
  }
  out.print("</td></tr></table>");
}else
{
  out.print("<table border=0 cellpadding=0 cellspacing=0 id=tablecenter><tr id=tableonetr>");
  out.print("<td nowrap>序号</td>");
  out.print("<td nowrap><input type=checkbox onClick=\"selectAll(form1.filecenters,this.checked);\"></td>");
  out.print("<td nowrap><a href=javascript:f_action('?',null,'subject')>"+r.getString(teasession._nLanguage, "标题")+"</a>");
  if(o.equals("subject"))out.print(a?"↑":"↓");

  out.print("<td nowrap><a href=javascript:f_action('?',null,'code')>"+r.getString(teasession._nLanguage, "文件编号")+"</a>");
  if(o.equals("code"))out.print(a?"↑":"↓");

  out.print("<td nowrap><a href=javascript:f_action('?',null,'make')>"+r.getString(teasession._nLanguage, "下发日期")+"</a>");
  if(o.equals("make"))out.print(a?"↑":"↓");

  out.print("<td nowrap><a href=javascript:f_action('?',null,'unit')>"+r.getString(teasession._nLanguage, "编制部门")+"</a>");
  if(o.equals("unit"))out.print(a?"↑":"↓");

  out.print("<td nowrap><a href=javascript:f_action('?',null,'valid')>"+r.getString(teasession._nLanguage, "有效性")+"</a>");
  if(o.equals("valid"))out.print(a?"↑":"↓");
  if(cpur>1)
  {
    out.print("<td nowrap>"+r.getString(teasession._nLanguage, "操作"));
  }

  while(e.hasMoreElements())
  {
    int id=((Integer)e.nextElement()).intValue();
    FileCenter nd=FileCenter.find(id);
    File f=new File(application.getRealPath(prefix+path));
    //Profile p = Profile.find(nd.getMember());
    purview=FileCenterSafety.findByMember(id,teasession._rv._strV);
    if(purview!=-1)
    {
      if(purview>maxpur)
      {
        maxpur=purview;
      }
      if(sum>=pos&&sum<pos+10)
      {
        String subject=nd.getSubject();
        if(q!=null)
        {
          subject=subject.replaceAll(q,"<FONT COLOR=RED>"+q+"</FONT>");
        }
        out.print("<tr onMouseOver=javascript:this.bgColor='#BCD1E9' onMouseOut=javascript:this.bgColor=''>");
        out.print("<td width=20 align=center>"+(sum+1)+"</td>");
        out.print("<td width=1><input name=filecenters type=checkbox value=\""+id+"\"");
        if(purview<1)out.print(" disabled ");
        out.print(">");
        out.print("<td>");
        if(!nd.isType())//文件夹
        {
          out.print("<a href=\"javascript:f_action('?','"+id+"')\"><img src=/tea/image/netdisk/dir.gif align=absmiddle style=margin-right:10px>"+subject+"</a>");
          out.print("<td>&nbsp;<td>&nbsp;<td>&nbsp;<td>&nbsp;");
        }else
        {
          if(purview>0)//文件
          {
            out.print("<a href=\"javascript:f_action('/jsp/netdisk/FileCenterView.jsp','"+id+"');\">");
          }
          out.print(subject+"</a>");
          String ndc=nd.getCode();
          out.print("<td align=center>&nbsp;");
          if(ndc!=null)out.print(ndc);
          out.print("<td align=center nowrap>&nbsp;"+nd.getMakeToString());
          out.print("<td align=center nowrap>&nbsp;");
          String ndu=nd.getUnit();
          if(ndu!=null)out.print(ndu);
          out.print("<td align=center>&nbsp;"+(nd.isValid()?"√":"X"));
        }
        if(cpur>2)
        {
          out.print("<td align=center nowrap>&nbsp;");
          if(purview>2)
          {
            out.print("<a title='修改文件' style='margin-right:5px' href=javascript:f_action('/jsp/netdisk/EditFileCenter.jsp','"+id+"',null,'edit')><img src=/tea/image/public/icon_edit.gif></a>");
            out.print("<a title='查看阅读情况' href='/jsp/netdisk/FileYNread1.jsp?bullid="+id+"'><img src=/tea/image/public/eye.gif></a>");
          }
        }
      }
      sum++;
    }
  }
  out.print("<tr><td colspan=8 align=right>"+new FPNL(teasession._nLanguage,par.toString(),pos,sum,10));
  out.print("</table>");
}

out.print("<script>");
if(maxpur<4)//列表中最高权限没有"完全控制"
{
  out.print("var td_delete=document.getElementById('td_delete'); if(td_delete)td_delete.style.display='none';");
  out.print("var td_move=document.getElementById('td_move'); if(td_move)td_move.style.display='none';");
}
//最新文件,没有移动或删除,也不显示复制
if(maxpur<(_bNew?4:3))//列表中最高权限没有"写入"
{
  out.print("var td_copy=document.getElementById('td_copy'); if(td_copy)td_copy.style.display='none';");
}
out.print("document.getElementById('sum').innerHTML="+sum+";");
out.print("</script>");
%>
</form>

</body>
</html>
