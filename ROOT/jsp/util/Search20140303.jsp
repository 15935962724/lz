<%@page contentType="text/html; charset=UTF-8" %><%@page import="tea.ui.TeaSession"%><%@ page import="org.apache.lucene.index.*"%><%@ page import="org.apache.lucene.search.*"%><%@ page import="tea.entity.util.*"%><%@ page import="tea.entity.node.*"%>
<%@page import="org.apache.lucene.queryParser.*" %>
<%@page import="tea.entity.admin.orthonline.NodePoints" %>
<%@page import="tea.entity.member.Profile" %>
<%@page import="java.util.regex.*"%>
<%@page import="tea.entity.MT"%>

<%@page import="org.apache.lucene.analysis.standard.*" %><%@page import="org.apache.lucene.document.*" %><%@ page import="java.util.*"%><%@ page import="java.io.*"%>
<%!

//标红,英文字母不区大小写
public String mark(String key,String content)
{
  StringBuffer sb=new StringBuffer(content.length());
  try
  {
    key=key.replaceAll("[\\\\]","").replaceAll("[|]","").replaceAll("[\\\\^]","").replaceAll("\\s+","|");
    java.util.regex.Matcher m=java.util.regex.Pattern.compile(key,java.util.regex.Pattern.CASE_INSENSITIVE).matcher(content);
    int index=0;
    while(m.find())
    {
      sb.append(content.substring(index,m.start()));
      sb.append("<FONT color='red'>"+m.group()+"</FONT>");
      index=m.end();
    }
    sb.append(content.substring(index));
    return sb.toString();
  }catch(Exception ex)
  {
    ex.printStackTrace();
    return content;
  }
}
%><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);



String community=teasession._strCommunity;

tea.resource.Resource r=new tea.resource.Resource("/tea/resource/Lucene");

int lucenelist=0;
try
{
  lucenelist=Integer.parseInt(request.getParameter("lucenelist"));
}catch(Exception ex)
{
  System.out.println("搜索:"+request.getServerName()+request.getRequestURI()+"?"+request.getQueryString());
  return;
}
File f=new File(application.getRealPath("/res/" + community + "/searchindex/"+lucenelist+"_"+teasession._nLanguage));
if(!f.exists())
{
  response.sendRedirect("/jsp/info/Alert.jsp?info="+java.net.URLEncoder.encode(r.getString(teasession._nLanguage,"1169017432031"),"UTF-8"));//没有发现索引文件
  return;
}
LuceneList ll=LuceneList.find(lucenelist);

int status=teasession._nStatus;

long lo=System.currentTimeMillis();

String keywords=request.getParameter("q");

String regxpForHtml = "<([^>]*)>";
Pattern pattern = Pattern.compile(regxpForHtml);   
 boolean result1=false;
if(keywords==null)
	keywords="";
else{
	Matcher matcher = pattern.matcher(keywords);    
	result1 = matcher.find(); 
	if(result1)
	{
	  keywords="";
	}
	else if((keywords=keywords.trim()).length()>64)
	{
	  keywords=keywords.substring(0,64);
	}
}
/*
if("---关键字---".equals(keywords))
{
  keywords="";
}
*/

StringBuffer param=new StringBuffer(request.getRequestURI());
param.append("?node=").append(teasession._nNode);
param.append("&community=").append(community);
param.append("&lucenelist=").append(lucenelist);
param.append("&q=").append(java.net.URLEncoder.encode(keywords,"UTF-8"));



int type=0;
if("1".equals(request.getParameter("type")))
type=1;

param.append("&type=").append(type);



int pos=0;
String tmp=request.getParameter("pos");
if(tmp!=null)
pos=Integer.parseInt(tmp);

//在上次搜索结果中找
boolean isLast=request.getParameter("last")!=null;




