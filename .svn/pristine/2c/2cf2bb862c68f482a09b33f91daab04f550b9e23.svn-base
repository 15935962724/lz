<%@page contentType="text/html; charset=UTF-8" %>
<%@page import="java.io.*" %>
<%@page import="java.util.*" %>
<%@page import="tea.ui.*" %>
<%@page import="tea.db.*" %>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.entity.util.*" %>
<%@page import="tea.entity.member.*" %>
<%@page import="org.apache.lucene.index.*" %>
<%@page import="org.apache.lucene.search.*" %>
<%@page import="org.apache.lucene.document.*" %>
<%@page import="org.apache.lucene.queryParser.*" %>
<%@page import="org.apache.lucene.analysis.standard.*" %>
<%
TeaSession teasession=new TeaSession(request);

int lucenelist=Integer.parseInt(request.getParameter("lucenelist"));
File fi=new File(application.getRealPath("/res/" + teasession._strCommunity + "/searchindex/"+lucenelist+"_"+teasession._nLanguage));
if(!fi.exists())
{
  response.sendRedirect("/jsp/info/Alert.jsp?info="+java.net.URLEncoder.encode("没有发现索引文件","UTF-8"));//没有发现索引文件
  return;
}

int city=0;
String tmp=request.getParameter("city");
if(tmp!=null&&tmp.length()>0)
{
  city=Integer.parseInt(tmp);
}
int father=0;
tmp=request.getParameter("father");
if(tmp!=null&&tmp.length()>0)
{
  father=Integer.parseInt(tmp);
}
int pos=0,size=10;
tmp=request.getParameter("pos");
if(tmp!=null&&tmp.length()>0)
{
  pos=Integer.parseInt(tmp);
}

boolean a=request.getParameter("a")!=null;

String q=request.getParameter("q");
boolean bql=q!=null&&q.length()>0;
boolean ajax=request.getParameter("ajax")!=null;


IndexSearcher is=new IndexSearcher(fi.getAbsolutePath());
StandardAnalyzer sa=new StandardAnalyzer();
BooleanQuery bq = new BooleanQuery();


%><html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script>
var win=parent.document.all('result');
function f_load()
{
  //load.style.display="none";
  //result.style.display="";
  f_size();
}
function f_clear(n)
{
  var obj;
  if(n)
  {
    obj=parent.document.all(n);
    obj.value='';
  }else
  {
    obj=parent.document.all("father");
    obj.value='';
    obj=parent.document.all("city");
    obj.value='';
    obj=parent.document.all("q");
    obj.value='';
  }
  obj.form.submit();
}
function f_size()
{
  win.height=document.body.scrollHeight;
  win.width=document.body.scrollWidth;
}
function show(n,hits,d)
{
  <%
  if(a)
  {
    out.print("window.open('/servlet/Node?node='+n,'_blank'); return;");
  }
  %>
  var title="<span id=company_menu><a href=javascript:; onclick=f_c(this,0,"+n+",'"+d+"');>名 片</a><a href=javascript:; onclick=f_c(this,1,"+n+",'"+d+"');>企业简介</a><a href=javascript:; onclick=f_c(this,2,"+n+",'"+d+"');>给我留言</a><a href=javascript:; onclick=f_c(this,3,"+n+",'"+d+"');>在线洽谈</a><a href=javascript:; onclick=f_c(this,4,"+n+",'"+d+"');>免费通话</a></span>";
  var footer=location.host+"浏览统计"+hits+"次 | <a href=/servlet/AddToFavorite?node="+n+" target=_blank>收藏</a>";
  parent.showDialog(title,"http://"+d+"/jsp/type/company/windows/CompanyBasicinfo.jsp?node="+n,footer,373,225,"<a href=http://www.redcome.com/ target=_blank><img src=/res/lib/u/0805/080565370.jpg></a>");
}
</script>
</head>
<body onLoad="f_load()" >
<%
StringBuffer par=new StringBuffer();
par.append("?community=").append(teasession._strCommunity);
par.append("&lucenelist=").append(lucenelist);

StringBuffer sql=new StringBuffer();
sql.append(" AND type=21");

