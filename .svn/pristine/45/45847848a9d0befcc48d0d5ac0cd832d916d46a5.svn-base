<%@page contentType="text/html; charset=UTF-8" %>
<%@page import="java.io.*" %>
<%@page import="java.util.*" %>
<%@page import="tea.ui.*" %>
<%@page import="tea.db.*" %>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.entity.util.*" %>
<%@page import=" tea.entity.admin.Supply" %>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="org.apache.lucene.index.*" %>
<%@page import="org.apache.lucene.search.*" %>
<%@page import="org.apache.lucene.document.*" %>
<%@page import="org.apache.lucene.queryParser.*" %>
<%@page import="org.apache.lucene.analysis.standard.*" %>
<%
TeaSession teasession=new TeaSession(request);

int lucenelist=27;//
//if(request.getParameter("lucenelist")!=null && request.getParameter("lucenelist").length()>0)
//      lucenelist = Integer.parseInt(request.getParameter("lucenelist"));
//File fi=new File(("X:/edn/ROOT/res/" + teasession._strCommunity + "/searchindex_"+lucenelist+"/"+teasession._nLanguage));
File fi=new File(application.getRealPath("/res/" + teasession._strCommunity + "/searchindex/"+lucenelist+"_"+teasession._nLanguage));
if(!fi.exists())
{
  response.sendRedirect("/jsp/info/Alert.jsp?info="+java.net.URLEncoder.encode("没有发现索引文件","UTF-8"));//没有发现索引文件
  return;
}


//StringBuffer sql = new StringBuffer();
IndexSearcher is=new IndexSearcher(fi.getAbsolutePath());
StandardAnalyzer sa=new StandardAnalyzer();
BooleanQuery bq = new BooleanQuery();
//new Sort(new SortField[]...{
//     new SortField("orderby"),
//     SortField.FIELD_SCORE
//}
java.util.Date d = new java.util.Date();
//sql.append(" and node in (select node from Node where  hidden =0 and type = 32 and stoptime >= "+DbAdapter.cite(d)+" )");
StringBuffer param = new StringBuffer("?community=" + teasession._strCommunity);
int city=0;
String tmp=request.getParameter("city");

if(tmp!=null&&tmp.length()>0)
{
  city=Integer.parseInt(tmp);
}
if(city!=0)
{
   bq.add(new TermQuery(new Term("t32_city",String.valueOf(city))),BooleanClause.Occur.MUST);
  //sql.append(" and city like ").append("").append(DbAdapter.cite(city+"%"));
  param.append("&city=").append(city);
}

int father=0;
tmp=request.getParameter("father");
if(tmp!=null&&tmp.length()>0)
{
  father=Integer.parseInt(tmp);
}
if(father!=0)
{
   bq.add(new TermQuery(new Term("t255_path",String.valueOf(father))),BooleanClause.Occur.MUST);
 // sql.append(" and ( industrytype1 = "+father+" or industrytype2 ="+father+") ");
  param.append("&father=").append(father);
}



String q=request.getParameter("q");

boolean bql=q!=null&&q.length()>0&&!"null".equals(q);

if(bql)
{
  bq.add(new QueryParser("t255_subject",sa).parse(q),BooleanClause.Occur.MUST);
  param.append("&q=").append(q);
}
int newstype = -1;
if(teasession.getParameter("newstype")!=null && teasession.getParameter("newstype").length()>0)
   newstype = Integer.parseInt(teasession.getParameter("newstype"));
if(newstype!=-1)
{
   bq.add(new TermQuery(new Term("t32_newstype",String.valueOf(newstype))),BooleanClause.Occur.MUST);
   param.append("&newstype=").append(newstype);
}