int sum=0;
Hits hits=null;
Searcher searcher = new IndexSearcher(f.getAbsolutePath());
BooleanQuery bq = new BooleanQuery();
if(isLast)
{
  BooleanQuery last=(BooleanQuery)session.getAttribute("last");
  if(last==null)isLast=false;
  if(isLast)bq.add(last,BooleanClause.Occur.MUST);
}
//  bq.setMaxClauseCount(Integer.MAX_VALUE);
Vector v=Lucene.findByLucenelist(lucenelist);
for(int i=0;i<v.size();i++)
{
  int id=((Integer)v.get(i)).intValue();
  Lucene obj=Lucene.find(id);
  if(!"q".equals(obj.getField()))
  {
    String field=obj.getField();
    if(obj.getQtype()==1)
    {
      String begin=request.getParameter(field+"_begin");
      String end=request.getParameter(field+"_end");
      if((begin!=null&&begin.length()>0)||(end!=null&&end.length()>0))
      {
        param.append("&").append(field).append("_begin=").append(begin);
        param.append("&").append(field).append("_end=").append(end);
        java.text.SimpleDateFormat sdf=new java.text.SimpleDateFormat("yyyy-MM-dd");
        try
        {
          if(begin!=null||begin.length()>0)
          {
            begin=sdf.format(sdf.parse(begin));
          }
          if(end==null||end.length()<1)
          {
            end="9999-12-30";
          }else
          {
            end=sdf.format(sdf.parse(end));
          }
          RangeQuery rq = new RangeQuery(new Term(field,begin), new Term(field,end), false);
          bq.add(rq,BooleanClause.Occur.MUST);
        }catch(java.text.ParseException pe)
        {}
      }
    }else
    {
      String value=request.getParameter(field);
      if(value!=null&&(value=value.trim()).length()>0)
      {
        param.append("&").append(field).append("=").append(java.net.URLEncoder.encode(value,"UTF-8"));
        switch(obj.getQtype())
        {
          case 0:
          Query query=new QueryParser(field,new StandardAnalyzer()).parse(value);
          bq.add(query,BooleanClause.Occur.MUST);
          break;

          case 1:
          break;

          case 2:
          TermQuery tq = new TermQuery(new Term(field,value));
          bq.add(tq,BooleanClause.Occur.MUST);
          break;
        }
      }
    }
  }
}
try
{
  if(keywords!=null && keywords.length()>0)
  {
    String group=request.getParameter("group");
    if(group!=null&&group.length()>0)
    {
      param.append("&group=").append(group);
      if(group.equals("media"))group+="name";
      Query query=new QueryParser(group,new StandardAnalyzer()).parse(keywords);
      bq.add(query,BooleanClause.Occur.MUST);
    }else
    {
      BooleanQuery bq2 = new BooleanQuery();
      for(int i=0;i<v.size();i++)
      {
        int id=((Integer)v.get(i)).intValue();
        Lucene lucene=Lucene.find(id);
        if(!"q".equals(lucene.getField()))
        {
          Query query=new QueryParser(lucene.getField(),new StandardAnalyzer()).parse(keywords);
          bq2.add(query,BooleanClause.Occur.SHOULD);
        }
      }
      bq.add(bq2,BooleanClause.Occur.MUST);
    }
    if(isLast)keywords=session.getAttribute("last_q")+" "+keywords;
  }else
  {
    //查找关键字///
    keywords=request.getParameter("content");
    if(keywords==null||keywords.length()<1)
    {
      keywords=request.getParameter("subject");
    }
    if(keywords==null)keywords="";
  }
  //排序
  Sort s=Sort.RELEVANCE;
  String st=ll.getSortType();
  if("".equals(st))s=new Sort(new SortField[]{new SortField("node", SortField.INT, true)});


  hits =searcher.search(bq,s);
  sum=hits.length();
  //
  String ua=request.getHeader("User-Agent");
  if(keywords.length()>0&&ua!=null)
  {
    if(ua.length() < 40||ua.indexOf("http://")!=-1)
    {
      FileOutputStream fos=new FileOutputStream("search_key.log",true);
      fos.write((tea.entity.MT.f(new Date(),1)+":"+keywords+"\t:\t"+ua).getBytes("GBK"));
      fos.close();
    }else
    {
      Keywords k=Keywords.find(community,keywords);
      k.set(sum,session.getId());//request.getRemoteAddr()
    }
  }

  session.setAttribute("last",bq);
  session.setAttribute("last_q",keywords);
}catch(Throwable ex)
{
  //System.out.println("网址："+request.getServerName()+request.getRequestURI()+"?"+request.getQueryString()+"\r\n错误："+ex.toString());
}
%>


<script src="/tea/tea.js" type=""></script>



<form name="searchform1" action="?">
<input type="hidden" name="node" value="<%=teasession._nNode%>"/>
<input type="hidden" name="community" value="<%=community%>"/>
<input type="hidden" name="lucenelist" value="<%=lucenelist%>"/>

<table width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr>

<td id="searchmenu">
<%
for(int i=0;i<v.size();i++)
{
  int id=((Integer)v.get(i)).intValue();
  Lucene lucene=Lucene.find(id);
  out.print(lucene.getBefore(teasession._nLanguage));
  out.print(lucene.getItypeToHtml(teasession));
  out.print(lucene.getAfter(teasession._nLanguage));
}

