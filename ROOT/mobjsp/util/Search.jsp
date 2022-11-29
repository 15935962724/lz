<%@page contentType="text/html; charset=UTF-8" %>
<%@page import="org.apache.lucene.index.*"%>
<%@page import="org.apache.lucene.search.*"%>
<%@page import="org.apache.lucene.queryParser.*" %>
<%@page import="org.apache.lucene.search.highlight.*" %>
<%@page import="org.apache.lucene.analysis.standard.*" %>
<%@page import="org.apache.lucene.document.*" %>
<%@page import="tea.entity.util.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.entity.admin.orthonline.NodePoints" %>
<%@page import="tea.entity.member.Profile" %><%@page import="tea.entity.*" %>
<%@page import="java.util.*"%><%@page import="java.io.*"%><%@page import="tea.db.*"%><%
request.setCharacterEncoding("UTF-8");

Http h=new Http(request);


tea.resource.Resource r=new tea.resource.Resource("/tea/resource/Lucene");

int lucenelist=h.getInt("lucenelist");

File f=new File(application.getRealPath("/res/"+h.community+"/searchindex/"+lucenelist+"_"+h.language));
if(!f.exists())
{
  response.sendRedirect("/jsp/info/Alert.jsp?info="+java.net.URLEncoder.encode(r.getString(h.language,"1169017432031"),"UTF-8"));//没有发现索引文件
  return;
}

String tmp=h.get("lang");
if(tmp!=null)h.language=Integer.parseInt(tmp);

LuceneList ll=LuceneList.find(lucenelist);

int status=h.status;

long lo=System.currentTimeMillis();



StringBuffer par=new StringBuffer(request.getRequestURI());
par.append("?node=").append(h.node);
par.append("&community=").append(h.community);
par.append("&lucenelist=").append(lucenelist);


int type=0;
if("1".equals(h.get("type")))type=1;

par.append("&type=").append(type);


int pos=h.getInt("pos");


//在上次搜索结果中找
boolean isLast=h.get("last")!=null;



int sum=0;
BooleanQuery bq=new BooleanQuery();
if(isLast)
{
  BooleanQuery last=(BooleanQuery)session.getAttribute("last");
  if(last==null)isLast=false;
  if(isLast)bq.add(last,BooleanClause.Occur.MUST);
}

//  bq.setMaxClauseCount(Integer.MAX_VALUE);
ArrayList v=Lucene.find(" AND lucenelist="+lucenelist,0,200);
for(int i=0;i<v.size();i++)
{
  Lucene obj=(Lucene)v.get(i);
  int id=obj.lucene;
  if("q".equals(obj.field))continue;

  String field=obj.field;
  if(obj.qtype==1)
  {
    String begin=h.get(field+"_begin","");
    String end=h.get(field+"_end","");
    if(begin.length()>0||end.length()>0)
    {
      par.append("&").append(field).append("_begin=").append(begin);
      par.append("&").append(field).append("_end=").append(end);

      if(end.length()<1)end="9999-12-30";
      RangeQuery rq=new RangeQuery(new Term(field,begin),new Term(field,end),false);
      bq.add(rq,BooleanClause.Occur.MUST);
    }
  }else
  {
    String value=h.get(field,"");
    if(value.length()>0)
    {
      par.append("&").append(field).append("=").append(Http.enc(value));
      switch(obj.qtype)
      {
        case 0:
        Query query=new QueryParser(field,new StandardAnalyzer()).parse(Lucene.f(value));
        bq.add(query,BooleanClause.Occur.MUST);
        break;

        case 1:
        break;

        case 2:
        TermQuery tq=new TermQuery(new Term(field,value));
        bq.add(tq,BooleanClause.Occur.MUST);
        break;
      }
    }
  }
}

