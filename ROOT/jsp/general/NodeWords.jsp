<%@page contentType="text/html;charset=UTF-8" %><%@page import="java.io.*" %><%@page import="jxl.write.*" %><%@page import="jxl.format.Alignment" %><%@page import="jxl.format.Colour" %><%@page import="tea.db.DbAdapter" %><%@page import="tea.entity.*"%><%@page import="tea.entity.member.*"%><%@page import="tea.entity.site.*"%><%@page import="tea.resource.Resource"%><%@page import="tea.entity.node.*" %><%@page import="tea.ui.TeaSession" %><%@page import="java.util.regex.Pattern" %><%@page import="java.util.regex.Matcher" %><%@page import="java.util.*" %><%@page import="java.net.*" %><%!
public String v(int node,int lang,int type,String field)throws Exception
{
  String v="";
  switch(type)
  {
    case 39:
    {
      Report obj=Report.find(node);
      if(field.equals("media"))
      {
        int _nMedia = obj.getMedia();
        if(_nMedia>0)
        {
          v=(Media.find(_nMedia).getName(lang));
        }
      }else if(field.equals("classes"))
      {
        int _nClass = obj.getClasses();
        if(_nClass>0)
        {
          v=(Classes.find(_nClass).getName());
        }
      }if(field.equals("locus"))
      {
        v=(obj.getLocus(lang));
      }else if(field.equals("logograph"))
      {
        v=(obj.getLogograph(lang));
      }else if(field.equals("issuetime"))
      {
        v=MT.f(Node.find(node).getStartTime());
        //v=(obj.getIssueTimeToString());
      }else if(field.equals("subhead"))
      {
        v=(obj.getSubhead(lang));
      }else if(field.equals("author"))
      {
        v=(obj.getAuthor(lang));
      }
    }
    break;
  }
  return v;
}
%><%
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
String field=request.getParameter("field");
if(field==null)field="/";
String fs[]=field.split("/");


int pos=0,size=20;
if (request.getParameter("pos") != null && request.getParameter("pos") .length()>0) {
	  pos = Integer.parseInt(request.getParameter("pos"));
}

int root=Community.find(teasession._strCommunity).getNode();

Resource r=new Resource("/tea/resource/"+Node.NODE_TYPE[type]);

String member=teasession._rv._strV;

String ts=String.valueOf(type);
if(type<65535)
{
  Enumeration e=TypeAlias.findByType(type);
  while(e.hasMoreElements())
  {
    int ta=((Integer)e.nextElement()).intValue();
    ts=ts+","+ta;
  }
}

StringBuffer sql=new StringBuffer();
StringBuffer par=new StringBuffer();
sql.append(" AND path LIKE ").append(DbAdapter.cite("/"+root+"/%"));
sql.append(" AND type IN(").append(ts).append(")");
par.append("?node=").append(teasession._nNode);
par.append("&type=").append(type);
par.append("&id=").append(strid);
par.append("&field=").append(field);

int father=0;
String tmp=request.getParameter("father");
if(tmp!=null&&tmp.length()>0)
{
  father=Integer.parseInt(tmp);
  sql.append(" AND path LIKE ").append(DbAdapter.cite("%/"+father+"/%"));
  par.append("&father=").append(father);
}

