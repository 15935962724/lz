<%@page contentType="text/html; charset=UTF-8" %><%@ page import="org.apache.lucene.index.*"%><%@ page import="org.apache.lucene.search.*"%><%@ page import="tea.entity.util.*"%><%@ page import="tea.entity.node.*"%>
<%@page import="org.apache.lucene.queryParser.*" %>
<%@page import="tea.entity.*" %><%@page import="java.util.regex.*" %>
<%@page import="org.apache.lucene.analysis.standard.*" %>
<%@page import="org.apache.lucene.document.*" %>
<%@page import="org.apache.lucene.search.highlight.*" %>
<%@page import="java.util.*"%><%@ page import="java.io.*"%>
<%!

public String red(String s,String q)
{
  try
  {
    return Pattern.compile(q.replaceAll(" +","|"),Pattern.CASE_INSENSITIVE).matcher(s).replaceAll("<font color='red'>$0</font>");
  }catch(Exception ex)
  {
    ex.printStackTrace();
    return s;
  }
}
%><%
request.setCharacterEncoding("UTF-8");

Http h=new Http(request);


int lucenelist=1;//h.getInt("lucenelist");
File f=new File(application.getRealPath("/res/" + h.community + "/searchindex/"+lucenelist+"_"+1));
if(!f.exists())
{
  response.sendRedirect("/jsp/info/Alert.jsp?info="+Http.enc("没有发现索引文件"));
  return;
}


StringBuilder par=new StringBuilder();
int type=h.getInt("type");
par.append("?type="+type);

String field=h.get("field");
if(type!=1)field="subject";
par.append("&field="+field);

String q=h.get("q","");
par.append("&q="+Http.enc(q));
out.print("<script>var t=search.type;t.value='"+type+"';t.onchange();search.field.value='"+field+"';search.q.value='"+q+"';</script>");

q=Lucene.f(q).toLowerCase();
if(q.length()<1)
{
  out.print("请输入关键字。。。");
  return;
}

Filex.logs("search.txt",request.getRemoteAddr()+" 关键字："+q);


int pos=h.getInt("pos");
par.append("&pos=");

//Sort sort=new Sort(new SortField[]{new SortField(null,SortField.SCORE,false),new SortField("time",SortField.STRING,true)});
Sort sort=new Sort(new SortField("time",SortField.STRING,true));

//+(-path:19) +subject:区  无法查出内容

StandardAnalyzer sa=new StandardAnalyzer();
SimpleHTMLFormatter shf=new SimpleHTMLFormatter("<font color='red'>","</font>");


String[] PATH={null,"21"   ,"19"      ,"22"          ,"20"    ,"49"      ,"58"   ,"65"   ,null};
String[] NAME={""  ,"标本库","保护区名录","红外相机数据库","物种名录","文献资料库","视频库","图片库","其它"};
int[] sum=new int[NAME.length];
Hits[] hits=new Hits[NAME.length];

Searcher is=new IndexSearcher(f.getAbsolutePath());
try
{
  Query qsubject=new QueryParser("subject",sa).parse(q);
  BooleanQuery other=new BooleanQuery();
  //
  for(int i=0;i<NAME.length;i++)
  {
    BooleanQuery bq=new BooleanQuery();
    if(PATH[i]!=null)
    {
      TermQuery tq=new TermQuery(new Term("path",PATH[i]));
      bq.add(tq,BooleanClause.Occur.MUST);
      other.add(tq,BooleanClause.Occur.MUST_NOT);
    }else
    {
      bq=other;
    }
    if(i==1&&!field.equals("subject"))
      bq.add(new QueryParser(field,sa).parse(q),BooleanClause.Occur.MUST);
    else
      bq.add(qsubject,BooleanClause.Occur.MUST);
    hits[i]=is.search(bq);
    //out.print("条件："+bq+"　　"+NAME[i]+"("+hits[i].length()+")<br/>");
  }

  Keywords k=Keywords.find(h.community,q);
  k.set(hits[type].length(),request.getRemoteAddr());

  out.print("<div class='setTit'><h3>全文搜索结果</h3><div class='right'>共有<b>"+hits[type].length()+"</b>项符合“"+q+"”的查询结果</div></div>");
  out.print("<table class='table_1'>");
  for(int i=1;i<NAME.length;i++)
  {
    if(i%5==0)out.print("<tr>");
    out.print("<td><a href='?type="+i+"&field=subject&q="+Http.enc(q)+"'>"+NAME[i]+"(<em>"+hits[i].length()+"</em>)</a>");
  }
  out.print("</table>");
  if(hits[type].length()<1)
  {
    out.print("<ul class='pro'><li>建议：<li>检查输入是否正确<li>简化输入词<li>尝试其他相关词，如同义、近义词等</ul>");
    return;
  }


  Highlighter hig=new Highlighter(shf,new QueryScorer(qsubject));
  hig.setTextFragmenter(new SimpleFragmenter(300));

  out.print("<table class='table_2'>");
  for(int i=pos;i<pos+20&&i<hits[type].length();i++)
  {
    int node=Integer.parseInt(hits[type].doc(i).get("node"));
    Node n=Node.find(node);
    if(n.getTime()==null)continue;//如果节点已被删除

    String[] arr=n.getPath().split("/");
    int father=arr.length>3?Integer.parseInt(arr[3]):n.getFather();

    Date time=n.getStartTime();
    if(time==null)time=n.getTime();

    //标红
    String subject=n.getSubject(h.language);
    String tmp=hig.getBestFragment(sa,"subject",subject);
    if(tmp!=null)subject=tmp;
    //
    //String desc=Lucene.t(n.getText(h.language));
    //tmp=hig.getBestFragment(sa,"content",desc);
    //desc=tmp==null?MT.f(desc,300):tmp;

    out.print("<tr><td>["+Node.find(father).getAnchor(h.language)+"] <a href='/html/"+h.community+"/"+(n.getType()>=1024?"node":Node.NODE_TYPE[n.getType()].toLowerCase())+"/"+node+"-"+h.language+".htm'>"+subject+"</a>　　点击："+n.getClick()+"　　日期："+MT.f(time));
    //out.print("<tr><td id='content'>"+desc+"...");
    //out.print("<tr><td id='detail'>日期: "+MT.f(time));
  }
  out.print("</table>");
}finally
{
  is.close();
}
%>

<li id="PageNum"><%=new tea.htmlx.FPNL(h.language,par.toString(),pos,hits[type].length(),20)%></li>