String results[]={String.valueOf(sum),keywords};
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
if(result1){
out.print(" <span id='searchsum'>输入字符串非法</span>");
}else{
out.print(" <span id='searchsum'>"+java.text.MessageFormat.format(r.getString(teasession._nLanguage,"Lucene.Results"),results)+"</span>");
}
out.print("<div id='searchdiv'><table border='0'>");
try
{
  if(hits == null||sum==0)
  {
	if(result1){
		keywords=MT.f(request.getParameter("q").replaceAll("\"","&quot;"));
	}
    out.print("<tr><td><br/><br/>"+tea.http.RequestHelper.format(r.getString(teasession._nLanguage,"Lucene.NotMatch"),keywords)+"<br/><br/>"+r.getString(teasession._nLanguage,"Suggestions")+"<br/></td></tr>");
  }else
  {
    for (int i=pos;i<(pos+10)&&i<sum;i++)
    {
      Document doc = hits.doc(i);
      int node=Integer.parseInt(doc.get("node"));
      Node n=Node.find(node);
      if(n.getTime()==null)//如果节点已被删除
        continue;

      String  urlpath="/html/node/"+node+"-"+teasession._nLanguage+".htm";


      String subject=doc.get("subject");
      String time=doc.get("time");
      String desc=doc.get("content");
      subject=n.getSubject(teasession._nLanguage);
      time=n.getTimeToString();
      desc=n.getText(teasession._nLanguage);
      subject=Lucene.htmlToText(subject);
      desc=Lucene.htmlToText(desc);


      NodePoints np=NodePoints.get(node);
      StringBuffer a=new StringBuffer("");
      boolean flag=false;
         float integral=0;
         if(np.getLlwz()>0)
          { if(teasession!=null)
             { if (teasession._rv!=null)
              {Profile profile=Profile.find(teasession._rv._strV);
               integral= profile.getIntegral();
              }
             }
         	  	if(integral<np.getLlwz()&&teasession!=null&&teasession._rv!=null)
         		a.append("<a  id='searchsubject' href='#' onclick=alert('对不起,您的积分不足,不能浏览该文章!');>");
         		else
         		a.append("<a   id='searchsubject' href='#' title=\"" +  n.getSubject(teasession._nLanguage) + "\"" +
          		" onclick=if(confirm(\"浏览该文件要扣减积分"+np.getLlwz()+
          		"是否继续\"))window.open('/html/node/"+node+"-"+teasession._nLanguage+".htm','_self');>");
          a.append(subject);
          a.append("</a>");
          flag=true;
          }
      int len=status==1?50:100;
      if(desc.length()>0)
      {
        String keys[]=keywords.split(" ");
        int beginindex=desc.indexOf(keys[0]);
        int endindex=desc.length();
        if(beginindex==-1)beginindex++;
        if(beginindex>40) beginindex=beginindex-30;
        if(endindex>beginindex+len)endindex=beginindex+len;
        desc=desc.substring(beginindex,endindex);
      }

      if(status==1)
      {
        out.print("<tr><td><b>"+(i+1)+"</b> ");
        if (flag)
        out.print(a.toString());
        else
        out.print(" <a href='"+urlpath+"' target='_blank' id='searchsubject'>"+subject+"</a>");
        out.print(" - <span id='searchcontent'>"+desc+"...</span>");
        if(urlpath.length()>15)
        urlpath=urlpath.substring(0,15)+"...";
        out.print(" - <font color='#008000'>http://"+request.getServerName()+":"+request.getServerPort()+urlpath+"</font></td></tr>"+ "<tr><td>&nbsp;</td></tr>");
      }else
      {
        subject=mark(keywords,subject);
        desc=mark(keywords,desc);

        out.print("<tr><td id='searchsubject'>");
         if (flag)
        out.print(a.toString());
        else
        out.print("<a href='"+urlpath+"' target='_blank'>"+subject+"</a>");
         if(n.getType()==39)
         {
        	 time = Report.find(node).getIssueTimeToString();
         }
        out.print("</td></tr>"+
        "<tr><td id='searchcontent'>"+desc+"...</td></tr>"+
        "<tr><td id='searchdetail'><font color='#00CC00'>http://"+request.getServerName()+":"+request.getServerPort()+urlpath+"&nbsp;&nbsp;"+r.getString(teasession._nLanguage,"Time")+":"+time+"</font></td></tr>"+
        "<tr><td>&nbsp;</td></tr>");
      }
    }

    Enumeration e3=Keywords.findByKeywords(community,keywords,10);
    if(e3.hasMoreElements())
    {
      out.print("<tr><td id='searchcorrelation'>"+r.getString(teasession._nLanguage,"Correlation")+":");
      while(e3.hasMoreElements())
      {
        String k=(String)e3.nextElement();
        out.print("<a href='?q="+java.net.URLEncoder.encode(k,"UTF-8")+"&amp;community="+community+"&amp;status="+status+"&amp;lucenelist="+lucenelist+"'>"+k+"</a> ");
      }
      out.print("</td></tr>");
    }
  }
}catch(Exception ex)
{
  ex.printStackTrace();
}finally
{
  searcher.close();
}
out.print("</table></div><div id = 'ali' align='center'>"+new tea.htmlx.FPNL(teasession._nLanguage,param.toString()+"&pos=",pos,sum,10) );

out.print("</div>");

%>