String keywords=h.get("q","");
if((keywords=Lucene.f(keywords)).length()>64)
{
  keywords=keywords.substring(0,64);
}
if(keywords.length()>0)
{
  String group=h.get("group");
  if(group!=null&&group.length()>0)
  {
    par.append("&group=").append(group);
    if(group.equals("media"))group+="name";
    Query query=new QueryParser(group,new StandardAnalyzer()).parse(keywords);
    bq.add(query,BooleanClause.Occur.MUST);
  }else
  {
    BooleanQuery bq2=new BooleanQuery();
    for(int i=0;i<v.size();i++)
    {
      Lucene lucene=(Lucene)v.get(i);
      if(!"q".equals(lucene.field))
      {
        Query query=new QueryParser(lucene.field,new StandardAnalyzer()).parse(keywords);
        bq2.add(query,BooleanClause.Occur.SHOULD);
      }
    }
    bq.add(bq2,BooleanClause.Occur.MUST);
  }
  par.append("&q=").append(Http.enc(keywords));
  if(isLast)keywords=session.getAttribute("last_q")+" "+keywords;
}else
{
  //查找关键字///
  keywords=h.get("content","");
  if(keywords.length()<1)keywords=h.get("subject","");
}

//排序
Sort s=Sort.RELEVANCE;
if(ll.sorttype==0)s=new Sort(new SortField[]{new SortField("node", SortField.INT, true)});


session.setAttribute("last",bq);
session.setAttribute("last_q",keywords);


Highlighter hig=new Highlighter(new SimpleHTMLFormatter("<font color='red'>","</font>"),new QueryScorer(bq));
hig.setTextFragmenter(new SimpleFragmenter(status==1?50:100));
StandardAnalyzer sa=new StandardAnalyzer();

if(ConnectionPool.isStatic)
{
  out.print("<!DOCTYPE html><html><head>");
  out.print("<script>");
  out.print("document.write(parent.document.getElementsByTagName('HEAD')[0].innerHTML);");
  out.print("var arr=parent.document.getElementsByTagName('LINK');");
  out.print("for(var i=0;i<arr.length;i++)document.write('<link href='+arr[i].href+' rel='+arr[i].rel+' type=text/css>');");
  out.print("</script></head><body class=ifrsearch>");
}
%>

<script>
var ls=parent.document.getElementsByTagName("HEAD")[0];
document.write(ls.innerHTML);
var arr=parent.document.getElementsByTagName("LINK");
for(var i=0;i<arr.length;i++)
{
  document.write("<link href='"+arr[i].href+"' rel='"+arr[i].rel+"' type='text/css'>");
}
</script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/tea/tea.js" type=""></script>

<form name="searchform1" action="?">
<input type="hidden" name="node" value="<%=h.node%>"/>
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="lucenelist" value="<%=lucenelist%>"/>

<table width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr>
<td id="searchmenu">
<%
for(int i=0;i<v.size();i++)
{
  Lucene lucene=(Lucene)v.get(i);
  out.print(lucene.getBefore(h.language));
  out.print(lucene.getItypeToHtml(h));
  out.print(lucene.getAfter(h.language));
}
%>
</td>
  </tr>
</table>

