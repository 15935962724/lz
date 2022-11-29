<%@page contentType="text/html; charset=UTF-8" %>
<%@page import="java.io.*" %>
<%@page import="java.util.*" %>
<%@page import="tea.ui.*" %>
<%@page import="tea.db.*" %>
<%@page import="tea.entity.admin.*" %>
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

int city=0;
String tmp=request.getParameter("city");
if(tmp!=null&&tmp.length()>0)
{
  city=Integer.parseInt(tmp);
}
int father=0;
tmp=request.getParameter("father");
if(tmp!=null&&tmp.length()>0)
{
  father=Integer.parseInt(tmp);
}
int newstype=-1;
tmp=request.getParameter("newstype");
if(tmp!=null&&tmp.length()>0)
{
  newstype=Integer.parseInt(tmp);
}
int pos=0,size=10;
tmp=request.getParameter("pos");
if(tmp!=null&&tmp.length()>0)
{
  pos=Integer.parseInt(tmp);
}

String q=request.getParameter("q");
boolean isQ=q!=null&&q.length()>0;

StringBuffer par=new StringBuffer();
par.append("?community=").append(teasession._strCommunity);
par.append("&node=").append(teasession._nNode);
par.append("&lucenelist=").append(lucenelist);




%>
<form name="formq" action="?">
<table>
  <tr>
    <td><input type="text" name="q" value="<%if(q!=null)out.print(q);%>"/><input type="submit" value="搜索"/></td>
  </tr>
  <tr>
    <td>
      <select name="city" onchange="formq.submit();">
      <option value="">---所有地区---</option>
      <%
      Enumeration ec=Card.find(" AND card<100",0,200);
      while(ec.hasMoreElements())
      {
        Card c=(Card)ec.nextElement();
        out.print("<option value=\""+c.getCard()+"\"");
        if(city==c.getCard())
        {
          out.print(" selected=\"\"");
        }
        out.print(">"+c.getAddress()+"</option>");
      }
      %>
    </select></td>
  </tr>
  <tr>
    <td><select name="father" onchange="formq.submit();">
    <option value="">---所有行业---</option>
      <%
      Enumeration ef=Node.findAllSons(2196711);
      while(ef.hasMoreElements())
      {
        int id=((Integer)ef.nextElement()).intValue();
        Node n=Node.find(id);
        out.print("<option value=\""+id+"\"");
        if(father==id)
        {
          out.print(" selected=\"\"");
        }
        out.print(">"+n.getSubject(teasession._nLanguage)+"</option>");
      }
      %>
     </select></td>
  </tr>
    <tr>
      <td  class="suoshy">
        <select name="newstype" onchange="formq.submit();">
        <option value="">---所有分类---</option>
        <option value="0" <%if(newstype==0)out.print(" selected=''");%>>供应信息</option>
        <option value="1" <%if(newstype==1)out.print(" selected=''");%>>求购信息</option>
        </select>
      </td>
  </tr>
<%

if(father==0&&city==0&&!isQ&&newstype==-1)
{
  out.print("");
}else
{
  BooleanQuery bq = new BooleanQuery();
  if(father!=0)
  {
    bq.add(new TermQuery(new Term("t255_path",String.valueOf(father))),BooleanClause.Occur.MUST);
    par.append("&father=").append(father);
  }
  if(city!=0)
  {
    bq.add(new TermQuery(new Term("t32_city",String.valueOf(city))),BooleanClause.Occur.MUST);
    par.append("&city=").append(city);
  }
  if(newstype!=-1)
  {
    bq.add(new TermQuery(new Term("t32_newstype",String.valueOf(newstype))),BooleanClause.Occur.MUST);
    par.append("&newstype=").append(newstype);
  }
  if(isQ)
  {
    bq.add(new QueryParser("t255_subject",new StandardAnalyzer()).parse(q),BooleanClause.Occur.MUST);
    par.append("&q=").append(java.net.URLEncoder.encode(q,"UTF-8"));
  }
  par.append("&pos=");
  IndexSearcher is=new IndexSearcher(fi.getAbsolutePath());
  try
  {
    Hits hits=is.search(bq);
    int count=hits.length();

    for(int i=pos;i<(pos+size)&&i<count;i++)
    {
      Document doc = hits.doc(i);
      int id=Integer.parseInt(doc.get("t255_node")); //((Integer)e.nextElement()).intValue();
      Node n=Node.find(id);
//      String syncid=n.getSyncId();
//      if(syncid==null)
//      {
//        continue;
//      }
      //String rid=syncid.substring(syncid.indexOf('.')+1);//在代理商上的节点号
      //String domain=OpenID.find(n.getCreator()._strV).getProxy();
      Supply s = Supply.find2(teasession._strCommunity,id);
      Company c=Company.find(s.getCompany());
      String subject=n.getSubject(teasession._nLanguage);
      String text=n.getText(teasession._nLanguage);
      subject=Lucene.htmlToText(subject);
      text=Lucene.htmlToText(text);
      if(text.length()>50)
      {
        text=text.substring(0,47)+"...";
      }
      if(isQ)
      {
        subject=subject.replaceAll(q,"<font color=\"RED\">"+q+"</font>");
        text=text.replaceAll(q,"<font color=\"RED\">"+q+"</font>");
      }
      %>
      <tr>
        <td class="gsmc"><a href="/servlet/Node?node=<%=id%>"><%=subject%></a></td>
      </tr>
      <tr>
        <td class="gsjj"><%=text%></td>
      </tr>
      <%
    }
    %>
<tr><td class="f_page"><%=new tea.htmlx.FPNL(teasession._nLanguage,par.toString(),pos,count,size)%></td></tr>

<%
}finally
{
  is.close();
}
}
%>
</table>
</form>

