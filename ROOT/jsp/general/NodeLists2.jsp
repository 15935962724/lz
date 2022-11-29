<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.entity.member.*"%>
<%@page import="tea.entity.site.*"%>
<%@page import="tea.resource.Resource"%>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.ui.TeaSession" %>
<%@page import="java.util.*" %>
<%@page import="java.net.*" %><%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}
Resource r=new Resource("/tea/resource/AdminList");
r.add("/tea/resource/Report");

if("POST".equals(request.getMethod()))
{
  String ns[]=request.getParameterValues("nodes");
  String act=request.getParameter("act");
  String nexturl=request.getParameter("nexturl");
  int father=Integer.parseInt(request.getParameter("father"));
  int options=Integer.parseInt(request.getParameter("options"));
  int ok=0,err=0;
  if("clone".equals(act))
  {
    for(int i=0;i<ns.length;i++)
    {
      ok+= Node.clone(Integer.parseInt(ns[i]),father,true,true,options,teasession._rv,null);
    }
  }else if("move".equals(act))
  {
    Node node=Node.find(Integer.parseInt(ns[0]));
    Node node1=Node.find(father);
    if(node1.getPath().startsWith(node.getPath()))
    {
      response.sendRedirect("/jsp/info/Alert.jsp?info=" + java.net.URLEncoder.encode(r.getString(teasession._nLanguage,"InvalidNewFather"),"UTF-8"));
      return;
    }
    for(int i=0;i<ns.length;i++)
    {
      node=Node.find(Integer.parseInt(ns[i]));
      ok+= node.move(father,options==2);
    }
  }else if("delete".equals(act))
  {
    for(int i=0;i<ns.length;i++)
    {
      int nid=Integer.parseInt(ns[i]);
      Node n=Node.find(nid);
      int pur=n.isCreator(teasession._rv)?3:AccessMember.find(nid,teasession._rv._strV).getPurview();
      if(pur>2)
      {
        n.delete(teasession._nLanguage);
        ok++;
      }else
      {
        err++;
      }
    }
  }else if("grant".equals(act)||"deny".equals(act))
  {
    for(int i=0;i<ns.length;i++)
    {
      int nid=Integer.parseInt(ns[i]);
      Node n=Node.find(nid);
      if(n.isHidden()&&AccessMember.find(nid,teasession._rv._strV).isAuditing())
      {
        if("deny".equals(act))
        {
          n.deny();
        }else
        {
          n.setHidden(false);
        }
        ok++;
      }else
      {
        err++;
      }
    }
  }else if("recommend".equals(act))//手动列举
  {
    String ls[] = teasession.getParameter("listing").split("/");
    for(int i = 0;i < ns.length;i++)
    {
      for(int j = 1;j < ls.length;j++)
      {
        Listed.create(Integer.parseInt(ns[i]),Integer.parseInt(ls[j]),null);
      }
    }
  }
  StringBuilder sb=new StringBuilder();
  if(err==0)
  {
    sb.append(r.getString(teasession._nLanguage,"UpdateSuccessful"));
  }else
  {
    sb.append("操作成功:").append(ok).append("\\n");
    sb.append("操作失败:").append(err);
  }
  out.print("<script>alert('"+sb.toString()+"'); location.replace('"+nexturl+"');</script>");
  //response.sendRedirect(nexturl);
  return;
}

String strid=request.getParameter("id");
String tmp=request.getParameter("type");
int type=tmp==null?-1:Integer.parseInt(tmp);

int pos=0,size=30;
tmp=request.getParameter("pos");
if(tmp!=null)
{
  pos=Integer.parseInt(tmp);
}

Node n=Node.find(teasession._nNode);
String path=n.getPath();
if(path==null)
{
  response.setStatus(404);
  return;
}

String member=teasession._rv._strV;


int tatype=type;
if(tatype>65534)
{
  tatype=TypeAlias.find(tatype).getType();
}
CommunityAdminList cal=CommunityAdminList.find(teasession._strCommunity,tatype);
String fs[]=cal.getField().split("/");


boolean me="true".equals(request.getParameter("me"));

