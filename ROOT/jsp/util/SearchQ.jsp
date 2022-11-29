<%@page contentType="text/html; charset=UTF-8" %><%@page import="java.util.*"%><%@page import="java.io.*"%>
<%@page import="org.apache.lucene.index.*"%>
<%@page import="org.apache.lucene.search.*"%>
<%@page import="org.apache.lucene.queryParser.*" %>
<%@page import="org.apache.lucene.search.highlight.*" %>
<%@page import="org.apache.lucene.analysis.standard.*" %>
<%@page import="org.apache.lucene.document.*" %>
<%@page import="tea.db.*"%><%@page import="tea.entity.*"%><%@page import="tea.entity.node.*"%><%@page import="tea.entity.util.*"%><%@page import="tea.entity.member.*"%><%@page import="tea.entity.admin.AdminUnit"%>
<%
request.setCharacterEncoding("UTF-8");

Http h=new Http(request);
if(h.isIllegal())
{
  out.println("无权操作！");
  return;
}

tea.resource.Resource r=new tea.resource.Resource("/tea/resource/Lucene");

int lucenelist=h.getInt("lucenelist");

String tmp=h.get("lang");
int lang=tmp==null?h.language:Integer.parseInt(tmp);

File f=new File(application.getRealPath("/res/"+h.community+"/searchindex/"+lucenelist+"_"+h.language));
if(!f.exists())
{
  out.print(r.getString(lang,"1169017432031"));//没有发现索引文件
  return;
}

LuceneList ll=LuceneList.find(lucenelist);

int status=h.status;

StringBuffer par=new StringBuffer();
par.append("?lucenelist="+lucenelist);
par.append("&lang="+lang);

String style=h.get("style","");
if(style.length()>0)par.append("&style="+Http.enc(style));


int pos=h.getInt("pos");

String q=h.get("q","请输入关键字...").replace('"',' ');
q=q.replaceAll("[\"'()+]"," ").replaceAll("select","");//[广发]
par.append("&q="+Http.enc(q));

int sum=0;

StandardAnalyzer sa=new StandardAnalyzer();

//排序
Sort sort=new Sort(new SortField[]{new SortField("node",SortField.INT,true)});



if(ConnectionPool.isHtml5)out.print("<!DOCTYPE html>");

%>
<script>
if(top!=self)
{
  document.write("<html><head>");
  try
  {
    document.write('<base href=//'+parent.location.host+'<%=request.getRequestURI()%> >');
    var arr=parent.document.getElementsByTagName('LINK');
    for(var i=0;i<arr.length;i++)document.write('<link href='+arr[i].href+' rel='+arr[i].rel+'>');
  }catch(e)
  {
    var ref=document.referrer,cur=location.protocol+'//'+location.host; ref=ref.substring(0,ref.indexOf('/',8)); if(ref==cur)ref=localStorage.getItem(cur+'/mt.fit');else localStorage.setItem(cur+'/mt.fit',ref);
    document.write('<base href='+ref+'>');
    var arr=mt.get('style').split(',');//style参数
    for(var i=0;i<arr.length-1;i++)document.write('<link href=/res/"+h.community+"/cssjs/'+arr[i]+'L1.css rel=stylesheet>');
  }
  document.write("</head><body class=ifrsearch>");
}
</script>
<script src="/tea/tea.js"></script>
<script src="/tea/mt.js"></script>
<style>
body{padding:0px;}
</style>

<form name="searchform1" action="?">
<input type="hidden" name="node" value="<%=h.node%>"/>
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="lucenelist" value="<%=lucenelist%>"/>
<input type="hidden" name="lang" value="<%=lang%>"/>
<input type="hidden" name="style" value="<%=MT.f(style)%>"/>

<table width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr><td id="searchmenu"><input type="text" name="q" value="<%=q%>" class="query"/><input type="submit" class="btn" value="<%=r.getString(lang,"Search")%>"/></td></tr>
</table>

