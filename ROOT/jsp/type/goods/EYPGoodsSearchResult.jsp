<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="tea.ui.TeaSession"%>
<%@ page import="org.apache.lucene.index.*"%>
<%@ page import="org.apache.lucene.search.*"%>
<%@ page import="tea.entity.util.*"%>
<%@ page import="tea.entity.node.*"%>
<%@ page import="tea.entity.admin.*"%>
<%@ page import="tea.entity.member.*"%>
<%@ page import="tea.db.*"%>
<%@page import="org.apache.lucene.queryParser.*" %>
<%@page import="org.apache.lucene.analysis.standard.*" %>
<%@ page import="java.util.*"%>
<%!
java.util.Random ran=new java.util.Random();

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
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");

long lo=System.currentTimeMillis();

TeaSession teasession=new TeaSession(request);

int lucenelist=Integer.parseInt(request.getParameter("lucenelist"));

String q=request.getParameter("t255_q");
if(q==null)
	q="";

StringBuffer param=new StringBuffer();
param.append("?community=").append(teasession._strCommunity);
param.append("&lucenelist=").append(lucenelist);


String _strGoodstype=request.getParameter("t34_goodstype");

String _strShow=request.getParameter("show");
if(_strShow==null)
  _strShow="list";
else
  param.append("&show=").append(_strShow);

int pos=0;
String _strPos=request.getParameter("pos");
if(_strPos!=null)
{
	pos=Integer.parseInt(_strPos);
}

int size=20;
String _strSize=request.getParameter("size");
if(_strSize!=null)
{
	size=Integer.parseInt(_strSize);
	param.append("&size=").append(_strSize);
}

tea.resource.Resource r=new tea.resource.Resource("/tea/resource/Lucene");
/*
java.io.File f=new java.io.File(application.getRealPath("/res/" + teasession._strCommunity + "/searchindex_"+lucenelist+"/"+teasession._nLanguage));
if(!f.exists())
{
  response.sendRedirect("/jsp/info/Alert.jsp?info="+java.net.URLEncoder.encode(r.getString(teasession._nLanguage,"1169017432031"),"UTF-8"));//没有发现索引文件
  return;
}*/

int count=0;

StringBuffer sql=new StringBuffer(" FROM Node n,NodeLayer nl,Goods g WHERE n.community="+DbAdapter.cite(teasession._strCommunity)+" AND n.type=34 AND n.node=nl.node AND n.hidden=0 AND n.node=g.node");
if(q!=null&&(q=q.trim()).length()>0)
{
	param.append("&t255_q=").append(java.net.URLEncoder.encode(q,"UTF-8"));
	sql.append(" AND nl.subject LIKE "+DbAdapter.cite("%"+q+"%"));
}
if(_strGoodstype!=null&&_strGoodstype.length()>0)
{
	param.append("&t34_goodstype=").append(java.net.URLEncoder.encode(_strGoodstype,"UTF-8"));
	sql.append(" AND g.goodstype LIKE "+DbAdapter.cite("%/"+_strGoodstype+"/%"));
}

/*
org.apache.lucene.search.Hits hits=null;
org.apache.lucene.search.Searcher searcher=null;

searcher = new org.apache.lucene.search.IndexSearcher(f.getAbsolutePath());
try
{
	  BooleanQuery bq = new BooleanQuery();
	  if(q!=null)
	  {
		param.append("&t255_q=").append(java.net.URLEncoder.encode(q,"UTF-8"));
		Query query=new QueryParser("t255_q",new StandardAnalyzer()).parse(q);
		bq.add(query,BooleanClause.Occur.MUST);
	  }
	  if(_strPath!=null&&_strPath.length()>0)
	  {
		  param.append("&t255_path=").append(java.net.URLEncoder.encode(_strPath,"UTF-8"));
		  TermQuery tq = new TermQuery(new Term("t255_path",_strPath));
		  //Query query=new QueryParser("t255_path",new StandardAnalyzer()).parse(_strPath);
		  bq.add(tq,BooleanClause.Occur.MUST);
	  }
	  if(_strCity!=null&&_strCity.length()>0)
	  {
		  param.append("&t21_city=").append(java.net.URLEncoder.encode(_strCity,"UTF-8"));
		  TermQuery tq = new TermQuery(new Term("t21_city",_strCity));
		  //Query query=new QueryParser("t21_city",new StandardAnalyzer()).parse(_strCity);
		  bq.add(tq,BooleanClause.Occur.MUST);
	  }
	  hits = searcher.search(bq);
	  count=hits.length();
	  tea.entity.util.Keywords k=tea.entity.util.Keywords.find(teasession._strCommunity,q);
	  k.set(count);
  }catch(Exception e)
  {
	  e.printStackTrace();
  }
*/