String start=request.getParameter("start");
if(start!=null&&start.length()>0)
{
  sql.append(" AND time>=").append(DbAdapter.cite(start));
  par.append("&start=").append(start);
}
String end=request.getParameter("end");
if(end!=null&&end.length()>0)
{
  sql.append(" AND time<").append(DbAdapter.cite(end));
  par.append("&end=").append(end);
}
String subject=request.getParameter("subject");
if(subject!=null&&(subject=subject.trim()).length()>0)
{//
  sql.append(" AND EXISTS ( SELECT nl.node FROM NodeLayer nl WHERE n.node=nl.node AND nl.language=").append(teasession._nLanguage);
  if(subject!=null)
  {
    sql.append(" AND subject LIKE ").append(DbAdapter.cite("%"+subject+"%"));
    par.append("&subject=").append(URLEncoder.encode(subject,"UTF-8"));
  }
//  if(content!=null)
//  {
//    sql.append(" AND content LIKE ").append(DbAdapter.cite("%"+content+"%"));
//    par.append("&content=").append(URLEncoder.encode(content,"UTF-8"));
//  }
  sql.append(")");
}
String author=request.getParameter("author");
if(author!=null&&(author=author.trim()).length()>0)
{
  sql.append(" AND EXISTS ( SELECT rl.node FROM ReportLayer rl WHERE n.node=rl.node AND rl.language=").append(teasession._nLanguage).append(" AND author LIKE ").append(DbAdapter.cite("%"+author+"%")).append(")");
  par.append("&author=").append(URLEncoder.encode(author,"UTF-8"));
}
//发布人
String member_rv = teasession.getParameter("member_rv");
if(member_rv!=null && (member_rv=member_rv.trim()).length()>0)
{
//String  member_rv2 = member_rv.substring(0,1);
 // String  member_rv3 = member_rv.substring(member_rv2.length(),member_rv.length());
sql.append(" AND n.rcreator like "+DbAdapter.cite("%"+member_rv+"%"));
  //sql.append(" AND n.rcreator in  (SELECT p1.member FROM ProfileLayer p1,Node n WHERE n.rcreator=p1.member AND p1.language=").append(teasession._nLanguage).append(" AND  (p1.lastname LIKE  ").append(DbAdapter.cite("%"+member_rv2+"%")).append(" or p1.firstname LIKE ").append(DbAdapter.cite("%"+member_rv3+"%")).append("))");
  par.append("&member_rv=").append(URLEncoder.encode(member_rv,"UTF-8"));
}


if(teasession.getParameter("path")!=null && teasession.getParameter("path").length()>0)
{
	sql.append(" AND n.path like "+DbAdapter.cite("%/"+teasession.getParameter("path")+"%/"));
	par.append("&path=").append(teasession.getParameter("path"));
}


Pattern p=Pattern.compile("(<img )",Pattern.CASE_INSENSITIVE);

if(request.getParameter("exp")!=null)
{
  String name="";
  if(start!=null&&start.length()>0)name=name+start;
  if(end!=null&&end.length()>0)name=name+" - "+end;
  response.setHeader("Content-Disposition", "attachment; filename="+java.net.URLEncoder.encode("信息统计_"+name+".xls","UTF-8"));
  WritableWorkbook ww=jxl.Workbook.createWorkbook(response.getOutputStream());
  WritableSheet ws=ww.createSheet("table",1);
  ws.setColumnView(0,15);
  ws.setColumnView(1,20);
  ws.setColumnView(3,15);
  ws.setColumnView(4,50);
  ws.setColumnView(5,15);
  WritableCellFormat nf=new WritableCellFormat(new NumberFormat("#,##0"));
  WritableCellFormat wcf=new WritableCellFormat(new WritableFont(WritableFont.TIMES,20,WritableFont.BOLD,false));
  wcf.setAlignment(Alignment.CENTRE);
  ws.mergeCells(1,0,4,0);
  ws.addCell(new Label(1, 0, "网站稿费统计",wcf));
  ws.mergeCells(5,0,7,0);
  ws.addCell(new Label(5, 0, name));
  int rows=0;
  wcf=new WritableCellFormat();
  wcf.setBackground(Colour.YELLOW);
  ws.addCell(new Label(rows++, 1, "单位",wcf));
  for(int j=1;j<fs.length;j++)
  {
    ws.addCell(new Label(rows++, 1, r.getString(teasession._nLanguage,(type<1024?Node.NODE_TYPE[type]:"Dynamic")+"."+fs[j]),wcf));
  }
  ws.addCell(new Label(rows++, 1, "图文费",wcf));
  ws.addCell(new Label(rows++, 1, "栏目",wcf));
  ws.addCell(new Label(rows++, 1, "标题",wcf));
  ws.addCell(new Label(rows++, 1, "日期",wcf));
  ws.addCell(new Label(rows++, 1, "文字数",wcf));
  ws.addCell(new Label(rows++, 1, "图片数",wcf));
  Enumeration e=Node.find(sql.toString(),0,Integer.MAX_VALUE);
  int x=2;
  for(;e.hasMoreElements();x++)
  {
    int nodeid=((Integer)e.nextElement()).intValue();
    Node nobj=Node.find(nodeid);
    String content=nobj.getText(teasession._nLanguage);
    rows=1;
    for(int i=1;i<fs.length;i++)
    {
      ws.addCell(new Label(rows++, x, v(nodeid,teasession._nLanguage,type,fs[i])));
    }
    int x1=x+1;
    ws.addCell(new Formula(rows++, x, "ROUND(IF(G"+x1+"<=900,G"+x1+"/10,90),-1)+(IF(H"+x1+">=3,50,IF(H"+x1+"=2,40,IF(H"+x1+"=1,20,0))))",nf));//图文费
    ws.addCell(new Label(rows++, x, Node.find(nobj.getFather()).getSubject(teasession._nLanguage)));
    ws.addCell(new Label(rows++, x, nobj.getSubject(teasession._nLanguage)));
    ws.addCell(new Label(rows++, x, nobj.getTimeToString()));
    int len=content.getBytes().length/2;
    ws.addCell(new jxl.write.Number(rows++, x, (double)len,nf));
    int img=0;
    Matcher m=p.matcher(content);
    while(m.find())
    {
      img++;
    }
    ws.addCell(new jxl.write.Number(rows++, x, (double)img,nf));
  }
  ws.addCell(new Formula(2, x, "SUM(C3:C"+x+")",nf));//图文费合计
  ww.write();
  ww.close();
  return;
}