StringBuffer sql=new StringBuffer();
StringBuffer par=new StringBuffer();
par.append("?node=").append(teasession._nNode);
if(type!=-1)
{
  sql.append(" AND path LIKE ").append(DbAdapter.cite(path+"_%"));
  sql.append(" AND type=").append(type);
  par.append("&type=").append(type);
}else
{
  sql.append(" AND father=").append(teasession._nNode);
}
par.append("&id=").append(strid);
if(me)
{
  sql.append(" AND vcreator=").append(DbAdapter.cite(member));
  par.append("&me=").append(me);
}
int father=-1;
tmp=request.getParameter("father");
if(tmp!=null&&tmp.length()>0)
{
  father=Integer.parseInt(tmp);
  sql.append(" AND path LIKE ").append(DbAdapter.cite("%/"+father+"/%"));
}else
{
  father=teasession._nNode;
}

String subject=request.getParameter("subject");
String content=request.getParameter("content");
if(subject!=null||content!=null)
{//
  sql.append(" AND EXISTS ( SELECT nl.node FROM NodeLayer nl WHERE n.node=nl.node AND nl.language=").append(teasession._nLanguage);
  if(subject!=null&&subject.length()>0)
  {
    sql.append(" AND subject LIKE ").append(DbAdapter.cite("%"+subject+"%"));
    par.append("&subject=").append(URLEncoder.encode(subject,"UTF-8"));
  }
  if(content!=null&&content.length()>0)
  {
    sql.append(" AND content LIKE ").append(DbAdapter.cite("%"+content+"%"));
    par.append("&content=").append(URLEncoder.encode(content,"UTF-8"));
  }
  sql.append(")");
}
par.append("&pos=");


int count=Node.count(sql.toString());
sql.append(" ORDER BY ").append(cal.getSortType()).append(" ").append("DESC");

//下拉菜单////
int fsize=0,flen=path.split("/").length+1;
StringBuffer fsb=new StringBuffer();
if(type!=-1)
{
  fsb.append("<td>分类:");
  fsb.append("<select name='father' ><option value=''>-----------------------");
  Enumeration fe=Node.find(" AND path LIKE "+DbAdapter.cite(path+"%")+" AND type<2 AND father!=0 ORDER BY path",0,200);
  while(fe.hasMoreElements())
  {
    int id=((Integer)fe.nextElement()).intValue();
    Node obj=Node.find(id);
    fsb.append("<option value="+id);
    if(id==father)
    {
      fsb.append(" selected='' ");
    }
    fsb.append(">");
    for(int j=obj.getPath().split("/").length;j>flen;j--)
    {
      fsb.append("　");
    }
    fsb.append(obj.getSubject(teasession._nLanguage));
    fsize++;
  }
  fsb.append("</select>");
}

if(tatype==-1)
{
  tatype=n.getType()==1?Category.find(teasession._nNode).getCategory():0;
}
String url=tatype==0?"/jsp/general/EditNode.jsp":tatype<1024?"/jsp/type/"+Node.NODE_TYPE[tatype].toLowerCase()+"/Edit"+Node.NODE_TYPE[tatype]+".jsp":"/jsp/type/dynamicvalue/EditDynamicValue.jsp";

n=Node.find(father);

AccessMember am=AccessMember.find(father,member);

out.print("<!--"+sql.toString()+"-->");