<script type="">
try
{
  searchform1.q.focus();
}catch(e)
{}
</script>
</form>
<%
Searcher searcher=new IndexSearcher(f.getPath());
try
{
  Hits hits=searcher.search(bq,s);
  sum=hits.length();

  out.print(" <span id='searchsum'>"+java.text.MessageFormat.format(r.getString(h.language,"Lucene.Results"),new String[]{String.valueOf(sum),keywords})+"</span>");

  out.print("<div id='searchdiv'><table border='0'>");
  if(hits==null||sum==0)
  {
    out.print("<tr><td><br/><br/>"+tea.http.RequestHelper.format(r.getString(h.language,"Lucene.NotMatch"),keywords)+"<br/><br/>"+r.getString(h.language,"Suggestions")+"<br/></td></tr>");
  }else
  {
    for(int i=pos;i<(pos+10)&&i<sum;i++)
    {
      Document doc=hits.doc(i);
      int node=Integer.parseInt(doc.get("node"));
      Node n=Node.find(node);
      if(n.getTime()==null)//如果节点已被删除
        continue;

      int ntype=n.getType();
      String urlpath=n.getAnchor(h.language,h.status);

      String subject=n.getSubject(h.language);
      tmp=hig.getBestFragment(sa,"subject",subject);
      if(tmp!=null)subject=tmp;

      String desc=Lucene.t(n.getText(h.language));
      tmp=hig.getBestFragment(sa,"content",desc);
      desc=tmp==null?MT.f(desc,status==1?50:100):tmp;

      String time=ntype==39?MT.f(n.getStartTime()):n.getTimeToString();

      NodePoints np=NodePoints.get(node);
      if(np.getLlwz()>0)
      {
        float integral=0;
        if(h.member>0)
        {
            Profile profile=Profile.find(h.member);
            integral= profile.getIntegral();
        }
        if(integral<np.getLlwz()&&h.member>0)
        urlpath="#' onclick=alert('对不起,您的积分不足,不能浏览该文章!'); ";
        else
        urlpath="#' title=\"" +  n.getSubject(h.language) + "\" onclick=if(confirm(\"浏览该文件要扣减积分"+np.getLlwz()+"是否继续\"))window.open('/html/node/"+node+"-"+h.language+".htm','_self'); ";
      }

//      if(status==1)
//      {
//        out.print("<tr><td><b>"+(i+1)+"</b> ");
//        if (flag)
//        out.print(a.toString());
//        else
//        out.print(" <a href='"+urlpath+"' target='_blank' id='searchsubject'>"+subject+"</a>");
//        out.print(" - <span id='searchcontent'>"+desc+"...</span>");
//        if(urlpath.length()>15)
//        urlpath=urlpath.substring(0,15)+"...";
//        out.print(" - <font color='#008000'>http://"+request.getServerName()+":"+request.getServerPort()+urlpath+"</font></td></tr>"+ "<tr><td>&nbsp;</td></tr>");
//      }else
      {
        out.print("<tr><td id='searchsubject'><a href='"+urlpath+"' target='_blank'>"+subject+"</a></td></tr>"+
        "<tr><td id='searchcontent'>"+desc+"...</td></tr>"+
        "<tr><td id='searchdetail'><font color='#00CC00'>"+r.getString(h.language,"Time")+":"+time+"</font></td></tr>"+
        "<tr><td>&nbsp;</td></tr>");
      }
    }

    Enumeration e3=Keywords.findByKeywords(h.community,keywords,10);
    if(e3.hasMoreElements())
    {
      out.print("<tr><td id='searchcorrelation'>"+r.getString(h.language,"Correlation")+":");
      while(e3.hasMoreElements())
      {
        String k=(String)e3.nextElement();
        out.print("<a href='?q="+java.net.URLEncoder.encode(k,"UTF-8")+"&amp;community="+h.community+"&amp;status="+status+"&amp;lucenelist="+lucenelist+"'>"+k+"</a> ");
      }
      out.print("</td></tr>");
    }
  }
}catch(Throwable ex)
{
  ex.printStackTrace();
}finally
{
  searcher.close();
}
out.print("</table></div><div id='ali' align='center'>"+new tea.htmlx.FPNL(h.language,par.toString()+"&pos=",pos,sum,10) );

out.print("</div>");

//统计
String ua=request.getHeader("User-Agent");
if(keywords.length()>0&&ua!=null)
{
  if(ua.length()<40||ua.indexOf("http://")!=-1)
  {
    Filex.logs("search_key.log",keywords+" UA："+ua);
  }else
  {
    Keywords k=Keywords.find(h.community,keywords);
    k.set(sum,session.getId());//request.getRemoteAddr()
  }
}

if(ConnectionPool.isStatic)out.print("<script>mt.fit();</script>");
%>
<script>
mt.fit();
</script>
