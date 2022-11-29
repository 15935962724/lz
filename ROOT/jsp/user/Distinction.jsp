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
String strid=request.getParameter("id");
int type=Integer.parseInt(request.getParameter("type"));
String nexturl = request.getRequestURI()+"?"+request.getQueryString();

int pos=0,size=10;
String tmp=request.getParameter("pos");
if(tmp!=null)
{
  pos=Integer.parseInt(tmp);
}

Resource r=new Resource("/tea/resource/AdminList");

Node n=Node.find(teasession._nNode);

String path=n.getPath();

String member=teasession._rv._strV;

AccessMember am=AccessMember.find(teasession._nNode,member);

CommunityAdminList cal=CommunityAdminList.find(teasession._strCommunity,type);
String fs[]=cal.getField().split("/");

StringBuffer sql=new StringBuffer();
StringBuffer par=new StringBuffer();
sql.append(" AND type=").append(type);
sql.append(" AND path LIKE ").append(DbAdapter.cite(path+"%"));

par.append("?node=").append(teasession._nNode);
par.append("&type=").append(type);
par.append("&id=").append(strid);

int father=-1;
tmp=request.getParameter("father");
if(tmp!=null&&tmp.length()>0)
{
  father=Integer.parseInt(tmp);
  sql.append(" AND path LIKE ").append(DbAdapter.cite("%/"+father+"/%"));
}
String subject=request.getParameter("subject");
String content=request.getParameter("content");
if(subject!=null||content!=null)
{//
  sql.append(" AND EXISTS ( SELECT nl.node FROM NodeLayer nl WHERE n.node=nl.node AND nl.language=").append(teasession._nLanguage);
  if(subject!=null)
  {
    sql.append(" AND subject LIKE ").append(DbAdapter.cite("%"+subject+"%"));
    par.append("&subject=").append(URLEncoder.encode(subject,"UTF-8"));
  }
  if(content!=null)
  {
    sql.append(" AND content LIKE ").append(DbAdapter.cite("%"+content+"%"));
    par.append("&content=").append(URLEncoder.encode(content,"UTF-8"));
  }
  sql.append(")");
}
par.append("&pos=");


int count=Node.count(sql.toString());

//下拉菜单////
int fsize=0,flen=path.split("/").length+1;
StringBuffer fsb=new StringBuffer();
fsb.append("<td>分类:");
fsb.append("<SELECT NAME=father ><OPTION VALUE=''>-----------------------");
Enumeration fe=Node.find(" AND type<2 AND path LIKE "+DbAdapter.cite(path+"/%")+" ORDER BY path",0,Integer.MAX_VALUE);
while(fe.hasMoreElements())
{
  int id=((Integer)fe.nextElement()).intValue();
  Node obj=Node.find(id);
  fsb.append("<OPTION VALUE="+id);
  if(id==father)
  {
    fsb.append(" SELECTED ");
  }
  fsb.append(">");
  for(int j=obj.getPath().split("/").length;j>flen;j--)
  {
    fsb.append("　");
  }
  fsb.append(obj.getSubject(teasession._nLanguage));
  fsize++;
}
fsb.append("</SELECT>");

String url=(type<1024)?"/jsp/type/"+Node.NODE_TYPE[type].toLowerCase()+"/Edit"+Node.NODE_TYPE[type]+".jsp":"/jsp/type/dynamicvalue/EditDynamicValue.jsp";

