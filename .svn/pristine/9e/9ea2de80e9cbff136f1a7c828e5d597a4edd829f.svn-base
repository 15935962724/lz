<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="tea.ui.TeaSession"%>
<%@ page import="org.apache.lucene.index.*"%>
<%@ page import="org.apache.lucene.search.*"%>
<%@ page import="tea.entity.util.*"%>
<%@ page import="tea.entity.node.*"%>
<%@ page import="tea.db.*"%>
<%@page import="org.apache.lucene.queryParser.*" %>
<%@page import="org.apache.lucene.analysis.standard.*" %>
<%@ page import="java.util.*"%>
<%@ page import="tea.entity.admin.map.*"%>
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


String _strPath=request.getParameter("t255_path");

String _strCity=request.getParameter("t21_city");


int pos=0;
String _strPos=request.getParameter("pos");
if(_strPos!=null)
{
	pos=Integer.parseInt(_strPos);
}

tea.resource.Resource r=new tea.resource.Resource("/tea/resource/Lucene");

java.io.File f=new java.io.File(application.getRealPath("/res/" + teasession._strCommunity + "/searchindex/"+lucenelist+"_"+teasession._nLanguage));
if(!f.exists())
{
//  response.sendRedirect("/jsp/info/Alert.jsp?info="+java.net.URLEncoder.encode(r.getString(teasession._nLanguage,"1169017432031"),"UTF-8"));//没有发现索引文件
//  return;
}

int count=0;

StringBuffer sql=new StringBuffer(" FROM Node n,NodeLayer nl,Company c WHERE n.community="+DbAdapter.cite(teasession._strCommunity)+" AND n.type=21 AND n.node=nl.node AND n.hidden=0 AND n.node=c.node");
String qs[]=null;
if(q!=null&&(q=q.trim()).length()>0)
{
	param.append("&t255_q=").append(java.net.URLEncoder.encode(q,"UTF-8"));
	qs=q.split(" ");
	sql.append(" AND(");
	for(int i=0;i<qs.length;i++)
	{
		if(i>0)
			sql.append(" AND ");
		sql.append(" nl.subject LIKE "+DbAdapter.cite("%"+qs[i]+"%"));
	}
	sql.append(")");
}
if(_strPath!=null&&_strPath.length()>0)
{
	param.append("&t255_path=").append(java.net.URLEncoder.encode(_strPath,"UTF-8"));
	sql.append(" AND n.path LIKE "+DbAdapter.cite("%/"+_strPath+"/%"));
}
if(_strCity!=null&&_strCity.length()>0)
{
	param.append("&t21_city=").append(java.net.URLEncoder.encode(_strCity,"UTF-8"));
	sql.append(" AND c.city LIKE "+DbAdapter.cite(_strCity+"%"));
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
	var iframe_csr=parent.document.getElementById("iframe_csr");
	if(iframe_csr)
	{
		var ifh=document.body.scrollHeight;
		var ifw=document.body.scrollWidth;

		iframe_csr.style.height=ifh+20;
		//iframe_csr.style.width=ifw;//+2;
	}
}
////////////////////////////
function show(n)
{
	var content='<div id="company_menu"><a href="javascript:f_c(0,'+n+');">基本信息</a><a href="javascript:f_c(1,'+n+');">推荐产品</a><a href="javascript:f_c(2,'+n+');">简介</a><a href="javascript:f_c(3,'+n+');">留言</a></div>'+
	'<iframe id=cbi name=cbi src=about:blank frameborder=0 width=100% ></iframe>';
	//d_box.style.width=580;
	//d_box.style.height=250;
	parent.showDialog(content);
	//document.getElementById('dialog_button').style.display="none";
	parent.f_c(0,n);
}
</script>
</head>
<body onLoad="fload();" id="resultbody">