%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<script>
function fload()
{
	var iframe_gsr=parent.document.getElementById("iframe_gsr");
	if(iframe_gsr)
	{
		var ifh=document.body.scrollHeight;
		var ifw=document.body.scrollWidth;
		iframe_gsr.style.height=ifh;
		//iframe_gsr.style.width=ifw;
	}
}
var clearint=setInterval("fload()",1);
</script>
</head>
<body onLoad="fload();clearInterval(clearint);" id="resultbody">

<table id ="currentpage" >
<tr><td>当前位置:</td>
<td>产品分类:><%
if(_strGoodstype!=null&&_strGoodstype.length()>0)
{
	int id=Integer.parseInt(_strGoodstype);
	GoodsType n=GoodsType.find(id);
	out.print(n.getName(teasession._nLanguage));
}
%></td>
<td>显示方式:<%
if("list".equals(_strShow))
{
	out.println("列");
}else
{
	out.println("<a href="+param.toString().replaceFirst("&show=","&")+"&show=list>列</a>");
}
if("grid".equals(_strShow))
{
	out.println("图");
}else
{
	out.println("<a href="+param.toString().replaceFirst("&show=","&")+"&show=grid>图</a>");
}
if("text".equals(_strShow))
{
	out.println("字");
}else
{
	out.println("<a href="+param.toString().replaceFirst("&show=","&")+"&show=text>字</a>");
}
%>
</td>
<td>每页显示数量:<%
if(20==size)
{
	out.println("20");
}else
{
	out.println("<a href="+param.toString().replaceFirst("&size=","&")+"&size=20>20</a>");
}
if(40==size)
{
	out.println("40");
}else
{
	out.println("<a href="+param.toString().replaceFirst("&size=","&")+"&size=40>40</a>");
}
if(80==size)
{
	out.println("80");
}else
{
	out.println("<a href="+param.toString().replaceFirst("&size=","&")+"&size=80>80</a>");
}
%>
</td>
<td align="right">找到相关信息 <span id=goodscount>0</span> 篇,用时 <span id=goodstime>0</span> 秒.
</td></tr></table>

<form action="/servlet/Node" target="_blank" name="form1">
<input type=hidden name=Node value="156633">
<div id="resultinfo">
<li id="goodstitle"><span><input type=submit value=对比商品 onClick="if(form1.nodes.checked) return true; for(var i=0;i<form1.nodes.length;i++)if(form1.nodes[i].checked) return true; alert('请选择对比的商品');return false;" ></span>
<span id="smallpicture"></span><span id=goodsname>产品名称</span><span  id=goodsprice>产品价格</span><span  id=goodscompany>相关企业</span>

</li>


<%--
if(hits == null||count==0)
{
  out.print("<tr><td ><br><br>"+tea.http.RequestHelper.format(r.getString(teasession._nLanguage,"Lucene.NotMatch"),q)+"<br/><br/>"+r.getString(teasession._nLanguage,"Suggestions")+
  "<br>"+
  "</td></tr>");
}else
{
    org.apache.lucene.document.Document doc = null;
    for (int i = pos;i<(pos+10)&&i < count; i++)
    {
      doc = hits.doc(i);
      //hits.score(i)//相关度
      String urlpath="/servlet/Node?node="+doc.get("t255_node")+"&Language="+teasession._nLanguage;
      String subject=doc.get("t255_subject");
      String time=doc.get("t255_time");
      String desc=doc.get("t255_content");

      int len=desc.length();
      int id=i;

      String keys[]=q.split(" ");
      int beginindex=desc.indexOf(keys[0]);
      int endindex=desc.length();
      if(beginindex==-1&&endindex>512)
      {
        beginindex=ran.nextInt(endindex-100);
      }else
      if(beginindex>40)
      beginindex=beginindex-30;
      if(endindex>beginindex+100)
      {
        endindex=beginindex+100;
      }
      desc=desc.substring(beginindex+1,endindex);

      subject=mark(q,subject);
      desc=mark(q,desc);

      out.print("  <tr>"+
      "    <td id=searchsubject ><A href="+urlpath+" target=_blank>"+subject+"</A></td>"+
      "  </tr>"+
      "  <tr>"+
      "    <td id=searchcontent >"+(desc)+"</td>"+
      "  </tr>"+
      "  <tr>"+
      "    <td id=searchdetail  ><font color=#00CC00 >"+urlpath+"&nbsp;&nbsp;"+r.getString(teasession._nLanguage,"Time")+":"+time+"</font></td>"+
      "  </tr>"+
      "  <tr>"+
      "    <td>&nbsp;</td>"+
      "  </tr>");
      }

      java.util.Enumeration correlationenumer=tea.entity.util.Keywords.findByKeywords(teasession._strCommunity,q,10);
      if(correlationenumer.hasMoreElements())
      {
    	out.print("<tr><td id=searchcorrelation  >"+r.getString(teasession._nLanguage,"Correlation")+":");
        while(correlationenumer.hasMoreElements())
        {
          String k=(String)correlationenumer.nextElement();
          out.print("<A href="+request.getRequestURI()+"?t255_q="+java.net.URLEncoder.encode(k,"UTF-8")+"&community="+teasession._strCommunity+" >"+k+"</A> ");
        }
      }
}
if(searcher!=null)
 searcher.close();

