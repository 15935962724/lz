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

StringBuffer par=new StringBuffer();
par.append("?community=").append(teasession._strCommunity);
par.append("&lucenelist=").append(lucenelist);

int city=0;
String tmp=request.getParameter("city");
if(tmp!=null&&tmp.length()>0)
{
  city=Integer.parseInt(tmp);
  par.append("&city=").append(city);
}
int father=0;
tmp=request.getParameter("father");
if(tmp!=null&&tmp.length()>0)
{
  father=Integer.parseInt(tmp);
  par.append("&father=").append(father);
}
int pos=0,size=10;
tmp=request.getParameter("pos");
if(tmp!=null&&tmp.length()>0)
{
  pos=Integer.parseInt(tmp);
}

String q=request.getParameter("q");
boolean bql=q!=null&&q.length()>0;
if(bql)
{
  par.append("&q=").append(java.net.URLEncoder.encode(q,"UTF-8"));
}



StandardAnalyzer sa=new StandardAnalyzer();
BooleanQuery bq = new BooleanQuery();

%>
<script>
function f_submit(f,n)
{
  var obj;
  if(f)
  {
    obj=document.all(f);
    obj.value=n;
  }
  obj.form.submit();
}
</script>
<%--
<table id="teble_all"  border="0" cellpadding="0" cellspacing="0" style="margin:0px;">
<tr>
<td valign="top">
<div id="fenlei">分类</div>

<table id="nodetree" border="0" cellpadding="0" cellspacing="0">
<tr><td>
<script type="text/javascript" src="http://<%=request.getServerName()+":"+request.getServerPort()%>/jsp/include/JsNodeTree.jsp?root=2196661&node=<%=father%>"></script>
<script type="">
function nt_open(id,a)
{
  form_sc2.father.value=id;
  form_sc2.submit();
  return false;
}
</script>
</td>
</tr>
</table>
</td><td valign="top" style="padding-left:20px;">
--%>

<form name="form_sc2" action="?">
<input type="hidden" name="lucenelist" value="<%=lucenelist%>"/>
<input type="hidden" name="father" value="<%=father%>"/>
<table id="tableform">
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td valign="top">关键字</td>
    <td valign="top"><input type="text" name="q" value="<%if(bql)out.print(q);%>" /></td>
    <td valign="top"><input type="submit" value="GO"/></td>
  </tr>
  <tr>
    <td valign="top">你的搜录:</td>
    <td valign="top">
<%
if(father!=0)
{
  Node f=Node.find(father);
  out.print("<a href=javascript:f_submit('father',0);>"+f.getSubject(teasession._nLanguage)+"</a>　");
  bq.add(new TermQuery(new Term("t255_path",String.valueOf(father))),BooleanClause.Occur.MUST);
}
%>
    </td>
    <td>&nbsp;</td>
  </tr>
</table>

</form>
<%
if(city!=0)
{
  //out.print("<a href=javascript:f_clear('city');>"+Card.find(city).getAddress()+"</a>　");
  bq.add(new TermQuery(new Term("t21_city",String.valueOf(city))),BooleanClause.Occur.MUST);
}
if(bql)
{
  bq.add(new QueryParser("t255_subject",sa).parse(q),BooleanClause.Occur.MUST);
}


par.append("&pos=");


long lo=System.currentTimeMillis();

IndexSearcher is=new IndexSearcher(fi.getAbsolutePath());
try
{
  Hits hits=is.search(bq);
  int count=hits.length();
  lo=System.currentTimeMillis()-lo;

  out.print("<table cellspacing=0 id=result><tr><td colspan=3 align=right>找到相关信息约"+count+" 篇，用时 "+(lo/1000F)+" 秒</td></tr>");
  for(int i=pos;i<(pos+size)&&i<count;i++)
  {
    Document doc = hits.doc(i);

    int id=Integer.parseInt(doc.get("t255_node")); //((Integer)e.nextElement()).intValue();
    Node n=Node.find(id);
//    String syncid=n.getSyncId();
//    if(syncid==null)
//    {
//      continue;
//    }
//    String rid=syncid.substring(syncid.indexOf('.')+1);//在代理商上的节点号
    Company c=Company.find(id);
    String domain=OpenID.find(n.getCreator()._strV).getProxy();
    String subject=n.getSubject(teasession._nLanguage);
    String tel=c.getTelephone(teasession._nLanguage);
    String fax=c.getFax(teasession._nLanguage);
    String url=c.getWebPage(teasession._nLanguage);
    boolean flag=url!=null&&url.startsWith("http://www.");
    if(bql)
    {
      subject=subject.replaceAll(q,"<font color='red'>"+q+"</font>");
    }
    String cn=i%2==0?"even":"odd";
    %>
    <tr class="<%=cn%>"><td></td></tr>
    <tr class="<%=cn%>"><td><div id="ptop"></div><a href='http://<%=domain%>/servlet/Company?node=<%=id%>' target='_blank'><%=subject%></a></td>
      <td class="tes"><div id="ptop"></div>
        <a id="te" href=http://www.mapabc.com/images/index_map4.gif target='_blank'>地图</a> | 
        <a id="te" href=http://www.mapabc.com/images/index_map4.gif target='_blank'>免费资讯</a>　
        <%
        if(flag)
        {
        out.print("<a class=ten href="+url+" target='_blank'>网站</a>");
      }
      %>
      <td class="pic" rowspan="3">
      <%
      if(flag)
      {
        int j=url.indexOf('/',10);
        if(j==-1)j=url.length();
        out.print("<img src=/res/pic/"+url.substring(7,j)+".jpg />");
      }
      %>
      </td>
</tr>
<tr class="<%=cn%>"><td colspan="2">电话:<%=tel%>
<%
if(fax!=null&&fax.length()>0)
{
  out.print("　传真:"+fax);
}
//Card.find(c.getCity(teasession._nLanguage)).toString()+
%>
<tr class="<%=cn%>"><td colspan="2"><%=c.getAddress(teasession._nLanguage)%><div id="ptop"></div></td></tr>
<tr class="jiange"><td colspan="3"></td></tr>
<%
}
out.print("<tr><td colspan=3 align=right>"+new tea.htmlx.FPNL(teasession._nLanguage,par.toString(),pos,count,size)+"</td></tr>");
out.print("</table>");
}finally
{
  is.close();
}


%>
<%--
</td></tr></table>
--%>