<table id ="currentpage" >
<tr><td><b>企业</b> 当前位置:</td>
<td>行业类别:><b><%
if(_strPath!=null&&_strPath.length()>0)
{
	int id=Integer.parseInt(_strPath);
	Node n=Node.find(id);
	out.print(n.getSubject(teasession._nLanguage));
}
%></b></td>
<td>所在地区:><b><%
if(_strCity!=null&&_strCity.length()>0)
{
	int id=Integer.parseInt(_strCity);
	Card n=Card.find(id);
	out.print(n.toString());
}
%></b>
</td><td align="right">符合 <b><%=q%></b> 查询结果有 <b><span id=companycount>0</span></b> 个,用时 <b><span id=companytime>0</span></b> 秒.
</td></tr></table>


<table id="resultinfo">
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
		for (int l = 0; l < pos + 10 && db.next(); l++)
		{
			if (l >= pos)
			{
				int id=db.getInt(1);
				Node obj=Node.find(id);
				Company c=Company.find(id);
				String subject=obj.getSubject(teasession._nLanguage);
				String content=obj.getText(teasession._nLanguage);
				int i=content.indexOf(q)-10;
				if(i<0)
					i=0;
				int ch=i+35;
				if(ch>content.length())
					ch=content.length();
				content=content.substring(i,ch);

				if(qs!=null)
					for(int loop=0;loop<qs.length;loop++)
					{
						subject=subject.replaceAll(qs[loop],"<font color=#FF0000>"+qs[loop]+"</font>");
						content=content.replaceAll(qs[loop],"<font color=#FF0000>"+qs[loop]+"</font>");
					}
				int city=c.getCity(teasession._nLanguage);
				Card n=Card.find(city);

                                /////////////////////////////////////
				Mapabc map=Mapabc.find("id");

				String email=c.getEmail(teasession._nLanguage);
			%>
			  <tr>
			    <td><a id=companyname href="javascript:show(<%=id%>);" ><%=subject%></a> ( <%=n.toString()%> )  点击量:<%=obj.getClick()%></td>
			  </tr>
			  <tr>
			    <td>电话:<%=c.getTelephone(teasession._nLanguage)%> | 地址:<%=n.toString()%> <%=c.getAddress(teasession._nLanguage)%> 邮编:<a onClick="javascript:window.showModalDialog('http://channel.mapabc.com/openmap/map.jsp?id=A3A0654596&uid=7246&eid=102341&w=600&h=500','','edge:raised;help:0;resizable:1;dialogWidth:609px;dialogHeight:527px;');" href="###"><%=c.getZip(teasession._nLanguage)%></a></td>
			  </tr>
			  <tr>
			    <td><a href="<%=c.getWebPage(teasession._nLanguage)%>" target="_blank">网站</a>
			    | <%if(email!=null&&email.length()>0)out.print("<a href=mailto:"+email+">");%>电子邮件</a>
			    | <a id=companyurl onClick="javascript:window.showModalDialog('<%if(map.isExists()&&!map.isHidden())out.print("http://channel.mapabc.com/openmap/map.jsp?id="+map.getSid()+"&uid=7246&eid=102341&w=600&h=500");else out.print("/servlet/Node?node=2176405");%>','','edge:raised;help:0;resizable:1;dialogWidth:620px;dialogHeight:558px;');" href=###>地图名片</a>
			    | <a href="/servlet/Node?node=<%=id%>&Language=<%=teasession._nLanguage%>" target="_top">更多...</a></td>
			  </tr>
			  <tr>
			    <td><b>简介:</b><%=content%>...</td>
			  </tr>
			  <tr>
			    <td><b>行业:</b><%=Node.find(obj.getFather()).getSubject(teasession._nLanguage)%></td>
			  </tr>
			  <tr>
			    <td><br/></td>
			  </tr>
			<%
			}
		}
	}
}finally
{
	db.close();
}
out.print("<tr><td>"+new tea.htmlx.FPNL(teasession._nLanguage,param.toString()+"&pos=",pos,count,10));
%>
</table>
</form>
<script>
companycount.innerHTML="<%=count%>";
companytime.innerHTML="<%=(System.currentTimeMillis()-lo)/1000F%>";
</script>
<div id="adword">
<jsp:include flush="true" page="/jsp/adword/AdwordShow.jsp">
<jsp:param name="community" value="<%=teasession._strCommunity%>" />
</jsp:include>
</div>
</body>
</html>