%>
<!--
参数说明:
me: true|false 选填
type:  有:此类型的所有节点(包括孙子节点),无:列出所有子节点
-->
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script>
function f_gd(id)
{
  selectValue(form2.nodes,id);
  form2.nexturl.value=location.pathname+location.search;
  form2.action="/servlet/GrantNodeRequests";
}
function f_new()
{
  form2.nexturl.value=location.pathname+location.search;
  form2.submit();
}
function f_load()
{

}
function f_act(act)
{
  if(!submitCheckbox(form2.nodes,'<%=r.getString(teasession._nLanguage, "InvalidSelect")%>'))return;
  if(act=="clone"||act=="move")
  {
    var rs=window.showModalDialog('/jsp/general/SelNode.jsp?info='+encodeURIComponent(act=='clone'?'复制到':'移动到'),self,'scroll:0;status:0;help:0;resizable:1;dialogWidth:600px;dialogHeight:400px;');
    if(!rs)return;
    var arr=rs.split(",");
    form2.father.value=arr[0];
    form2.options.value=arr[1];
  }else if(act=="delete")
  {
    var rs=window.confirm('<%=r.getString(teasession._nLanguage, "ConfirmDeleteTree")%>');
    if(!rs)return;
  }else if(act=="recommend")
  {
    var t;
    var ns=form2.nodes;
    if(!ns.length)ns=new Array(ns);
    for(var i=0;i<ns.length;i++)
    {
      var j=parseInt(ns[i].getAttribute('ntype'));
      if(i!=0&&t!=j)
      {
        t=255;
        break;
      }
      t=j;
    }
    var d=window.showModalDialog('/jsp/listing/SelListing.jsp?type='+t+'&info='+encodeURIComponent("<%=r.getString(teasession._nLanguage,"CBRecommend")%>"),self,'scroll:0;status:0;help:0;resizable:1;dialogWidth:600px;dialogHeight:420px;');
    if(!d)return;
    eval("d="+d);
    if((d.listing+d.node).length<3)return;
    form2.listing.value=d.listing;
  }
  form2.nexturl.value=location.pathname+location.search;
  form2.act.value=act;
  form2.submit();
}
</script>

</head>
<body>
<h1><%=n.getSubject(teasession._nLanguage)%>
<%
if(type==-1)
{
  out.print(n.getAncestor(teasession._nLanguage));
  out.print("<style type='text/css'>#NodeListsIDfather{display:none}</style>");
}
%>
</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<h2>查询</h2>
<form  name="form1" action="?">
<input type='hidden' name="node" value="<%=teasession._nNode%>">
<input type='hidden' name="type" value="<%=type%>">
<input type='hidden' name="id" value="<%=strid%>">
<input type='hidden' name="me" value="<%=me%>">

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr>
  <td>主题:<input type="text" name="subject" value="<%if(subject!=null)out.print(subject);%>"/></td>
  <td nowrap>内容:
    <input type="text" name="content" value="<%if(content!=null)out.print(content);%>"/></td>
  <%if(fsize>1)out.print(fsb.toString());%>
  <td><input type="submit" value="GO"/></td>
</tr>
</table>
</form>

<h2><%=r.getString(teasession._nLanguage, "列表")+" - "+count%></h2>
<form name="form2" action="?" method="post">
<input type='hidden' name="id" value="<%=strid%>">
<input type='hidden' name="nexturl">
<input type='hidden' name="father" value="0">
<input type='hidden' name="act">
<input type='hidden' name="options" value="0">
<input type='hidden' name="listing">

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr id=tableonetr>
  <td>&nbsp;</td>
<%
for(int i=1;i<fs.length;i++)
{
  String name;
  if("/father/time/subject/content/".indexOf(fs[i])!=-1)
  {
    name="Node";
  }else
  {
    name=(type<1024?Node.NODE_TYPE[type]:"Dynamic");
  }
  out.print("<td id=NodeListsID"+fs[i]+" nowrap='nowrap' >"+r.getString(teasession._nLanguage,name+"."+fs[i]));
}
out.print("<td>&nbsp;");