out.print("<div id=searchwhere>");
if(father!=0||city!=0||bql)
{
  if(father!=0)
  {
    Node f=Node.find(father);
    out.print("<a href=javascript:f_clear('father');>"+f.getSubject(teasession._nLanguage)+"</a>　");
    bq.add(new TermQuery(new Term("t255_path",String.valueOf(father))),BooleanClause.Occur.MUST);
    sql.append(" AND path LIKE ").append(DbAdapter.cite(f.getPath()+"%"));
    par.append("&father=").append(father);
  }
  if(city!=0)
  {
    out.print("<a href=javascript:f_clear('city');>"+Card.find(city).getAddress()+"</a>　");
    bq.add(new TermQuery(new Term("t21_city",String.valueOf(city))),BooleanClause.Occur.MUST);
    sql.append(" AND node IN ( SELECT node FROM Company WHERE city LIKE ").append(DbAdapter.cite(city+"%")).append(" )");
    par.append("&city=").append(city);
  }
  if(bql)//contains , FREETEXT
  {
    out.print("<a href=javascript:f_clear('q');>"+q+"</a>　");
    bq.add(new QueryParser("t255_subject",sa).parse(q),BooleanClause.Occur.MUST);
    sql.append(" AND node IN ( SELECT node FROM NodeLayer WHERE FREETEXT(subject,").append(DbAdapter.cite("%"+q+"%")).append("))");//.append(" OR content LIKE ").append(DbAdapter.cite("%"+q+"%"))
    par.append("&q=").append(java.net.URLEncoder.encode(q,"UTF-8"));
  }
  out.print("(←点击取消此条件)　");
  out.print("<a href=javascript:f_clear();>取消全部条件</a>");
}
out.print("</div>");
if(!ajax)
{
  out.print("<div id=load>数据加载中...</div>");
  out.print("<script>f_size(); location.replace(location.href+'&ajax=on');</script>");
}else
{
  par.append("&pos=");


  //System.out.println(sql.toString());

  long lo=System.currentTimeMillis();
  Hits hits=is.search(bq);
  try
  {
    int count=hits.length();
    //int count=Node.count(sql.toString());
    //Enumeration e=Node.find(sql.toString(),pos,size);
    lo=System.currentTimeMillis()-lo;

    StringBuffer sb=new StringBuffer();
    sb.append("<div id=waiwei><table id=result><tr><td colspan=3 align=right>找到相关信息约"+count+" 篇，用时 "+(lo/1000F)+" 秒</td></tr>");
    for(int i=pos;i<(pos+size)&&i<count;i++)
    {
      Document doc = hits.doc(i);

      int id=Integer.parseInt(doc.get("t255_node")); //((Integer)e.nextElement()).intValue();
      Node n=Node.find(id);
      String syncid=n.getSyncId();
      if(syncid==null)
      {
        continue;
      }
      String rid=syncid.substring(syncid.indexOf('.')+1);//在代理商上的节点号
      Company c=Company.find(id);
      String domain=OpenID.find(n.getCreator()._strV).getProxy();
      String subject=n.getSubject(teasession._nLanguage);
      String text=n.getText(teasession._nLanguage);
      if(text.length()>130)
      {
        text=text.substring(0,130);
      }
      if(bql)
      {
        subject=subject.replaceAll(q,"<FONT COLOR=RED>"+q+"</FONT>");
        text=text.replaceAll(q,"<FONT COLOR=RED>"+q+"</FONT>");
      }

      sb.append("<tr><td height=10></td></tr><tr><td id=qymc><a href=javascript:show(").append(rid).append(",").append(n.getClick()).append(",'").append(domain).append("')>").append(subject).append(" ( ").append(Card.find(c.getCity(teasession._nLanguage)).toString()).append(" )</td></tr>");
      sb.append("<tr><td>").append(text).append("</td></tr>");
      sb.append("<tr><td align=right>").append(c.getAgora(3)).append("</td></tr>");
    }
    sb.append("<tr><td colspan=3 align=right>"+new tea.htmlx.FPNL(teasession._nLanguage,par.toString(),pos,count,size)+"</td></tr>");
    sb.append("</table></div>");
    out.print(sb.toString());
  }finally
  {
    is.close();
  }
}

%>
</body>
</html>