%>
<HTML>
<HEAD>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type="text/javascript"></SCRIPT>
<script>
function f_gd(id)
{
  form2.nodes.value=id;
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


 function shenhe(igd)
  {

      form2.amid.value=igd;
//      form1.act.value="";
    form2.nexturl.value=location.pathname+location.search;
      form2.action='/jsp/user/EditDistinction.jsp';
      form2.submit();
  }
</script>

</HEAD>
<body>
<h1><%=n.getSubject(teasession._nLanguage)%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<h2>查询</h2>
<form  name="form1" action="?">
<input type='hidden' name="node" value="<%=teasession._nNode%>">
<input type='hidden' name="type" value="<%=type%>">
<input type='hidden' name="id" value="<%=strid%>">


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
<form name="form2" action="?">
<input type='hidden' name="nexturl">
<input type='hidden' name="nodes">
<input type="hidden" name="amid" />
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr id=tableonetr>
<td nowrap>栏目名称</td>
<td nowrap>主题</td>
<td nowrap>现在级别</td>
<td nowrap>操作</td>
<%
//for(int i=1;i<fs.length;i++)
//{
//  String name;
//  if("/father/time/subject/content/".indexOf(fs[i])!=-1)
//  {
//    name="Node";
//  }else
//  {
//    name=(type<1024?Node.NODE_TYPE[type]:"Dynamic");
//  }
//  out.print("<td id=NodeListsID"+fs[i]+">"+r.getString(teasession._nLanguage,name+"."+fs[i]));
//}

Enumeration e=Node.find(sql.toString(),pos,size);
while(e.hasMoreElements())
{
int nodeid=((Integer)e.nextElement()).intValue();
Node nobj=Node.find(nodeid);
AccessMember amobj=AccessMember.find(nodeid,member);
Company c = Company.find(nodeid);
out.print("<tr onmouseover=bgColor='#BCD1E9'; onmouseout=bgColor=''; >");
for(int i=1;i<fs.length;i++)
{
  out.print("<td id=NodeListsID"+fs[i]+">&nbsp;");
  if(fs[i].equals("father"))
  {
    out.print("<a href=/servlet/Node?node="+nobj.getFather()+" target=_blank>"+Node.find(nobj.getFather()).getSubject(teasession._nLanguage)+"</a>");
  }else if(fs[i].equals("time"))
  {
   // out.print(nobj.getTimeToString());
   out.print(Company.GRADE_TYPE[c.getGrade(teasession._nLanguage)]);
 //  out.print(c.getGrade());
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
          out.print("<img src="+obj.getPicture(teasession._nLanguage)+">");
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
         // out.print(f.getAddress());
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


out.print(" <input type=button  value=设置级别 onclick=\"shenhe('"+nodeid+"'); \" >");
//  if(amobj.isProvider(type))
//  {
  //    out.print("<input type=button value="+r.getString(teasession._nLanguage,"CBEdit")+" onclick=window.open('"+url+"?node="+nodeid+"');>");
  //    out.print("<input type=button value="+r.getString(teasession._nLanguage,"CBDelete")+" onclick=\"if(confirm('" + r.getString(teasession._nLanguage, "ConfirmDeleteTree") + "')){window.open('/servlet/DeleteNode?node=" + nodeid + "&language=" + teasession._nLanguage + "&nexturl='+encodeURIComponent(location.href),'_self');}\">");
  //  }
  //  if(amobj.isAuditing()&&nobj.isHidden())
  //  {
    //    out.print("<input type=submit name=Grant value="+r.getString(teasession._nLanguage,"CBGrant")+" onclick=f_gd('"+nodeid+"');>");
    //    out.print("<input type=submit name=Deny value="+r.getString(teasession._nLanguage,"CBDeny")+" onclick=f_gd('"+nodeid+"');>");
    //  }



}
out.println("<tr><td colspan=3 align=right>"+new tea.htmlx.FPNL(teasession._nLanguage,par.toString(),pos,count,size));
out.print("</table>");


//if(n.getType()==1&&am.isProvider(type))
//{
//  Category c=Category.find(teasession._nNode);
//  out.print("<input type=button value="+r.getString(teasession._nLanguage,"CBNew")+" onclick=window.open('"+url+"?NewNode=ON&Type="+type+"&TypeAlias="+c.getTypeAlias()+"&node="+teasession._nNode+"&nexturl='+encodeURIComponent(location.href),'_self');>");
//}

%>
</form>

<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</HTML>
