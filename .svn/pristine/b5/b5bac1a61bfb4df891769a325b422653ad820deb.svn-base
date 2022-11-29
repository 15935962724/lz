<%@page contentType="text/html; charset=UTF-8" %>
<%@page import="tea.ui.TeaSession"%>
<%@ page import="org.apache.lucene.index.*"%>
<%@ page import="org.apache.lucene.search.*"%>
<%@ page import="tea.entity.util.*"%>
<%@ page import="tea.entity.node.*"%>
<%@page import="org.apache.lucene.queryParser.*" %>
<%@page import="org.apache.lucene.analysis.standard.*" %>
<%@page import="org.apache.lucene.document.*" %>
<%@ page import="java.util.*"%>
<%@ page import="tea.entity.bpicture.*" %>
<%!
Random ran=new Random();

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
%>

<%
request.setCharacterEncoding("UTF-8");
response.setHeader("progma","no-cache");
response.setHeader("Cache-Control","no-cache");
response.setDateHeader("Expires",0);
TeaSession teasession=new TeaSession(request);
String community=teasession._strCommunity;
String lightbox = request.getParameter("lightbox");
if(teasession._rv!=null){
  Bperson bp = Bperson.find(Bperson.findId(teasession._rv._strR));
  if(lightbox==null)
  {
    lightbox = bp.getCurrentlightbox();
  }
}
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

java.io.File f=new java.io.File(application.getRealPath("/res/" + community + "/searchindex/"+lucenelist+"_"+teasession._nLanguage));
if(!f.exists())
{
  response.sendRedirect("/jsp/info/Alert.jsp?info="+java.net.URLEncoder.encode(r.getString(teasession._nLanguage,"1169017432031"),"UTF-8"));//没有发现索引文件
  return;
}


int status=teasession._nStatus;


long lo=System.currentTimeMillis();

String keywords=request.getParameter("t255_q");
if(keywords==null)
keywords="";
else
if((keywords=keywords.trim()).length()>64)
{
  keywords=keywords.substring(0,64);
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
param.append("&t255_q=").append(java.net.URLEncoder.encode(keywords,"UTF-8"));



int type=0;
if("1".equals(request.getParameter("type")))
type=1;

param.append("&type=").append(type);



int pos=0;
if(request.getParameter("pos")!=null)
pos=Integer.parseInt(request.getParameter("pos"));





int sum=0;
org.apache.lucene.search.Hits hits=null;
org.apache.lucene.search.Searcher searcher=null;

searcher = new org.apache.lucene.search.IndexSearcher(f.getAbsolutePath());
BooleanQuery bq = new BooleanQuery();
//  bq.setMaxClauseCount(Integer.MAX_VALUE);
Vector v=Lucene.findByLucenelist(lucenelist);
for(int i=0;i<v.size();i++)
{
  int id=((Integer)v.get(i)).intValue();
  Lucene obj=Lucene.find(id);
  if(!"q".equals(obj.getField()))
  {
    String name="t"+obj.getNtype()+"_"+obj.getField();
    if(obj.getQtype()==1)
    {
      String begin=request.getParameter(name+"_begin");
      String end=request.getParameter(name+"_end");
      if((begin!=null&&begin.length()>0)||(end!=null&&end.length()>0))
      {
        param.append("&").append(name).append("_begin=").append(begin);
        param.append("&").append(name).append("_end=").append(end);
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
          RangeQuery rq = new RangeQuery(new Term(name,begin), new Term(name,end), false);
          bq.add(rq,BooleanClause.Occur.MUST);
        }catch(java.text.ParseException pe)
        {}
      }
    }else
    {
      String value=request.getParameter(name);
      if(value!=null&&(value=value.trim()).length()>0)
      {
        param.append("&").append(name).append("=").append(java.net.URLEncoder.encode(value,"UTF-8"));
        switch(obj.getQtype())
        {
          case 0:
          Query query=new QueryParser(name,new StandardAnalyzer()).parse(value);
          bq.add(query,BooleanClause.Occur.MUST);
          break;

          case 1:
          break;

          case 2:
          TermQuery tq = new TermQuery(new Term(name,value));
          bq.add(tq,BooleanClause.Occur.MUST);
          break;
        }
      }
    }
  }
}
try
{
  if(keywords.length()>0)
  {
    String group=request.getParameter("group");
    if(group!=null&&group.length()>0)
    {
      param.append("&group=").append(group);
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
          String name="t"+lucene.getNtype()+"_"+lucene.getField();
          Query query=new QueryParser(name,new StandardAnalyzer()).parse(keywords);
          bq2.add(query,BooleanClause.Occur.SHOULD);
        }
      }
      bq.add(bq2,BooleanClause.Occur.MUST);
    }
  }else
  {
    //查找关键字///
    keywords=request.getParameter("t255_content");
    if(keywords==null||keywords.length()<1)
    {
      keywords=request.getParameter("t255_subject");
    }
    if(keywords==null)keywords="";
  }
  hits =searcher.search(bq);
  sum=hits.length();
  //
  if(keywords.length()>0)
  {
    Keywords k=Keywords.find(community,keywords);
    k.set(sum);
  }
}catch(org.apache.lucene.queryParser.ParseException pe)
{
  System.out.println(keywords);
}
String url = request.getRequestURI();