boolean ajax=request.getParameter("ajax")!=null;

 int pos = 0, size = 6;
  if (request.getParameter("pos") != null) {
    pos = Integer.parseInt(request.getParameter("pos"));
  }
  long lo=System.currentTimeMillis();
  try
  {
  Hits hits = is.search(bq,new Sort(new SortField("t255_time",true)));//new MySortComparatorSource()
 // Hits hits=is.search(bq);
  int count=hits.length();

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

function f_size()
{
  win.height=document.body.scrollHeight;
  win.width=document.body.scrollWidth;
}
//function show(n,hits)
//{
//  var title='<span id="company_menu"><a href="javascript:f_c(0,'+n+');">基本信息</a><a href="javascript:f_c(1,'+n+');">推荐产品</a><a href="javascript:f_c(2,'+n+');">简介</a><a href="javascript:f_c(3,'+n+');">留言</a></span>';
//  var footer=location.host+"浏览统计"+hits+"次 | <a href=/servlet/AddToFavorite?node="+n+" target=_blank>收藏</a>";
//  parent.showDialog(title,"about:blank",footer,373,225,"<a href=http://www.redcome.com/ target=_blank><img src=/res/lib/u/0805/080565370.jpg></a>");
//  parent.f_c(0,n);
//}
function f_act(igd)
{
  form1.newstype.value=igd;
  form1.action="?";
  form1.submit();
}
function f_clear(n)
{
  //var obj;
//  if(n)
//  {
//    obj=parent.document.all(n);
//    obj.value='';
//  }else
  //{
    obj=parent.document.all("father");
    obj.value=n;
    obj=parent.document.all("city");
    obj.value=0;
    obj=parent.document.all("q");
    obj.value='';
//    obj=parent.document.all("newstype");
//    obj.value='';

//   form1.father.value=n;
//   form1.city.value=0;
//   form1.q.value='';
//   form1.newstype.value='';

 // }
  //form1.action="?";
  //parent.document.form1.submit();
  obj.form.submit();
}
function show(n,hits)
{
  //<a href="javascript:f_c(1,'+n+');">推荐产品</a>
  var title='<span id="company_menu"><a href=javascript:; onclick="f_c(this,0,'+n+');">名 片</a><a href=javascript:; onclick="f_c(this,1,'+n+');">企业简介</a><a href=javascript:; onclick="f_c(this,2,'+n+');">给我留言</a><a href=javascript:; onclick="f_c(this,3,'+n+');">在线洽谈</a><a href=javascript:; onclick="f_c(this,4,'+n+');">免费通话</a></span>';
  var footer=location.host+"浏览统计"+hits+"次 | <a href=/servlet/AddToFavorite?node="+n+" target=_blank>收藏</a>";
  parent.showDialog(title,"/jsp/type/company/windows/CompanyBasicinfo.jsp?node="+n,footer,373,225,"<a href=http://www.redcome.com/ target=_blank><img src=/res/lib/u/0805/080565370.jpg></a>");
  //parent.f_c(0,n);
}
</script>
</head>
<body onLoad="f_load()" >
<form action="?" method="POST" name="form1">
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter_free">
<tr>
<td id="tablecenter_td01"><%
if(city!=0){
  out.print("<span id=city01>"+Card.find(city).toString()+"</span>" );
}else
{
   out.print("<span id=city01>全部城市</span>");
}
out.print(" | ");
if(father!=0){
  Node nn = Node.find(father);
  out.print(nn.getSubject(teasession._nLanguage));
}else
{
   out.print("全部类别");
}
out.print("　<a id=teshu01 href=javascript:f_clear('2196711');>取消全部条件</a>");
%></td><td id="tablecenter_td02"><a href="#">帮助</a></td><td id="tablecenter_td03"><a href="/jsp/type/supply/EditSupply.jsp?nexturl=/servlet/Folder?node=2196662&language=1" target="_blank"><img src="/res/lib/u/0804/080415894.jpg"></a></td>
</tr>
</table>

<input type="hidden" name="city" value="<%=city%>"/>
<input type="hidden" name="father" value="<%=father%>"/>
<input type="hidden" name="q" value="<%=q%>"/>.
<input name="lucenelist" type="hidden" value="26" />
<input type="hidden" name="newstype" />
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter_gongqiu">
<tr>
<td>
  <div id="gongqiu"><span id="gongqiu_left"><a href="javascript:f_act('-1');" >全部信息</a> | <a href="javascript:f_act('0');" >供应信息</a> | <a href="javascript:f_act('1');">求购信息</a></span><span id="gongqiu_right">
  共有<font><%=count %></font>条信息</span></div>
</td>
</tr>
    <%


  lo=System.currentTimeMillis()-lo;
  StringBuffer sb=new StringBuffer();
	out.print("<tr><td id=juzhong><table border=0 cellpadding=0 cellspacing=0 id=tablecenter_gongqiu_nei>");
//        if(count==0)
//        {
//
//            out.print("<tr><td colspan=10 align=center>暂无记录</td></tr>");
//        }
        for(int i=pos;i<(pos+size)&&i<count;i++)
        {
          Document doc = hits.doc(i);

          int ids=Integer.parseInt(doc.get("t255_node")); //((Integer)e.nextElement()).intValue();
          Node n=Node.find(ids);

          tea.entity.admin.Supply sobj = tea.entity.admin.Supply.find2(teasession._strCommunity,ids);
          Company c=Company.find(sobj.getCompany());
         Node n2 = Node.find(sobj.getCompany());
    %>

    <tr>
    <td <%if(i==1)out.print(" id=gongqiu_01");else{out.print(" id=gongqiu_td01");}%>><img src="<%if(sobj.getPicpath()!=null&&sobj.getPicpath().length()>0){out.print(sobj.getPicpath());}else{out.print("/res/lib/u/0805/080561405.jpg");}%>"></td>
      <td <%if(i==1)out.print(" id=gongqiu_02");else{out.print("id=gongqiu_td02");}%>>
	  <div><a href="javascript:show('<%=sobj.getCompany()%>','<%=n.getClick()%>')"><%=n2.getSubject(teasession._nLanguage) %></a>

</div>
      <font>名　　称：</font><a href="/servlet/Node?node=<%=sobj.getNode()%>"  target=_blank> <%=n.getSubject(teasession._nLanguage)%></a><br>
        <font>信息类型：</font><%=Supply.NEWS_TYPE[sobj.getNewstype()] %><br><font>所属地区：</font><%=Card.find(sobj.getCity())%><br>
          <font>有 效 期：</font><%=Supply.TERM[sobj.getTerm()] %><br><font>联系地址：</font><%=c.getAddress(teasession._nLanguage)%><br>
            <font>邮　　编：</font><%=c.getZip(teasession._nLanguage)%><br><font>联系电话：</font><%=c.getTelephone(teasession._nLanguage)%><br>
              <font>联 系 人：</font><%=c.getContact(teasession._nLanguage)%><br><font>详细描述：</font><%=sobj.getContent()%></td>
</tr>
    <%} %>
	</table>
</td></tr></table>
	<table border="0" cellpadding="0" cellspacing="0" id="tablecenter_gongqiu_page">
<tr>
  <%if (count > size) {  %>
    <td colspan="10"><%=new tea.htmlx.FPNL(teasession._nLanguage,request.getRequestURI()+param.toString()+"&pos=",pos,count,size)%>    </td>
  <%}}finally{is.close(); } %>
  </tr>
  </table>
  </form>
</body>

