<%@page contentType="text/html; charset=UTF-8" %><%@page import="tea.ui.TeaSession"%><%@ page import="org.apache.lucene.index.*"%><%@ page import="org.apache.lucene.search.*"%><%@ page import="tea.entity.util.*"%><%@ page import="tea.entity.node.*"%><%@page import="tea.entity.*" %>
<%@page import="org.apache.lucene.queryParser.*" %><%@page import="org.apache.lucene.analysis.standard.*" %><%@page import="org.apache.lucene.document.*" %><%@ page import="java.util.*"%><%@ page import="java.io.*"%><%!

public static String red(String s, String q)
{
  if (s == null)
  return "";
  String qs[] = q.replaceAll("[()]", " ").split(" +");
  for (int i = 0; i < qs.length; i++)
  {
    s = s.replaceAll(qs[i], "<font color='red'>" + qs[i] + "</font>");
  }
  return s;
}

%><%

request.setCharacterEncoding("UTF-8");


Http h=new Http(request,response);

h.community="Home";
h.language=1;

File f=new File(application.getRealPath("/res/" + h.community + "/searchindex/e_news"));
if(!f.exists())
{
  out.print("<script>alert('抱歉索引文件丢失！');</script>");
  return;
}



StringBuffer par=new StringBuffer(request.getRequestURI());

String q=h.get("q","").replace('"',' ');
if(q.length()>64)q=q.substring(0,64);
par.append("?q=").append(Http.enc(q));



int type=h.getInt("type");
String[] TYPE_NAME={"subject","content","author"};
par.append("&type=").append(type);


//排序
int sort=h.getInt("sort");
Sort s=sort==0?new Sort(new SortField("time",SortField.STRING,true)):Sort.RELEVANCE;
par.append("&sort=").append(sort);


int pos=h.getInt("pos");
int sum=0;


%><!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%=q%>_电子报搜索</title>
<style type="text/css">
#detail {
	color: #00CC00;
    padding-bottom:20px
}
.cur{font-weight:bold}
body{text-align:center;padding:0px;margin:0px;}
.headerTop{background:url(/res/Home/1106/1106991.jpg) repeat-x left top;margin:0 auto;width:980px;height:132px;padding-top:13px;}
.headerTop img{border:0px;}
.content,.footerbottom{width:980px;margin:0 auto;font-size:14px;text-align:left;line-height:150%;}
.footerbottom{height:75px;background:#A90110;margin-top:10px;}
.content td,.content font{font-size:14px;line-height:150%;}
</style>
</head>

<body>
<div class="headerTop"><a href="/html/node/96173-1.htm" target="_blank"><img src="/res/Home/1106/1106993.jpg"></a></div>
<div class="content">
<form name="frms" action="?">
<input type="hidden" name="sort" value="<%=sort%>"/>
<table>
  <tr><td>
<input name="type" type="radio" value="0" <%=type==0?" checked":""%> />标题
<input name="type" type="radio" value="1" <%=type==1?" checked":""%> />内容
<input name="type" type="radio" value="2" <%=type==2?" checked":""%> />作者
  </td></tr>
  <tr><td><input name="q" value="<%=q%>" type="text" /><input type="submit" value="搜索"/></td></tr>
</table>

排序：<a href="javascript:f_q(0)" id="sort0">日期</a> <a href="javascript:f_q(1)" id="sort1">相关性</a>
<script type="">
function f_q(v)
{
  frms.sort.value=v;
  frms.submit();
}
document.getElementById('sort'+frms.sort.value).className='cur';
try
{
  frms.q.focus();
}catch(e)
{}
</script>
</form>


<%
if(q.length()<1)
{
  out.print("<div>抱歉，您还没有输入关键字。</div>");
}else
{
  Searcher searcher = new IndexSearcher(f.getAbsolutePath());
  try
  {
    Hits hits=searcher.search(new QueryParser(TYPE_NAME[type],new StandardAnalyzer()).parse(Lucene.f(q)),s);
    sum=hits.length();
    //
    Keywords k=Keywords.find(h.community,q);
    k.set(sum,request.getRemoteAddr());
    if(sum<1)
    {
      out.print("<div>抱歉，没有找到与“"+q+"”相关的内容。</div>");
    }else
    {
      for(int i=pos;i<(pos+10)&&i<sum;i++)
      {
        Document doc = hits.doc(i);
        int node=Integer.parseInt(doc.get("node"));
        Node n=Node.find(node);
        if(n.getTime()==null)//如果节点已被删除
        continue;
        Report r=Report.find(node);

        String urlpath=n.getClickUrl(h.language);//"/html/node/"+node+"-"+h.language+".htm";

        String subject=Lucene.t(n.getSubject(h.language)),content=Lucene.t(n.getText(h.language)),author=r.getAuthor(h.language);
        if(content.length()>100)content=content.substring(0,100);
        subject=red(subject,q);
        content=red(content,q);
        out.print("<div id='subject'><a href='"+urlpath+"' target='_blank'>"+subject+"</a><!--"+node+"--></div>"+
        "<div id='content'>"+content+"...</div>"+
        "<div id='detail'>作者:"+author+"&nbsp;&nbsp;时间:"+MT.f(n.getTime())+"</div>");
      }

      Enumeration e3=Keywords.findByKeywords(h.community,q,10);
      if(e3.hasMoreElements())
      {
        out.print("<div id='correlation'>相关搜索:");
        while(e3.hasMoreElements())
        {
          String key=(String)e3.nextElement();
          out.print("<a href='?q="+java.net.URLEncoder.encode(key,"UTF-8")+"'>"+key+"</a> ");
        }
        out.print("</div>");
      }
    }
  }catch(Exception ex)
  {
    ex.printStackTrace();
  }finally
  {
    searcher.close();
  }
}
%>
<%=new tea.htmlx.FPNL(h.language,par.toString()+"&pos=",pos,sum,10)%>
</div>
<div class="footerbottom"></div>
</body>
</html>