int count=Node.countReport(teasession._strCommunity,sql.toString());


String o=request.getParameter("o");
if(o==null)
{
  o="n.starttime";
}
boolean aq=java.lang.Boolean.parseBoolean(request.getParameter("aq"));
sql.append(" ORDER BY ").append(o).append(" ").append(aq?"ASC":"DESC");
par.append("&o=").append(o).append("&aq=").append(aq);



//http://127.0.0.1/jsp/general/NodeWords.jsp?node=2196637&type=39&id=null&field=/author/
%><html>
<head>
<title>网站信息统计</title>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
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
function f_order(v)
  {
    var aq=form1.aq.value=="true";
    if(form1.o.value==v)
    {
      form1.aq.value=!aq;
    }else
    {
      form1.o.value=v;
    }
    form1.action="?";
    form1.submit();
  }

</script>

</head>
<body>
<h1>网站信息统计</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<h2>查询</h2>
<form  name="form1" action="?">
<input type='hidden' name="node" value="<%=teasession._nNode%>">
<input type='hidden' name="type" value="<%=type%>">
<input type='hidden' name="id" value="<%=strid%>">
<input type='hidden' name="field" value="<%=field%>">
 <input type="hidden" name="o" VALUE="<%=o%>">
      <input type="hidden" name="aq" VALUE="<%=aq%>">


<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr>
<td>栏目:<select name="father">
<option value="">------------------------------</option>
<%
Enumeration fe=Node.find(" AND n.path LIKE "+DbAdapter.cite("/"+root+"/%")+" AND n.type=1 AND n.node IN(SELECT node FROM Category WHERE category =39)",0,Integer.MAX_VALUE);

while(fe.hasMoreElements())
{
  int id=((Integer)fe.nextElement()).intValue();

  int j=Node.countReport(teasession._strCommunity," AND n.father="+id);
  Node obj=Node.find(id);

  out.print("<OPTION VALUE="+id);
  if(id==father)
  {
    out.print(" SELECTED ");
  }
  out.append(">"+obj.getSubject(teasession._nLanguage)+" ( "+j+" )");
}
%>
</select>
  <td>主题:<input type="text" name="subject" value="<%if(subject!=null)out.print(subject);%>"/></td>
  </tr>
  <tr>
  <td>作者:<input type="text" name="author" value="<%if(author!=null)out.print(author);%>"/></td>
  <td>创建者:<input type="text" name="member_rv" value="<%if(member_rv!=null)out.print(member_rv);%>"/></td>
  </tr>
  <tr>
  <td>日期:<input  type="text" name="start" value="<%if(start!=null)out.print(start);%>" size="12" ondblclick="value=''" readonly><img align="top" src="/tea/image/public/Calendar2.gif" onclick="showCalendar('form1.start')"  style="cursor:pointer"/>
    <input type="text" name="end" value="<%if(end!=null)out.print(end);%>" size="12" ondblclick="value=''" readonly><img align="top" src="/tea/image/public/Calendar2.gif" onclick="showCalendar('form1.end')"  style="cursor:pointer"/>
  </td>

  <td><input type="submit" value="GO"/></td>