out.print("</table></div><div align=center>"+new tea.htmlx.FPNL(teasession._nLanguage,param.toString()+"&pos=",pos,count,10) );
if(count>10)
{
  String results[]={String.valueOf(count),q};
  out.print(" <span id=searchsum>"+java.text.MessageFormat.format(r.getString(teasession._nLanguage,"Lucene.Results"),results)+"</span>");
}
--%>

<%
DbAdapter db=new DbAdapter();
try
{
	count=db.getInt("SELECT COUNT(n.node) "+sql.toString());
	if(count<1)
		out.print("无记录...");
	else
	{
		db.executeQuery("SELECT DISTINCT n.node "+sql.toString());
		for (int l = 0; l < pos + size && db.next(); l++)
		{
			if (l >= pos)
			{
				int id=db.getInt(1);
				Node obj=Node.find(id);
				String subject=obj.getSubject(teasession._nLanguage);
				if(subject==null)
					subject="";
				else
					subject=subject.replaceAll(q,"<font color=#FF0000>"+q+"</font>");
				Goods g=Goods.find(id,teasession._nLanguage);
				
				Node obj2=Node.find(g.getCompany());
				String company=obj2.getSubject(teasession._nLanguage);
				if(company==null)
					company="";

				AttributeValue av=AttributeValue.find(id,165);
				String price=av.getAttrvalue(teasession._nLanguage);
				if(price==null)
					price="";
				if("list".equals(_strShow))
				{
					%>
					  <li id=goodslei> <span id="duibikuang"><input type=checkbox name=nodes value="<%=id%>" ></span><span id="goodspicture"><img id="smallpicture" src="<%=g.getSmallpicture()%>"></span>
					  <span id=goodsname><a href="/servlet/Node?node=<%=id%>" target="_blank"><%=subject%></a><br>
  					   <INPUT TYPE="BUTTON" VALUE="加入收藏" ID="CBAddToFavorites" onClick="window.open('/servlet/AddToFavorite?node=<%=id%>');"/></span>
					  <span id=goodsprice><%=price%></span>
					<span id=goodscompany><a href="/servlet/<%=g.getCompany()%>" target="_blank"><%=company%></a></span>
					  </li>
					<%
				}else if("grid".equals(_strShow))
				{
					%>
					 <li id=goodstu><span><img id="smallpicture" src="<%=g.getSmallpicture()%>"></span>
					 <span id=goodsname><input type=checkbox name=nodes value="<%=id%>" ><a id=goodsname href="/servlet/Node?node=<%=id%>" target="_blank"><%=subject%></a></span>
  					  <span id=goodscompany><a href="/servlet/<%=g.getCompany()%>" target="_blank"><%=company%></a></span>
 					 <INPUT TYPE="BUTTON" VALUE="加入收藏" ID="CBAddToFavorites" onClick="window.open('/servlet/AddToFavorite?node=<%=id%>');"/>
					 </li>
					<%			
				}else if("text".equals(_strShow))
				{
					%>
					  <li id=goodszi><span id="duibikuang"><input type=checkbox name=nodes value="<%=id%>" ></span>
					  <span id=goodsname><a href="/servlet/Node?node=<%=id%>" target="_blank"><%=subject%></a><br> 
  					  <INPUT TYPE="BUTTON" VALUE="加入收藏" ID="CBAddToFavorites" onClick="window.open('/servlet/AddToFavorite?node=<%=id%>');"/> </span>
					  <span id=goodsprice><%=price%></span>
					 <span id=goodscompany><a href="/servlet/<%=g.getCompany()%>" target="_blank"><%=company%></a></span>
					  </li>
					<%
				}
			}
		}
	}
}finally
{
	db.close();
}
out.print("<li><span>"+new tea.htmlx.FPNL(teasession._nLanguage,param.toString()+"&pos=",pos,count,size)+"</span></li>");
%>
</div>
</form>
<script>
goodscount.innerHTML="<%=count%>";
goodstime.innerHTML="<%=(System.currentTimeMillis()-lo)/1000F%>";

var sp=document.all('smallpicture');
if(sp)
for(var i=0;i<sp.length;i++)
{
  if(sp[i].width>sp[i].height)
  {
	sp[i].width=80;
  }else
  {
  	sp[i].height=80;
  }
}
</script>
<div id="adword">
<jsp:include flush="true" page="/jsp/adword/AdwordShow.jsp">
<jsp:param name="community" value="<%=teasession._strCommunity%>" />
</jsp:include>
</div>
</body>
</html>