<script>
var t=searchform1.q;
try
{
  t.focus();
}catch(e)
{}
</script>
</form>
<%
q=Lucene.f(q);
Searcher is=new IndexSearcher(f.getPath());
try
{
  Hits[] hits=new Hits[2];

  BooleanQuery b0=new BooleanQuery(),b1=new BooleanQuery(),b2=new BooleanQuery();

  //权限
//  b0.add(new TermQuery(new Term("access","0")),BooleanClause.Occur.SHOULD);
//  if(h.member>0)
//  {
//    Profile m=Profile.find(h.member);
//    b0.add(new TermQuery(new Term("access",String.valueOf(h.member))),BooleanClause.Occur.SHOULD);
//    String[] arr=AdminUnit.find(m.dept).path.split("/");
//    for(int i=1;i<arr.length;i++)b0.add(new TermQuery(new Term("access",arr[i])),BooleanClause.Occur.SHOULD);
//  }
//  b1.add(b0,BooleanClause.Occur.MUST);
//  b2.add(b0,BooleanClause.Occur.MUST);

  //路径
  int path=h.getInt("path");
  if(path>0)
  {
    TermQuery tq=new TermQuery(new Term("path",""+path));
    b1.add(tq,BooleanClause.Occur.MUST);
    b2.add(tq,BooleanClause.Occur.MUST);
    par.append("&path="+path);
  }

  //标题
  Query query=new QueryParser("subject",sa).parse(q);
  b1.add(query,BooleanClause.Occur.MUST);
  b2.add(query,BooleanClause.Occur.MUST_NOT);

  out.print("<!--"+b1+"-->");
  hits[0]=is.search(b1,sort);
  sum+=hits[0].length();

  //内容
  query=new QueryParser("content",sa).parse(q);
  b2.add(query,BooleanClause.Occur.MUST);

  out.print("<!--"+b2+"-->");
  hits[1]=is.search(b2,sort);
  sum+=hits[1].length();

  out.print(" <span id='searchsum'>"+java.text.MessageFormat.format(r.getString(lang,"Lucene.Results"),new String[]{String.valueOf(sum),q})+"</span>");

  out.print("<div id='searchdiv'><table border='0'>");
  if(sum==0)
  {
    out.print("<tr><td><br/><br/>"+tea.http.RequestHelper.format(r.getString(lang,"Lucene.NotMatch"),q)+"<br/><br/>"+r.getString(lang,"Suggestions")+"<br/></td></tr>");
  }else
  {
    Highlighter hig=new Highlighter(new SimpleHTMLFormatter("<font color='red'>","</font>"),new QueryScorer(b1));
    hig.setTextFragmenter(new SimpleFragmenter(status==1?50:100));

    for(int i=pos;i<pos+10&&i<sum;i++)
    {
      int seq=i;
      Document doc=null;
      for(int j=0;j<hits.length;j++)
      {
        if(seq<hits[j].length())
        {
          doc=hits[j].doc(seq);
          break;
        }
        seq-=hits[j].length();
      }

      int node=Integer.parseInt(doc.get("node"));
      Node n=Node.find(node);
      if(n.isHidden()||n.getFinished()!=1||n.getTime()==null)continue;//如果节点已被删除

      int ntype=n.getType();
      String urlpath=n.getAnchor(h.language,h.status);

      String subject=n.getSubject(h.language);
      tmp=hig.getBestFragment(sa,"subject",subject);
      if(tmp!=null)subject=tmp;

      String desc=Lucene.t(n.getText(h.language));
      tmp=hig.getBestFragment(sa,"content",desc);
      desc=tmp==null?MT.f(desc,status==1?50:100):tmp;


      String time=MT.f(ntype==39?n.getStartTime():n.getTime());


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
        "<tr><td id='searchdetail'><font color='#00CC00'>"+r.getString(lang,"Time")+":"+time+"</font></td></tr>"+
        "<tr><td>&nbsp;</td></tr>");
      }
    }

//    Enumeration e3=Keywords.findByKeywords(h.community,q,10);
//    if(e3.hasMoreElements())
//    {
//      out.print("<tr><td id='searchcorrelation'>"+r.getString(lang,"Correlation")+":");
//      while(e3.hasMoreElements())
//      {
//        String k=(String)e3.nextElement();
//        out.print("<a href=javascript:; onclick=location='?q="+Http.enc(k)+"&community="+h.community+"&status="+status+"&lucenelist="+lucenelist+"'>"+k+"</a> ");
//      }
//      out.print("</td></tr>");
//    }
  }

}catch(Throwable ex)
{
  ex.printStackTrace();
}finally
{
  is.close();
}
out.print("</table></div><div id='ali' align='center'>"+new tea.htmlx.FPNL(lang,par.toString()+"&pos=",pos,sum,10));

out.print("</div>");

%>
<script>
mt.fit();
(parent._hmt=parent._hmt||[]).push(['_trackEvent','search','query',"<%=q%>",<%=pos%>]);
</script>