</tr>
</table>


<h2><%=r.getString(teasession._nLanguage, "列表")+" ( "+count+" )"%></h2>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr id=tableonetr><td>&nbsp;
<td>栏目</td>
<td>标题</td>
<%
for(int i=1;i<fs.length;i++)
{
  out.print("<td>"+r.getString(teasession._nLanguage,(type<1024?Node.NODE_TYPE[type]:"Dynamic")+"."+fs[i]));
}
out.print("<td><a href=\"javascript:f_order('n.starttime');\">发生日期");
if(o.equals("n.starttime"))
{
  if(aq)
  out.print("&nbsp;<img src=\"/tea/image/pic_time_1.gif\" >");
  else
  out.print("&nbsp;<img src=\"/tea/image/pic_time_0.gif\" >");
}

out.print("</a></td><td>创建者</td><td>文章字数</td><td>图片数</td></tr>");
int cimg = 0;

if(teasession.getParameter("path")!=null && teasession.getParameter("path").length()>0)
{
	Enumeration e=Node.findReport(teasession._strCommunity,sql.toString(),0,Integer.MAX_VALUE);
	for(int x=pos+1;e.hasMoreElements();x++)
	{
	  int nodeid=((Integer)e.nextElement()).intValue();
	  Node nobj=Node.find(nodeid);
	  Profile pobj = Profile.find(nobj.getCreator()._strR);
	  String content=nobj.getText(teasession._nLanguage);
	  int img=0;
	  Matcher m=p.matcher(content);
	  while(m.find())
	  {
	    img++;
	  }
	  cimg = cimg+img;
	}
	out.println("图片总数："+cimg);
}



Enumeration e=Node.findReport(teasession._strCommunity,sql.toString(),pos,size);
for(int x=pos+1;e.hasMoreElements();x++)
{
  int nodeid=((Integer)e.nextElement()).intValue();
  Node nobj=Node.find(nodeid);
  Profile pobj = Profile.find(nobj.getCreator()._strR);
  String content=nobj.getText(teasession._nLanguage);
  out.print("<tr onmouseover=bgColor='#BCD1E9'; onmouseout=bgColor=''; ><td>"+x);
  out.print("<td>"+Node.find(nobj.getFather()).getAnchor(teasession._nLanguage)+"</td>");
  out.print("<td>"+nobj.getAnchor(teasession._nLanguage,"_blank",subject,20));
  for(int i=1;i<fs.length;i++)
  {
    out.print("<td>&nbsp;"+v(nodeid,teasession._nLanguage,type,fs[i]));
  }
  if(nobj.getType() ==39)
  {
    out.print("<td>"+MT.f(nobj.getStartTime()));
  }else
  {
    out.print("<td>"+nobj.getTimeToString());
  }

  out.print("<td>"+nobj.getCreator()._strR+"</td>");
  int len=0;
  if(content!=null && content.length()>0)
  {
    len=content.getBytes().length/2;
  }else
  {
    content="";
  }
  out.print("<td align=right>"+len);
  int img=0;
  Matcher m=p.matcher(content);
  while(m.find())
  {
    img++;
  }

  out.print("<td align=right>"+img);
}


out.println("<tr><td colspan=3 align=right>");

out.print(new tea.htmlx.FPNL(teasession._nLanguage,request.getRequestURI()+par.toString()+"&pos=",pos,count,size));


out.print("</table>");
%>
<input type="submit" name="exp" value="导出">
</form>

<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