int pageSize = 5;
if (request.getParameter("npgs") != null) {
  pageSize = Integer.parseInt(request.getParameter("npgs"));
}
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<title>图片查询</title>
<style type="text/css">
.lzj_a{margin:0 10px;color:#0000CC; text-decoration:none;}
#my-B-picture{color:#000;font-weight:bold;text-decoration:none;margin:0 10px;}

#qt{width:210px;height:23px;border:1px solid #809EBA;background:#fff;}
#lzj_bg{font-size:12px;}
#lzj_bg a{color:#0000cc;}
#lzj_an{width:45px;height:23px;background:url(/res/bigpic/u/0812/081243710.jpg) no-repeat;border:0;margin:0 10px;}
.kuan{border:0;}
#tablecenter001{border-top:1px solid #67A7E4;background:#D6E6FF;font-size:12px;color:#012DA8;}
.padleft{padding-left:10px;}
.top{border-top:1px solid #cccccc;margin-top:15px;}
.top td{font-size:12px;line-height:150%;}
.top a{color:0000cc;}
#lzj_cz{align:left;line-height:150%;}
#lzj_zi{font-weight:bold;}

#sear1{float:left;width:160px;margin-left:70px;}
#sear{display:block;width:160px;text-align:center;margin-left:70px;margin-bottom:5px;}
</style>

<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/load.js" type="text/javascript"></SCRIPT>
<script type="">
function add_cart(me)
{

  var rv = '<%=teasession._rv%>';

  if(rv == 'null')
  {

    window.location.href='/jsp/user/StartLogin.jsp?nexturl=<%=url%>';
  }else{
    currentPos = 'cart_'+me;
    var url = "/jsp/bpicture/Lightbox_ajax.jsp?act=cart&pic="+me+"&lightbox=<%=lightbox%>";
    url = encodeURI(url);
    send_request(url);
  }
}
function c_jax(me)
{

  var rv = '<%=teasession._rv%>';
  if(rv == 'null')
  {
    window.location.href='/jsp/user/StartLogin.jsp?nexturl=<%=url%>';
  }else{
    currentPos = 'lit_'+me;
    var url = "/jsp/bpicture/Lightbox_ajax.jsp?act=lit&pic="+me;
    url = encodeURI(url);
    send_request(url);
  }
}

function currn_jax(me)
{

  currentPos = me;
  var url = "/jsp/bpicture/buyer/CurrentLightbox_ajax.jsp?lightbox="+me.value;
  url = encodeURI(url);
  send_request(url);
}

</script>
</head>
<body style="margin:0;padding:0;">


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
  searchform1.t255_q.focus();
}catch(e)
{}
</script>

</form>
<h2><a href="/jsp/bpicture/" >首页</a>  &gt; 搜索结果</h2>
<table width=100% cellpadding=2 cellspacing=0 border=0 id="tablecenter001">
  <form name="fm" action="?">
  <input type="hidden" name="t255_subject" value="<%if(keywords!=null)out.print(keywords);%>"/>
<input type="hidden" name="pos" value="<%if(pos!=0){out.print(pos);}else{out.print("0");}%>"/>
<input type="hidden" name="node" value="<%=teasession._nNode%>"/>
<input type="hidden" name="community" value="<%=community%>"/>
<input type="hidden" name="lucenelist" value="<%=lucenelist%>"/>
    <tr>
      <td width=90% nowrap class="padleft">图片<%="("+sum+")"%></td>

      <td width=5% nowrap>每页图片数目:</td>
      <td width=5% class="padright"><select name="npgs" class=button onChange="document.fm.submit();">
        <OPTION value="5" <%if(pageSize == 5)out.print("selected");%>>5</OPTION>

        <OPTION value="10" <%if(pageSize == 10)out.print("selected");%>>10</OPTION>
        <OPTION value="20" <%if(pageSize == 20)out.print("selected");%>>20</OPTION>
        <OPTION value="40" <%if(pageSize == 40)out.print("selected");%>>40</OPTION>
</select>
      </td>
    </tr>
  </form>
</table>
<%

out.print("<div id='searchdiv'><table border='0'>");
try
{
  if(hits == null||sum==0)
  {
    out.print("<tr><td><br/><br/>"+tea.http.RequestHelper.format(r.getString(teasession._nLanguage,"Lucene.NotMatch"),keywords)+"<br/><br/>"+r.getString(teasession._nLanguage,"Suggestions")+"<br/></td></tr>");
  }else
  {
    for (int i=pos;i<(pos+pageSize)&&i<sum;i++)
    {
      Document doc = hits.doc(i);
      int node=Integer.parseInt(doc.get("t255_node"));
      Node n=Node.find(node);
      if(n.getTime()==null)//如果节点已被删除
      {
        continue;
      }
      String subject=doc.get("t255_subject");
      String time=doc.get("t255_time");
      String desc=doc.get("t255_content");
      subject=n.getSubject(teasession._nLanguage);
      subject=Lucene.htmlToText(subject);
      Picture p = Picture.find(node);
      Baudit ba = Baudit.find(node);
      String rfl = "";
      if(ba.getProperty() == 2)
      {
        rfl="(L)";
      }else{
        rfl="(RF)";
      }
      String picture ="/res/"+teasession._strCommunity+"/picture/"+node+".jpg";

      out.print("<div id=sear1>");
      out.print("<span id=sear><a href=# onclick=window.open('/jsp/bpicture/ImageInfo.jsp?nodes="+node+"','_blank'); ><img src="+picture+" border=0 width=160 /></a></span><span id=sear>"+n.getSubject(1)+"&nbsp;-&nbsp;"+rfl+"</span>");
      out.print("<span id=sear><a href=# onclick='c_jax("+node+")'><span id=lit_"+node+"><img src=/tea/image/bpicture/add_lightbox.gif alt=添加至图库 width=17 height=17 border=0 name=l1></span></a>");
      out.print("&nbsp;<a href=# onclick='add_cart("+node+")'><span id=cart_"+node+"><img width=17 height=17 border=0 src=/tea/image/bpicture/add_cart.gif alt=放入购物车></span></a>");
      out.print("&nbsp;<a href=/jsp/bpicture/buyer/CalPrice.jsp?nexturl="+request.getRequestURI()+"&nodes="+node+"><img width=17 height=17 border=0 src=/tea/image/bpicture/cal_price.gif alt=计算价格></a>");
      out.print("</span></div>");
    }


  }
  if(searcher!=null)
  searcher.close();
}catch(Exception ex)
{
  ex.printStackTrace();
}
out.print("</table></div><div id = 'ali' align='center'>"+new tea.htmlx.FPNL(teasession._nLanguage,param.toString()+"&pos=",pos,sum,pageSize) );

out.print("</div>");

%>

<div style="padding-top:10px;">
<%
if(teasession._rv!=null){
  %>
       <form id="frmMain" name="frm1" action="?" method="get">
  <table width=100% cellpadding=2 cellspacing=0 border=0 id="tablecenter001" style="border:0;">
    <tr class=bg8>

      <td width="90%" class="padleft">当前图库</td>
      <td width="10%" class="padright">
        <select id="Lightboxes" class="lightbox" name="lightbox" onChange="currn_jax(this)" style="WIDTH: 264;">
        <%
        Enumeration e = BLightbox.findLightBox(teasession._rv._strR);
        if(e.hasMoreElements()){
          while(e.hasMoreElements()){
            String elment = e.nextElement().toString();
            if(lightbox.equals(elment)){
              out.print("<option value="+elment+" selected>"+elment+"</option>");
            }else{
              out.print("<option value="+elment+">"+elment+"</option>");
            }
          }
        }
        %>

        </select>

      </td>

    </tr>
  </table>
  </form>
  <%}%>
</div>
</body>
</html>



