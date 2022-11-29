<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.entity.node.*" %><%@page import="tea.db.*" %><%@page import="tea.ui.*" %><%

TeaSession teasession=new TeaSession(request);

StringBuffer sql=new StringBuffer();
StringBuffer par=new StringBuffer();
sql.append(" FROM Node n,Hostel h,NodeLayer nl WHERE n.node=h.node AND n.node=nl.node AND n.type=48 AND n.community=").append(DbAdapter.cite(teasession._strCommunity)).append(" AND hidden=0");
par.append("?node=").append(teasession._nNode);
///
String subject=request.getParameter("subject");
if(subject!=null&&subject.length()>0)
{
  sql.append(" AND n.node IN ( SELECT node FROM NodeLayer WHERE subject LIKE ").append(DbAdapter.cite("%"+subject+"%")).append(")");
  par.append("&subject=").append(java.net.URLEncoder.encode(subject,"UTF-8"));
}
///
String city=request.getParameter("city");
if(city!=null&&city.length()>0)
{
  sql.append(" AND h.city=").append(DbAdapter.cite(city));
  par.append("&city=").append(java.net.URLEncoder.encode(city,"UTF-8"));
}
///
int starclass=0;
String tmp=request.getParameter("starclass");
if(tmp!=null)
{
  starclass=Integer.parseInt(tmp);
}
if(starclass>0)
{
  sql.append(" AND h.starclass=").append(starclass);
  par.append("&starclass=").append(starclass);
}
///
String o=request.getParameter("o");
if(o==null)o="n.node";
par.append("&o=").append(o);
boolean a=Boolean.parseBoolean(request.getParameter("a"));
par.append("&a=").append(a);

par.append("&pos=");

int pos=0,size=25;
tmp=request.getParameter("pos");
if(tmp!=null)
{
  pos=Integer.parseInt(tmp);
}

int count=0;
%>
<!--
=========酒店搜索===========
subject: 名称
city: 城市
starclass: 星级
o:排序
a:升/降序
-->
<%

//System.out.println("SELECT n.node"+sql.toString()+" ORDER BY "+o+" "+(a?"DESC":"ASC"));
DbAdapter db=new DbAdapter();
try
{
  count=db.getInt("SELECT COUNT(*)"+sql.toString());
  if(count>0)
  {
    db.executeQuery("SELECT n.node"+sql.toString()+" ORDER BY "+o+" "+(a?"DESC":"ASC"));
    for(int i=0;i<pos+size&&db.next();i++)
    {
      if(i>=pos)
      {
        int node=db.getInt(1);
        Node n=Node.find(node);
        Hostel h=Hostel.find(node,teasession._nLanguage);
        %>

        <LI><Span ID=HostelIDName><A HREF='/servlet/Hostel?node=<%=node%>' TARGET=_self><%=n.getSubject(teasession._nLanguage)%></A></Span>
          <Span ID=HostelIDgetStarClass><%=h.getStarClassToString()%></Span>
          ..........................................................
          <Span ID=HostelIDgetPrice><%=h.getPrice()%></Span></LI>
          <%
       }
    }
  }
}finally
{
  db.close();
}
%>
<LI>共搜索到<%=count%>记录.<%=new tea.htmlx.FPNL(teasession._nLanguage,par.toString(),pos,count)%></LI>