Enumeration e=Node.find(sql.toString(),pos,size);
if(!e.hasMoreElements())
{
  out.println("<tr><td colspan=30 align=center>暂无记录");
}else
{
  boolean auditing=false;
  for(int x=pos+1;e.hasMoreElements();x++)
  {
    int nodeid=((Integer)e.nextElement()).intValue();
    Node nobj=Node.find(nodeid);
    AccessMember amobj=AccessMember.find(nodeid,member);
    int nt=nobj.getType();
    int nc=nt!=1?0:Category.find(nodeid).getCategory();
    out.print("<tr onmouseover=bgColor='#BCD1E9'; onmouseout=bgColor=''; ><td><input name='nodes' type='checkbox' ntype='"+nt+"' ncategory='"+nc+"' value='"+nodeid+"' />");
    for(int i=1;i<fs.length;i++)
    {
      out.print("<td id=NodeListsID"+fs[i]+">&nbsp;");
      if(fs[i].equals("father"))
      {
        out.print("<a href='/servlet/Node?node="+nobj.getFather()+"' target='_blank'>"+Node.find(nobj.getFather()).getSubject(teasession._nLanguage)+"</a>");
      }else if(fs[i].equals("time"))
      {
        out.print(nobj.getTimeToString());
      }else if(fs[i].equals("subject"))
      {
        out.print(nobj.getAnchor(teasession._nLanguage));
      }else if(fs[i].equals("content"))
      {
        out.print(nobj.getText2(teasession._nLanguage));
      }else
      {
        switch(type)
        {
          case 39:
          {
            Report obj=Report.find(nodeid);
            if(fs[i].equals("media_id"))
            {
              int _nMedia = obj.getMedia();
              if(_nMedia>0)
              {
                out.print(Media.find(_nMedia).getName(teasession._nLanguage));
              }
            }else if(fs[i].equals("class_id"))
            {
              int _nClass = obj.getClasses();
              if(_nClass>0)
              {
                out.print(Classes.find(_nClass).getName());
              }
            }else if(fs[i].equals("picture"))
            {
              out.print("<img src=\""+obj.getPicture(teasession._nLanguage)+"\">");
            }else if(fs[i].equals("locus"))
            {
              out.print(obj.getLocus(teasession._nLanguage));
            }else if(fs[i].equals("logograph"))
            {
              out.print(obj.getLogograph(teasession._nLanguage));
            }else if(fs[i].equals("issuetime"))
            {
              out.print(obj.getIssueTimeToString());
            }else if(fs[i].equals("subhead"))
            {
              out.print(obj.getSubhead(teasession._nLanguage));
            }else if(fs[i].equals("author"))
            {
              out.print(obj.getAuthor(teasession._nLanguage));
            }
          }
          break;
          case 41:
          {
            Files f=Files.find(nodeid,teasession._nLanguage);
            if(fs[i].equals("classes"))
            {
              int classes = f.getClasses();
              if (classes > 0)
              {
                out.print(Classes.find(classes).getName());
              }
            }else if(fs[i].equals("code"))
            {
              out.print(f.getCode());
            }else if(fs[i].equals("name"))
            {
              String url41 = "/res/" + teasession._strCommunity + "/files/" + nodeid + "_" + teasession._nLanguage + ".doc";
              out.print("<a href="+url41+">"+f.getName()+"</a>");
            }else if(fs[i].equals("author"))
            {
              out.print(f.getAuthor());
            }else if(fs[i].equals("address"))
            {
              out.print(f.getAddress());
            }else if(fs[i].equals("note"))
            {
              out.print(f.getNote());
            }else if(fs[i].equals("hits"))
            {
              //out.print(f.getHits());
            }
          }
          break;
          case 44:
          {
            NewsPaper np=NewsPaper.find(nodeid,teasession._nLanguage);
            if(fs[i].equals("subtitle"))
            {
              out.print(np.getSubTitle());
            }else if(fs[i].equals("author"))
            {
              out.print(np.getAuthor());
            }else if(fs[i].equals("editor"))
            {
              out.print(np.getEditor());
            }else if(fs[i].equals("issue"))
            {
              out.print(np.getIssue());
            }else if(fs[i].equals("edition"))
            {
              out.print(np.getEdition());
            }else if(fs[i].equals("column"))
            {
              out.print(np.getColumn());
            }else if(fs[i].equals("pubdate"))
            {
              out.print(np.getSubTitle());
            }
          }
          break;
          case 85:
          {
            Scholar obj=Scholar.find(nodeid,teasession._nLanguage);
            if(fs[i].equals("media"))
            {
              int media = obj.getMedia();
              if(media>0)
              {
                out.print(Media.find(media).getName(teasession._nLanguage));
              }
            }else if(fs[i].equals("subhead"))
            {
              out.print(obj.getSubhead());
            }else if(fs[i].equals("author"))
            {
              out.print(obj.getAuthor());
            }else if(fs[i].equals("locus"))
            {
              out.print(obj.getLocus());
            }else if(fs[i].equals("time"))
            {
              out.print(obj.getTimeToString());
            }else if(fs[i].equals("file"))
            {
              out.print("<a href=/servlet/ScholarDowns?node=" + nodeid + " >" + obj.getFileName() + "</a>");
            }
          }
          break;
        }
      }
    }
    out.print("<td>");
    boolean isC=nobj.isCreator(teasession._rv);
    if(isC||amobj.isProvider(nt))
    {
      int pur=isC?3:amobj.getPurview();
      if(pur>1)out.print("<input type=button value="+r.getString(teasession._nLanguage,"CBEdit")+" onclick=window.open('"+url+"?node="+nodeid+"&nexturl='+encodeURIComponent(location.href),'_self');>");
      if(pur>2)out.print("<input type=button value="+r.getString(teasession._nLanguage,"CBDelete")+" onclick=\"if(confirm('" + r.getString(teasession._nLanguage, "ConfirmDeleteTree") + "')){window.open('/servlet/DeleteNode?node=" + nodeid + "&language=" + teasession._nLanguage + "&nexturl='+encodeURIComponent(location.href),'_self');}\">");
      if(amobj.isAuditing()&&nobj.isHidden())
      {
        out.print("<input type=submit name=Grant value="+r.getString(teasession._nLanguage,"CBGrant")+" onclick=f_gd('"+nodeid+"');>");
        out.print("<input type=submit name=Deny value="+r.getString(teasession._nLanguage,"CBDeny")+" onclick=f_gd('"+nodeid+"');>");
        auditing=true;
      }
    }
  }
  out.println("<tr><td colspan='2'><input type='checkbox' onclick='selectAll(form2.nodes,checked)' />"+r.getString(teasession._nLanguage,"SelectAll"));
  out.println("<input type='button' value='"+r.getString(teasession._nLanguage,"CBClone")+"' onclick=f_act('clone'); >");
  out.println("<input type='button' value='"+r.getString(teasession._nLanguage,"CBMove")+"' onclick=f_act('move');>");
  out.println("<input type='button' value='"+r.getString(teasession._nLanguage,"CBDelete")+"' onclick=f_act('delete');>");
  out.println("<input type='button' value='"+r.getString(teasession._nLanguage,"CBRecommend")+"' onclick=f_act('recommend');>");
  if(auditing)
  {
    out.println("<input type='button' value="+r.getString(teasession._nLanguage,"CBGrant")+" onclick=f_act('grant');>");
    out.println("<input type='button' value="+r.getString(teasession._nLanguage,"CBDeny")+" onclick=f_act('deny');>");
  }
  out.println("</td><td colspan='30' align='right'>"+new tea.htmlx.FPNL(teasession._nLanguage,par.toString(),pos,count,size));
}
out.print("</table>");

boolean isC=n.isCreator(teasession._rv);
int pur=isC?3:am.getPurview();
if(pur>0)//有创建的权限
{
  if(n.getType()==0)
  {
    if(isC||am.isProvider(0))out.println("<input type=button value="+r.getString(teasession._nLanguage,"CBNewFolder")+" onclick=window.open('/jsp/general/EditNode.jsp?NewNode=ON&Type=0&node="+teasession._nNode+"&nexturl='+encodeURIComponent(location.href),'_self');>");
    if(isC||am.isProvider(1))out.println("<input type=button value="+r.getString(teasession._nLanguage,"CBNewCategory")+" onclick=window.open('/jsp/general/EditNode.jsp?NewNode=ON&Type=1&node="+teasession._nNode+"&nexturl='+encodeURIComponent(location.href),'_self');>");
  }else
  if(n.getType()==1)
  {
    Category c=Category.find(teasession._nNode);
    if(isC||am.isProvider(c.getCategory()))out.println("<input type=button value="+r.getString(teasession._nLanguage,"CBNew")+" onclick=window.open('"+url+"?NewNode=ON&Type="+type+"&node="+teasession._nNode+"&nexturl='+encodeURIComponent(location.href),'_self');>");
  }
}
%>


</form>

<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
