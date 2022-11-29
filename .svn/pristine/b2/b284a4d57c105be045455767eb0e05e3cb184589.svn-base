<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter"%>
<%@page import="tea.resource.Resource"%>
<%@page import="java.util.*"%>
<%@page import="java.net.*"%>
<%@page import="java.io.*"%><%@page import="tea.entity.*"%>
<%@page import="tea.entity.netdisk.*"%>
<%@page import="tea.entity.admin.*"%>
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

Resource r=new Resource("/tea/resource/NetDisk");

int base=0;
String tmp=request.getParameter("base");
if(tmp!=null)
{
  base=Integer.parseInt(tmp);
}
if(base==0)
{
  base=FileCenter.getRootId(teasession._strCommunity);
}

int filecenter=0;
tmp=request.getParameter("filecenter");
if(tmp!=null)
{
  filecenter=Integer.parseInt(tmp);
}
if(filecenter==0)
{
  filecenter=base;
}


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


//int pos=0;
//tmp=request.getParameter("pos");
if(tmp!=null)
{
//  pos=Integer.parseInt(tmp);
}

String prefix="/res/"+teasession._strCommunity+"/netdisk";

String o=request.getParameter("o");
if(o==null)
{
  o="make";
}
String act=request.getParameter("act");
boolean a=Boolean.parseBoolean(request.getParameter("a"));
boolean spic=Boolean.parseBoolean(request.getParameter("spic"));

StringBuffer par=new StringBuffer();
par.append("?community=").append(teasession._strCommunity);
par.append("&id=").append(strid);
par.append("&base=").append(base);
par.append("&o=").append(o).append("&a=").append(a);

StringBuffer sql=new StringBuffer();
String subject=request.getParameter("subject");
String content=request.getParameter("content");
String time0=request.getParameter("time0");
String time1=request.getParameter("time1");
String size0=request.getParameter("size0");
String size1=request.getParameter("size1");
boolean _bSearch=subject!=null;
boolean _bNew="new".equals(act);


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


par.append("&pos=");

int maxpur=-1;//当前目录下最高权限//

int cpur=FileCenterSafety.findByMember(teasession._strCommunity,teasession._rv._strV);

Enumeration e=FileCenter.find(teasession._strCommunity,sql.toString(),o,a);

%>

<script src="/tea/tea.js" type="text/javascript"></script>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">


<script type="">
function f_action(v,p,o,act,spic)
{
  form1.action=v;
  if(v.indexOf("?")!=0)
  {
    form1.method="post";
    form1.nexturl.value=location;
  }
  var p_old=form1.filecenter.value;
  if(p)
  {
    form1.filecenter.value=p;
  }

  form1.submit();

  //下载文件,本页没有刷新,要改回去////////
  form1.filecenter.value=p_old;
}
</script>


<%
//SEARCH/////////



  out.print("");

if(subject!=null)out.print("<input type=hidden name=subject value=\""+subject+"\">");
if(content!=null)out.print("<input type=hidden name=content value=\""+content+"\">");
if(time0!=null)out.print("<input type=hidden name=time0 value=\""+time0+"\">");
if(time1!=null)out.print("<input type=hidden name=time1 value=\""+time1+"\">");
if(size0!=null)out.print("<input type=hidden name=size0 value=\""+size0+"\">");
if(size1!=null)out.print("<input type=hidden name=size1 value=\""+size1+"\">");
%>
<form name="form1" action="?">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>">
<input type="hidden" name="id" value="<%=strid%>">
<input type="hidden" name="filecenter" value="<%=filecenter%>">
<input type="hidden" name="base" value="<%=base%>">
<input type="hidden" name="act" value="<%=act%>">
<input type="hidden" name="o" value="<%=o%>">
<input type="hidden" name="a" value="<%=a%>">
<input type="hidden" name="spic" value="<%=spic%>">
<%--<input type="hidden" name="pos" value="<%=pos%>">--%>
<input type="hidden" name="nexturl">
<%
//  int sum=0;
if(!e.hasMoreElements())
out.print("暂无最新文件!");
else
  while(e.hasMoreElements())
  {
    int id=((Integer)e.nextElement()).intValue();
    FileCenter nd=FileCenter.find(id);
    File f=new File(application.getRealPath(prefix+path));

    purview=FileCenterSafety.findByMember(id,teasession._rv._strV);
    if(purview!=-1)
    {
      if(purview>maxpur)
      {
        maxpur=purview;
      }
//      if(sum>=pos&&sum<pos+10)
//      {
        subject=nd.getSubject();
        out.print("<div>");


        out.print("");
        //标题

          if(purview>0)//文件
          {
            out.print("<a title=\""+MT.f(subject)+"\" href=\"javascript:f_action('/jsp/netdisk/FileCenterView.jsp','"+id+"');\" target=_self>");
          }
          if(nd.getShowtype()!=1)
          {
            out.print("<b>");
          }
          if(subject.length() > 23)
          out.print(subject.substring(0, 22) + "...");
          else
          out.print(subject);
          if(nd.getShowtype()!=1)
          {
            out.print("</b>");
          }
          out.print("</a>");
          out.print(""+nd.getMakeToString()+"</div>");

      }
//      sum++;
//    }
 }
//  if(sum>10){
//    out.print("<tr><td colspan=8 align=right>"+new FPNL(teasession._nLanguage,par.toString(),pos,sum,10));
//  }
  out.print("</form>");

out.print("<script>");
if(maxpur<3)//列表中最高权限没有"完全控制"
{
  out.print("var td_delete=document.getElementById('td_delete'); if(td_delete)td_delete.style.display='none';");
  out.print("var td_move=document.getElementById('td_move'); if(td_move)td_move.style.display='none';");
}
if(maxpur<2)//列表中最高权限没有"写入"
{
  out.print("var td_copy=document.getElementById('td_copy'); if(td_copy)td_copy.style.display='none';");
}
out.print("</script>");
%>



